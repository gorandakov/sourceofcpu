#include "keyword.h"
#include "id.h"
#include "parse.h"
#include "type.h"
#define FNCALL_CUSTOM 1000

FN *parse_function(char * str, int *new_pos) {
  int pos1,pos;
  int kw=parse_keyword(str,&pos1);
  int t;
  FN *ret;
  if (kw<0) {*new_pos=0; return ERROR_NOT_PARSED; }
  if (init_KW[kw].number!=KW_DEFINE) {*new_pos=0; return ERROR_NOT_PARSED; }
  str+=pos1;
  pos=pos1;
  parse_spc(str,&pos1);
  str+=pos1;
  pos+=pos1;
  ret=new_function();  
  kw=parse_keyword(str,&pos1);
  if (init_KW[kw].type=KW_LINKAGE) {
      ret->linkage=init_KW[kw].number;
      str+=pos1;
      pos+=pos1;
      parse_spc(str,&pos1);
      str+=pos1;
      pos+=pos1;
      kw=parse_keyword(str,&pos1);
  }
  if (init_KW[kw].type=KW_PREEMPT) {
      ret->preempt=init_KW[kw].number;
      str+=pos1;
      pos+=pos1;
      parse_spc(str,&pos1);
      str+=pos1;
      pos+=pos1;
      kw=parse_keyword(str,&pos1);
  }
  if (init_KW[kw].type=KW_VIS) {
      ret->visibility=init_KW[kw].number;
      str+=pos1;
      pos+=pos1;
      parse_spc(str,&pos1);
      str+=pos1;
      pos+=pos1;
      kw=parse_keyword(str,&pos1);
  }
  if (init_KW[kw].type=KW_FNCALL) {
      if (init_KW[kw].number!=KW_FN_CC)
          ret->cconv=init_KW[kw].number;
      else {
          int a;
          str+=pos1;
          pos+=pos1;
          parse_spc(str,&pos1);
          str+=pos1;
          pos+=pos1;
          a=parse_num(str,&pos1);
          if (a<0) {free_fn(ret); *new_pos=pos; return a; }
          ret->cconv=a+FNCALL_CUSTOM;          
      }
      str+=pos1;
      pos+=pos1;
      parse_spc(str,&pos1);
      str+=pos1;
      pos+=pos1;
      kw=parse_keyword(str,&pos1);
  }
//ret attrs
  t=parse_type(str,&pos1);
  if (t<0) { free_fn(ret); *new_pos=pos; return t=ERROR_NOT_PARSED ? 
   ERROR_TYPE_EXPECTED : t; }
  ret->rtype=t;  
}

