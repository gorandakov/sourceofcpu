#define PARAM_H 0
#define PARAM_I 2


struct req {
  unsigned long A[2];
  unsigned long B[2];
  unsigned short Ah;
  unsigned short Bh;
  char Ax[2];
  char Bx[2];
  int op;
  int en;
  unsigned long res[2];
  unsigned short resh;
  char resx[2];
  unsigned short exceptions;
  void opADDd (int iA,int iB, int iRes, int rmode);
  void opSUBd (int iA,int iB, int iRes, int rmode);
  void oprSUBd(int iA,int iB, int iRes, int rmode);
  void opMULd (int iA,int iB, int iRes, int rmode);
  void opADDs(int cnt, int rmode);
  void opSUBs(int cnt, int rmode);
  void opMULs(int cnt, int rmode);
  void opADDx(int rmode);
  void opSUBx(int rmode);
  void opMULx(int rmode);
};
/*
 * double: extra exponent bit Ax[iA]>>1 (comes before last)
 * single: lower half extra exponent Ax[iA]&1,upper half Ax[iA]>>1
 * extended: extra exponent same as double, Ah=sign and exponent
 * "native" denormals are treated as zero
 * */
int rndfunc(bool last,bool rbit,bool tail,bool sgn, int rmod);

