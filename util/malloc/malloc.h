
struct __HEAP {
  void * (*malloc)(struct __HEAP *h,long size);
  unsigned long module_handle;
  void *first_block;
  void *helper; //internal to implementation
};
