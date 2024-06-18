class TObject;

template <class T> class PTR_ONE_INST {
  public:
  T *valp_name_0xdeadbeef;
  T& operator *() {
      return *valp_name_0xdeadbeef;
  }
};


template <class T> class GC_PTR {
  private:
  T *valp;
  public:
  T& operator *() {
      return *valp;
  }
  TObject *get_object() {
    unsigned long valp2=(unsigned long) valp;
    unsigned long mask=0xffffffff800;
    unsigned int exp=(valp2>>44)&0x1f;
    valp2&=mask<<exp;
    unsigned int low=(valp2>>52)&0xff0;
    valp2|=low<<exp;
    return valp2+32;
  }
  GC_PTR<T>(GC_PTR<T> &from) {
    
    __move_ptr(from.get_object(),from->get_object(),&valp,get_object(),&this);
  }
  GC_PTR<T>(TObject *from) {
    if (from) __add_ref_ptr(get_object(),&valp,from.valp);
    else __free_ptr(get_object(),&valp);
  }
  void operator+= 
  (GC_PTR<field_other,T> &from) {
    __add_ref_ptr(get_object,&valp,from.valp);
  }
  PTR_ONE_INST<T> operator() {
    PTR_ONE_INST<T> res;
    res.valp_name_0xdeadbeef=valp;
    return res;
  }
  void add_unhinged_owner(PTR_ONE_INST<T> obj) {
    __add_owner_ptr(get_object,valp,obj);
  }
};

