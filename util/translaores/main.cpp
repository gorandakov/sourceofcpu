
struct transl_header {
    unsigned short target[6];//<16k is invalid/unused; 
    unsigned char source[3]; //nibble per source
    unsigned char is_addition; //bit per jump target/source
};

typedef transl_header transl_header_section[1024];

struct transl_context {
    void *curpage;
    void *transl_region;
    unsigned long transl_region_size;
    volatile unsigned long curpos_orig;
    volatile unsigned long curpos_native;
    void *pinvoke_table;//8192 entries
    const int shift_of_0x66_extra=0x22;
    void *null_pinvoke;//1 entry for no-op pinvoke
    virtual int prealloc_page(unsigned long addr)=0; //returns 0 on success
    virtual int is_allocated_page(unsigned long addr)=0;
    virtual int is_opcode_fixed_jump(unsigned long opcode,unsigned long &jmpaddr)=0; //returs 1 on fixed jump
    virtual int is_opcode_flag_set(unsigned long opcode)=0; //returs 1 on fixed jump
    virtual int is_opcode_jmpflag(unsigned long opcode)=0; //returs 1 on fixed jump
    int call_pinvoke(unsigned long foreign_val, unsigned long A, unsigned long B,unsigned long IP,int jmptype) {
        asm("movq foreign_val, %r17\n"
            "movq A, %r18\n"
            "movq B, %r19\n"
            "movq IP, %r20\n"
            "movl jmptype,%r21\n"
            "andl $0xfff,%r17,%r22\n"
            "shrq $shift_of_0x66_extra-12,%r17,%r23\n"
            "orq %r23, %r22\n"
            "movq pinvoke_table,%r23\n"
            "movq (%r23,%r22,8),%r23\n"
            "wrmsr %MSR_PINVOKE, %r23\n");
        return 0;            
    }
    int noop_pinvoke(void) {
        asm("movq null_pinvoke, %r23\n"
            "wrmsr %MSR_PINVOKE, %r23\n");
        return 1;
    }
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
                        if (flags==(hdr->target_and_class[n]>>14)) return 1;
                        else if (n!=5) {
                            hdr->insert(n+1,flags,address&0xf,0xfff);
                            return 1;
                        } else return 0;
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
            else return -1;
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
    unsigned long long bgnloop=0,bgnloop2=-1;
    bool flag=true,was_addition=starts_with_add,was_fpu_cmp=starts_with_fpu_cmp;
    do {
        A=((unsigned long *) (((char *) curpage)+address));
        B=((unsigned long *) (((char *) curpage)+address))+1;
        unsigned long fr=foreign(A,B);
        unsigned long sz=size_from_foreign(fr);
        if (is_opcode_fixed_jump(fr,target_address,jmptype)) {
            poke_target(target_address,jmptype);
        }
        if (is_called(address,fl2) && fl2!=jmptype) {
            create_callout(address,fl2,jmptype);
        }
        if (is_opcode_forward(fr,jmpoff,jmpcond) && jmpoff<16384) {
            if (if_else_target) {
               if (jmpcond==16 && (if_else_target==address) || (if_else_target==allign16(address)) || (if_else_target==allign32(address))  ) {//uc 
                   if (checknop(if_else_target)) {
                       convert_to_if_else:
                       if_else_target=0;
                   }
               } else {
                   if (bgnloop2==bgnloop) {
                       poke_loop(bgnloop);
                   }
                   bgnloop=address+sz;
                   bgnloop2=-1;
               }
            } else {
                if_else_target=jmpoff;
            }
        } else if (is_opcode_backward(fr)) {
            if (jmpoff>=bgnloop && bgnloop>=0) {
                bgnloop=jmpoff;
                bgnloop2=jmpoff;
            }
            if (address>(24*1024)) {
                flag=false;
                if (bgnloop2=bgnloop) poke_loop(bgnloop);
                insert_jump_to_next_page(address+sz,address);
            }
        } else if (if_else_target==address) {
            if_else_target=0;
        }
        if (is_opcode_flag_set(fr)) jmptype=is_opcode_jmpflag(fr);
        address+=sz;
        if (address>32767) flag=false; //up to entire next page can be fetched
    } while (flag);
    insert_jump_to_next_page(address+sz,address);
   

}

void transl_context::transl_through(int jmptype, int start_off, int has_next) {
    unsigned long long address=start_off;
    unsigned long long target_address;
    unsigned long A,B;
    transl_regmap regmap;
    bool flag=true,was_addition=starts_with_add,was_fpu_cmp=starts_with_fpu_cmp;
    has_next=has_next ? 4223 :4095;
    do {
        A=((unsigned long *) (((char *) curpage)+address));
        B=((unsigned long *) (((char *) curpage)+address))+1;
        unsigned long fr=foreign(A,B);
        unsigned long sz=size_from_foreign(fr);
        if (is_opcode_flag_set(fr)) jmptype=is_opcode_jmpflag(fr);
        call_pinvoke(fr,A,B,address,jmptype);
        if (is_loop(address)) {
            lastloop=address;
            regmap.clear();
        }
        regmap.detect_used(fr);
        regmap.mark_target(fr);
        if (end_loop(address)) {
            if (regmap.has_multi_chain()) {
                clear_loop(lastloop);
                clear_endloop(address);
            }
        }
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
