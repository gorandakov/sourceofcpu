wrcsr %rsp, excStackSave
rdcsr excStack, %rsp
subxq $8,%rsp
link %r31,1
callp %r31, save_context
movq $exc_no,%rdi
subxq $8, %rsp
link %r24,1
;;6a6a_4818_80204409_FFFC33b7_FFFFFFFF1fb6_3f18_80204409_000624ff_000504ff
callp except_handler
subxq $8,%rsp
link %r24,1
callp restore_context
;begin new code
movq context_off+192(%r31),%r24
movq context_off+248(%r31),%r31
rdcsr excStackSave, %rsp
iret excIP
;;1534_0000_0000_000840ff_000524ff_FFFFFFFF18b6_3818_80204409_FFFFFFFF18b6
