
#include "continuation.hpp"

int syscall(void *retcap,cap_and_flags capfl,buf_and_arg strarg,buf_and_arg 
    buf_or_vma) {
    void *fsroot=k_verify_fsroot(4);
    void *tgt_thread=k_fsroot_find_cap_thread(fsroot,capfl.cap);
    if (!(capfl.flags&0x1)) { //request
        if (!(capfl.flags&0x10000)) produce_buffer_in_thread(tgt_thread,&stragr);
        if (!(capfl.flags&0x4)) produce_buffer_in_thread(tgt_thread,&stragr);
        else produce_buffer_sg_in_thread(tgt_thread,&strarg);
    } else { //reply
       unsigned long cap;
       int n;
       for (n=0;n<5;n=n+1) if (capfl.flags&(0x800<<n)) {
           cap=k_read_ulong(strarg,8*n);
           int capu=k_create_cap(tgt_thread,cap);
           k_write_uint(buf_and_arg,capu,4*n,0);//not scatter-gather
       }
       for (n=0;n<5;n=n+1) if (capfl.flags&(0x8<<n)) {
           cap=k_read_uint(buf_and_arg,4*n);
           k_delete_own_cap_no_fail(cap);
       }
    }
    asm("movq $pinvoke_nop,%r0\n"
        "wrmsr %MSR_PINVOKE,%r0\n"
        "wrmsr %MSR_PINVOKE,%r0\n"
        "wrmsr %MSR_PINVOKE,%r0\n"
        "wrmsr %MSR_PINVOKE,%r0\n");
    

}
