
.global pinvoke_init
.type pinvoke_init, function
.global pinvoke_nop
.type pinvoke_nop, function
.global pinvoke_clear_lower
.type pinvoke_clear_lower, function

.p2align 5
pinvoke_init:
movq %r16,%r0
movq %r17,%r1
movq %r18,%r2
movq %r19,%r3
movq %r20,%r4
movq %r21,%r5
movq %r22,%r6
movq %r23,%r7
movq %r24,%r8
movq %r25,%r9
movq %r26,%r10
movq %r27,%r11
movapd %ymm16,%ymm0
movapd %ymm17,%ymm1
movapd %ymm18,%ymm2
movapd %ymm19,%ymm3
movapd %ymm20,%ymm4
movapd %ymm21,%ymm5
movapd %ymm22,%ymm6
movapd %ymm23,%ymm7
movapd %ymm24,%ymm8
movapd %ymm25,%ymm9
movapd %ymm26,%ymm10
movapd %ymm27,%ymm11
wrmsr %MSR_PKILL, %r0

.p2align 5
pinvoke_nop:
wrmsr %MSR_PKILL

.p2align 5
pinvoke_clear_lower:
movq $0,%r0
movq $0,%r1
movq $0,%r2
movq $0,%r3
movq $0,%r4
movq $0,%r5
movq $0,%r6
movq $0,%r7
movq $0,%r8
movq $0,%r9
movq $0,%r10
movq $0,%r11
movq $0,%r12
movq $0,%r13
movq $0,%r14
movq $0,%r15
wrmsr %MSR_PKILL

