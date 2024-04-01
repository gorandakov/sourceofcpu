
struct AST {
  int op;
  int flags;
  AST *OP_A;
  AST *OP_B;
  enum AST_CODE_EXPR { _op_mul, _op_div, _op_rem, _op_tofp, _op_tobool, _op_and, _op_or, _op_xor, _op_add, _op_sub, _op_cmovdrv, _op_cmov, _op_bracketi, _op_bracketf, _op_not, _op_minus, _op_length, _op_heap, _op_alloca, _op_call, _op_lookup, _op_toint, _op_num};
  const int _mask_A_fp=1;
  const int _mask_B_fp=2;
  const int _mask_A_string=4;
  const int _mask_B_string=8;
  const int _mask_A_literal=16;
  const int _mask_B_literal=32;
  const int _mask_fp=32768;
  const int _mask_string=65536;
  const int _mask_literal=65536*2;
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
  AST *opstack[32]={0};
  int opstack_prio[32];
  int opstack_size=0;
  AST *ast1;
  chr= strcharl(mystr);
  while (chr==' ') {
    chr=strcharl(mystr);
  }
  if (chr=='(' && prefix_level) {
  }
  if (chr==')' && !prefix_level) {
  }
  if (chr=='~' && prefix_level) {
    ast1=new AST;
    ast1.op=_op_inv;
    ast1.flags=_mask_EXPR;
    ast1.op_A=opstack[opstack_size-1];
    if (ast1.op_A) {
      if (!(op_A->flags&_mask_EXPR) && !(opA->op==_op_num)) throw PARSE_ERROR;
      ast1.flags=(opA->op==_op_num) ? _mask_A_literal : 0;
    }
    opstack[opstack_size-1]=ast1;
  }
  if (chr=='-' && prefix_level) {
    ast1=new AST;
    ast1.op=_op_neg;
    ast1.flags=_mask_EXPR;
    ast1.op_A=opstack[opstack_size-1];
    if (ast1.op_A) {
      if (!(op_A->flags&_mask_EXPR) && !(opA->op==_op_num)) throw PARSE_ERROR;
      ast1.flags=(opA->op==_op_num) ? _mask_A_literal : 0;
    }
    opstack[opstack_size-1]=ast1;
  }
  if (chr=='t' && prefix_level) {
    if (!strcmp(str,"toint")) {
      ast1=new AST;
      ast1.op=_op_toint;
      ast1.flags=_mask_EXPR;
      ast1.op_A=opstack[opstack_size-1];
      if (ast1.op_A) {
        if (!(op_A->flags&_mask_EXPR) && !(opA->op==_op_num)) throw PARSE_ERROR;
      ast1.flags=(opA->op==_op_num) ? _mask_A_literal : 0;
    }
    if (!strcmp(str,"tofp")) {
      ast1=new AST;
      ast1.op=_op_tofp;
      ast1.flags=_mask_EXPR;
      ast1.op_A=opstack[opstack_size-1];
      if (ast1.op_A) {
        if (!(op_A->flags&_mask_EXPR) && !(opA->op==_op_num)) throw PARSE_ERROR;
      ast1.flags=(opA->op==_op_num) ? _mask_A_literal : 0;
    }
    opstack[opstack_size-1]=ast1;
    }
    if (!strcmp(str,"tobool")) {
      ast1=new AST;
      ast1.op=_op_tobool;
      ast1.flags=_mask_EXPR;
      ast1.op_A=opstack[opstack_size-1];
      if (ast1.op_A) {
        if (!(op_A->flags&_mask_EXPR) && !(opA->op==_op_num)) throw PARSE_ERROR;
      ast1.flags=(opA->op==_op_num) ? _mask_A_literal : 0;
    }
  }
  if (chr=='a' && !prefix_level) {
    if (!strcmp(str,"and")) {
    }
  }
  if (chr=='o' && !prefix_level) {
    if (!strcmp(str,"or")) {
    }
  }
  if (chr=='n' && prefix_level) {
    if (!strcmp(str,"not")) {
      ast1=new AST;
      ast1.op=_op_not;
      ast1.flags=_mask_EXPR;
      ast1.op_A=opstack[opstack_size-1];
      if (ast1.op_A) {
        if (!(op_A->flags&_mask_EXPR) && !(opA->op==_op_num)) throw PARSE_ERROR;
      ast1.flags=(opA->op==_op_num) ? _mask_A_literal : 0;
    }
  }
  if (chr=='*' && !prefix_level) {
    //conditional stack push
  } 
  if (chr=='/' && !prefix_level) {
    //conditional stack push
  }
  if (chr=='%' && !prefix_level) {
    //conditional stack push
  }
  if (chr=='+' && !prefix_level) {
  }
  if (chr=='-' && !prefix_level) {
  }
  if (chr=='&' && !prefix_level) {
  }
  if (chr=='|' && !prefix_level) {
  }
  if (chr=='^' && !prefix_level) {
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
