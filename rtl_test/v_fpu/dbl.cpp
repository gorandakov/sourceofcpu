#include "fpu.h"


void req::opADDd (int iA,int iB, int iRes, int rmode) {
  unsigned expA=((A[iA]>>52)&0x7ff)|((Ax[iA]&2)<<10);
  unsigned expB=((B[iB]>>52)&0x7ff)|((Bx[iB]&2)<<10);

  unsigned long mantA=(A[iA]&0xfffffffffffff)|0x80000000000000;
  unsigned long mantB=(B[iB]&0xfffffffffffff)|0x80000000000000;

  unsigned sigA=A[iA]>>63;
  unsigned sigB=B[iB]>>63;

  if (expB>expA) {
      unsigned long swp;
      swp=expA;
      expA=expB;
      expB=swp;
      swp=mantA;
      mantA=mantB;
      mantB=swp;
      swp=sigA;
      sigA=sigB;
      sigB=swp;
  }
}

void req::opSUBd (int iA,int iB, int iRes, int rmode) {
}

void req::oprSUBd(int iA,int iB, int iRes, int rmode) {
}

void req::opMULd (int iA,int iB, int iRes, int rmode) {
}


