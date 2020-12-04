#define PARAM_H 0
#define PARAM_I 2


unsigned short OPS_ADD[]={
  fop_addDH,
  fop_addDL,
  fop_addDP,
  fop_subDH,
  fop_subDL,
  fop_subDP,
  fop_addS,
  fop_addSP,
  fop_subS,
  fop_subSP,
  fop_permDS,
  fop_cmpDH,
  fop_cmpDL,
  fop_cmpS,
  fop_pcmplt,
  fop_pcmpge,
  fop_pcmpeq,
  fop_pcmpne,
  fop_pcmplt|1024,//single
  fop_pcmpge|1024,
  fop_pcmpeq|1024,
  fop_pcmpne|1024,
  fop_logic,
  fop_logic+1,
  fop_logic+2,
  fop_logic+3
  };

unsigned short OPS_MUL[]={
  fop_mulDH,
  fop_mulDL,
  fop_mulDP,
  fop_divDH,
  fop_divDL,
  fop_sqrtDH,
  fop_sqrtDL,
  fop_mulS,
  fop_mulSP,
  fop_divS,
  fop_sqrtS,
  fop_permDS,
  fop_rndED,
  fop_rndDS,
  fop_rndDSP,
  fop_cvtD,
  fop_cvtS,
  fop_cvt32D,
  fop_cvt32S

  };


unsigned short OPS_MUL_no2[]={
  fop_mulDH,
  fop_mulDL,
  fop_mulDP,
  fop_mulS,
  fop_mulSP,
  fop_permDS,
  fop_rndED,
  fop_rndDS,
  fop_rndDSP
  };


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

