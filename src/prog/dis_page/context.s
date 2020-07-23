context_off=0
.global e_store_context
.type e_store_context, @function
e_store_context:
wrcsr %r31,$9
rdcsr $7,%r31
movq %rax,context_off+0(%r31)
movq %rbx,context_off+8(%r31)
movq %rcx,context_off+16(%r31)
movq %rdx,context_off+24(%r31)
;ovq %rsp,context_off+0(%r31)
movq %rbp,context_off+40(%r31)
movq %rsi,context_off+48(%r31)
movq %rdi,context_off+56(%r31)
movq %r8,context_off+64(%r31)
movq %r9,context_off+72(%r31)
movq %r10,context_off+80(%r31)
movq %r11,context_off+88(%r31)
movq %r12,context_off+96(%r31)
movq %r13,context_off+104(%r31)
movq %r14,context_off+112(%r31)
movq %r15,context_off+120(%r31)
movq %r16,context_off+128(%r31)
movq %r17,context_off+136(%r31)
movq %r18,context_off+144(%r31)
movq %r19,context_off+152(%r31)
movq %r20,context_off+160(%r31)
movq %r21,context_off+168(%r31)
movq %r22,context_off+176(%r31)
movq %r23,context_off+184(%r31)
movq %r24,context_off+192(%r31)
movq %r25,context_off+200(%r31)
movq %r26,context_off+208(%r31)
movq %r27,context_off+216(%r31)
movq %r28,context_off+224(%r31)
movq %r29,context_off+232(%r31)
movq %r30,context_off+240(%r31)
rdcsr $9,%rdi
movq %rdi,context_off+248(%r31)
ret
.size e_store_context, .-e_store_context


.global e_load_context
.type e_load_context, @function
e_load_context:
movq context_off+0(%r31),%rax
movq context_off+8(%r31),%rbx
movq context_off+16(%r31),%rcx
movq context_off+24(%r31),%rdx
;ovq context_off+0(%r31),%rsp
movq context_off+40(%r31),%rbp
movq context_off+48(%r31),%rsi
movq context_off+56(%r31),%rdi
movq context_off+64(%r31),%r8
movq context_off+72(%r31),%r9
movq context_off+80(%r31),%r10
movq context_off+88(%r31),%r11
movq context_off+96(%r31),%r12
movq context_off+104(%r31),%r13
movq context_off+112(%r31),%r14
movq context_off+120(%r31),%r15
movq context_off+128(%r31),%r16
movq context_off+136(%r31),%r17
movq context_off+144(%r31),%r18
movq context_off+152(%r31),%r19
movq context_off+160(%r31),%r20
movq context_off+168(%r31),%r21
movq context_off+176(%r31),%r22
movq context_off+184(%r31),%r23
movq context_off+200(%r31),%r25
movq context_off+208(%r31),%r26
movq context_off+216(%r31),%r27
movq context_off+224(%r31),%r28
movq context_off+232(%r31),%r29
movq context_off+240(%r31),%r30
ret
.size e_load_context, .-e_load_context


