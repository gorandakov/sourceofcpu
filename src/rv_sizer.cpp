#include <cstdio>
#include <cstdlib>

unsigned int prune(unsigned short stops,bool xs[17]) {
    int k;
    unsigned int a;
    a=stops;
    for(k=0;k<16;k++) {
        if (stops&(1<<k)) {
            xs[k]=false;
        } else {
            a=a|(1<<(k+1));
            xs[k]=false;
            xs[k+1]=true;
            k++;
        }
    }
    return a;
}

unsigned int getcnt(unsigned int val) {
    int k,res=0;
    for(k=0;k<16;k++) res+=(val&(1<<k))!=0;
    return res;
}

unsigned int poke_used(bool vals[65536], bool xs[17],unsigned int val,int from) {
    if (from>15) return val;
    if (xs[from]) {
        vals[val^(1<<from)]=true;
        poke_used(vals,xs,val^(1<<from),from+1);
    }
    poke_used(vals,xs,val,from+1);
    return 0;
}

size_t get_expr(int start,char buf[]) {
    char *pos=buf;
    bool vals[65536]={false};
    unsigned int valu,val;
    pos+=sprintf(pos,"  function [16:0] cnt%i;\n    input [15:0] bits;\n    casex(bits)\n",start);
    for(valu=0;valu<65536;valu++) {
        val=valu|(0xffff>>(16-start));
        bool xs[17]={false};
        unsigned int p=prune(val,xs);
        poke_used(vals,xs,val,0);
        if (!vals[val]) {
            pos+=sprintf(pos,"        16'b");
            int kl;
            for(kl=0;kl<16;kl++) {
                if (xs[kl]) *(pos++)='x';
                else *(pos++)='0'+((val&(1<<kl))!=0);
            }
            unsigned int cnt=(1<<(getcnt(p)-start));
            pos+=sprintf(pos," : cnt%i=17'h%x;\n",start,cnt);
        }
    }
    pos+=sprintf(pos,"    endcase\n\n  endfunction\n");
    *(pos++)=0;
    return pos-buf;
}

size_t get_expri2(int start,char buf[]) {
    char *pos=buf;
    bool vals[65536]={false};
    unsigned int valu,val;
    pos+=sprintf(pos,"  function [0:0] tail%i;\n    input [15:0] bits;\n    casex(bits)\n",start);
    for(valu=0;valu<65536;valu++) {
        val=valu|(0xffff>>(16-start));
        bool xs[17]={false};
        unsigned int p=prune(val,xs);
        poke_used(vals,xs,val,0);
        if (!vals[val]) {
            pos+=sprintf(pos,"        16'b");
            int kl;
            for(kl=0;kl<16;kl++) {
                if (xs[kl]) *(pos++)='x';
                else *(pos++)='0'+((val&(1<<kl))!=0);
            }
            unsigned int cnt=!(p>>15);
            pos+=sprintf(pos," : tail%i=1'b%x;\n",start,cnt);
        }
    }
    pos+=sprintf(pos,"    endcase\n\n  endfunction\n");
    *(pos++)=0;
    return pos-buf;
}


int main(int argc,char *argv[]) {
    FILE *f=fopen("rom.sv","w");
    char *buf=(char *)malloc(8*1024*1024);
    int start;
    for(start=0;start<1;start++) {
        get_expr(start,buf);
        fprintf(f,"%s",buf);
        get_expri2(start,buf);
        fprintf(f,"%s",buf);
    }
    fclose(f);
    free(buf);
    return 0;
}
