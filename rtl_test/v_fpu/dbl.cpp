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

  unsigned tail=0;
  unsigned rbit=0;
  unsigned lbit=0;
  if ((expA-expB)>54) {
      tail=expB!=0;
  } else {
      unsigned __int128 mant=mantA<<63<<1;
      mant+=mantB<<1<<(63-expA+expB);
      if (mant>>63>>1>>53) {
	  mant<<=1;
	  expA++;
      }
      lbit=(mant>>63>>1)&1;
      rbit=(mant>>63)&1;
      tail=((unsigned long) mant<<1)!=0;
  }
}

void req::opSUBd (int iA,int iB, int iRes, int rmode) {
}

void req::oprSUBd(int iA,int iB, int iRes, int rmode) {
}

void req::opMULd (int iA,int iB, int iRes, int rmode) {
}


