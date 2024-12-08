
#define driven_phase_mask 0xff
#define driven_off_mask 0xffff0000
#define driven_off_shift 16
#define driven_count_mask 0xff00
#define driven_count_shift 8
#define pclk_combined 0x16
#define pclk_1 0x2
#define pclk_2 0x4
#define pclk_3 0x10
#define pclk_12 0xe
#define pclk_13 0x32
#define pclk_23 0x64
#define pclk_ppower 0xff

int global_anchor_x;
int global_anchor_y;
int global_bus_X_off;
int global_bus_Y_off;

class __acds_cell {
  int phase;
  int size;
  short anchor_x;
  short anchor_y;
  short x_off;
  short y_off;
  short x_mod;
  short y_mod;
  void *Owner;
  std::vector<void *> driven_obj;
  std::vector<long> driven_off_pos;
  unsigned short precharge_mask;
  unsigned short outp;
  unsigned char io[];
  public:
  void eval();
  void antiphase();
  void drive();
};
  void __acds_cell::eval() {
      long n,n2;
      for(n=size;n<(size*16);n++) {
          if ((n&15)<12) {
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
          } else {
            io[n]=io[n] & io[n-size];
            io[n-size]=io[n-size] & io[n];
          }
      }
      for(n=0;n<size;n++) if ((n&15)<12 && (precharge>>(n&15))&1) {
        io[n&15|12]|=io[n];
        io[n&15|13]|=io[n];
      }
  }
  void __acds_cell::antiphase() {
      long n,n2;
     for(n=size;n<(size*16);n++) {
          if ((n&15)<12) {
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
            io[n]=io[n] | io[n-size];
            io[n-size]=io[n-size] | io[n];
          } else {
            io[n]=io[n] & io[n-size];
            io[n-size]=io[n-size] & io[n];
          }
      }
      for(n=0;n<size;n++) if ((n&15)<12 && (precharge>>(n&15))&1) {
        io[n]&=io[n&15|12];
      } 
  }
  void __acds_cell::drive() {
    std::vector<void *>::iterator obj;
    std::vector<long>::iterator field;
    for(obj=driven_obj.iterator(),field=driven_off_pos.iterator(); 
      obj,field;obj++,field++) {
      long n,pos,cnt,off,othersz;
      pos=(field&driven_phase_mask);      
      off=(field&driven_off_mask)>>driven_off_shift;
      cnt=(field&driven_count_mask)>>driven_count_shift;
      othersz=((__acds_cell *) obj)->size;
      if (pos<12) for(n=0;n<cnt;n=n+1) {
        ((__acds_cell *) obj)->io[n*16+pos]|=
          io[n*16+outp+off];
      }
      if (pos<12) for(n=0;n<cnt;n=n+1) {
        ((__acds_cell *) obj)->io[n*16+pos]&=
          io[n*16+outp+off];
      }
    }
  }
template <long size,long precharge_mask> class acds_cell {
  int phase;
  int size;
  short anchor_x;
  short anchor_y;
  short x_off;
  short y_off;
  short x_mod;
  short y_mod;
  void *Owner;
  std::vector<void *> driven_obj;
  std::vector<long> driven_off_pos;
  unsigned short precharge_mask;
  unsigned char io[12][size];
  public:
  acds_cell<size> {
      anchor_x=global_anchor_x;
      anchor_y=global_anchor_y;
      x_off=global_bus_X_off;
      y_off=global_bus_Y_off;
      x_mod=16000;
      y_mod=16000;
  }
  acds_cell<size> (int x,int y) {
      anchor_x=global_anchor_x+x;
      anchor_y=global_anchor_y+y;
      x_off=global_bus_X_off;
      y_off=global_bus_Y_off;
      x_mod=16000;
      y_mod=16000;
  }
  int add_input(void * from, int off, int pos, int count) {
    __acds_cell *f=(__acds_cell *) from;
    if (off>f->size && off>0 || off<size && off<0) return 0;//error
    f->driven_obj.append((void *)this);
    f->driven_off_pos.append((pos&driven_pos_mask)|
       ((off<<driven_off_shift)&driven_off_mask)|
       ((count<<driven_count_shift)&driven_count_mask);
    int cntmax= off>0 ? f->size-off : size+off;
    if (cntmax<count) return 0;
    return count;
  }
  void eval() {
      __acds_cell *f=(__acds_cell *) this;
      f->eval();
      f->drive();
  }
};
