
struct cap_and_flags {
  int cap;
  int flags;
  const int flag_async_reply=0x80;
  const int flag_switch_thread=0x100; //switch to next thread in server thread pool
  const int fire_and_forget=0x200;
  const int can_switch_thread_on_reply=0x400;
  const int flag_reply=0x1;
  const int buffer_is_vma=0x2;
  const int buffer_is_scatther_gather=0x4;
  const int reply_delete_cap1_from_own_space=0x8;
  const int reply_delete_cap2_from_own_space=0x10;
  const int reply_delete_cap3_from_own_space=0x20;
  const int reply_delete_cap4_from_own_space=0x40;
  const int reply_delete_caps_other_from_own_space=0x80;
  const int reply_create_cap1 0x800
  const int reply_create_cap2 0x1000
  const int reply_create_cap3 0x2000
  const int reply_create_cap4 0x4000
  const int reply_create_cap5 0x8000
  const int string_buffer_pointer_as_pair_of_ints 0x10000
  const int capcnt_in_buffer_shift=20;
  const int cap_stdin=0;
  const int cap_stdout=1;
  const int cap_stderr=2;
  const int cap_gfx=3;
  const int cap_fsroot=4;
};

struct buf_and_arg {
  int arg;
  int buf_size;
  void *buf_ptr;
};

class continuation {

  private:
  unsigned long reg_save[5];
  protected:
  void * label;
  void * env; //contains handle table and other server status items
  public:
  continuation();
  int syscall(void *ret, cap_and_flags capfl,buf_and_arg strarg,buf_and_arg 
    buf_or_vma) {
    label=ret;
    return do_syscall(this, capfl, strarg, buf_or_vma);
  }
  do_syscall(void *ret, cap_and_flags capfl,buf_and_arg strarg,buf_and_arg 
    buf_or_vma) {
    int ret;
    asm("iret %MSR_SYSCALL\n"
        "retq\n");
    return ret;
  }
  virtual int exec(int flags,buf_and_arg strarg,buf_and_arg 
    buf_or_vma)=0;
  virtual int exec_new_request(cap_and_flags capfl,buf_and_arg strarg,buf_and_arg 
    buf_or_vma)=0;
};

#define __INIT_CONTINUATION_EXEC if (label) goto *label;
//paste the macro at the beggining of exec()
