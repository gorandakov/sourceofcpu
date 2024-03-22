_start:
 seaq ptbl0(%rip),%rax
 seaq ptbl1(%rip), %rbx
 wrcsr $csr_page0, %rax
 wrcsr $csr_page1, %rbx


