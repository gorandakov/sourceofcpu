#include <cstdlib>
#include <cfenv>
#include "Vfu_alu.h"
#include "verilated.h"
#include "../inc/ptr.h"

#define get64(a) ((((unsigned long long) a[1])<<32)|(unsigned long long) a[0])
#define set64i(a,b,c) a[0]=b;a[1]=b>>32;a[2]=c;

unsigned short OPS_REGL[]={0,1,4,5,8,9,12,13,16,17,32|4096,33|4096,34|4096,
35|4096,36|4096,37|4096,39|4096,40|4096,41|4096,42|4096,43|4096,48|4096,49|4096,
50|4096,51|4096,52|4096,53|4096,54|4096,55|4096,56|4096,57|4096};
unsigned short OPS_S_REGL[]={0,1,4,5,8,9,12,13,16,17,20,21,24,25,28,29,32|4096,
33|4096,34|4096,35|4096,36|4096,37|4096,39|4096,40|4096,41|4096,42|4096,43|4096,48|4096,49|4096,50|4096,51|4096,52|4096,53|4096,54|4096,55|4096,56|4096,57|4096
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


char *reg32[]={
"eax",
"ebx",
"ecx",
"edx",
"esi",
"edi",
"esp",
"ebp",
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
"rsi",
"rdi",
"rsp",
"rbp",
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

char *reg16[]={
"ax",
"bx",
"cx",
"dx",
"si",
"di",
"sp",
"bp",
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

char *reg8[]={
"al",
"bl",
"cl",
"dl",
"sil",
"dil",
"spl",
"bpl",
"r8l",
"r9l",
"r10l",
"r11l",
"r12l",
"r13l",
"r14l",
"r15l",
"r16l",
"r17l",
"r18l",
"r19l",
"r20l",
"r21l",
"r22l",
"r23l",
"r24l",
"r25l",
"r26l",
"r27l",
"ah",
"bh",
"ch",
"dh"
};



class req {
    public:
    unsigned int op;
    unsigned long long A,B,res;
    unsigned A_p,B_p,res_p,excpt;
    unsigned flags,flags_in;
    unsigned fset;
    unsigned alt,mul;
    unsigned en;
    unsigned num[3];
    unsigned rA,rB,rT;
    unsigned base,index,scale;
    unsigned offset;
    unsigned has_mem;
    unsigned has_alu;
    char asmtext[32];
    void gen(bool alt_, bool mul_, bool can_shift, req *prev1=NULL,hcont *contx);
    void gen_init(int rT,int dom,unsigned long int val,int val_p);
    void flgPTR(__int128 r);
    void flg64(__int128 r);
    void flg32(__int128 r);
    void flgM64(unsigned long long r, bool big=0);
    void flgM128(unsigned __int128 r, bool big=0);
    bool testj(int code);
};
    
void req::gen_init(int rT,int dom,unsigned long int val,int val_p) {
    has_alu=true;
    res=val;
    res_p=val_p;
    op=32;
    rB=-1;
    rA=-1;
    this->rT=rT;
    op=32;
    if (!val_p) snprintf(asmtext,sizeof asmtext,"movabs $%li\n",B);
    else snprintf(asmtext,sizeof asmtext,"movabsp $%li\n",B);//WARNING: movabsp non impl and not in cpu spec
}

void req::gen(bool alt_, bool mul_, bool can_shift, req *prev1,hcont *contx) {
    alt=alt_;
    mul=mul_;
    excpt=-1;
    if (!alt && !mul && !can_shift) op=OPS_REGL[rand()%(sizeof OPS_REGL/2)];
    if (!alt && !mul && can_shift)  op=OPS_S_REGL[rand()%(sizeof OPS_S_REGL/2)];
    if (!alt && mul) op=OPS_M_REGL[rand()%(sizeof OPS_M_REGL/2)]|0x800;
    if (alt) op=rand()&0x1ffff;
    res_p=0;
    rA=rand()&0x1f;
    rB=rand()&0x1f;
    rT=rand()&0x1f;
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
        switch(op&0xff) {
            case 0:
	
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"addq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"addq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res0=((unsigned __int128)  A)+(unsigned __int128) B;
            if (A_p && B_p) excpt=11;
	    if (A_p && !B_p) res0= (res0&0xfffffffffff)|(A&0xfffff00000000000);
	    if (!A_p && B_p) res0= (res0&0xfffffffffff)|(B&0xfffff00000000000);
addie:
            ptr p,p2;
	    if (A_p || B_p) {
		res1=(res=res0)&0xfffffffffff;
		unsigned long low,hi;
		p.val=pttr;
		unsigned long b=p2.val;
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
                if (!no_O) {
		    flags|=((A1>0&&B1>0&&res1<0) || (A1<0&&B1<0&&res1>0))<<4;
                    flags|=(((A&0xf)+(B&0xf))&0x10)>>1;
	        }
	    }
            break;
            
            case 1:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"addl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"addl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=((unsigned __int128) A0x)+(unsigned __int128) B0x;
            res2=res=res0&0xffffffffull;
            flg32(res0);
            flags|=((A0>0&&B0>0&&res2<0) || (A0<0&&B0<0&&res2>0))<<4;
            flags|=(((A&0xf)+(B&0xf))&0x10)>>1;
            break;

            case 4:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"subq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
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
            
            if (!(A_p && B_p)) flags|=((A1>=0&&B1<0&&res1<0) || (A1<0&&B1>0&&res1>0))<<4;
            if ((A_p && B_p)) flags|=((!(A1&0x80000000000)&&(B1&0x80000000000)&&(res1&0x80000000000)) || 
		((A1&0x80000000000)&&!(B1&0x80000000000)&&!(res1&0x80000000000)))<<4;
            flags|=(((A&0xf)-(B&0xf))&0x10)>>1;
            break;
            
            case 5:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"subl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"subl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=((unsigned __int128) A0x)+((unsigned __int128) ~B0x)+1;
            res2=res=res0&0xffffffffull;
            flg32(res0^0x100000000ll);
            flags|=((A0>=0&&B0<0&&res2<0) || (A0<0&&B0>0&&res2>0))<<4;
            flags|=(((A&0xf)-(B&0xf))&0x10)>>1;
            break;

            case 8:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"andq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
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
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"andl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"andl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=A0x&B0x;
            res2=res=res0&0xffffffffull;
            flg32(res);
            break;

            case 12:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"orq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
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
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"orl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"orl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=A0x|B0x;
            res2=res=res0&0xffffffffull;
            flg32(res);
            break;

            case 16:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"xorq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
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
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"xorl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"xorl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=A0x^B0x;
            res2=res=res0&0xffffffffull;
            flg32(res);
            break;

            case 20:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"salq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"sllq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res0=((__int128) A)<<(B&0x3f);
            res1=res=res0;
            flg64(res0);
            break;

            case 21:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"sall %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"slll $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=((__int128) A0x)<<(B0x&0x3f);
            res2=res=res0&0xffffffffull;
            flg32(res0);
            break;

            case 24:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"slrq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"slrq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res0=(B&0x3f) ?((__int128)  A) >>((B&0x3f)-1) :((__int128)  A)<<1;
            res1=res=(res0>>1);
            flg64(((res0>>1)&0xffffffffffffffffull)|((res0&0x1) ? one<<1:0));
            break;

            case 25:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"slrl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"slrl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=(B0x&0x3f) ?((__int128)A0x) >>((B0x&0x3f)-1) :((__int128)  A0x)<<1;
            res=(res0>>1)&0xffffffffull;
            flg32(((res0>>1)&0xffffffffu)|((res0&0x1)<<32));
            break;

            case 28:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"sarq %%%s, %%%s, %%%s\n",reg65[rB],reg65[rA],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"sarq $%i, %%%s, %%%s\n",(int) B,reg65[rA],reg65[rT]);

            res0=(B&0x3f) ?((__int128) A1) >>((B&0x3f)-1) :((__int128)  A1)<<1;
            res1=res=(res0>>1);
            flg64(((res0>>1)&0xffffffffffffffffull)|((res0&0x1) ? one<<1 : 0));
            break;

            case 29:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"sarl %%%s, %%%s, %%%s\n",reg32[rB],reg32[rA],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"sarl $%i, %%%s, %%%s\n",(int) B,reg32[rA],reg32[rT]);

            res0=(B0x&0x3f) ? ((__int128) A0) >>((B0x&0x3f)-1) :((__int128) A0)<<1;
            res2=res=(res0>>1)&0xffffffffull;
            flg32(((res0>>1)&0xffffffffu)|((res0&0x1)<<32));
            break;
 
            case 32:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movq %%%s,  %%%s\n",reg65[rB],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movq $%i, %%%s\n",(int) B,reg65[rT]);
            res=B;
            flags=flags_in;
            break;

            case 33:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movl %%%s,  %%%s\n",reg32[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movl $%i, %%%s\n",(int) B,reg32[rT]);
            res=B&0xffffffffull;
            flags=flags_in;
            break;

            case 34:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movw %%%s,  %%%s\n",reg16[rB],reg16[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movw $%i, %%%s\n",(int) B,reg16[rT]);
            res=(B&0xffffull)|(A&0xffffffffffff0000ull);
            flags=flags_in;
            break;

            case 35:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movq %%%s,  %%%s\n",reg8[rB],reg8[rT]);
	    else snprintf(asmtext,sizeof asmtext,"sarl $%i, %%%s\n",(int) B,reg8[rT]);
            if (op&256) res=(A&0xffffffffffff00ffull)| ((op&1024) ? B&0xff00ull :
                (B&0xffull)<<8);
            else res=(A&0xffffffffffffff00ull)| ((op&1024) ? (B&0xff00ull)>>8 :
                B&0xffull);
            flags=flags_in;
            break;

            case 36:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movzbl %%%s,  %%%s\n",reg32[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movzbl $%i, %%%s\n",(int) B,reg32[rT]);
            res=B&0xffull;
            flags=flags_in;
            break;

            case 37:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movzwl %%%s,  %%%s\n",reg32[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movzwl $%i, %%%s\n",(int) B,reg32[rT]);
            res=B&0xffffull;
            flags=flags_in;
            break;

            case 39:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movsbq %%%s,  %%%s\n",reg65[rB],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movsbq $%i, %%%s\n",(int) B,reg65[rT]);
            res=(B&0x80) ? B|0xffffffffffffff00ull : B&0xffull;
            flags=flags_in;
            break;

            case 40:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movswq %%%s,  %%%s\n",reg65[rB],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movswq $%i, %%%s\n",(int) B,reg65[rT]);
            res=(B&0x8000) ? B|0xffffffffffff0000ull : B&0xffffull;
            flags=flags_in;
            break;

            case 41:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movslq %%%s,  %%%s\n",reg65[rB],reg65[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movslq $%i, %%%s\n",(int) B,reg65[rT]);
            res=(B&0x80000000) ? B|0xffffffff00000000ull : B&0xffffffffull;
            flags=flags_in;
            break;

            case 42:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movsbl %%%s,  %%%s\n",reg32[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movsbl $%i, %%%s\n",(int) B,reg32[rT]);
            res=(B0&0x80) ? B0x|0xffffff00ull : B0x&0xffull;
            flags=flags_in;
            break;

            case 43:
	    if (rB>=0) snprintf(asmtext,sizeof asmtext,"movswl %%%s,  %%%s\n",reg32[rB],reg32[rT]);
	    else snprintf(asmtext,sizeof asmtext,"movswl $%i, %%%s\n",(int) B,reg32[rT]);
            res=(B0&0x8000) ? B0x|0xffff0000ull : B0x&0xffffull;
            flags=flags_in;
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
            break;
            
            case 50:
            case 51:
            op|=rand()&0x700;
            op|=rand()&0x700;
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
                A0x=A,B0x=B;
	    }
	    snprintf(asmtext,sizeof asmtext,"cmov%sl %%%s, %%%s, %%%s\n",COND(op),reg32[rB],reg32[rA],reg32[rT]);
            res=testj(((op&0x700)>>7)|(op&0x1)) ? B0x : A0x;
            flags=flags_in;
            break;
            
            
            case 52:
            case 53:
            op|=rand()&0x700;
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    snprintf(asmtext,sizeof asmtext,"clahf%s %%%s\n",COND(op),reg32[rA]);
            res=0;
            flags=testj(((op&0x700)>>7)|(op&0x1)) ? A&0x3f : flags_in;
            break;

            case 54:
            case 55:
            op|=rand()&0x700;
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    snprintf(asmtext,sizeof asmtext,"cset%s %%%s\n",COND(op),reg32[rT]);
            res=testj(((op&0x700)>>7)|(op&0x1));
            flags=flags_in;
            break;

            case 56:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    snprintf(asmtext,sizeof asmtext,"sahf %%%s\n",reg32[rT]);
            res=flags_in&0x3f;
            flags=flags_in;
            break;

            case 57:
	    if (rB<0) {
		rB=rand()&0x1f;
		B=contx->reg_gen[rB];
		B_p=contx->reg_genP[rB];
	    }
	    snprintf(asmtext,sizeof asmtext,"lahf %%%s\n",reg32[rA]);
            res=0;
            flags=A&0x3f;
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
        resSx= (signed long) As * (signed long) Bs;
        res0x=(unsigned long) Au * (unsigned long) Bu;
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
            fp_get_ext((op&0x400) ? (long double) (signed long) B : 
              (long double) B,num);
            flags=flags_in;
            break;
            
            case 13:
            fp_get_double((op&0x400) ? (double) (signed long) B : 
              (double) B,num);
            flags=flags_in;
            break;

            case 14:
            fp_get_single((op&0x400) ? (float) (signed long) B : (float) B,num);
            flags=flags_in;
            break;
        }
    }
    en=rand()&0xff!=0;
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
    long r1=r;
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


void req_set(Vfu_alu *mod,req *reqs,char *mem) {
    static unsigned long addr[32];
    static unsigned pos=0;
    static unsigned pos_R=0;
    static bool R=0;
    if (top->rbusOut_want && top->rbusOut_can) {
	addr[pos]=top->rbusOut_addr;
	sigs[pos]=top->rbusOut_signals;
	src[pos]=top->rbusOut_src_req;
	pos++;
    }
    if (pos_R!=pos) {
	unsigned signals=0;
	top->rbusDIn_signals=signals;
	top->rbusDIn_src_req=src[pos_R];
	if (!R) {
	    memcpy((char *) top->rbusDIn_data,mem[addr[pos_R]<<7],64);
	} else {
	    memcpy((char *) top->rbusDIn_data,mem[(addr[pos_R]<<7)+64],64);
	}
    }
}

bool get_check(Vfu_alu *top, req *reqs) {
    bool rtn=true;
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
        unsigned long *p1= (unsigned long *)&a;
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

void gen_prog(req *reqs,int count, FILE *f) {
   int n;
   for(n=0;n<31;n++) {
       if (n!=6) reqs[n].gen_init(n,0,0,0);
       else reqs[n].gen_init(n,0,0xf80fc00008000000,1);
   }
   reqs[31].gen_init(31,0,0x8000,0);
   reqs[32].gen_movcsr(csr_page,31);
   
}


int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);
    Vheptane_core *top=new Vfu_alu();
    Verilated::assertOn(false);
    int initcount=10;
    int cyc=0;
    req *reqs=new req[10*100000000];
    fesetround(FE_TOWARDZERO);
    top->clk=0;
    top->rst=1;
    top->except=0;
    gen_prog(reqs[0],100000000)
    req_set(top,reqs[0]);
    top->eval();
    top->clk=1;
    top->eval();
    top->rst=0;
    while(!Verilated::gotFinish()) {
        int k,j;
        top->clk=0;
        top->eval();
        top->eval();
        top->clk=1;
        top->eval();
        req_set(top,reqs[0]);
        top->eval();
        if (!initcount) {
            cyc=cyc+1;
            if (!get_check(top,reqs[1])) {
                printf("error @%i\n",cyc);
                sleep(1);
            }
            if ((cyc%10000)==0) {
                printf("cycle %i\n",cyc);
            }

        } else {
            initcount=initcount-1;
            if (!initcount) Verilated::assertOn(true);
        }
    }
}
