#include <stdlib.h>
#include <string.h>
#include "type.h"
#include "hash.h"

#define IDKIND_DATA 1
#define IDKIND_TYPE 2
#define IDKIND_FUNC 3
#define IDKIND_TEMP 4
#define IDKIND_OPER 5
#define IDKIND_PHI  6
#define IDKIND_ARG  7

struct _ID {
    int kind;
    int type;
    long long int size;
    unsigned char *data;
    unsigned char align;    
    unsigned char linkage;
    unsigned char visibility;
    unsigned char isConst;
    int oper;
    int opA;
    int opB;
    int opC;
} *ID_GLOBAL, *ID_LOCAL, *ID_LNUM;

unsigned int ID_GLOBAL_SZ=0,ID_GLOBAL_CNT=0,ID_LOCAL_SZ=0,ID_LOCAL_CNT=0,
  ID_LNUM_SZ=0,ID_LNUM_CNT=0;

int ID_alloc_local() {
    if (ID_LOCAL_SZ==0) {
        ID_LOCAL=malloc(32768*sizeof (ID_LOCAL[0]));
	memset(ID_LOCAL,0,32768*sizeof (ID_LOCAL[0]));
	ID_LOCAL_SZ=32768;
//	goto alloc_fine;
    }
    if (ID_LOCAL_CNT>=ID_LOCAL_SZ) {
        ID_LOCAL=realloc(ID_LOCAL,2*ID_LOCAL_SZ*sizeof (ID_LOCAL[0]));
	memset(ID_LOCAL+ID_LOCAL_SZ,0,ID_LOCAL_SZ*sizeof (ID_LOCAL[0]));
	ID_LOCAL_SZ*=2;
    }
    return ID_LOCAL_CNT++;
}

int ID_alloc_global() {
    if (ID_GLOBAL_SZ==0) {
        ID_GLOBAL=malloc(1024*1024*sizeof (ID_GLOBAL[0]));
	memset(ID_GLOBAL,0,1024*1024*sizeof (ID_GLOBAL[0]));
	ID_GLOBAL_SZ=1024*1024;
//	goto alloc_fine;
    }
    if (ID_GLOBAL_CNT>=ID_GLOBAL_SZ) {
        ID_GLOBAL=realloc(ID_GLOBAL,2*ID_GLOBAL_SZ*sizeof (ID_GLOBAL[0]));
	memset(ID_GLOBAL+ID_GLOBAL_SZ,0,ID_GLOBAL_SZ*sizeof (ID_GLOBAL[0]));
	ID_GLOBAL_SZ*=2;
    }
    return ID_GLOBAL_CNT++;
}


int ID_alloc_lnum(int upto) {
    if (upto<ID_LNUM_CNT) return upto;
    if (ID_LOCAL_SZ==0) {
        ID_LNUM=malloc(32768*sizeof (ID_LNUM[0]));
	memset(ID_LNUM,0,32768*sizeof (ID_LNUM[0]));
	ID_LNUM_SZ=32768;
//	goto alloc_fine;
    }
    while (upto>=ID_LNUM_SZ) {
        ID_LNUM=realloc(ID_LNUM,2*ID_LNUM_SZ*sizeof( ID_LNUM[0]));
	memset(ID_LNUM+ID_LNUM_SZ,0,ID_LNUM_SZ*sizeof( ID_LNUM[0]));
	ID_LNUM_SZ*=2;
    }
    return upto;
}

void ID_cleanup(int id) {
    int n=id&0xfffffff;
    if ((id&IDMASK_ID) && !(id&IDMASK_GLOBAL)) {
        if (ID_LOCAL[n].kind==IDKIND_TYPE) type_unref(ID_LOCAL[n].type); 
    }
}

struct _ID *find_id_ptr(int id) {
    struct _ID *ids;
    switch(id&0xf0000000) {
    case IDMASK_ID|IDMASK_GLOBAL:
        ids=ID_GLOBAL+(id&0x0fffffff);
        break;
    case IDMASK_ID:
        ids=ID_LOCAL+(id&0x0fffffff);
    default:
        ids=ID_LNUM +id;
    }
    return ids;
}

void set_id_data(int id, char * data) {
    struct _ID *ids=find_id_ptr(id);
    ids->data=data;
}

void set_id_size(int id, long long int size) {
    struct _ID *ids=find_id_ptr(id);
    ids->size=size;
}

void set_id_type(int id, int type) {
    struct _ID *ids=find_id_ptr(id);
    ids->type=type;
}

void set_id_linkage(int id, int linkage) {
    struct _ID *ids=find_id_ptr(id);
    ids->linkage=linkage;
}

void set_id_visibility(int id, int vis) {
    struct _ID *ids=find_id_ptr(id);
    ids->visibility=vis;
}

void set_id_constant(int id) {
    struct _ID *ids=find_id_ptr(id);
    ids->isConst=1;
}

int get_id_kind(int id) {
    struct _ID *ids=find_id_ptr(id);
    return ids->kind;
}
