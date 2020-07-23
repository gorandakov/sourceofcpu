#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double zrand() {
  return pow(10.0,((double)rand()/RAND_MAX*4.0-2.0))*
    ((double)rand()/RAND_MAX*20.0-10.0);
}

int main(int argc, char*argv[]) {

  double arr[7][8];
  double sol[7];
  int a,b;
  srand(0xdeadbeef);
  for(a=0;a<8;a++)
    for(b=0;b<7;b++)
      arr[b][a]=zrand();
  if (argc==1) {
    for(a=0;a<7;a++) {
      for(b=0;b<8;b+=4) {
        union { double d;unsigned long long a;}rr[4];
        rr[0].d=arr[a][b+0];
        rr[1].d=arr[a][b+1];
        rr[2].d=arr[a][b+2];
        rr[3].d=arr[a][b+3];
        printf("%16llx_%16llx_%16llx_%16llx\n",rr[3].a,rr[2].a,rr[1].a,rr[0].a);
      }
    }
  } else {
    for(a=0;a<6;a++) {
      for(b=a+1;b<7;b++) {
        union { double d; unsigned long long a;} x;
	double f=arr[b][a]/arr[a][a];
	x.d=f;
	int c;
	for(c=0;c<8;c++) arr[b][c]-=arr[a][c]*f;
      }
    }
    for(a=6;a>=0;a=a-1) {
      sol[a]=arr[a][7]/arr[a][a];
      for(b=0;b<a;b++) {
        arr[b][7]-=sol[a]*arr[b][a];
      }
    }
    for(a=0;a<7;a++) {
      union { double d; unsigned long long a;} x;
      x.d=sol[a];
      if (argv[1][0]=='h') printf("%16llx\n",x.a);
      else printf("%lf\n",x.d);
    }
  }
}
