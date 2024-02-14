
typedef struct kmembuf_entry {
  int offset;
  int size;
  void *data;
};

template struct _kmembuf {
  long int count;
  long int min_est_size;
};

template<int cnt> struct kmembuf : _kmembuf {
  struct kmembuf_entry item[cnt];  
  _kmembuf() {
      count=cnt;
  }
};

 

template<type T> class sys_ptr {
  void *val;
  public:
  T* operator () {
      return (T*) val;
  }
  void operator =(T* ptr) {
      val=ptr;
  }
  sys_ptr<T>() {
  }
  set_range(int k) {
    __asm("movq val,%r8\n"
          "movq k, %r9\n"
          "ptrbnd %r9,%r8,%r8\n"
          "movq %r8,val\n");
  }
};

template<type T> class sys_ptr_kernel {
  void *val;
  public:
  T* operator () {
      return (T*) val;
  }
  void operator =(T* ptr) {
      val=ptr;
  }
  sys_ptr<T>() {
  }
};


typedef sys_ptr_kernel<_kmembuf> pkmembuf;

