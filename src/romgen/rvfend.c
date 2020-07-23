#include <stdio.h>

int ent[8];
int beef;

int get_entries(int addr) {
  int off=0;
  int n;
  beef=0;
  for(n=0;n<8;n++) {
    off+=addr&0x1 ? 1 : 2;
    ent[n]=off;
    if (!(addr&0x1)&&off==7) beef=1;
    addr=addr>>(addr&0x1 ? 1 : 2);
    if (off>7) ent[n]=0;
  }
}

int get_entries_beef(int addr) {
  int off=0;
  int n;
  beef=0;
  for(n=0;n<8;n++) {
    ent[n]=off+1;
    off+=addr&0x1 ? 1 : 2;
    if (!(addr&0x1)&&off==6) beef=1;
    addr=addr>>(addr&0x1 ? 1 : 2);
    if (off>6) ent[n]=0;
  }
}

unsigned long long get_value(void) {
  int n;
  unsigned long long ret=0;
  for(n=0;n<7;n++) {
      ret+=ent[n]<<(4*n);
  }
  if (beef) ret|=0x10000000ll;
  return ret;
}

int main(int argc, char *argv[]) {
  FILE *beef,*nobeef;
  int n;
  beef=fopen("predec_rom_beef.memh","w");
  nobeef=fopen("predec_rom_beef.memh","w");
  for(n=0;n<256;n++) {
      get_entries(n);
      fprintf(nobeef,"%llx\n",get_value());
  }
  for(n=0;n<128;n++) {
      get_entries(n);
      fprintf(beef,"%llx\n",get_value());
  }
  fclose(beef);
  fclose(nobeef);
  return 0;
}
