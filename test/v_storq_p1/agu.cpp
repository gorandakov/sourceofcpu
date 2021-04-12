#include <cstdio>
#include <cstdlib>
#include <random>
#include "Vstorq_p1.h"
#include "verilated.h"
#include "../inc/struct.h"
#include "../inc/extract.h"
#include "../inc/csrss_no.h"

#define get64(a) ((((unsigned long long) a[1])<<32)|(unsigned long long) a[0])
#define set64i(a,b) a[0]=b;a[1]=b>>32;a[2]=0;
#define elem(A) top->mem_II_bits_##A

#define def_seed 0xbaba1a9a6868

struct lsent {
    unsigned short op;
    unsigned short sh;
    unsigned short sz;
};

lsent load_op[]={
    0x20,0,1,
    0x22,0,2,
    0x24,0,4,
    0x26,0,8,
    0x00,0,16,
    0x02,0,16,
    0x04,0,16,
    0x06,0,10,
    0x08,0,4,
    0x0a,0,4,
    0x0c,0,4,
    0x0e,0,8,
    0x10,0,8,
    0x12,0,8,
    0x14,0,8,
    0x16,0,8,
    0x18,0,16,
    0x1a,0,16,
    0x1c,0,16,
    0x1e,0,17,
    
    0x60,0,1,
    0x62,0,2,
    0x64,0,4,
    0x66,0,8,
    0x40,0,16,
    0x42,0,16,
    0x44,0,16,
    0x46,0,10,
    0x48,0,4,
    0x4a,0,4,
    0x4c,0,4,
    0x4e,0,8,
    0x50,0,8,
    0x52,0,8,
    0x54,0,8,
    0x56,0,8,
    0x58,0,16,
    0x5a,0,16,
    0x5c,0,16,
    0x5e,0,17,
    
    0x160,1,1,
    0x162,1,2,
    0x164,1,4,
    0x166,1,8,
    0x140,1,16,
    0x142,1,16,
    0x144,1,16,
    0x146,1,10,
    0x148,1,4,
    0x14a,1,4,
    0x14c,1,4,
    0x14e,1,8,
    0x150,1,8,
    0x152,1,8,
    0x154,1,8,
    0x156,1,8,
    0x158,1,16,
    0x15a,1,16,
    0x15c,1,16,
    0x15e,1,17,
    
    0x260,2,1,
    0x262,2,2,
    0x264,2,4,
    0x266,2,8,
    0x240,2,16,
    0x242,2,16,
    0x244,2,16,
    0x246,2,10,
    0x248,2,4,
    0x24a,2,4,
    0x24c,2,4,
    0x24e,2,8,
    0x250,2,8,
    0x252,2,8,
    0x254,2,8,
    0x256,2,8,
    0x258,2,16,
    0x25a,2,16,
    0x25c,2,16,
    0x25e,2,17,
    
    0x360,3,1,
    0x362,3,2,
    0x364,3,4,
    0x366,3,8,
    0x340,3,16,
    0x342,3,16,
    0x344,3,16,
    0x346,3,10,
    0x348,3,4,
    0x34a,3,4,
    0x34c,3,4,
    0x34e,3,8,
    0x350,3,8,
    0x352,3,8,
    0x354,3,8,
    0x356,3,8,
    0x358,3,16,
    0x35a,3,16,
    0x35c,3,16,
    0x35e,3,17
};

lsent store_op[]={
    0x21,0,1,
    0x23,0,2,
    0x25,0,4,
    0x27,0,8,
    0x01,0,16,
    0x03,0,16,
    0x05,0,16,
    0x07,0,10,
    0x09,0,8,
    0x0b,0,8,
    0x0d,0,4,
    0x0f,0,4,
    0x11,0,4,
    0x13,0,8,
    0x15,0,16,
    0x17,0,16,
    0x19,0,16,
    0x1b,0,8,
    0x1f,0,17,
    
    0x61,0,1,
    0x63,0,2,
    0x65,0,4,
    0x67,0,8,
    0x41,0,16,
    0x43,0,16,
    0x45,0,16,
    0x47,0,10,
    0x49,0,8,
    0x4b,0,8,
    0x4d,0,4,
    0x4f,0,4,
    0x51,0,4,
    0x53,0,8,
    0x55,0,16,
    0x57,0,16,
    0x59,0,16,
    0x5b,0,8,
    0x5f,0,17,
    
    0x161,1,1,
    0x163,1,2,
    0x165,1,4,
    0x167,1,8,
    0x141,1,16,
    0x143,1,16,
    0x145,1,16,
    0x147,1,10,
    0x149,1,8,
    0x14b,1,8,
    0x14d,1,4,
    0x14f,1,4,
    0x151,1,4,
    0x153,1,8,
    0x155,1,16,
    0x157,1,16,
    0x159,1,16,
    0x15b,1,8,
    0x15f,1,17,
    
    0x261,2,1,
    0x263,2,2,
    0x265,2,4,
    0x267,2,8,
    0x241,2,16,
    0x243,2,16,
    0x245,2,16,
    0x247,2,10,
    0x249,2,8,
    0x24b,2,8,
    0x24d,2,4,
    0x24f,2,4,
    0x251,2,4,
    0x253,2,8,
    0x255,2,16,
    0x257,2,16,
    0x259,2,16,
    0x25b,2,8,
    0x25f,2,17,
    
    0x361,3,1,
    0x363,3,2,
    0x365,3,4,
    0x367,3,8,
    0x341,3,16,
    0x343,3,16,
    0x345,3,16,
    0x347,3,10,
    0x349,3,8,
    0x34b,3,8,
    0x34d,3,4,
    0x34f,3,4,
    0x351,3,4,
    0x353,3,8,
    0x355,3,16,
    0x357,3,16,
    0x359,3,16,
    0x35b,3,8,
    0x35f,3,17
};

class dmigen;

class lsreq {
    public:
    unsigned long vaddr;
    unsigned long base;
    unsigned long index;
    int imm;
    unsigned data[5];
    bool b_ptr,in_ptr;
    unsigned short op;
    unsigned short II,LSQ,WQ,bytes,reg_no;
    unsigned depb[3];
    bool en;
    char sched;
    bool discarded,kmode,sys_kmode,oor,flag;
    bool chk(dmigen &gen,unsigned mop[],unsigned short lsq,
      unsigned short ret,bool *err);
    void poke(dmigen gen, unsigned mop[]);
    void poke2(char * data1);
    unsigned dep(lsreq *req);
} reqs[64][6]={0};

class dmigen {
    public:
    unsigned long *rng_addr;
    unsigned long *rng_size;
    unsigned short *rng_perm;
    unsigned rng_cnt;
    unsigned char *mem;
    unsigned char *cache;
    unsigned long mem_sz;
    unsigned long ptbl_off;
    unsigned char II,LSQ,WQ,POS;
    bool kmode;
    void gen_ptbl();
    bool gen_bndl(lsreq reqs[6],Vstorq_p1 *top, bool no_alloc);
    unsigned long get_phys(unsigned long virt);
} gen;

void dmigen::gen_ptbl() {
    unsigned long brk=ptbl_off+16384,off,back=ptbl_off-8192;
    int n,n1,n2;
    memset(mem+ptbl_off,16384,0);
    for(n=0;n<rng_cnt;n++) {
        unsigned long addr=rng_addr[n];
        for(n1=0;n1<rng_size[n];n1++) {
            unsigned long pe,*ppe,val;
            ppe=(unsigned long *) (mem+ptbl_off+((addr>>30)&0x3ff8ul));
            pe=*ppe;
            extract(pe,page_na,val);
            if (!val) {
                off=brk;
                brk+=8192;
                pe=(off&0xffffffffffffe000ul)|(rng_perm[n]&0xfffu);//huge pages??
                *ppe=pe;
            }
            ppe=(unsigned long *) (mem+(pe&0xfffffffe000ull)+((addr>>20)&0x1ff8ul));
            pe=*ppe;
            extract(pe,page_na,val);
            if (rng_perm[n]&0x8000u) { //huge page
                printf("huge pages not yet supp\n");
                exit(1);
            }
            if (!val) {
                off=brk;
                brk+=8192;
                pe=(off&0xffffffffffffe000ul)|(rng_perm[n]&0xfffu);
                *ppe=pe;
            }
            ppe=(unsigned long *) (mem+(pe&0xfffffffe000ull)+((addr>>10)&0x1ff8ul));
            pe=*ppe;
            extract(pe,page_na,val);
            if ((!val) && !(rng_perm[n]&0x2000)) {
                off=back;
                back-=8192;
                pe=(off&0xffffffffffffe000ul)|(rng_perm[n]&0xfffu);
                *ppe=pe;
                addr+=8192;
		for(n2=0;n2<2048;n2++) {
		    unsigned *ptr;
		    ptr=(unsigned *) (mem + off + n2*4);
		    *ptr=lrand48();
		}
            } else if (!val) {
                off=0xc0000000000ul;
                pe=(off&0xffffffffffffe000ul)|(rng_perm[n]&0xfffu);
                *ppe=pe;
                addr+=8192;
            }
        }
    }
}

void do_discard() {
    int n,n2;
    for(n=0;n<64;n++) {
	for(n2=0;n2<6;n2++) {
	    reqs[n][n2].en=0;//switching to cisc
	}
    }
}

bool has_req() {
    int n,n2;
    for(n=0;n<64;n++) {
	for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en&&(reqs[n][n2].op&1)&&reqs[n][n2].sched<11) return true;//switching to cisc
	}
    }
    for(n=0;n<64;n++) {
	for(n2=0;n2<6;n2++) {
	    reqs[n][n2].en=0;//switching to cisc
	}
    }
    return false;
}

unsigned lsreq::dep(lsreq *req) {
    unsigned char bnk=0;

    if (!(op&1) || !en) return 0;
    if (!(req->vaddr>=vaddr && req->vaddr<(vaddr+bytes)) &&
        !((req->vaddr+req->bytes-1)>=vaddr && (req->vaddr+req->bytes-1)<(vaddr+bytes))) {
        return 0;
    }
    if (vaddr==req->vaddr && bytes==req->bytes) return 1;
    if ((bytes&0x3)==0 && (vaddr&0x3)==0 && (req->bytes==1 || (req->bytes==2 &&
        (req->vaddr&0x3)!=3))) return 1|((req->vaddr-vaddr)<<8);
    if ((bytes&3)==0 && (req->bytes&3)==0 && (vaddr&3)==(req->vaddr&3)) {
        bnk=req->vaddr>=vaddr && req->vaddr<(vaddr+bytes);
        bnk=(req->vaddr+4)>=vaddr && (req->vaddr+4)<(vaddr+bytes) && req->bytes>4;
        bnk=(req->vaddr+8)>=vaddr && (req->vaddr+8)<(vaddr+bytes) && req->bytes>8;
        bnk=(req->vaddr+12)>=vaddr && (req->vaddr+12)<(vaddr+bytes) && req->bytes>12;
        if (req->vaddr>=vaddr) {
            return 2|((req->vaddr-vaddr)<<8)|(bnk<<16);
        } else {
            return 2|((vaddr-req->vaddr)<<8)|(bnk<<16)|0x4000;
        } 
    }
    if ((req->vaddr>=vaddr && req->vaddr<(vaddr+bytes)) ||
        ((req->vaddr+req->bytes-1)>=vaddr && (req->vaddr+req->bytes-1)<(vaddr+bytes))) {
        return 3;
    }
    return 0;
}

//exc=exc!=switc to riscv
bool sched(Vstorq_p1 *top, int exc, bool &retired) {
    unsigned n,n2,m,m2,m3,a,b=0,p;
    unsigned vals[6];
    unsigned long val,ind,ii;
    bool found=false;
    static bool bhold,stall,st1,st2,st3;
    static char wrsst[3];
    static bool FU0Hit[5],FU1Hit[5],FU2Hit[5],FU3Hit[5];
    static unsigned LS_pos0,LS_pos,LSJ_pos0,LSJ_pos;
    static unsigned inspos;
    static unsigned inspos2;  
    static unsigned iaddr[3];  
    unsigned pdat[3][6];
    static unsigned rdat[2][6];
    static unsigned rcmp[4];
    static unsigned rcmpr1[4];
    static unsigned rcmpr2[4];
    static unsigned deps[6][3];
    static unsigned depsr1[6][3];
    static unsigned depsr2[6][3];
    static bool ldone[2],new_enP,new_enPr1;
    static unsigned confl_cnt,confl_first,confl_last;
    bool ret;

    retired=0;
    ret=0;
    if (confl_cnt==0) confl_cnt=1;
    top->lStall=(lrand48()%13)==2;
    top->eval();
    if (top->std_hasA0) {
        retired=1;
        if (top->lStall) { 
            ret=true;
            printf("A0 durnig lstall\n");
        }
        if (ldone[0]) {
            ret=true;
            printf("A0 rpt\n");
        }
        if (!top->std_MexactA0 && !top->std_byBankA0) {
            if (!depsr2[0][0]&&!depsr2[0][1]&&!depsr2[0][2]&&!top->std_hasA1)
                goto do_B0;
        }
        if (top->std_MexactA0 && (rcmpr2[0]&0xff)==1) {
            if (top->std_MshiftA0==((rcmpr2[0]&0xff00)>>8))
                goto do_B0;
            ret=true;
        }
        if (top->std_MexactA0 || (rcmpr2[0]&0xff)==1) {
            ret=true;
            printf("MexactA0 error\n");
        } else if (top->std_byBankA0) {
            if ((top->std_MshiftA0&0x1f)!=((rcmpr2[0]&0xff00)>>8)) {
                ret=true;
                printf("bybankA0 shift\n");
            }
            if (!((top->std_MshiftA0&0x20)&&(rcmpr2[0]&0xff)==3) &&
                !(!(top->std_MshiftA0&0x20)&&(rcmpr2[0]&0xff)==2)) {
                ret=true;
                printf("bybankA0 sdir\n");
            }
            if (top->std_banksA0!=((rcmpr2[0]&0xff0000)>>16)) {
                ret=true;
                printf("bybankA0 bnk\n");
            }
        } else if (top->std_hasA1) {
            ret=true;
            printf("bybankA0;1 nowait\n");
        } else if ((rcmpr2[0]&0xff)!=0) {
        }
        if (!top->std_hasA1) {
            if (!depsr2[1][0]&&!depsr2[1][1]&&!depsr2[1][2]) goto do_B0;
            ret=true;
            printf("noWaitA1\n");
        }
        if (top->std_MexactA1 && (rcmpr2[1]&0xff)==1) {
            if (top->std_MshiftA1==((rcmpr2[1]&0xff00)>>8))
                goto do_B0;
            ret=true;
        }
        if (top->std_MexactA1 || (rcmpr2[1]&0xff)==1) {
            ret=true;
            printf("MexactA1 error\n");
        } else if (top->std_byBankA1) {
            if ((top->std_MshiftA1&0x1f)!=((rcmpr2[1]&0xff00)>>8)) {
                ret=true;
                printf("bybankA1 shift\n");
            }
            if (!((top->std_MshiftA1&0x20)&&(rcmpr2[1]&0xff)==3) &&
                !(!(top->std_MshiftA1&0x20)&&(rcmpr2[1]&0xff)==2)) {
                ret=true;
                printf("bybankA1 sdir\n");
            }
            if (top->std_banksA1!=((rcmpr2[1]&0xff0000)>>16)) {
                ret=true;
                printf("bybankA1 bnk\n");
            }
        } else {
            ret=true;
            printf("nowait2A1\n");
        }
        ldone[0]=true; 
    }
do_B0:
    if (top->std_hasB0) {
        retired=1;
        if (top->lStall || top->lDoStall) { 
            ret=true;
            printf("B0 durnig lstall\n");
        }
        if (ldone[1]) {
            ret=true;
            printf("B0 rpt\n");
        }
        if (!top->std_MexactB0 && !top->std_byBankB0) {
            if (!depsr2[3][0]&&!depsr2[3][1]&&!depsr2[3][2]&&!top->std_hasB1)
                goto do_B0_after;
        }
        if (top->std_MexactB0 && (rcmpr2[2]&0xff)==1) {
            if (top->std_MshiftB0==((rcmpr2[2]&0xff00)>>8))
                goto do_B0_after;
            ret=true;
        }
        if (top->std_MexactB0 || (rcmpr2[2]&0xff)==1) {
            ret=true;
            printf("MexactB0 error\n");
        } else if (top->std_byBankB0) {
            if ((top->std_MshiftB0&0x1f)!=((rcmpr2[2]&0xff00)>>8)) {
                ret=true;
                printf("bybankB0 shift\n");
            }
            if (!((top->std_MshiftB0&0x20)&&(rcmpr2[2]&0xff)==3) &&
                !(!(top->std_MshiftB0&0x20)&&(rcmpr2[2]&0xff)==2)) {
                ret=true;
                printf("bybankB0 sdir\n");
            }
            if (top->std_banksB0!=((rcmpr2[2]&0xff0000)>>16)) {
                ret=true;
                printf("bybankB0 bnk\n");
            }
        } else if (top->std_hasA1) {
            ret=true;
            printf("bybankB0;1 nowait\n");
        } else if ((rcmpr2[2]&0xff)!=0) {
        }
        if (!top->std_hasB1) {
            if (!depsr2[4][0]&&!depsr2[4][1]&&!depsr2[4][2]) goto do_B0_after;
            ret=true;
            printf("noWaitB1\n");
        }
        if (top->std_MexactB1 && (rcmpr2[3]&0xff)==1) {
            if (top->std_MshiftB1==((rcmpr2[3]&0xff00)>>8))
                goto do_B0_after;
            ret=true;
        }
        if (top->std_MexactB1 || (rcmpr2[3]&0xff)==1) {
            ret=true;
            printf("MexactB1 error\n");
        } else if (top->std_byBankB1) {
            if ((top->std_MshiftB1&0x1f)!=((rcmpr2[3]&0xff00)>>8)) {
                ret=true;
                printf("bybankB1 shift\n");
            }
            if (!((top->std_MshiftB1&0x20)&&(rcmpr2[3]&0xff)==3) &&
                !(!(top->std_MshiftB1&0x20)&&(rcmpr2[3]&0xff)==2)) {
                ret=true;
                printf("bybankB1 sdir\n");
            }
            if (top->std_banksB1!=((rcmpr2[3]&0xff0000)>>16)) {
                ret=true;
                printf("bybankB1 bnk\n");
            }
        } else {
            ret=true;
            printf("nowait2B1\n");
        }
        ldone[1]=true; 
    }
do_B0_after:
    if (top->lDoStall || top->lStall) {
        goto do_nChNext;
    }

    ldone[0]=false;
    ldone[1]=false;

    top->new_conflictx[0]=deps[2][0];
    top->new_conflictx[1]=deps[2][1];
    top->new_conflictx[2]=deps[2][2];
    top->new_conflicty[0]=deps[5][0];
    top->new_conflicty[1]=deps[5][1];
    top->new_conflicty[2]=deps[5][2];
    top->new_conflictA[0]=deps[0][0];
    top->new_conflictA[1]=deps[0][1];
    top->new_conflictA[2]=deps[0][2];
    top->new_conflictA_b=(((deps[0][0]&0xff)!=0))|(((deps[0][0]&0xff00)!=0)<<1)|
        (((deps[0][0]&0xff0000)!=0)<<2)|(((deps[0][0]&0xff000000u)!=0)<<3)|
        (((deps[0][1]&0xff)!=0)<<4)|(((deps[0][1]&0xff00)!=0)<<5)|
        (((deps[0][1]&0xff0000)!=0)<<6)|(((deps[0][1]&0xff000000u)!=0)<<7)|
        (((deps[0][2]&0xff)!=0)<<8)|(((deps[0][2]&0xff00)!=0)<<9)|
        (((deps[0][2]&0xff0000)!=0)<<10)|(((deps[0][2]&0xff000000u)!=0)<<11);
    top->new_conflictA_has=top->new_conflictA_b!=0;
    top->new_conflictB[0]=deps[3][0];
    top->new_conflictB[1]=deps[3][1];
    top->new_conflictB[2]=deps[3][2];
    top->new_conflictB_b=(((deps[3][0]&0xff)!=0))|(((deps[3][0]&0xff00)!=0)<<1)|
        (((deps[3][0]&0xff0000)!=0)<<2)|(((deps[3][0]&0xff000000u)!=0)<<3)|
        (((deps[3][1]&0xff)!=0)<<4)|(((deps[3][1]&0xff00)!=0)<<5)|
        (((deps[3][1]&0xff0000)!=0)<<6)|(((deps[3][1]&0xff000000u)!=0)<<7)|
        (((deps[3][2]&0xff)!=0)<<8)|(((deps[3][2]&0xff00)!=0)<<9)|
        (((deps[3][2]&0xff0000)!=0)<<10)|(((deps[3][2]&0xff000000u)!=0)<<11);
    top->new_conflictB_has=top->new_conflictB_b!=0;

    for(a=0;a<6;a++) {
        top->lstep1_owndataA[a]=rdat[0][a];
        top->lstep1_owndataB[a]=rdat[1][a];
    }

    top->confl_first=confl_first;
    top->confl_last=confl_last;
    top->confl_cnt=confl_cnt;
    top->new_en_reg2<=new_enP;
    top->new_enP_reg2<=1;

    for(a=0;a<6;a++) {
        for(b=0;b<3;b++) {
            depsr2[a][b]=depsr1[a][b];
            depsr1[a][b]=deps[a][b];
            deps[a][b]=0;
        }
    }
    if (LS_pos==6) {
        LS_pos=0;
        LS_pos0=(LS_pos0+1)&0x3f;
    } else if (!reqs[LS_pos0][LS_pos].en && reqs[(LS_pos0+1)&0x3f][0].en) {
        LS_pos=0;
        LS_pos0=(LS_pos0+1)&0x3f;
    }
 //   if (LS_pos==5) n=1;
    n=lrand48()%(6-LS_pos)+1;
    if (LS_pos0==gen.POS || LS_pos0==((LSJ_pos0+47)&0x3f)) n=0;
  //  rcmp[0]=0;
  //  rcmp[1]=0;
   // rcmp[2]=0;
 //   rcmp[3]=0;
    for(a=0;a<4;a++) {
        rcmpr2[a]=rcmpr1[a];
        rcmpr1[a]=rcmp[a];
        rcmp[a]=0;
    }
  //  retired=reqs[LS_pos0][LS_pos].en;
    n2=LS_pos;
    confl_first=0;
    confl_last=0;
    confl_cnt=1;
    m3=0;
    if (found=(reqs[LS_pos0][LS_pos].en) && n) for(n2=LS_pos;n2<(LS_pos+n);n2++) {
        if (reqs[LS_pos0][n2].en && !(reqs[LS_pos0][n2].op&1)) {
            m=LSJ_pos0;
            m2=LSJ_pos;
            if (m3>1) {
                break;
            }
            while (m2!=n2 && m!=n) {
                if (p=reqs[m][m2].dep(&reqs[LS_pos0][n2])) {
                    deps[m3*3+1][0]=deps[m3*3][0];
                    deps[m3*3+1][1]=deps[m3*3][1];
                    deps[m3*3+1][2]=deps[m3*3][2];
                    deps[m3*3][0]=reqs[m][m2].depb[0];
                    deps[m3*3][1]=reqs[m][m2].depb[1];
                    deps[m3*3][2]=reqs[m][m2].depb[2];
                    deps[m3*3+2][0]|=reqs[m][m2].depb[0];
                    deps[m3*3+2][1]|=reqs[m][m2].depb[0];
                    deps[m3*3+2][2]|=reqs[m][m2].depb[0];
                    rcmp[m3*2+1]=rcmp[m3*2];
                    rcmp[m3*2]=p;
                }
                m2++;
                if (m2>5) {
                    m2=0;
                    m=(m+1)&0x3f;
                }
            } 
            reqs[LS_pos0][n2].poke(gen,&rdat[m3][0]);
            m3++;
            //reqs[LS_pos0][n2].en=0;
            if (confl_first) {
                if (deps[m3*3+2][0]||deps[m3*3+2][1]||deps[m3*3+2][2]||
                   reqs[LS_pos0][n2].flag) {
                   confl_first=1<<n2; 
                   confl_cnt=2;
                }
            } else {
                if (deps[m3*3+2][0]||deps[m3*3+2][1]||deps[m3*3+2][2]||
                   reqs[LS_pos0][n2].flag) {
                   confl_last=1<<n2; 
                   confl_cnt=4;
                }
            }
        } else if (reqs[LS_pos0][n2].en) {
            reqs[LS_pos0][n2].depb[inspos2%3]=1<<(iaddr[inspos2%3]++);
            iaddr[inspos2%3]&=0x3f;
            reqs[LS_pos0][n2].poke(gen,&pdat[inspos2++%3][0]);
        }
    }
    for(n=0;n<6;n++) {
        top->pos_dataA0[n]=pdat[0][n];
        top->pos_dataA1[n]=pdat[1][n];
        top->pos_dataA2[n]=pdat[2][n];
    }
    new_enPr1=new_enP;
    if (n2==6 || (found && !reqs[LS_pos0][n2].en)) {
        LS_pos=0;
        LS_pos0=(LS_pos0+1)&0x3f;
        new_enP=1;
    } else {
        LS_pos=n2;
        new_enP=0;
    }
    do_nChNext:
    top->nChNextA0=0;
    top->nChNextA1=0;
    top->nChNextA2=0;
    n=lrand48()%9-6;
    if (n>8) n=0;
    if (abs((int) LS_pos- (int) LSJ_pos)>15) {
        n=lrand48()%3;
    }
    for (n2=0;n2<n;n2++) {
        if (LSJ_pos0==((LS_pos0-16)&0x3f)) {
          // LSJ_pos0=(LSJ_pos0-1)&0x3f;
          // LSJ_pos=5;
           goto end_loop;
        }
        while(!(reqs[LSJ_pos0][LSJ_pos].op&1) || !(reqs[LSJ_pos0][LSJ_pos].en)) {
           reqs[LSJ_pos0][LSJ_pos].en=0;
           if (++LSJ_pos>5) {
               LSJ_pos=0;
               LSJ_pos0=(LSJ_pos0+1)&0x3f;
           }
           if (LSJ_pos0==((LS_pos0-16)&0x3f)) {
               //LSJ_pos0=(LSJ_pos0-1)&0x3f;
               //LSJ_pos=5;
               goto end_loop;
           } 
        }
        top->nChNextA0|=reqs[LSJ_pos0][LSJ_pos].depb[0];
        top->nChNextA1|=reqs[LSJ_pos0][LSJ_pos].depb[1];
        top->nChNextA2|=reqs[LSJ_pos0][LSJ_pos].depb[2];
        reqs[LSJ_pos0][LSJ_pos].en=0;
        if (++LSJ_pos>5) {
            LSJ_pos=0;
            LSJ_pos0=(LSJ_pos0+1)&0x3f;
        }
end_loop:;
    }
    if (((top->lDoStall || top->lStall)  && !top->peek_aStall && !new_enPr1) ) {
        top->new_conflict1_acc[0]|=top->nChNextA0;
        top->new_conflict1_acc[1]|=top->nChNextA1;
        top->new_conflict1_acc[2]|=top->nChNextA2;
    }  else {
        top->new_conflict1_acc[0]=0;
        top->new_conflict1_acc[1]=0;
        top->new_conflict1_acc[2]=0;
    }
    for(a=0;a<6;a++) {
        depsr1[a][0]&=top->nChNextA0;
        depsr1[a][1]&=top->nChNextA1;
        depsr1[a][2]&=top->nChNextA2;
        depsr2[a][0]&=top->nChNextA0;
        depsr2[a][1]&=top->nChNextA1;
        depsr2[a][2]&=top->nChNextA2;
    }
    return ret;
}



bool dmigen::gen_bndl(lsreq reqZ[6],Vstorq_p1 *top,bool no_alloc) {
    unsigned int n,cnt_st=0,rng,pge,sh,a;
    unsigned long addr,val,base,imm,index;
    unsigned cnt=lrand48()%6+1;
    unsigned map_size=0;
    unsigned usb=0;
    static unsigned wrt_pos;
    wrt_pos=0;
    if (no_alloc) {
	//top->bundle_in_reg2=0;
	return false;
    }
    reqZ[0].en=0;
    reqZ[1].en=0;
    reqZ[2].en=0;
    reqZ[3].en=0;
    reqZ[4].en=0;
    reqZ[5].en=0;
    reqZ[0].discarded=0;
    reqZ[1].discarded=0;
    reqZ[2].discarded=0;
    reqZ[3].discarded=0;
    reqZ[4].discarded=0;
    reqZ[5].discarded=0;
    reqZ[0].kmode=0;
    reqZ[1].kmode=0;
    reqZ[2].kmode=0;
    reqZ[3].kmode=0;
    reqZ[4].kmode=0;
    reqZ[5].kmode=0;
    reqZ[0].sys_kmode=0;
    reqZ[1].sys_kmode=0;
    reqZ[2].sys_kmode=0;
    reqZ[3].sys_kmode=0;
    reqZ[4].sys_kmode=0;
    reqZ[5].sys_kmode=0;
    reqZ[0].oor=0;
    reqZ[1].oor=0;
    reqZ[2].oor=0;
    reqZ[3].oor=0;
    reqZ[4].oor=0;
    reqZ[5].oor=0;
    reqZ[0].flag=0;
    reqZ[1].flag=0;
    reqZ[2].flag=0;
    reqZ[3].flag=0;
    reqZ[4].flag=0;
    reqZ[5].flag=0;
    reqZ[0].reg_no=0;
    reqZ[1].reg_no=1;
    reqZ[2].reg_no=5;
    reqZ[3].reg_no=3;
    reqZ[4].reg_no=4;
    reqZ[5].reg_no=8;
    reqZ[0].depb[0]=0;
    reqZ[1].depb[0]=0;
    reqZ[2].depb[0]=0;
    reqZ[3].depb[0]=0;
    reqZ[4].depb[0]=0;
    reqZ[5].depb[0]=0;
    reqZ[0].depb[1]=0;
    reqZ[1].depb[1]=0;
    reqZ[2].depb[1]=0;
    reqZ[3].depb[1]=0;
    reqZ[4].depb[1]=0;
    reqZ[5].depb[1]=0;
    reqZ[0].depb[2]=0;
    reqZ[1].depb[2]=0;
    reqZ[2].depb[2]=0;
    reqZ[3].depb[2]=0;
    reqZ[4].depb[2]=0;
    reqZ[5].depb[2]=0;
    /*top->lsi0_reg=6;
    top->lsi1_reg=6;
    top->lsi2_reg=5;
    deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrtII0,15);
    deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrtII1,15);
    deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrtII2,15);
    deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrt0,7);
    deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrt1,7);
    deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrt2,7);
    deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_used,0);//meaning??
    deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_II,II);
    deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_usedB,0);
    top->bundle_in_reg2=1;
    top->ldq_new_mask_reg=0; */
    for(n=0;n<rng_cnt;n++)
        map_size+=rng_size[n];
    for(n=0;n<cnt;n++) {
        val=lrand48() % map_size;
        for(a=0;a<rng_cnt;a++) {
            if (val<rng_size[a]) {
                rng=a;
                pge=val;
                break;
            } else {
                val-=rng_size[a];
            }
        }
        
        addr=rng_addr[rng]+pge*8192+(lrand48()&0x1fff);
        reqZ[n].vaddr=addr;
        val=lrand48();
        if (val&1) {
            cnt_st++;
            if (cnt_st>3) {
                cnt_st--;
                val=val&0xfffffffeu;
                goto load;
            }
            reqZ[n].op=store_op[(val>>1)%(sizeof store_op/sizeof store_op[0])].op;
            reqZ[n].bytes=store_op[(val>>1)%(sizeof store_op/sizeof store_op[0])].sz;
            sh=store_op[(val>>1)%(sizeof store_op/sizeof store_op[0])].sh;
            reqZ[n].II=(((unsigned)II)<<4)+n;
            reqZ[n].LSQ=(((unsigned) LSQ)<<3)+n;
            reqZ[n].WQ=WQ++;
	    reqZ[n].data[0]=lrand48();
	    reqZ[n].data[1]=lrand48();
	    reqZ[n].data[2]=lrand48();
	    reqZ[n].data[3]=lrand48();
	    reqZ[n].data[4]=lrand48();
/*	    if (top->lsi0_reg==6) {
		top->lsi0_reg=n;
		top->WQS0_reg=reqZ[n].WQ;
	    } else if (top->lsi1_reg==6) {
		top->lsi1_reg=n;
		top->WQS1_reg=reqZ[n].WQ;
	    } else {
		top->lsi2_reg=n;
		top->WQS2_reg=reqZ[n].WQ;
	    }

	    if (wrt_pos==0) {
                deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrt0,n);
                deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrtII0,n);
		wrt_pos++;
	    }
	    else if (wrt_pos==1) {
                deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrt1,n);
                deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrtII1,n);
		wrt_pos++;
	    }
	    else if (wrt_pos==2) {
                deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrt2,n);
                deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_wrtII2,n);
		wrt_pos=0;
	    }*/

	    if (WQ>239) WQ=0;
	    if (!(lrand48()%3)) {
		unsigned D_n=LSQ,D_n1=n;
		do {
	            if ((--D_n1)>6) {
		        D_n1=5;
			D_n--;
			D_n&=0x3f;
		    }

		} while( reqs[D_n][D_n1].en && (!(reqs[D_n][D_n1].op&1)||!(lrand48()&0x1)));
		if (reqs[D_n][D_n1].en && (reqs[D_n][D_n1].op&1)) {
	            addr=reqs[D_n][D_n1].vaddr+lrand48()%31-15;
	            reqZ[n].vaddr=addr;
		}
	    }

        } else {
            load:
            reqZ[n].op=load_op[(val>>1)%(sizeof load_op/sizeof load_op[0])].op;
            reqZ[n].bytes=load_op[(val>>1)%(sizeof load_op/sizeof load_op[0])].sz;
            sh=load_op[(val>>1)%(sizeof load_op/sizeof load_op[0])].sh;
            reqZ[n].II=(((unsigned) II)<<4)+n;
            reqZ[n].LSQ=(((unsigned) LSQ)<<3)+n;
	    reqZ[n].data[0]=0;
	    reqZ[n].data[1]=0;
	    reqZ[n].data[2]=0;
	    reqZ[n].data[3]=0;
	    reqZ[n].data[4]=0;
	    reqZ[n].flag=(lrand48()%7)==1;
	    //top->ldq_new_mask_reg|=1<<n;
	    if (reqZ[n].flag || !(lrand48()%81)) {
		unsigned D_n=LSQ,D_n1=n;
		do {
	            if ((--D_n1)>6) {
		        D_n1=5;
			D_n--;
			D_n&=0x3f;
		    }

		} while( reqs[D_n][D_n1].en && (!(reqs[D_n][D_n1].op&1)||!(lrand48()&0x1)));
		if (reqs[D_n][D_n1].en && (reqs[D_n][D_n1].op&1)) {
	            addr=reqs[D_n][D_n1].vaddr+lrand48()%31-15;
	            reqZ[n].vaddr=addr;
                if (reqZ[n].vaddr<rng_addr[0]) {
                    addr=rng_addr[0];
                    reqZ[n].vaddr=rng_addr[0];
                }
		}
	    }
        }
        if (reqZ[n].II&0xf000) {
            printf("iiness\n");
        }
        base=addr+lrand48()%65536-32768;
        index=(long int) lrand48()%65536-32768;
        if (!(reqZ[n].op&0x40)) index=0;
        imm=addr-base-(index<<sh);
        if (sh==0) {
           // if (((val=lrand48())&0xffu)>128) {
                base|=0xf80ff00000000000;
                reqZ[n].b_ptr=1;
                reqZ[n].in_ptr=0;
           // } else /*if ((val&0xffu))*/ { 
           //     index|=0xf80fe00000000000;
           //     reqZ[n].b_ptr=0;
           //     reqZ[n].in_ptr=1;
           // }
          /*  }  else {
                base|=(lrand48()&0xfffffull)<<44;
                reqZ[n].b_ptr=0;
                reqZ[n].in_ptr=0;
            }*/
        } else {
           // if (lrand48()&0xffu) {
                base|=0xf80ff00000000000;
                reqZ[n].b_ptr=1;
                reqZ[n].in_ptr=0;
          /*  } else {
                index|=(lrand48()&0xfffffull)<<44;
                reqZ[n].b_ptr=0;
                reqZ[n].in_ptr=lrand48()&1;
            }*/
        }
        reqZ[n].base=base;
        reqZ[n].index=index;
        reqZ[n].imm=imm;
        reqZ[n].en=1;
        reqZ[n].sched=0;
	extract(rng_perm[rng],page_sys,val);
	reqZ[n].kmode=val;
	reqZ[n].sys_kmode=kmode;
	if (rng <(rng_cnt-1) && (reqZ[n].vaddr+reqZ[n].bytes-1)>=rng_addr[rng+1]) {
	    extract(rng_perm[rng+1],page_sys,val);
	    if (val) reqZ[n].kmode=1;
	}
	if (rng ==(rng_cnt-1) && (reqZ[n].vaddr+reqZ[n].bytes-1)>(rng_addr[rng]+rng_size[rng]*8192-1)) {
            reqZ[n].oor=1;
	}
	usb=usb|~~((!reqZ[n].flag)<<n);

    }
    //if (cnt) deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_used,(1<<cnt)-1);
    //if (cnt) deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_usedB,usb);
    //reqZ[n].reg_no=n; 
    //top->II_upper=II;
    //top->eval();
   // if (top->doStall) {
//	WQ-=cnt_st;
//	if (WQ>239) WQ+=240;//unsigned magic
//	for(n=0;n<6;n++) reqZ[n].en=0;
//	return false;
//    }*/
    for(n=0;n<cnt;n++) {
	if (gen.get_phys(reqZ[n].vaddr)<0xc0000000000 && !reqZ[n].oor) {
            int bytes1=(reqZ[n].vaddr&0x7f)+reqZ[n].bytes-0x80;
	    if (bytes1<0) bytes1=0;
	    if ((reqZ[n].op&1) && (!reqZ[n].kmode || reqZ[n].sys_kmode) && !reqZ[n].oor) {
	        memcpy(mem+get_phys(reqZ[n].vaddr),(char *) reqZ[n].data,reqZ[n].bytes-bytes1);
		if (bytes1) 
		    memcpy(mem+get_phys(reqZ[n].vaddr+reqZ[n].bytes-bytes1),(char *) reqZ[n].data+reqZ[n].bytes-bytes1,
			bytes1);
	    }
    //    if (bytes1==14 && reqZ==reqs[8] && n==2) printf("memcpy %lx,%lx,%lx\n",(char *) reqZ[n].data+reqZ[n].bytes-bytes1,mem+get_phys(reqZ[n].vaddr+reqZ[n].bytes-bytes1),reqZ[n].vaddr);
	    if (!(reqZ[n].op&1) && (!reqZ[n].kmode || reqZ[n].sys_kmode) && !reqZ[n].oor) {
	        memcpy((char *) reqZ[n].data,mem+get_phys(reqZ[n].vaddr),reqZ[n].bytes-bytes1);
		if (bytes1)
		    memcpy((char *) reqZ[n].data+reqZ[n].bytes-bytes1,mem+get_phys(reqZ[n].vaddr+reqZ[n].bytes-bytes1),bytes1);
	    }
	}
    }
    II++;
    if (cnt) LSQ++;
    if (II>47) II=0;
    LSQ&=0x3f;
    POS=LSQ;
    return true;
}


unsigned long dmigen::get_phys(unsigned long virt) {
    unsigned long pe,*ppe,val,addr=virt;
    ppe=(unsigned long *) (mem+ptbl_off+((addr>>30)&0x3ff8ul));
    pe=*ppe;
    extract(pe,page_na,val);
    if (!val) return 0;
    ppe=(unsigned long *) (mem+(pe&0xfffffffe000ull)+((addr>>20)&0x1ff8ul));
    pe=*ppe;
    extract(pe,page_na,val);
    if (!val) return 0;
    ppe=(unsigned long *) (mem+(pe&0xfffffffe000ull)+((addr>>10)&0x1ff8ul));
    pe=*ppe;
    extract(pe,page_na,val);
    if (!val) return 0;
    return (pe&0xfffffffe000ull)|(addr&0x1fffull);
}

bool can_ins() {
    int n;
    for(n=0;n<6;n++) {
        if (reqs[gen.LSQ][n].en) 
            return false;
    }
    return true;
}


bool lsreq::chk(dmigen &gen,unsigned mop[],unsigned short lsq,
    unsigned short ret,bool *err) {
    bool odd=(vaddr&0x80)>>7;
    bool split=((vaddr&0x7f)+bytes)>0x80;
    unsigned long val,phys=gen.get_phys(vaddr),
		  phys2=gen.get_phys(vaddr+bytes-1);
    extract_e(mop,lsaddr_WQ,val);
    if (val!=WQ && (op&1)) return false;
    extract_e(mop,lsaddr_II,val);
    if (val!=II) {
        printf("II\n");
        return false; 
    }
    //extract_e(mop,lsaddr_LSQ,val);
    if (lsq!=LSQ) return false;
    if ((!sys_kmode && kmode)||oor) {
        if ((ret&3)!=1) *err=1;
    } else {
        if ((ret&3)==1) {
           printf("<cann> %lx\n",vaddr);
	   sleep(1);
	   return true;
	}
    }
    extract_e(mop,lsaddr_addrE,val);
    if ((!odd) && val!=(phys>>8)) *err=1;
    if (odd && split && val!=(phys2>>8)) *err=1;
    extract_e(mop,lsaddr_addrO,val);
    if (odd && val!=(phys>>8)) *err=1;
    if ((!odd) && split && val!=(phys2>>8)) *err=1;
    extract_e(mop,lsaddr_low,val);
    if (val!=(phys&3)) *err=1;
    extract_e(mop,lsaddr_bank0,val);
    if (val!=((phys>>2)&0x1f)) *err=1;
    unsigned banks=0;
    banks|=1u<<((phys>>2)&0x1f);
    if ((phys&0x3)+bytes>4) 
        banks|=1u<<(((phys>>2)+1)&0x1f);
    if ((phys&0x3)+bytes>8) 
        banks|=1u<<(((phys>>2)+2)&0x1f);
    if ((phys&0x3)+bytes>12) 
        banks|=1u<<(((phys>>2)+3)&0x1f);
    if ((phys&0x3)+bytes>16) 
        banks|=1u<<(((phys>>2)+4)&0x1f);
    extract_e(mop,lsaddr_banks,val);
    if (val!=banks) *err=1;
    return true;
}

void lsreq::poke(dmigen gen, unsigned mop[]) {
    unsigned long addr=gen.get_phys(vaddr);
    unsigned long addr2=gen.get_phys(vaddr+bytes-1);
    deposit_e(mop,lsaddr_WQ,WQ);
    deposit_e(mop,lsaddr_II,II);
    deposit_e(mop,lsaddr_reg_hi,0);
    deposit_e(mop,lsaddr_reg_low,0);
    deposit_e(mop,lsaddr_bank0,(vaddr>>2)&0x1f);
    deposit_e(mop,lsaddr_low,vaddr&3);
    deposit_e(mop,lsaddr_odd,(vaddr>>7)&1);
    deposit_e(mop,lsaddr_split,(vaddr>>7)!=((vaddr+bytes-1)>>7));
    deposit_e(mop,lsaddr_sz,(op>>1)&0x1f);
    deposit_e(mop,lsaddr_st,(op&1)&1);
    deposit_e(mop,lsaddr_flag,flag);
    deposit_e(mop,lsaddr_mtype,addr>=0xc0000000000 ? 2 : 0);
    deposit_e(mop,lsaddr_reg_low,reg_no&0xf);
    deposit_e(mop,lsaddr_odd_round,LSQ>>8);
    if (bytes==1) {
	deposit_e(mop,lsaddr_blow,1<<(vaddr&0x3));
    } else if (bytes==2) {
	deposit_e(mop,lsaddr_blow,(1<<(vaddr&0x3))|(1<<((vaddr+1)&0x3)));
    } else {
	deposit_e(mop,lsaddr_blow,0xf);
    }
    if (vaddr&0x40) {
        deposit_e(mop,lsaddr_OH,((vaddr>>7)&1));
        deposit_e(mop,lsaddr_EH,!((vaddr>>7)&1));
        deposit_e(mop,lsaddr_OL,!((vaddr>>7)&1)&&(vaddr>>7)!=((vaddr+bytes-1)>>7));
        deposit_e(mop,lsaddr_EL,((vaddr>>7)&1)&&(vaddr>>7)!=((vaddr+bytes-1)>>7));
    } else {
        deposit_e(mop,lsaddr_OL,((vaddr>>7)&1));
        deposit_e(mop,lsaddr_EL,!((vaddr>>7)&1));
        deposit_e(mop,lsaddr_OH,(vaddr>>7)&1);
        deposit_e(mop,lsaddr_EH,!((vaddr>>7)&1));
    }
    if ((!sys_kmode && kmode)||oor) {
        deposit_e(mop,lsaddr_except,1);
    } else {
        deposit_e(mop,lsaddr_except,0);
    }
    unsigned banks=0;
    banks|=1u<<((addr>>2)&0x1f);
    if ((addr&0x3)+bytes>4) 
        banks|=1u<<(((addr>>2)+1)&0x1f);
    if ((addr&0x3)+bytes>8) 
        banks|=1u<<(((addr>>2)+2)&0x1f);
    if ((addr&0x3)+bytes>12) 
        banks|=1u<<(((addr>>2)+3)&0x1f);
    if ((addr&0x3)+bytes>16) 
        banks|=1u<<(((addr>>2)+4)&0x1f);
    deposit_e(mop,lsaddr_banks,banks);
    if ((vaddr>>7)&1) {
        deposit_e(mop,lsaddr_addrO,addr>>8);
        deposit_e(mop,lsaddr_addrE,addr2>>8);
    } else {
        deposit_e(mop,lsaddr_addrO,addr2>>8);
        deposit_e(mop,lsaddr_addrE,addr>>8);
    }
}



int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);
    Vstorq_p1 *top=new Vstorq_p1();
    Verilated::assertOn(false);
    int initcount=512;
    int cyc=0;
    unsigned exc=0,n;
    unsigned short perm_normal=(1<<(page_na));
    unsigned short perm_io=(1<<(page_na))|(1<<(page_nc))|0x2000;
    unsigned short perm_glob=(1<<(page_na))|(1<<(page_global));
    unsigned short perm_sys=(1<<(page_na))|(1<<(page_sys));
    static unsigned long rng_addr[]={0xdeadc00000,0xdeadc02000,0xdeade02000,0xdeadffe000};
    static unsigned long rng_size[]={1,256,254,1};
    //static unsigned long rng_addr[]={0xdeadc00000,0xdeadc02000,0xdeadc04000,0xdeadc06000};
    //static unsigned long rng_size[]={1,1,1,1};
    static unsigned short rng_perm[]={perm_io,perm_normal,perm_glob,perm_sys};
    unsigned long bndl=0;
    bool err,retired;

    std::mt19937 rndgen(def_seed); 
    std::uniform_int_distribution<unsigned> dist(0,1000);

    srand48(def_seed);
    rndgen.seed();
    gen.rng_addr=rng_addr;
    gen.rng_size=rng_size;
    gen.rng_perm=rng_perm;
    gen.rng_cnt=4;
    gen.kmode=1;
    gen.mem=(unsigned char *)malloc(64*1024*1024);
    gen.cache=(unsigned char *)malloc(64*1024*1024);
    bzero(gen.mem,64*1024*1024);//will port fpc
    gen.ptbl_off=32*1024*1024;
    gen.mem_sz=64*1024*1024;
    gen.II=0;
    gen.LSQ=0;
    gen.WQ=0;
    gen.gen_ptbl();
    memcpy(gen.cache,gen.mem,64*1024*1024);
    top->rst=1;
    top->except=0;
    top->eval();
    top->clk=1;
    top->eval();
    top->rst=0;
    top->confl_cnt=1;
    while (!Verilated::gotFinish()) {
        top->clk=0;
        top->eval();
        top->eval();
        top->clk=1;
        top->eval();
        if (!initcount) {
	   //err=false;
       if (exc) exc--;
	   err=sched(top,exc,retired);
           for(n=0;n<6;n++) if (reqs[gen.POS][n].en) { break; }
           gen.gen_bndl(reqs[gen.POS],top,n!=6 || exc!=0);
       if ((lrand48()%113)==3) {
           exc=10;
 //          purge();
       }
       if (exc==9) do_discard();

	   if (retired) bndl++;
	   if (err) {
	       printf("error @%i\n",cyc);
	       //sleep(1);
	       exit(1);
	   }
        }
        top->eval();
        if (!initcount) {
            if ((cyc%10000)==0) {
                printf("cycle %i,%lu\n",cyc,bndl);
            }
        }

        if (initcount) initcount--;
        cyc++;
    }

}
