
CFLAGS=-O2 -Wno-write-strings

fuzzer: alu.cpp contx.h
	g++ ${CFLAGS} alu.cpp -ofuzzer

clean:
	rm *.memh
	rm hsim.bin
	rm asm2.o
	rm asm2.obj

