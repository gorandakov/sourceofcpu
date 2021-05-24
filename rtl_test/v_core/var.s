
.global find_var
find_var:
lea varlist(%rip),%rsi
loop_find:
  movq (%rsi),%rdx
  cmpq %r8,%rdx
  jeq loop_found
  testq %rdx,%rdx
  addq $16,%rsi
  jne loop_find
subq $16,%rsi
movq $0,%rax
retq
loop_found:
movq $1,%rax
retq  


.global init_var
init_var:
movq $0,%rax
movq %rax,varlist(%rip)
retq


.global find_var_new
lea varlist(%rip),%rsi
loop_find:
  movq (%rsi),%rdx
  cmpq %r8,%rdx
  jeq loop_found
  testq %rdx,%rdx
  addq $16,%rsi
  jne loop_find
subq $16,%rsi
movq %r8,%rsi
movq $1,%rax
retq
loop_found:
movq $1,%rax
retq  


