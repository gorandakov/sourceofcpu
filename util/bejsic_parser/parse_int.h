
struct AST {
  int op;
  int flags;
  AST *OP_A;
  AST *OP_B;
  enum AST_CODE_EXPR { _op_mul, _op_div, _op_rem, _op_tofp, _op_tobool, _op_and, _op_or, _op_xor, _op_add, _op_sub, _op_cmovdrv, _op_cmov, _op_bracketi, _op_bracketf, _op_not, _op_minus, _op_length, _op_heap, _op_alloca, _op_call, _op_lookup, _op_toint };
  const int _mask_A_fp=1;
  const int _mask_B_fp=2;
  const int _mask_A_string=4;
  const int _mask_B_string=8;
  const int _mask_A_literal=16;
  const int _mask_B_literal=32;
  const int _mask_AST_EXPR=64;
  const int _mask_AST_LET=128;
  const int _mask_AST_DEF=256;
  const int _mask_AST_PROC=512;
  const int _mask_AST_RTN=1024;
  const int _mask_AST_ERRHNDL=2048;
  const int _dump_expr=4096;
  const int _mark_sem=8192;
  const int _do_goto=16385;
};


AST * parse_int( long *str) {
  long *mystr=str;
  long chr;
  bool prefix_level=0;
  chr= strcharl(mystr);
  while (chr==' ') {
    chr=strcharl(mystr);
  }
  if (chr=='*' && !prefix_level) {
  } 
  if (chr=='/' && !prefix_level) {
  }
  if (chr=='%' && !prefix_level) {
  }
  if ((alnum(chr) || chr==',' || chr==';') && !prefix_level) {
    //terminate a paired operator
    //handle exception record
    //handle context
  }
  if (alnum(chr) && prefix_level) {
      //handle call
      //handle constant
      //handle keyword
  }
}
