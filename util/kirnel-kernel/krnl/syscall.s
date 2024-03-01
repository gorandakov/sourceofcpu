
.global __syscall
.type __syscall,@function

.p2allign 5
__syscall:
rdmsr %MSR_KPCR, %r0
rdmsr %MSR_RETIP, %r2
test $MASK_KMODE, %r2
jnz __syscall_non_kmode
movq %r2,%r19
jmp syscall
__syscall_non_kmode:
orq $KFL_SYSCALL,0(%r0)
movq %r5,8(%r0)
movq 16(%r0),%r5
movq %r2,24(%r0)
jmp syscall

