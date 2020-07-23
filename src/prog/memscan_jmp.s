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
hlt

myaddr: ;4096
.dword x ; x=0-299 



; first bundle
;002c_0000_0000_0000_0000_0000_0000_0000_0000_0000_019008b8_3322_0000100000b7
; second bundle
;1af5_0000_0000_f3a1_0004880b_00600001_3602_6202_2102_00406064_00202064_0164
;hlt bundle
0001_00000000_00000000_00000000_00000000_00000000_00000000_00000000_ffff
;empty bundle
;0


