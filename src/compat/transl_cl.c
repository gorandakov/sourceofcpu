
#define PREF_64 0x1
#define PREF_DATA 0x2
#define PREF_0F 0x4
#define PREF_A 0x8
#define PREF_B 0x10
#define PREF_C 0x20
#define PREF_REX 0x40
#define PREF_REP 0x80
#define PREF_REPE 0x80
#define PREF_REPNE 0x100
#define PREF_ADDR 0x200
#define PREF_CS 0x400
#define PREF_SS 0x800
#define PREF_DS 0x1000
#define PREF_ES 0x2000
#define PREF_FS 0x4000
#define PREF_GS 0x8000

#define PREF_NOT_SUPP 0x3e00
#define PREF_ALT 0xc000


struct transl_status {
  unsigned short *bundle_cur;
  unsigned short *bundle_begin;
  unsigned long long native;
  unsigned long long targetAddr;
  unsigned char *optype;
  char poff[16];
  char voff[12];
  int begin_addr;
};

unsigned int optype_x86[256]={
 //0f op16 op64
 //1=alu.target first 8/16
 //2=alu.source first 8/16
 //3=??
 //4=??
 //5=alu.target first 32/64
 //6=alu.source first 32/64
 //7=??
 //8=??
 //9=alu.target imm
 [0]=0x1111,
 [1]=0x1155,
 [2]=0x2222,
 [3]=0x2266,
 [8]=0x1111,
 [9]=0x1155,
 [0xa]=0x2222,
 [0xb]=0x2266,
 [0x20]=0x1111,
 [0x21]=0x1155,
 [0x22]=0x2222,
 [0x23]=0x2266,
 [0x28]=0x1111,
 [0x29]=0x1155,
 [0x2a]=0x2222,
 [0x2b]=0x2266,
 [0x30]=0x1111,
 [0x31]=0x1155,
 [0x32]=0x2222,
 [0x33]=0x2266,
 [0x80]=0x99999999,
 [0x81]=0x99999999,
 [0x82]=0x99999999,
 [0x83]=0x99999999,
//base alu done sans non imm cmp, test, shift, mov, accum versions
};

unsigned short preftbl_x86[256]={
 [0x0f]=PREF_0f,
 [0xF0]=PREF_LOCK,
 [0xF3]=PREF_REP,
 [0xF2]=PREF_REPNE,
 [0x2e]=PREF_CS,
 [0x36]=PREF_SS,
 [0x3e]=PREF_DS,
 [0x26]=PREF_ES,
 [0x64]=PREF_FS,
 [0x65]=PREF_GS,
 [0x66]=PREF_DATA,
 [0x67]=PREF_ADDR
};

inline unsigned int get_prefix(char * instr, unsigned int *cnt) {
  unsigned int pref,pref0,pref1,pref2,pref3,pref4,off;
  unsigned char c0=instr[0],c1=instr[1],c2=instr[2],c3=instr[3],c4=instr[4];
  pref0=preftbl_x86[c0];
  pref=pref0 ? pref0 : 0;
  off=pref0 ? 1 : 0;
  pref1=preftbl_x86[c1];
  pref=pref0&&pref1 ? pref0|pref1 : pref;
  off=pref0&&pref1 ? 2 : off;
  pref2=preftbl_x86[c2];
  pref=pref0&&pref1&&pref2 ? pref0|pref1|pref2 : pref;
  off=pref0&&pref1&&pref2 ? 3 : off;
  pref3=preftbl_x86[c3];
  pref=pref0&&pref1&&pref2&&pref3 ? pref0|pref1|pref2|pref3 : pref;
  off=pref0&&pref1&&pref2&&pref3 ? 4 : off;
  pref4=preftbl_x86[c4];
  pref=pref0&&pref1&&pref2&&pref3&&pref4 ? pref0|pref1|pref2|pref3|pref4 : pref;
  off=pref0&&pref1&&pref2&&pref3&&pref4 ? 5 : off;
  *cnt=off;
  return pref;
}

int optput_spec_load_g(int code,unsigned short *to, unsigned char *from, unsigned char modrm, int maxsz,int *natsz) {
  int sz;
  unsigned int off=0;
  if ((modrm&0x38)!=0x20 && (modrm&0xf8)!=0x28) {
    //base+offset
    off=(modrm&0xc0) ? *from : 0u;
    off=(modrm&0x80) ? *from+from[1]*8+from[2]*16+from[2]*24 : off;
    *natsz=(modrm&0xc0) ? 1 : 0u;
    *natsz=(modrm&0x80) ? 4 : *natsz;
    if ((off&0xffffc000u)==0xffffc000u || (off&0xffffc000u)==0u) {
	  //4 byte load
      if (maxsz<2) return 0;
      *to=0xCA|(code<<8)|((modrm&0x7)<<12));
      *(to+1)=(offset & 0x3fff)<<2;
      return 2;
    } else {
	  //6 byte load
      if (maxsz<3) return 0;
      *to=0xCA|(code<<8)|((modrm&0x7)<<12);
      *(to+1)=off&0xffff;
      *(to+2)=(off&0xffff0000)>>16;
      return 3;
    }
  } 
  if ((modrm&0x38)==0x20) {
    //sib
    off=(modrm&0xc0) ? from[1] : 0u;
    off=(modrm&0x80) ? from[1]+from[2]*8+from[3]*16+from[4]*24 : off;
    *natsz=(modrm&0xc0) ? 2 : 0u;
    *natsz=(modrm&0x80) ? 5 : *natsz;
    if ((off&0xfffffe00u)==0xfffffe00u || (off&0xfffffe00u)==0u) {
      if (maxsz<2) return 0;
      return 2;
    } else if ((off&0xf8000000u)==0xf8000000u || (off&0xf8000000u)==0u) {
      if (maxsz<3) return 0;
      return 3;
    } else {
      if (maxsz<4) return 0;
      return 4;
    }
  }
  //imm
  if (maxsz<3) return 0;
  off=*from+from[1]*8+from[2]*16+from[2]*24;
  *natsz=4;
  return 6;
 
}

int optput_load_g(int code,unsigned short *to, unsigned char *from, unsigned char modrm, int maxsz,int treg,int *natsz) {
  int sz;
  unsigned int off=0;
  if ((modrm&0x38)!=0x20 && (modrm&0xf8)!=0x28) {
    //base+offset
    off=(modrm&0xc0) ? *from : 0u;
    off=(modrm&0x80) ? *from+from[1]*8+from[2]*16+from[2]*24 : off;
    *natsz=(modrm&0xc0) ? 1 : 0u;
    *natsz=(modrm&0x80) ? 4 : *natsz;
    if ((off&0xffffc000u)==0xffffc000u || (off&0xffffc000u)==0u) {
	  //4 byte load
      if (maxsz<2) return 0;
      return 2;
    } else {
	  //6 byte load
      if (maxsz<3) return 0;
      return 3;
    }
  } 
  if ((modrm&0x38)==0x20) {
    //sib
    off=(modrm&0xc0) ? from[1] : 0u;
    off=(modrm&0x80) ? from[1]+from[2]*8+from[3]*16+from[4]*24 : off;
    *natsz=(modrm&0xc0) ? 2 : 0u;
    *natsz=(modrm&0x80) ? 5 : *natsz;
    if ((off&0xfffffe00u)==0xfffffe00u || (off&0xfffffe00u)==0u) {
      if (maxsz<2) return 0;
      return 2;
    } else if ((off&0xf8000000u)==0xf8000000u || (off&0xf8000000u)==0u) {
      if (maxsz<3) return 0;
      return 3;
    } else {
      if (maxsz<4) return 0;
      return 4;
    }
  }
  //imm
  if (maxsz<3) return 0;
  off=*from+from[1]*8+from[2]*16+from[2]*24;
  *natsz=4;
  return 6;
 
}


struct transl_status bundle_transl(long long paddr, long long vaddr, unsigned
  short *bundle, unsigned int bgnoff) {
  struct transl_status ret;
  int bndl_off=bgnoff;
  unsigned char bundl2[32];
  unsigned char *instr=(unsigned char *) (paddr+PADDR_OFF);
  int mod, chr1;
  int opc1;
  if ((paddr&0xff0)==0xff0) {
    unsigned long long *ptr=(unsigned long long *) &bndl2[0];
    unsigned long long *src=(unsigned long long *) instr;
    unsigned long long *src2=(unsigned long long *) vmachine_addr_transl(
        vaddr+32);
    *ptr[0]=*src[0];
    *ptr[1]=*src[1];
    *ptr[2]=*src2[0];
    *ptr[3]=*src2[1];
    instr=&bndl2[0];
  }
  while (bndl_off<16) {
    unsigned int prefcnt;
    unsigned int prefix;
    int bndl_off2;
    unsigned int index,shift;
    prefix=get_prefix(instr+bndl_off,&prefcnt);    
    bndl_off2+=prefcnt;
    index=instr[bndl_off2];
    shift=(prefix&0x7)<<2;
    switch((optype_x86[index]>>shift)&0xf) {
0:
1:
2:
3:
4:
5: //alu 32/64 target first
   chr1=*(instr+bndl_off2+1);
   mod=chr1&0xc0;
   opc1=OPC1_X86[index];
   if (mod==0xc0) {
     bundle[bpr++]=(opc1&0x1c)|(((~prefix)&PREF_64)<<1)|((opc1&0x38)<<5)|((opc1&0x7)<<8);
     TERMINATE_BUNDLE;
   } else {
   }
   break;
6:
7:
8:
9:
0xa:
0xb:
0xc:
0xd:
0xe:
0xf:
    }
  }
}
