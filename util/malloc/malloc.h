
struct __HEAP {
  void * (*malloc)(struct __HEAP *h,long size);
  void * (*mrealloc)(struct __HEAP *h,long size_new);
  unsigned long module_handle;
  void *first_block;
  void *helper;
};


extern unsigned long __HEAP_TOP=0;
extern struct __HEAP __attribute(thread) *__CURRENT_HEAP[2048];
