./fuzzer -asm
~/heptbinut/gas/as-new /tmp/asm2.s -oasm2.o
~/heptbinut/ld/ld-new asm2.o -Ttext 0x0 -Tbss 0x20000000 --oformat=binary -ohsim.bin
