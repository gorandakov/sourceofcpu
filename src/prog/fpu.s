movabsq array, %r9
xorq %r10,%r10
;0030_0000_00000000_00000000_00000000_00000000_aa10_000000000000800090b7
.p2align 5
do_box:
  addl $1,%r10,%r11
  addq $64,%r9,%r8
  movapd (%r9),  %xmm0
  movapd 16(%r9),%xmm1
  movapd 32(%r9),%xmm2
  movapd 48(%r9),%xmm3
;0aaa_0000_00000000_00c1395a_0081295a_0041195a_0001095a_01008901_0004ba03
;label=32
.p2align 5
do_row:
;xmm0-3=source row
;r8=current tx row ptr
;r9=source row
;r10=source index
;r11=tx row index
  movsd (%r9,%r10,8),%xmm10
  movsd (%r8,%r10,8),%xmm8
  x0divdl %xmm10,%xmm8,%xmm8
  movapd (%r8),  %xmm4
  movapd 16(%r8),%xmm5
  movapd 32(%r8),%xmm6
  movapd 48(%r8),%xmm7
;2aaa_0000_00c1785a_0081685a_0041585a_0001485a_c6b023ef_007a8892_007a9a92
  x2muld %xmm8,%xmm0,%xmm9
  x0subd %xmm9,%xmm4,%xmm4
  movapd %xmm4,(%r8)
  x2muld %xmm8,%xmm1,%xmm9
  x0subd %xmm9,%xmm5,%xmm5
  movapd %xmm5,16(%r8)
  x2muld %xmm8,%xmm2,%xmm9
  x0subd %xmm9,%xmm6,%xmm6
  movapd %xmm6,32(%r8)
;5ad6_00816853_96be_ce2488ef_00415853_95be_ce2288ef_00014853_94be_ce2088ef
  x2muld %xmm8,%xmm3,%xmm9
  x0subd %xmm9,%xmm7,%xmm7
  movapd %xmm7,48(%r8)
  addq $64,%r8,%r8
  addl $1,%r11d,%r11d
  cjlel $6,%r11d,do_row
  
  addq $64,%r9,%r9
  addl $1,%r10,%r10
;34d6_0000_1a03_01009901_ffab00340ba3_1b03_01008801_00c17853_97be_ce2688ef
  cjlel $5,%r10d,do_box
;new registers
  movabsq array+320, %r9
  movq $6,%r10
;0284_0000_0000_0000_0000_0000_0018a0b7_000000000000814090b7_ff7b002c0aa3
.p2align 5
do_nroot:  
  movsd 64(%r9,%r10,8),%xmm0
  x0divdl 112(%r9),%xmm0,%xmm0 ;2 instr spec ld + x0divd
  movsd %xmm0,roots(,%r10,8)
  xorq %r11,%r11
  movq %r9,%r8
;0e2a_0000_0000_0000_8920_bb10_047a00008200009b_03e023ef_01c09936_027a9092
.p2align 5
do_nroot_loop:
  x0muldl (%r8,%r10,8),%xmm0,%xmm1
  movsd 56(%r8),%xmm2
  x0subdl %xmm1,%xmm2,%xmm2 
  movsd %xmm2,56(%r8)
  sub $64,%r8,%r8
  addq $1,%r11,%r11
  cjleql %r10d,%r11d,do_nroot_loop
  sub $64,%r9,%r9
;56b6_01009909_ff98aba3_1b01_01008809_00e1285b_12b6_00e12852_01b8_006a8936
  subq $1,%r10,%r10
  cjeql $-1,%r10,do_nroot
  jmp _start
;0029_0000_0000_0000_0000_0000_0000_0000_0000_0000_ffff7ab5_ffd8fffc0aa1_1a06  
  
