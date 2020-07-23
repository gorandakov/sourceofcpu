OPT=3
CC=g++
CFLAGS=-g

all: asm

asm: asm.o objfile.o instr.o
	$(CC) asm.o objfile.o instr.o -o asm
asm.o: asm.cpp objfile.hpp instr.hpp
	$(CC) -c $(CFLAGS) asm.cpp
objfile.o: objfile.cpp
	$(CC) -c $(CFLAGS) objfile.cpp
instr.o: instr.cpp
	$(CC) -c $(CFLAGS) instr.cpp

