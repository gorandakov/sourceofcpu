typedef struct _branch {
  int ptroff:24;
  unsigned int used:1;
  unsigned int offset:7;
} branchentry;


struct branches {
  branchentry br[6];
  struct branches *ptrnext;
};

typedef unsigned int ptrbtbl[BACK_SIZE+FWD_SIZE+1];


typedef struct branches externtbl;
typedef struct branches referenctbl;


ptrbtbl branch_table;

int append_branch(tr_context *tr,int offset,branchentry entry)
{
  unsigned long ent=offset+BACK_SIZE;
  unsigned long ent2=offset+BACK_SIZE;
  unsigned long ent3=0;
  struct _branch *br;
  if (offset<-tr->BACK_SIZE || offset>tr->FWD_SIZE) {
    return 0;
  } 
  ent2=(ent=tr->branch_table[ent]->ptrnext) ? ent : ent2;
  while(ent=tr->branch_table[ent]->ptrnext) {ent2=ent};
  br=branch_table+ent2;
  ent3=br->br[0].used ? 1 : ent3;
  ent3=br->br[1].used ? 2 : ent3;
  ent3=br->br[2].used ? 3 : ent3;
  ent3=br->br[3].used ? 4 : ent3;
  ent3=br->br[4].used ? 5 : ent3;
  ent3=br->br[5].used ? 6 : ent3;
  if (ent3==6) {
     ent3=0;
     br->ptrnext=alloc_brheap(tr,32);
     if (br->ptrnext<0) return -1;
     br=br->ptrnext;
  }
  br->br[ent3]=entry;
  return 1;
} 
