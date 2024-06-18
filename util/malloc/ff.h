class TObject;

template <class T> class PTR_ONE_INST {
  public:
  T *valp_name_0xdeadbeef;
  T& operator *() {
      return *valp_name_0xdeadbeef;
  }
};


template <TObject.*void field, class T> class GC_PTR {
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
  GC_PTR<field,T>(GC_PTR<field,T> &from) {
    __ptr_move(from.get_object,from,get_object,*this);
  }
  GC_PTR<field,T>(TObject *from) {
    if (from) __assign_owner_new(get_object,*this,from);
    else __free_ptr(get_object,*this);
  }
  template <TObject.*void field_other> void operator+= 
(GC_PTR<field_other,T> &from) {
    __addref_ptr(from->get_object,from,get_object,*this);
  }
  PTR_ONE_INST<T> operator() {
    PTR_ONE_INST<T> res;
    res.valp_name_0xdeadbeef=valp;
    return res;
  }
  void add_unhinged_owner(PTR_ONE_INST<T> obj) {
    __addref_dangling(get_object,valp,obj);
  }
};

