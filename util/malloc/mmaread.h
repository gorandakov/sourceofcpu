
struct __PTRHDR {
  void *ptr_block;
  unsigned long alloc_size;
  unsigned int permissions_and_cookie;
  unsigned int owner_array_size; // if one, pointer is owner pointer not 
array pointer
  void **owner_array;
};

const long __PTRHDR_CAN_FREE=0x1;
const long __PTRHDR_IS_MEMORY_MAP=0x2;
const long __PTRHDR_CAN_STORE_IN_HEAP=0x4;
const long __PTRHDR_CAN_STORE_IN_OBJECT=0x8;
const long __PTRHDR_6_CHUNKS 0x400;

const static char *__UNBOUND_PTR;


inline void * check_if_can_free(void *ptr, int mark_as_unfree=0) {
  unsigned long addr=ptr;
  struct __PTRHDR *p1;
  p1=(struct __PTRHDR *) ((addr-32)&0xffffffffffffff80);
  if (!(p1->permissions_and_cookie&__PTRHDR_CAN_FREE)) {
      return 0;
  }
  if (mark_as_unfree) {
      if ((p1->permissions_and_cookie&__PTRHDR_3_CHUNKS) {
          unsigned long off2=(addr>>5)&0x3;
          p1->permissions_and_cookie&=~(16ul<<off2);
      } else {
          p1->permissions_and_cookie&=~__PTRHDR_CAN_FREE;
      }
  }
  return p1;
}
