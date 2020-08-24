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
  unsigned char is_setcsr;
  unsigned char is_tkn;
  unsigned char jtype;
  unsigned char en;
  unsigned long target;
  unsigned long IP;
};

insn reqs[48][10]={};
int ii_upper;
int ii_ret;

void gen_bndl(insn reqs[10],int exc,unsigned long &IP) {
    if (exc) return;
    memset((char *) reqs,0,10*sizeof reqs[0]);
    int cnt=lrand48()%10+1;
    int jcnt;
    if (cnt!=10) jcnt=lrand48() % 3;
    else jcnt=lrand48()%2+1;
    int jpos0=lrand48()%cnt;
    int jpos1;
    if (jcnt==2) do {
        jpos1=lrand48()%cnt;
    } while (jpos1==jpos0);
    int n;
    int regs_used=0;
    int tkn=0;
    if (jcnt==2) tkn=lrand48()%2;
    int jalu0=lrand48()%2;
    if (cnt==10 && jcnt<2) jalu0=0;
    int jalu1=lrand48()%2;
    if (cnt==10 && jalu0) jalu1=0;
    int tkn0,tkn1;
    tkn0=lrand48()%2;
    if (tkn0) tkn1=0;
    else tkn1=lrand48()%2;
    for(n=0;n<cnt;n++) {
	reqs[n].en=1;
	if (jcnt&&n==jpos0) {
	    reqs[n].is_jump=1;
	    reqs[n].is_tkn=tkn0;
	    reqs[n].is_indir=lrand48()%2;
	    if (!tkn0) reqs[n].is_indir=0;
	    reqs[n].is_setcsr=lrand48()%2;
	    if (!tkn0) reqs[n].is_setcsr=0;
	    reqs[n].jtype=lrand48()%16;
	    reqs[n].IP=IP;
	    do {
		reqs[n].target=lrand48()&0xffffffffffe|((lrand48()&0xfffff)<<44);
	    } while ((reqs[n].target&0x1e)==0x1e);
	    reqs[n].after_tick=(has_tick && n>=tick);
	    reqs[n].IPoff=IPoff;
	    reqs[n].len=(lrand48()%10+1)<<1;
	    IP+=len;
	    IPoff+=len;
	    if (!tkn0 && IPoff>255) {
		tick=n+1;
		has_tick=1;
	    }
	    if (tkn0) {
		IP=reqs[n].target;
		IPoff=0;
		has_tick=0;
	    }
	} else if (jcnt&&n==jpos1) {
	    reqs[n].is_jump=1;
	    reqs[n].is_tkn=tkn1;
	    reqs[n].is_indir=lrand48()%2;
	    if (!tkn1) reqs[n].is_indir=0;
	    reqs[n].is_setcsr=lrand48()%2;
	    if (!tkn1) reqs[n].is_setcsr=0;
	    reqs[n].jtype=lrand48()%16;
	    reqs[n].IP=IP;
	    do {
		reqs[n].target=lrand48()&0xffffffffffe|((lrand48()&0xfffff)<<44);
	    } while ((reqs[n].target&0x1e)==0x1e);
	    reqs[n].after_tick=(has_tick && n>=tick);
	    reqs[n].IPoff=IPoff;
	    reqs[n].len=(lrand48()%10+1)<<1;
	    IP+=len;
	    IPoff+=len;
	    if (!tkn1 && IPoff>255) {
		tick=n+1;
		has_tick=1;
	    }
	    if (tkn1) {
		IP=reqs[n].target;
		IPoff=0;
		has_tick=0;
	    }
	}
    }
    if (IPoff>255) IPoff-=256;
}

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
