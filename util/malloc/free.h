
struct __PTRLIST {
  struct __PTRLIST *Next;
  unsigned long size;
};

struct __PTRBLOCK {
  void * (*handle_block_free)(void *ptr,unsigned long alloc_size, unsigned long block_offset);
  struct __PTRBLOCK *blockptr_next_in_module;
  unsigned long blocksize;
  struct __PTRLIST *first_free;
};


void free(void *ptr) {
  struct __PTRHDR *p1;
  struct __PTRBLOCK *p2;
  if (p1=check_if_can_free(ptr,1)) {
      p2=p1->ptr_block;
      p2->handle_block_free(ptrbnd(p1,0x0), p1->alloc_size, p1->block_offset);
      return;
  } else {
      handle_bad_free();
  }
}

void __free_ptr(void *obj,void **ptr) {
  struct __PTRHDR *p1=(((unsigned long) obj)-32&0xffffffffffffff80;
  struct __PTRBLOCK *p2;
  struct __PTRHDR *p2=(((unsigned long) *ptr)-32&0xffffffffffffff80;
  unsigned long nref;
  if (p2->owner_cnt>1) {
      for(nref=0;nref<p2->owner_cnt;nref=nref+1) {
          if (p2->owners[nref]==obj) {
              p2->owners[nref]=0;
              goto endref;
          }
          __throw_bad_free();
      }
  } else {
      if (p2->owners==obj) {
          p2->owners[0]=0;
          goto endref;
      } else {
          __throw_bad_free();
      }
  }
  endref:
  if (p1=check_if_can_free(ptr,1)) {
      p2=p1->ptr_block;
      p2->handle_block_free(ptrbnd(p1,0x0), p1->alloc_size, p1->block_offset);
      return;
  } else {
      __throw_bad_free();
  }
}

void __move_ptr(void *from_parent_obj,void *from_ptr_obj, void 
**from_ptr,void *to_obj, void 
**to_ptr) {
    struct __PTRHDR *p1=((unsigned long) from_obj-32)&0xffffffffff80;
    struct __PTRHDR *p2=((unsigned long) to_obj-32)&0xffffffffff80;
    if (p1->owner_cnt==1 && p2->owner_cnt==1) {
        *to_ptr=*from_ptr;
        p2->owner=from_ptr_obj;
        p1->owner_cnt=0;
    } else if (p2->owner_cnt==1) {
        *to_ptr=*from_ptr;
        p2->owner=from_ptr_obj;
        __free_ptr(from_parent_obj,from_ptr);
    } else {
        *to_ptr=*from_ptr;
        __append_owner(to_obj,to_ptr,from_ptr_obj);
        __free_ptr(from_parent_obj,from_ptr);
    }
}

void __add_ref_ptr(void *from_parent_obj,void *from_ptr_obj, void 
**from_ptr,void *to_obj, void 
**to_ptr) {
    struct __PTRHDR *p1=((unsigned long) from_obj-32)&0xffffffffff80;
    struct __PTRHDR *p2=((unsigned long) to_obj-32)&0xffffffffff80;
    if (p1->owner_cnt==1 && p2->owner_cnt==1) {
        __add_owner_ptr(to_obj,to_ptr,from_ptr_obj);
        *to_ptr=*from_ptr;
    } else if (p2->owner_cnt==1) {
        __add_owner_ptr(to_obj,to_ptr,from_ptr_obj);
        *to_ptr=*from_ptr;
    } else {
        __add_owner_ptr(to_obj,to_ptr,from_ptr_obj);
        *to_ptr=*from_ptr;
    }
}

