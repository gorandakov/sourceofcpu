#include <cstdio>
#include <cstdlib>
#include <random>
#include "Vagu_block.h"
#include "verilated.h"
#include "../inc/struct.h"
#include "../inc/extract.h"
#include "../inc/csrss_no.h"

#define get64(a) ((((unsigned long long) a[1])<<32)|(unsigned long long) a[0])
#define set64i(a,b) a[0]=b;a[1]=b>>32;a[2]=0;

#define HUG 1

#define def_seed 0xbbea1735baad
struct lsent {
    unsigned short op;
    unsigned short sh;
    unsigned short sz;
};

lsent load_op[]={
    0xa0,0,1, //inv tlb
    
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
    bool b_ptr,in_ptr;
    unsigned short op;
    unsigned short II,LSQ,WQ,bytes;
    bool en;
    char sched;
    bool discarded,kmode,sys_kmode;
    bool oor;
    bool chk(dmigen &gen,unsigned mop[],unsigned short lsq,
      unsigned short repl,unsigned short ret,bool *err);
    void poke(dmigen gen, unsigned mop[]);
} reqs[32][6]={0};

class dmigen {
    public:
    unsigned long *rng_addr;
    unsigned long *rng_size;
    unsigned short *rng_perm;
    unsigned rng_cnt;
    unsigned char *mem;
    unsigned long mem_sz;
    unsigned long ptbl_off;
    unsigned char II,LSQ,WQ,POS;
    bool kmode;
    void gen_ptbl();
    void gen_bndl(lsreq reqs[6]);
    unsigned long get_phys(unsigned long virt);
} gen;

void dmigen::gen_ptbl() {
    unsigned long brk=ptbl_off+16384,off,back=ptbl_off-8192;
    int n,n1;
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
            } else if (!val) {
                off=0xc0000000000ul;
                pe=(off&0xffffffffffffe000ul)|(rng_perm[n]&0xfffu);
                *ppe=pe;
                addr+=8192;
            }
        }
    }
}

void dmigen::gen_bndl(lsreq reqs[6]) {
    unsigned int n,cnt_st=0,rng,pge,sh,a;
    unsigned long addr,val,base,imm,index;
    unsigned cnt=lrand48()%6;
    unsigned map_size=0;
    reqs[0].en=0;
    reqs[1].en=0;
    reqs[2].en=0;
    reqs[3].en=0;
    reqs[4].en=0;
    reqs[5].en=0;
    reqs[0].discarded=0;
    reqs[1].discarded=0;
    reqs[2].discarded=0;
    reqs[3].discarded=0;
    reqs[4].discarded=0;
    reqs[5].discarded=0;
    reqs[0].kmode=0;
    reqs[1].kmode=0;
    reqs[2].kmode=0;
    reqs[3].kmode=0;
    reqs[4].kmode=0;
    reqs[5].kmode=0;
    reqs[0].sys_kmode=gen.kmode;
    reqs[1].sys_kmode=gen.kmode;
    reqs[2].sys_kmode=gen.kmode;
    reqs[3].sys_kmode=gen.kmode;
    reqs[4].sys_kmode=gen.kmode;
    reqs[5].sys_kmode=gen.kmode;
    reqs[0].oor=0;
    reqs[1].oor=0;
    reqs[2].oor=0;
    reqs[3].oor=0;
    reqs[4].oor=0;
    reqs[5].oor=0;
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
	if (!(lrand48()%100)) addr|=0x1fff;
        reqs[n].vaddr=addr;
        val=lrand48();
        if (val&1) {
            cnt_st++;
            if (cnt_st>2) {
                cnt_st--;
                val=val&0xfffffffeu;
                goto load;
            }
            reqs[n].op=store_op[(val>>1)%(sizeof store_op/sizeof store_op[0])].op;
            reqs[n].bytes=store_op[(val>>1)%(sizeof store_op/sizeof store_op[0])].sz;
            sh=store_op[(val>>1)%(sizeof store_op/sizeof store_op[0])].sh;
            reqs[n].II=(((unsigned)II)<<4)+n;
            reqs[n].LSQ=(((unsigned) LSQ)<<3)+n;
            reqs[n].WQ=WQ++;
        } else {
            load:
            reqs[n].op=load_op[(val>>1)%(sizeof load_op/sizeof load_op[0])].op;
            reqs[n].bytes=load_op[(val>>1)%(sizeof load_op/sizeof load_op[0])].sz;
            sh=load_op[(val>>1)%(sizeof load_op/sizeof load_op[0])].sh;
            reqs[n].II=(((unsigned) II)<<4)+n;
            reqs[n].LSQ=(((unsigned) LSQ)<<3)+n;
        }
        if (reqs[n].II&0xf000) {
            printf("iiness\n");
        }
        base=addr+lrand48()%65536-32768;
        index=(long int) lrand48()%65536-32768;
        if (!(reqs[n].op&0x40)) index=0;
        imm=addr-base-(index<<sh);
        if (sh==0) {
           // if (((val=lrand48())&0xffu)>128) {
                base|=0xf80ff00000000000;
                reqs[n].b_ptr=1;
                reqs[n].in_ptr=0;
           // } else /*if ((val&0xffu))*/ { 
           //     index|=0xf80fe00000000000;
           //     reqs[n].b_ptr=0;
           //     reqs[n].in_ptr=1;
           // }
          /*  }  else {
                base|=(lrand48()&0xfffffull)<<44;
                reqs[n].b_ptr=0;
                reqs[n].in_ptr=0;
            }*/
        } else {
           // if (lrand48()&0xffu) {
                base|=0xf80ff00000000000;
                reqs[n].b_ptr=1;
                reqs[n].in_ptr=0;
          /*  } else {
                index|=(lrand48()&0xfffffull)<<44;
                reqs[n].b_ptr=0;
                reqs[n].in_ptr=lrand48()&1;
            }*/
        }
        reqs[n].base=base;
        reqs[n].index=index;
        reqs[n].imm=imm;
        reqs[n].en=1;
        reqs[n].sched=0;
	extract(rng_perm[rng],page_sys,val);
	reqs[n].kmode=val;
	if (rng <(rng_cnt-1) && (reqs[n].vaddr+reqs[n].bytes-1)>=rng_addr[rng+1]) {
	    extract(rng_perm[rng+1],page_sys,val);
	    if (val) reqs[n].kmode=1;
	}
	if (rng ==(rng_cnt-1) && (reqs[n].vaddr+reqs[n].bytes-1)>=(rng_addr[rng]+rng_size[rng]*8192-1)) {
            reqs[n].oor=1;
	}
    }
    II++;
    if (cnt) LSQ++;
    if (II>47) II=0;
    LSQ&=0x1f;
}

void do_discard() {
    int n,n2;
    for(n=0;n<32;n++) {
	for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en && !(reqs[n][n2].op&1)) {
		reqs[n][n2].en=0;
	    }
	    if (reqs[n][n2].en && (reqs[n][n2].op&1) && reqs[n][n2].sched!=4 &&
		reqs[n][n2].sched!=2 && reqs[n][n2].sched!=7) {
		reqs[n][n2].en=0;
	    }
	}
    }
}

void do_discardX() {
    int n,n2;
    for(n=0;n<32;n++) {
	for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en && reqs[n][n2].sched==0) {
		reqs[n][n2].en=0;
	    }
	}
    }
}

void do_discardY(unsigned long addr) {
    int n,n2;
    for(n=0;n<32;n++) {
	for(n2=0;n2<6;n2++) {
	    if (reqs[n][n2].en && !(reqs[n][n2].op&1)) {
		if (gen.get_phys(reqs[n][n2].vaddr)>>7==addr ||
		    (gen.get_phys(reqs[n][n2].vaddr+reqs[n][n2].bytes-HUG))>>7==addr)
		    reqs[n][n2].discarded=1;
	    }
	}
    }
}


bool sched_MSI(Vagu_block *top, bool &err) {
    static unsigned long MSI_addr[27];
    static bool MSI_en[27];
    unsigned n,a;
    unsigned long addr,map_size=0,val,rng,pge;

    //if (MSI_en[27] && top->msi_out_clear) { 
    //    err=true;
//	printf("MSI ovl\n");
//        return false;	
 //   }
    if (MSI_en[0]) {
	do_discardY(MSI_addr[0]);
    }
    top->msi_en=0;
    if (top->msi_out_clear && lrand48()%10000<100) {
	for(n=26;n;n--) {
	    MSI_addr[n]=MSI_addr[n-1];
	    MSI_en[n]=MSI_en[n-1];
	}
        for(n=0;n<gen.rng_cnt;n++)
            map_size+=gen.rng_size[n];
        val=lrand48() % map_size;
        for(a=0;a<gen.rng_cnt;a++) {
            if (val<gen.rng_size[a]) {
                rng=a;
                pge=val;
                break;
            } else {
                val-=gen.rng_size[a];
            }
	}
	rng=a;
        
        addr=gen.rng_addr[rng]+pge*8192+(lrand48()&0x1fff);
	MSI_addr[0]=addr;
	MSI_en[0]=1;
	top->msi_exp_addr=gen.get_phys(addr)>>7;
	top->msi_en=1;
	printf("exx %lx\n",gen.get_phys(addr)>>7);
	//sleep(1);
    }
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
static bool sch_init=1;
bool sched(Vagu_block *top, bool &err2, int exc) {
    bool found=0;
    unsigned ind;
    static unsigned que_data4[3][7];
    static unsigned que_data5[3][7];
    static unsigned short que_LSQ4[3];
    static unsigned short que_LSQ5[3];
    static bool que_en4[3];
    static bool que_en5[3];
    static unsigned LSJ_pos;
    static unsigned LSJ_pos2;
    unsigned size,n,n2,n3,LSQ;
    unsigned long val;
    bool err;
    unsigned vals[7];
    static bool bhold;
    static bool wms=false;
    static bool stall0,stall1,stall2,stall,stallw;
    bool ret=false;
    static std::mt19937 rndgen(def_seed); 
    static std::uniform_int_distribution<unsigned> dist192(0,191);
    static std::uniform_int_distribution<unsigned> dist64(0,63);
    static unsigned wb[3]={0,0,0},wb2[3]={0,0,0};

    stall2=stall1;
    stall1=stall0||exc;
    stall0=stallw||exc;
    stall=top->pause_agu || top->miss_holds_agu || top->miss_pause_agu || bhold || top->insert_isData || exc;
    stallw=top->miss_holds_agu || top->miss_pause_agu || bhold || top->insert_isData || wms || exc;
    bhold=top->insert_isData;
    wms=wms||top->miss4 || top->miss5;
    if (top->mOp_write_clear) wms=false;

    err2=false;

    if (sch_init) {
        LSJ_pos=0;
        LSJ_pos2=0;
        for(n=0;n<3;n++) que_en4[n]=false;
        for(n=0;n<3;n++) que_en5[n]=false;
        sch_init=0;
    }
    wb[2]=wb[1];
    wb[1]=wb[0];
    wb2[2]=wb2[1];
    wb2[1]=wb2[0];
    if (!stall) {
        wb[0]=lrand48()&1;
	wb2[0]=lrand48()%3+1;
    } else {
	wb[0]=0;
	wb2[0]=0;
    }
    for(n=0;n<6;n++) if (reqs[gen.POS][n].en) break;
    if (n==6 && !exc) {
        gen.gen_bndl(&reqs[gen.POS] [0]);
	gen.POS++;
	gen.POS&=0x1f;
        printf("bndl\n");
        ret=true;
    }
    if (stall) {
        top->u1_clkEn=0;
        top->u2_clkEn=0;
        top->u3_clkEn=0;
        goto no_4;
    }
    while (!found) {
        ind=dist64(rndgen);
        if (reqs[ind>>1][3*(ind&1)].en && (!reqs[ind>>1][3*(ind&1)].sched) &&
            !(reqs[ind>>1][3*(ind&1)].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            top->u1_clkEn=0;
            goto no_2;
        }
    }
    set64i(top->u1_base,reqs[ind>>1][3*(ind&1)].base);
    top->u1_base[2]=reqs[ind>>1][3*(ind&1)].b_ptr;
    set64i(top->u1_index,reqs[ind>>1][3*(ind&1)].index);
    top->u1_index[2]=reqs[ind>>1][3*(ind&1)].in_ptr;
    top->u1_const=reqs[ind>>1][3*(ind&1)].imm;
    top->u1_clkEn=1;
    top->u1_op=reqs[ind>>1][3*(ind&1)].op;
    top->u1_LSQ_no=reqs[ind>>1][3*(ind&1)].LSQ;
    top->u1_WQ_no=reqs[ind>>1][3*(ind&1)].WQ;
    top->u1_II_no=reqs[ind>>1][3*(ind&1)].II;
    reqs[ind>>1][3*(ind&1)].sched=1;
    no_2:
    found=0;
    while (!found) {
        ind=dist64(rndgen);
        if (reqs[ind>>1][3*(ind&1)+1].en && (!reqs[ind>>1][3*(ind&1)+1].sched) &&
            !(reqs[ind>>1][3*(ind&1)+1].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            top->u2_clkEn=0;
            goto no_3;
        }
    }
    set64i(top->u2_base,reqs[ind>>1][3*(ind&1)+1].base);
    top->u2_base[2]=reqs[ind>>1][3*(ind&1)+1].b_ptr;
    set64i(top->u2_index,reqs[ind>>1][3*(ind&1)+1].index);
    top->u2_index[2]=reqs[ind>>1][3*(ind&1)+1].in_ptr;
    top->u2_const=reqs[ind>>1][3*(ind&1)+1].imm;
    top->u2_clkEn=1;
    top->u2_op=reqs[ind>>1][3*(ind&1)+1].op;
    top->u2_LSQ_no=reqs[ind>>1][3*(ind&1)+1].LSQ;
    top->u2_WQ_no=reqs[ind>>1][3*(ind&1)+1].WQ;
    top->u2_II_no=reqs[ind>>1][3*(ind&1)+1].II;
    reqs[ind>>1][3*(ind&1)+1].sched=1;
    no_3:
    found=0;
    while (!found) {
        ind=dist64(rndgen);
        if (reqs[ind>>1][3*(ind&1)+2].en && (!reqs[ind>>1][3*(ind&1)+2].sched) &&
            !(reqs[ind>>1][3*(ind&1)+2].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            top->u3_clkEn=0;
            goto no_4;
        }
    }
    set64i(top->u3_base,reqs[ind>>1][3*(ind&1)+2].base);
    top->u3_base[2]=reqs[ind>>1][3*(ind&1)+2].b_ptr;
    set64i(top->u3_index,reqs[ind>>1][3*(ind&1)+2].index);
    top->u3_index[2]=reqs[ind>>1][3*(ind&1)+2].in_ptr;
    top->u3_const=reqs[ind>>1][3*(ind&1)+2].imm;
    top->u3_clkEn=1;
    top->u3_op=reqs[ind>>1][3*(ind&1)+2].op;
    top->u3_LSQ_no=reqs[ind>>1][3*(ind&1)+2].LSQ;
    top->u3_WQ_no=reqs[ind>>1][3*(ind&1)+2].WQ;
    top->u3_II_no=reqs[ind>>1][3*(ind&1)+2].II;
    reqs[ind>>1][3*(ind&1)+2].sched=1;
    no_4:
    top->u4_clkEn=0;
    top->u5_clkEn=0;
    if (top->wt_pause_agu||exc) goto no_6;
    found=0;
    while (!found) {
        ind=dist192(rndgen);
        if (reqs[ind&0x1f][ind>>5].en && (!reqs[ind&0x1f][ind>>5].sched)&&
            (reqs[ind&0x1f][ind>>5].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            top->u4_clkEn=0;
            goto no_5;
        }
    }
    set64i(top->u4_base,reqs[ind&0x1f][ind>>5].base);
    top->u4_base[2]=reqs[ind&0x1f][ind>>5].b_ptr;
    set64i(top->u4_index,reqs[ind&0x1f][ind>>5].index);
    top->u4_index[2]=reqs[ind&0x1f][ind>>5].in_ptr;
    top->u4_const=reqs[ind&0x1f][ind>>5].imm;
    top->u4_clkEn=1;
    top->u4_op=reqs[ind&0x1f][ind>>5].op;
    top->u4_II_no=reqs[ind&0x1f][ind>>5].II;
    top->u4_WQ_no=reqs[ind&0x1f][ind>>5].WQ;
    top->u4_LSQ_no=reqs[ind&0x1f][ind>>5].LSQ;
    reqs[ind&0x1f][ind>>5].sched=1;
    no_5:
    found=0;
    while (!found) {
        ind=dist192(rndgen);
        if (reqs[ind&0x1f][ind>>5].en && (!reqs[ind&0x1f][ind>>5].sched)&&
            (reqs[ind&0x1f][ind>>5].op&1))
            found=1;
        if (dist192(rndgen)==0) {
            top->u5_clkEn=0;
            goto no_6;
        }
    }
    set64i(top->u5_base,reqs[ind&0x1f][ind>>5].base);
    top->u5_base[2]=reqs[ind&0x1f][ind>>5].b_ptr;
    set64i(top->u5_index,reqs[ind&0x1f][ind>>5].index);
    top->u5_index[2]=reqs[ind&0x1f][ind>>5].in_ptr;
    top->u5_const=reqs[ind&0x1f][ind>>5].imm;
    top->u5_clkEn=1;
    top->u5_op=reqs[ind&0x1f][ind>>5].op;
    top->u5_II_no=reqs[ind&0x1f][ind>>5].II;
    top->u5_WQ_no=reqs[ind&0x1f][ind>>5].WQ;
    top->u5_LSQ_no=reqs[ind&0x1f][ind>>5].LSQ;
    reqs[ind&0x1f][ind>>5].sched=1;
    no_6:
    top->mOpY4_en=que_en4[1];
    extract_e(que_data4[1],lsaddr_addrE,val);
    top->mOpY4_addrEven=val;
    extract_e(que_data4[1],lsaddr_addrO,val);
    top->mOpY4_addrOdd=val;
    extract_e(que_data4[1],lsaddr_odd,val);
    top->mOpY4_odd=val;
    extract_e(que_data4[1],lsaddr_split,val);
    top->mOpY4_split=val;
    extract_e(que_data4[1],lsaddr_bank0,val);
    top->mOpY4_bank0=val;
    extract_e(que_data4[1],lsaddr_banks,val);
    top->mOpY4_banks=val;
    extract_e(que_data4[1],lsaddr_low,val);
    top->mOpY4_addr_low=val;
    extract_e(que_data4[1],lsaddr_sz,val);
    top->mOpY4_sz=val;
    for(n=0;n<(sizeof store_op/sizeof store_op[0]); n++) {
        if (((store_op[n].op>>1)&0x1f)==val) goto found4;
    }
    printf("unknown opcode @store\n");
    sleep(1);
    n=0;
    found4:
    top->mOpY4_bgn_b=(0xf<<top->mOpY4_addr_low)&0xf;
    if (store_op[n].sz+top->mOpY4_addr_low<4)
        top->mOpY4_bgn_b&=0xf>>(4-store_op[n].sz-top->mOpY4_addr_low);
    top->mOpY4_end_b=0xf>>(4-((store_op[n].sz+top->mOpY4_addr_low)&0x3));
    if (store_op[n].sz+top->mOpY4_addr_low<4)
        top->mOpY4_end_b&=(0xf<<top->mOpY4_addr_low)&0xf;
    extract_e(que_data4[1],lsaddr_II,val);
    top->mOpY4_II=val;
    top->mOpY4_bank1=top->mOpY4_bank0+(top->mOpY4_addr_low+store_op[n].sz)/4;

    top->mOpY5_en=que_en5[1];
    extract_e(que_data5[1],lsaddr_addrE,val);
    top->mOpY5_addrEven=val;
    extract_e(que_data5[1],lsaddr_addrO,val);
    top->mOpY5_addrOdd=val;
    extract_e(que_data5[1],lsaddr_odd,val);
    top->mOpY5_odd=val;
    extract_e(que_data5[1],lsaddr_split,val);
    top->mOpY5_split=val;
    extract_e(que_data5[1],lsaddr_bank0,val);
    top->mOpY5_bank0=val;
    extract_e(que_data5[1],lsaddr_banks,val);
    top->mOpY5_banks=val;
    extract_e(que_data5[1],lsaddr_low,val);
    top->mOpY5_addr_low=val;
    extract_e(que_data5[1],lsaddr_sz,val);
    top->mOpY5_sz=val;
    for(n=0;n<(sizeof store_op/sizeof store_op[0]); n++) {
        if (((store_op[n].op>>1)&0x1f)==val) goto found5;
    }
    printf("unknown opcode @store\n");
    n=0;
    found5:
    top->mOpY5_bgn_b=(0xf<<top->mOpY5_addr_low)&0xf;
    if (store_op[n].sz+top->mOpY5_addr_low<4)
        top->mOpY5_bgn_b&=0xf>>(4-store_op[n].sz-top->mOpY5_addr_low);
    top->mOpY5_end_b=0xf>>(4-((store_op[n].sz+top->mOpY5_addr_low)&0x3));
    if (store_op[n].sz+top->mOpY5_addr_low<4)
        top->mOpY5_end_b&=(0xf<<top->mOpY5_addr_low)&0xf;
    extract_e(que_data5[1],lsaddr_II,val);
    top->mOpY5_II=val;
    top->mOpY5_bank1=top->mOpY5_bank0+(top->mOpY5_addr_low+store_op[n].sz)/4;
    no_Y:
    err=0;
    if (!top->p4_en || exc==10) goto skip4;
    LSQ=top->p4_LSQ;
    for(n=0;n<32;n++) {
        if (reqs[n][0].en && reqs[n][0].LSQ==LSQ && reqs[n][0].sched==1) {
            n2=0; break;
        }
        if (reqs[n][1].en && reqs[n][1].LSQ==LSQ && reqs[n][1].sched==1) {
            n2=1; break;
        }
        if (reqs[n][2].en && reqs[n][2].LSQ==LSQ && reqs[n][2].sched==1) {
            n2=2; break;
        }
        if (reqs[n][3].en && reqs[n][3].LSQ==LSQ && reqs[n][3].sched==1) {
            n2=3; break;
        }
        if (reqs[n][4].en && reqs[n][4].LSQ==LSQ && reqs[n][4].sched==1) {
            n2=4; break;
        }
        if (reqs[n][5].en && reqs[n][5].LSQ==LSQ && reqs[n][5].sched==1) {
            n2=5; break;
        }
    }
    err=n==32;
    if (n<32 && reqs[n][n2].chk(gen,top->p4_adata,top->p4_LSQ,0,top->p4_ret,&err) && !err) {
          reqs[n][n2].sched=3; //clear for Y4/5
	  if ((top->p4_ret&3)==1) {
	      reqs[n][n2].en=0;
	  }
    }
    if (err) printf("P4 ERROR @LSQ %3x, ii %3x\n",
        LSQ,n==32 ? 0xffff : reqs[n][n2].II);
    err2|=err;
    skip4:
    err=0;
    if (!top->p5_en || exc==10) goto skip5;
    LSQ=top->p5_LSQ;
    for(n=0;n<32;n++) {
        if (reqs[n][0].en && reqs[n][0].LSQ==LSQ && reqs[n][0].sched==1) {
            n2=0; break;
        }
        if (reqs[n][1].en && reqs[n][1].LSQ==LSQ && reqs[n][1].sched==1) {
            n2=1; break;
        }
        if (reqs[n][2].en && reqs[n][2].LSQ==LSQ && reqs[n][2].sched==1) {
            n2=2; break;
        }
        if (reqs[n][3].en && reqs[n][3].LSQ==LSQ && reqs[n][3].sched==1) {
            n2=3; break;
        }
        if (reqs[n][4].en && reqs[n][4].LSQ==LSQ && reqs[n][4].sched==1) {
            n2=4; break;
        }
        if (reqs[n][5].en && reqs[n][5].LSQ==LSQ && reqs[n][5].sched==1) {
            n2=5; break;
        }
    }
    err=n==32;
    if (n<32 && reqs[n][n2].chk(gen,top->p5_adata,top->p5_LSQ,0,top->p5_ret,&err) && !err) {
          reqs[n][n2].sched=3; //clear for Y4/5
	  if ((top->p5_ret&3)==1) {
	      reqs[n][n2].en=0;
	  }
    }
    if (err) printf("P5 ERROR @LSQ %3x, ii %3x\n",
        LSQ,n==32 ? 0xffff : reqs[n][n2].II);
    err2|=err;
    skip5:
    for(n=2;n;n--) {
        for(n2=0;n2<7;n2++) {
            que_data4[n][n2]=que_data4[n-1][n2];
            que_data5[n][n2]=que_data5[n-1][n2];
        }
        que_en4[n]=que_en4[n-1];
        que_en5[n]=que_en5[n-1];
        que_LSQ4[n]=que_LSQ4[n-1];
        que_LSQ5[n]=que_LSQ5[n-1];
    }
    if (stallw||exc) {
	que_en4[0]=false;
	que_en5[0]=false;
        return ret;
    }
    found=0;
    n2=LSJ_pos;
    n3=LSJ_pos2;
    while (!found) {
        if (!reqs[LSJ_pos][LSJ_pos2].en) {
            n=(LSJ_pos+1)&0x1f;
            if (LSJ_pos2==5) {
                LSJ_pos=(LSJ_pos+1)&0x1f;
                LSJ_pos2=0;
                if (LSJ_pos==n2) {LSJ_pos2=n3; break;}
            } else {
                LSJ_pos2++; 
            }
        } else if (reqs[LSJ_pos][LSJ_pos2].sched==3 && 
          reqs[LSJ_pos][LSJ_pos2].op&1) {
            found=true;
        } else {
            if (reqs[LSJ_pos][LSJ_pos2].op&1) break;
            if (++LSJ_pos2>5) {
                LSJ_pos=(LSJ_pos+1)&0x1f;
                LSJ_pos2=0;
            }
        }
    }
    que_en4[0]=found;
    que_en5[0]=0;
    if (!found) return ret;
    reqs[LSJ_pos][LSJ_pos2].poke(gen,vals);
    que_data4[0][0]=vals[0];
    que_data4[0][1]=vals[1];
    que_data4[0][2]=vals[2];
    que_data4[0][3]=vals[3];
    que_data4[0][4]=vals[4];
    que_data4[0][5]=vals[5];
    que_LSQ4[0]=reqs[LSJ_pos][LSJ_pos2].LSQ;
    reqs[LSJ_pos][LSJ_pos2].sched=4;
    if (++LSJ_pos2>5) {
        LSJ_pos=(LSJ_pos+1)&0x1f;
        LSJ_pos2=0;
    }
    

    n2=LSJ_pos;
    n3=LSJ_pos2;
    found=0;
    while (!found) {
        if (!reqs[LSJ_pos][LSJ_pos2].en) {
            n=(LSJ_pos+1)&0x1f;
            if (LSJ_pos2==5) {
                LSJ_pos=(LSJ_pos+1)&0x1f;
                LSJ_pos2=0;
                if (LSJ_pos==n2) {LSJ_pos2=n3; break;}
            } else {
                LSJ_pos2++;
            }
        } else if (reqs[LSJ_pos][LSJ_pos2].sched==3 && 
          reqs[LSJ_pos][LSJ_pos2].op&1) {
            found=true;
        } else {
            if (reqs[LSJ_pos][LSJ_pos2].op&1) break;
            if (++LSJ_pos2>5) {
                LSJ_pos=(LSJ_pos+1)&0x1f;
                LSJ_pos2=0;
            }
        }
    }
    que_en5[0]=found;
    if (!found) return ret;
    reqs[LSJ_pos][LSJ_pos2].poke(gen,vals);
    que_data5[0][0]=vals[0];
    que_data5[0][1]=vals[1];
    que_data5[0][2]=vals[2];
    que_data5[0][3]=vals[3];
    que_data5[0][4]=vals[4];
    que_data5[0][5]=vals[5];
    que_LSQ5[0]=reqs[LSJ_pos][LSJ_pos2].LSQ;
    reqs[LSJ_pos][LSJ_pos2].sched=4;
    if (++LSJ_pos2>5) {
        LSJ_pos=(LSJ_pos+1)&0x1f;
        LSJ_pos2=0;
    }

    return ret;
}

bool can_ins() {
    int n;
    for(n=0;n<6;n++) {
        if (reqs[gen.LSQ][n].en) 
            return false;
    }
    return true;
}


bool lsreq::chk(dmigen &gen,unsigned mop[],unsigned short lsq,unsigned short repl,
    unsigned short ret,bool *err) {
    bool odd=(vaddr&0x80)>>7;
    bool split=((vaddr&0x7f)+bytes-HUG)>=0x80;
    unsigned long val,phys=gen.get_phys(vaddr),phys2=gen.get_phys(vaddr+bytes-HUG);
    extract_e(mop,lsaddr_WQ,val);
    if (val!=WQ && (op&1)) { printf("WQ\n"); return false; }
    extract_e(mop,lsaddr_II,val);
    if (val!=II) {
        printf("II\n");
        return false; 
    }
    //extract_e(mop,lsaddr_LSQ,val);
    if (lsq!=LSQ) { printf("LSQ\n"); return false; }
    if (repl && !discarded && !(op&1)) *err=1;
    if (discarded && !repl && !(op&1)) *err=1;
    if ((!sys_kmode && kmode)||oor) {
        if ((ret&3)!=1) *err=1;
    } else {
        if ((ret&3)==1) {
           printf("<cann> %lx\n",vaddr);
	   sleep(1);
	   *err=1;
	}
    }
    if (*err) printf("EX\n");
    extract_e(mop,lsaddr_addrE,val);
    if ((!odd) && val!=(phys>>8) && (ret&3)!=1)  { printf("AE\n");*err=1;}
    if (odd && split && val!=(phys2>>8) && (ret&3)!=1) { printf("AE\n");*err=1;}
    extract_e(mop,lsaddr_addrO,val);
    if (odd && val!=(phys>>8) && (ret&3)!=1) { printf("AO\n"); *err=1; }
    if ((!odd) && split && val!=(phys2>>8) && (ret&3)!=1) { printf("AO\n"); *err=1; }
    extract_e(mop,lsaddr_low,val);
    if (val!=(phys&3)) { printf("Al\n"); *err=1; }
    extract_e(mop,lsaddr_bank0,val);
    if (val!=((phys>>2)&0x1f)) { printf("Ab0\n"); *err=1; }
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
    if (val!=banks) { printf("BNK\n"); *err=1; }
    return true;
}

void lsreq::poke(dmigen gen, unsigned mop[]) {
    unsigned long addr=gen.get_phys(vaddr);
    unsigned long addr2=gen.get_phys(vaddr+bytes-HUG);
    deposit_e(mop,lsaddr_WQ,WQ);
    deposit_e(mop,lsaddr_II,II);
    deposit_e(mop,lsaddr_reg_hi,0);
    deposit_e(mop,lsaddr_reg_low,0);
    deposit_e(mop,lsaddr_bank0,(vaddr>>2)&0x1f);
    deposit_e(mop,lsaddr_low,vaddr&3);
    deposit_e(mop,lsaddr_odd,(vaddr>>7)&1);
    deposit_e(mop,lsaddr_split,(vaddr>>8)!=((vaddr+bytes-HUG)>>8));
    deposit_e(mop,lsaddr_sz,(op>>1)&0x1f);
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

bool get_check(Vagu_block *top, int exc) {
    bool err[6];
    unsigned LSQ;
    unsigned long val;
    unsigned vals[7];
    unsigned n,n2=0;
    static bool FU0Hit[3],FU1Hit[3],FU2Hit[3],FU3Hit[3];
    static unsigned FU3_data[3][4];
    static unsigned short FU3Reg[3];
    static bool wms=0,Y4Hit[3],Y5Hit[3],Y4En[3],Y5En[3];
    static unsigned Y4_n[3],Y4_n2[3],Y5_n[3],Y5_n2[3];
    bool ret=0;
    static std::mt19937 rndgen(def_seed); 
    static std::uniform_int_distribution<unsigned> dist(0,200);

    if (exc==10) {
	FU0Hit[0]=0;
	FU1Hit[0]=0;
	FU2Hit[0]=0;
        if (FU3Reg[0]!=0x1fc) FU3Hit[0]=0;
    }
    top->FU0Hit=FU0Hit[1];
    top->FU1Hit=FU1Hit[1];
    top->FU2Hit=FU2Hit[1];
    top->FU3Hit=FU3Hit[1];
    top->mOpY4_hit=Y4Hit[2];
    top->mOpY4_clHit=3*(Y4Hit[2]);
    top->miss4=((!Y4Hit[2])||wms)&&Y4En[2];
    wms=(Y4En[2]&&!Y4Hit[2])||wms;
    top->mOpY5_hit=Y5Hit[2];
    top->mOpY5_clHit=3*(Y5Hit[2]);
    top->miss5=((!Y5Hit[2])||wms)&&Y5En[2];
    wms=(Y5En[2]&&!Y5Hit[2])||wms;
    if ((!top->miss4) && Y4Hit[2]) reqs[Y4_n[2]][Y4_n2[2]].en=0;
    if ((!top->miss5) && Y5Hit[2]) reqs[Y5_n[2]][Y5_n2[2]].en=0;
    if (top->mOp_write_clear) wms=0;

    top->dc_rdataA[0]=FU3_data[1][0];
    top->dc_rdataA[1]=FU3_data[1][1];
    top->dc_rdataA[2]=FU3_data[1][2];
    top->dc_rdataA[3]=FU3_data[1][3];
    top->FUreg3_reg=FU3Reg[1];

    for(n=2;n;n--) {
        Y4Hit[n]=Y4Hit[n-1];
        Y5Hit[n]=Y5Hit[n-1];
        Y4En[n]=Y4En[n-1];
        Y5En[n]=Y5En[n-1];
        Y4_n[n]=Y4_n[n-1];
        Y5_n[n]=Y5_n[n-1];
        Y4_n2[n]=Y4_n2[n-1];
        Y5_n2[n]=Y5_n2[n-1];
        FU0Hit[n]=FU0Hit[n-1];
        FU1Hit[n]=FU1Hit[n-1];
        FU2Hit[n]=FU2Hit[n-1];
        FU3Hit[n]=FU3Hit[n-1];
        FU3Reg[n]=FU3Reg[n-1];
        FU3_data[n][0]=FU3_data[n-1][0];
        FU3_data[n][1]=FU3_data[n-1][1];
        FU3_data[n][2]=FU3_data[n-1][2];
        FU3_data[n][3]=FU3_data[n-1][3];
    }
    Y4En[0]=top->mOpY4_en_o;
    Y5En[0]=top->mOpY5_en_o;
    Y4Hit[0]=0;
    Y5Hit[0]=0;
    FU0Hit[0]=0;
    FU1Hit[0]=0;
    FU2Hit[0]=0;
    FU3Hit[0]=0;
    FU3Reg[0]=0;

    LSQ=top->p0_LSQ;
    if ((!top->p0_en && !(top->p0_rsEn && top->p0_lsfwd)) && !(top->p0_ret&0x3==1)) goto label_p1;
    if (exc==10) goto label_p1;
    for(n=0;n<32;n++) {
        if (reqs[n][0].en && reqs[n][0].LSQ==LSQ && (reqs[n][0].sched==1
	    ||reqs[n][0].sched==2||reqs[n][0].sched==7) &&!(reqs[n][0].op&0x1)) {
            n2=0; break;
        }
        if (reqs[n][3].en && reqs[n][3].LSQ==LSQ && (reqs[n][3].sched==1
	    || reqs[n][3].sched==2||reqs[n][3].sched==7)&&!(reqs[n][3].op&0x1)) {
            n2=3; break;
        }
    }
    err[n2]=n==32;
    if (n<32 && reqs[n][n2].chk(gen,top->p0_adata,top->p0_LSQ,top->p0_repl,top->p0_ret,
	&err[n2]) && !err[n2]) {
        if (reqs[n][n2].flag && reqs[n][n2].sched==1) {
	    reqs[n][n2].flag=0;
	    FU0Hit[0]=0;
	} else if ((dist(rndgen)||(top->p0_ret&3)==1) && reqs[n][n2].sched==1) {
          reqs[n][n2].en=0;
          FU0Hit[0]=1;
        } else {
	  if (reqs[n][n2].sched==1) reqs[n][n2].sched=2; //miss queued
          printf("miss0 %lx\n",gen.get_phys(reqs[n][n2].vaddr)>>8);
          //printf("miss\n");
        }
    }
    if (err[n2]) printf("ERROR @LSQ %3x, ii %3x, lane %1x\n",
        LSQ,reqs[n][n2].II,n2);
    if (top->p0_ret&0x3==1) printf("EXCPT @LSQ %3x, ii %3x, lane %1x\n",
        LSQ,reqs[n][n2].II,n2);
    //printf("Reg0: LSQ %x\n",LSQ);
    ret|=err[n2];
    label_p1:
    LSQ=top->p1_LSQ;
    if ((!top->p1_en && !(top->p1_rsEn && top->p1_lsfwd)) && !(top->p1_ret&0x3==1)) goto label_p2;
    if (exc==10) goto label_p2;
    for(n=0;n<32;n++) {
        if (reqs[n][1].en && reqs[n][1].LSQ==LSQ && (reqs[n][1].sched==1
	    || reqs[n][1].sched==2||reqs[n][1].sched==7)&&!(reqs[n][1].op&0x1)) {
            n2=1; break;
        }
        if (reqs[n][4].en && reqs[n][4].LSQ==LSQ && (reqs[n][4].sched==1
	    || reqs[n][4].sched==2||reqs[n][4].sched==7)&&!(reqs[n][4].op&0x1)) {
            n2=4; break;
        }
    }
    err[n2]=n==32;
    if (n<32 && reqs[n][n2].chk(gen,top->p1_adata,top->p1_LSQ,top->p1_repl,top->p1_ret,
	&err[n2]) && !err[n2]) {
        if (reqs[n][n2].flag && reqs[n][n2].sched==1) {
	    reqs[n][n2].flag=0;
	    FU1Hit[0]=0;
	} else if ((dist(rndgen)||(top->p1_ret&3)==1) && reqs[n][n2].sched==1) {
          reqs[n][n2].en=0;
          FU1Hit[0]=1;
        } else {
	  if (reqs[n][n2].sched==1) reqs[n][n2].sched=2; //miss queued
          printf("miss1 %lx\n",gen.get_phys(reqs[n][n2].vaddr)>>8);
          //printf("miss\n");
        }
    }
    if (err[n2]) printf("ERROR @LSQ %3x, ii %3x, lane %1x\n",
        LSQ,reqs[n][n2].II,n2);
    if (top->p1_ret&0x3==1) printf("EXCPT @LSQ %3x, ii %3x, lane %1x\n",
        LSQ,reqs[n][n2].II,n2);
    //printf("Reg1: LSQ %x\n",LSQ);
    ret|=err[n2];
    label_p2:
    LSQ=top->p2_LSQ;
    if ((!top->p2_en && !(top->p2_rsEn && top->p2_lsfwd)) && !(top->p2_ret&0x3==1)) goto label_p3;
    if (exc==10) goto label_p3;
    for(n=0;n<32;n++) {
        if (reqs[n][2].en && reqs[n][2].LSQ==LSQ && (reqs[n][2].sched==1
	    || reqs[n][2].sched==2||reqs[n][2].sched==7)&&!(reqs[n][2].op&0x1)) {
            n2=2; break;
        }
        if (reqs[n][5].en && reqs[n][5].LSQ==LSQ && (reqs[n][5].sched==1
	    || reqs[n][5].sched==2||reqs[n][5].sched==7)&&!(reqs[n][5].op&0x1)) {
            n2=5; break;
        }
    }
    err[n2]=n==32;
    if (n<32 && reqs[n][n2].chk(gen,top->p2_adata,top->p2_LSQ,top->p2_repl,top->p2_ret,
	&err[n2]) && !err[n2]) {
        if (reqs[n][n2].flag && reqs[n][n2].sched==1) {
	    reqs[n][n2].flag=0;
	    FU2Hit[0]=0;
	} else if ((dist(rndgen)||(top->p2_ret&3)==1) && reqs[n][n2].sched==1) {
          reqs[n][n2].en=0;
          FU2Hit[0]=1;
        } else {
	  if (reqs[n][n2].sched==1) reqs[n][n2].sched=2; //miss queued
          printf("miss2 %lx\n",gen.get_phys(reqs[n][n2].vaddr)>>8);
          //printf("miss\n");
        }
    }
    if (err[n2]) printf("ERROR @LSQ %3x, ii %3x, lane %1x\n",
        LSQ,reqs[n][n2].II,n2);
    if (top->p2_ret&0x3==1) printf("EXCPT @LSQ %3x, ii %3x, lane %1x\n",
        LSQ,reqs[n][n2].II,n2);
    //printf("Reg2: LSQ %x\n",LSQ);
    ret|=err[n2];
    label_p3:
    LSQ=top->p3_LSQ;
    if ((!top->p3_en)  && !(top->p3_ret&0x3==1)) goto label_Y4;
    if (exc==10) goto label_Y4;
    extract_e(top->p3_adata,lsaddr_reg_low,val);
    if (val>8) goto label_Y4;
    //printf("match p3\n");
    for(n=0;n<32;n++) {
        if (reqs[n][0].en && reqs[n][0].LSQ==LSQ && (reqs[n][0].sched==1
	    || reqs[n][0].sched==2||reqs[n][0].sched==7)&&!(reqs[n][0].op&0x1)) {
            n2=0; break;
        }
        if (reqs[n][1].en && reqs[n][1].LSQ==LSQ && (reqs[n][1].sched==1
	    || reqs[n][1].sched==2||reqs[n][1].sched==7)&&!(reqs[n][1].op&0x1)) {
            n2=1; break;
        }
        if (reqs[n][2].en && reqs[n][2].LSQ==LSQ && (reqs[n][2].sched==1
	    || reqs[n][2].sched==2||reqs[n][2].sched==7)&&!(reqs[n][2].op&0x1)) {
            n2=2; break;
        }
        if (reqs[n][3].en && reqs[n][3].LSQ==LSQ && (reqs[n][3].sched==1
	    || reqs[n][3].sched==2||reqs[n][3].sched==7)&&!(reqs[n][3].op&0x1)) {
            n2=3; break;
        }
        if (reqs[n][4].en && reqs[n][4].LSQ==LSQ && (reqs[n][4].sched==1
	    || reqs[n][4].sched==2||reqs[n][4].sched==7)&&!(reqs[n][4].op&0x1)) {
            n2=4; break;
        }
        if (reqs[n][5].en && reqs[n][5].LSQ==LSQ && (reqs[n][5].sched==1
	    || reqs[n][5].sched==2||reqs[n][5].sched==7)&&!(reqs[n][5].op&0x1)) {
            n2=5; break;
        }
    }
    err[n2]=n==32;
    if (n<32 && reqs[n][n2].chk(gen,top->p3_adata,top->p3_LSQ,top->p3_repl,top->p3_ret,
	&err[n2]) && !err[n2]) {
        if ((dist(rndgen)||(top->p3_ret&3))==1 && reqs[n][n2].sched==1) {
          reqs[n][n2].en=0;
          FU3Hit[0]=1;
        } else {
	  if (reqs[n][n2].sched==1) reqs[n][n2].sched=2; //miss queued
          printf("miss3 %lx\n",gen.get_phys(reqs[n][n2].vaddr)>>8);
          //printf("miss\n");
        }
    } else if (n<32 && !err[n2]) {
        printf("garbage\n");
        sleep(1);
    }
    if (err[n2]) printf("ERROR3 @LSQ %3x, ii %3x, lane %1x\n",
        LSQ,n==32 ? 0xffff : reqs[n][n2].II,n2);
    if (top->p3_ret&0x3==1) printf("EXCPT3 @LSQ %3x, ii %3x, lane %1x\n",
        LSQ,reqs[n][n2].II,n2);
    ret|=err[n2];
    label_Y4:
    LSQ=top->mOpY4_II_o;
    if (!top->mOpY4_en_o) goto label_Y5;
    for(n=0;n<32;n++) {
        if (reqs[n][0].en && reqs[n][0].II==LSQ && (reqs[n][0].sched==4
	    || reqs[n][0].sched==2 || reqs[n][0].sched==7)&&(reqs[n][0].op&0x1)) {
            n2=0; break;
        }
        if (reqs[n][1].en && reqs[n][1].II==LSQ && (reqs[n][1].sched==4
            || reqs[n][1].sched==2 || reqs[n][1].sched==7)&&(reqs[n][1].op&0x1)) {
            n2=1; break;
        }
        if (reqs[n][2].en && reqs[n][2].II==LSQ && (reqs[n][2].sched==4
	    || reqs[n][2].sched==2 || reqs[n][2].sched==7)&&(reqs[n][2].op&0x1)) {
            n2=2; break;
        }
        if (reqs[n][3].en && reqs[n][3].II==LSQ && (reqs[n][3].sched==4
	    || reqs[n][3].sched==2 || reqs[n][3].sched==7)&&(reqs[n][3].op&0x1)) {
            n2=3; break;
        }
        if (reqs[n][4].en && reqs[n][4].II==LSQ && (reqs[n][4].sched==4
	    || reqs[n][4].sched==2 || reqs[n][4].sched==7)&&(reqs[n][4].op&0x1)) {
            n2=4; break;
        }
        if (reqs[n][5].en && reqs[n][5].II==LSQ && (reqs[n][5].sched==4
	    || reqs[n][5].sched==2 || reqs[n][5].sched==7)&&(reqs[n][5].op&0x1)) {
            n2=5; break;
        }
    }
    err[n2]=n==32;
    deposit_e(vals,lsaddr_addrE,top->mOpY4_addrEven_o);
    deposit_e(vals,lsaddr_addrO,top->mOpY4_addrOdd_o);
    deposit_e(vals,lsaddr_WQ,reqs[n][n2].WQ);
    deposit_e(vals,lsaddr_II,top->mOpY4_II_o);
    deposit_e(vals,lsaddr_banks,top->mOpY4_banks_o);
    deposit_e(vals,lsaddr_bank0,top->mOpY4_bank0_o);
    deposit_e(vals,lsaddr_low,top->mOpY4_addr_low_o);
    deposit_e(vals,lsaddr_st,1);
    //deposit_e(vals,lsaddr_addrE,top->mOpY4_addrEven_o);
    if (n<32 && reqs[n][n2].chk(gen,vals,reqs[n][n2].LSQ,0,2,&err[n2]) && !err[n2]) {
	Y4_n[0]=n;
	Y4_n2[0]=n2;
	Y4En[0]=1;
        if (dist(rndgen) && reqs[n][n2].sched==4) {
          //reqs[n][n2].en=0;
          Y4Hit[0]=1;
        } else {
          reqs[n][n2].sched=reqs[n][n2].sched==7 ? 7 : 2; //miss queued
          printf("miss %lx\n",gen.get_phys(reqs[n][n2].vaddr)>>8);
        }
    } else {
	Y4En[0]=0;
    }
    if (err[n2]) printf("ERROR @LSQ %3x, ii %3x,store\n",
        LSQ,n==32 ? 0xfeed : reqs[n][n2].II);
    ret|=err[n2];
    label_Y5:
    LSQ=top->mOpY5_II_o;
    if (!top->mOpY5_en_o) goto label_Y;
    for(n=0;n<32;n++) {
        if (reqs[n][0].en && reqs[n][0].II==LSQ && (reqs[n][0].sched==4
	    || reqs[n][0].sched==2 || reqs[n][0].sched==7)&&(reqs[n][0].op&0x1)) {
            n2=0; break;
        }
        if (reqs[n][1].en && reqs[n][1].II==LSQ && (reqs[n][1].sched==4
	    || reqs[n][1].sched==2 || reqs[n][1].sched==7)&&(reqs[n][1].op&0x1)) {
            n2=1; break;
        }
        if (reqs[n][2].en && reqs[n][2].II==LSQ && (reqs[n][2].sched==4
	    || reqs[n][2].sched==2 || reqs[n][2].sched==7)&&(reqs[n][2].op&0x1)) {
            n2=2; break;
        }
        if (reqs[n][3].en && reqs[n][3].II==LSQ && (reqs[n][3].sched==4
	    || reqs[n][3].sched==2 || reqs[n][3].sched==7)&&(reqs[n][3].op&0x1)) {
            n2=3; break;
        }
        if (reqs[n][4].en && reqs[n][4].II==LSQ && (reqs[n][4].sched==4
	    || reqs[n][4].sched==2 || reqs[n][4].sched==7)&&(reqs[n][4].op&0x1)) {
            n2=4; break;
        }
        if (reqs[n][5].en && reqs[n][5].II==LSQ && (reqs[n][5].sched==4
	    || reqs[n][5].sched==2 || reqs[n][5].sched==7)&&(reqs[n][5].op&0x1)) {
            n2=5; break;
        }
    }
    err[n2]=n==32;
    deposit_e(vals,lsaddr_addrE,top->mOpY5_addrEven_o);
    deposit_e(vals,lsaddr_addrO,top->mOpY5_addrOdd_o);
    deposit_e(vals,lsaddr_WQ,reqs[n][n2].WQ);
    deposit_e(vals,lsaddr_II,top->mOpY5_II_o);
    deposit_e(vals,lsaddr_banks,top->mOpY5_banks_o);
    deposit_e(vals,lsaddr_bank0,top->mOpY5_bank0_o);
    deposit_e(vals,lsaddr_low,top->mOpY5_addr_low_o);
    deposit_e(vals,lsaddr_st,1);
    //deposit_e(vals,lsaddr_addrE,top->mOpY4_addrEven_o);
    if (n<32 && reqs[n][n2].chk(gen,vals,reqs[n][n2].LSQ,0,2,&err[n2]) && !err[n2]) {
	Y5_n[0]=n;
	Y5_n2[0]=n2;
	Y5En[0]=1;
        if (dist(rndgen) && reqs[n][n2].sched==4) {
          //reqs[n][n2].en=0;
          Y5Hit[0]=1;
        } else {
          reqs[n][n2].sched=reqs[n][n2].sched==7 ? 7 : 2; //miss queued
          printf("miss %lx\n",gen.get_phys(reqs[n][n2].vaddr)>>8);
        }
    } else {
	Y5En[0]=0;
    }
    if (err[n2]) printf("ERROR @LSQ %3x, ii %3x,store\n",
        LSQ,n==32 ? 0xf00d : reqs[n][n2].II);
    ret|=err[n2];
    label_Y:
    if (top->p3_en) {
          unsigned long addr;
          extract_e(top->p3_adata,lsaddr_low,val);
          addr=val;
          extract_e(top->p3_adata,lsaddr_bank0,val);
          addr|=val<<2;
          extract_e(top->p3_adata,lsaddr_odd,val);
          addr|=val<<7;
          if (val) {
              extract_e(top->p3_adata,lsaddr_addrO,val);
              addr|=val<<8;
          } else {
              extract_e(top->p3_adata,lsaddr_addrE,val);
              addr|=val<<8;
          }
          extract_e(top->p3_adata,lsaddr_reg_hi,val);
          FU3Reg[0]=val<<4;
          extract_e(top->p3_adata,lsaddr_reg_low,val);
          FU3Reg[0]|=val;
	  if (FU3Reg[0]==0x1fc) {
              FU3_data[0][0]=*((unsigned *)(gen.mem+addr));
              FU3_data[0][1]=*((unsigned *)(gen.mem+addr+4));
              if (!(addr&0x8)) {
                  FU3_data[0][2]=*((unsigned *)(gen.mem+addr+8));
                  FU3_data[0][3]=*((unsigned *)(gen.mem+addr+12));
              }
	  }
          //printf("Reg: %x, %lx, %8x%8x\n",FU3Reg[0],addr,FU3_data[0][1],FU3_data[0][0]);
          if (val==0xc) FU3Hit[0]=1;
    }
    return ret;
}

bool sched_cl_init=true;

void sched_cl(Vagu_block *top, bool check, int exc) {
    static unsigned long addr[32];
    static bool addr_en[32];
    static bool addr_io[32];
    static unsigned short addr_req[32];
    static bool addr_noerr[32];
    static bool ioaddr_en[5];
    unsigned n,n2;
    bool err=true;
    if (check) goto l_check;

    if (sched_cl_init) {
        for(n=0;n<32;n++)
            addr_en[n]=false;
        sched_cl_init=false;
    }
    if (ioaddr_en[5]) {
        top->p3_io_ack=1;
        printf("ioe\n");
    } else {
        top->p3_io_ack=0;
    }
    for(n=4;n;n--) {
        ioaddr_en[n]=ioaddr_en[n-1];
    }
    top->insert_isData=0;
    ioaddr_en[0]=0;
    if (addr_en[31]) {
        for(n=0;n<32;n++)
            for(n2=0;n2<6;n2++) {
                if ((reqs[n][n2].en && reqs[n][n2].sched==2 || reqs[n][n2].en && reqs[n][n2].sched==7) &&
                    (
		     ((gen.get_phys(reqs[n][n2].vaddr)>>7)==addr[31]) ||
		     ((gen.get_phys(reqs[n][n2].vaddr+reqs[n][n2].bytes-HUG)>>7)==addr[31]) 
		    )) {
                    err=false;
		    if ((gen.get_phys(reqs[n][n2].vaddr)>>7)!=
		        (gen.get_phys(reqs[n][n2].vaddr+reqs[n][n2].bytes-HUG)>>7)) {
			if (reqs[n][n2].sched==2) { reqs[n][n2].sched=7;
			} else {
			    reqs[n][n2].sched=(reqs[n][n2].op&0x1) ? 4 : 1;
			    if (reqs[n][n2].discarded) reqs[n][n2].en=0;
			}
		    } else {
                        reqs[n][n2].sched=(reqs[n][n2].op&0x1) ? 4 : 1;
			if (reqs[n][n2].discarded) reqs[n][n2].en=0;
		    }
                }
            }
        top->insert_isData=1;
        top->insBus_req=addr_req[31];
        if (addr_io[31]) {
            ioaddr_en[0]=1;
        }
        if (err && !addr_noerr[31]) {
            printf("insBusE %x,%lx\n",addr_req[31],addr[31]/2);
            sleep(1);
        } else {
            printf("sbus  %x,%lx\n",addr_req[31],addr[31]/2);
        }
    }
    for(n=31;n;n--) {
        addr[n]=addr[n-1];
        addr_en[n]=addr_en[n-1];
        addr_io[n]=addr_io[n-1];
        addr_req[n]=addr_req[n-1];
        addr_noerr[n]=addr_noerr[n-1];
    }
    return;
    l_check:
    addr_en[0]=false;
    addr_noerr[0]=false;
    if (top->reqBus_en) {
        addr[0]=top->reqBus_addr;
        addr_en[0]=true;
        addr_io[0]=top->reqBus_io;
        addr_req[0]=top->reqBus_req;
	addr_noerr[0]=exc>0;
        printf("reqBus %lx:%x:%x\n",top->reqBus_addr*8,top->reqBus_req,top->reqBus_io);
        //sleep(1);
    }
}

int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);
    Vagu_block *top=new Vagu_block();
    Verilated::assertOn(false);
    int initcount=512;
    long int cyc0=0;
    int stall_cnt=0;
    int exc=0;
    unsigned short perm_normal=(1<<(page_na));
    unsigned short perm_io=(1<<(page_na))|(1<<(page_nc))|0x2000;
    unsigned short perm_glob=(1<<(page_na))|(1<<(page_global));
    unsigned short perm_sys=(1<<(page_na))|(1<<(page_sys));
    static unsigned long rng_addr[]={0xdeadc00000,0xdeade00000,0xdeade02000,0xdeadffe000};
    static unsigned long rng_size[]={256,1,254,1};
    static unsigned short rng_perm[]={perm_normal,perm_io,perm_glob,perm_sys};
    unsigned long bndl=0;
    bool err2;
    std::mt19937 rndgen(def_seed); 
    std::uniform_int_distribution<unsigned> dist(0,1000);

    srand48(def_seed);
    //rndgen.seed();
    gen.rng_addr=rng_addr;
    gen.rng_size=rng_size;
    gen.rng_perm=rng_perm;
    gen.rng_cnt=4;
    gen.kmode=1;
    gen.mem=(unsigned char *)malloc(64*1024*1024);
    memset(gen.mem,64*1024*1024,0);
    gen.ptbl_off=32*1024*1024;
    gen.mem_sz=64*1024*1024;
    gen.II=0;
    gen.LSQ=0;
    gen.WQ=0;
    gen.gen_ptbl();
    top->rst=1;
    top->except=0;
    top->eval();
    top->clk=1;
    top->eval();
    top->rst=0;
    top->u1_base_fufwd=0xf;
    top->u1_base_fuufwd=0xf;
    top->u1_index_fufwd=0xf;
    top->u1_index_fuufwd=0xf;
    top->u2_base_fufwd=0xf;
    top->u2_base_fuufwd=0xf;
    top->u2_index_fufwd=0xf;
    top->u2_index_fuufwd=0xf;
    top->u3_base_fufwd=0xf;
    top->u3_base_fuufwd=0xf;
    top->u3_index_fufwd=0xf;
    top->u3_index_fuufwd=0xf;
    top->u4_base_fufwd=0xf;
    top->u4_base_fuufwd=0xf;
    top->u4_index_fufwd=0xf;
    top->u4_index_fuufwd=0xf;
    top->u5_base_fufwd=0xf;
    top->u5_base_fuufwd=0xf;
    top->u5_index_fufwd=0xf;
    top->u5_index_fuufwd=0xf;
    while (!Verilated::gotFinish()) {
        top->clk=0;
        top->eval();
        top->eval();
        top->clk=1;
        top->eval();
        if (!initcount) {
	    if (dist(rndgen)==0 && !exc) {
	       exc=10;
	       top->except=1;
	       printf("excpt %i\n",cyc0);
	       do_discard();
	       top->excpt_in_km=lrand48()&1;
	       top->excpt_gate=1;
	       top->eval();
	    }
            if (exc==9||exc==8||exc==7) {
                static bool km,km2;
	        gen.kmode=km2 && exc==7;
	        km2=km;
	        km=top->excpt_in_km;
		top->except=0;
	        top->excpt_in_km=0;
	        top->excpt_gate=0;
	        top->eval();
	    }
            if (exc==9) {
//		do_discard();
	    }
            if (sched(top,err2,exc))  { bndl++; stall_cnt=0; } 
	    else {
	        if((++stall_cnt)>=20000)  {
		    err2=true;
		    printf("bndl error 20000\n");
		}
	    }
            sched_cl(top,false,exc);
	    sched_MSI(top,err2);
        }
        if (initcount==10) {
            top->csrss_en=1;
            top->csrss_data=((gen.ptbl_off>>13)+1)|0x8ccccc0000000000;
            top->csrss_addr=csr_page;
        }
        if (initcount==9) {
            top->csrss_en=1;
            top->csrss_data=1<<(mflags_pg);
            top->csrss_addr=csr_mflags;
        }
        if (initcount==8) {
            top->csrss_en=1;
            top->csrss_data=(gen.ptbl_off>>13)|0x8ccccc0000000000;
            top->csrss_addr=csr_page0;
        }
        if (initcount==7) {
            top->csrss_en=0;
            top->csrss_data=0;
            top->csrss_addr=0;
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
            sched_cl(top,!false,exc);
	    if (exc) exc--;
        }
        if (initcount) initcount--;
        cyc0++;
    }

}
