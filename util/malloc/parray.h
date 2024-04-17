
class parray_hidden {
public:
  long size;
  void *element;
};

template <class T, struct __HEAP *h> class parray : parray_hidden {
  parray() {
      size=0;
      element=0;
  }
  parray (long _size) {
    size=_size;
    element=h.malloc(size*sizeof T);
    if (!element) size=0;
  }
  ~parray() {
    if (element) free(element);
  }
};
