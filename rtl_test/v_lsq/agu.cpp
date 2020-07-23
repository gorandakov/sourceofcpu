#include <cstdio>
#include <cstdlib>
#include <random>
#include "Vfun_lsq.h"
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
    bool en;
    char sched;
    bool discarded,kmode,sys_kmode,oor,flag;
    bool chk(dmigen &gen,unsigned mop[],unsigned short lsq,
      unsigned short ret,bool *err);
    void poke(dmigen gen, unsigned mop[]);
    void poke2(char * data1);
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
    bool gen_bndl(lsreq reqs[6],Vfun_lsq *top, bool no_alloc);
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
	    if (!(reqs[n][n2].op&1)||reqs[n][n2].sched<5) reqs[n][n2].en=0;//switching to cisc
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

//exc=exc!=switc to riscv
void sched(Vfun_lsq *top, int exc) {
    unsigned n,n2;
    unsigned vals[6];
    unsigned long val,ind,ii;
    bool found=false;
    static std::mt19937 rndgen(def_seed); 
    static std::uniform_int_distribution<unsigned> dist384(0,383);
    static std::uniform_int_distribution<unsigned> dist192(0,191);
    static std::uniform_int_distribution<unsigned> dist64(0,63);
    static std::uniform_int_distribution<unsigned> dist128(0,127);
    static std::uniform_int_distribution<unsigned> dist16(0,16);
    static bool bhold,stall,st1,st2,st3;
    static int stall_cnt=0;
    static char wrsst[3];
    static bool FU0Hit[5],FU1Hit[5],FU2Hit[5],FU3Hit[5];
   
    static bool p0_en[3],p1_en[3],p2_en[3],p3_en[3],p4_en[3],p5_en[3]; 
    static bool p0_rsEn[3],p1_rsEn[3],p2_rsEn[3],p3_rsEn[3],p4_rsEn[3],p5_rsEn[3]; 
    static unsigned short  p0_LSQ[3],p1_LSQ[3],p2_LSQ[3],p3_LSQ[3],p4_LSQ[3],p5_LSQ[3]; 
    static bool p0_lsfwd[3],p1_lsfwd[3],p2_lsfwd[3],p3_lsfwd[3],p4_lsfwd[3],p5_lsfwd[3];
    static unsigned p0_adata[3][6],p1_adata[3][6],p2_adata[3][6],p3_adata[3][6],p4_adata[3][6],p5_adata[3][6]; 
    #define poo(X) top->p0_##X=p0_##X[2]; top->p1_##X=p1_##X[2]; top->p2_##X=p2_##X[2]; top->p3_##X=p3_##X[2]; 
        poo(en)
	poo(rsEn)
	poo(LSQ)
	poo(lsfwd)
    #undef poo
    #define poo(X) top->p4_##X=p4_##X[2]; top->p5_##X=p5_##X[2];  
        poo(en)
	poo(LSQ)
    #undef poo
    #define poo(X,Y) top->p0_##X[Y]=p0_##X[2][Y]; top->p1_##X[Y]=p1_##X[2][Y]; top->p2_##X[Y]=p2_##X[2][Y]; top->p3_##X[Y]=p3_##X[2][Y]; \
       top->p4_##X[Y]=p4_##X[2][Y]; top->p5_##X[Y]=p5_##X[2][Y];	
	poo(adata,0)
	poo(adata,1)
	poo(adata,2)
	poo(adata,3)
	poo(adata,4)
	poo(adata,5)
    #undef poo
    #define poo(X) p0_##X[n]=p0_##X[n-1]; p1_##X[n]=p1_##X[n-1]; p2_##X[n]=p2_##X[n-1]; p3_##X[n]=p3_##X[n-1]; p4_##X[n]=p4_##X[n-1]; p5_##X[n]=p5_##X[n-1];
    for(n=2;n;n--) {
        poo(en)
	poo(rsEn)
	poo(LSQ)
	poo(lsfwd)
    #undef poo
    #define poo(X,Y) p0_##X[n][Y]=p0_##X[n-1][Y]; p1_##X[n][Y]=p1_##X[n-1][Y]; p2_##X[n][Y]=p2_##X[n-1][Y]; \
	p3_##X[n][Y]=p3_##X[n-1][Y]; p4_##X[n][Y]=p4_##X[n-1][Y]; p5_##X[n][Y]=p5_##X[n-1][Y];
	poo(adata,0)
	poo(adata,1)
	poo(adata,2)
	poo(adata,3)
	poo(adata,4)
	poo(adata,5)
    #undef poo

    }
    top->FU0Hit=FU0Hit[4] && !exc;
    top->FU1Hit=FU1Hit[4] && !exc;
    top->FU2Hit=FU2Hit[4] && !exc;
    top->FU3Hit=FU3Hit[4] && !exc;

    for(n=4;n;n--) {
       FU0Hit[n]=FU0Hit[n-1];
       FU1Hit[n]=FU1Hit[n-1];
       FU2Hit[n]=FU2Hit[n-1];
       FU3Hit[n]=FU3Hit[n-1];
    }
    FU0Hit[0]=0;
    FU1Hit[0]=0;
    FU2Hit[0]=0;
    FU3Hit[0]=0;

    st3=st2;
    st2=st1;
    st1=stall;
    //stall=top->pause_agu || top->miss_holds_agu || top->miss_pause_agu || bhold || top->insert_isData || exc;
    if (!stall_cnt) stall=!(lrand48()%231);
    if (stall_cnt==0 && stall) stall_cnt=lrand48()%231;
    if (stall_cnt) stall_cnt--;
    
    if (stall) {
        top->miss_holds_agu_reg2=1;
        top->pause_agu=1;
    } else {
        top->miss_holds_agu_reg2=0;
        top->pause_agu=0;
    }
    top->eval();

    //bhold=top->insert_isData;

    p0_en[0]=0;
    p0_rsEn[0]=0;
    extract_e(top->wb1_adata,lsaddr_reg_low,val);
    if (top->wb1_en && (val%3)==0) goto no_2;
    if (st1) goto no_2;
    while (!found) {
        ind=dist128(rndgen);
        if (reqs[ind>>1][3*(ind&1)].en && (!reqs[ind>>1][3*(ind&1)].sched) &&
            !(reqs[ind>>1][3*(ind&1)].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            p0_en[0]=0;
	    p0_rsEn[0]=0;
            goto no_2;
        }
    }
    reqs[ind>>1][3*(ind&1)].poke(gen,vals);
    for(n=0;n<6;n++)p0_adata[0][n]=vals[n];
    p0_en[0]=1;
    p0_rsEn[0]=1;
    p0_LSQ[0]=reqs[ind>>1][3*(ind&1)].LSQ;
    p0_lsfwd[0]=0;
    reqs[ind>>1][3*(ind&1)].sched++;
    FU0Hit[0]++;
no_2:
    found=false;
    p1_en[0]=0;
    p1_rsEn[0]=0;
    if (top->wb1_en && (val%3)==1) goto no_3;
    if (st1) goto no_3;
    while (!found) {
        ind=dist128(rndgen);
        if (reqs[ind>>1][3*(ind&1)+1].en && (!reqs[ind>>1][3*(ind&1)+1].sched) &&
            !(reqs[ind>>1][3*(ind&1)+1].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            p1_en[0]=0;
	    p1_rsEn[0]=0;
            goto no_3;
        }
    }
    reqs[ind>>1][3*(ind&1)+1].poke(gen,vals);
    for(n=0;n<6;n++) p1_adata[0][n]=vals[n];
    p1_en[0]=1;
    p1_rsEn[0]=1;
    p1_LSQ[0]=reqs[ind>>1][3*(ind&1)+1].LSQ;
    p1_lsfwd[0]=0;
    reqs[ind>>1][3*(ind&1)+1].sched++;
    FU1Hit[0]++;

no_3:
    found=false;
    p2_en[0]=0;
    p2_rsEn[0]=0;
    if (top->wb1_en && (val%3)==2) goto no_4;
    if (st1) goto no_4;
    while (!found) {
        ind=dist128(rndgen);
        if (reqs[ind>>1][3*(ind&1)+2].en && (!reqs[ind>>1][3*(ind&1)+2].sched) &&
            !(reqs[ind>>1][3*(ind&1)+2].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            p2_en[0]=0;
	    p2_rsEn[0]=0;
            goto no_4;
        }
    }
    reqs[ind>>1][3*(ind&1)+2].poke(gen,vals);
    for(n=0;n<6;n++) p2_adata[0][n]=vals[n];
    p2_en[0]=1;
    p2_rsEn[0]=1;
    p2_LSQ[0]=reqs[ind>>1][3*(ind&1)+2].LSQ;
    p2_lsfwd[0]=0;
    reqs[ind>>1][3*(ind&1)+2].sched++;
    FU2Hit[0]++;
no_4:
    if (!top->wb1_en || exc || stall) goto wb0;
    extract_e(top->wb1_adata,lsaddr_II,ii);
    for(n=0;n<64;n++) {
        for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en&&reqs[n][n2].II==ii) {
		goto out1;
	    }
	}
    }
out1:
    if (n<64) ii=reqs[n][n2].LSQ;
    else {
	printf("Wb1\n");
	//ret=true;
	goto wb0;
    }
    switch(val%3) {
	case 0:
        for(n=0;n<6;n++) p0_adata[0][n]=top->wb1_adata[n];
        p0_en[0]=top->wb1_en;
        p0_rsEn[0]=0;
        p0_LSQ[0]=ii;
        p0_lsfwd[0]=1;
	FU0Hit[0]++;
	break;
	case 1:
        for(n=0;n<6;n++) p1_adata[0][n]=top->wb1_adata[n];
        p1_en[0]=top->wb1_en;
        p1_rsEn[0]=0;
        p1_LSQ[0]=ii;
        p1_lsfwd[0]=1;
	FU1Hit[0]++;
	break;
	case 2:
        for(n=0;n<6;n++) p2_adata[0][n]=top->wb1_adata[n];
        p2_en[0]=top->wb1_en;
        p2_rsEn[0]=0;
        p2_LSQ[0]=ii;
        p2_lsfwd[0]=1;
	FU2Hit[0]++;
	break;
	
    }
    //reqs[ii>>3][ii&7].sched++;
wb0:
    if (!top->wb0_en || exc || stall) goto do_p3;
    extract_e(top->wb0_adata,lsaddr_II,ii);
    for(n=0;n<64;n++) {
        for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en&&reqs[n][n2].II==ii) {
		goto out2;
	    }
	}
    }
out2:
    if (n<64) ii=reqs[n][n2].LSQ;
    else {
	printf("Wb0\n");
	//ret=true;
	goto do_store;
    }
    for(n=0;n<6;n++) p3_adata[0][n]=top->wb0_adata[n];
    p3_en[0]=top->wb0_en;
    p3_rsEn[0]=0;
    p3_LSQ[0]=ii;
    p3_lsfwd[0]=1;
    FU3Hit[0]++;
    //reqs[ii>>3][ii&7].sched++;
    goto do_store;
do_p3:
    found=false;
    p3_en[0]=0;
    p3_rsEn[0]=0;
    p3_lsfwd[0]=0;
    if (st1) goto do_store;
    while (!found) {
        ind=dist384(rndgen);
        if (reqs[ind&0x3f][ind>>6].en && (!reqs[ind&0x3f][ind>>6].sched) &&
            !(reqs[ind&0x3f][ind>>6].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            p3_en[0]=0;
	    p3_rsEn[0]=0;
            goto do_store;
        }
    }
    reqs[ind&0x3f][ind>>6].poke(gen,vals);
    for(n=0;n<6;n++) p3_adata[0][n]=vals[n];
    p3_en[0]=1;
    p3_rsEn[0]=1;
    p3_LSQ[0]=reqs[ind&0x3f][ind>>6].LSQ;
    p3_lsfwd[0]=0;
    reqs[ind&0x3f][ind>>6].sched++;
    FU3Hit[0]++;
do_store:
    found=false;
    p4_en[0]=0;
    if (wrsst[2]&1) goto do_store2;
   // top->p3_rsEn=0;
   // top->p3_lsfwd=0;
    while (!found) {
        ind=dist384(rndgen);
        if (reqs[ind&0x3f][ind>>6].en && (!(reqs[ind&0x3f][ind>>6].sched&3) 
	    || (reqs[ind&0x3f][ind>>6].sched&3)==2) && (reqs[ind&0x3f][ind>>6].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            p4_en[0]=0;
	    //top->p3_rsEn=0;
            goto do_store2;
        }
    }
    reqs[ind&0x3f][ind>>6].poke(gen,vals);
    for(n=0;n<6;n++) p4_adata[0][n]=vals[n];
    p4_en[0]=1;
   // top->p3_rsEn=1;
    p4_LSQ[0]=reqs[ind&0x3f][ind>>6].LSQ;
    reqs[ind&0x3f][ind>>6].sched++;
    //printf("mm4 %x\n",p4_LSQ[0]);
do_store2:
    found=false;
    p5_en[0]=0;
    if (wrsst[2]&2) goto after_store;
   // top->p3_rsEn=0;
   // top->p3_lsfwd=0;
    while (!found) {
        ind=dist384(rndgen);
        if (reqs[ind&0x3f][ind>>6].en && (!(reqs[ind&0x3f][ind>>6].sched&3) 
	    || (reqs[ind&0x3f][ind>>6].sched&3)==2) && (reqs[ind&0x3f][ind>>6].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            p5_en[0]=0;
	    //top->p3_rsEn=0;
            goto after_store;
        }
    }
    reqs[ind&0x3f][ind>>6].poke(gen,vals);
    for(n=0;n<6;n++) p5_adata[0][n]=vals[n];
    p5_en[0]=1;
   // top->p3_rsEn=1;
    p5_LSQ[0]=reqs[ind&0x3f][ind>>6].LSQ;
    reqs[ind&0x3f][ind>>6].sched++;
    //printf("mm5 %x\n",p5_LSQ[0]);
after_store:
    found=false;
    top->lsw_rs_en0=0;
   // top->p3_rsEn=0;
   // top->p3_lsfwd=0;
    while (!found) {
        ind=dist384(rndgen);
        if (reqs[ind&0x3f][ind>>6].en && ((reqs[ind&0x3f][ind>>6].sched&3)<2) &&
            (reqs[ind&0x3f][ind>>6].op&1))
            found=1;
        if (dist16(rndgen)==0) {
            top->lsw_rs_en0=0;
	    //top->p3_rsEn=0;
            goto do_storeD2;
        }
    }
    top->lsw_rs_en0=1;
   // top->p3_rsEn=1;
    top->lsw_wq0=reqs[ind&0x3f][ind>>6].WQ;
    top->lsw_wdata0[0]=reqs[ind&0x3f][ind>>6].data[0];
    top->lsw_wdata0[1]=reqs[ind&0x3f][ind>>6].data[1];
    top->lsw_wdata0[2]=reqs[ind&0x3f][ind>>6].data[2];
    top->lsw_wdata0[3]=reqs[ind&0x3f][ind>>6].data[3];
    top->lsw_wdata0[4]=reqs[ind&0x3f][ind>>6].data[4]&0xff;

    reqs[ind&0x3f][ind>>6].sched++;
    reqs[ind&0x3f][ind>>6].sched++;
do_storeD2:
    found=false;
    top->lsw_rs_en1=0;
   // top->p3_rsEn=0;
   // top->p3_lsfwd=0;
    while (!found) {
        ind=dist384(rndgen);
        if (reqs[ind&0x3f][ind>>6].en && ((reqs[ind&0x3f][ind>>6].sched&3)<2) &&
            (reqs[ind&0x3f][ind>>6].op&1))
            found=1;
        if (dist16(rndgen)==0) {
            top->lsw_rs_en1=0;
	    //top->p3_rsEn=0;
            goto ende;
        }
    }
    top->lsw_rs_en1=1;
   // top->p3_rsEn=1;
    top->lsw_wq1=reqs[ind&0x3f][ind>>6].WQ;
    top->lsw_wdata1[0]=reqs[ind&0x3f][ind>>6].data[0];
    top->lsw_wdata1[1]=reqs[ind&0x3f][ind>>6].data[1];
    top->lsw_wdata1[2]=reqs[ind&0x3f][ind>>6].data[2];
    top->lsw_wdata1[3]=reqs[ind&0x3f][ind>>6].data[3];
    top->lsw_wdata1[4]=reqs[ind&0x3f][ind>>6].data[4]&0xff;

    reqs[ind&0x3f][ind>>6].sched++;
    reqs[ind&0x3f][ind>>6].sched++;
ende:
    for(n=0;n<=4;n++) if (exc) FU0Hit[n]=0;
    for(n=0;n<=4;n++) if (exc) FU1Hit[n]=0;
    for(n=0;n<=4;n++) if (exc) FU2Hit[n]=0;
    for(n=0;n<=4;n++) if (exc) FU3Hit[n]=0;
    for(n=0;n<=2;n++) if (exc) p0_en[n]=0;
    for(n=0;n<=2;n++) if (exc) p1_en[n]=0;
    for(n=0;n<=2;n++) if (exc) p2_en[n]=0;
    for(n=0;n<=2;n++) if (exc) p3_en[n]=0;
    for(n=2;n;n--) wrsst[n]=wrsst[n-1];
   // for(n=0;n<=2;n++) if (exc) p4_en[n]=0;
   // for(n=0;n<=2;n++) if (exc) p5_en[n]=0;
    wrsst[0]=top->WDoRsPause;
    return;
}

bool get_check_ret(Vfun_lsq *top,bool &retire,unsigned &exc) {
    static unsigned ret_point;
    static unsigned ret_II;
    static unsigned was_ret;
    //static bool exc;
    bool ret=false;
    retire=false;
#define pooch was_ret=top->mem_II_bits_ret;
    if (/*$*/top->doRetire_d) {
       top->mem_II_upper_in=ret_II;
       top->eval();
    }
    if (was_ret & ~top->mem_II_bits_ret) ret=true;
    /*$*/top->doRetire_d=0;
    /*$*/top->except=exc==9;
    ///*$*/exc=10;
    static unsigned stall_cnt=0;
    static unsigned stall_val=9000;

    if (stall_cnt>2000) {
        ret=true;  
    } else if (stall_val==top->mem_II_upper_in) {
        stall_cnt++;
    } else {
        stall_val=top->mem_II_upper_in;
        stall_cnt=0;
    }

    unsigned x;
    unsigned n;
    unsigned n1;
    for(x=0;x<6;x++) if (!reqs[ret_point][0].en) break;
    top->xbreak=~(top->mem_II_bits_ret&top->mem_II_bits_fine);
    for(n=0;n<x;n++) if (!(reqs[ret_point][n].op&1) && reqs[ret_point][n].sched>1)
	    top->xbreak&=~(1<<n);
    top->xbreak|=((top->xbreak<<1)|(top->xbreak<<2)|(top->xbreak<<3)|(top->xbreak<<4)|
	(top->xbreak<<5)|(top->xbreak<<6)|(top->xbreak<<7)|(top->xbreak<<8)|(top->xbreak<<9));
    top->xbreak&=0x3ff;
    if (exc==9) {
        top->xbreak=0x3ff;
    }
    top->has_xbreak=top->xbreak!=0;
    top->eval();
    if (!reqs[ret_point][0].en || exc==9) {exc=exc; was_ret=0; return ret;}
    if (ret_II!=(reqs[ret_point][0].II>>4)) {
       ret_II++;
       if (ret_II>47) ret_II=0;
       top->mem_II_upper_in=ret_II;
       exc=exc;
       was_ret=0;
       return ret;
    }
    if (ret_II!=top->mem_II_upper) {exc=exc; was_ret=0; return ret;}
    for(n=0;n<6;n++) {
        if (!reqs[ret_point][n].en) {
retire:     
	    if (top->mem_II_stall||top->mem_II_stall2)
	        { exc=exc;  pooch return ret;}
	    for(x=0;x<n;x++) if ((reqs[ret_point][x].op&1)) reqs[ret_point][x].sched+=4;//no shed
	       
	    for(n1=0;n1<6;n1++)
		if (!(reqs[ret_point][n1].op&1)||reqs[ret_point][n1].sched<4) reqs[ret_point][n1].en=0;
	    retire=1;
	    ret_point++;
	    ret_point&=0x3f;
            ret_II++;
            if (ret_II>47) ret_II=0;
            /*$*/top->doRetire_d++;
	    retire++;
	    exc=exc;
	    was_ret=0;
	    //for(x=0;x<=n;x++) reqs[ret_point][x].sched+=4;//no shed 
	    return ret;
	}
	if (!((elem(ret)>>n)&1) && !(reqs[ret_point][n].sched>=2 && !(reqs[ret_point][n].op&1))) 
	    { exc=exc;  pooch return ret;}
	if (!reqs[ret_point][n].sched) { exc=exc;  pooch return ret;}
	if (((elem(except)>>n)&1 && (elem(ret)>>n)&1) ||(reqs[ret_point][n].sched==3 && !(reqs[ret_point][n].op&1))) {
	    if (!((!reqs[ret_point][n].sys_kmode && reqs[ret_point][n].kmode)||
	        reqs[ret_point][n].oor)) {
		printf("extra excpt, LSQ %x\n",reqs[ret_point][n].LSQ);
		ret=true;
	    }
flush:
            if (top->mem_II_stall2|top->mem_II_stall)
                { exc=exc;  pooch return ret;}
	    for(x=0;x<n;x++) if ((reqs[ret_point][x].op&1)) reqs[ret_point][x].sched+=4;//shed 
	    for(n1=0;n1<6;n1++)
		if (!(reqs[ret_point][n1].op&1)||reqs[ret_point][n1].sched<4) reqs[ret_point][n1].en=0;
	    x=ret_point;
	    for(n1=(ret_point+1)&0x3f;n1!=x;n1=(n1+1)&0x3f) {
	        if (!reqs[n1][0].en) {
		    ret_point=n1;
		    break;
		} else {
		    ret_II=reqs[n1][0].II>>4;
		}
	    }
	    ret_II++;
	    if (ret_II>47) ret_II=0;
	    top->II_upper=ret_II;
	    do_discard(); 
            /*$*/top->doRetire_d++;
	    /*$*/exc=10;
	    //top->xbreak=;
	    top->has_xbreak=true;
	    retire++;
	    was_ret=0;
	    //for(x=0;x<=n;x++) reqs[ret_point][x].sched+=4;//c rules
	    return ret; 
	}
	if (((elem(fine)>>n)&1 && (elem(ret)>>n)&1) || (reqs[ret_point][n].sched==2 && !(reqs[ret_point][n].op&1))) {
	    if (gen.get_phys(reqs[ret_point][n].vaddr)>=0xc0000000000 &&
	        !reqs[ret_point][n].flag && ((elem(fine)>>n)&1 && (elem(ret)>>n)&1) && !(reqs[ret_point][n].op&1)) {
		printf("IO as normal, LSQ %x\n",reqs[ret_point][n].LSQ);
		ret=true;
		goto retire;
	    }
	    if (((!reqs[ret_point][n].sys_kmode && reqs[ret_point][n].kmode)||
	        reqs[ret_point][n].oor)&&((elem(fine)>>n)&1 && (elem(ret)>>n)&1)) {
		printf("missing excpt, LSQ %x\n",reqs[ret_point][n].LSQ);
		ret=true;
		continue;
	    }
	    continue; 
	}
	if (((elem(ldconfl)>>n)&1 && (elem(ret)>>n)&1)|| ((elem(waitconfl)>>n)&1 && (elem(ret)>>n)&1) ||
	    (reqs[ret_point][n].sched==2 && !reqs[ret_point][n].flag)) {
	    if (reqs[ret_point][n].flag &&((elem(ldconfl)>>n)&1) && (elem(ret)>>n)&1) {
		printf("LDCONFL & FLAG, LSQ %x\n",reqs[ret_point][n].LSQ);
		ret=true;
	    }
	    if ((elem(waitconfl)>>n)&1 && (elem(ret)>>n)&1) {
		printf("waitconfl, LSQ %x\n",reqs[ret_point][n].LSQ);
	    }
	    goto flush;
	}
    }
    if (top->mem_II_stall||top->mem_II_stall2)
        { exc=exc;  pooch return ret;}
    for(x=0;x<n;x++) if ((reqs[ret_point][x].op&1)) reqs[ret_point][x].sched+=4;//no shed 
	       
    for(n1=0;n1<6;n1++)
	if (!(reqs[ret_point][n1].op&1)||reqs[ret_point][n1].sched<4) reqs[ret_point][n1].en=0;
    retire=1;
    ret_point++;
    ret_point&=0x3f;
    ret_II++;
    if (ret_II>47) ret_II=0;
    /*$*/top->doRetire_d++;
    retire++;
    exc=exc;
    was_ret=0;
    return ret;
}

bool get_check(Vfun_lsq *top, int exc) {
    static unsigned fwd_data2[2][6];
    static unsigned fwd_ddata2[2][5];
    static unsigned fwd_banks2[2];
    static bool fwd_en2[2];
    static unsigned short fwd_LSQ2[2];
    static unsigned fwd_data1[2][6];
    static unsigned fwd_ddata1[2][5];
    static unsigned fwd_banks1[2];
    static bool fwd_en1[2];
    static unsigned short fwd_LSQ1[2];
    static unsigned str0_II[3],str1_II[3];
    static bool str0_en[3],str1_en[3];
    unsigned val1[6],fwd_ret;
    unsigned n,n2;
    bool flag;
    unsigned LSQ;
    unsigned long val,ii;
    bool ret=false,err=false;
    static unsigned LS_pos0,LS_pos1;
    int bytes1;

    if (!fwd_en1[1] || exc) goto do_fwd_en2;
    extract_e(fwd_data1[1],lsaddr_flag,val);
    flag=val;
    extract_e(fwd_data1[1],lsaddr_except,val);
    fwd_ret=val ? 1 : 2;
    LSQ=fwd_LSQ1[1];
    n=LSQ>>3;
    n2=LSQ&7;
    if (LSQ!=reqs[n][n2].LSQ || !reqs[n][n2].chk(gen,fwd_data1[1],LSQ,fwd_ret,&err) || err) {
        printf("ERROR WB0 LSQ %x:%x\n",reqs[n][n2].LSQ,LSQ);
	ret=true;
    }
    if (gen.get_phys(reqs[n][n2].vaddr)<0xc0000000000ul && !reqs[n][n2].oor) {
        bzero((char *) val1,20);//c rules
        bytes1=(reqs[n][n2].vaddr&0x7f)+reqs[n][n2].bytes-0x80;
        if (bytes1<0) bytes1=0;
        memcpy((char *) val1,gen.cache+gen.get_phys(reqs[n][n2].vaddr), reqs[n][n2].bytes-bytes1);
        if (bytes1)
	    memcpy((char *) val1+reqs[n][n2].bytes-bytes1,gen.cache+gen.get_phys(reqs[n][n2].vaddr+reqs[n][n2].bytes-bytes1),
	    bytes1);
        if (!(fwd_banks1[1]&0x1)) val1[0]=fwd_ddata1[1][0];
        if (!(fwd_banks1[1]&0x2)) val1[1]=fwd_ddata1[1][1];
        if (!(fwd_banks1[1]&0x4)) val1[2]=fwd_ddata1[1][2];
        if (!(fwd_banks1[1]&0x8)) val1[3]=fwd_ddata1[1][3];
        if (!(fwd_banks1[1]&0x8) && reqs[n][n2].bytes==17) val1[4]=fwd_ddata1[1][4]&0xff;
        if (val1[0]!=reqs[n][n2].data[0] || val1[1]!=reqs[n][n2].data[1] ||
	    val1[2]!=reqs[n][n2].data[2] || val1[3]!=reqs[n][n2].data[3] ||
	    val1[4]!=reqs[n][n2].data[4]) {
            printf("ERROR WB0(D) LSQ %x:%x\n",reqs[n][n2].LSQ,LSQ);
	    ret=true;
        }
    }
    if (reqs[n][n2].sched>1) { printf("DREQ %x\n",LSQ); ret=true; }
    reqs[n][n2].sched++;
    if (reqs[n][n2].oor) reqs[n][n2].sched++;
do_fwd_en2:
    if (!fwd_en2[1] || exc) goto do_write;
    extract_e(fwd_data2[1],lsaddr_flag,val);
    flag=val;
    extract_e(fwd_data2[1],lsaddr_except,val);
    fwd_ret=val ? 1 : 2;
    LSQ=fwd_LSQ2[1];
    n=LSQ>>3;
    n2=LSQ&7;
    if (LSQ!=reqs[n][n2].LSQ || !reqs[n][n2].chk(gen,fwd_data2[1],LSQ,fwd_ret,&err) || err) {
        printf("ERROR WB0 LSQ %x:%x\n",reqs[n][n2].LSQ,LSQ);
	ret=true;
    }
    if (gen.get_phys(reqs[n][n2].vaddr)<0xc0000000000ul && !reqs[n][n2].oor) {
        bzero((char *) val1,20);//over c++
        bytes1=(reqs[n][n2].vaddr&0x7f)+reqs[n][n2].bytes-0x80;
        if (bytes1<0) bytes1=0;
        memcpy((char *) val1,gen.cache+gen.get_phys(reqs[n][n2].vaddr), reqs[n][n2].bytes-bytes1);
        if (bytes1)
	    memcpy((char *) val1+reqs[n][n2].bytes-bytes1,gen.cache+gen.get_phys(reqs[n][n2].vaddr+reqs[n][n2].bytes-bytes1),
	        bytes1);
        if (!(fwd_banks2[1]&0x1)) val1[0]=fwd_ddata2[1][0];
        if (!(fwd_banks2[1]&0x2)) val1[1]=fwd_ddata2[1][1];
        if (!(fwd_banks2[1]&0x4)) val1[2]=fwd_ddata2[1][2];
        if (!(fwd_banks2[1]&0x8)) val1[3]=fwd_ddata2[1][3];
        if (!(fwd_banks2[1]&0x8) && reqs[n][n2].bytes==17) val1[4]=fwd_ddata2[1][4]&0xff;
        if (val1[0]!=reqs[n][n2].data[0] || val1[1]!=reqs[n][n2].data[1] ||
	    val1[2]!=reqs[n][n2].data[2] || val1[3]!=reqs[n][n2].data[3] ||
	    val1[4]!=reqs[n][n2].data[4]) {
            printf("ERROR WB0(D) LSQ %x:%x\n",reqs[n][n2].LSQ,LSQ);
	    ret=true;
        }
    }
    if (reqs[n][n2].sched>1) { printf("DREQ %x\n",LSQ); ret=true; }
    reqs[n][n2].sched++;
    if (reqs[n][n2].oor) reqs[n][n2].sched++;

do_write:

    top->mOpY4_II=str0_II[1];
    top->mOpY4_hit=str0_en[1];
    top->mOpY5_II=str1_II[1];
    top->mOpY5_hit=str1_en[1];

    if (!str0_en[1]) goto  str_B;
    for(n=0;n<64;n++) {
        for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en&&reqs[n][n2].II==str0_II[1]) {
		goto outA;
	    }
	}
    }
outA:
    if (n!=64) {
	if (gen.get_phys(reqs[n][n2].vaddr)<0xc0000000000) {
	    if ((reqs[n][n2].op&1) && (!reqs[n][n2].kmode || reqs[n][n2].sys_kmode) && !reqs[n][n2].oor) {
                int bytes1=(reqs[n][n2].vaddr&0x7f)+reqs[n][n2].bytes-0x80;
	        if (bytes1<0) bytes1=0;
	        memcpy(gen.cache+gen.get_phys(reqs[n][n2].vaddr),(char *) reqs[n][n2].data,reqs[n][n2].bytes-bytes1);
	        if (bytes1)
		    memcpy(gen.cache+gen.get_phys(reqs[n][n2].vaddr+reqs[n][n2].bytes-bytes1),
			(char *) reqs[n][n2].data+reqs[n][n2].bytes-bytes1,bytes1);
	    }
	}
	reqs[n][n2].sched+=4;
    }
str_B:

    if (!str1_en[1]) goto  str_No;
    for(n=0;n<64;n++) {
        for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en&&reqs[n][n2].II==str1_II[1]) {
		goto outB;
	    }
	}
    }
outB:
    if (n!=64) {
	if (gen.get_phys(reqs[n][n2].vaddr)<0xc0000000000) {
	    if ((reqs[n][n2].op&1) && (!reqs[n][n2].kmode || reqs[n][n2].sys_kmode) && !reqs[n][n2].oor) {
                int bytes1=(reqs[n][n2].vaddr&0x7f)+reqs[n][n2].bytes-0x80;
	        if (bytes1<0) bytes1=0;
	        memcpy(gen.cache+gen.get_phys(reqs[n][n2].vaddr),(char *) reqs[n][n2].data,reqs[n][n2].bytes-bytes1);
	        if (bytes1)
		    memcpy(gen.cache+gen.get_phys(reqs[n][n2].vaddr+reqs[n][n2].bytes-bytes1),
			(char *) reqs[n][n2].data+reqs[n][n2].bytes-bytes1,bytes1);
	    }
	}
	reqs[n][n2].sched+=4;
    }
str_No:

    for (n=2;n;n--) {
	str0_en[n]=str0_en[n-1];
	str1_en[n]=str1_en[n-1];
	str0_II[n]=str0_II[n-1];
	str1_II[n]=str1_II[n-1];
    }

    str0_en[0]=0;
    str1_en[0]=0;

    do {
        for(n=0;n<6;n++) if (reqs[LS_pos0][n].en) break;
        if (n==6 && LS_pos0!=gen.POS) {
	    LS_pos1=0;
	    LS_pos0++;
	    LS_pos0&=0x3f;
        }
    } while (n==6 && LS_pos0!=gen.POS);
    n=LS_pos0;
    n2=LS_pos1;
    if (top->st0_en) {
        while (!reqs[LS_pos0][LS_pos1].en || !(reqs[LS_pos0][LS_pos1].op&1)) {
	    if ((++LS_pos1)==6) {
		LS_pos1=0;
		LS_pos0++;
		LS_pos0&=0x3f;
	    }
	    if (n==LS_pos0 && n2==LS_pos1) { ret=true; goto nowrite; }
	}
	if (!(reqs[LS_pos0][LS_pos1].op&1)) { ret=true; goto nowrite; }
	if (!(reqs[LS_pos0][LS_pos1].sched==7) && !(reqs[LS_pos0][LS_pos1].sched==3)) { ret=true; goto nowrite; }
//	if (reqs[LS_pos0][LS_pos1].LSQ!=top->st0_LSQ) { ret=true; goto nowrite; }
        extract_e(top->st0_adata,lsaddr_except,val);
	if (!reqs[LS_pos0][LS_pos1].chk(gen,top->st0_adata,reqs[LS_pos0][LS_pos1].LSQ,val ? 1 : 2, &err) || err) {
            printf("ERROR ST0 LSQ %x:%x\n",reqs[LS_pos0][LS_pos1].LSQ,reqs[LS_pos0][LS_pos1].LSQ);
	    ret=true;
	}

	//reqs[LS_pos0][LS_pos1].sched+=4;
	
	str0_II[0]=reqs[LS_pos0][LS_pos1].II;
	str0_en[0]=1;
	
	//reqs[LS_pos0][LS_pos1].en=0;
	if ((++LS_pos1)==6) {
		LS_pos1=0;
		LS_pos0++;
		LS_pos0&=0x3f;
	}
    }

    if (top->st1_en) {
        if (!top->st0_en) ret=true;
        n=LS_pos0;
        n2=LS_pos1;
        while (!reqs[LS_pos0][LS_pos1].en || !(reqs[LS_pos0][LS_pos1].op&1)) {
	    if ((++LS_pos1)==6) {
		LS_pos1=0;
		LS_pos0++;
		LS_pos0&=0x3f;
	    }
	    if (n==LS_pos0 && n2==LS_pos1) { ret=true; goto nowrite; }
	}
	if (!(reqs[LS_pos0][LS_pos1].op&1)) { ret=true; goto nowrite; }
	if (!(reqs[LS_pos0][LS_pos1].sched==7) && !(reqs[LS_pos0][LS_pos1].sched==3)) { ret=true; goto nowrite; }
        extract_e(top->st1_adata,lsaddr_except,val);
	if (!reqs[LS_pos0][LS_pos1].chk(gen,top->st1_adata,reqs[LS_pos0][LS_pos1].LSQ,val ? 1 : 2, &err) || err) {
            printf("ERROR ST0 LSQ %x:%x\n",reqs[LS_pos0][LS_pos1].LSQ,reqs[LS_pos0][LS_pos1].LSQ);
	    ret=true;
	}
	
	//reqs[LS_pos0][LS_pos1].sched+=4;
	
	str1_II[0]=reqs[LS_pos0][LS_pos1].II;
	str1_en[0]=1;

	//reqs[LS_pos0][LS_pos1].en=0;
	if ((++LS_pos1)==6) {
		LS_pos1=0;
		LS_pos0++;
		LS_pos0&=0x3f;
	}
    }
nowrite:
    for(n=0;n==0;n--) {
        fwd_en1[n+1]=fwd_en1[n];
        fwd_LSQ1[n+1]=fwd_LSQ1[n];
        fwd_banks1[n+1]=fwd_banks1[n];
        fwd_ddata1[n+1][0]=fwd_ddata1[n][0];
        fwd_ddata1[n+1][1]=fwd_ddata1[n][1];
        fwd_ddata1[n+1][2]=fwd_ddata1[n][2];
        fwd_ddata1[n+1][3]=fwd_ddata1[n][3];
        fwd_ddata1[n+1][4]=fwd_ddata1[n][4];
        fwd_data1[n+1][0]=fwd_data1[n][0];
        fwd_data1[n+1][1]=fwd_data1[n][1];
        fwd_data1[n+1][2]=fwd_data1[n][2];
        fwd_data1[n+1][3]=fwd_data1[n][3];
        fwd_data1[n+1][4]=fwd_data1[n][4];
        fwd_data1[n+1][5]=fwd_data1[n][5];
        
	fwd_en2[n+1]=fwd_en2[n];
        fwd_LSQ2[n+1]=fwd_LSQ2[n];
        fwd_banks2[n+1]=fwd_banks2[n];
        fwd_ddata2[n+1][0]=fwd_ddata2[n][0];
        fwd_ddata2[n+1][1]=fwd_ddata2[n][1];
        fwd_ddata2[n+1][2]=fwd_ddata2[n][2];
        fwd_ddata2[n+1][3]=fwd_ddata2[n][3];
        fwd_ddata2[n+1][4]=fwd_ddata2[n][4];
        fwd_data2[n+1][0]=fwd_data2[n][0];
        fwd_data2[n+1][1]=fwd_data2[n][1];
        fwd_data2[n+1][2]=fwd_data2[n][2];
        fwd_data2[n+1][3]=fwd_data2[n][3];
        fwd_data2[n+1][4]=fwd_data2[n][4];
        fwd_data2[n+1][5]=fwd_data2[n][5];
    }

    fwd_en1[0]=top->wb0_en && !exc;
    extract_e(top->wb0_adata,lsaddr_II,ii);
    for(n=0;n<64;n++) {
        for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en&&reqs[n][n2].II==ii) {
		goto out1;
	    }
	}
    }
out1:
    if (n!=64) fwd_LSQ1[0]=reqs[n][n2].LSQ;
    else if (top->wb0_en && !exc) {
	printf("WB0.64 %lx\n\n",ii);
	ret=true;
    }
    for(n=0;n<6;n=n+1) fwd_data1[0][n]=top->wb0_adata[n];
    for(n=0;n<5;n=n+1) fwd_ddata1[0][n]=top->wb0_data[n];
    fwd_banks1[0]=top->wb0_brdbanks;

    fwd_en2[0]=top->wb1_en && !exc;
    extract_e(top->wb1_adata,lsaddr_II,ii);
    for(n=0;n<64;n++) {
        for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en&&reqs[n][n2].II==ii) {
		goto out2;
	    }
	}
    }
out2:
    if (n!=64) fwd_LSQ2[0]=reqs[n][n2].LSQ;
    else if (top->wb1_en && !exc) {
	printf("WB1.64 %lx\n",ii);
	ret=true;
    }
    for(n=0;n<6;n=n+1) fwd_data2[0][n]=top->wb1_adata[n];
    for(n=0;n<5;n=n+1) fwd_ddata2[0][n]=top->wb1_data[n];
    fwd_banks2[0]=top->wb1_brdbanks;
    
    fwd_en1[1]=fwd_en1[1] && !exc;
    fwd_en2[1]=fwd_en2[1] && !exc;

    return ret;
}

void lsreq::poke2(char * data1) {
	if (gen.get_phys(vaddr)<0xc0000000000) {
            int bytes1=(vaddr&0x7f)+bytes-0x80;
	    if (bytes1<0) bytes1=0;
	    if ((op&1) && (!kmode || sys_kmode) && !oor) {
	        memcpy(data1+gen.get_phys(vaddr),(char *) data,bytes-bytes1);
		if (bytes1) 
		    memcpy(data1+gen.get_phys(vaddr+bytes-bytes1),(char *) data+bytes-bytes1,
			bytes1);
	    }
	}
}


bool dmigen::gen_bndl(lsreq reqZ[6],Vfun_lsq *top,bool no_alloc) {
    unsigned int n,cnt_st=0,rng,pge,sh,a;
    unsigned long addr,val,base,imm,index;
    unsigned cnt=lrand48()%6+1;
    unsigned map_size=0;
    unsigned usb=0;
    static unsigned wrt_pos;
    wrt_pos=0;
    if (no_alloc) {
	top->bundle_in_reg2=0;
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
    top->lsi0_reg=6;
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
    top->ldq_new_mask_reg=0; 
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
	    if (top->lsi0_reg==6) {
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
	    }

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
                if (addr<rng_addr[0]) {
                    addr=rng_addr[0];
    	            reqZ[n].vaddr=addr;
                }
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
	    top->ldq_new_mask_reg|=1<<n;
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
                    if (addr<rng_addr[0]) {
                        addr=rng_addr[0];
    	                reqZ[n].vaddr=addr;
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
    if (cnt) deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_used,(1<<cnt)-1);
    if (cnt) deposit_e((unsigned *) &top->LSQ_shr_data,lsqshare_usedB,usb);
    //reqZ[n].reg_no=n; 
    top->II_upper=II;
    top->eval();
    if (top->doStall_LSQ || top->doStall_LDQ || top->doStall_STQ || II==top->mem_II_upper) {
	WQ-=cnt_st;
	if (WQ>239) WQ+=240;//unsigned magic
	for(n=0;n<6;n++) reqZ[n].en=0;
	return false;
    }
    for(n=0;n<cnt;n++) {
	if (gen.get_phys(reqZ[n].vaddr)<0xc0000000000) {
            int bytes1=(reqZ[n].vaddr&0x7f)+reqZ[n].bytes-0x80;
	    if (bytes1<0) bytes1=0;
	    if ((reqZ[n].op&1) && (!reqZ[n].kmode || reqZ[n].sys_kmode) && !reqZ[n].oor) {
	        memcpy(mem+get_phys(reqZ[n].vaddr),(char *) reqZ[n].data,reqZ[n].bytes-bytes1);
		if (bytes1) 
		    memcpy(mem+get_phys(reqZ[n].vaddr+reqZ[n].bytes-bytes1),(char *) reqZ[n].data+reqZ[n].bytes-bytes1,
			bytes1);
	    }
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
    if ((!odd) && val!=(phys>>8) && (ret&3)!=1) *err=1;
    if (odd && split && val!=(phys2>>8) && (ret&3)!=1) *err=1;
    extract_e(mop,lsaddr_addrO,val);
    if (odd && val!=(phys>>8) && (ret&3)!=1) *err=1;
    if ((!odd) && split && val!=(phys2>>8) && (ret&3)!=1) *err=1;
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
    if (op&1) deposit_e(mop,lsaddr_pconfl,0);
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
    Vfun_lsq *top=new Vfun_lsq();
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
    while (!Verilated::gotFinish()) {
        top->clk=0;
        top->eval();
        top->eval();
        top->clk=1;
        top->eval();
        if (!initcount) {
	   err=false;
	   sched(top,exc);
	   if (exc>1) exc=exc-1;
	   if (exc==1) {
	       if (!has_req()) {
		   exc=0;
                   memcpy(gen.mem+28*1024*1024,gen.cache+28*1024*1024,4*1024*1024);
	       }
	   }
	   err=err||get_check(top,exc);
	   err=err||get_check_ret(top,retired,exc);
           for(n=0;n<6;n++) if (reqs[gen.POS][n].en) break;
           if (n==6 && !exc && top->fun_lsq__DOT__LSQ_upper!=gen.POS) {
	       printf("LU %x:%x\n",top->fun_lsq__DOT__LSQ_upper,gen.POS);
           } 
           gen.gen_bndl(reqs[gen.POS],top,n!=6 || exc!=0);

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
