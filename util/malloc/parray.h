
class parray_hidden {
public:
  long size;
  void *element;
};

template <class T, struct __HEAP *h, bool alloc> class parray : parray_hidden {
  parray() {
      size=0;
      element=0;
  }
  parray (long _size) {
    size=_size;
    element=h.malloc(size*sizeof T);
    if (!element) size=0;
    if (alloc) __throw_bad_alloc();
  }
  ~parray() {
    if (element && alloc) free(element);
  }
};
