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
#include "../inc/cjump.h"


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
  unsigned char is_jcsr;
  unsigned char fl_wr;
  unsigned char flag;
  unsigned char flag_in;
  unsigned char len;
  unsigned char is_setcsr;
  unsigned char is_tkn;
  unsigned char is_mispr;
  unsigned char is_aspc;
  unsigned char jtype;
  unsigned char sched;
  unsigned char en;
  unsigned short rT_reg;
  unsigned short IPoff;
  unsigned long target;
  unsigned long xtarget;
  unsigned long IP;
};

insn reqs[48][10]={};
int ii_upper;
int ii_ret;
struct str_exc {
    unsigned long long target;
    bool is_exc;
};
str_exc req_ex[48];

void gen_bndl(insn reqs[10],&str_exc req_ex,int exc,unsigned long &baseIP,unsigned int &IPoff,unsigned char &flg) {
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
	    if (reqs[n].is_indir) reqs[n].is_jcsr=!(lrand48()%3);
	    reqs[n].jtype=lrand48()%17;
	    reqs[n].IP=IP;
	    do {
		reqs[n].target=lrand48()&0xffffffffffe|((lrand48()&0xfffff)<<44);
	    } while ((reqs[n].target&0x1e)==0x1e);
//	    reqs[n].after_tick=(has_tick && n>=tick);

	    reqs[n].xtarget=reqs[n].target;
	    reqs[n].IPoff=IPoff;
	    reqs[n].len=(lrand48()%5+1)<<1;
	    IP+=reqs[n].len;
	    IPoff+=reqs[n].len;
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
	    if ((tkn0!=cjump(reqs[n].jtype,reqs[n].flags_in)) ||
	        (reqs[n].is_indir && !(lrand48()%53))) {
		reqs[n].is_mispr=1;
		if (tkn0) req_ex.target=reqs[n].IP+reqs[n].len;
		else req_ex.target=reqs[n].target;
		if (reqs[n].is_indir) {
		    reqs[n].xtarget=lrand48()&0xffffffffffe|((lrand48()&0xfffff)<<44);
		    if (reqs[n].is_jcsr) reqs[n].xtarget=(reqs[n].xtarget&0xfffffffffff)|
		    (reqs[n].IP&0xfffff00000000000);
		    req_ex.target=reqs[n].xtarget;
		}
		req_ex.is_exc=1;
	    }
	} else if (jcnt&&n==jpos1) {
	    reqs[n].is_jump=1;
	    reqs[n].is_tkn=tkn1;
	    reqs[n].is_indir=(lrand48()%2)&jalu1;
	    if (!tkn1 || (jalu0 && cnt==10) ) reqs[n].is_indir=0;
	    if (!reqs[n].is_indir) reqs[n].is_setcsr=(lrand48()%2)&jalu1;
	    if (!tkn1 || reqs[n].is_indir) reqs[n].is_setcsr=0;
	    if (reqs[n].is_indir) reqs[n].is_jcsr=!(lrand48()%3);
	    reqs[n].jtype=lrand48()%17;
	    reqs[n].IP=IP;
	    do {
		reqs[n].target=lrand48()&0xffffffffffe|((lrand48()&0xfffff)<<44);
	    } while ((reqs[n].target&0x1e)==0x1e);
//	    reqs[n].after_tick=(has_tick && n>=tick);
	    
	    reqs[n].xtarget=reqs[n].target;
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
	    if ((!req_ex.is_exc) && ( (tkn1!=cjump(reqs[n].jtype,reqs[n].flags_in)) ||
	        (reqs[n].is_indir && !(lrand48()%53)))) {
		reqs[n].is_mispr=1;
		if (tkn0) req_ex.target=reqs[n].IP+reqs[n].len;
		else req_ex.target=reqs[n].target;
		if (reqs[n].is_indir) {
		    reqs[n].xtarget=lrand48()&0xffffffffffe|((lrand48()&0xfffff)<<44);
		    if (reqs[n].is_jcsr) reqs[n].xtarget=(reqs[n].xtarget&0xfffffffffff)|
		    (reqs[n].IP&0xfffff00000000000);
		    req_ex.target=reqs[n].xtarget;
		}
		req_ex.is_exc=1;
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
	    reqs[n].is_aspc=lrand48()&1;
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
    static unsigned II_upper=0;
    unsigned n;
    top->new_en=reqs[II_upper][0].en;
    top->new_thread=0;
    top->new_addr=II_upper;
    top->instr0_en=reqs[II_upper][0].en && reqs[II_upper][0].rT_en | 
	    reqs[II_upper][0].rT_enF | reqs[II_upper][0].fl_wr |
	    reqs[II_upper][0].is_indir | reqs[II_upper][0].is_setcsr;
    top->instr0_wren=reqs[II_upper][0].rT_en || reqs[II_upper][0].rT_enF;
    top->instr0_IPOff=reqs[II_upper][0].IPoff+reqs[II_upper][0].len;
    top->instr0_magic=reqs[II_upper][0].len;
    top->instr0_last=reqs[II_upper][0].en && !reqs[II_upper][0].en;
    top->instr0_after_spec=reqs[II_upper][0].is_aspc;
    top->instr1_en=reqs[II_upper][1].en && reqs[II_upper][1].rT_en | 
	    reqs[II_upper][1].rT_enF | reqs[II_upper][1].fl_wr |
	    reqs[II_upper][1].is_indir | reqs[II_upper][1].is_setcsr;
    top->instr1_wren=reqs[II_upper][1].rT_en || reqs[II_upper][1].rT_enF;
    top->instr1_IPOff=reqs[II_upper][1].IPoff+reqs[II_upper][1].len;
    top->instr1_magic=reqs[II_upper][1].len;
    top->instr1_last=reqs[II_upper][1].en && !reqs[II_upper][1].en;
    top->instr1_after_spec=reqs[II_upper][1].is_aspc;
    top->instr2_en=reqs[II_upper][2].en && reqs[II_upper][2].rT_en | 
	    reqs[II_upper][2].rT_enF | reqs[II_upper][2].fl_wr |
	    reqs[II_upper][2].is_indir | reqs[II_upper][2].is_setcsr;
    top->instr2_wren=reqs[II_upper][2].rT_en || reqs[II_upper][2].rT_enF;
    top->instr2_IPOff=reqs[II_upper][2].IPoff+reqs[II_upper][2].len;
    top->instr2_magic=reqs[II_upper][2].len;
    top->instr2_last=reqs[II_upper][2].en && !reqs[II_upper][2].en;
    top->instr2_after_spec=reqs[II_upper][2].is_aspc;
    top->instr3_en=reqs[II_upper][3].en && reqs[II_upper][3].rT_en | 
	    reqs[II_upper][3].rT_enF | reqs[II_upper][3].fl_wr |
	    reqs[II_upper][3].is_indir | reqs[II_upper][3].is_setcsr;
    top->instr3_wren=reqs[II_upper][3].rT_en || reqs[II_upper][3].rT_enF;
    top->instr3_IPOff=reqs[II_upper][3].IPoff+reqs[II_upper][3].len;
    top->instr3_magic=reqs[II_upper][3].len;
    top->instr3_last=reqs[II_upper][3].en && !reqs[II_upper][3].en;
    top->instr3_after_spec=reqs[II_upper][3].is_aspc;
    top->instr4_en=reqs[II_upper][4].en && reqs[II_upper][4].rT_en | 
	    reqs[II_upper][4].rT_enF | reqs[II_upper][4].fl_wr |
	    reqs[II_upper][4].is_indir | reqs[II_upper][4].is_setcsr;
    top->instr4_wren=reqs[II_upper][4].rT_en || reqs[II_upper][4].rT_enF;
    top->instr4_IPOff=reqs[II_upper][4].IPoff+reqs[II_upper][4].len;
    top->instr4_magic=reqs[II_upper][4].len;
    top->instr4_last=reqs[II_upper][4].en && !reqs[II_upper][4].en;
    top->instr4_after_spec=reqs[II_upper][4].is_aspc;
    top->instr5_en=reqs[II_upper][5].en && reqs[II_upper][5].rT_en | 
	    reqs[II_upper][5].rT_enF | reqs[II_upper][5].fl_wr |
	    reqs[II_upper][5].is_indir | reqs[II_upper][5].is_setcsr;
    top->instr5_wren=reqs[II_upper][5].rT_en || reqs[II_upper][5].rT_enF;
    top->instr5_IPOff=reqs[II_upper][5].IPoff+reqs[II_upper][5].len;
    top->instr5_magic=reqs[II_upper][5].len;
    top->instr5_last=reqs[II_upper][5].en && !reqs[II_upper][5].en;
    top->instr5_after_spec=reqs[II_upper][5].is_aspc;
    top->instr6_en=reqs[II_upper][6].en && reqs[II_upper][6].rT_en | 
	    reqs[II_upper][6].rT_enF | reqs[II_upper][6].fl_wr |
	    reqs[II_upper][6].is_indir | reqs[II_upper][6].is_setcsr;
    top->instr6_wren=reqs[II_upper][6].rT_en || reqs[II_upper][6].rT_enF;
    top->instr6_IPOff=reqs[II_upper][6].IPoff+reqs[II_upper][6].len;
    top->instr6_magic=reqs[II_upper][6].len;
    top->instr6_last=reqs[II_upper][6].en && !reqs[II_upper][6].en;
    top->instr6_after_spec=reqs[II_upper][6].is_aspc;
    top->instr7_en=reqs[II_upper][7].en && reqs[II_upper][7].rT_en | 
	    reqs[II_upper][7].rT_enF | reqs[II_upper][7].fl_wr |
	    reqs[II_upper][7].is_indir | reqs[II_upper][7].is_setcsr;
    top->instr7_wren=reqs[II_upper][7].rT_en || reqs[II_upper][7].rT_enF;
    top->instr7_IPOff=reqs[II_upper][7].IPoff+reqs[II_upper][7].len;
    top->instr7_magic=reqs[II_upper][7].len;
    top->instr7_last=reqs[II_upper][7].en && !reqs[II_upper][7].en;
    top->instr7_after_spec=reqs[II_upper][7].is_aspc;
    top->instr8_en=reqs[II_upper][8].en && reqs[II_upper][8].rT_en | 
	    reqs[II_upper][8].rT_enF | reqs[II_upper][8].fl_wr |
	    reqs[II_upper][8].is_indir | reqs[II_upper][8].is_setcsr;
    top->instr8_wren=reqs[II_upper][8].rT_en || reqs[II_upper][8].rT_enF;
    top->instr8_IPOff=reqs[II_upper][8].IPoff+reqs[II_upper][8].len;
    top->instr8_magic=reqs[II_upper][8].len;
    top->instr8_last=reqs[II_upper][8].en && !reqs[II_upper][8].en;
    top->instr8_after_spec=reqs[II_upper][8].is_aspc;
    top->instr9_en=reqs[II_upper][9].en && reqs[II_upper][9].rT_en | 
	    reqs[II_upper][9].rT_enF | reqs[II_upper][9].fl_wr |
	    reqs[II_upper][9].is_indir | reqs[II_upper][9].is_setcsr;
    top->instr9_wren=reqs[II_upper][9].rT_en || reqs[II_upper][9].rT_enF;
    top->instr9_IPOff=reqs[II_upper][9].IPoff+reqs[II_upper][9].len;
    top->instr9_magic=reqs[II_upper][9].len;
    top->instr9_last=reqs[II_upper][9].en && !reqs[II_upper][9].en;
    top->instr9_after_spec=reqs[II_upper][9].is_aspc;
    
    top->instr0_rT=reqs[II_upper][0].rT;
    top->instr1_rT=reqs[II_upper][1].rT;
    top->instr2_rT=reqs[II_upper][2].rT;
    top->instr3_rT=reqs[II_upper][3].rT;
    top->instr4_rT=reqs[II_upper][4].rT;
    top->instr5_rT=reqs[II_upper][5].rT;
    top->instr6_rT=reqs[II_upper][6].rT;
    top->instr7_rT=reqs[II_upper][7].rT;
    top->instr8_rT=reqs[II_upper][8].rT;
    top->instr9_rT=reqs[II_upper][9].rT;
    
    top->instr0_gen=reqs[II_upper][0].rT_en;
    top->instr1_gen=reqs[II_upper][1].rT_en;
    top->instr2_gen=reqs[II_upper][2].rT_en;
    top->instr3_gen=reqs[II_upper][3].rT_en;
    top->instr4_gen=reqs[II_upper][4].rT_en;
    top->instr5_gen=reqs[II_upper][5].rT_en;
    top->instr6_gen=reqs[II_upper][6].rT_en;
    top->instr7_gen=reqs[II_upper][7].rT_en;
    top->instr8_gen=reqs[II_upper][8].rT_en;
    top->instr9_gen=reqs[II_upper][9].rT_en;
   
    top->instr0_vec=reqs[II_upper][0].rT_enF; 
    top->instr1_vec=reqs[II_upper][1].rT_enF; 
    top->instr2_vec=reqs[II_upper][2].rT_enF; 
    top->instr3_vec=reqs[II_upper][3].rT_enF; 
    top->instr4_vec=reqs[II_upper][4].rT_enF; 
    top->instr5_vec=reqs[II_upper][5].rT_enF; 
    top->instr6_vec=reqs[II_upper][6].rT_enF; 
    top->instr7_vec=reqs[II_upper][7].rT_enF; 
    top->instr8_vec=reqs[II_upper][8].rT_enF; 
    top->instr9_vec=reqs[II_upper][9].rT_enF; 
    top->iret0=0xf; 
    top->iret1=0xf; 
    top->iret2=0xf; 
    top->iret3=0xf; 
    top->iret4=0xf; 
    top->iret5=0xf; 
    top->iret6=0xf; 
    top->iret7=0xf; 
    top->iret8=0xf; 
    for(n=0;n<10;n++) {
        if (reqs[II_upper][n].rT_en||reqs[II_upper][n].rT_enF||
        reqs[II_upper][n].fl_wr||reqs[II_upper][n].is_indir||
        reqs[II_upper][n].is_setcsr) {
            switch (reqs[II_upper][n].rT_reg&0xf) {
                case 0: top->iret0=n; top->iret0_rF=reqs[II_upper][n].rT_reg>>4; break;
                case 1: top->iret1=n; top->iret1_rF=reqs[II_upper][n].rT_reg>>4; break;
                case 2: top->iret2=n; top->iret2_rF=reqs[II_upper][n].rT_reg>>4; break;
                case 3: top->iret3=n; top->iret3_rF=reqs[II_upper][n].rT_reg>>4; break;
                case 4: top->iret4=n; top->iret4_rF=reqs[II_upper][n].rT_reg>>4; break;
                case 5: top->iret5=n; top->iret5_rF=reqs[II_upper][n].rT_reg>>4; break;
                case 6: top->iret6=n; top->iret6_rF=reqs[II_upper][n].rT_reg>>4; break;
                case 7: top->iret7=n; top->iret7_rF=reqs[II_upper][n].rT_reg>>4; break;
                case 8: top->iret8=n; top->iret8_rF=reqs[II_upper][n].rT_reg>>4; break;
            }
        }
    }
    for(n=0;n<10;n++) {
        if (reqs[II_upper][n].is_tkn) {
            top->itk_after=(0x3ff<<(n+1))&0x3ff;
            break;
        }
    }
    top->ijump0Off=0xf;
    top->ijump1Off=0xf;
    top->flTE=0x9;
    for(n=0;n<10;n++) {
        if (reqs[II_upper][n].is_jump) {
            if (top->ijump0Off==0xf) {
                top->ijump0Off=n;
                top->ijump0Type=reqs[II_upper][n].jtype;
                if (reqs[II_upper][n].is_indir)  top->ijump0Type=0x11;
                if (reqs[II_upper][n].is_setcsr) top->ijump0Type=0x19;
                top->ijump0JmpInd=n&0x3;
                top->ijump0Mask=(0xf<<(n&0x3))&0xf;
                top->ijump0IP=reqs[II_upper][n].target&0xfffffffffff;
                top->ijump0BND=reqs[II_upper][n].target>>44;
            } else {
                top->ijump1Off=n;
                top->ijump1Type=reqs[II_upper][n].jtype;
                if (reqs[II_upper][n].is_indir)  top->ijump1Type=0x11;
                if (reqs[II_upper][n].is_setcsr) top->ijump1Type=0x19;
                top->ijump1JmpInd=n&0x3;
                top->ijump1Mask=(0xf<<(n&0x3))&0xf;
                top->ijump1IP=reqs[II_upper][n].target&0xfffffffffff;
                top->ijump1BND=reqs[II_upper][n].target>>44;
            }
        }
    }    
    if (top->doStall) return;
    II_upper++;
    for(n=0;n<10;n++) reqs[II_upper][n].sched++;
    if (II_upper>47) II_upper=0;
}

void sched_load(Vcntrl_find_outcome *top, int &err, bool exc) {
    static unsigned ii=0;
    int k;
    top->mem_II_upper=ii;
    top->mem_II_bits_ldconfl=0;
    //top->mem_II_bits_smpconfl=0;
    top->mem_II_bits_except=0;
    top->mem_II_bits_fine=0;
    top->mem_II_bits_ret=0;
    for(k=0;k<10;k++) {
        if (reqs[ii][k].is_ldpass || !reqs[ii][k].is_load) continue;
        if (reqs[ii][k].is_ldconfl) top->mem_II_bits_ldconfl|=1<<k;
        //if (reqs[ii][k].is_smpconfl) top->mem_II_bits_smpconfl|=1<<k;
        if (reqs[ii][k].is_ldexc) top->mem_II_bits_except|=1<<k;
        if (!reqs[ii][k].is_ldconfl && !reqs[ii][k].is_smpconfl && !reqs[ii][k].is_ldexc) 
        top->mem_II_bits_fine|=1<<k;
        top->mem_II_bits_ret|=1<<k;
    }
    top->eval();
    if (top->doRetire_d) {
        for(k=0;k<10;k++) {
            reqs[ii][k].en=0;
        }
        ii++;
        if (ii>47) ii=0;
    }
    if (top->except) {
	int k2,k3,k34;
	for(k2=0;k2==47;k2++) {
	    k3=ii+k;
	    if (k3>47) k3-=48;
	    if (reqs[k3][0].en) {
	        for(k34=0;k34<10;k34++) {
	            reqs[k3][k34].en=0;
		}
	    } else {
		ii=k3;
		break;
	    }
	}
    }
}

void sched_ret(Vcntrl_find_outcome *top, int &err, bool exc) {
    int n,ii,rdat;
    int k=0;
    top->ret0_addr=0;
    top->ret0_wen=0;
    top->ret0_data=0;
    top->ret1_addr=0;
    top->ret1_wen=0;
    top->ret1_data=0;
    top->ret2_addr=0;
    top->ret2_wen=0;
    top->ret2_data=0;
    top->ret3_addr=0;
    top->ret3_wen=0;
    top->ret3_data=0;
    top->ret4_addr=0;
    top->ret4_wen=0;
    top->ret4_data=0;
    top->ret5_addr=0;
    top->ret5_wen=0;
    top->ret5_data=0;
    set64i(top->ret5_IP,0);
    top->ret5_IP_en=0;
    seek:
    for(k=0;k<8 && k!=6 && !(lrand48()%11);k++) {
    do {
        ii=lrand48()%48;
        n=lrand48()%10;
    } while(!(reqs[ii][n].en && reqs[ii][n].sched==1) && !(lrand48()%43));
    if (reqs[ii][n].en && reqs[ii][n].sched==1) {
        int k2=k;
        if (reqs[ii][n].is_indir || reqs[ii][n].is_setcsr) k==5;
        if (reqs[ii][n].is_load && !reqs[ii][n].is_ldpass) goto seek;
        if (reqs[ii][n].is_ldpass) { //
            k=6;
	    rdat=reqs[ii][n].is_smpconfl ? 2049+11*8 : 2;
	} else {
	    rdat=2;
            if (reqs[ii][n].fl_wr) rdat|=4|(reqs[ii][n].flag<<3);
            if (reqs[ii][n].is_exc) rdat=1|(reqs[ii][n].exc_vec<<3);
	} 
     //   else k=reqs[ii][n].rT_reg%3+3*(lrand48()%1);
        switch (k) {
            case 0:
            top->ret0_addr=(ii<<4)|n;
            top->ret0_wen=1;
            top->ret0_data=rdat;
            break;
            case 1:
            top->ret1_addr=(ii<<4)|n;
            top->ret1_wen=1;
            top->ret1_data=rdat;
            break;
            case 2:
            top->ret2_addr=(ii<<4)|n;
            top->ret2_wen=1;
            top->ret2_data=rdat;
            break;
            case 3:
            top->ret3_addr=(ii<<4)|n;
            top->ret3_wen=1;
            top->ret3_data=rdat;
            break;
            case 4:
            top->ret4_addr=(ii<<4)|n;
            top->ret4_wen=1;
            top->ret4_data=rdat;
            break;
            case 5:
            top->ret5_addr=(ii<<4)|n;
            top->ret5_wen=1;
            top->ret5_data=rdat;
            set64i(top->ret5_IP,reqs[ii][n].target);
            top->ret5_IP_en=reqs[ii][n].is_indir|reqs[ii][n].is_setcsr;
            break;
            case 6:
            if (!top->ret6_wen) {
                top->ret6_addr=(ii<<4)|n;
                top->ret6_wen=1;
                top->ret6_data=rdat;
                k=k2;
                break;
            }
            case 7:
            top->ret7_addr=(ii<<4)|n;
            top->ret7_wen=1;
            top->ret7_data=rdat;
            break;
        }
    }
    }
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
