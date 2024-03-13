#include "main.h"

transl_context *tr;

extern "C" {


int exception_handler( hcont *context ) {
  void *IP=context->IP;
  struct { unsigned char[10] b } *insn=IP;
  unsigned long IP_i=(unsigned long) context->IP;
  unsigned long IP_j=((IP_i+31)&0xfffffffffe0)-2;
  unsigned short stop_bits=*(short *) IP_j;
  int pos=IP_i&0x1f;
  unsigned long off;
  unsigned long xoffA=pos==14;
  unsigned long xoffB=pos==13 || pos==14;
  if ((stop_bits >> pos)&1) {
      exit(0);
  } else  if (((stop_bits >> pos >>1)&1)) {
      switch(insn[0]) {
        case OP_CMP_JMP:
          off=(unsigned long) (signed char) insn[3+xoffA*2];
          off<<=2;
          off|=(insn[2+xoffa*2]&0x80)>>6;
          break;
        case OP_UCJUMP:
          off=((unsigned long) (signed char) insn[3+xoffA*2])<<17;
          off|=insn[2+xoffA*2]<<9;
          off|=insn[1]<<1;
          break;
        case OP_CJUMP:
          off=(unsigned long) (signed char) insn[3+xoffA*2];
          off<<=3;
          off|=(insn[2+xoffA*2]&0xc0)>>5;
          break;
#ifdef use_insn_not_in_spec
        case OP_CLOOP_A:
        case OP_CLOOP_B:
        case OP_CITER_A:
        case OP_CITER_B:
          off=((signed short) (insn[3+xoffA*2]&0x7)<<12));
          off|=insn[2+xoffA*2]<<4;
          off|=(insn[1]&0xe0)>>4;
        break;
#endif
        default:
          exit(0);
  } else  if (((stop_bits >> pos >>2)&1) && pos!=13) {
      switch(insn[0]) {
        case OP_UCJUMP:
        case OP_CJUMP:
          off=((unsigned long) (signed char) insn[5+2*xoffB])<<24;
          off|=insn[4+2*xoffB]<<16;
          off|=insn[3+2*xoffA]<<8;
          off|=insn[2+2*xoffA]&0xfe;
          break;
        default:
          exit(0);
          
      }
  }
  void *pgoff=(char *) IP-(char *) tr->transl_region;
  unsigned long off2=(unsigned long)pgoff;
  off2>>=2;
  unsigned long addr=tr->approx_addr(IP,void *off2);
  if ((unptr(addr+off)&0xfe0)==0xfe0) {
    //translate target and next page
    tr->translate_page(off2);
    tr->translate_page(off2+256);
    //re-translate source page
    tr->translate_page(IP);
  } else if ((unptr(addr+off)&0xfe0)==0xfe0) {
    //translate target and previous page
    tr->translate_page(off2);
    tr->translate_page(off2-256);
    //re-translate source page
    tr->translate_page(IP);
  } else {
    //translate target page
    tr->translate_page(off2);
    //re-translate source page
    tr->translate_page(IP);
  }
  return 0;
}
}
