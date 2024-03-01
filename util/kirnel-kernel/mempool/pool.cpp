
class free_mem_pool {
public:
  int ccnumaX;
  int ccnumaY;
  void *NEXT_FREE;
  void *alloc_page();
  void *alloc_huge_page();
  void reclaim(void *addr, unsigned long size);
  void zero_pages(int count);
};

class mem_pool_next {
public:
  unsigned long size;
  void *NEXT_FREE;
  unsigned int is_zeroed;
};
