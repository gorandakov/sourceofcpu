#include "fpu.h"


void req::opADDx (int rmode) {
  unsigned expA=(Ah&0x7fff)|((Ax[0]&2)<<14);
  unsigned expB=(Bh&0x7fff)|((Bx[0]&2)<<14);

  unsigned long mantA=A[0]|0x8000000000000000;
  unsigned long mantB=B[0]|0x8000000000000000;

  unsigned sigA=Ah>>15;
  unsigned sigB=Bh>>15;

  if (!expA && !expB) {
      res[iRes]=0;
      resx[iRes]=0;
      resh=0;
      return;
  }
  if (!expA) {
      res[iRes]=B[iB];
      resx[iRes]=Bx[iB];
      resh=Bh;
      return;
  }

  if (!expB) {
      res[iRes]=A[iA];
      resx[iRes]=Ax[iA];
      resh=Ah;
      return;
  }
  if (expA==0xfffe && expB==0xFFFe && sigA!=sigB) {
      res[iRes]=0x0;
      resx[iRes]=0x2;
      resh=0x7fff;
      return;
  }
  if (expB==0xfffe) {
      res[iRes]=0;
      resx[iRes]=Bx[0];
      resh=Bh;
      return;
  }

  if (expA==0xfffe) {
      res[iRes]=0;
      resx[iRes]=Ax[0];
      resh=Ah;
      return;
  }

  if (expA==0xffff || expB==0xffff) {
      res[iRes]=0;
      resx[iRes]=0x2;
      resh=0x7fff;
      return;
  }

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
      if (sigA==sigB) mant+=mantB<<1<<(63-expA+expB);
      else mant-=mantB<<1<<(63-expA+expB);
      if (!(mant>>63>>1>>63) && sigA==sigB) {
	  mant>>=1;
	  mant|=0x8000000000000000;
	  expA++;
      }
      lbit=(mant>>63>>1)&1;
      rbit=(mant>>63)&1;
      tail=((unsigned long) mant<<1)!=0;
  }
  mant=mant>>63>>1;
  if (rndfunc(last,rbit,tail,sigA,rmode)) {
      mant++;
      if (!(mant>>63)) {
	  mant>>=1;
	  mant|=0x8000000000000000;
	  expA++;
      }
  }
  res[0]=mant;
  resh=(expA&0x7fff)|(sigA<<15);
  resx[0]=(expA&0x8000)>>14;
}

void req::opSUBx (int rmode) {
  unsigned expA=(Ah&0x7fff)|((Ax[0]&2)<<14);
  unsigned expB=(Bh&0x7fff)|((Bx[0]&2)<<14);

  unsigned long mantA=A[0]|0x8000000000000000;
  unsigned long mantB=B[0]|0x8000000000000000;

  unsigned sigA=Ah>>15;
  unsigned sigB=!(Bh>>15);

  if (!expA && !expB) {
      res[iRes]=0;
      resx[iRes]=0;
      resh=0;
      return;
  }
  if (!expA) {
      res[iRes]=B[iB];
      resx[iRes]=Bx[iB];
      resh=Bh;
      return;
  }

  if (!expB) {
      res[iRes]=A[iA];
      resx[iRes]=Ax[iA];
      resh=Ah;
      return;
  }
  if (expA==0xfffe && expB==0xFFFe && sigA!=sigB) {
      res[iRes]=0x0;
      resx[iRes]=0x2;
      resh=0x7fff;
      return;
  }
  if (expB==0xfffe) {
      res[iRes]=0;
      resx[iRes]=Bx[0];
      resh=Bh;
      return;
  }

  if (expA==0xfffe) {
      res[iRes]=0;
      resx[iRes]=Ax[0];
      resh=Ah;
      return;
  }

  if (expA==0xffff || expB==0xffff) {
      res[iRes]=0;
      resx[iRes]=0x2;
      resh=0x7fff;
      return;
  }

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
      if (sigA==sigB) mant+=mantB<<1<<(63-expA+expB);
      else mant-=mantB<<1<<(63-expA+expB);
      if (!(mant>>63>>1>>63) && sigA==sigB) {
	  mant>>=1;
	  mant|=0x8000000000000000;
	  expA++;
      }
      lbit=(mant>>63>>1)&1;
      rbit=(mant>>63)&1;
      tail=((unsigned long) mant<<1)!=0;
  }
  mant=mant>>63>>1;
  if (rndfunc(last,rbit,tail,sigA,rmode)) {
      mant++;
      if (!(mant>>63)) {
	  mant>>=1;
	  mant|=0x8000000000000000;
	  expA++;
      }
  }
  res[0]=mant;
  resh=(expA&0x7fff)|(sigA<<15);
  resx[0]=(expA&0x8000)>>14;
}

void req::opMULx (int rmode) {
}


