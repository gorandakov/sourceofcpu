struct HEP_context;

typedef int (*ihandler)(HEP_context *);

ihandler INSTBL[5*256];

struct HEP_context {
    unsigned long long genR[32];
    char flags;
    char avx;
    unsigned long long IP;
    unsigned long long VIP;
    unsigned short stops; 
    int stopn;
    unsigned char * mem;
    int next(void);
    void IP_transl(void);
};

int HEP_context::next(void) {
  int stp=(stops&0x7)==7 ? (stops&0x8 ? 4 : 3) : 
     ((stops&0x3)==3 ? 2 : stops&0x1); 
  int stp2=stopn;
  int brk;
  stopn=stp;
  brk=(*INSTBL[stp2*256+mem[IP]])(this);
  IP+=stp2;
  VIP+=stp2;
  stops<=stp2;
  if (!stops) {
      VIP=(VIP+31) &0xffffffffffffffe0ll;
      IP_transl();
      stops=(mem[IP+30]+256*mem[IP+31])&0x7fff;
      avx=((mem[IP+30]+256*mem[IP+31])&0x8000)!=0;
  }
  return brk;
}


#define DEF_ALU_16(vname,instr) \
int INSTR16_##vname(struct HEP_context *con) { \
  int c1=con->mem[con->IP];\
  int c2=con->mem[con->IP+1];\
  long long int rT=(c2&0xf)|((c1&0x40)>>2);\
  long long int rB=((c2&0xf0)>>4)|((c1&0x80)>>3);\
  asm(instr " %3, %0" \
      "\n\t lahf" \
      "\n\t movb %%ah, %1" :\
     "=r" (con->genR[rT]), "=m" (con->flags) :\
     "0" (con->genR[rT]), "r" (con->genR[rB]) :\
     "cc","ah");\
  return 0;\
}

#define DEF_ALU_16l(vname,instr) \
int INSTR16_##vname(struct HEP_context *con) { \
  int c1=con->mem[con->IP];\
  int c2=con->mem[con->IP+1];\
  long long int rT=(c2&0xf)|((c1&0x40)>>2);\
  long long int rB=((c2&0xf0)>>4)|((c1&0x80)>>3);\
  asm(instr " %k3, %k0" \
      "\n\t lahf" \
      "\n\t movb %%ah, %1" :\
     "=r" (con->genR[rT]), "=m" (con->flags) :\
     "0" (con->genR[rT]), "r" (con->genR[rB]) :\
     "cc","ah");\
  return 0;\
}

#define DEF_ALU_16i(vname,instr) \
int INSTR16i_##vname(struct HEP_context *con) { \
  int c1=con->mem[con->IP];\
  int c2=con->mem[con->IP+1];\
  long long int rT=(c2&0xf)|((c1&0x40)>>2);\
  long long int rB=((c2&0xf0)>>4)|((c1&0x80)>>3);\
  asm(instr " %3, %0" \
      "\n\t lahf" \
      "\n\t movb %%ah, %1" :\
     "=r" (con->genR[rT]), "=m" (con->flags) :\
     "0" (con->genR[rT]), "r" (rB ? rB : 32) :\
     "cc","ah");\
  return 0;\
}

#define DEF_ALU_16li(vname,instr) \
int INSTR16i_##vname(struct HEP_context *con) { \
  int c1=con->mem[con->IP];\
  int c2=con->mem[con->IP+1];\
  long long int rT=(c2&0xf)|((c1&0x40)>>2);\
  long long int rB=((c2&0xf0)>>4)|((c1&0x80)>>3);\
  asm(instr " %k3, %k0" \
      "\n\t lahf" \
      "\n\t movb %%ah, %1" :\
     "=r" (con->genR[rT]), "=m" (con->flags) :\
     "0" (con->genR[rT]), "r" (rB ? rB : 32) :\
     "cc","ah");\
  return 0;\
}

#define DEF_SHF_16(vname,instr) \
int INSTR16_##vname(struct HEP_context *con) { \
  int c1=con->mem[con->IP];\
  int c2=con->mem[con->IP+1];\
  long long int rT=(c2&0xf)|((c1&0x40)>>2);\
  long long int rB=((c2&0xf0)>>4)|((c1&0x80)>>3);\
  asm(instr " %b3, %0" \
      "\n\t lahf" \
      "\n\t movb %%ah, %1" :\
     "=r" (con->genR[rT]), "=m" (con->flags) :\
     "0" (con->genR[rT]), "c" (con->genR[rB]) :\
     "cc","ah");\
  return 0;\
}

#define DEF_SHF_16l(vname,instr) \
int INSTR16_##vname(struct HEP_context *con) { \
  int c1=con->mem[con->IP];\
  int c2=con->mem[con->IP+1];\
  long long int rT=(c2&0xf)|((c1&0x40)>>2);\
  long long int rB=((c2&0xf0)>>4)|((c1&0x80)>>3);\
  asm(instr " %b3, %k0" \
      "\n\t lahf" \
      "\n\t movb %%ah, %1" :\
     "=r" (con->genR[rT]), "=m" (con->flags) :\
     "0" (con->genR[rT]), "c" (con->genR[rB]) :\
     "cc","ah");\
  return 0;\
}

#define DEF_SHF_16i(vname,instr) \
int INSTR16i_##vname(struct HEP_context *con) { \
  int c1=con->mem[con->IP];\
  int c2=con->mem[con->IP+1];\
  long long int rT=(c2&0xf)|((c1&0x40)>>2);\
  long long int rB=((c2&0xf0)>>4)|((c1&0x80)>>3);\
  asm(instr " %b3, %0" \
      "\n\t lahf" \
      "\n\t movb %%ah, %1" :\
     "=r" (con->genR[rT]), "=m" (con->flags) :\
     "0" (con->genR[rT]), "c" (rB ? rB : 32) :\
     "cc","ah");\
  return 0;\
}

#define DEF_SHF_16li(vname,instr) \
int INSTR16i_##vname(struct HEP_context *con) { \
  int c1=con->mem[con->IP];\
  int c2=con->mem[con->IP+1];\
  long long int rT=(c2&0xf)|((c1&0x40)>>2);\
  long long int rB=((c2&0xf0)>>4)|((c1&0x80)>>3);\
  asm(instr " %b3, %k0" \
      "\n\t lahf" \
      "\n\t movb %%ah, %1" :\
     "=r" (con->genR[rT]), "=m" (con->flags) :\
     "0" (con->genR[rT]), "c" (rB ? rB : 32) :\
     "cc","ah");\
  return 0;\
}

DEF_ALU_16(add64,"addq");
DEF_ALU_16l(add32,"addl");
DEF_ALU_16(sub64,"subq");
DEF_ALU_16l(sub32,"subl");
DEF_ALU_16(and64,"andq");
DEF_ALU_16l(and32,"andl");
DEF_ALU_16(or64,"orq");
DEF_ALU_16l(or32,"orl");
DEF_ALU_16(xor64,"xorq");
DEF_ALU_16l(xor32,"xorl");
DEF_ALU_16(cmp64,"cmpq");
DEF_ALU_16l(cmp32,"cmpl");
DEF_ALU_16(test64,"testq");
DEF_SHF_16(shl64,"shlq");
DEF_SHF_16(shr64,"shrq");
DEF_SHF_16(sar64,"sarq");
DEF_SHF_16l(shl32,"shll");
DEF_SHF_16l(shr32,"shrl");
DEF_SHF_16l(sar32,"sarl");

DEF_ALU_16i(add64,"addq");
DEF_ALU_16li(add32,"addl");
DEF_ALU_16i(sub64,"subq");
DEF_ALU_16li(sub32,"subl");
DEF_ALU_16i(and64,"andq");
DEF_ALU_16li(and32,"andl");
DEF_ALU_16i(or64,"orq");
DEF_ALU_16li(or32,"orl");
DEF_ALU_16i(xor64,"xorq");
DEF_ALU_16li(xor32,"xorl");
DEF_ALU_16i(cmp64,"cmpq");
DEF_ALU_16li(cmp32,"cmpl");
DEF_ALU_16i(test64,"testq");
DEF_SHF_16i(shl64,"shlq");
DEF_SHF_16i(shr64,"shrq");
DEF_SHF_16i(sar64,"sarq");
DEF_SHF_16li(shl32,"shll");
DEF_SHF_16li(shr32,"shrl");
DEF_SHF_16li(sar32,"sarl");

