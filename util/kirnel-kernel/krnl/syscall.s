#     This program is free software: you can redistribute it and/or modify it under 
#     the terms of the GNU General Public License as published by the Free Software Foundation, 
#     version 2 of the License.
#
#    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
#    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along with this program. 
#    If not, see <https://www.gnu.org/licenses/>. 

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

