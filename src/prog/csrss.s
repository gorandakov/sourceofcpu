xorq %ebx,%ebx,%ebx
loop:
wrcsr %rbx,$5
rdcsr $5,%r9
addq $3,%rbx,%rbx
cjle $300,%rbx,loop

;0135_0000_0000_0000_0000_0000_0000_fff1096409a2_3101_000529ff_000501ff_1110
