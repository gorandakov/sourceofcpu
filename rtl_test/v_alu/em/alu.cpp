#include <cstdlib>
#include <cfenv>
#include "Vfu_alu.h"
#include "verilated.h"
#include "../inc/ptr.h"

#define get64(a) ((((unsigned long long) a[1])<<32)|(unsigned long long) a[0])
#define set64i(a,b,c) a[0]=b;a[1]=b>>32;a[2]=c;


void fp_get_ext(long double a, unsigned num[3]);
void fp_get_double(double a, unsigned num[3]);
void fp_get_single(float a, unsigned num[3]);
bool ckran_alu(unsigned long long ptr,unsigned long long addr);

class req {
    public:
    unsigned int op;
    unsigned long long A,B,res;
    unsigned A_p,B_p,res_p,excpt;
    unsigned flags,flags_in;
    unsigned fset;
    unsigned long mul[MULCNT];
    unsigned long alu[ALUCNT];
    unsigned long mov[MOVCNT];
    unsigned long flaginstr[FLAGCNT];
    unsigned long shift[SHIFTCNT];
    unsigned mul_p[MULCNT];
    unsigned alu_p[ALUCNT];
    unsigned mov_p[MOVCNT];
    unsigned flaginstr_p[FLAGCNT];
    unsigned shift_p[SHIFTCNT];
    unsigned mul_f[MULCNT];
    unsigned alu_f[ALUCNT];
    unsigned mov_f[MOVCNT];
    unsigned flaginstr_f[FLAGCNT];
    unsigned shift_f[SHIFTCNT];
    void gen();
    void flgPTR(__int128 r);
    void flg64(__int128 r);
    void flg32(__int128 r);
    void flgM64(unsigned long long r, bool big=0);
    void flgM128(unsigned __int128 r, bool big=0);
    bool testj(int code);
};
#define ADDIE \
	    if (A_p || B_p) {\
		res1=(res=res0)&0xfffffffffff;\
		unsigned long low,hi;\
		p.val=pttr;\
		unsigned long b=p2.val;\
		if (!no_O) p2.val=res;\
		unsigned exp=p.val>>59;\
		bool flip;\
\
		if (!p.get_bounds2(no_O,p2,b,flip) && (exp!=31 || no_O)) {\
		    excpt=11;\
		    break;\
		}\
		if (flip) {\
		    res^=1ul<<44;\
		};\
		res_p=1;\
                flg64(res0);\
	        res1=res0;\
	    } else {\
                res1=res=res0;\
		res_p=0;\
                flg64(res0);\
	        res1=res0;\
                if (!no_O) {\
		    flags|=((A1>0&&B1>0&&res1<0) || (A1<0&&B1<0&&res1>0))<<4;\
                    flags|=(((A&0xf)+(B&0xf))&0x10)>>1;\
	        }\
	    }

void req::gen(void) {
        __int128 res0;
        int A0=A,B0=B,res2;
        unsigned A0x=A,B0x=B;
        long long int A1=A,B1=B,res1;
        unsigned __int128 one=0x8000000000000000ull;
        unsigned long long pttr=A_p ? A : B;
	int no_O=0;
            res0=((unsigned __int128)  A)+(unsigned __int128) B;
            if (A_p && B_p) excpt=11;
	    if (A_p && !B_p) res0= (res0&0xfffffffffff)|(A&0xfffff00000000000);
	    if (!A_p && B_p) res0= (res0&0xfffffffffff)|(B&0xfffff00000000000);
            ptr p,p2;
	    ADDIE
	    alu  [0]=res;
	    alu_p[0]=res_p;
	    alu_f[0]=flags;
            
            res0=((unsigned __int128) A0x)+(unsigned __int128) B0x;
            res2=res=res0&0xffffffffull;
            flg32(res0);
            flags|=((A0>0&&B0>0&&res2<0) || (A0<0&&B0<0&&res2>0))<<4;
            flags|=(((A&0xf)+(B&0xf))&0x10)>>1;
	    alu  [1]=res;
	    alu_p[1]=res_p;
	    alu_f[1]=flags;

            res0=((unsigned __int128) A)+((unsigned __int128)~B)+(one>>63);
	    if (A_p && !B_p) {
                res0=(((unsigned __int128) A)+(((unsigned __int128)~B)+(one>>63))&0xffffffffffful)|
		((unsigned __int128) A&0xfffff00000000000ul);
		ADDIE; 
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
	    alu  [2]=res;
	    alu_p[2]=res_p;
	    alu_f[2]=flags;
            
            res0=((unsigned __int128) A0x)+((unsigned __int128) ~B0x)+1;
            res2=res=res0&0xffffffffull;
            flg32(res0^0x100000000ll);
            flags|=((A0>=0&&B0<0&&res2<0) || (A0<0&&B0>0&&res2>0))<<4;
            flags|=(((A&0xf)-(B&0xf))&0x10)>>1;
	    alu  [3]=res;
	    alu_p[3]=res_p;
	    alu_f[3]=flags;

            res1=res=res0=A&B;
	    if (A_p && B_p) excpt=11;
	    if (A_p && !B_p) { 
		no_O=2; 
                res1=res=res0=A&(B|0xfffff00000000000);
		p2.val=B&0xfffffffffff;
		ADDIE 
	    }
	    if (!A_p && B_p) { 
		no_O=2; 
                res1=res=res0=B&(A|0xfffff00000000000);
		p2.val=A&0xfffffffffff;
		ADDIE 
	    }
            res1=res=res0;
            flg64(res0);
	    alu  [4]=res;
	    alu_p[4]=res_p;
	    alu_f[4]=flags;

            case 9:
            res0=A0x&B0x;
            res2=res=res0&0xffffffffull;
            flg32(res);
	    alu  [5]=res;
	    alu_p[5]=res_p;
	    alu_f[5]=flags;

            case 12:
            res1=res=res0=A|B;
	    if (A_p && B_p) excpt=11;
	    if (A_p && !B_p) { 
		no_O=1; 
                res1=res=res0=A|(B&0xfffffffffff);
		p2.val=B&0xfffffffffff;
		ADDIE 
	    }
	    if (!A_p && B_p) { 
		no_O=1; 
                res1=res=res0=B|(A&0xfffffffffff);
		p2.val=A&0xfffffffffff;
		ADDIE 
	    }
            res1=res=res0;
            flg64(res0);
	    alu  [6]=res;
	    alu_p[6]=res_p;
	    alu_f[6]=flags;

            res0=A0x|B0x;
            res2=res=res0&0xffffffffull;
            flg32(res);
	    alu  [7]=res;
	    alu_p[7]=res_p;
	    alu_f[7]=flags;

            res1=res=res0=A^B;
	    if (A_p && B_p) excpt=11;
	    if (A_p && !B_p) { 
		no_O=1; 
                res1=res=res0=A^(B&0xfffffffffff);
		p2.val=B&0xfffffffffff;
		ADDIE 
	    }
	    if (!A_p && B_p) { 
		no_O=1; 
                res1=res=res0=B^(A&0xfffffffffff);
		p2.val=A&0xfffffffffff;
		ADDIE 
	    }
            res1=res=res0;
            flg64(res0);
	    alu  [8]=res;
	    alu_p[8]=res_p;
	    alu_f[8]=flags;

            res0=A0x^B0x;
            res2=res=res0&0xffffffffull;
            flg32(res);
	    alu  [9]=res;
	    alu_p[9]=res_p;
	    alu_f[9]=flags;

            res0=((__int128) A)<<(B&0x3f);
            res1=res=res0;
            flg64(res0);
	    shift  [0]=res;
	    shift_p[0]=res_p;
	    shift_f[0]=flags;

            res0=((__int128) A0x)<<(B0x&0x3f);
            res2=res=res0&0xffffffffull;
            flg32(res0);
	    shift  [1]=res;
	    shift_p[1]=res_p;
	    shift_f[1]=flags;

            res0=(B&0x3f) ?((__int128)  A) >>((B&0x3f)-1) :((__int128)  A)<<1;
            res1=res=(res0>>1);
            flg64(((res0>>1)&0xffffffffffffffffull)|((res0&0x1) ? one<<1:0));
	    shift  [2]=res;
	    shift_p[2]=res_p;
	    shift_f[2]=flags;

            res0=(B0x&0x3f) ?((__int128)A0x) >>((B0x&0x3f)-1) :((__int128)  A0x)<<1;
            res=(res0>>1)&0xffffffffull;
            flg32(((res0>>1)&0xffffffffu)|((res0&0x1)<<32));
	    shift  [3]=res;
	    shift_p[3]=res_p;
	    shift_f[3]=flags;

            res0=(B&0x3f) ?((__int128) A1) >>((B&0x3f)-1) :((__int128)  A1)<<1;
            res1=res=(res0>>1);
            flg64(((res0>>1)&0xffffffffffffffffull)|((res0&0x1) ? one<<1 : 0));
	    shift  [4]=res;
	    shift_p[4]=res_p;
	    shift_f[4]=flags;

            res0=(B0x&0x3f) ? ((__int128) A0) >>((B0x&0x3f)-1) :((__int128) A0)<<1;
            res2=res=(res0>>1)&0xffffffffull;
            flg32(((res0>>1)&0xffffffffu)|((res0&0x1)<<32));
	    shift  [5]=res;
	    shift_p[5]=res_p;
	    shift_f[5]=flags;
 
            res=B;
	    res_p=B_p;
            flags=flags_in;
	    mov  [0]=res;
	    mov_p[0]=res_p;
	    mov_f[0]=flags;

            res=B&0xffffffffull;
	    res_p=0;
            flags=flags_in;
	    mov  [1]=res;
	    mov_p[1]=res_p;
	    mov_f[1]=flags;

            res=(B&0xffffull)|(A&0xffffffffffff0000ull);
	    res_p=0;
            flags=flags_in;
	    mov  [2]=res;
	    mov_p[2]=res_p;
	    mov_f[2]=flags;

	    res_p=0;
            if (op&256) res=(A&0xffffffffffff00ffull)| ((op&1024) ? B&0xff00ull :
                (B&0xffull)<<8);
            else res=(A&0xffffffffffffff00ull)| ((op&1024) ? (B&0xff00ull)>>8 :
                B&0xffull);
            flags=flags_in;
	    mov  [3]=res;
	    mov_p[3]=res_p;
	    mov_f[3]=flags;

            res=B&0xffull;
	    res_p=0;
            flags=flags_in;
	    mov  [4]=res;
	    mov_p[4]=res_p;
	    mov_f[4]=flags;

            res=B&0xffffull;
	    res_p=0;
            flags=flags_in;
	    mov  [5]=res;
	    mov_p[5]=res_p;
	    mov_f[5]=flags;

            res=(B&0x80) ? B|0xffffffffffffff00ull : B&0xffull;
	    res_p=0;
            flags=flags_in;
	    mov  [6]=res;
	    mov_p[6]=res_p;
	    mov_f[6]=flags;

            res=(B&0x8000) ? B|0xffffffffffff0000ull : B&0xffffull;
	    res_p=0;
            flags=flags_in;
	    mov  [7]=res;
	    mov_p[7]=res_p;
	    mov_f[7]=flags;

            res=(B&0x80000000) ? B|0xffffffff00000000ull : B&0xffffffffull;
	    res_p=0;
            flags=flags_in;
	    mov  [8]=res;
	    mov_p[8]=res_p;
	    mov_f[8]=flags;

            res=(B0&0x80) ? B0x|0xffffff00ull : B0x&0xffull;
	    res_p=0;
            flags=flags_in;
	    mov  [9]=res;
	    mov_p[9]=res_p;
	    mov_f[9]=flags;

            res=(B0&0x8000) ? B0x|0xffff0000ull : B0x&0xffffull;
	    res_p=0;
            flags=flags_in;
	    mov  [10]=res;
	    mov_p[10]=res_p;
	    mov_f[10]=flags;

            res=testj(((op&0x700)>>7)|(op&0x1)) ? B : A;
            res_p=testj(((op&0x700)>>7)|(op&0x1)) ? B_p : A_p;
            flags=flags_in;
	    mov  [11]=res;
	    mov_p[11]=res_p;
	    mov_f[11]=flags;
            
            res=testj(((op&0x700)>>7)|(op&0x1)) ? B0x : A0x;
	    res_p=0;
            flags=flags_in;
	    mov  [12]=res;
	    mov_p[12]=res_p;
	    mov_f[12]=flags;
            
            
            res=0;
	    res_p=0;
            flags=testj(((op&0x700)>>7)|(op&0x1)) ? A&0x3f : flags_in;
	    flaginstr  [0]=res;
	    flaginstr_p[0]=res_p;
	    flaginstr_f[0]=flags;

            res=testj(((op&0x700)>>7)|(op&0x1));
	    res_p=0;
            flags=flags_in;
	    flaginstr  [1]=res;
	    flaginstr_p[1]=res_p;
	    flaginstr_f[1]=flags;

            res=flags_in&0x3f;
	    res_p=0;
            flags=flags_in;
	    flaginstr  [2]=res;
	    flaginstr_p[2]=res_p;
	    flaginstr_f[2]=flags;

            res=0;
	    res_p=0;
            flags=A&0x3f;
	    flaginstr  [3]=res;
	    flaginstr_p[3]=res_p;
	    flaginstr_f[3]=flags;
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
            res=res0x;
	    res_p=0;
            flgM64(res0x,true);
	    mul  [0]=res;
	    mul_p[0]=res_p;
	    mul_f[0]=flags;

            res=res0x & 0xffffffffull;
	    res_p=0;
            flgM64(res0x);
	    mul  [1]=res;
	    mul_p[1]=res_p;
	    mul_f[1]=flags;

            res=res0;
	    res_p=0;
            flgM128(res0);
	    mul  [2]=res;
	    mul_p[2]=res_p;
	    mul_f[2]=flags;
            
            res=resSx;
	    res_p=0;
            flgM64(resSx,1);
	    mul  [3]=res;
	    mul_p[3]=res_p;
	    mul_f[3]=flags;

            res=resSx & 0xffffffffull;
	    res_p=0;
            flgM64(resSx);
	    mul  [4]=res;
	    mul_p[4]=res_p;
	    mul_f[4]=flags;

            res=resS;
	    res_p=0;
            flgM128(resS);
	    mul  [5]=res;
	    mul_p[5]=res_p;
	    mul_f[5]=flags;

            resU=resS>>63;
            res=resU>>1;
	    res_p=0;
            flgM128(resS,1);
	    mul  [6]=res;
	    mul_p[6]=res_p;
	    mul_f[6]=flags;
            
            resU=res0>>63;
            res=resU>>1;
	    res_p=0;
            flgM128(res0,1);
	    mul  [7]=res;
	    mul_p[7]=res_p;
	    mul_f[7]=flags;

	    mul  [8]=B;
	    mul_p[8]=0;
	    mul_f[8]=flags_in;

	    mul  [9]=B;
	    mul_p[9]=1;
	    mul_f[9]=flags_in;

	    /*
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
    en=rand()&0xff!=0;*/
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

void gen_reqs(req *reqs,bool simp=false) {
    req *ptr=simp ? NULL : reqs+10;
    bool a=simp ? false : ptr[29].mul&&ptr[29].en; 
    bool mul=rand()%10==0;
    reqs[0].gen(0,0,0);
    reqs[1].gen(0,0,1);
    reqs[2].gen(0,0,0);
    reqs[3].gen(0,0,1);
    reqs[4].gen(0,0,0,ptr);
    reqs[5].gen(0,0,0,ptr);
    reqs[6].gen(a,0,0,ptr);
    reqs[7].gen(0,0,1,ptr);
    reqs[8].gen(0,0,1,ptr);
    reqs[9].gen(0,mul,1,ptr);

    if (a) {
        reqs[6].res=ptr[29].res;
        reqs[6].flags=ptr[29].flags;
        reqs[6].op=ptr[29].op;
        reqs[6].num[0]=ptr[29].num[0];
        reqs[6].num[1]=ptr[29].num[1];
        reqs[6].num[2]=ptr[29].num[2];
        reqs[6].en=0;
    }
}

void req_set(Vfu_alu *mod,req reqs[10]) {
    set64i(mod->u1_A,reqs[4].A,reqs[4].A_p);
    set64i(mod->u1_B,reqs[4].B,reqs[4].B_p);
    mod->u1_S=reqs[14].flags_in;
    mod->u1_op=reqs[4].op;
    mod->u1_clkEn=reqs[4].en;
    mod->u1_A_fufwd=reqs[4].fuA();
    mod->u1_A_fuufwd=reqs[4].fuuA();
    mod->u1_B_fufwd=reqs[4].fuB();
    mod->u1_B_fuufwd=reqs[4].fuuB();
    mod->u1_S_fufwd=reqs[14].fuFl();
    mod->u1_S_fuufwd=reqs[14].fuuFl();

    set64i(mod->u3_A,reqs[5].A,reqs[5].A_p);
    set64i(mod->u3_B,reqs[5].B,reqs[5].B_p);
    mod->u3_S=reqs[15].flags_in;
    mod->u3_op=reqs[5].op;
    mod->u3_clkEn=reqs[5].en;
    mod->u3_A_fufwd=reqs[5].fuA();
    mod->u3_A_fuufwd=reqs[5].fuuA();
    mod->u3_B_fufwd=reqs[5].fuB();
    mod->u3_B_fuufwd=reqs[5].fuuB();
    mod->u3_S_fufwd=reqs[15].fuFl();
    mod->u3_S_fuufwd=reqs[15].fuuFl();

    set64i(mod->u5_A,reqs[6].A,reqs[6].A_p);
    set64i(mod->u5_B,reqs[6].B,reqs[6].B_p);
    mod->u5_S=reqs[16].flags_in;
    mod->u5_op=reqs[6].op;
    mod->u5_clkEn=reqs[6].en && !reqs[6].alt;
    mod->u5_A_fufwd=reqs[6].fuA();
    mod->u5_A_fuufwd=reqs[6].fuuA();
    mod->u5_B_fufwd=reqs[6].fuB();
    mod->u5_B_fuufwd=reqs[6].fuuB();
    mod->u5_S_fufwd=reqs[16].fuFl();
    mod->u5_S_fuufwd=reqs[16].fuuFl();
    mod->u5_nDataAlt=1;

    set64i(mod->u2_A,reqs[7].A,reqs[7].A_p);
    set64i(mod->u2_B,reqs[7].B,reqs[7].B_p);
    mod->u2_S=reqs[17].flags_in;
    mod->u2_op=reqs[7].op;
    mod->u2_clkEn=reqs[7].en;
    mod->u2_A_fufwd=reqs[7].fuA();
    mod->u2_A_fuufwd=reqs[7].fuuA();
    mod->u2_B_fufwd=reqs[7].fuB();
    mod->u2_B_fuufwd=reqs[7].fuuB();
    mod->u2_S_fufwd=reqs[17].fuFl();
    mod->u2_S_fuufwd=reqs[17].fuuFl();

    set64i(mod->u4_A,reqs[8].A,reqs[8].A_p);
    set64i(mod->u4_B,reqs[8].B,reqs[8].B_p);
    mod->u4_S=reqs[18].flags_in;
    mod->u4_op=reqs[8].op;
    mod->u4_clkEn=reqs[8].en;
    mod->u4_A_fufwd=reqs[8].fuA();
    mod->u4_A_fuufwd=reqs[8].fuuA();
    mod->u4_B_fufwd=reqs[8].fuB();
    mod->u4_B_fuufwd=reqs[8].fuuB();
    mod->u4_S_fufwd=reqs[18].fuFl();
    mod->u4_S_fuufwd=reqs[18].fuuFl();

    set64i(mod->u6_A,reqs[9].A,reqs[9].A_p);
    set64i(mod->u6_B,reqs[9].B,reqs[9].B_p);
    mod->u6_S=reqs[19].flags_in;
    mod->u6_op=reqs[9].op;
    mod->u6_clkEn=reqs[9].en;
    mod->u6_A_fufwd=reqs[9].fuA();
    mod->u6_A_fuufwd=reqs[9].fuuA();
    mod->u6_B_fufwd=reqs[9].fuB();
    mod->u6_B_fuufwd=reqs[9].fuuB();
    mod->u6_S_fufwd=reqs[19].fuFl();
    mod->u6_S_fuufwd=reqs[19].fuuFl();
    
    mod->FUS4=reqs[24].flags;
    mod->FUS5=reqs[25].flags;
    mod->FUS6=reqs[26].flags;
    mod->FUS7=reqs[27].flags;
    mod->FUS8=reqs[28].flags;
    mod->FUS9=reqs[29].flags;

    set64i(mod->FU0,reqs[10].res,reqs[10].res_p);
    set64i(mod->FU1,reqs[11].res,reqs[11].res_p);
    set64i(mod->FU2,reqs[12].res,reqs[12].res_p);
    set64i(mod->FU3,reqs[13].res,reqs[13].res_p);

   /* if (reqs[16].alt) mod->FU6=reqs[6].res;
    else mod->FU6=0xbaadf00dbaadf00dull;
    if (reqs[26].alt) mod->u5_ret=(reqs[26].flags<<3)|2|((reqs[26].op&0x1000)>>10);
    else mod->u5_ret=0;*/
}

bool get_check(Vfu_alu *top, req *reqs) {
    bool rtn=true;
    static unsigned num_s[3];

    if (reqs[4].en && !(get64(top->FU4)==reqs[4].res) && reqs[4].excpt!=11) { 
        printf("FU4 error;op=%i:%i;res=%llx:%llx;%i:%i:%i\n",
        top->fu_alu__DOT__u1_op_reg,reqs[4].op,
        get64(top->FU4),reqs[4].res,reqs[4].A_p,reqs[4].B_p,reqs[4].res_p);
        rtn=false; 
	    printf("A=%lx,B=%lx,A_p=%i,B_p=%i,soft=%i\n",
		reqs[4].A,
		reqs[4].B,
		reqs[4].A_p,
		reqs[4].B_p,
		reqs[4].excpt);
    }
    if (reqs[5].en && !(get64(top->FU5)==reqs[5].res) && reqs[5].excpt!=11) { 
        printf("FU5 error;op=%i:%i;res=%llx:%llx\n",
        top->fu_alu__DOT__u3_op_reg,reqs[5].op,
        get64(top->FU5),reqs[5].res);
        rtn=false; 
    }
    if (reqs[6].en && !(get64(top->FU6)==reqs[6].res) && reqs[6].excpt!=11)  {
        printf("FU6 error;op=%i:%i;res=%llx:%llx;%i:%i:%i\n",
        top->fu_alu__DOT__u5_op_reg,reqs[6].op,
        get64(top->FU6),reqs[6].res,reqs[6].A_p,reqs[6].B_p,reqs[6].res_p);
        rtn=false; 
    }
    if (reqs[7].en && !(get64(top->FU7)==reqs[7].res) && reqs[7].excpt!=11)  {
        printf("FU7 error;op=%i:%i;res=%llx:%llx\n;%i:%i:%i",
        top->fu_alu__DOT__u2_op_reg,reqs[7].op,
        get64(top->FU7),reqs[7].res,reqs[7].A_p,reqs[7].B_p,reqs[7].res_p);
        rtn=false; 
    }
    if (reqs[8].en && !(get64(top->FU8)==reqs[8].res) && reqs[8].excpt!=11)  {
        printf("FU8 error;op=%i:%i;res=%llx:%llx\n",
        top->fu_alu__DOT__u4_op_reg,reqs[8].op,
        get64(top->FU8),reqs[8].res);
	    printf("A=%lx,B=%lx,A_p=%i,B_p=%i,soft=%i\n",
		reqs[8].A,
		reqs[8].B,
		reqs[8].A_p,
		reqs[8].B_p,
		reqs[8].excpt);
        rtn=false; 
    }
    if (reqs[9].en && !reqs[9].mul && !(get64(top->FU9)==reqs[9].res) && reqs[9].excpt!=11)  {
        printf("FU9 error;op=%i:%i;res=%llx:%llx\n",
        top->fu_alu__DOT__u6_op_reg,reqs[9].op,
        get64(top->FU9),reqs[9].res);
	    printf("A=%lx,B=%lx,A_p=%i,B_p=%i,soft=%i\n",
		reqs[9].A,
		reqs[9].B,
		reqs[9].A_p,
		reqs[9].B_p,
		reqs[9].excpt);
        rtn=false; 
    }

    if (reqs[14].en && (!((top->u1_ret>>3)==reqs[14].flags || 
        !(top->u1_ret&0x4) || reqs[14].excpt==11) || ((top->u1_ret&3)==1)!=(reqs[14].excpt==11))) {
        printf("ret4 error;op=%i;ret=%x:%x\n",
        reqs[14].op,
        top->u1_ret*2,reqs[14].flags);
	if (((top->u1_ret&3)==1)!=(reqs[14].excpt==11) || 1) {
	    printf("A=%lx,B=%lx,A_p=%i,B_p=%i,soft=%i\n",
		reqs[14].A,
		reqs[14].B,
		reqs[14].A_p,
		reqs[14].B_p,
		reqs[14].excpt);
	}
        rtn=false; 
    }
    if (reqs[15].en && (!((top->u3_ret>>3)==reqs[15].flags || 
        !(top->u3_ret&0x4) || reqs[15].excpt==11) || ((top->u3_ret&3)==1)!=(reqs[15].excpt==11))) {
        printf("ret5 error;op=%i;ret=%x:%x\n",
        reqs[15].op,
        top->u3_ret*2,reqs[15].flags);
        rtn=false; 
	if (((top->u3_ret&3)==1)!=(reqs[15].excpt==11) || 1) {
	    printf("A=%lx,B=%lx,A_p=%i,B_p=%i,soft=%i\n",
		reqs[15].A,
		reqs[15].B,
		reqs[15].A_p,
		reqs[15].B_p,
		reqs[15].excpt);
	}
    }
    if ((reqs[16].en || reqs[16].alt) && (!((top->u5_ret>>3)==reqs[16].flags || 
        !(top->u5_ret&0x4) || reqs[16].excpt==11) || ((top->u5_ret&3)==1)!=(reqs[16].excpt==11))) {
        printf("ret6 error;op=%i;ret=%x:%x;ex=%i;res=%llx\n",
        reqs[16].op,
        top->u5_ret*2,reqs[16].flags,
	((top->u5_ret&3)==1)!=(reqs[16].excpt==11),
	reqs[16].res);
	if (((top->u5_ret&3)==1)!=(reqs[16].excpt==11) ||1) {
	    printf("A=%lx,B=%lx,A_p=%i,B_p=%i,soft=%i\n",
		reqs[16].A,
		reqs[16].B,
		reqs[16].A_p,
		reqs[16].B_p,
		reqs[16].excpt);
	}
        rtn=false; 
    }
    if (reqs[17].en && (!((top->u2_ret>>3)==reqs[17].flags || 
        !(top->u2_ret&0x4) || reqs[17].excpt==11) || ((top->u2_ret&3)==1)!=(reqs[17].excpt==11))) {
        printf("ret7 error;op=%i;ret=%x:%x\n",
        reqs[17].op,
        top->u2_ret*2,reqs[17].flags);
	if (((top->u2_ret&3)==1)!=(reqs[17].excpt==11) || 1) {
	    printf("A=%lx,B=%lx,A_p=%i,B_p=%i,soft=%i\n",
		reqs[17].A,
		reqs[17].B,
		reqs[17].A_p,
		reqs[17].B_p,
		reqs[17].excpt);
	}
        rtn=false; 
    }
    if (reqs[18].en && (!((top->u4_ret>>3)==reqs[18].flags || 
        !(top->u4_ret&0x4) || reqs[18].excpt==11) || ((top->u4_ret&3)==1)!=(reqs[18].excpt==11))) {
        printf("ret8 error;op=%i;ret=%x:%x\n",
        reqs[18].op,
        top->u4_ret*2,reqs[18].flags);
        rtn=false; 
    }
    if (reqs[19].en && !reqs[19].mul &&  (!((top->u6_ret>>3)==reqs[19].flags || 
        !(top->u6_ret&0x4) || reqs[19].excpt==11) || ((top->u6_ret&3)==1)!=(reqs[19].excpt==11))) {
        printf("ret9 error;op=%i;ret=%x:%x\n",
        reqs[19].op,
        top->u6_ret*2,reqs[19].flags);
        rtn=false; 
	if (((top->u6_ret&3)==1)!=(reqs[19].excpt==11) || 1) {
	    printf("A=%lx,B=%lx,A_p=%i,B_p=%i,soft=%i\n",
		reqs[19].A,
		reqs[19].B,
		reqs[19].A_p,
		reqs[19].B_p,
		reqs[19].excpt);
	}
    }

    if (reqs[6].alt) {
        if ((reqs[6].op&0xff)<12) {
            if (!(get64(top->FU6)==reqs[6].res))  {
                printf("FU6-M error;op=%i:%i;res=%llx:%llx\n",
                top->fu_alu__DOT__u5_op_reg&0xff,reqs[6].op&0xff,
                get64(top->FU6),reqs[6].res);
                rtn=false; 
            }
        } else {
            if (reqs[6].num[0]!=num_s[0] || reqs[6].num[1]!=num_s[1] ||
                reqs[6].num[2]!=num_s[2]) {
                printf("FU6-MC error;op=%i:%i;res=%llx:%llx\n",
                top->fu_alu__DOT__u5_op_reg&0x4ff,reqs[6].op&0x4ff,
                get64(top->FU6),reqs[6].res);
                rtn=false; 
            }
        }
    }
    num_s[0]=top->fcvtout[0];
    num_s[1]=top->fcvtout[1];
    num_s[2]=top->fcvtout[2];
    return rtn;

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

int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);
    Vfu_alu *top=new Vfu_alu();
    Verilated::assertOn(false);
    int initcount=10;
    int cyc=0;
    req reqs[4][10];
    fesetround(FE_TOWARDZERO);
    top->clk=0;
    top->rst=1;
    top->except=0;
    gen_reqs(reqs[1],1);
    gen_reqs(reqs[2],1);
    gen_reqs(reqs[3],1);
    gen_reqs(reqs[0]);
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
        for(k=3;k>=1;k=k-1) {
            for(j=0;j<10;j++) {
                reqs[k][j]=reqs[k-1][j];
            }
        }
        gen_reqs(reqs[0]);
        top->clk=1;
        top->eval();
        req_set(top,reqs[0]);
        top->eval();
        if (!initcount) {
            cyc=cyc+1;
            if (!get_check(top,reqs[1])) {
                printf("error @%i\n",cyc);
                exit(1);
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
