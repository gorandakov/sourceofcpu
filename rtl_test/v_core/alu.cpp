#include <cstdlib>
#include <cfenv>
#include <cstdio>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include "Vheptane_core.h"
#include "verilated.h"
#include "../inc/ptr.h"
#include "contx.h"
#include "../inc/struct.h"
#include "../inc/cjump.h"
#include "../inc/extract.h"

#define get64(a) ((((unsigned long long) a[1])<<32)|(unsigned long long) a[0])
#define set64i(a,b,c) a[0]=b;a[1]=b>>32;a[2]=c;

unsigned short OPS_REGL[]={0,1,4,5,8,9,12,13,16,17,32|4096,33|4096,34|4096,
35|4096,36|4096,37|4096,39|4096,40|4096,41|4096,42|4096,43|4096,48|4096,49|4096,
50|4096,51|4096,52,53,54|4096,55|4096,56|4096,57};
unsigned short OPS_S_REGL[]={0,1,4,5,8,9,12,13,16,17,20,21,24,25,28,29,32|4096,
33|4096,34|4096,35|4096,36|4096,37|4096,39|4096,40|4096,41|4096,42|4096,43|4096,48|4096,49|4096,50|4096,51|4096,52,53,54|4096,55|4096,56|4096,57
};
unsigned short OPS_M_REGL[]={1,2,3,5,7,9,10,11,12|4096,13|4096,14|4096,
12|4096|1024,13|4096|1024,14|4096|1024};

void fp_get_ext(long double a, unsigned num[3]);
void fp_get_double(double a, unsigned num[3]);
void fp_get_single(float a, unsigned num[3]);
bool ckran_alu(unsigned long long ptr,unsigned long long addr);

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
/*    0x00,0,16,
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
    0x1e,0,17,*/
    
    0x60,0,1,
    0x62,0,2,
    0x64,0,4,
    0x66,0,8,
 /*   0x40,0,16,
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
    0x5e,0,17,*/
    
    0x160,1,1,
    0x162,1,2,
    0x164,1,4,
    0x166,1,8,
 /*   0x140,1,16,
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
    0x15e,1,17,*/
    
    0x260,2,1,
    0x262,2,2,
    0x264,2,4,
    0x266,2,8,
   /* 0x240,2,16,
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
    0x25e,2,17,*/
    
    0x360,3,1,
    0x362,3,2,
    0x364,3,4,
    0x366,3,8//,
   /* 0x340,3,16,
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
    0x35e,3,17*/
};

lsent store_op[]={
    0x21,0,1,
    0x23,0,2,
    0x25,0,4,
    0x27,0,8,
 /*   0x01,0,16,
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
    0x1f,0,17,*/
    
    0x61,0,1,
    0x63,0,2,
    0x65,0,4,
    0x67,0,8,
   /* 0x41,0,16,
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
    0x5f,0,17,*/
    
    0x161,1,1,
    0x163,1,2,
    0x165,1,4,
    0x167,1,8,
   /* 0x141,1,16,
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
    0x15f,1,17,*/
    
    0x261,2,1,
    0x263,2,2,
    0x265,2,4,
    0x267,2,8,
    /*0x241,2,16,
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
    0x25f,2,17,*/
    
    0x361,3,1,
    0x363,3,2,
    0x365,3,4,
    0x367,3,8//,
   /* 0x341,3,16,
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
    0x35f,3,17*/
};
char *reg8[]={
"al",
"bl",
"cl",
"dl",
"spl",
"bpl",
"sil",
"dil",
"r8b",
"r9b",
"r10b",
"r11b",
"r12b",
"r13b",
"r14b",
"r15b",
"r16b",
"r17b",
"r18b",
"r19b",
"r20b",
"r21b",
"r22b",
"r23b",
"r24b",
"r25b",
"r26b",
"r27b",
"r28b",
"r29b",
"r30b",
"r31b",
"ah",
"bh",
"ch",
"dh",
"sih",
"dih",
"sph",
"bph",
"r8h",
"r9h",
"r10h",
"r11h",
"r12h",
"r13h",
"r14h",
"r15h",
"r16h",
"r17h",
"r18h",
"r19h",
"r20h",
"r21h",
"r22h",
"r23h",
"r24h",
"r25h",
"r26h",
"r27h",
"r28h",
"r29h",
"r30h",
"r31h"
};


char *reg16[]={
"ax",
"bx",
"cx",
"dx",
"sp",
"bp",
"si",
"di",
"r8w",
"r9w",
"r10w",
"r11w",
"r12w",
"r13w",
"r14w",
"r15w",
"r16w",
"r17w",
"r18w",
"r19w",
"r20w",
"r21w",
"r22w",
"r23w",
"r24w",
"r25w",
"r26w",
"r27w",
"r28w",
"r29w",
"r30w",
"r31w"
};


char *reg32[]={
"eax",
"ebx",
"ecx",
"edx",
"esp",
"ebp",
"esi",
"edi",
"r8d",
"r9d",
"r10d",
"r11d",
"r12d",
"r13d",
"r14d",
"r15d",
"r16d",
"r17d",
"r18d",
"r19d",
"r20d",
"r21d",
"r22d",
"r23d",
"r24d",
"r25d",
"r26d",
"r27d",
"r28d",
"r29d",
"r30d",
"r31d"
};

char *reg65[]={
"rax",
"rbx",
"rcx",
"rdx",
"rsp",
"rbp",
"rsi",
"rdi",
"r8",
"r9",
"r10",
"r11",
"r12",
"r13",
"r14",
"r15",
"r16",
"r17",
"r18",
"r19",
"r20",
"r21",
"r22",
"r23",
"r24",
"r25",
"r26",
"r27",
"r28",
"r29",
"r30",
"r31"
};

#define MEMRGN_DATA 512*1024*1024
#define MEMRGN_DATA_SZ 65536

class req {
    public:
    unsigned int op;
    unsigned long long A,B,res;
    unsigned long long addr;
    unsigned A_p,B_p,res_p,excpt;
    unsigned flags,flags_in;
    unsigned fset;
    unsigned alt,mul;
    unsigned en;
    unsigned num[3];
    int rA,rB,rT;
    unsigned base,index,scale;
    unsigned offset;
    unsigned has_mem;
    unsigned has_alu;
    char asmtext[64];
    bool gen(bool alt_, bool mul_, bool can_shift, req *prev1,hcont *contx,int has_mem_,char *mem,char *pmem);
    void gen_init(int rT,int dom,unsigned long long int val,int val_p);
    void gen_mem(req* prev1,unsigned code,char * mem,char *memp,unsigned long long addr);
    void gen_memw(req* prev1,unsigned code,char * mem,char *memp,unsigned long long addr,unsigned long long res, char res_p);
    void flgPTR(__int128 r);
    void flg64(__int128 r);
    void flg32(__int128 r);
    void flgM64(unsigned long long r, bool big=0);
    void flgM128(unsigned __int128 r, bool big=0);
    bool testj(int code);
};
    
void req::gen_init(int rT_,int dom,unsigned long long int val,int val_p) {
    has_alu=true;
    res=val;
    res_p=val_p;
    B=val;
    B_p=val_p;
    A=0;
    A_p=0;
    op=32;
    rB=-1;
    rA=-1;
    this->rT=rT_;
    op=32;
    if (!val_p) snprintf(asmtext,sizeof asmtext,"movabs $%li,%%%s\n",B,reg65[rT]);
    else snprintf(asmtext,sizeof asmtext,"movabsp $%li,%%%s\n",B,reg65[rT]);//WARNING: movabsp non impl and not in cpu spec
}

bool req::gen(bool alt_, bool mul_, bool can_shift, req *prev1,hcont *contx,int has_mem_,char *mem,char *memp) {
    alt=alt_;
    mul=mul_;
    excpt=-1;
    bool rtn=has_mem_;
    if (!alt && !mul && !can_shift) op=OPS_REGL[rand()%(sizeof OPS_REGL/2)];
    if (!alt && !mul && can_shift)  op=OPS_S_REGL[rand()%(sizeof OPS_S_REGL/2)];
    if (!alt && mul) op=OPS_M_REGL[rand()%(sizeof OPS_M_REGL/2)]|0x800;
    if (alt) op=rand()&0x1ffff;
    res_p=0;
    rA=rand()&0x1f;
    rB=rand()&0x1f;
    rT=rand()&0x1f;
    if (has_mem_ && rT==16) rT=17;
    if (has_mem_ && rA==16) rA=17;
    if (has_mem_) addr=lrand48()%(MEMRGN_DATA_SZ-8);
    if (rand()&1) {
        B=lrand48()&0xffffffff;
	B_p=0;
	rA&=0xf;
	rT&=0xf;
	rB=-1;
    } else if (rand()&1) {
	B=(lrand48()&0x1fff)-0x1000;
	B_p=0;
	rB=-1;
    } else {
	B=contx->reg_gen[rB];
	B_p=contx->reg_genP[rB];
    }
    A=contx->reg_gen[rA];
    A_p=contx->reg_genP[rA];
    asmtext[0]=0;
    flags_in=contx->flags;

    has_alu=1;
    //has_mem=0;
    if (!alt && !mul) {
        __int128 res0;
        int A0=A,B0=B,res2;
        unsigned A0x=A,B0x=B;
        long long int A1=A,B1=B,res1;
        unsigned __int128 one=0x8000000000000000ull;
        unsigned long long pttr=A_p ? A : B;
	bool no_O=false;
	int mmem=0;
	if (has_mem_) mmem=lrand48()%3;
        switch(op&0xff) {
            case 0:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "addq %%%s, mem+%li(%rip)\n",reg65[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "addq $%i, mem+%li(%rip)\n",B,addr);
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rB=16;
		B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "addq mem+%li(%rip), %%%s, %%%s\n",addr,reg65[rA],reg65[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"addq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"addq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res0=((unsigned __int128)  A)+(unsigned __int128) B;
            if (A_p && B_p) excpt=11;
	    if (A_p && !B_p) res0= (res0&0xfffffffffff)|(A&0xfffff00000000000);
	    if (!A_p && B_p) res0= (res0&0xfffffffffff)|(B&0xfffff00000000000);
addie:
            ptr p,p2;
	    if (A_p || B_p) {
		res1=(res=res0)&0xfffffffffff;
		unsigned long long low,hi;
		p.val=pttr;
		unsigned long long b=p2.val;
		if (!no_O) p2.val=res;
		unsigned exp=p.val>>59;
		bool flip;

		if (!p.get_bounds2(no_O,p2,b,flip) && (exp!=31 || no_O)) {
		    excpt=11;
		    break;
		}
		if ((((res>>44)^(pttr>>44))&1)!=flip) {
		    excpt=11;
		    break;
		};
		res_p=1;
                flg64(res0);
	        res1=res0;
	    } else {
                res1=res=res0;
		res_p=0;
                flg64(res0);
	        res1=res0;
		B1=B;
                if (!no_O) {
		    flags|=((A1>0&&B1>0&&res1<0) || (A1<0&&B1<0&&res1>0))<<4;
                    flags|=(((A&0xf)+(B&0xf))&0x10)>>1;
	        }
	    }
            break;
            
            case 1:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A0x=A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "addl %%%s, mem+%li(%rip)\n",reg32[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "addl $%i, mem+%li(%rip)\n",B,addr);
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,4,mem,memp,addr);
		rB=16;
		B0x=B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "addl mem+%li(%rip), %%%s, %%%s\n",addr,reg32[rA],reg32[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"addl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"addl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=((unsigned __int128) A0x)+(unsigned __int128) B0x;
            res2=res=res0&0xffffffffull;
            flg32(res0);
	    B0=B;
            flags|=((A0>0&&B0>0&&res2<0) || (A0<0&&B0<0&&res2>0))<<4;
            flags|=(((A&0xf)+(B&0xf))&0x10)>>1;
            break;

            case 4:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "subq %%%s, mem+%li(%rip)\n",reg65[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "subq $%i, mem+%li(%rip)\n",B,addr);
	    } else  if (has_mem_) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rB=16;
		B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "subq mem+%li(%rip), %%%s, %%%s\n",addr,reg65[rA],reg65[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"subq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"subq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res0=((unsigned __int128) A)+((unsigned __int128)~B)+(one>>63);
	    if (A_p && !B_p) {
                res0=(((unsigned __int128) A)+(((unsigned __int128)~B)+(one>>63))&0xffffffffffful)|
		((unsigned __int128) A&0xfffff00000000000ul);
		goto addie; 
	    }
            res1=res=res0;
	    if (A_p && B_p) {
		res1=res=
	        res0=(((unsigned __int128) A&0xfffffffffff)+(((unsigned __int128)~B)&0xffffffffffful))+(one>>63);
		res1=res=res0&0xfffffffffff;
	    }
	    if (!A_p && B_p) excpt=11;
	    res_p=0;
            if (!(A_p && B_p)) flg64(res0^(one<<1));
	    else flgPTR(res0^(one>>19));
            B1=B;

            if (!(A_p && B_p)) flags|=((A1>=0&&B1<0&&res1<0) || (A1<0&&B1>0&&res1>0))<<4;
            if ((A_p && B_p)) flags|=((!(A1&0x80000000000)&&(B1&0x80000000000)&&(res1&0x80000000000)) || 
		((A1&0x80000000000)&&!(B1&0x80000000000)&&!(res1&0x80000000000)))<<4;
            flags|=(((A&0xf)-(B&0xf))&0x10)>>1;
            break;
            
            case 5:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "subl %%%s, mem+%li(%rip)\n",reg32[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "subl $%i, mem+%li(%rip)\n",B,addr);
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,4,mem,memp,addr);
		rB=16;
		B0x=B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "subl mem+%li(%rip), %%%s, %%%s\n",addr,reg32[rA],reg32[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"subl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"subl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=((unsigned __int128) A0x)+((unsigned __int128) ~B0x)+1;
            res2=res=res0&0xffffffffull;
            flg32(res0^0x100000000ll);
	    B0=B;
            flags|=((A0>=0&&B0<0&&res2<0) || (A0<0&&B0>0&&res2>0))<<4;
            flags|=(((A&0xf)-(B&0xf))&0x10)>>1;
            break;

            case 8:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "andq %%%s, mem+%li(%rip)\n",reg65[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "andq $%i, mem+%li(%rip)\n",B,addr);
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rB=16;
		B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "andq mem+%li(%rip), %%%s, %%%s\n",addr,reg65[rA],reg65[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"andq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"andq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res1=res=res0=A&B;
	    if (A_p && B_p) excpt=11;
	    if (A_p && !B_p) { 
		no_O=2; 
                res1=res=res0=A&(B|0xfffff00000000000);
		p2.val=B&0xfffffffffff;
		goto addie; 
	    }
	    if (!A_p && B_p) { 
		no_O=2; 
                res1=res=res0=B&(A|0xfffff00000000000);
		p2.val=A&0xfffffffffff;
		goto addie; 
	    }
            res1=res=res0;
            flg64(res0);
            break;

            case 9:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "andl %%%s, mem+%li(%rip)\n",reg32[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "andl $%i, mem+%li(%rip)\n",B,addr);
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,4,mem,memp,addr);
		rB=16;
		B0x=B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "andl mem+%li(%rip), %%%s, %%%s\n",addr,reg32[rA],reg32[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"andl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"andl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=A0x&B0x;
            res2=res=res0&0xffffffffull;
            flg32(res);
            break;

            case 12:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "orq %%%s, mem+%li(%rip)\n",reg65[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "orq $%i, mem+%li(%rip)\n",B,addr);
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rB=16;
		B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "orq mem+%li(%rip), %%%s, %%%s\n",addr,reg65[rA],reg65[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"orq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"orq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res1=res=res0=A|B;
	    if (A_p && B_p) excpt=11;
	    if (A_p && !B_p) { 
		no_O=1; 
                res1=res=res0=A|(B&0xfffffffffff);
		p2.val=B&0xfffffffffff;
		goto addie; 
	    }
	    if (!A_p && B_p) { 
		no_O=1; 
                res1=res=res0=B|(A&0xfffffffffff);
		p2.val=A&0xfffffffffff;
		goto addie; 
	    }
            res1=res=res0;
            flg64(res0);
            break;

            case 13:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "orl %%%s, mem+%li(%rip)\n",reg32[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "orl $%i, mem+%li(%rip)\n",B,addr);
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,4,mem,memp,addr);
		rB=16;
		B0x=B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "orl mem+%li(%rip), %%%s, %%%s\n",addr,reg32[rA],reg32[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"orl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"orl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=A0x|B0x;
            res2=res=res0&0xffffffffull;
            flg32(res);
            break;

            case 16:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "xorq %%%s, mem+%li(%rip)\n",reg65[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "xorq $%i, mem+%li(%rip)\n",B,addr);
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rB=16;
		B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "xorq mem+%li(%rip), %%%s, %%%s\n",addr,reg65[rA],reg65[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"xorq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"xorq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res1=res=res0=A^B;
	    if (A_p && B_p) excpt=11;
	    if (A_p && !B_p) { 
		no_O=1; 
                res1=res=res0=A^(B&0xfffffffffff);
		p2.val=B&0xfffffffffff;
		goto addie; 
	    }
	    if (!A_p && B_p) { 
		no_O=1; 
                res1=res=res0=B^(A&0xfffffffffff);
		p2.val=A&0xfffffffffff;
		goto addie; 
	    }
            res1=res=res0;
            flg64(res0);
            break;

            case 17:
	    if (has_mem_==2) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		rA=16;
		A=(this-1)->res;
		A_p=(this-1)->res_p;
		if (rB>=0)
		    snprintf(asmtext,sizeof (asmtext), "xorl %%%s, mem+%li(%rip)\n",reg32[rB],addr);
		else
		    snprintf(asmtext,sizeof (asmtext), "xorl $%i, mem+%li(%rip)\n",B,addr);
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,4,mem,memp,addr);
		rB=16;
		B0x=B=(this-1)->res;
		B_p=(this-1)->res_p;
		snprintf(asmtext,sizeof (asmtext), "xorl mem+%li(%rip), %%%s, %%%s\n",addr,reg32[rA],reg32[rT]);
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"xorl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"xorl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=A0x^B0x;
            res2=res=res0&0xffffffffull;
            flg32(res);
            break;

            case 20:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"salq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"shlq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res0=((__int128) A)<<(B&0x3f);
            res1=res=res0;
            flg64(res0);
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 21:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"sall %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"shll $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=((__int128) A0x)<<(B0x&0x3f);
            res2=res=res0&0xffffffffull;
            flg32(res0);
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 24:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"shrq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"shrq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res0=(B&0x3f) ?((__int128)  A) >>((B&0x3f)-1) :((__int128)  A)<<1;
            res1=res=(res0>>1);
            flg64(((res0>>1)&0xffffffffffffffffull)|((res0&0x1) ? one<<1:0));
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 25:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"shrl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"shrl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=(B0x&0x3f) ?((__int128)A0x) >>((B0x&0x3f)-1) :((__int128)  A0x)<<1;
            res=(res0>>1)&0xffffffffull;
            flg32(((res0>>1)&0xffffffffu)|((res0&0x1)<<32));
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 28:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"sarq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"sarq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res0=(B&0x3f) ?((__int128) A1) >>((B&0x3f)-1) :((__int128)  A1)<<1;
            res1=res=(res0>>1);
            flg64(((res0>>1)&0xffffffffffffffffull)|((res0&0x1) ? one<<1 : 0));
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 29:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"sarl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"sarl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=(B0x&0x3f) ? ((__int128) A0) >>((B0x&0x3f)-1) :((__int128) A0)<<1;
            res2=res=(res0>>1)&0xffffffffull;
            flg32(((res0>>1)&0xffffffffu)|((res0&0x1)<<32));
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;
 
            case 32:
	    if (has_mem_==2) {
		(this-1)->gen_memw(NULL,8,mem,memp,addr,A,A_p);
		snprintf((*(this-1)).asmtext,sizeof (asmtext), "copyq %%%s, mem+%li(%rip)\n",reg65[rA],addr);
		(this-1)->rT=-1;
		(this-1)->flags=flags_in;
		rtn=false;
		break;
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,8,mem,memp,addr);
		snprintf((*(this-1)).asmtext,sizeof (asmtext), "copyq mem+%li(%rip), %%%s\n",addr,reg65[rT]);
                (*(this-1)).rT=rT;
		rtn=false;
                (this-1)->flags=flags_in;
		break;
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"copyq %%%s,  %%%s\n",reg65[rB],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copyq $%i, %%%s\n",(int) B,reg65[rT]);
            res=B;
            flags=flags_in;
            break;

            case 33:
	    if (has_mem_==2) {
		(this-1)->gen_memw(NULL,4,mem,memp,addr,A,A_p);
		snprintf((*(this-1)).asmtext,sizeof (asmtext), "copyl %%%s, mem+%li(%rip)\n",reg32[rA],addr);
		(this-1)->rT=-1;
		(this-1)->flags=flags_in;
		rtn=false;
		break;
	    } else if (has_mem_) {
		(this-1)->gen_mem(NULL,4,mem,memp,addr);
		snprintf((*(this-1)).asmtext,sizeof (asmtext), "copyl mem+%li(%rip), %%%s\n",addr,reg32[rT]);
                (*(this-1)).rT=rT;
		rtn=false;
                (this-1)->flags=flags_in;
		break;
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"copyl %%%s,  %%%s\n",reg32[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copyl $%i, %%%s\n",(int) B,reg32[rT]);
            res=B&0xffffffffull;
            flags=flags_in;
            break;

            case 34:
	    if (has_mem_==2) {
		(this-1)->gen_memw(NULL,2,mem,memp,addr,A,A_p);
		snprintf((*(this-1)).asmtext,sizeof (asmtext), "copyw %%%s, mem+%li(%rip)\n",reg16[rA],addr);
		(this-1)->rT=-1;
		(this-1)->flags=flags_in;
		rtn=false;
		break;
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"copyw %%%s,  %%%s\n",reg16[rB],reg16[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copyw $%i, %%%s\n",(int) B,reg16[rT]);
	    rA=rT;
	    A=contx->reg_gen[rA];
            res=(B&0xffffull)|(A&0xffffffffffff0000ull);
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 35:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    if (has_mem_==2) {
		(this-1)->gen_memw(NULL,1,mem,memp,addr,A,A_p);
		snprintf((*(this-1)).asmtext,sizeof (asmtext), "copyb %%%s, mem+%li(%rip)\n",reg8[rA],addr);
		(this-1)->rT=-1;
		(this-1)->flags=flags_in;
		rtn=false;
		break;
	    } else if (rB>=0) snprintf(asmtext,sizeof asmtext,"copyb %%%s,  %%%s\n",reg8[rB+((op&1024)>>5)],reg8[rT+((op&256)>>3)]);
	    else snprintf(asmtext,sizeof asmtext,"copyb $%i, %%%s\n",(int) B,reg8[rT]);
	    rA=rT;
	    A=contx->reg_gen[rA];
            if (op&256) res=(A&0xffffffffffff00ffull)| ((op&1024) ? B&0xff00ull :
                (B&0xffull)<<8);
            else res=(A&0xffffffffffffff00ull)| ((op&1024) ? (B&0xff00ull)>>8 :
                B&0xffull);
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 36:
	    if (has_mem_) {
		(this-1)->gen_mem(NULL,1,mem,memp,addr);
		snprintf((*(this-1)).asmtext,sizeof (asmtext), "copyzbl mem+%li(%rip), %%%s\n",addr,reg32[rT]);
                (*(this-1)).rT=rT;
		rtn=false;
		(*(this-1)).flags=flags_in;
		break;
	    } else if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"copyzbl %%%s,  %%%s\n",reg8[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copyzbl $%i, %%%s\n",(int) B,reg32[rT]);
            res=B&0xffull;
            flags=flags_in;
            break;

            case 37:
	    if (has_mem_) {
		(this-1)->gen_mem(NULL,2,mem,memp,addr);
		snprintf((*(this-1)).asmtext,sizeof (asmtext), "copyzwl mem+%li(%rip), %%%s\n",addr,reg32[rT]);
                (*(this-1)).rT=rT;
		rtn=false;
		(*(this-1)).flags=flags_in;
		break;
	    } else if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"copyzwl %%%s,  %%%s\n",reg16[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copyzwl $%i, %%%s\n",(int) B,reg32[rT]);
            res=B&0xffffull;
            flags=flags_in;
            break;

            case 39:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"copysbq %%%s,  %%%s\n",reg8[rB],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copysbq $%i, %%%s\n",(int) B,reg65[rT]);
            res=(B&0x80) ? B|0xffffffffffffff00ull : B&0xffull;
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 40:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"copyswq %%%s,  %%%s\n",reg16[rB],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copyswq $%i, %%%s\n",(int) B,reg65[rT]);
            res=(B&0x8000) ? B|0xffffffffffff0000ull : B&0xffffull;
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 41:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"copyslq %%%s,  %%%s\n",reg32[rB],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copyslq $%i, %%%s\n",(int) B,reg65[rT]);
            res=(B&0x80000000) ? B|0xffffffff00000000ull : B&0xffffffffull;
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 42:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
		B0=B;
		B0x=B;
	    }
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"copysbl %%%s,  %%%s\n",reg8[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copysbl $%i, %%%s\n",(int) B,reg32[rT]);
            res=(B0&0x80) ? B0x|0xffffff00ull : B0x&0xffull;
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 43:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
		B0=B;
		B0x=B;
	    }
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"copyswl %%%s,  %%%s\n",reg16[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"copyswl $%i, %%%s\n",(int) B,reg32[rT]);
            res=(B0&0x8000) ? B0x|0xffff0000ull : B0x&0xffffull;
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 48:
            case 49:
            op|=rand()&0x700;
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    snprintf(asmtext,sizeof asmtext,"cmov%sq %%%s, %%%s, %%%s\n",COND(op),reg65[rB],reg65[rA],reg65[rT]);

            res=testj(((op&0x700)>>7)|(op&0x1)) ? B : A;
            res_p=testj(((op&0x700)>>7)|(op&0x1)) ? B_p : A_p;
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;
            
            case 50:
            case 51:
            op|=rand()&0x700;
            op|=rand()&0x700;
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
		B0=B;
		B0x=B;
	    }
	    snprintf(asmtext,sizeof asmtext,"cmov%sl %%%s, %%%s, %%%s\n",COND(op),reg32[rB],reg32[rA],reg32[rT]);
            res=testj(((op&0x700)>>7)|(op&0x1)) ? B0x : A0x;
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;
            
            
            case 52:
            case 53:
            op|=rand()&0x700;
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    snprintf(asmtext,sizeof asmtext,"clahf%sl %%%s\n",COND(op),reg32[rA]);
            res=0;
            flags=testj(((op&0x700)>>7)|(op&0x1)) ? A&0x3f : flags_in;
	    rT=-1;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 54:
            case 55:
            op|=rand()&0x700;
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    snprintf(asmtext,sizeof asmtext,"cset%sl %%%s\n",COND(op),reg32[rT]);
            res=testj(((op&0x700)>>7)|(op&0x1));
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 56:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    snprintf(asmtext,sizeof asmtext,"sahfl %%%s\n",reg32[rT]);
            res=flags_in&0x3f;
            flags=flags_in;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;

            case 57:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    snprintf(asmtext,sizeof asmtext,"lahfl %%%s\n",reg32[rA]);
            res=0;
            flags=A&0x3f;
	    rT=-1;
	    if (has_mem_) {
		rtn=false;
		(*(this-1))=*this;
	    }
            break;
        }
    } else if (!alt) {
        __int128 AS=(long long) A;
        unsigned __int128 A0=A;
        __int128 BS=(long long) B;
        unsigned __int128 B0=B;
        __int128 resS;
        unsigned __int128 res0;
        int As=(int) A;
        unsigned Au=(unsigned) A;
        int Bs=(int) B;
        unsigned Bu=(unsigned) B;
        long long resSx;
        unsigned long long res0x;
        unsigned __int128 resU;
        resSx= (signed long long) As * (signed long long) Bs;
        res0x=(unsigned long long) Au * (unsigned long long) Bu;
        res0=A0*B0;
        resS=AS*BS;
        switch(op&0xff) {
            case 1:
            res=res0x;
            flgM64(res0x,true);
            break;

            case 2:
            res=res0x & 0xffffffffull;
            flgM64(res0x);
            break;

            case 3:
            res=res0;
            flgM128(res0);
            break;
            
            case 9:
            res=resSx;
            flgM64(resSx,1);
            break;

            case 10:
            res=resSx & 0xffffffffull;
            flgM64(resSx);
            break;

            case 11:
            res=resS;
            flgM128(resS);
            break;

            case 5:
            resU=resS>>63;
            res=resU>>1;
            flgM128(resS,1);
            break;
            
            case 7:
            resU=res0>>63;
            res=resU>>1;
            flgM128(res0,1);
            break;

            case 12:
            fp_get_ext((op&0x400) ? (long double) (signed long long) B : 
              (long double) B,num);
            flags=flags_in;
            break;
            
            case 13:
            fp_get_double((op&0x400) ? (double) (signed long long) B : 
              (double) B,num);
            flags=flags_in;
            break;

            case 14:
            fp_get_single((op&0x400) ? (float) (signed long long) B : (float) B,num);
            flags=flags_in;
            break;
        }
    }
    en=rand()&0xff!=0;
    if (!(op&0x1000)) contx->flags=flags;
    if (has_mem_ && ((*(this-1)).rT>=0)) {
	contx->reg_gen[(*(this-1)).rT]=(*(this-1)).res;
	contx->reg_genP[(*(this-1)).rT]=(*(this-1)).res_p;
    }
    if ((rtn||!has_mem_) && (rT>=0) && has_mem_!=2) {
	contx->reg_gen[rT]=res;
	contx->reg_genP[rT]=res_p;
    }
    if (has_mem_==2 && rtn) {
	rT=16;
	contx->reg_gen[rT]=res;
	contx->reg_genP[rT]=res_p;
        (this+1)->gen_memw(NULL,(this-1)->op,mem,memp,addr,res,res_p);
    }
    return rtn;
}
    
void req::gen_mem(req* prev1,unsigned code,char *mem,char *memp,unsigned long long addr) {
    res=0;
    res_p=0;
    rT=16;
    op=code;
    asmtext[0]='\x00';
#define UC (unsigned long long)
    switch(code) {
        case 8: res_p=(memp[MEMRGN_DATA+addr/64]>>((addr&0x38)>>3))&0x1;
		res|=UC (unsigned char) mem[MEMRGN_DATA+addr+4]<<32;
	        res|=UC (unsigned char) mem[MEMRGN_DATA+addr+5]<<40;        
	        res|=UC (unsigned char) mem[MEMRGN_DATA+addr+6]<<48;        
	        res|=UC (unsigned char) mem[MEMRGN_DATA+addr+7]<<56;        
        case 4: res|=UC (unsigned char) mem[MEMRGN_DATA+addr+2]<<16;
	        res|=UC (unsigned char) mem[MEMRGN_DATA+addr+3]<<24;        
        case 2: res|=UC (unsigned char) mem[MEMRGN_DATA+addr+1]<<8; 
        case 1: res|=UC (unsigned char) mem[MEMRGN_DATA+addr]; break;
    }
#undef UC
}

void req::gen_memw(req* prev1,unsigned code,char *mem,char *memp,unsigned long long addr,unsigned long long Dt,char Dt_p) {
    res=0;
    res_p=0;
    rT=-1;
    asmtext[0]='w';
    asmtext[1]='\x00';
    op=code;
    mem[MEMRGN_DATA+addr+0]=(Dt>>0)&0xffull;
    if (code) mem[MEMRGN_DATA+addr+1]=(Dt>>8)&0xffull;
    if (code>2) mem[MEMRGN_DATA+addr+2]=(Dt>>16)&0xffull;
    if (code>2) mem[MEMRGN_DATA+addr+3]=(Dt>>24)&0xffull;
    if (code>4) {
        mem[MEMRGN_DATA+addr+4]=(Dt>>32)&0xffull;
        mem[MEMRGN_DATA+addr+5]=(Dt>>40)&0xffull;
        mem[MEMRGN_DATA+addr+6]=(Dt>>48)&0xffull;
        mem[MEMRGN_DATA+addr+7]=(Dt>>56)&0xffull;
    }
    memp[(MEMRGN_DATA+addr)/64]=(memp[(MEMRGN_DATA+addr)/64])&(0xff7f>>(7-((MEMRGN_DATA+addr)/8)%8))|
	(Dt_p<<(((MEMRGN_DATA+addr)/8)%8));
}


void req::flg64(__int128 r) {
    flags=((r>>59)&0x20)|((r>>61)&0x4)|(((unsigned long long) r==0)<<1)|
      (1^(r&0x1)^((r&0x2)>>1)^((r&0x4)>>2)^((r&0x8)>>3)^((r&0x10)>>4)^
      ((r&0x20)>>5)^((r&0x40)>>6)^((r&0x80)>>7));
}
void req::flgPTR(__int128 r) {
    flags=((r>>39)&0x20)|((r>>41)&0x4)|(((unsigned long long) r==0)<<1)|
      (1^(r&0x1)^((r&0x2)>>1)^((r&0x4)>>2)^((r&0x8)>>3)^((r&0x10)>>4)^
      ((r&0x20)>>5)^((r&0x40)>>6)^((r&0x80)>>7));
}
void req::flg32(__int128 r) {
    flags=((r>>27)&0x20)|((r>>29)&0x4)|(((unsigned) r==0)<<1)|
      (1^(r&0x1)^((r&0x2)>>1)^((r&0x4)>>2)^((r&0x8)>>3)^((r&0x10)>>4)^
      ((r&0x20)>>5)^((r&0x40)>>6)^((r&0x80)>>7));
}
void req::flgM64(unsigned long long r,bool big) {
    flags=(((r&0xffffffff00000000ull)!=0)<<5) | (((r&0xffffffff80000000ull)!=
    0xffffffff80000000ull && (r&0xffffffff80000000ull)!=0)<<4) | ((((long long )
    r<0 && big)  ||((r&0x80000000ull) && !big))<<2) | (((r==0 && big)||
    ((r&0xffffffffull)==0 && !big))<<1) | (1^(r&0x1)^((r&0x2)>>1)^((r&0x4)>>2)^
    ((r&0x8)>>3)^((r&0x10)>>4)^((r&0x20)>>5)^((r&0x40)>>6)^((r&0x80)>>7));
}
void req::flgM128(unsigned __int128 r, bool big) {
    unsigned __int128 r0=r>>63;
    long long r1=r;
    r0=r0>>1;
    flags=((r0!=0)<<5) | (!((r0==0xffffffffffffffffull && r1<0) | (r0==0 &&
    r1>=0))<<4) | (((r0&0x8000000000000000 && big) || (r1<0 && !big))<<2) |
    (((r==0 && big) || (r1==0 && !big))<<1) | (1^(r&0x1)^((r&0x2)>>1)^
    ((r&0x4)>>2)^((r&0x8)>>3)^((r&0x10)>>4)^((r&0x20)>>5)^((r&0x40)>>6)^
    ((r&0x80)>>7));
}

bool req::testj(int code) {
    switch(code) {
        case 0: return (flags_in&0x2)!=0;
        case 1: return (flags_in&0x2)==0;
        case 2: return (flags_in&0x4)!=0;
        case 3: return (flags_in&0x4)==0;
        case 4: return (flags_in&0x22)==0;
        case 5: return (flags_in&0x22)!=0;
        case 6: return (flags_in&0x20)==0;
        case 7: return (flags_in&0x20)!=0;
        case 8: return !((((flags_in&0x4)!=0)^((flags_in&0x10)!=0))||
        ((flags_in&0x2)!=0));
        case 9: return ((((flags_in&0x4)!=0)^((flags_in&0x10)!=0))||
        (flags_in&0x2)!=0);
        case 10: return !(((flags_in&0x4)!=0)^((flags_in&0x10)!=0));
        case 11: return (((flags_in&0x4)!=0)^((flags_in&0x10)!=0));
        case 12: return (flags_in&0x10)!=0;
        case 13: return (flags_in&0x10)==0;
        case 14: return (flags_in&0x1)!=0;
        case 15: return (flags_in&0x1)==0;
    }
}

unsigned get_retfl_data(Vheptane_core *vlTOPp) {

            
           return   (((((((((((((((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__0__KET____DOT__ram_mod__DOT__retA_en)
                                 ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__0__KET____DOT__ram_mod__DOT__ramA_mod__DOT__ram
                                [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__0__KET____DOT__ram_mod__DOT__ramA_mod__DOT__retireRead_addr_reg]
                                 : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__0__KET____DOT__ram_mod__DOT__retA_en)
                                           ? 0x3fU : 0U)) 
                              | (((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__0__KET____DOT__ram_mod__DOT__retB_en)
                                   ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__0__KET____DOT__ram_mod__DOT__ramB_mod__DOT__ram
                                  [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__0__KET____DOT__ram_mod__DOT__ramB_mod__DOT__retireRead_addr_reg]
                                   : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__0__KET____DOT__ram_mod__DOT__retB_en)
                                             ? 0x3fU
                                             : 0U))) 
                             & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT____pinNumber8__en2)) 
                            | (((((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__1__KET____DOT__ram_mod__DOT__retA_en)
                                   ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__1__KET____DOT__ram_mod__DOT__ramA_mod__DOT__ram
                                  [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__1__KET____DOT__ram_mod__DOT__ramA_mod__DOT__retireRead_addr_reg]
                                   : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__1__KET____DOT__ram_mod__DOT__retA_en)
                                             ? 0x3fU
                                             : 0U)) 
                                | (((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__1__KET____DOT__ram_mod__DOT__retB_en)
                                     ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__1__KET____DOT__ram_mod__DOT__ramB_mod__DOT__ram
                                    [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__1__KET____DOT__ram_mod__DOT__ramB_mod__DOT__retireRead_addr_reg]
                                     : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__1__KET____DOT__ram_mod__DOT__retB_en)
                                               ? 0x3fU
                                               : 0U))) 
                               & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT____pinNumber8__en4))) 
                           | (((((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__2__KET____DOT__ram_mod__DOT__retA_en)
                                  ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__2__KET____DOT__ram_mod__DOT__ramA_mod__DOT__ram
                                 [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__2__KET____DOT__ram_mod__DOT__ramA_mod__DOT__retireRead_addr_reg]
                                  : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__2__KET____DOT__ram_mod__DOT__retA_en)
                                            ? 0x3fU
                                            : 0U)) 
                               | (((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__2__KET____DOT__ram_mod__DOT__retB_en)
                                    ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__2__KET____DOT__ram_mod__DOT__ramB_mod__DOT__ram
                                   [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__2__KET____DOT__ram_mod__DOT__ramB_mod__DOT__retireRead_addr_reg]
                                    : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__2__KET____DOT__ram_mod__DOT__retB_en)
                                              ? 0x3fU
                                              : 0U))) 
                              & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT____pinNumber8__en6))) 
                          | (((((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__3__KET____DOT__ram_mod__DOT__retA_en)
                                 ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__3__KET____DOT__ram_mod__DOT__ramA_mod__DOT__ram
                                [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__3__KET____DOT__ram_mod__DOT__ramA_mod__DOT__retireRead_addr_reg]
                                 : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__3__KET____DOT__ram_mod__DOT__retA_en)
                                           ? 0x3fU : 0U)) 
                              | (((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__3__KET____DOT__ram_mod__DOT__retB_en)
                                   ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__3__KET____DOT__ram_mod__DOT__ramB_mod__DOT__ram
                                  [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__3__KET____DOT__ram_mod__DOT__ramB_mod__DOT__retireRead_addr_reg]
                                   : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__3__KET____DOT__ram_mod__DOT__retB_en)
                                             ? 0x3fU
                                             : 0U))) 
                             & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT____pinNumber8__en8))) 
                         | (((((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__4__KET____DOT__ram_mod__DOT__retA_en)
                                ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__4__KET____DOT__ram_mod__DOT__ramA_mod__DOT__ram
                               [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__4__KET____DOT__ram_mod__DOT__ramA_mod__DOT__retireRead_addr_reg]
                                : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__4__KET____DOT__ram_mod__DOT__retA_en)
                                          ? 0x3fU : 0U)) 
                             | (((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__4__KET____DOT__ram_mod__DOT__retB_en)
                                  ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__4__KET____DOT__ram_mod__DOT__ramB_mod__DOT__ram
                                 [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__4__KET____DOT__ram_mod__DOT__ramB_mod__DOT__retireRead_addr_reg]
                                  : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__4__KET____DOT__ram_mod__DOT__retB_en)
                                            ? 0x3fU
                                            : 0U))) 
                            & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT____pinNumber8__en10))) 
                        | (((((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__5__KET____DOT__ram_mod__DOT__retA_en)
                               ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__5__KET____DOT__ram_mod__DOT__ramA_mod__DOT__ram
                              [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__5__KET____DOT__ram_mod__DOT__ramA_mod__DOT__retireRead_addr_reg]
                               : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__5__KET____DOT__ram_mod__DOT__retA_en)
                                         ? 0x3fU : 0U)) 
                            | (((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__5__KET____DOT__ram_mod__DOT__retB_en)
                                 ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__5__KET____DOT__ram_mod__DOT__ramB_mod__DOT__ram
                                [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__5__KET____DOT__ram_mod__DOT__ramB_mod__DOT__retireRead_addr_reg]
                                 : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__5__KET____DOT__ram_mod__DOT__retB_en)
                                           ? 0x3fU : 0U))) 
                           & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT____pinNumber8__en12))) 
                       | (((((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__6__KET____DOT__ram_mod__DOT__retA_en)
                              ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__6__KET____DOT__ram_mod__DOT__ramA_mod__DOT__ram
                             [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__6__KET____DOT__ram_mod__DOT__ramA_mod__DOT__retireRead_addr_reg]
                              : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__6__KET____DOT__ram_mod__DOT__retA_en)
                                        ? 0x3fU : 0U)) 
                           | (((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__6__KET____DOT__ram_mod__DOT__retB_en)
                                ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__6__KET____DOT__ram_mod__DOT__ramB_mod__DOT__ram
                               [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__6__KET____DOT__ram_mod__DOT__ramB_mod__DOT__retireRead_addr_reg]
                                : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__6__KET____DOT__ram_mod__DOT__retB_en)
                                          ? 0x3fU : 0U))) 
                          & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT____pinNumber8__en14))) 
                      | (((((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__7__KET____DOT__ram_mod__DOT__retA_en)
                             ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__7__KET____DOT__ram_mod__DOT__ramA_mod__DOT__ram
                            [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__7__KET____DOT__ram_mod__DOT__ramA_mod__DOT__retireRead_addr_reg]
                             : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__7__KET____DOT__ram_mod__DOT__retA_en)
                                       ? 0x3fU : 0U)) 
                          | (((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__7__KET____DOT__ram_mod__DOT__retB_en)
                               ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__7__KET____DOT__ram_mod__DOT__ramB_mod__DOT__ram
                              [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__7__KET____DOT__ram_mod__DOT__ramB_mod__DOT__retireRead_addr_reg]
                               : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__7__KET____DOT__ram_mod__DOT__retB_en)
                                         ? 0x3fU : 0U))) 
                         & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT____pinNumber8__en16))) 
                     | (((((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__8__KET____DOT__ram_mod__DOT__retA_en)
                            ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__8__KET____DOT__ram_mod__DOT__ramA_mod__DOT__ram
                           [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__8__KET____DOT__ram_mod__DOT__ramA_mod__DOT__retireRead_addr_reg]
                            : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__8__KET____DOT__ram_mod__DOT__retA_en)
                                      ? 0x3fU : 0U)) 
                         | (((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__8__KET____DOT__ram_mod__DOT__retB_en)
                              ? vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__8__KET____DOT__ram_mod__DOT__ramB_mod__DOT__ram
                             [vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__8__KET____DOT__ram_mod__DOT__ramB_mod__DOT__retireRead_addr_reg]
                              : 0U) & ((IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT__rams__BRA__8__KET____DOT__ram_mod__DOT__retB_en)
                                        ? 0x3fU : 0U))) 
                        & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT__ram_mod__DOT____pinNumber8__en18))) 
                    & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT____pinNumber8__en1)) 
                   & (IData)(vlTOPp->heptane_core__DOT__bck_mod__DOT__regS_mod__DOT____pinNumber8__en1));
}

void req_set(Vheptane_core *top,req *reqs,char *mem,char *memp) {
    static unsigned long long addr[64];
    static unsigned pos=0;
    static unsigned pos_R=0;
    static bool R=0;
    static unsigned sigs[64];
    static unsigned src[64];
    static unsigned delay=0;
    static bool bmr=0;
    if (top->rbusOut_want && top->rbusOut_can) {
	addr[pos]=top->rbusOut_address;
	sigs[pos]=top->rbusOut_signals;
	src[pos]=top->rbusOut_src_req;
	if (pos_R==pos) delay=0;
	pos++;
	pos&=0x3f;
    }
    if (pos_R!=pos) delay++;
    if (pos_R!=pos && delay>10) {
	unsigned signals=(1<<(rbusD_mem_reply))|(1<<(rbusD_used));
	top->rbusDIn_signals=signals;
	top->rbusDIn_dst_req=src[pos_R];
	if (!R) {
	    memcpy((char *) top->rbusDIn_data,mem+(addr[pos_R]<<7),64);
	    top->rbusDIn_dataPTR=mem[addr[pos_R]<<1];
	} else {
	    memcpy((char *) top->rbusDIn_data,mem+((addr[pos_R]<<7)+64),64);
	    top->rbusDIn_dataPTR=mem[(addr[pos_R]<<1)+1];
	    top->rbusDIn_signals|=1<<(rbusD_second);
	}
	printf("retn 0x%lx,\t%i, 0x%x\n",addr[pos_R],R,src[pos_R]);
	R=!R;
	if (!R) pos_R++;
	pos_R&=0x3f;
    } else {
	top->rbusDIn_signals=0;
    }

    if (top->rbusDOut_can && top->rbusDOut_want) {
	//unsigned long long address=<<7;
	if (!(top->rbusDOut_signals&(1<<(rbusD_write_back)))) {
            goto end_DOut;
	}
	if (!(top->rbusDOut_signals&(1<<(rbusD_second)))) {
	    memcpy(mem+(addr[pos_R]<<7),(char *) top->rbusDOut_data,64);
	    mem[addr[pos_R]<<1]=top->rbusDIn_dataPTR;
        } else {
	    memcpy(mem+((addr[pos_R]<<7)+64),(char *) top->rbusDOut_data,64);
	    mem[(addr[pos_R]<<1)+1]=top->rbusDIn_dataPTR;
	}
        end_DOut:;
    }
    top->rbusOut_can=1;
    if (top->rbusOut_want) printf("want 0x%lx,\t%i,\t%i\n",top->rbusOut_address,pos,pos_R);
    if (top->heptane_core__DOT__dc2_rdEnX_reg4) printf("dc2_rdEnX_reg4 0x%lx, 0x%x\n",top->heptane_core__DOT__dc2_rd_addr_reg3,
		    top->heptane_core__DOT__dc2_req_rd_reg4);
    if (top->heptane_core__DOT__req_en_reg) printf("wantR 0x%lx,\t%i\n",top->heptane_core__DOT__req_addr_reg,
	top->heptane_core__DOT__req_slot_reg);
    if (bmr) printf("insert 0x%lx\n",
	top->heptane_core__DOT__front_mod__DOT__cc_mod__DOT__write_IP_reg);
    if (top->heptane_core__DOT__front_mod__DOT__bus_match_reg) bmr=1;
    else bmr=0;
    if (top->heptane_core__DOT__insBus_en) 
	    printf("insBus 0x%x, 0x%#8x%#8x%#8x%#8x, %i\n",top->heptane_core__DOT__dc2_req_rd_reg5,
	top->heptane_core__DOT__dc2_rdata_reg[3],top->heptane_core__DOT__dc2_rdata_reg[2],
	top->heptane_core__DOT__dc2_rdata_reg[1],top->heptane_core__DOT__dc2_rdata_reg[0],
	top->heptane_core__DOT__dc2_rhitB1_reg);
    static int idr=0;
    if (top->heptane_core__DOT__bck_mod__DOT__agu_aligned__DOT__alt_bus_hold_reg2) {
	printf("ABH -> 0x%lx,0x%lx,o 0x%x,is_ins 0x%x:0x%x\n",
			top->heptane_core__DOT__bck_mod__DOT__agu_aligned__DOT__mOpX0_addrEven_reg,
			top->heptane_core__DOT__bck_mod__DOT__agu_aligned__DOT__mOpX0_addrOdd_reg,
                        top->heptane_core__DOT__bck_mod__DOT__agu_aligned__DOT__mOpX0_odd_reg,
			idr,
	((top->heptane_core__DOT__bck_mod__DOT__L1D_mod__DOT__ways_gen__BRA__0__KET____DOT__way_mod__DOT__ins_hit&1)<<0)|
	((top->heptane_core__DOT__bck_mod__DOT__L1D_mod__DOT__ways_gen__BRA__1__KET____DOT__way_mod__DOT__ins_hit&1)<<1)|
	((top->heptane_core__DOT__bck_mod__DOT__L1D_mod__DOT__ways_gen__BRA__2__KET____DOT__way_mod__DOT__ins_hit&1)<<2)|
	((top->heptane_core__DOT__bck_mod__DOT__L1D_mod__DOT__ways_gen__BRA__3__KET____DOT__way_mod__DOT__ins_hit&1)<<3)|
	((top->heptane_core__DOT__bck_mod__DOT__L1D_mod__DOT__ways_gen__BRA__4__KET____DOT__way_mod__DOT__ins_hit&1)<<4)|
	((top->heptane_core__DOT__bck_mod__DOT__L1D_mod__DOT__ways_gen__BRA__5__KET____DOT__way_mod__DOT__ins_hit&1)<<5)|
	((top->heptane_core__DOT__bck_mod__DOT__L1D_mod__DOT__ways_gen__BRA__6__KET____DOT__way_mod__DOT__ins_hit&1)<<6)|
	((top->heptane_core__DOT__bck_mod__DOT__L1D_mod__DOT__ways_gen__BRA__7__KET____DOT__way_mod__DOT__ins_hit&1)<<7));
    }
    if (top->heptane_core__DOT__bck_mod__DOT__agu_aligned__DOT__mOpX2_addrEven_reg==0x20001d && top->heptane_core__DOT__bck_mod__DOT__agu_aligned__DOT__mOpX2_en_reg) {
	printf(" ");
    }
    idr=top->heptane_core__DOT__bck_mod__DOT__insert_isData_reg3;
    if (!top->heptane_core__DOT__insBus_en && top->heptane_core__DOT__dc2_rhit) printf("insBusX 0x%x, 0x%#8x%#8x%#8x%#8x, %i\n",top->heptane_core__DOT__dc2_req_rd_reg5,
	top->heptane_core__DOT__dc2_rdata_reg[3],top->heptane_core__DOT__dc2_rdata_reg[2],
	top->heptane_core__DOT__dc2_rdata_reg[1],top->heptane_core__DOT__dc2_rdata_reg[0],
	top->heptane_core__DOT__dc2_rhitB1_reg);
    if (top->heptane_core__DOT__front_mod__DOT__cc_mod__DOT__cc_write_wen_reg2)
	    printf("wenR\n");
    if (top->heptane_core__DOT__rinsBus_A||top->heptane_core__DOT__rinsBus_B) {
	    printf("insburst 0x%8x%8x%8x%8x, %i, 0x%lx\n",top->heptane_core__DOT__rbusDIn_data_reg[3],
	top->heptane_core__DOT__rbusDIn_data_reg[2],top->heptane_core__DOT__rbusDIn_data_reg[1],
	top->heptane_core__DOT__rbusDIn_data_reg[0],top->heptane_core__DOT__dc2_rdOdd,top->heptane_core__DOT__dc2_addrE0);
	    if (top->heptane_core__DOT__dc2_hitE0||top->heptane_core__DOT__dc2_hitO0||top->heptane_core__DOT__dc2_hitE1||
		top->heptane_core__DOT__dc2_hitO1) printf("shmupd\n");
    }
}

bool get_check(Vheptane_core *top, req *reqs,unsigned long long &ip) {
    bool rtn=true;
    static unsigned long long pos=0;
    long long k,x,count;
    static unsigned xbreak=0;
    static unsigned retire=0;
    static int insn_count[64];
    static int insn_posR=0,insn_posW=0;
    static unsigned retII=0;
    if (retire) {
	for(k=0;k<10;k++) {
	    if (xbreak&(1<<k)) break;
	}
	count=(top->heptane_core__DOT__except && top->heptane_core__DOT__except_due_jump) ? k+1 : k;
	if (count==10) count=insn_count[insn_posR];
	if (count!=insn_count[insn_posR] && !top->heptane_core__DOT__except) {
	    printf("wrong count at %li, 0x%x\n",ip,retII);
	    rtn=false;
	}
	insn_posR++;
	insn_posR&=0x3f;
	if (top->heptane_core__DOT__except) {
            printf("except %li, %li\n",count,ip);
	    rtn=false;
	}
	else printf("ret %li, \t%li, %x, fl:0x%x\n",count,ip+count,retII,get_retfl_data(top));
	for(x=0;x<count;x++) {
	    if (reqs[ip+x].rT<0) goto no_srch;
	    if (x<(count-1)) for(k=x+1;k<count;k=k+1) if (reqs[ip+x].rT==reqs[ip+k].rT || reqs[ip+x].rT<0) goto no_srch;
	    for(k=0;k<9;k=k+1) {
		unsigned long long val,valp;
		extract_e(top->heptane_core__DOT__bck_mod__DOT__ret_dataA,65*k,65*k+63,val);
		extract_e(top->heptane_core__DOT__bck_mod__DOT__ret_dataA,65*k+64,65*k+64,valp);
		switch(k) {
		    case 0: if (top->heptane_core__DOT__bck_mod__DOT__retire0_rT!=reqs[ip+x].rT ||
					    !top->heptane_core__DOT__bck_mod__DOT__retire0_enG) continue;
			    break;
		    case 1: if (top->heptane_core__DOT__bck_mod__DOT__retire1_rT!=reqs[ip+x].rT ||
					    !top->heptane_core__DOT__bck_mod__DOT__retire1_enG) continue;
			    break;
		    case 2: if (top->heptane_core__DOT__bck_mod__DOT__retire2_rT!=reqs[ip+x].rT ||
					    !top->heptane_core__DOT__bck_mod__DOT__retire2_enG) continue;
			    break;
		    case 3: if (top->heptane_core__DOT__bck_mod__DOT__retire3_rT!=reqs[ip+x].rT ||
					    !top->heptane_core__DOT__bck_mod__DOT__retire3_enG) continue;
			    break;
		    case 4: if (top->heptane_core__DOT__bck_mod__DOT__retire4_rT!=reqs[ip+x].rT ||
					    !top->heptane_core__DOT__bck_mod__DOT__retire4_enG) continue;
			    break;
		    case 5: if (top->heptane_core__DOT__bck_mod__DOT__retire5_rT!=reqs[ip+x].rT ||
					    !top->heptane_core__DOT__bck_mod__DOT__retire5_enG) continue;
			    break;
		    case 6: if (top->heptane_core__DOT__bck_mod__DOT__retire6_rT!=reqs[ip+x].rT ||
					    !top->heptane_core__DOT__bck_mod__DOT__retire6_enG) continue;
			    break;
		    case 7: if (top->heptane_core__DOT__bck_mod__DOT__retire7_rT!=reqs[ip+x].rT ||
					    !top->heptane_core__DOT__bck_mod__DOT__retire7_enG) continue;
			    break;
		    case 8: if (top->heptane_core__DOT__bck_mod__DOT__retire8_rT!=reqs[ip+x].rT ||
					    !top->heptane_core__DOT__bck_mod__DOT__retire8_enG) continue;
			    break;
		}
		if (reqs[ip+x].res!=val || reqs[ip+x].res_p!=valp) {
		    printf("reterr %i, %li, %lx:%lx,off %lx, instr %s, AB %lx:%lx\n",x,ip+x,reqs[ip+x].res,val,reqs[ip+x].offset,
			reqs[ip+x].asmtext,reqs[ip+x].A,reqs[ip+x].B);
		    rtn=false;
		}
		break;
	    }
            if (k==9) {
		printf("reterr %i, %lx, %lx, instr %s\n",x,ip+x,reqs[ip+x].res,reqs[ip+x].asmtext);
	        rtn=false;
	    }
no_srch:;
	}
	ip+=count;
	pos+=count;
    }
    xbreak=top->heptane_core__DOT__bck_mod__DOT__retM_xbreak;
    retire=top->heptane_core__DOT__bck_mod__DOT__retM_do_retire;
    retII=top->heptane_core__DOT__bck_mod__DOT__cntrl_unit_mod__DOT__retire_addr_reg;
    if (top->heptane_core__DOT__iAvail) printf("iAvail 0x%x, \t0x%x, \t0x%x, \t0x%x\n",top->heptane_core__DOT__iAvail,top->heptane_core__DOT__instrEn,top->heptane_core__DOT__dec_mod__DOT__cls_ALU,top->heptane_core__DOT__dec_mod__DOT__cls_shift);
    if (top->heptane_core__DOT__instrEn && top->heptane_core__DOT__bck_mod__DOT__stall_rs==0 && 
		    top->heptane_core__DOT__bck_mod__DOT__doStall_rs==0) {
	k=0;
	while (top->heptane_core__DOT__instrEn&(1<<k)) {k++;}
	insn_count[insn_posW++]=k;
	insn_posW&=0x3f;
    }
   // for(k=0;k<6;k++) {
	if (top->heptane_core__DOT__bck_mod__DOT__enS_alu) {
	    printf("ALU 0x%x, fl 0x%lx, ret 0x%x\n",top->heptane_core__DOT__bck_mod__DOT__enS_alu,
		top->heptane_core__DOT__bck_mod__DOT__FUS_alu,
		top->heptane_core__DOT__bck_mod__DOT__ex_alu);
	}
  //  }
    if (top->heptane_core__DOT__bck_mod__DOT__outEn&0x111111111ul) {
	printf("outEn 0x%lx\n",top->heptane_core__DOT__bck_mod__DOT__outEn);
    }
    for(k=0;k<9;k++) {
        if (top->heptane_core__DOT__bck_mod__DOT__rs_en_reg[k] && !(top->heptane_core__DOT__bck_mod__DOT__stall_rs|
				top->heptane_core__DOT__bck_mod__DOT__doStall_rs)) {
	    printf("rs_en_reg 0x%x, \t0x%x\n",k,top->heptane_core__DOT__bck_mod__DOT__rs_port_sch[k]);
        }
    }
    for(k=0;k<6;k++) {
	if (top->heptane_core__DOT__bck_mod__DOT__fret_en&(1<<k)) {
	    unsigned long long val;
	    int k2;
	    k2=(k>>1)*3+1+(k&1);
	    extract_e(top->heptane_core__DOT__bck_mod__DOT__fret,14*k,14*k+13,val);
	    if ((k&1)==0) printf("fsret %i,\t0x%x, \t0x%x\n",k,val,top->heptane_core__DOT__bck_mod__DOT__outII_reg4[k2]);
	    if ((k&1)==1) printf("fsret %i,\t0x%x, \t0x%x\n",k,val,top->heptane_core__DOT__bck_mod__DOT__outII_reg7[k2]);
	}
    }
    if (top->heptane_core__DOT__front_mod__DOT__cc_mod__DOT____Vcellout__stHit_mod__read_data&0x100) {
	printf("fetch ");
	for(k=3;k>=0;k--) {
	   unsigned long long val;
	   extract_e(top->heptane_core__DOT__front_mod__DOT__read_data,65*k,65*k+63,val);
	   printf("%#16lx",val);
	}
	if (!top->heptane_core__DOT__front_mod__DOT__instrEn_reg3) printf(" err ");
	printf(" 0x%lx\n",top->heptane_core__DOT__front_mod__DOT__IP_phys_reg3);
    }
    if (top->heptane_core__DOT__front_mod__DOT__bus_tlb_match_reg) {
	printf("TLBIN 0x%lx -> 0x%lx\n",top->heptane_core__DOT__front_mod__DOT__tlb_IP<<13,
	    top->heptane_core__DOT__front_mod__DOT__bus_tlb_data_reg);
    }
    if (top->heptane_core__DOT__bck_mod__DOT__FUwen_reg[0]|top->heptane_core__DOT__bck_mod__DOT__FUwen_reg[1]|
	top->heptane_core__DOT__bck_mod__DOT__FUwen_reg[2]|top->heptane_core__DOT__bck_mod__DOT__FUwen_reg[3]) {
	printf("FUwen_reg 0x%x, 0x%x : 0x%x,0x%x,0x%x,0x%x\n",top->heptane_core__DOT__bck_mod__DOT__FUwen_reg[0] | 
	(top->heptane_core__DOT__bck_mod__DOT__FUwen_reg[1]<<1) |(top->heptane_core__DOT__bck_mod__DOT__FUwen_reg[2]<<2)|
	(top->heptane_core__DOT__bck_mod__DOT__FUwen_reg[3]<<3),
	top->heptane_core__DOT__bck_mod__DOT__FU0HitP | (top->heptane_core__DOT__bck_mod__DOT__FU1HitP<<1) |
	(top->heptane_core__DOT__bck_mod__DOT__FU2HitP<<2) |(top->heptane_core__DOT__bck_mod__DOT__FU3HitP<<3),
	top->heptane_core__DOT__bck_mod__DOT__FUreg_reg[0],
	top->heptane_core__DOT__bck_mod__DOT__FUreg_reg[1],
	top->heptane_core__DOT__bck_mod__DOT__FUreg_reg[2],
	top->heptane_core__DOT__bck_mod__DOT__FUreg_reg[3]
	);
    }
    if (top->heptane_core__DOT__bck_mod__DOT__miss_pause_agu) {
	printf("miss_pause_agu\n");
	if (top->heptane_core__DOT__bck_mod__DOT__outEn&1) printf("outEn0\n");
	if (top->heptane_core__DOT__bck_mod__DOT__outEn&8) printf("outEn3\n");
	if (top->heptane_core__DOT__bck_mod__DOT__outEn&64) printf("outEn6\n");
    }
    if (top->heptane_core__DOT__bck_mod__DOT__dc_rdEn) {
	printf("");
    }
    return rtn;
}

void prog_locate(req *reqs,unsigned char *mem) {
    unsigned long long addr=0;
    unsigned long long ins=0;
    unsigned bits=mem[30]|(mem[31]<<8);
    while (1) {
	int n,sz;
	reqs[ins++].offset=addr;
	for(n=0;n<15;n++) if (bits&(1<<n)) {sz=n; break;}
	addr+=sz*2+2;
	bits>>=sz+1;
	if (!bits) {
	    addr=(addr+31)&0xfffffffe0;
            bits=mem[addr+30]|(mem[addr+31]<<8);
	}
	if (ins>=(10000000-1)) return;
    }
}
void fp_get_ext(long double a, unsigned num[3]) {
    if (a!=0.0) {
        unsigned *p1=(unsigned*) &a;
        unsigned short *p2=(unsigned short *) &a;

        num[0]=p1[0];
        num[1]=p1[1]<<1;
        num[2]=((p1[1]>>31)&0x1)|((p2[4]&0x4000)>>13)|0x4|(((~p2[4])&0x4000)<<4)|
          ((p2[4]&0xbfff)<<4);
    } else {
        num[0]=0;
        num[1]=0;
        num[2]=0x4;
    }
}

void fp_get_double(double a, unsigned num[3]) {
    if (a!=0.0) {
        unsigned long long *p1= (unsigned long long *)&a;
        num[0]=*p1&0xffffffffu;
        num[1]=((*p1&0x7fffffff00000000ull)>>31)^0x80000000ull;
        num[2]=(*p1>>63)|((*p1>>61)&0x2)|0x8;
    } else {
        num[0]=0;
        num[1]=0;
        num[2]=0x8;
    }
}

void fp_get_single(float a1, unsigned num[3]) {
    float a=a1;
    unsigned *p1=(unsigned *) &a;
    if (a!=0.0) {
        num[0]=*p1^0x40000000;
        num[1]=(*p1>>30)&0x1;
        num[2]=0xC;
    } else {
        num[0]=0;
        num[1]=0;
        num[2]=0xC;
    }
}

bool ckran_alu(unsigned long long ptr,unsigned long long &addr) {
    unsigned off=ptr>>58;
    if (ptr&0xfffffe0000000000ull!=addr&0xfffffe0000000000ull)
        return false;
    unsigned long long ptru=(ptr&0x1ffffffffffull)>>(off+9);
    unsigned long long addru=(addr&0x1ffffffffffull)>>(off+9);
    if (ptru==addru) return true;
    if (addru==(ptru+1) && (ptr&0x40000000000) && (ptr&0x20000000000))
    {
        addr^=0x40000000000;
        return true;
    }
    if (addru==(ptru-1) && !(ptr&0x40000000000) && (ptr&0x20000000000))
    {
        addr^=0x40000000000;
        return true;
    }
    return false;
}


void gen_memrgn(char *mem,char *pmem) {
    int n;
    for(n=0;n<(MEMRGN_DATA_SZ/8);n++) {
	unsigned long long *xmem=(unsigned long long *) (mem+8*n+MEMRGN_DATA);
        if ((lrand48()%3)==1) {
	    pmem[n/8+MEMRGN_DATA/64]|=1<<(n&0x7);
	    *xmem=lrand48()&0xfffffffffff;
	    *xmem|=0xf80ff00000000000ul;	    
	} else {
	    pmem[n/8+MEMRGN_DATA/64]&=~(1<<(n&0x7));
	    *xmem=lrand48()&0xfffffffffff;
	    *xmem|=lrand48()<<44;	    
	}
    }
}


void gen_prog(req *reqs,int count, FILE *f,hcont *contx,char *mem,char *pmem) {
   int n;
   fprintf(f,".text\n");
   fprintf(f,".global _start\n");
   fprintf(f,".comm mem,65536\n");
   fprintf(f,"_start:\n");
   for(n=0;n<31;n++) {
       if (n!=6) reqs[n].gen_init(n,0,lrand48()|(lrand48()<<48),0);
       else reqs[n].gen_init(n,0,0xf80fc00008000000,1);
       fprintf(f,"%s",reqs[n].asmtext);
       contx->reg_gen[n]=reqs[n].res;
       contx->reg_genP[n]=reqs[n].res_p;
   }
   reqs[31].gen_init(31,0,0x8000,0);
   fprintf(f,"%s",reqs[31].asmtext);
   contx->reg_gen[n]=reqs[n].res;
   contx->reg_genP[n]=reqs[n].res_p;
  // reqs[32].gen_movcsr(csr_page,31);
   
   for(n=32;n<(count-2);n++) {
	   int p;
	   if ((p=(lrand48()&3))==2) {
               reqs[n].gen(false, false, lrand48()&1, NULL,contx,0,NULL,NULL);
	       fprintf(f,"%s",reqs[n].asmtext);
	   } else if (p)  {
               if (reqs[n+1].gen(false, false, false, NULL,contx,1,mem,pmem)) n++;
	       fprintf(f,"%s",reqs[n].asmtext);
	   } else {
               if (reqs[n+1].gen(false, false, false, NULL,contx,2,mem,pmem)) {
		   n+=2;
	           fprintf(f,"%s",reqs[n-1].asmtext);
	       } else {
	           fprintf(f,"%s",reqs[n].asmtext);
	       }
	   }
   }
   fprintf(f,".p2align 5\n");
   
   
}

req *reqs;

int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);
    Vheptane_core *top=new Vheptane_core();
    Verilated::assertOn(false);
    int initcount=10;
    int cyc=0;
    unsigned long long ip=0;
    FILE *FOUT=fopen("/tmp/asm2.s","w");
    if (!FOUT) exit(1);
    hcont contx;
    memset((void *) &contx,0,sizeof (contx));
    char *mem=(char *) mmap(0,2l*1024*1024*1024,PROT_READ|PROT_WRITE,MAP_ANON|MAP_PRIVATE,-1,0);
    char *memp=(char *) mmap(0,2l*1024*1024*1024/64,PROT_READ|PROT_WRITE,MAP_ANON|MAP_PRIVATE,-1,0);
    char *memw=(char *) mmap(0,2l*1024*1024*1024,PROT_READ|PROT_WRITE,MAP_ANON|MAP_PRIVATE,-1,0);
    char *mempw=(char *) mmap(0,2l*1024*1024*1024/64,PROT_READ|PROT_WRITE,MAP_ANON|MAP_PRIVATE,-1,0);
    if (!mem) {
	perror("mem");
	exit(1);
    }
    //bzero(mem,2l*1024*1024*1024);
    reqs=new req[10000000];
    fesetround(FE_TOWARDZERO);
    top->clk=0;
    top->rst=1;
    gen_memrgn(mem,memp);
    memcpy(memw,mem,2l*1024*1024*1024);
    memcpy(mempw,memp,2l*1024*1024*1024/64);
    gen_prog(reqs,10000000,FOUT,&contx,memw,mempw);
    fclose(FOUT);
    if (argc==2 && !strcmp(argv[1],"-asm")) exit(0);
    char mname[256];
    mname[0]=0;
    snprintf(mname,256,"%s/.hsim/hsim.bin",getenv("HOME"));
    int fd=open(mname,O_RDONLY);
    if (fd>=0) {
	struct stat s;
	long long sz;
	fstat(fd,&s);
	sz=s.st_size;
	sz=(sz+4095l)&0xfffffffff000;
	if (sz>(1024l*1024*1024)) {
            printf("map too big!\n");
	    exit(1);
	}
        if (!mmap(mem,sz,PROT_READ|PROT_WRITE,MAP_FIXED|MAP_PRIVATE,fd,0)) {
	    perror("mmap");
	    exit(1);
	}
    } else {
	perror("open() ");
    }
    prog_locate(reqs,(unsigned char *)mem);
    req_set(top,reqs,mem,memp);
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
	//usleep(5000);
        top->clk=0;
        top->eval();
	//usleep(5000);
        if (top->heptane_core__DOT__front_mod__DOT__cc_mod__DOT__cc_mod__DOT__wayMod_gen__BRA__7__KET____DOT__way_mod__DOT__tag_mod__DOT__init_reg2) printf("dinit7 0x%x\n",top->heptane_core__DOT__front_mod__DOT__cc_mod__DOT__cc_mod__DOT__wayMod_gen__BRA__7__KET____DOT__way_mod__DOT__tag_mod__DOT__write_NRU);
        top->rbusOut_can=1;
        if (!initcount) {
            req_set(top,reqs,mem,memp);
            cyc=cyc+1;
            if (!get_check(top,reqs,ip)) {
                printf("error @%i\n",cyc);
                sleep(1);
		return 1;
            }
            if ((cyc%100)==0) {
                printf("cycle %i\n",cyc);
            }
           
        } else {
            initcount=initcount-1;
            if (!initcount) Verilated::assertOn(true);
        }
    }
}
