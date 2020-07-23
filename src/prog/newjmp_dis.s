mov $myaddr, %rax
mov $myaddr2, %rbx
xor %rcx,%rcx,%rcx
mov $511,%r10d
.align 32
loopCPY:
movq (%rax,%rcx,8),%r8
xorq %r8,%r8,%r11
addq %rax,%r11,%r11
movq %r8,8(%r11,%rcx,8)
movq %r8,(%rbx,%rcx,8)
movq 8(%rax,%rcx,8),%r9
addq $2,%rcx,%rcx
cjle %r10d,%rcx,loopCPY

;0164_0000_0000_0000_0000_0000_0000_07fc0ab8_2212_0000200010b7_0000100000b7
;2d5a_0000_FF91a2A2_2201_04620976_00621877_0462b877_0b00_0020b820_00620876
xor %r9d,%r9d,%r9d
loopH:
mov $myaddr, %rax
xor %ebx,%ebx,%ebx
mov $100,%r8d
.align 32
loopL:
movl (%rax),%ecx
movl 8(%rax),%edx
movl 16(%rax),%esi
addl %ecx,%edx,%edx
addl %edx,%esi,%esi
addl %esi,%ebx,%ebx
addq $24,%rax,%rax
subl $1,%r8d,%r8d
jnz loopL
add $1,%r9d,%r9d
jnz loopH

myaddr: ;4096
.dword x ; x=0-299 
;x86_64 reg numbers used for second part.
;part 1
;part 2
; first bundle
;0059_0000_0000_0000_0000_0000_0000_0000_0000_019008b8_3312_0000100000b7_8810
; second bundle
;3FEA_0000_e131_1903_f031_1807_8081_3602_6202_2102_00406064_00202064_00001064
;empty bundle
;0


