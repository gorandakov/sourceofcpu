
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
    virtual int is_opcode_fixed_jump(unsigned int opcode,unsigned long &jmpaddr)=0; //returs 1 on fixed jump
    virtual int call_pinvoke(unsigned long foreign_val, unsigned long A, unsigned long B)=0;
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
};
