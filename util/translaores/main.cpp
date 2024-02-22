
struct transl_header {
    unsigned short target_and_class[6];
    unsigned char source[3]; //nibble per source
    unsigned char dummy;
};

struct transl_context {
    void *curpage;
    void *transl_region;
    unsigned long transl_region_size;
    volatile unsigned long curpos_orig;
    volatile unsigned long curpos_native;
    virtual int prealloc_page(unsigned long addr)=0; //returns 0 on success
    virtual int is_allocated_page(unsigned long addr)=0;
    virtual int is_opcode_fixed_jump(unsigned long opcode,unsigned long &jmpaddr)=0; //returs 1 on fixed jump
    virtual int is_opcode_flag_set(unsigned long opcode)=0; //returs 1 on fixed jump
    virtual int is_opcode_jmpflag(unsigned long opcode)=0; //returs 1 on fixed jump
    virtual int call_pinvoke(unsigned long foreign_val, unsigned long A, unsigned long B,unsigned long IP,int jmptype)=0;
    virtual void noop_pinvoke(void)=0;
    int poke_target(unsigned long address, int flags) {
        if (is_allocated_page(address)) {
            allocated:
            void *ptr=(void *) (((char *) transl_region) + (address/4096)*16384);
            struct transl_header *hdr;
            hdr=(struct transl_header *) ptr+((address&0xfff)>>4);
            int n;
            for(n=0;n<6;n=n+1) {
                if (hdr->target_and_class[n]) {
                    if (hdr->source[n/2]&(0xf<<(4*(n&1))))==(address&0xf)) {
                        return (flags==(hdr->target_and_class[n]>>14));
                    } else if (hdr->source[n/2]&(0xf<<(4*(n&1))))>(address&0xf)) {
                        hdr->insert(n,flags,address&0xf,0xfff);
                        return 1;
                    }
                } else {
                    hdr->insert(n,flags,address&0xf,0xfff);
                    return 1;
                }
            }
            hdr->insert(6,flags,address&0xf,0xfff);
            return 1;
        } else {
            if (prealloc_page(address/4096)) goto allocated;
            else return 0;
        }

    }
    unsigned long foreign(register unsigned long A, register unsigned long B) {
        register unsigned long ret;
        asm("foreign B,A,ret\n");
        return ret;
    }
    unsigned long size_from_foreign(unsigned long val) {
        return ((val>>48)&7)+((val>>51)&7)+~((val>>45)&7)+1;
    }
    int is_called(unsigned long addr,int fl) {

    }
    int create_callout(unsigned long addr, int from, int to) {

    }
    void poke_through(bool starts_with_add, bool starts_with_fpu_cmp);
    void transl_through(int jmptype, int start_off, int has_next);
};
void transl_context::poke_through(int jmptype, int start_off) {
    unsigned long long address=start_off;
    unsigned long long target_address;
    unsigned long A,B;
    int jmptype,fl2;
    bool flag=true,was_addition=starts_with_add,was_fpu_cmp=starts_with_fpu_cmp;
    do {
        A=((unsigned long *) (((char *) curpage)+address));
        B=((unsigned long *) (((char *) curpage)+address))+1;
        unsigned long fr=foreign(A,B);
        unsigned long sz=size_from_foreign(fr);
        if (is_opcode_fixed_jump(fr,target_address)) {
            poke_target(address,jmptype);
        }
        if (is_called(address,fl2) && fl2!=jmptype) {
            create_callout(address,fl2,jmptype);
        }
        if (is_opcode_flag_set(fr)) jmptype=is_opcode_jmpflag(fr);
        address+=sz;
        if (address>4095) flag=false;
    } while (flag);

}

void transl_context::transl_through(int jmptype, int start_off, int has_next) {
    unsigned long long address=start_off;
    unsigned long long target_address;
    unsigned long A,B;
    bool flag=true,was_addition=starts_with_add,was_fpu_cmp=starts_with_fpu_cmp;
    has_next=has_next ? 4223 :4095;
    do {
        A=((unsigned long *) (((char *) curpage)+address));
        B=((unsigned long *) (((char *) curpage)+address))+1;
        unsigned long fr=foreign(A,B);
        unsigned long sz=size_from_foreign(fr);
        if (is_opcode_flag_set(fr)) jmptype=is_opcode_jmpflag(fr);
        call_pinvoke(fr,A,B,address,jmptype);
        address+=sz;
        if (is_opcode_reg_gen_cmp(fr)) {
            A=((unsigned long *) (((char *) curpage)+address));
            B=((unsigned long *) (((char *) curpage)+address))+1;
            unsigned long fr=foreign(A,B);
            unsigned long sz=size_from_foreign(fr);
            if (is_opcode_fixed_jump_byte(fr)) address+=sz;
        }
        if (address>has_next) flag=false;//some overhang to next page!
    } while (flag);

}
