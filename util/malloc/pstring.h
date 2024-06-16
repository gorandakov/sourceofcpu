
class pstring_hidden {
public:
  int size;
  int capacity;
  char element[];
};

template <class T=char, struct __HEAP *h> class pstring {
  char *valp;
  unsigned long peekchars;
public:
  pstring (long _size) {
    valp=h.malloc((_size+1)+8);
    if (!valp) __throw_out_of_memory();
    valp+=8;
  }
  ~pstring() {
    if (valp) free(valp-8);
  }
  void resize(long _size) {
    valp-=8;
    h.realloc(valp,_size+1+8);
  }
  void post_update(void) {
    peekchars=*(unsigned long *) valp;
    __asm("bswapq %1,%0\n",peekchars : "+r",peekchars : "r");
  }
};
