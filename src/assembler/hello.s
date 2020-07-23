

movl $1000,%eax
loop1:
movl $10,%ebx
loop2:
addl %eax,%ebx,%ecx
addl $10,%ebx
subl %ebx,$90,%edx
jne loop2
addl $1000,%eax
subl %eax,$20000,%edx
jne loop1

hlt


