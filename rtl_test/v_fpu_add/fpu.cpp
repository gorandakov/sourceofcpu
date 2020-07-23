#include <cstdlib>
#include <cfenv>
#include "Vfun_fpu.h"
#include "verilated.h"


unsigned short OPS[]={1,2,3,5,6,7,9,10,11,12,13,  16,20,/*e*/
    32,33,34,/*cmp*/ 36,37,38,39, /*pcmp*/  40,41,42,43, /*logic*/
    0x201,0x102,0x203,0x103,0x303, 0x205,0x106,0x207,0x107,0x307,
    0x209,0x10a,0x20b,0x10b,0x30b, /*dbl*/  
    0x118,0x119,0x219,0x319,0x11a,0x11b,0x21b,0x31b, /*sng*/  
    0x120,0x221, /*cmp d*/     0x1f,0x11f,0x21f,0x31f, /*porm val*/
    0x41f,0x51f,0x61f,0x71f /*perm non val*/
  };  

class req {
    public:
    unsigned int op;
    unsigned long long A[2],B[2],res[2];
    unsigned char A_p[2],B_p[2],res_p[2],excpt;
    unsigned flags,flags_in;
    unsigned fset;
    unsigned alt,mul;
    int depA,depB,depS;
    unsigned en;
    void gen(bool alt_, bool mul_, req *prev1=NULL);
    int fuA() {
        return depA<0 ? depA+10 : 15;
    }
    int fuB() {
        return depB<0 ? depB+10 : 15;
    }
    int fuFl() {
        return depS<0 ? depS+10 : 15;
    }
    int fuuA() {
        return depA<0 ? 15 : depA;
    }
    int fuuB() {
        return depB<0 ? 15 : depB;
    }
    int fuuFl() {
        return depS<0 ? 15 : depS;
    }
};

void req::gen(bool alt_, bool mul_, req *prev1) {
    alt=alt_;
    mul=mul_;
    excpt=-1;
    if (!alt) op=OPS[rand()%(sizeof OPS/2)];
    if (alt) op=rand()&0x1ffff;
    depA=15;
    depB=15;
    depS=15;
    if ((rand()&0x3f) || (!prev1)) {
        A[0]=(rand()&0x1fffffull) | ((rand()&0x1fffffull)<<21) | 
          ((rand()&0x3fffffull)<<42);
        A_p[0]=rand()&0x1u;
        A[1]=(rand()&0x1fffffull) | ((rand()&0x1fffffull)<<21) | 
          ((rand()&0x3fffffull)<<42);
        A_p[1]=rand()&0x1u;
    } else {
        int which=rand()%20;
        depA=which-10;
        if ((which%10)==4 || (which%10)==5 || (which%10)==6) {
            which+=20;
        } else if ((which%10)==7 || (which%10)==8 || (which%10)==9) {
            which+=40;
        }
        A[0]=prev1[which].res[0];
        A_p[0]=prev1[which].res_p[0];
        A[1]=prev1[which].res[1];
        A_p[1]=prev1[which].res_p[1];
        if (!prev1[which].en || prev1[which].mul) depA=15;
    }
    if ((rand()&0x3f) || (!prev1)) {
        B[0]=(rand()&0x1fffffull) | ((rand()&0x1fffffull)<<21) | 
          ((rand()&0x3fffffull)<<42);
        B_p[0]=rand()&0x1u;
        B[1]=(rand()&0x1fffffull) | ((rand()&0x1fffffull)<<21) | 
          ((rand()&0x3fffffull)<<42);
        B_p[1]=rand()&0x1u;
    } else {
        int which=rand()%20;
        depB=which-10;
        if ((which%10)==4 || (which%10)==5 || (which%10)==6) {
            which+=20;
        } else if ((which%10)==7 || (which%10)==8 || (which%10)==9) {
            which+=40;
        }
        B[0]=prev1[which].res[0];
        B_p[0]=prev1[which].res_p[0];
        B[1]=prev1[which].res[1];
        B_p[1]=prev1[which].res_p[1];
        depB=which-10;
        if (!prev1[which].en || prev1[which].mul) depB=15;
    }
    if ((rand()&0x3f) || (!prev1)) {
       flags_in=rand()&0x3f;
       depS=15;
    } else {
        int which=rand()%12;
        which=which>=6 ? which-2 : which-6;
        flags_in=prev1[which+20].flags;
        depS=which;
        if (!prev1[which+20].fset || prev1[which+20].mul) depS=15;
    }
    res[1]=(rand()&0x1fffffull) | ((rand()&0x1fffffull)<<21) | 
      ((rand()&0x3fffffull)<<42);
    res_p[1]=rand()&0x1u;

    if (!alt) {
        switch(op&0xff) {
            case 1,5,9:
                res[0]=0;
                res_p[0]=0;
            break;
            case 2,3,6,7,10,11,  12,13, 33: {
                double Af=reinterpret_cast <double> (A[0]);
                double Bf=reinterpret_cast <double> (B[0]);
                if (op&0x100) Bf=reinterpret_cast <double> (B[1]);
                bool A_up=((A[0]&0x4000000000000000ul) && A_p[0]);
                bool A_dn=(!(A[0]&0x4000000000000000ul) && A_p[0]);
                bool B_up=((B[(op&0x100)!=0]&0x4000000000000000ul) && B_p[(op&0x100)!=0]);
                bool B_dn=(!(B[(op&0x100)!=0]&0x4000000000000000ul) && B_p[(op&0x100)!=0]);
                double resF;
                if (A_up || B_up) {
                    if (!A_up) Af=Af*2.0**-1024;
                    if (!B_up) Bf=Bf*2.0**-1024;
                    if (A_dn) Af=0.0;
                    if (B_dn) Bf=0.0;
                } else if (!A_dn || !B_dn) {
                    if (A_dn) Af=Af*2.0**-1024;
                    if (B_dn) Bf=Bf*2.0**-1024;
                }
                switch (op&0xff) {
                    case 2,3,  12,13: //
                        resF=(Af+Bf);
                        res[0]=reinterpret_cast <unsigned long>  (Af+Bf);
                    break;
                    case 6,7, 33:
                        resF=(Af-Bf);
                        res[0]=reinterpret_cast <unsigned long>  (Af-Bf);
                        if ((op&0xff)==33) {
                            en=0;
                            fset=1;
                            flags=((resF<0)<<5) | ((resF<0)<<2) | ((resF=0)<<1);
                            if (!(resF==resF)) {
                                flags=0x3;
                            }
                        }
                    break;
                    case 10,11:
                        resF=(-Af+Bf);
                        res[0]=reinterpret_cast <unsigned long>  (-Af+Bf);
                    break;
                }
                if (A_up || B_up) {
                    if (res[0]&0x4000000000000000ul) res_p[0]=1;
                    else {
                        res_p[0]=0;
                        res[0]=reinterpret_cast <unsigned long>  resF*2.0**1024;
                    }
                } else if (A_dn && B_dn) {
                    if (!(res[0]&0x4000000000000000ul)) res_p[0]=1;
                    else { 
                        res_p[0]=0;
                        res[0]=reinterpret_cast <unsigned long>  resF*2.0**-1024;
                    }
                }
            }
            break;
            case 32: {
                double Af=reinterpret_cast <double> (A[1]);
                double Bf=reinterpret_cast <double> (B[1]);
                if (op&0x200) Bf=reinterpret_cast <double> (B[0]);
                bool A_up=((A[1]&0x4000000000000000ul) && A_p[1]);
                bool A_dn=(!(A[1]&0x4000000000000000ul) && A_p[1]);
                bool B_up=((B[(op&0x200)==0]&0x4000000000000000ul) && B_p[(op&0x200)==0]);
                bool B_dn=(!(B[(op&0x200)==0]&0x4000000000000000ul) && B_p[(op&0x200)==0]);
                double resF;
                if (A_up || B_up) {
                    if (!A_up) Af=Af*2.0**-1024;
                    if (!B_up) Bf=Bf*2.0**-1024;
                    if (A_dn) Af=0.0;
                    if (B_dn) Bf=0.0;
                } else if (!A_dn || !B_dn) {
                    if (A_dn) Af=Af*2.0**-1024;
                    if (B_dn) Bf=Bf*2.0**-1024;
                }
                switch (op&0xff) {
                    case 32:
                        resF=(Af-Bf);
                        res[0]=reinterpret_cast <unsigned long>  (Af-Bf);
                        if ((op&0xff)==32) {
                            en=0;
                            fset=1;
                            flags=((resF<0)<<5) | ((resF<0)<<2) | ((resF=0)<<1);
                            if (!(resF==resF)) {
                                flags=0x3;
                            }
                        }
                    break;
                }
            }
            break;
            case 16,20,34: {
                long double Eptr=(long double *) &A[0];
                long double Af=*Eptr;
                Eptr=(long double *) &B[0];
                long double Bf=*Eptr;
                long double resF;
                bool A_up=((A[1]&0x4000ul) && A_p[0]);
                bool A_dn=(!(A[1]&0x4000ul) && A_p[0]);
                bool B_up=((B[1]&0x4000ul) && B_p[0]);
                bool B_dn=(!(B[1]&0x4000ul) && B_p[0]);
                if (A_up || B_up) {
                    if (!A_up) Af=Af*2.0**-32768;
                    if (!B_up) Bf=Bf*2.0**-32768;
                    if (A_dn) Af=0.0;
                    if (B_dn) Bf=0.0;
                } else if (!A_dn || !B_dn) {
                    if (A_dn) Af=Af*2.0**-32768;
                    if (B_dn) Bf=Bf*2.0**-32768;
                }
                switch (op&0xff) {
                    case 16:
                        resF=(Af+Bf);
                        Eptr=&res[0];
                        res[1]=0;
                        *Eptr=Af+Bf;
                    break;
                    case 20,34:
                        resF=(Af-Bf);
                        Eptr=&res[0];
                        res[1]=0;
                        *Eptr=Af-Bf;
                        if ((op&0xff)==34) {
                            en=0;
                            fset=1;
                            flags=((resF<0)<<5) | ((resF<0)<<2) | ((resF=0)<<1);
                            if (!(resF==resF)) {
                                flags=0x3;
                            }
                        }
                    break;
                }
                if (A_up || B_up) {
                    if (res[1]&0x4000ul) res_p[0]=1;
                    else {
                        res_p[0]=0;
                        *Eptr=resF*2.0**32768;
                    }
                } else if (A_dn && B_dn) {
                    if (!(res[1]&0x4000ul)) res_p[0]=1;
                    else { 
                        res_p[0]=0;
                        *Eptr=resF*2.0**-32768;
                    }
                }
            }
            break;
        }
    } else if (!alt) {
        switch(op&0xff) {
        }
    }
    en=rand()&0xff!=0;
}


int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);
    Vfun_fpu_add *top=new Vfun_fpu_add();
    Verilated::assertOn(false);
    int initcount=10;
    int cyc=0;
    req reqs[5][10];
 //   fesetround(FE_TOWARDZERO);
    top->clk=0;
    top->rst=1;
    top->except=0;
    gen_reqs(reqs[1],1);
    gen_reqs(reqs[2],1);
    gen_reqs(reqs[3],1);
    gen_reqs(reqs[4],1);
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
        for(k=4;k>=1;k=k-1) {
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
                printf(,"error @%i\n",cyc);
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

