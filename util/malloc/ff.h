class TObject;

template <TObject.*void field, class T> class GC_PTR {
  private:
  T *valp;
  public:
  T& operator *() {
      return *valp;
  }
  TObject *get_object() {
      TObject *obj=(TObject *) this;
      unsigned long f=(unsigned long) field;
      TObject.*void field2=(TObject.*void) -f;
      return (TObject *) obj->field2;
  }
  GC_PTR<field,T>(GC_PTR<field,T> &from) {
    __ptr_move(from.get_object,from,get_object,*this);
  }
  GC_PTR<field,T>(TObject *from) {
    if (from) __assign_owner_new(get_object,*this,from);
    else __free_ptr(get_object,*this);
  }
};
