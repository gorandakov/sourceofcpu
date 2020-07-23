#include <stdlib.h>
#include <string.h>
#include "keyword.h"

#define TYPKIND_ARRAY 1
#define TYPKIND_FUNC 2
#define TYPKIND_STRUCT 3
#define TYPKIND_VEC 4
#define TYPKIND_VOID 5
#define TYPKIND_PTR 6
#define TYPEMASK_INT 0x20000000
#define TYPEMASK_FIXED 0x10000000

#define PTR_SIZE 8

struct _Type {
    int kind;
    int type;//sometimes its id
    int refcnt;
    int *data;
    int len;
    long long int sz_of_var;
    unsigned char align;    
    unsigned char ptrcnt;
} *TYP_GLOBAL;

unsigned int TYP_GLOBAL_SZ=0,TYP_GLOBAL_CNT=0,TYP_FREE=0;


int TYP_alloc_global() {
    int n;
    if (TYP_GLOBAL_SZ==0) {
        TYP_GLOBAL=malloc(65536*sizeof TYP_GLOBAL[0]);
	memset(TYP_GLOBAL,0,65536*sizeof TYP_GLOBAL[0]);
	TYP_GLOBAL_SZ=65536;
//	goto alloc_fine;
    }
    if (TYP_GLOBAL_CNT>=TYP_GLOBAL_SZ) {
        TYP_GLOBAL=realloc(TYP_GLOBAL,2*TYP_GLOBAL_SZ*sizeof TYP_GLOBAL[0]);
	memset(TYP_GLOBAL+TYP_GLOBAL_SZ,0,TYP_GLOBAL_SZ*sizeof TYP_GLOBAL[0]);
	TYP_GLOBAL_SZ*=2;
    }
    TYP_FREE=TYP_GLOBAL[n=TYP_FREE].type+TYP_FREE+1;
    memset(TYP_GLOBAL+n,0,sizeof TYP_GLOBAL[0]);
    return n;
}

int type_ref(int id) {
    if (id&0xf0000000) return 1;
    return ++TYP_GLOBAL[id].refcnt;
}

int type_unref(int id) {
    if (id&0xf0000000) return 1;
    if (TYP_GLOBAL[id].refcnt>1) return --TYP_GLOBAL[id].refcnt;
    switch (TYP_GLOBAL[id].kind) {
    case TYPKIND_ARRAY:
    case TYPKIND_PTR:
        type_unref(TYP_GLOBAL[id].type);
        break;
    }
    TYP_GLOBAL[id].type=TYP_FREE-id-1;
    TYP_GLOBAL[id].kind=0;
    TYP_FREE=id;
    TYP_GLOBAL_CNT--;
    return 0;
}

int type_new_array(long long len, int type) {
    int n=TYP_alloc_global();
    TYP_GLOBAL[n].kind=TYPKIND_ARRAY;
    TYP_GLOBAL[n].type=type;
    TYP_GLOBAL[n].len=len;
    TYP_GLOBAL[n].refcnt=1;
    return n;
}

int type_new_vector(int len, int type) {
    int n=TYP_alloc_global();
    TYP_GLOBAL[n].kind=TYPKIND_VEC;
    TYP_GLOBAL[n].type=type;
    TYP_GLOBAL[n].len=len;
    TYP_GLOBAL[n].refcnt=1;
    return n;
}


void type_inc_ptr(int id,int cnt) {
    int n=id&0xfffffff;
    if (n>TYP_GLOBAL_SZ) internal_error();
    TYP_GLOBAL[n].ptrcnt+=cnt;
}

int type_new_struct(int *types, int cnt, int packed) {
    int z,n=TYP_alloc_global();
    long long int sz=0;
    int align=1;
    if (cnt==0) internal_error();
    //TYP_GLOBAL[n].type=types[0];
    if (cnt) {
        TYP_GLOBAL[n].len=cnt;
        TYP_GLOBAL[n].data=malloc(cnt*4);
        memcpy(TYP_GLOBAL[n].data,types,cnt*4);
        for(z=0;z<cnt;z++) {
            int s=get_type_align(types[z]);
            sz=align64(sz,s);
            sz+=get_type_size(types[z]);
            align=(s>align) ? s : align;
        }
        sz=align64(sz,align);
        TYP_GLOBAL[n].sz_of_var=sz;
        TYP_GLOBAL[n].align=align;
    }
    return n;
}

int type_new_fun(int *types, int cnt) {
    int n=TYP_alloc_global();
    if (cnt==0) internal_error();
    TYP_GLOBAL[n].type=types[0];
    if (cnt-1) {
        TYP_GLOBAL[n].len=cnt-1;
        TYP_GLOBAL[n].data=malloc(cnt*4-4);
        memcpy(TYP_GLOBAL[n].data,types,cnt*4-4);
    }
    return n;
}

int adjust_int(int type) {
  int nbits=type&0xff;
  if (type&0xf0000000!=TYPEMASK_INT) return -1;
  if (nbits>128) return -1;
  if (nbits>64) nbits=128;
  else if (nbits>32) nbits=64;
  else if (nbits>16) nbits=32;
  else if (nbits>8) nbits=16;
  else nbits=8;
  return (type&0xffffff00 )|nbits;
}

long long int type_size(int type) {
    int n=type&0x0fffffff;
    switch (type&0xf0000000) {
    case TYPEMASK_INT:
        if (type&0xff00) return PTR_SIZE;
        return (adjust_int(type)&0xff)>>3;
        break;
    case TYPEMASK_FIXED:
        if (type&0xff00) return PTR_SIZE;
        switch (type&0xff) {
        case KW_TYP_FPE:
            return 10;
            break;
        case KW_TYP_FPS:
            return 4;
            break;
        case KW_TYP_FPD:
            return 8;
            break;
        }
        break;
    default:
        return TYP_GLOBAL[n].sz_of_var; 
        break;     
    }
}
