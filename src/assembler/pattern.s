

movl $1,%r8
movl $256,%eax
loop1:
movl %r8,%r9
shll $1,r8
xorl %r8,%r9,%r8
shrl $3,%r9
andl $1,%r9
jeq nextzero
orl $1,%r8
nextzero:
movl %r8,%r10
subl $1,%eax
jne loop1

hlt


