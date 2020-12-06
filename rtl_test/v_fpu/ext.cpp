#include "fpu.h"


void req::opADDx (int rmode) {
  unsigned expA=(Ah&0x7fff)|((Ax[0]&2)<<14);
  unsigned expB=(Bh&0x7fff)|((Bx[0]&2)<<14);

  unsigned long mantA=A[0]|0x8000000000000000;
  unsigned long mantB=B[0]|0x8000000000000000;

  unsigned sigA=Ah>>15;
  unsigned sigB=Bh>>15;

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
  if ((expA-expB)>64) {
      tail=expB!=0;
  } else {
      unsigned __int128 mant=mantA<<63<<1;
      mant+=mantB<<1<<(63-expA+expB);
      if (!(mant>>63>>1>>63)) {
	  mant>>=1;
	  mant|=0x8000000000000000;
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


