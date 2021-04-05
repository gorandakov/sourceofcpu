#include <cstdio>
  
char is_used[32768]={0};
int p;
char stack[15];
int stack_top=0;
void useup(int top) {
  if (top!=0) {
      useup(top-1);
      p^=1<<stack[top];
      useup(top-1);
      p^=1<<stack[top];
  } else {
      is_used[p]=1;
      p^=1<<stack[top];
      is_used[p]=1;
      p^=1<<stack[top];
  }
}

int main(int argc, char *argv[]) {
  printf("module frrv_rom(\n");
  printf("  input [14:0] bits_in,\n");
  printf("  output [14:0] bits_out);\n");
  printf("  always @(bits_in) begin\n");
  printf("    casex(bits_in)\n");
  int n,m;
  char ch[16];
  char ch2[16];
  
  ch[15]=0;
  ch2[15]=0;

  for(n=0;n<32768;n++) {
      stack_top=0;
      for(m=0;m<15;m++) {
          if (n&(1<<m)) {
	      ch[m]='1';
	      ch2[m]='1';
	  } else {
	      ch[m]='0';
	      ch2[m]='0';
	      if (m<14) {
		  ch[++m]='1';
		  ch2[m]='x';
		  stack[stack_top++]=m;
	      }
	  }
      }
      p=n;
      if (!is_used[n]) {
	  printf("        15'b%s: bits_out=15'b%s;\n",ch2,ch);
      }
      if (stack_top) useup(stack_top-1);
  }
  printf("    endcase\n");
  printf("  end\n");
  printf("endmodule\n");
}
