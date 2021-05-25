
.global parse_assign
.p2align 5
parse_assign:
movzbl (%r9),%r8
callq is_alpha
testl %eax,%eax
jeq parse_error
lea chrbuftkn(%rip),%rsi
xorl %eax,%eax
movq %eax,(%rsi)
.p2align 5
loop_tkn:
  movb %r8,(%rsi)
  addq $1, %rsi
  movzbl (%r9),%r8
  addq $1,%r9
  callq is_alpha_num
  testl %eax,%eax
  jne loop_tkn
callq skip_spc
movq chrbuftkn(%rip),%r8
callq find_kword
testq %rax,%rax
jne process_kword
callq find_var_new
movq %rsi,assign_var(%rip)
movzbl (%r9),%edx
cmpl $'=',%edx
jne parse_error
addq $1,%r9
callq skip_spc
movq $0,%r10
.p2align 5
parse_node:
xorl %eax,%eax
movl %eax,acc_minus(,%r10)
.p2align 5
loop_minus:
  movzbl (%r9),%r8
  cmpl '-',%r8
  jne no_minus
  movl $1,%eax
  xorl acc_minus(%rip,%r10),%eax
  movl %eax,acc_minus(,%r10)
  addq $1,%r9
  callq skip_spc
  jmp loop_minus
.p2align 5
no_minus:
  cmpl '(',%r8
  jne no_o_brack
  addl $1,%r10
  cmpl $15,%r10
  jg parse_error
  addq $1,%r9
  movzbl (%r9),%r8
  jmp parse_node
.p2align 5
no_o_brack:

callq is_alpha
testl %eax,%eax
jeq parse_number
lea chrbuftkn(%rip),%rsi
xorl %eax,%eax
movq %eax,(%rsi)
.p2align 5
loop_tkn_node:
  movb %r8,(%rsi)
  addq $1, %rsi
  movzbl (%r9),%r8
  addq $1,%r9
  callq is_alpha_num
  testl %eax,%eax
  jne loop_tkn
callq skip_spc
movq chrbuftkn(%rip),%r8
callq find_var
testl %eax,%eax
jeq parse_error
movq $8(%rsi),%rdx
movq %rdx,acc_val(,%r10,8)
.p2align 5
parse_operator:

.p2align 5
parse_number:


