#include "fpu.h"


void req::opADDd (int iA,int iB, int iRes, int rmode) {
  unsigned expA=((A[iA]>>52)&0x7ff)|((Ax[iA]&2)<<10);
  unsigned expB=((B[iB]>>52)&0x7ff)|((Bx[iB]&2)<<10);

  unsigned long mantA=(A[iA]&0xfffffffffffff)|0x80000000000000;
  unsigned long mantB=(B[iB]&0xfffffffffffff)|0x80000000000000;

  unsigned sigA=A[iA]>>63;
  unsigned sigB=B[iB]>>63;

  exc=0;

  if (!expA && !expB) {
      res[iRes]=0;
      resx[iRes]=0;
      resh=0;
      return;
  }
  if (!expA) {
      res[iRes]=B[iB];
      resx[iRes]=Bx[iB];
      resh=0;
      return;
  }

  if (!expB) {
      res[iRes]=A[iA];
      resx[iRes]=Ax[iA];
      resh=0;
      return;
  }
  if (expA==0xffe && expB==0xFFe && sigA!=sigB) {
      res[iRes]=0x7ff0000000000000;
      resx[iRes]=0x2;
      resh=0;
      exc=EX_INVD;
      return;
  }
  if (expB==0xffe) {
      res[iRes]=B[iB]&0xfff0000000000000;
      resx[iRes]=Bx[iB];
      resh=0;
      exc=0;
      return;
  }

  if (expA==0xffe) {
      res[iRes]=A[iA]&0xfff0000000000000;
      resx[iRes]=Ax[iA];
      resh=0;
      exc=0;
      return;
  }

  if (expA==0xfff || expB==0xfff) {
      res[iRes]=0x7ff0000000000000;
      resx[iRes]=0x2;
      resh=0;
      exc=EX_INVD;
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
  if ((expA-expB)>54) {
      tail=expB!=0;
  } else {
      unsigned __int128 mant=mantA<<63<<1;
      if (sigA==sigB) mant+=mantB<<1<<(63-expA+expB);
      else mant-=mantB<<1<<(63-expA+expB);
      if (mant>>63>>1>>53) {
	  mant>>=1;
	  expA++;
      }
      lbit=(mant>>63>>1)&1;
      rbit=(mant>>63)&1;
      tail=((unsigned long) mant<<1)!=0;
  }
  mant=mant>>63>>1;
  if (rndfunc(last,rbit,tail,sigA,rmode)) {
      mant++;
      if (mant>>53) {
	  mant>>=1;
	  expA++;
      }
  }

  if (extA<=(0x400)) {
      exc|=EX_DENOR_STD;
  }
  if (extA<(0x400-51)) {
      extA=0;
      exc|=EX_DENOR_STD;
  }

  if (extA>=0xffe) {
      extA=0xffe;
      if (sigA) exc|=EX_OVER;
      if (!sigA) exc|=EX_UNDER;
  }
  if (extA>0xbfe) {
      extA=0xffe;
      if (sigA) exc|=EX_OVER_STD;
      if (!sigA) exc|=EX_UNDER_STD;
  }

  res[iRes]=(mant&0xfffffffffffff)|((expA<<52)&0x7ff)|(sigA<<63);
  resx[iRes]=(expA>>10)&2;
  resh=0;
}

void req::opSUBd (int iA,int iB, int iRes, int rmode) {
  unsigned expA=((A[iA]>>52)&0x7ff)|((Ax[iA]&2)<<10);
  unsigned expB=((B[iB]>>52)&0x7ff)|((Bx[iB]&2)<<10);

  unsigned long mantA=(A[iA]&0xfffffffffffff)|0x80000000000000;
  unsigned long mantB=(B[iB]&0xfffffffffffff)|0x80000000000000;

  unsigned sigA=A[iA]>>63;
  unsigned sigB=!(B[iB]>>63);

  exc=0;

  if (!expA && !expB) {
      res[iRes]=0;
      resx[iRes]=0;
      resh=0;
      return;
  }
  if (!expA) {
      res[iRes]=B[iB];
      resx[iRes]=Bx[iB];
      resh=0;
      return;
  }

  if (!expB) {
      res[iRes]=A[iA];
      resx[iRes]=Ax[iA];
      resh=0;
      return;
  }
  if (expA==0xffe && expB==0xFFe && sigA!=sigB) {
      res[iRes]=0x7ff0000000000000;
      resx[iRes]=0x2;
      resh=0;
      exc=EX_INVD;
      return;
  }
  if (expB==0xffe) {
      res[iRes]=B[iB]&0xfff0000000000000;
      resx[iRes]=Bx[iB];
      resh=0;
      return;
  }

  if (expA==0xffe) {
      res[iRes]=A[iA]&0xfff0000000000000;
      resx[iRes]=Ax[iA];
      resh=0;
      return;
  }

  if (expA==0xfff || expB==0xfff) {
      res[iRes]=0x7ff0000000000000;
      resx[iRes]=0x2;
      resh=0;
      exc=EX_INVD;
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
  if ((expA-expB)>54) {
      tail=expB!=0;
  } else {
      unsigned __int128 mant=mantA<<63<<1;
      if (sigA==sigB) mant+=mantB<<1<<(63-expA+expB);
      else mant-=mantB<<1<<(63-expA+expB);
      if (mant>>63>>1>>53) {
	  mant>>=1;
	  expA++;
      }
      lbit=(mant>>63>>1)&1;
      rbit=(mant>>63)&1;
      tail=((unsigned long) mant<<1)!=0;
  }
  mant=mant>>63>>1;
  if (rndfunc(last,rbit,tail,sigA,rmode)) {
      mant++;
      if (mant>>53) {
	  mant>>=1;
	  expA++;
      }
  }
  
  if (extA<=(0x400)) {
      exc|=EX_DENOR_STD;
  }
  if (extA<(0x400-51)) {
      extA=0;
      exc|=EX_DENOR_STD;
  }

  if (extA>=0xffe) {
      extA=0xffe;
      if (sigA) exc|=EX_OVER;
      if (!sigA) exc|=EX_UNDER;
  }
  if (extA>0xbfe) {
      extA=0xffe;
      if (sigA) exc|=EX_OVER_STD;
      if (!sigA) exc|=EX_UNDER_STD;
  }

  res[iRes]=(mant&0xfffffffffffff)|((expA<<52)&0x7ff)|(sigA<<63);
  resx[iRes]=(expA>>10)&2;
  resh=0;
}


void req::opMULd (int iA,int iB, int iRes, int rmode) {
  unsigned expA=((A[iA]>>52)&0x7ff)|((Ax[iA]&2)<<10);
  unsigned expB=((B[iB]>>52)&0x7ff)|((Bx[iB]&2)<<10);

  unsigned long mantA=(A[iA]&0xfffffffffffff)|0x80000000000000;
  unsigned long mantB=(B[iB]&0xfffffffffffff)|0x80000000000000;

  unsigned sigA=!(A[iA]>>63);
  unsigned sigB=B[iB]>>63;

  int exp=expA+expB-0x7ff;
  
  exc=0;

  unsigned __int128 prod=mantA*mantB;
  if ((prod>>53>>52)&1) {
      exp++;
  } else {
      prod<<=1;
  }

  bool last=(prod>>53)&1;
  bool rbit=(prod>>52)&1;
  bool tail=(prod&0xfffffffffffff)!=0;

  if (rndfunc(last,rbit,tail,sigA^sigB,rmode)) {
      prod++;
      if (prod>>53>>53) {
	  prod>>=1;
	  exp++;
      }
  }
  
  if (ext<=(0x400)) {
      exc|=EX_DENOR_STD;
  }
  if (ext<(0x400-51)) {
      ext=0;
      exc|=EX_DENOR_STD;
  }

  if (ext>=0xffe) {
      ext=0xffe;
      if (sigA) exc|=EX_OVER;
      if (!sigA) exc|=EX_UNDER;
  }
  if (ext>0xbfe) {
      ext=0xffe;
      if (sigA) exc|=EX_OVER_STD;
      if (!sigA) exc|=EX_UNDER_STD;
  }

  prod>>=53;

  res[iRes]=(prod&0xfffffffffffff)|((exp<<52)&0x7ff)|((sigA^sigB)<<63);
  resx[iRes]=(exp>>10)&2;
  resh=0;
}

void req::opPERMd (int iAB,int iB, int iRes, int swp,int cpy) {
  unsigned long AB=iAB ? B[iB] : A[iB];
  unsigned ABx=iAB ? Bx[iB] : Ax[iB];
  exc=0;
  if (swp) {
      AB=(AB>>32)|((AB&0xffffffff)<<32);
      ABx=(AB>>1)|((AB&1)<<1);
  }
  if (cpy) {
      AB=(AB>>32)|((AB&0xffffffff00000000));
      ABx=(AB&1)|((AB&1)<<1);
  }
  res[iRes]=AB;
  resx[iRes]=ABx;
  resh=0;
}


