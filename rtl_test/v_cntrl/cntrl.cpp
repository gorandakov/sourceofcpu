#include <cstdio>
#include <cstdlib>
#include <random>
#include "Vcntrl_find_outcome.h"
#include "verilated.h"
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include "../inc/struct.h"
#include "../inc/extract.h"
#include "../inc/csrss_no.h"

#define get64(a) ((((unsigned long long) a[1])<<32)|(unsigned long long) a[0])
#define set64i(a,b) a[0]=b;a[1]=b>>32;a[2]=0;

#define HUG 1

unsigned long def_seed;

struct insn {
  unsigned char rT;
  unsigned char rT_en;
  unsigned char rT_enF;
  unsigned char II;
  unsigned char is_load;
  unsigned char is_ldconfl;
  unsigned char is_smpconfl;
  unsigned char is_ldexc;
  unsigned char is_exc;
  unsigned char exc_vec;
  unsigned char is_jump;
  unsigned char is_indir;
  unsigned char fl_wr;
  unsigned char flag;
  unsigned char len;
  unsigned char en;
  unsigned long target;
  unsigned long IP;
};

insn reqs[48][10]={};
int ii_upper;
int ii_ret;

int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);
    Vagu_block *top=new Vagu_block();
    Verilated::assertOn(false);
    int initcount=512;
    long int cyc0=0;
    int stall_cnt=0;
    int exc=0;
    unsigned long bndl=0;
    bool err2;
    
    int pid;

    if (argc==1) {
        FILE *f=fopen("/home/goran/ctl_req_seed","r");
	if (f==NULL) f=fopen("/dev/random","r");
	if (f==NULL) exit(2);
	fread((void *) &def_seed,8,1,f);
	fclose(f);
	goto _begin;
    } else {
        if (strcmp(argv[1],"-multi")) exit(2);
        FILE *f=fopen("/dev/random","r");
	if (f==NULL) exit(2);
        FILE *f2=fopen("/home/goran/ctl_req_seed","w");
	if (f2==NULL) exit(2);
	fread((void *) &def_seed,8,1,f);
	fwrite((void *) &def_seed,8,1,f2);
	fflush(f2);
	while (pid=fork()) {
	    int status;
	    if (pid<0) exit(4);
	    wait(&status);
	    if (!WIFEXITED(status)) exit(3);
	    if (WEXITSTATUS(status)==0) {
	        fread((void *) &def_seed,8,1,f);
	        rewind(f2);
	        fwrite((void *) &def_seed,8,1,f2);
	        fflush(f2);
	    } else {
	        exit(WEXITSTATUS(status));
	    }
	}
	execl(argv[0],argv[0],(char *) NULL);
	exit(5);
    }

_begin:

    srand48(def_seed);
    //rndgen.seed();
    top->rst=1;
    top->except=0;
    top->eval();
    top->clk=1;
    top->eval();
    top->rst=0;
    while (!Verilated::gotFinish()) {
        top->clk=0;
        top->eval();
        top->eval();
        top->clk=1;
        top->eval();
        if (!initcount) {
            if (sched(top,err2,exc))  { bndl++; stall_cnt=0; } 
	    else {
	        if((++stall_cnt)>=20000)  {
		    err2=true;
		    printf("bndl error 20000\n");
		}
	    }
        }
        top->eval();
        if (!initcount) {
            if (get_check(top,exc) || err2) {
                printf("error @%u\n",cyc0);
                sleep(1);
		exit(1);
            }
            if ((cyc0%10000)==0) {
                printf("cycle %i,%lu\n",cyc0,bndl);
            }
	    if (exc) exc--;
        }
        if (initcount) initcount--;
        cyc0++;
        if (cyc0>1000000) exit(0);
    }

}
