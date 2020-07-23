typedef struct _branch {
  int ptroff:24;
  unsigned int used:1;
  unsigned int offset:7;
} branchentry;


struct branches {
  branchentry br[7];
  unsigned int ptrnext;
};

typedef unsigned int ptrbtbl[BACK_SIZE/128+FWD_SIZE/128];

#define BRPTR(base,off) ((struct branches *)((char *) base+off))

typedef struct branches externtbl;
typedef struct branches referenctbl;
