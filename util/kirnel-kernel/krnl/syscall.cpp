/*
     This program is free software: you can redistribute it and/or modify it under 
     the terms of the GNU General Public License as published by the Free Software Foundation, 
     version 2 of the License.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along with this program. 
    If not, see <https://www.gnu.org/licenses/>. 

*/
#include "continuation.hpp"

int syscall(void *retcap,cap_and_flags capfl,buf_and_arg strarg,buf_and_arg 
    buf_or_vma) {
    void *fsroot=k_verify_fsroot(4);
    void *tgt_thread=k_fsroot_find_cap_thread(fsroot,capfl.cap);
    int locked;
    if (!(capfl.flags&0x1)) { //request
        if (!(capfl.flags&0x10000)) produce_buffer_in_thread(tgt_thread,&stragr);
        if (!(capfl.flags&0x4)) produce_buffer_in_thread(tgt_thread,&stragr);
        else produce_buffer_sg_in_thread(tgt_thread,&strarg);
        if (locked=k_lock_thread_for_msg(tgt_thread)) k_attach_request(tgt_thread,retcap,capfl,strarg,buf_or_vma);
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
       if (locked=k_lock_thread_for_msg(tgt_thread)) {
           k_query_reply(tgt_thread,retcap0,capfl0,strarg0,buf_or_vma0);
           k_attach_request(tgt_thread,retcap,capfl,strarg,buf_or_vma);
       }
    }
    asm(
        "movq $pinvoke_clear_lower, %r11\n"
        "wrmsr %MSR_PINVOKE, %r11\n"
        "movq $pinvoke_nop,%r11\n"
        "wrmsr %MSR_PINVOKE,%r11\n"
        "wrmsr %MSR_PINVOKE,%r11\n"
        "kall clr_upper_registers\n"
        "wrmsr %MSR_PINVOKE,%r11\n"
        "wrmsr %MSR_PINVOKE,%r11\n"
        "kall clr_upper_registers\n"
         );
    if ((capfl.flags&0x1) && (capfl.flags&0x400)) {  //reply with switch of thread
        k_switch_cap_thread_optional(tgt_thread,capfl.cap);
    }
    if (locked) {
        if (!(capfl0.flags&0x80)) stall_thread();
        switch_to_thread(tgt_thread);
        deliver_message(tgt_thread);
    } else {
        void *disp=k_fsroot_get_delayed_dispatcher(fsroot,tgt_thread,capfl.flags);//if no resources for delayed dispatcher, do a context switch with register save
        k_attach_request(disp,retcap,capfl,strarg,buf_or_vma);        
        k_thread_yield(capfl.flags);
    }
    
}
