
struct __PTRBLOCK {
  void * (*handle_block_free)(void *ptr,unsigned long alloc_size, unsigned long trailing_size);
};


void free(void *ptr) {
  struct __PTRHDR *p1;
  struct __PTRBLOCK *p2;
  if (p1=check_if_can_free(ptr,1)) {
      p2=p1->ptr_block;
      p2->handle_block_free(p2, p1->alloc_size, p1->trailing_size);
      return;
  } else {
      handle_bad_free();
  }
}
