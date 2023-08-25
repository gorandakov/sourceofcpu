#include <cstdlib>
#include <cfenv>
#include <cstdio>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include "Vselftest.h"
#include "verilated.h"
#include "prefix.h"
#include "../inc/ptr.h"
#include "contx.h"
#include "../inc/struct.h"
#include "../inc/cjump.h"
#include "../inc/extract.h"

#define get64(a) ((((unsigned long long) a[1])<<32)|(unsigned long long) a[0])
#define set64i(a,b,c) a[0]=b;a[1]=b>>32;a[2]=c;

int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);
    Vtop *top=new Vselftest();
    Verilated::assertOn(false);
    Verilated::traceEverOn(false);
    int initcount=10;
    int cyc=0;
    unsigned long long ip=0;
    top->clk=0;
    top->rst=1;
    top->eval();
    top->clk=1;
    top->eval();
    top->clk=0;
    top->eval();
    top->eval();
    top->rst=0;
    while(!Verilated::gotFinish()) {
        int k,j;
        top->clk=1;
        top->eval();
        top->clk=0;
        top->eval();
        if (!initcount) {
            cyc=cyc+1;
            if ((cyc%100)==0) {
                printf("cycle %i\n",cyc);
            }
           
        } else {
            initcount=initcount-1;
            if (!initcount) Verilated::assertOn(false);
        }
    }
}
