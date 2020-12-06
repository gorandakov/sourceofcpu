#include "fpu.h"


void req::opADDd (int iA,int iB, int iRes, int rmode) {
  unsigned expA=((A[iA]>>52)&0x7ff)|((Ax[iA]&2)<<10);
  unsigned expB=((B[iB]>>52)&0x7ff)|((Bx[iB]&2)<<10);
}

void req::opSUBd (int iA,int iB, int iRes, int rmode) {
}

void req::oprSUBd(int iA,int iB, int iRes, int rmode) {
}

void req::opMULd (int iA,int iB, int iRes, int rmode) {
}


