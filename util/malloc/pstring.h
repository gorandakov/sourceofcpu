
class pstring_hidden {
public:
  int size;
  int capacity;
  void *element;
};

template <class T=char, struct __HEAP *h> class pstring : pstring_hidden {
  pstring() {
      size=0;
      capacity=0;
      element=0;
  }
  pstring (long _size) {
    size=0;
    capacity=_size;
    element=h.malloc((size+1)*sizeof T);
    if (!element) capacity=0;
  }
  ~pstring() {
    if (element) free(element);
  }
};
