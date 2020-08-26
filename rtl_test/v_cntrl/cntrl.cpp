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
  unsigned char is_ldpass;
  unsigned char is_exc;
  unsigned char exc_vec;
  unsigned char is_jump;
  unsigned char is_indir;
  unsigned char fl_wr;
  unsigned char flag;
  unsigned char flag_in;
  unsigned char len;
  unsigned char is_setcsr;
  unsigned char is_tkn;
  unsigned char jtype;
  unsigned char en;
  unsigned short rT_reg;
  unsigned long target;
  unsigned long IP;
};

insn reqs[48][10]={};
int ii_upper;
int ii_ret;

void gen_bndl(insn reqs[10],int exc,unsigned long &baseIP,unsigned int &IPoff,unsigned char &flg) {
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
    int rno;
    int tick=0;
    int has_tick=0;
    unsigned long IP=baseIP+IPoff;
    for(n=0;n<cnt;n++) {
	reqs[n].en=1;
	reqs[n].flag_in=flg;
	if (jcnt&&n==jpos0) {
	    reqs[n].is_jump=1;
	    reqs[n].is_tkn=tkn0;
	    reqs[n].is_indir=(lrand48()%2)&jalu0;
	    if (!tkn0 || (jcnt<2 && cnt==10) reqs[n].is_indir=0;
	    reqs[n].is_setcsr=(lrand48()%2)&jalu0;
	    if (!tkn0 || reqs[n].is_indir) reqs[n].is_setcsr=0;
	    reqs[n].jtype=lrand48()%16;
	    reqs[n].IP=IP;
	    do {
		reqs[n].target=lrand48()&0xffffffffffe|((lrand48()&0xfffff)<<44);
	    } while ((reqs[n].target&0x1e)==0x1e);
//	    reqs[n].after_tick=(has_tick && n>=tick);
	    reqs[n].IPoff=IPoff;
	    reqs[n].len=(lrand48()%5+1)<<1;
	    IP+=len;
	    IPoff+=len;
	    if (!tkn0 && IPoff>255) {
		tick=n+1;
		has_tick=1;
	    }
	    if (tkn0) {
		IP=reqs[n].target;
		baseIP=IP;
		IPoff=0;
		has_tick=0;
	    }
	} else if (jcnt&&n==jpos1) {
	    reqs[n].is_jump=1;
	    reqs[n].is_tkn=tkn1;
	    reqs[n].is_indir=(lrand48()%2)&jalu1;
	    if (!tkn1 || (jalu0 && cnt==10) ) reqs[n].is_indir=0;
	    if (!reqs[n].is_indir) reqs[n].is_setcsr=(lrand48()%2)&jalu1;
	    if (!tkn1 || reqs[n].is_indir) reqs[n].is_setcsr=0;
	    reqs[n].jtype=lrand48()%16;
	    reqs[n].IP=IP;
	    do {
		reqs[n].target=lrand48()&0xffffffffffe|((lrand48()&0xfffff)<<44);
	    } while ((reqs[n].target&0x1e)==0x1e);
//	    reqs[n].after_tick=(has_tick && n>=tick);
	    reqs[n].IPoff=IPoff;
	    reqs[n].len=(lrand48()%5+1)<<1;
	    IP+=len;
	    IPoff+=len;
	    if (!tkn1 && IPoff>255) {
		tick=n+1;
		has_tick=1;
	    }
	    if (tkn1) {
		IP=reqs[n].target;
		baseIP=IP;
		IPoff=0;
		has_tick=0;
	    }
	} else {
	    do {
		rno=lrand48()%9;
	    } while (!((regs_used>>rno)&1));
	    reqs[n].rT_reg=((lrand48()&0x1f)<<4) | rno;
	    reqs[n].rT=lrand48()&0x1f;
	    switch(lrand48()%3) {
		case 1: if (st_cnt<3 && lscnt<6) goto do_store;
		case 0: if (lscnt<6) goto do_load;
		case 2: goto do_alu;
	    }
            do_store:
	    reqs[n].is_load=1;
	    reqs[n].is_ldexc=!(lrand48()%43);
	    goto do_end;
            do_load:
	    reqs[n].is_load=1;
	    reqs[n].is_ldexc=!(lrand48()%43);
	    reqs[n].is_ldconfl=!(lrand48()%43);
	    reqs[n].is_smpconfl=!(lrand48()%43);
	    reqs[n].is_ldpass=!(lrand48()%43);
	    reqs[n].rT_en=lrand48()&1;
	    reqs[n].rT_enF=!reqs[n].rT_en;
	    regs_used|=1<<rno;
	    goto do_end;
            do_alu:
	    reqs[n].rT_en=lrand48()&1;
	    reqs[n].rT_enF=!reqs[n].rT_en;
	    regs_used|=1<<rno;
	    reqs[n].fl_wr=lrand48()&1;
	    if (reqs[n].fl_wr) {
		reqs[n].flag=lrand48()&0x3f;
		flg=reqs[n].flag;
	    }
	    if (reqs[n].fl_wr && !(lrand48()%13)) {
		reqs[n].rT_en=0;
		reqs[n].rT_enF=0;
	    }
            do_end:
	    reqs[n].after_tick=(has_tick && n>=tick);
	    reqs[n].IPoff=IPoff;
	    reqs[n].len=(lrand48()%5+1)<<1;
	    IP+=len;
	    IPoff+=len;
	    if (IPoff>255) {
		tick=n+1;
		has_tick=1;
	    }
	}
    }
    if (IPoff>255) {
	IPoff-=256;
	baseIP+=256;
    }
}

void sched(Vcntrl_find_outcome *top, int &err, bool exc) {
    unsigned II_upper=0;
    if (top->doStall) return;
    top->new_en=1;
    top->new_thread=0;
    top->new_addr=II_upper;
    top->instr0_en=reqs[II_upper][0].en && reqs[II_upper][0].rT_en | 
	    reqs[II_upper][0].rT_enF | reqs[II_upper][0].fl_wr |
	    reqs[II_upper][0].is_indir | reqs[II_upper][0].is_setcsr;
    top->instr0_wren=reqs[II_upper][0].rT_en || reqs[II_upper][0].rT_enF;
    top->instr0_IPOff=reqs[II_upper][0].IPoff+reqs[II_upper][0].len;
    top->instr0_magic=reqs[II_upper][0].len;
    top->instr0_last=reqs[II_upper][0].en && !reqs[II_upper][0].en;
    //top->instr0_after_spec=
    top->instr1_en=reqs[II_upper][1].en && reqs[II_upper][1].rT_en | 
	    reqs[II_upper][1].rT_enF | reqs[II_upper][1].fl_wr |
	    reqs[II_upper][1].is_indir | reqs[II_upper][1].is_setcsr;
    top->instr1_wren=reqs[II_upper][1].rT_en || reqs[II_upper][1].rT_enF;
    top->instr1_IPOff=reqs[II_upper][1].IPoff+reqs[II_upper][1].len;
    top->instr1_magic=reqs[II_upper][1].len;
    top->instr1_last=reqs[II_upper][1].en && !reqs[II_upper][1].en;
    //top->instr1_after_spec=
    top->instr2_en=reqs[II_upper][2].en && reqs[II_upper][2].rT_en | 
	    reqs[II_upper][2].rT_enF | reqs[II_upper][2].fl_wr |
	    reqs[II_upper][2].is_indir | reqs[II_upper][2].is_setcsr;
    top->instr2_wren=reqs[II_upper][2].rT_en || reqs[II_upper][2].rT_enF;
    top->instr2_IPOff=reqs[II_upper][2].IPoff+reqs[II_upper][2].len;
    top->instr2_magic=reqs[II_upper][2].len;
    top->instr2_last=reqs[II_upper][2].en && !reqs[II_upper][2].en;
    //top->instr2_after_spec=
    top->instr3_en=reqs[II_upper][3].en && reqs[II_upper][3].rT_en | 
	    reqs[II_upper][3].rT_enF | reqs[II_upper][3].fl_wr |
	    reqs[II_upper][3].is_indir | reqs[II_upper][3].is_setcsr;
    top->instr3_wren=reqs[II_upper][3].rT_en || reqs[II_upper][3].rT_enF;
    top->instr3_IPOff=reqs[II_upper][3].IPoff+reqs[II_upper][3].len;
    top->instr3_magic=reqs[II_upper][3].len;
    top->instr3_last=reqs[II_upper][3].en && !reqs[II_upper][3].en;
    //top->instr3_after_spec=
    top->instr4_en=reqs[II_upper][4].en && reqs[II_upper][4].rT_en | 
	    reqs[II_upper][4].rT_enF | reqs[II_upper][4].fl_wr |
	    reqs[II_upper][4].is_indir | reqs[II_upper][4].is_setcsr;
    top->instr4_wren=reqs[II_upper][4].rT_en || reqs[II_upper][4].rT_enF;
    top->instr4_IPOff=reqs[II_upper][4].IPoff+reqs[II_upper][4].len;
    top->instr4_magic=reqs[II_upper][4].len;
    top->instr4_last=reqs[II_upper][4].en && !reqs[II_upper][4].en;
    //top->instr4_after_spec=
    top->instr5_en=reqs[II_upper][5].en && reqs[II_upper][5].rT_en | 
	    reqs[II_upper][5].rT_enF | reqs[II_upper][5].fl_wr |
	    reqs[II_upper][5].is_indir | reqs[II_upper][5].is_setcsr;
    top->instr5_wren=reqs[II_upper][5].rT_en || reqs[II_upper][5].rT_enF;
    top->instr5_IPOff=reqs[II_upper][5].IPoff+reqs[II_upper][5].len;
    top->instr5_magic=reqs[II_upper][5].len;
    top->instr5_last=reqs[II_upper][5].en && !reqs[II_upper][5].en;
    //top->instr5_after_spec=
    top->instr6_en=reqs[II_upper][6].en && reqs[II_upper][6].rT_en | 
	    reqs[II_upper][6].rT_enF | reqs[II_upper][6].fl_wr |
	    reqs[II_upper][6].is_indir | reqs[II_upper][6].is_setcsr;
    top->instr6_wren=reqs[II_upper][6].rT_en || reqs[II_upper][6].rT_enF;
    top->instr6_IPOff=reqs[II_upper][6].IPoff+reqs[II_upper][6].len;
    top->instr6_magic=reqs[II_upper][6].len;
    top->instr6_last=reqs[II_upper][6].en && !reqs[II_upper][6].en;
    //top->instr6_after_spec=
    top->instr7_en=reqs[II_upper][7].en && reqs[II_upper][7].rT_en | 
	    reqs[II_upper][7].rT_enF | reqs[II_upper][7].fl_wr |
	    reqs[II_upper][7].is_indir | reqs[II_upper][7].is_setcsr;
    top->instr7_wren=reqs[II_upper][7].rT_en || reqs[II_upper][7].rT_enF;
    top->instr7_IPOff=reqs[II_upper][7].IPoff+reqs[II_upper][7].len;
    top->instr7_magic=reqs[II_upper][7].len;
    top->instr7_last=reqs[II_upper][7].en && !reqs[II_upper][7].en;
    //top->instr7_after_spec=
    top->instr8_en=reqs[II_upper][8].en && reqs[II_upper][8].rT_en | 
	    reqs[II_upper][8].rT_enF | reqs[II_upper][8].fl_wr |
	    reqs[II_upper][8].is_indir | reqs[II_upper][8].is_setcsr;
    top->instr8_wren=reqs[II_upper][8].rT_en || reqs[II_upper][8].rT_enF;
    top->instr8_IPOff=reqs[II_upper][8].IPoff+reqs[II_upper][8].len;
    top->instr8_magic=reqs[II_upper][8].len;
    top->instr8_last=reqs[II_upper][8].en && !reqs[II_upper][8].en;
    //top->instr8_after_spec=
    top->instr9_en=reqs[II_upper][9].en && reqs[II_upper][9].rT_en | 
	    reqs[II_upper][9].rT_enF | reqs[II_upper][9].fl_wr |
	    reqs[II_upper][9].is_indir | reqs[II_upper][9].is_setcsr;
    top->instr9_wren=reqs[II_upper][9].rT_en || reqs[II_upper][9].rT_enF;
    top->instr9_IPOff=reqs[II_upper][9].IPoff+reqs[II_upper][9].len;
    top->instr9_magic=reqs[II_upper][9].len;
    top->instr9_last=reqs[II_upper][9].en && !reqs[II_upper][9].en;
    //top->instr9_after_spec=
}

int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);
    Vcntrl_find_outcome *top=new Vcntrl_find_outcome();
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
