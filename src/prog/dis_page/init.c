#define HEAP_BEGIN 0x400000ll
#define PAGE_NA 0x1ll
#define PROG_BEGIN 0x0ll
#define PROG_END 0x3fffffll
long long brk=HEAP_BEGIN;
unsigned long long *page_table;

unsigned short ehandl_bundles[2][16]={{
  0x04ff,0x5,
  0x24ff,0x6,
  0x4409,0x8020,
  0x3f18,
  0x1fb6,0xffff,0xffff,
  0x33b7,0xfffc,
  0x4409,0x8020,
  0x4818,
  0x6a6a},
  {
  0x18b6,0xffff,0xffff,
  0x4409,0x8020,
  0x3818,
  0x18b6,0xffff,0xffff,
  0x24ff,0x5,
  0x40ff,0x8,
  0,0,
  0x1534}
  }
};

void e_store_context(void);
void e_load_context(void);

void set_ehandler(int no, unsigned short *where, void (*handler)(int)) {
  int n;
  unsigned int addrdiff1,addrdiff2;
  for(n=0;n<16;n++) { 
      where[n]=ehandl_bundles[0][n];
      where[n+16]=ehandl_bundles[1][n];
      where[n+32]=0;
      where[n+48]=0;
  }
  addrdiff1=(unsigned int) store_context -(unsigned int) (where+10);
  addrdiff2=(unsigned int) handler-(unsigned int) (where+19);
  addrdiff3=(unsigned int) load_context-(unsigned int) (where+25);
  where[8]=addrdiff1&0xffff;
  where[9]=(addrdiff1&0xffff0000u)>>16;
  where[11]=((no&0x1fff)<<3)|0x8000;
  where[17]=addrdiff2&0xffff;
  where[18]=(addrdiff2&0xffff0000u)>>16;
  where[23]=addrdiff3&0xffff;
  where[24]=(addrdiff3&0xffff0000u)>>16;
}
void zero_page(long long addr) {
  long long *ptr=(long long *) addr;
  int n;
  for(n=0;n<64;n++) {
      ptr[n]=0ll;
  }
}

long long alloc_page(void) {
  long long old=brk;
  zero_page(brk);
  brk+=0x1000;
  return old;
}

void set_page(long long addr, long long entry) {
  unsigned long long *pt=page_table;
  long long addr2;
  if (pt[(addr&0xff1000000000)>>39]&PAGE_NA) {
      pt=pt[(addr&0xff1000000000)>>39]&0xfffffffff000;
  } else {
      addr2=alloc_page();
      pt[(addr&0xff1000000000)>>39]=(addr2&0xfffffffff000)|0x1;
      pt=(unsigned long long *) addr2; 
  }
  if (pt[(addr&0x7fc0000000)>>30]&PAGE_NA) {
      pt=pt[(addr&0x7fc0000000)>>30]&0xfffffffff000;
  } else {
      addr2=alloc_page();
      pt[(addr&0x7fc0000000)>>30]=(addr2&0xfffffffff000)|0x1;
      pt=(unsigned long long *) addr2; 
  }
  if (pt[(addr&0x3fe00000)>>21]&PAGE_NA) {
      pt=pt[(addr&0x3fe00000)>>21]&0xfffffffff000;
  } else {
      addr2=alloc_page();
      pt[(addr&0x3fe00000)>>21]=(addr2&0xfffffffff000)|0x1;
      pt=(unsigned long long *) addr2; 
  }
  pt[(addr&0x1ff000)>>12]=entry;
}


void prog_map(void) {
  long long int a=PROG_BEGIN;
  page_table=alloc_page();
  zero_page(page_table);
  for(a=a;a<PROG_END;a+=4096ll) {
      set_page(a,a|0x1);
  }
  
}

