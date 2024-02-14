
typedef struct kmembuf_entry {
  int offset;
  int size;
  void *data;
};

typedef struct _kmembuf {
  long int count;
  long int min_est_size;
  struct kmembuf_entry item[];  
  _kmembuf() {
  }
} *pkmembuf;

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
};


