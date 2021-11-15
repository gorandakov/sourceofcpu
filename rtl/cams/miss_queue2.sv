`include "../common.v"


//read-during-write behaviour: write first
module missQ_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=2+2*`mOp1_width;
  localparam ADDR_WIDTH=4;
  localparam ADDR_COUNT=16;

  input clk;
  input rst;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  
  assign read_data=ram[read_addr_reg];

  always @(posedge clk)
    begin
      if (rst) read_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule

//read-during-write behaviour: write first
module missQ_data_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=3*128+4;
  localparam ADDR_WIDTH=4;
  localparam ADDR_COUNT=16;

  input clk;
  input rst;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  
  assign read_data=ram[read_addr_reg];

  always @(posedge clk)
    begin
      if (rst) read_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule




module missQ(
  clk,
  rst,
  except,
  excpt_thread,
  read_clkEn,
  last_inserted,
  doSkip,
  do_bus_hold,
  do_unlock,
  miss0,
  mOp0_en,
  mOp0_thread,
  mOp0_addrEven,
  mOp0_addrOdd,
  mOp0_sz,
  mOp0_st,
  mOp0_banks,
  mOp0_bank0,
  mOp0_odd,
  mOp0_addr_low,
  mOp0_split,
  mOp0_register,
  mOp0_clHit,
  mOp0_LSQ,
  mOp0_II,
  mOp0_WQ,
  mOp0_lsflag,
  mOp0_en_o,
  mOp0_thread_o,
  mOp0_addrEven_o,
  mOp0_addrOdd_o,
  mOp0_sz_o,
  mOp0_st_o,
  mOp0_banks_o,
  mOp0_bank0_o,
  mOp0_odd_o,
  mOp0_addr_low_o,
  mOp0_split_o,
  mOp0_register_o,
  mOp0_LSQ_o,
  mOp0_II_o,
  mOp0_WQ_o,
  mOp0_lsflag_o,
  miss1,
  mOp1_en,
  mOp1_thread,
  mOp1_addrEven,
  mOp1_addrOdd,
  mOp1_sz,
  mOp1_st,
  mOp1_banks,
  mOp1_bank0,
  mOp1_odd,
  mOp1_addr_low,
  mOp1_split,
  mOp1_register,
  mOp1_clHit,
  mOp1_LSQ,
  mOp1_II,
  mOp1_WQ,
  mOp1_lsflag,
  mOp1_en_o,
  mOp1_thread_o,
  mOp1_addrEven_o,
  mOp1_addrOdd_o,
  mOp1_sz_o,
  mOp1_st_o,
  mOp1_banks_o,
  mOp1_bank0_o,
  mOp1_odd_o,
  mOp1_addr_low_o,
  mOp1_split_o,
  mOp1_register_o,
  mOp1_LSQ_o,
  mOp1_II_o,
  mOp1_WQ_o,
  mOp1_lsflag_o,
  miss2,
  mOp2_en,
  mOp2_thread,
  mOp2_addrEven,
  mOp2_addrOdd,
  mOp2_sz,
  mOp2_st,
  mOp2_banks,
  mOp2_bank0,
  mOp2_odd,
  mOp2_addr_low,
  mOp2_split,
  mOp2_register,
  mOp2_clHit,
  mOp2_LSQ,
  mOp2_II,
  mOp2_WQ,
  mOp2_en_no,
  mOp2_thread_no,
  mOp2_addrEven_no,
  mOp2_addrOdd_no,
  mOp2_sz_no,
  mOp2_st_no,
  mOp2_banks_no,
  mOp2_bank0_no,
  mOp2_odd_no,
  mOp2_addr_low_no,
  mOp2_split_no,
  mOp2_register_no,
  mOp2_LSQ_no,
  mOp2_II_no,
  mOp2_WQ_no,
  mOp2_lsflag_no,
  miss3,
  mOp3_en,
  mOp3_thread,
  mOp3_addrEven,
  mOp3_addrOdd,
  mOp3_sz,
  mOp3_st,
  mOp3_banks,
  mOp3_bank0,
  mOp3_odd,
  mOp3_addr_low,
  mOp3_split,
  mOp3_register,
  mOp3_clHit,
  mOp3_LSQ,
  mOp3_II,
  mOp3_WQ,
  mOp3_lsflag,
  mOp3_lsfwd,
  mOp3_data,
  mOp3_brdbanks,
  mOp3_en_no,
  mOp3_thread_no,
  mOp3_addrEven_no,
  mOp3_addrOdd_no,
  mOp3_sz_no,
  mOp3_st_no,
  mOp3_banks_no,
  mOp3_bank0_no,
  mOp3_odd_no,
  mOp3_addr_low_no,
  mOp3_split_no,
  mOp3_register_no,
  mOp3_LSQ_no,
  mOp3_II_no,
  mOp3_WQ_no,
  mOp3_lsflag_no,
  mOp3_lsfwd_no,
  mOp3_data_no,
  mOp3_brdbanks_no,
  miss4,
  mOp4_en,
  mOp4_dupl,//write to a non-exclusive cl
  //mOp4_thread,
  mOp4_addrEven,
  mOp4_addrOdd,
  mOp4_sz,
  mOp4_first,
  mOp4_banks,
  mOp4_bank0,
  mOp4_bank1,
  mOp4_bgn_b,
  mOp4_end_b,
  mOp4_odd,
  mOp4_addr_low,
  mOp4_split,
  mOp4_clHit,
  mOp4_data,
  mOp4_II,
  mOp4_en_no,
  mOp4_dupl_no,//write to a non-exclusive cl
  //mOp4_thread,
  mOp4_addrEven_no,
  mOp4_addrOdd_no,
  mOp4_sz_no,
  mOp4_first_no,
  mOp4_banks_no,
  mOp4_bank0_no,
  mOp4_bank1_no,
  mOp4_bgn_b_no,
  mOp4_end_b_no,
  mOp4_odd_no,
  mOp4_addr_low_no,
  mOp4_split_no,
  mOp4_data_no,
  mOp4_II_no,
  miss5,
  mOp5_en,
  mOp5_dupl,
 // mOp5_thread,
  mOp5_addrEven,
  mOp5_addrOdd,
  mOp5_sz,
  mOp5_first,
  mOp5_banks,
  mOp5_bank0,
  mOp5_bank1,
  mOp5_bgn_b,
  mOp5_end_b,
  mOp5_odd,
  mOp5_addr_low,
  mOp5_split,
  mOp5_clHit,
  mOp5_data,
  mOp5_II,
  mOp5_en_no,
  mOp5_dupl_no,
 // mOp5_thread,
  mOp5_addrEven_no,
  mOp5_addrOdd_no,
  mOp5_sz_no,
  mOp5_first_no,
  mOp5_banks_no,
  mOp5_bank0_no,
  mOp5_bank1_no,
  mOp5_bgn_b_no,
  mOp5_end_b_no,
  mOp5_odd_no,
  mOp5_addr_low_no,
  mOp5_split_no,
  mOp5_data_no,
  mOp5_II_no,

  mOp_noBanks,
  mOp_write_clear,
  mOpR_en,
  mOpR_addrEven,
  mOpR_addrOdd,
  mOpR_sz,
  mOpR_st,
  mOpR_first,
  mOpR_banks,
  mOpR_bank0,
  mOpR_odd,
  mOpR_addr_low,
  mOpR_split,
  mOpR_clHit,
  mOpR_dupl
  );

  localparam DEPTH=16;
  localparam ADDR_WIDTH=4;
  localparam DATA_WIDTH=2+2*`mOp1_width;
  localparam MOP_WIDTH=`mOp1_width;
  localparam STALL_COUNT=10;
  localparam VADDR_WIDTH=64;
  localparam PADDR_WIDTH=44;
  localparam OPERATION_WIDTH=`operation_width;
  localparam TLB_DWIDTH=`dtlbData_width;
  localparam INDEX_WIDTH=7;
  localparam BANK_COUNT=32;
  localparam REG_WIDTH=9;
  localparam DDATA_WIDTH=3*128+4;
 
  input clk;
  input rst;
  input except;
  input excpt_thread;
  input read_clkEn;
  input last_inserted;
  output reg doSkip;
  output do_bus_hold;
  output reg do_unlock;

  input miss0;
  input mOp0_en;
  input mOp0_thread;
  input [PADDR_WIDTH-1:8] mOp0_addrEven;
  input [PADDR_WIDTH-1:8] mOp0_addrOdd;
  input [4:0] mOp0_sz;
  input mOp0_st;
  input [BANK_COUNT-1:0] mOp0_banks;
  input [4:0] mOp0_bank0;
  input mOp0_odd;
  input [1:0] mOp0_addr_low;
  input mOp0_split;
  input [REG_WIDTH-1:0] mOp0_register;
  input [1:0] mOp0_clHit;
  input [8:0] mOp0_LSQ;
  input [9:0] mOp0_II;
  input [7:0] mOp0_WQ;
  input mOp0_lsflag;
  output mOp0_en_o;
  output mOp0_thread_o;
  output [PADDR_WIDTH-1:8] mOp0_addrEven_o;
  output [PADDR_WIDTH-1:8] mOp0_addrOdd_o;
  output [4:0] mOp0_sz_o;
  output mOp0_st_o;
  output [BANK_COUNT-1:0] mOp0_banks_o;
  output [4:0] mOp0_bank0_o;
  output mOp0_odd_o;
  output [1:0] mOp0_addr_low_o;
  output mOp0_split_o;
  output [REG_WIDTH-1:0] mOp0_register_o;
  output [8:0] mOp0_LSQ_o;
  output [9:0] mOp0_II_o;
  output [7:0] mOp0_WQ_o;
  output mOp0_lsflag_o;


  input miss1;
  input mOp1_en;
  input mOp1_thread;
  input [PADDR_WIDTH-1:8] mOp1_addrEven;
  input [PADDR_WIDTH-1:8] mOp1_addrOdd;
  input [4:0] mOp1_sz;
  input mOp1_st;
  input [BANK_COUNT-1:0] mOp1_banks;
  input [4:0] mOp1_bank0;
  input mOp1_odd;
  input [1:0] mOp1_addr_low;
  input mOp1_split;
  input [REG_WIDTH-1:0] mOp1_register;
  input [1:0] mOp1_clHit;
  input [8:0] mOp1_LSQ;
  input [9:0] mOp1_II;
  input [7:0] mOp1_WQ;
  input mOp1_lsflag;
  output mOp1_en_o;
  output mOp1_thread_o;
  output [PADDR_WIDTH-1:8] mOp1_addrEven_o;
  output [PADDR_WIDTH-1:8] mOp1_addrOdd_o;
  output [4:0] mOp1_sz_o;
  output mOp1_st_o;
  output [BANK_COUNT-1:0] mOp1_banks_o;
  output [4:0] mOp1_bank0_o;
  output mOp1_odd_o;
  output [1:0] mOp1_addr_low_o;
  output mOp1_split_o;
  output [REG_WIDTH-1:0] mOp1_register_o;
  output [8:0] mOp1_LSQ_o;
  output [9:0] mOp1_II_o;
  output [7:0] mOp1_WQ_o;
  output mOp1_lsflag_o;


  input miss2;
  input mOp2_en;
  input mOp2_thread;
  input [PADDR_WIDTH-1:8] mOp2_addrEven;
  input [PADDR_WIDTH-1:8] mOp2_addrOdd;
  input [4:0] mOp2_sz;
  input mOp2_st;
  input [BANK_COUNT-1:0] mOp2_banks;
  input [4:0] mOp2_bank0;
  input mOp2_odd;
  input [1:0] mOp2_addr_low;
  input mOp2_split;
  input [REG_WIDTH-1:0] mOp2_register;
  input [1:0] mOp2_clHit;
  input [8:0] mOp2_LSQ;
  input [9:0] mOp2_II;
  input [7:0] mOp2_WQ;
  input mOp2_lsflag;
  output mOp2_en_no;
  output mOp2_thread_no;
  output [PADDR_WIDTH-1:8] mOp2_addrEven_no;
  output [PADDR_WIDTH-1:8] mOp2_addrOdd_no;
  output [4:0] mOp2_sz_no;
  output mOp2_st_no;
  output [BANK_COUNT-1:0] mOp2_banks_no;
  output [4:0] mOp2_bank0_no;
  output mOp2_odd_no;
  output [1:0] mOp2_addr_low_no;
  output mOp2_split_no;
  output [REG_WIDTH-1:0] mOp2_register_no;
  output [8:0] mOp2_LSQ_no;
  output [9:0] mOp2_II_no;
  output [7:0] mOp2_WQ_no;
  output mOp2_lsflag_no;


  input miss3;
  input mOp3_en;
  input mOp3_thread;
  input [PADDR_WIDTH-1:8] mOp3_addrEven;
  input [PADDR_WIDTH-1:8] mOp3_addrOdd;
  input [4:0] mOp3_sz;
  input mOp3_st;
  input [BANK_COUNT-1:0] mOp3_banks;
  input [4:0] mOp3_bank0;
  input mOp3_odd;
  input [1:0] mOp3_addr_low;
  input mOp3_split;
  input [REG_WIDTH-1:0] mOp3_register;
  input [1:0] mOp3_clHit;
  input [8:0] mOp3_LSQ;
  input [9:0] mOp3_II;
  input [7:0] mOp3_WQ;
  input mOp3_lsflag;
  input mOp3_lsfwd;
  input [127:0] mOp3_data;
  input [3:0] mOp3_brdbanks;
  output mOp3_en_no;
  output mOp3_thread_no;
  output [PADDR_WIDTH-1:8] mOp3_addrEven_no;
  output [PADDR_WIDTH-1:8] mOp3_addrOdd_no;
  output [4:0] mOp3_sz_no;
  output mOp3_st_no;
  output [BANK_COUNT-1:0] mOp3_banks_no;
  output [4:0] mOp3_bank0_no;
  output mOp3_odd_no;
  output [1:0] mOp3_addr_low_no;
  output mOp3_split_no;
  output [REG_WIDTH-1:0] mOp3_register_no;
  output [8:0] mOp3_LSQ_no;
  output [9:0] mOp3_II_no;
  output [7:0] mOp3_WQ_no;
  output mOp3_lsflag_no;
  output mOp3_lsfwd_no;
  output [127:0] mOp3_data_no;
  output [3:0] mOp3_brdbanks_no;

  input miss4;
  input mOp4_en;
  input [1:0] mOp4_dupl;
 // inout mOp4_thread;
  input [PADDR_WIDTH-1:8] mOp4_addrEven;
  input [PADDR_WIDTH-1:8] mOp4_addrOdd;
  input [4:0] mOp4_sz;
  input mOp4_first;
//output [BANK_COUNT-1:0] mOp4_banks;
  input [4:0] mOp4_bank0;
  input [4:0] mOp4_bank1;
//output [3:0] mOp4_bgn_b;
//output [3:0] mOp4_end_b;
  input mOp4_odd;
  input [1:0] mOp4_addr_low;
  input mOp4_split;
  input [1:0] mOp4_clHit;
  input [159:0] mOp4_data;
  input [9:0] mOp4_II;
  output mOp4_en_no;
  output [1:0] mOp4_dupl_no;
 // inout mOp4_thread;
  output [PADDR_WIDTH-1:8] mOp4_addrEven_no;
  output [PADDR_WIDTH-1:8] mOp4_addrOdd_no;
  output [4:0] mOp4_sz_no;
  output mOp4_first_no;
  output [BANK_COUNT-1:0] mOp4_banks;
  output [4:0] mOp4_bank0_no;
  output [4:0] mOp4_bank1_no;
  output [3:0] mOp4_bgn_b;
  output [3:0] mOp4_end_b;
  output mOp4_odd_no;
  output [1:0] mOp4_addr_low_no;
  output mOp4_split_no;
  output [1:0] mOp4_clHit_no;
  output [159:0] mOp4_data_no;
  output [9:0] mOp4_II_no;

  input miss5;
  input mOp5_en;
  input [1:0] mOp5_dupl;
//  inout mOp5_thread;
  input [PADDR_WIDTH-1:8] mOp5_addrEven;
  input [PADDR_WIDTH-1:8] mOp5_addrOdd;
  input [4:0] mOp5_sz;
  input mOp5_first;
//output [BANK_COUNT-1:0] mOp5_banks;
  input [4:0] mOp5_bank0;
  input [4:0] mOp5_bank1;
//output [3:0] mOp5_bgn_b;
//output [3:0] mOp5_end_b;
  input mOp5_odd;
  input [1:0] mOp5_addr_low;
  input mOp5_split;
  input [1:0] mOp5_clHit;
  input [159:0] mOp5_data;
  input [9:0] mOp5_II;
  output mOp5_en_no;
  output [1:0] mOp5_dupl_no;
//  inout mOp5_thread;
  output [PADDR_WIDTH-1:8] mOp5_addrEven_no;
  output [PADDR_WIDTH-1:8] mOp5_addrOdd_no;
  output [4:0] mOp5_sz_no;
  output mOp5_first_no;
  output [BANK_COUNT-1:0] mOp5_banks;
  output [4:0] mOp5_bank0_no;
  output [4:0] mOp5_bank1_no;
  output [3:0] mOp5_bgn_b;
  output [3:0] mOp5_end_b;
  output mOp5_odd_no;
  output [1:0] mOp5_addr_low_no;
  output mOp5_split_no;
  output [1:0] mOp5_clHit_no;
  output [159:0] mOp5_data_no;
  output [9:0] mOp5_II_no;
  
  output [31:0] mOp_noBanks;
  output mOp_write_clear;

  output mOpR_en;
  output [PADDR_WIDTH-1:8] mOpR_addrEven;
  output [PADDR_WIDTH-1:8] mOpR_addrOdd;
  output [4:0] mOpR_sz;
  output mOpR_st;
  output mOpR_first;
  output [BANK_COUNT-1:0] mOpR_banks;
  output [4:0] mOpR_bank0;
  output mOpR_odd;
  output [1:0] mOpR_addr_low;
  output mOpR_split;
  output [1:0] mOpR_clHit;
  output [1:0] mOpR_dupl;
  wire [5:0] curConfl;
//  wire [5:0] write_confl;
  wire [5:0] read_confl;
  wire [5:0] sel;  
  wire conflFound;
  wire doStep;
  
  reg [ADDR_WIDTH-1:0] read_addr;
  wire [ADDR_WIDTH-1:0] read_addr_d;
 // reg [ADDR_WIDTH-1:0] read_addr_old;
  reg [ADDR_WIDTH-1:0] read_addr_begin;
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  reg [ADDR_WIDTH-1:0] write_addr_end;
  reg [ADDR_WIDTH-1:0] write_addr_end2;
 // wire [ADDR_WIDTH-1:0] write_addr_end_d;
  reg [ADDR_WIDTH-1:0] write_addr;
  wire [ADDR_WIDTH-1:0] write_addr_d;
  reg [ADDR_WIDTH:0] count;
  wire [ADDR_WIDTH:0] count_d;
  reg [ADDR_WIDTH:0] countF;
  wire [ADDR_WIDTH:0] countF_d;
  wire wen;
  wire [3:0] write_addr_dec;
  
  wire [MOP_WIDTH-1:0] write_mop[5:0];
  wire [DATA_WIDTH-1:0] write_dataA;
  wire [DATA_WIDTH-1:0] write_dataB;
  wire [DATA_WIDTH-1:0] write_dataC;
  wire [MOP_WIDTH-1:0] read_mop[5:0];
  wire [DATA_WIDTH-1:0] read_dataA;
  wire [DATA_WIDTH-1:0] read_dataB;
  wire [DATA_WIDTH-1:0] read_dataC;
  wire [DDATA_WIDTH-1:0] read_ddata;
  wire [DDATA_WIDTH-1:0] write_ddata;
  
  
  reg [5:0] confl_mask;

  reg mOp0_thread_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp0_addrEven_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp0_addrOdd_reg[3:1];
  reg [4:0] mOp0_sz_reg[3:1];
  reg mOp0_st_reg[3:1];
  reg [BANK_COUNT-1:0] mOp0_banks_reg[3:1];
  reg [4:0] mOp0_bank0_reg[3:1];
  reg [4:0] mOp0_bank1_reg[3:1];
  reg mOp0_odd_reg[3:1];
  reg [1:0] mOp0_addr_low_reg[3:1];
  reg mOp0_split_reg[3:1];
  reg [REG_WIDTH-1:0] mOp0_register_reg[3:1];
  reg [8:0] mOp0_LSQ_reg[3:1];
  reg [9:0] mOp0_II_reg[3:1];
  reg [7:0] mOp0_WQ_reg[3:1];
  reg mOp0_lsflag_reg[3:1];

  reg mOp1_thread_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp1_addrEven_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp1_addrOdd_reg[3:1];
  reg [4:0] mOp1_sz_reg[3:1];
  reg mOp1_st_reg[3:1];
  reg [BANK_COUNT-1:0] mOp1_banks_reg[3:1];
  reg [4:0] mOp1_bank0_reg[3:1];
  reg [4:0] mOp1_bank1_reg[3:1];
  reg mOp1_odd_reg[3:1];
  reg [1:0] mOp1_addr_low_reg[3:1];
  reg mOp1_split_reg[3:1];
  reg [REG_WIDTH-1:0] mOp1_register_reg[3:1];
  reg [8:0] mOp1_LSQ_reg[3:1];
  reg [9:0] mOp1_II_reg[3:1];
  reg [7:0] mOp1_WQ_reg[3:1];
  reg mOp1_lsflag_reg[3:1];

  reg mOp2_thread_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp2_addrEven_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp2_addrOdd_reg[3:1];
  reg [4:0] mOp2_sz_reg[3:1];
  reg mOp2_st_reg[3:1];
  reg [BANK_COUNT-1:0] mOp2_banks_reg[3:1];
  reg [4:0] mOp2_bank0_reg[3:1];
  reg [4:0] mOp2_bank1_reg[3:1];
  reg mOp2_odd_reg[3:1];
  reg [1:0] mOp2_addr_low_reg[3:1];
  reg mOp2_split_reg[3:1];
  reg [REG_WIDTH-1:0] mOp2_register_reg[3:1];
  reg [8:0] mOp2_LSQ_reg[3:1];
  reg [9:0] mOp2_II_reg[3:1];
  reg [7:0] mOp2_WQ_reg[3:1];
  reg mOp2_lsflag_reg[3:1];

  reg mOp3_thread_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp3_addrEven_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp3_addrOdd_reg[3:1];
  reg [4:0] mOp3_sz_reg[3:1];
  reg mOp3_st_reg[3:1];
  reg [BANK_COUNT-1:0] mOp3_banks_reg[3:1];
  reg [4:0] mOp3_bank0_reg[3:1];
  reg [4:0] mOp3_bank1_reg[3:1];
  reg mOp3_odd_reg[3:1];
  reg [1:0] mOp3_addr_low_reg[3:1];
  reg mOp3_split_reg[3:1];
  reg [REG_WIDTH-1:0] mOp3_register_reg[3:1];
  reg [8:0] mOp3_LSQ_reg[3:1];
  reg [9:0] mOp3_II_reg[3:1];
  reg [7:0] mOp3_WQ_reg[3:1];
  reg mOp3_lsflag_reg[3:1];
  reg mOp3_lsfwd_reg[3:1];
  reg [127:0] mOp3_data_reg[3:1];
  reg [3:0] mOp3_brdbanks_reg[3:1];

//  reg mOp4_thread_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp4_addrEven_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp4_addrOdd_reg[3:1];
  reg [4:0] mOp4_sz_reg[3:1];
  reg mOp4_first_reg[3:1];
  reg [4:0] mOp4_bank0_reg[3:1];
  reg [4:0] mOp4_bank1_reg[3:1];
  reg mOp4_odd_reg[3:1];
  reg [1:0] mOp4_addr_low_reg[3:1];
  reg mOp4_split_reg[3:1];
  reg [159:0] mOp4_data_reg[3:1];
  reg [9:0] mOp4_II_reg[3:1];
  reg [3:0] mOp4_bgn_b_reg[3:1];
  reg [3:0] mOp4_end_b_reg[3:1];

//  reg mOp5_thread_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp5_addrEven_reg[3:1];
  reg [PADDR_WIDTH-1:8] mOp5_addrOdd_reg[3:1];
  reg [4:0] mOp5_sz_reg[3:1];
  reg mOp5_first_reg[3:1];
  reg [4:0] mOp5_bank0_reg[3:1];
  reg [4:0] mOp5_bank1_reg[3:1];
  reg mOp5_odd_reg[3:1];
  reg [1:0] mOp5_addr_low_reg[3:1];
  reg mOp5_split_reg[3:1];
  reg [159:0] mOp5_data_reg[3:1];
  reg [9:0] mOp5_II_reg[3:1];
  reg [3:0] mOp5_bgn_b_reg[3:1];
  reg [3:0] mOp5_end_b_reg[3:1];

  reg [31:0] bank4;
  reg [31:0] bank5;
  reg [2:0] sz4;
  reg [2:0] sz5;
  
  reg begin_flush;
  reg now_flushing;
  wire flush_end;
  reg begin_flush_reg;
  reg now_flushing_reg;
  reg begin_flush_reg2;
  reg now_flushing_reg2;
  reg sticky_begin;

  reg last_inserted_reg;
  reg last_inserted_reg2;
  reg last_inserted_reg3;
  reg last_inserted_reg4;
  
  wire [31:0] rdbanks[3:0];
  
  reg locked;
  
 // reg now_flooshing;
  
  wire rdwr_match,rdwr_match2;

  wire doSkip_d;
 
  reg stepOver4,stepOver42;
  reg stepOver5,stepOver52;
 
  genvar k;
  integer r,q;
  
  reg init;
  reg [3:0] initCount;
  wire [3:0] initCount_next;
  
  reg [3:0] thrblk_addr0;
  reg thrblk_en0;
  reg [3:0] thrblk_addr1;
  reg thrblk_en1; 
  wire [5:0] read_thread; 
  wire [5:0] thrinhibitconfl;
  reg [5:0] thrreginh[3:1];
  
  wire [4:0] dummy5;

  assign write_dataA={miss1&~thrreginh[3][1],miss0&~thrreginh[3][0],write_mop[1],write_mop[0]}&{DATA_WIDTH{~init}};
  assign write_dataB={miss3&~thrreginh[3][3],miss2&~thrreginh[3][2],write_mop[3],write_mop[2]}&{DATA_WIDTH{~init}};
  assign write_dataC={miss5&~thrreginh[3][5],miss4&~thrreginh[3][4],write_mop[5],write_mop[4]}&{DATA_WIDTH{~init}};
  assign write_ddata={mOp5_data_reg[3][159:32],mOp4_data_reg[3][159:32],mOp3_data_reg[3],mOp3_brdbanks_reg[3]}
    &{DDATA_WIDTH{~init}};
  
  assign wen=miss0&~thrreginh[3][0]||miss1&~thrreginh[3][1]||miss2&~thrreginh[3][2]||
      miss3&~thrreginh[3][3]||miss4&~thrreginh[3][4]||miss5&~thrreginh[3][5];
  assign read_addr_d=~doStep & ~begin_flush_reg2 & ~rst ? read_addr : 4'bz; 
  assign read_addr_d=begin_flush_reg2 &~rst ? read_addr_begin : 4'bz;
  assign write_addr_d=~wen & ~rst ? write_addr : 4'bz; 
  assign count_d=~wen & ~now_flushing &~rst ? count : 5'bz;
  assign count_d=wen & now_flushing &~rst ? count : 5'bz;
  
  assign read_addr_d=rst ? 4'b0:4'bz;
  assign write_addr_d=rst ? 4'b0:4'bz;
  assign count_d=rst ? 5'b0 : 5'bz;
  
  
  assign {read_confl[1:0],read_mop[1],read_mop[0]}=read_dataA;
  assign {read_confl[3:2],read_mop[3],read_mop[2]}=read_dataB;
  assign {read_confl[5:4],read_mop[5],read_mop[4]}=read_dataC;

  assign do_bus_hold=now_flushing;
  
  assign mOp_noBanks=now_flushing_reg2 ? 
    ~(rdbanks[0]|rdbanks[1]|rdbanks[2]|rdbanks[3]) : 32'bz;
 
  assign read_thread={2'b0,read_mop[3][`mOp1_thr],read_mop[2][`mOp1_thr],read_mop[1][`mOp1_thr],read_mop[0][`mOp1_thr]};

  assign thrinhibitconfl=(read_thread & {4{thrblk_en1}}) | (~read_thread & {4{thrblk_en0}}); 

  assign mOp0_thread=now_flushing_reg2 ?   read_mop[0][`mOp1_thr] : 1'bz;
  assign mOp0_addrEven=now_flushing_reg2 ? read_mop[0][`mOp1_addrEven] : 36'bz;
  assign mOp0_addrOdd=now_flushing_reg2 ?  read_mop[0][`mOp1_addrOdd] : 36'bz;
  assign mOp0_sz=now_flushing_reg2 ?       read_mop[0][`mOp1_sz] : 5'bz;
  assign mOp0_st=now_flushing_reg2 ?       read_mop[0][`mOp1_st] : 1'bz;
  assign mOp0_split=now_flushing_reg2 ?    read_mop[0][`mOp1_split] : 1'bz;
  assign mOp0_addr_low=now_flushing_reg2 ? read_mop[0][`mOp1_low] : 2'bz;
  assign mOp0_odd=now_flushing_reg2 ?      read_mop[0][`mOp1_odd] : 1'bz;
  assign mOp0_banks=now_flushing_reg2 ?    read_mop[0][`mOp1_banks] : 32'bz;
  assign mOp0_bank0=now_flushing_reg2 ?    read_mop[0][`mOp1_bank0] : 5'bz;
  assign mOp0_register=now_flushing_reg2 ? read_mop[0][`mOp1_regNo] : 9'bz;
  assign mOp0_en=now_flushing_reg2 ?       read_confl[0]&~thrinhibitconfl[0] : 1'bz;
  assign mOp0_LSQ=now_flushing_reg2 ?      read_mop[0][`mOp1_LSQ] : 9'bz;
  assign mOp0_II=now_flushing_reg2 ?       read_mop[0][`mOp1_II] : 10'bz;
  assign mOp0_WQ=now_flushing_reg2 ?       read_mop[0][`mOp1_WQ] : 8'bz;
  assign mOp0_lsflag=now_flushing_reg2 ?   read_mop[0][`mOp1_lsf] : 1'bz;
  
  assign mOp1_thread=now_flushing_reg2 ?   read_mop[1][`mOp1_thr] : 1'bz;
  assign mOp1_addrEven=now_flushing_reg2 ? read_mop[1][`mOp1_addrEven] : 36'bz;
  assign mOp1_addrOdd=now_flushing_reg2 ?  read_mop[1][`mOp1_addrOdd] : 36'bz;
  assign mOp1_sz=now_flushing_reg2 ?       read_mop[1][`mOp1_sz] : 5'bz;
  assign mOp1_st=now_flushing_reg2 ?       read_mop[1][`mOp1_st] : 1'bz;
  assign mOp1_split=now_flushing_reg2 ?    read_mop[1][`mOp1_split] : 1'bz;
  assign mOp1_addr_low=now_flushing_reg2 ? read_mop[1][`mOp1_low] : 2'bz;
  assign mOp1_odd=now_flushing_reg2 ?      read_mop[1][`mOp1_odd] : 1'bz;
  assign mOp1_banks=now_flushing_reg2 ?    read_mop[1][`mOp1_banks] : 32'bz;
  assign mOp1_bank0=now_flushing_reg2 ?    read_mop[1][`mOp1_bank0] : 5'bz;
  assign mOp1_register=now_flushing_reg2 ? read_mop[1][`mOp1_regNo] : 9'bz;
  assign mOp1_en=now_flushing_reg2 ?       read_confl[1]&~thrinhibitconfl[1]  : 1'bz;
  assign mOp1_LSQ=now_flushing_reg2 ?      read_mop[1][`mOp1_LSQ] : 9'bz;
  assign mOp1_II=now_flushing_reg2 ?       read_mop[1][`mOp1_II] : 10'bz;
  assign mOp1_WQ=now_flushing_reg2 ?       read_mop[1][`mOp1_WQ] : 8'bz;
  assign mOp1_lsflag=now_flushing_reg2 ?   read_mop[1][`mOp1_lsf] : 1'bz;

  assign mOp2_thread=now_flushing_reg2 ?   read_mop[2][`mOp1_thr] : 1'bz;
  assign mOp2_addrEven=now_flushing_reg2 ? read_mop[2][`mOp1_addrEven] : 36'bz;
  assign mOp2_addrOdd=now_flushing_reg2 ?  read_mop[2][`mOp1_addrOdd] : 36'bz;
  assign mOp2_sz=now_flushing_reg2 ?       read_mop[2][`mOp1_sz] : 5'bz;
  assign mOp2_st=now_flushing_reg2 ?       read_mop[2][`mOp1_st] : 1'bz;
  assign mOp2_split=now_flushing_reg2 ?    read_mop[2][`mOp1_split] : 1'bz;
  assign mOp2_addr_low=now_flushing_reg2 ? read_mop[2][`mOp1_low] : 2'bz;
  assign mOp2_odd=now_flushing_reg2 ?      read_mop[2][`mOp1_odd] : 1'bz;
  assign mOp2_banks=now_flushing_reg2 ?    read_mop[2][`mOp1_banks] : 32'bz;
  assign mOp2_bank0=now_flushing_reg2 ?    read_mop[2][`mOp1_bank0] : 5'bz;
  assign mOp2_register=now_flushing_reg2 ? read_mop[2][`mOp1_regNo] : 9'bz;
  assign mOp2_en=now_flushing_reg2 ?       read_confl[2]&~thrinhibitconfl[2]  : 1'bz;
  assign mOp2_LSQ=now_flushing_reg2 ?      read_mop[2][`mOp1_LSQ] : 9'bz;
  assign mOp2_II=now_flushing_reg2 ?       read_mop[2][`mOp1_II] : 10'bz;
  assign mOp2_WQ=now_flushing_reg2 ?       read_mop[2][`mOp1_WQ] : 8'bz;
  assign mOp2_lsflag=now_flushing_reg2 ?   read_mop[2][`mOp1_lsf] : 1'bz;

  assign mOp3_thread=now_flushing_reg2 ?   read_mop[3][`mOp1_thr] : 1'bz;
  assign mOp3_addrEven=now_flushing_reg2 ? read_mop[3][`mOp1_addrEven] : 36'bz;
  assign mOp3_addrOdd=now_flushing_reg2 ?  read_mop[3][`mOp1_addrOdd] : 36'bz;
  assign mOp3_sz=now_flushing_reg2 ?       read_mop[3][`mOp1_sz] : 5'bz;
  assign mOp3_st=now_flushing_reg2 ?       read_mop[3][`mOp1_st] : 1'bz;
  assign mOp3_split=now_flushing_reg2 ?    read_mop[3][`mOp1_split] : 1'bz;
  assign mOp3_addr_low=now_flushing_reg2 ? read_mop[3][`mOp1_low] : 2'bz;
  assign mOp3_odd=now_flushing_reg2 ?      read_mop[3][`mOp1_odd] : 1'bz;
  assign mOp3_banks=now_flushing_reg2 ?    read_mop[3][`mOp1_banks] : 32'bz;
  assign mOp3_bank0=now_flushing_reg2 ?    read_mop[3][`mOp1_bank0] : 5'bz;
  assign mOp3_register=now_flushing_reg2 ? read_mop[3][`mOp1_regNo] : 9'bz;
  assign mOp3_en=now_flushing_reg2 ?       read_confl[3]&~thrinhibitconfl[3]  : 1'bz;
  assign mOp3_LSQ=now_flushing_reg2 ?      read_mop[3][`mOp1_LSQ] : 9'bz;
  assign mOp3_II=now_flushing_reg2 ?       read_mop[3][`mOp1_II] : 10'bz;
  assign mOp3_WQ=now_flushing_reg2 ?       read_mop[3][`mOp1_WQ] : 8'bz;
  assign mOp3_lsflag=now_flushing_reg2 ?   read_mop[3][`mOp1_lsf] : 1'bz;
  assign mOp3_lsfwd=now_flushing_reg2 ?    read_mop[3][`mOp1_lsfwd] : 1'bz;
  assign mOp3_data=now_flushing_reg2 ?     read_ddata[127+4:4] : 128'bz;
  assign mOp3_brdbanks=now_flushing_reg2 ? read_ddata[387:384] : 4'bz;

//  assign mOp4_thread=now_flushing_reg2 ?   read_mop[4][`mOp1_thr] : 1'bz;
  assign mOp4_addrEven=now_flushing_reg2 ? read_mop[4][`mOp1_addrEven] : 36'bz;
  assign mOp4_addrOdd=now_flushing_reg2 ?  read_mop[4][`mOp1_addrOdd] : 36'bz;
  assign mOp4_sz=now_flushing_reg2 ?       read_mop[4][`mOp1_sz] : 5'bz;
  assign mOp4_first=now_flushing_reg2 ?    read_mop[4][`mOp1_st] : 1'bz;
  assign mOp4_split=now_flushing_reg2 ?    read_mop[4][`mOp1_split] : 1'bz;
  assign mOp4_odd=now_flushing_reg2 ?      read_mop[4][`mOp1_odd] : 1'bz;
  assign mOp4_addr_low=now_flushing_reg2 ? read_mop[4][`mOp1_low] : 2'bz;
  assign mOp4_bank0=now_flushing_reg2 ?    read_mop[4][`mOp1_bank0] : 5'bz;
  assign mOp4_banks=now_flushing_reg2 ?    bank4 : 32'bz;
  assign mOp4_data=now_flushing_reg2 ? {read_ddata[255+4:128+4],read_mop[4][`mOp1_banks]} : 160'bz;
  assign mOp4_en=now_flushing_reg2 ?       read_confl[4]&~thrinhibitconfl[4]  : 1'bz;
  assign mOp4_bank1=now_flushing_reg2 ?    read_mop[4][`mOp1_LSQ] : 9'bz;
  assign mOp4_II=now_flushing_reg2 ?       read_mop[4][`mOp1_II] : 10'bz;
  assign {mOp4_bgn_b,mOp4_end_b}=now_flushing_reg2 ? read_mop[4][`mOp1_WQ] : 8'bz;

//  assign mOp5_thread=now_flushing_reg2 ?   read_mop[5][`mOp1_thr] : 1'bz;
  assign mOp5_addrEven=now_flushing_reg2 ? read_mop[5][`mOp1_addrEven] : 36'bz;
  assign mOp5_addrOdd=now_flushing_reg2 ?  read_mop[5][`mOp1_addrOdd] : 36'bz;
  assign mOp5_sz=now_flushing_reg2 ?       read_mop[5][`mOp1_sz] : 5'bz;
  assign mOp5_first=now_flushing_reg2 ?    read_mop[5][`mOp1_st] : 1'bz;
  assign mOp5_split=now_flushing_reg2 ?    read_mop[5][`mOp1_split] : 1'bz;
  assign mOp5_odd=now_flushing_reg2 ?      read_mop[5][`mOp1_odd] : 1'bz;
  assign mOp5_addr_low=now_flushing_reg2 ? read_mop[5][`mOp1_low] : 2'bz;
  assign mOp5_bank0=now_flushing_reg2 ?    read_mop[5][`mOp1_bank0] : 5'bz;
  assign mOp5_banks=now_flushing_reg2 ?    bank5 : 32'bz;
  assign mOp5_data=now_flushing_reg2 ? {read_ddata[383+4:256+4],read_mop[5][`mOp1_banks]} : 160'bz;
  assign mOp5_en=now_flushing_reg2 ?       read_confl[5]&~thrinhibitconfl[5]  : 1'bz;
  assign mOp5_bank1=now_flushing_reg2 ?    read_mop[5][`mOp1_LSQ] : 9'bz;
  assign mOp5_II=now_flushing_reg2 ?       read_mop[5][`mOp1_II] : 10'bz;
  assign {mOp5_bgn_b,mOp5_end_b}=now_flushing_reg2 ? read_mop[5][`mOp1_WQ] : 8'bz;

  assign write_mop[0][`mOp1_thr]=     mOp0_thread_reg[3];
  assign write_mop[0][`mOp1_addrEven]=mOp0_addrEven_reg[3];
  assign write_mop[0][`mOp1_addrOdd]= mOp0_addrOdd_reg[3];
  assign write_mop[0][`mOp1_sz]=      mOp0_sz_reg[3];
  assign write_mop[0][`mOp1_st]=      1'b0;
  assign write_mop[0][`mOp1_split]=   mOp0_split_reg[3];
  assign write_mop[0][`mOp1_low]=     mOp0_addr_low_reg[3];
  assign write_mop[0][`mOp1_odd]=     mOp0_odd_reg[3];
  assign write_mop[0][`mOp1_banks]=   mOp0_banks_reg[3];
  assign write_mop[0][`mOp1_bank0]=   mOp0_bank0_reg[3];
  assign write_mop[0][`mOp1_clHit]=   mOp0_clHit;
  assign write_mop[0][`mOp1_regNo]=   mOp0_register_reg[3];
  assign write_mop[0][`mOp1_LSQ]=     mOp0_LSQ_reg[3];
  assign write_mop[0][`mOp1_II]=      mOp0_II_reg[3];
  assign write_mop[0][`mOp1_WQ]=      mOp0_WQ_reg[3];
  assign write_mop[0][`mOp1_lsf]=     mOp0_lsflag_reg[3];
  assign write_mop[0][`mOp1_lsfwd]=   1'b0;

  assign write_mop[1][`mOp1_thr]=     mOp1_thread_reg[3];
  assign write_mop[1][`mOp1_addrEven]=mOp1_addrEven_reg[3];
  assign write_mop[1][`mOp1_addrOdd]= mOp1_addrOdd_reg[3];
  assign write_mop[1][`mOp1_sz]=      mOp1_sz_reg[3];
  assign write_mop[1][`mOp1_st]=      1'b0;
  assign write_mop[1][`mOp1_split]=   mOp1_split_reg[3];
  assign write_mop[1][`mOp1_low]=     mOp1_addr_low_reg[3];
  assign write_mop[1][`mOp1_odd]=     mOp1_odd_reg[3];
  assign write_mop[1][`mOp1_banks]=   mOp1_banks_reg[3];
  assign write_mop[1][`mOp1_bank0]=   mOp1_bank0_reg[3];
  assign write_mop[1][`mOp1_clHit]=   mOp1_clHit;
  assign write_mop[1][`mOp1_regNo]=   mOp1_register_reg[3];
  assign write_mop[1][`mOp1_LSQ]=     mOp1_LSQ_reg[3];
  assign write_mop[1][`mOp1_II]=      mOp1_II_reg[3];
  assign write_mop[1][`mOp1_WQ]=      mOp1_WQ_reg[3];
  assign write_mop[1][`mOp1_lsf]=     mOp1_lsflag_reg[3];
  assign write_mop[1][`mOp1_lsfwd]=   1'b0;

  assign write_mop[2][`mOp1_thr]=     mOp2_thread_reg[3];
  assign write_mop[2][`mOp1_addrEven]=mOp2_addrEven_reg[3];
  assign write_mop[2][`mOp1_addrOdd]= mOp2_addrOdd_reg[3];
  assign write_mop[2][`mOp1_sz]=      mOp2_sz_reg[3];
  assign write_mop[2][`mOp1_st]=      1'b0;
  assign write_mop[2][`mOp1_split]=   mOp2_split_reg[3];
  assign write_mop[2][`mOp1_low]=     mOp2_addr_low_reg[3];
  assign write_mop[2][`mOp1_odd]=     mOp2_odd_reg[3];
  assign write_mop[2][`mOp1_banks]=   mOp2_banks_reg[3];
  assign write_mop[2][`mOp1_bank0]=   mOp2_bank0_reg[3];
  assign write_mop[2][`mOp1_clHit]=   mOp2_clHit;
  assign write_mop[2][`mOp1_regNo]=   mOp2_register_reg[3];
  assign write_mop[2][`mOp1_LSQ]=     mOp2_LSQ_reg[3];
  assign write_mop[2][`mOp1_II]=      mOp2_II_reg[3];
  assign write_mop[2][`mOp1_WQ]=      mOp2_WQ_reg[3];
  assign write_mop[2][`mOp1_lsf]=     mOp2_lsflag_reg[3];
  assign write_mop[2][`mOp1_lsfwd]=   1'b0;

  assign write_mop[3][`mOp1_thr]=     mOp3_thread_reg[3];
  assign write_mop[3][`mOp1_addrEven]=mOp3_addrEven_reg[3];
  assign write_mop[3][`mOp1_addrOdd]= mOp3_addrOdd_reg[3];
  assign write_mop[3][`mOp1_sz]=      mOp3_sz_reg[3];
  assign write_mop[3][`mOp1_st]=      1'b0;
  assign write_mop[3][`mOp1_split]=   mOp3_split_reg[3];
  assign write_mop[3][`mOp1_low]=     mOp3_addr_low_reg[3];
  assign write_mop[3][`mOp1_odd]=     mOp3_odd_reg[3];
  assign write_mop[3][`mOp1_banks]=   mOp3_banks_reg[3];
  assign write_mop[3][`mOp1_bank0]=   mOp3_bank0_reg[3];
  assign write_mop[3][`mOp1_clHit]=   mOp3_clHit;
  assign write_mop[3][`mOp1_regNo]=   mOp3_register_reg[3];
  assign write_mop[3][`mOp1_LSQ]=     mOp3_LSQ_reg[3];
  assign write_mop[3][`mOp1_II]=      mOp3_II_reg[3];
  assign write_mop[3][`mOp1_WQ]=      mOp3_WQ_reg[3];
  assign write_mop[3][`mOp1_lsf]=     mOp3_lsflag_reg[3];
  assign write_mop[3][`mOp1_lsfwd]=   mOp3_lsfwd_reg[3];

  assign write_mop[4][`mOp1_thr]=     1'b0;
  assign write_mop[4][`mOp1_addrEven]=mOp4_addrEven_reg[3];
  assign write_mop[4][`mOp1_addrOdd]= mOp4_addrOdd_reg[3];
  assign write_mop[4][`mOp1_sz]=      mOp4_sz_reg[3];
  assign write_mop[4][`mOp1_st]=      1'b1;
  assign write_mop[4][`mOp1_split]=   mOp4_split_reg[3];
//  assign write_mop[4][`mOp1_low]=     2'b0;
  assign write_mop[4][`mOp1_odd]=     mOp4_odd_reg[3];
  assign write_mop[4][`mOp1_low]=     mOp4_addr_low_reg[3];
  assign write_mop[4][`mOp1_banks]=   mOp4_data_reg[3][31:0];
  assign write_mop[4][`mOp1_bank0]=   mOp4_bank0_reg[3];
  assign write_mop[4][`mOp1_clHit]=   mOp4_clHit;
  assign write_mop[4][`mOp1_LSQ]=     {mOp4_dupl,mOp4_bank1_reg[3]};
  assign write_mop[4][`mOp1_II]=      mOp4_II_reg[3];
  assign write_mop[4][`mOp1_WQ]=      {mOp4_bgn_b_reg[3],mOp4_end_b_reg[3]};
  assign write_mop[4][`mOp1_lsfwd]=   1'b0;

  assign write_mop[5][`mOp1_thr]=     1'b0;
  assign write_mop[5][`mOp1_addrEven]=mOp5_addrEven_reg[3];
  assign write_mop[5][`mOp1_addrOdd]= mOp5_addrOdd_reg[3];
  assign write_mop[5][`mOp1_sz]=      mOp5_sz_reg[3];
  assign write_mop[5][`mOp1_st]=      1'b1;
  assign write_mop[5][`mOp1_split]=   mOp5_split_reg[3];
//  assign write_mop[5][`mOp1_low]=     2'b0;
  assign write_mop[5][`mOp1_odd]=     mOp5_odd_reg[3];
  assign write_mop[5][`mOp1_low]=     mOp5_addr_low_reg[3];
  assign write_mop[5][`mOp1_banks]=   mOp5_data_reg[3][31:0];
  assign write_mop[5][`mOp1_bank0]=   mOp5_bank0_reg[3];
  assign write_mop[5][`mOp1_clHit]=   mOp5_clHit;
  assign write_mop[5][`mOp1_LSQ]=     {mOp5_dupl,mOp5_bank1_reg[3]};
  assign write_mop[5][`mOp1_II]=      mOp5_II_reg[3];
  assign write_mop[5][`mOp1_WQ]=      {mOp5_bgn_b_reg[3],mOp5_end_b_reg[3]};
  assign write_mop[5][`mOp1_lsfwd]=   1'b0;


  assign mOpR_en=conflFound && ~init && count;

  assign mOpR_addrEven=!conflFound ? {PADDR_WIDTH-8{1'B0}} : {PADDR_WIDTH-8{1'BZ}};
  assign mOpR_addrOdd=!conflFound ? {PADDR_WIDTH-8{1'B0}} : {PADDR_WIDTH-8{1'BZ}};
  assign mOpR_sz=!conflFound ? 5'B0 : 5'BZ;
  assign mOpR_st=!conflFound ? 1'B0 : 1'BZ;
  assign mOpR_split=!conflFound ? 1'B0 : 1'BZ;
  assign mOpR_odd=!conflFound ? 1'B0 : 1'BZ;
  assign mOpR_addr_low=!conflFound ? 2'B0 : 2'BZ;
  assign mOpR_banks=!conflFound ? 32'b0 : 32'BZ;
  assign mOpR_bank0=!conflFound ? 5'b0 : 5'BZ;
  assign mOpR_clHit=!conflFound ? 2'b0 : 2'BZ;
  assign mOpR_first=!conflFound ? 1'b0 : 1'BZ;
  assign mOpR_dupl=!conflFound ? 2'b0 : 2'BZ;
  
  assign curConfl=read_confl&confl_mask;

  assign rdwr_match2=read_addr==write_addr_end;
  assign rdwr_match=countF==5'd1;
  assign flush_end=rdwr_match && now_flushing;

  assign mOp_write_clear=begin_flush_reg;
  
  generate
    for(k=0;k<=5;k=k+1)  begin
        assign mOpR_addrEven=sel[k] ? read_mop[k][`mOp1_addrEven] : {PADDR_WIDTH-8{1'BZ}};
        assign mOpR_addrOdd=sel[k] ? read_mop[k][`mOp1_addrOdd] : {PADDR_WIDTH-8{1'BZ}};
        assign mOpR_sz=sel[k] ? read_mop[k][`mOp1_sz] : 5'BZ;
        assign mOpR_st=sel[k] ? read_mop[k][`mOp1_st] : 1'BZ;
        assign mOpR_first=sel[k] ? read_mop[k][`mOp1_st] : 1'BZ;
        assign mOpR_split=sel[k] ? read_mop[k][`mOp1_split] : 1'BZ;
        assign mOpR_odd=sel[k] ? read_mop[k][`mOp1_odd] : 1'BZ;
        assign mOpR_addr_low=sel[k] ? read_mop[k][`mOp1_low] : 2'BZ;
        assign mOpR_banks=sel[k] ? read_mop[k][`mOp1_banks] : 32'BZ;
        assign mOpR_bank0=sel[k] ? read_mop[k][`mOp1_bank0] : 5'BZ;
        assign mOpR_clHit=sel[k] ? read_mop[k][`mOp1_clHit] : 5'BZ;
        if (k>=4)
          assign {mOpR_dupl,dummy5}=sel[k] ? read_mop[k][`mOp1_LSQ] : 9'bz;
        else
          assign mOpR_dupl=sel[k] ? 2'b0 : 2'bz;
        if (k<4) assign rdbanks[k]=read_mop[k][`mOp1_banks] & {32{read_confl[k]}};        
    end
  endgenerate
  
  adder_inc #(4) read_inc_mod(read_addr,read_addr_d,doStep &~begin_flush_reg2 &~rst);
  adder_inc #(4) write_inc_mod(write_addr,write_addr_d,wen&~rst);
  adder_inc #(5) count_inc_mod(count,count_d,~now_flushing & wen & ~rst);
  adder #(5) count_dec_mod(count,5'b11111,count_d,1'b0,now_flushing & ~wen & ~rst);
  //adder #(4) wrEndAdd_mod(write_addr,4'hf,write_addr_end_d,1'b0,1'b1);
  adder #(5) coundF_dec_mod(countF,5'b11111,countF_d,1'b0,1'b1); 
  adder_inc #(4) initAdd_mod(initCount,initCount_next,1'b1);

  
  bit_find_first_bit #(6) findConfl_mod(curConfl,sel,conflFound);

  get_carry #(5) cmpSkip_mod(count,~STALL_COUNT[4:0],1'b1,doSkip_d);
  adder #(4) write_dec_mod(write_addr,4'hf,write_addr_dec,1'b0,1'b1);
  

  missQ_ram ramA_mod(
  clk,
  rst,
  doStep|begin_flush_reg2,
  read_addr_d,
  read_dataA,
  init ? initCount : write_addr,
  write_dataA,
  wen|init
  );

  missQ_ram ramB_mod(
  clk,
  rst,
  doStep|begin_flush_reg2,
  read_addr_d,
  read_dataB,
  init ? initCount : write_addr,
  write_dataB,
  wen|init
  );

  missQ_ram ramC_mod(
  clk,
  rst,
  doStep|begin_flush_reg2,
  read_addr_d,
  read_dataC,
  init ? initCount : write_addr,
  write_dataC,
  wen|init
  );

  missQ_data_ram ramD_mod(
  clk,
  rst,
  doStep|begin_flush_reg2,
  read_addr_d,
  read_ddata,
  init ? initCount : write_addr,
  write_ddata,
  wen|init
  );

  assign doStep=now_flushing_reg2 || ((curConfl==6'b0001 || curConfl==6'b0010 || curConfl==6'b0100 || curConfl==6'b1000 ||
    curConfl==6'b10000 || curConfl==6'b100000) && read_clkEn && ~rdwr_match2 && count);
 
  always @* begin
      stepOver4=read_mop[4][`mOp1_low]!=2'd0;
      stepOver5=read_mop[5][`mOp1_low]!=2'd0;
      stepOver42=read_mop[4][`mOp1_low]==2'd3;
      stepOver52=read_mop[5][`mOp1_low]==2'd3;
  end
   
  always @* begin
      sz4=read_mop[4][`mOp1_sz]&4'hf;
      sz5=read_mop[5][`mOp1_sz]&4'hf;
  
      for(q=0;q<32;q=q+1) begin
          bank4[q]=read_mop[4][`mOp1_bank0]==q || 
          ((sz4==3 || sz4[2] || (stepOver4 && sz4==2) || 
            (stepOver42 && sz4==1)) && read_mop[4][`mOp1_bank0]==((q-1)&5'h1f)) ||
          (((sz4==3 && stepOver4) | sz4[2]) && read_mop[4][`mOp1_bank0]==((q-2)&5'h1f)) || 
          (((sz4==4 && stepOver42) || sz4==5) && read_mop[4][`mOp1_bank0]==((q-3)&5'h1f)) ||
          ((sz4==5 && stepOver4) && read_mop[4][`mOp1_bank0]==((q-4)&5'h1f)) ;
          bank5[q]=read_mop[5][`mOp1_bank0]==q || 
          ((sz5==3 || sz5[2] || (stepOver5 && sz5==2) || 
            (stepOver52 && sz5==1)) && read_mop[5][`mOp1_bank0]==((q-1)&5'h1f)) ||
          (((sz5==3 && stepOver5) | sz5[2]) && read_mop[5][`mOp1_bank0]==((q-2)&5'h1f)) || 
          (((sz5==5 && stepOver52) || sz5==5) && read_mop[5][`mOp1_bank0]==((q-3)&5'h1f)) ||
          ((sz5==5 && stepOver5) && read_mop[5][`mOp1_bank0]==((q-4)&5'h1f)) ;
      end
  end
  
  always @(posedge clk)
    begin
	  if (rst) begin
	      confl_mask<=6'b111111;
	  end else if (flush_end|doStep) begin
	      confl_mask<=6'b111111;
	  end else begin
	      if (!count && wen) confl_mask<=6'h3f;
	      else if (count && read_clkEn && ~rdwr_match) confl_mask<=confl_mask&~sel;
	  end
	  read_addr<=read_addr_d;
	  write_addr<=write_addr_d;
	  count<=count_d;
	  if (rst) begin
	     read_addr_begin<=4'b0;
             sticky_begin<=1'b0;
	  end else if (wen && !count) begin
	      read_addr_begin<=write_addr;
              sticky_begin<=now_flushing_reg2;
	  end else if (now_flushing_reg2 & wen & ~sticky_begin) begin
              read_addr_begin<=write_addr;
              sticky_begin<=1'b1;
          end else if (~now_flushing_reg2) begin
              sticky_begin<=1'b0;
          end

	  if (rst) begin
	     write_addr_end<=4'b0;
	     write_addr_end2<=4'b0;
	  end else if (wen && ~locked|do_unlock) begin
	      write_addr_end<=write_addr;
	      write_addr_end2<=write_addr_d;
	  end else if (do_unlock & ~wen) begin
	      write_addr_end<=write_addr_dec;
	      write_addr_end2<=write_addr_dec;
	  end

          if (rst) begin
	      thrblk_addr0<=4'd0;
	      thrblk_en0<=1'b0;
	  end else if (except && ~excpt_thread && count) begin
	      thrblk_addr0<=write_addr;
	      thrblk_en0<=1'b1;
	  end else if (now_flushing_reg && read_addr_d==thrblk_addr0 && thrblk_en0) begin
	      thrblk_en0<=1'b0;
	  end
	  
          if (rst) begin
	      thrblk_addr1<=4'd0;
	      thrblk_en1<=1'b0;
	  end else if (except && excpt_thread && count) begin
	      thrblk_addr1<=write_addr;
	      thrblk_en1<=1'b1;
	  end else if (now_flushing_reg && read_addr_d==thrblk_addr1 && thrblk_en1) begin
	      thrblk_en1<=1'b0;
	  end
	  
          if (rst) doSkip<=1'b0;
	  else if (doSkip_d || last_inserted) doSkip<=1'b1;
	  else if (flush_end|~locked && ~doSkip_d) doSkip<=1'b0;
	  
	  if (rst) begin
              countF<=5'd0;
	      begin_flush<=1'b0;
	      now_flushing<=1'b0;
	      begin_flush_reg<=1'b0;
	      begin_flush_reg2<=1'b0;
	      now_flushing_reg<=1'b0;
	      now_flushing_reg2<=1'b0;
	  //    now_flooshing<=1'b0;
	      last_inserted_reg<=1'b0;
	      last_inserted_reg2<=1'b0;
	      last_inserted_reg3<=1'b0;
	      last_inserted_reg4<=1'b0;
	      do_unlock<=1'b0;
	      read_addr_reg<={ADDR_WIDTH{1'B0}};
	  end else begin
	      begin_flush<=last_inserted_reg4;
              if (begin_flush) countF<=count_d;
              else if (now_flushing && ~(wen && begin_flush_reg|begin_flush_reg2)) countF<=countF_d;
	      if (begin_flush) now_flushing<=1'b1;
	      else if (flush_end) now_flushing<=1'b0;
	      begin_flush_reg<=begin_flush;
	      begin_flush_reg2<=begin_flush_reg;
	      now_flushing_reg<=now_flushing;
	      now_flushing_reg2<=now_flushing_reg;
	//      if (now_flushing_reg & ~now_flushing_reg2) now_flooshing<=1'b1;
	//      else if (flush_end) now_flooshing<=1'b0;
	      last_inserted_reg<=last_inserted;
	      last_inserted_reg2<=last_inserted_reg;
	      last_inserted_reg3<=last_inserted_reg2;
	      last_inserted_reg4<=last_inserted_reg3;
	      do_unlock<=flush_end;
	      read_addr_reg<=read_addr;
	  end
	  if (rst) locked<=1'b0;
	  else if (last_inserted) locked<=1'b1;
	  else if (do_unlock) locked<=1'b0;
	  
	  if (rst) begin
	      for(r=1;r<=3;r=r+1) begin
                  mOp0_thread_reg[r]<=1'b0; 
                  mOp0_addrEven_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp0_addrOdd_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp0_sz_reg[r]<=5'B0;
                  mOp0_st_reg[r]<=1'B0;
                  mOp0_banks_reg[r]<=32'B0;
                  mOp0_bank0_reg[r]<=5'B0;
                  mOp0_odd_reg[r]<=1'B0;
                  mOp0_addr_low_reg[r]<=2'B0;
                  mOp0_split_reg[r]<=1'B0;
                  mOp0_register_reg[r]<=9'b0;
                  mOp0_LSQ_reg[r]<=9'b0;
                  mOp0_II_reg[r]<=10'b0;
                  mOp0_WQ_reg[r]<=8'b0;
                  mOp0_lsflag_reg[r]<=1'b0;

                  mOp1_thread_reg[r]<=1'b0; 
                  mOp1_addrEven_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp1_addrOdd_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp1_sz_reg[r]<=5'B0;
                  mOp1_st_reg[r]<=1'B0;
                  mOp1_banks_reg[r]<=32'B0;
                  mOp1_bank0_reg[r]<=5'B0;
                  mOp1_odd_reg[r]<=1'B0;
                  mOp1_addr_low_reg[r]<=2'B0;
                  mOp1_split_reg[r]<=1'B0;
                  mOp1_register_reg[r]<=9'b0;
                  mOp1_LSQ_reg[r]<=9'b0;
                  mOp1_II_reg[r]<=10'b0;
                  mOp1_WQ_reg[r]<=8'b0;
                  mOp1_lsflag_reg[r]<=1'b0;
                  
                  mOp2_thread_reg[r]<=1'b0; 
                  mOp2_addrEven_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp2_addrOdd_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp2_sz_reg[r]<=5'B0;
                  mOp2_st_reg[r]<=1'B0;
                  mOp2_banks_reg[r]<=32'B0;
                  mOp2_bank0_reg[r]<=5'B0;
                  mOp2_odd_reg[r]<=1'B0;
                  mOp2_addr_low_reg[r]<=2'B0;
                  mOp2_split_reg[r]<=1'B0;
                  mOp2_register_reg[r]<=9'b0;
                  mOp2_LSQ_reg[r]<=9'b0;
                  mOp2_II_reg[r]<=10'b0;
                  mOp2_WQ_reg[r]<=8'b0;
                  mOp2_lsflag_reg[r]<=1'b0;
                  
                  mOp3_thread_reg[r]<=1'b0; 
                  mOp3_addrEven_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp3_addrOdd_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp3_sz_reg[r]<=5'B0;
                  mOp3_st_reg[r]<=1'B0;
                  mOp3_banks_reg[r]<=32'B0;
                  mOp3_bank0_reg[r]<=5'B0;
                  mOp3_odd_reg[r]<=1'B0;
                  mOp3_addr_low_reg[r]<=2'B0;
                  mOp3_split_reg[r]<=1'B0;
                  mOp3_register_reg[r]<=9'b0;
                  mOp3_LSQ_reg[r]<=9'b0;
                  mOp3_II_reg[r]<=10'b0;
                  mOp3_WQ_reg[r]<=8'b0;
                  mOp3_lsflag_reg[r]<=1'b0;
                  mOp3_data_reg[r]<=128'b0;
		  mOp3_lsfwd_reg[r]<=1'b0;
		  mOp3_brdbanks_reg[r]<=4'b0;

                  mOp4_addrEven_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp4_addrOdd_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp4_sz_reg[r]<=5'B0;
                  mOp4_first_reg[r]<=1'B0;
                  mOp4_bank0_reg[r]<=5'B0;
                  mOp4_odd_reg[r]<=1'B0;
                  mOp4_addr_low_reg[r]<=2'B0;
                  mOp4_split_reg[r]<=1'B0;
                  mOp4_data_reg[r]<=160'b0;
                  mOp4_bank1_reg[r]<=9'b0;
                  mOp4_II_reg[r]<=10'b0;
                  mOp4_bgn_b_reg[r]<=4'b0;
                  mOp4_end_b_reg[r]<=4'b0;

                  mOp5_addrEven_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp5_addrOdd_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp5_sz_reg[r]<=5'B0;
                  mOp5_first_reg[r]<=1'B0;
                  mOp5_bank0_reg[r]<=5'B0;
                  mOp5_odd_reg[r]<=1'B0;
                  mOp5_addr_low_reg[r]<=2'B0;
                  mOp5_split_reg[r]<=1'B0;
                  mOp5_data_reg[r]<=160'b0;
                  mOp5_bank1_reg[r]<=9'b0;
                  mOp5_II_reg[r]<=10'b0;
                  mOp5_bgn_b_reg[r]<=4'b0;
                  mOp5_end_b_reg[r]<=4'b0;

                  thrreginh[r]<=6'b0;
	      end
	  end else begin
              thrreginh[1][0]<=mOp0_thread~^excpt_thread && except;
	      mOp0_thread_reg[1]<=mOp0_thread;
              mOp0_addrEven_reg[1]<=mOp0_addrEven;
              mOp0_addrOdd_reg[1]<=mOp0_addrOdd;
              mOp0_sz_reg[1]<=mOp0_sz;
              mOp0_st_reg[1]<=mOp0_st;
              mOp0_banks_reg[1]<=mOp0_banks;
              mOp0_bank0_reg[1]<=mOp0_bank0;
              mOp0_odd_reg[1]<=mOp0_odd;
              mOp0_addr_low_reg[1]<=mOp0_addr_low;
              mOp0_split_reg[1]<=mOp0_split;
              mOp0_register_reg[1]<=mOp0_register;
              mOp0_LSQ_reg[1]<=mOp0_LSQ;
              mOp0_II_reg[1]<=mOp0_II;
              mOp0_WQ_reg[1]<=mOp0_WQ;
              mOp0_lsflag_reg[1]<=mOp0_lsflag;

              thrreginh[1][1]<=mOp1_thread~^excpt_thread && except;
	      mOp1_thread_reg[1]<=mOp1_thread;
              mOp1_addrEven_reg[1]<=mOp1_addrEven;
              mOp1_addrOdd_reg[1]<=mOp1_addrOdd;
              mOp1_sz_reg[1]<=mOp1_sz;
              mOp1_st_reg[1]<=mOp1_st;
              mOp1_banks_reg[1]<=mOp1_banks;
              mOp1_bank0_reg[1]<=mOp1_bank0;
              mOp1_odd_reg[1]<=mOp1_odd;
              mOp1_addr_low_reg[1]<=mOp1_addr_low;
              mOp1_split_reg[1]<=mOp1_split;
              mOp1_register_reg[1]<=mOp1_register;
              mOp1_LSQ_reg[1]<=mOp1_LSQ;
              mOp1_II_reg[1]<=mOp1_II;
              mOp1_WQ_reg[1]<=mOp1_WQ;
              mOp1_lsflag_reg[1]<=mOp1_lsflag;

              thrreginh[1][2]<=mOp2_thread~^excpt_thread && except;
	      mOp2_thread_reg[1]<=mOp2_thread;
              mOp2_addrEven_reg[1]<=mOp2_addrEven;
              mOp2_addrOdd_reg[1]<=mOp2_addrOdd;
              mOp2_sz_reg[1]<=mOp2_sz;
              mOp2_st_reg[1]<=mOp2_st;
              mOp2_banks_reg[1]<=mOp2_banks;
              mOp2_bank0_reg[1]<=mOp2_bank0;
              mOp2_odd_reg[1]<=mOp2_odd;
              mOp2_addr_low_reg[1]<=mOp2_addr_low;
              mOp2_split_reg[1]<=mOp2_split;
              mOp2_register_reg[1]<=mOp2_register;
              mOp2_LSQ_reg[1]<=mOp2_LSQ;
              mOp2_II_reg[1]<=mOp2_II;
              mOp2_WQ_reg[1]<=mOp2_WQ;
              mOp2_lsflag_reg[1]<=mOp2_lsflag;
              
              thrreginh[1][3]<=mOp3_thread~^excpt_thread && except;
	      mOp3_thread_reg[1]<=mOp3_thread;
              mOp3_addrEven_reg[1]<=mOp3_addrEven;
              mOp3_addrOdd_reg[1]<=mOp3_addrOdd;
              mOp3_sz_reg[1]<=mOp3_sz;
              mOp3_st_reg[1]<=mOp3_st;
              mOp3_banks_reg[1]<=mOp3_banks;
              mOp3_bank0_reg[1]<=mOp3_bank0;
              mOp3_odd_reg[1]<=mOp3_odd;
              mOp3_addr_low_reg[1]<=mOp3_addr_low;
              mOp3_split_reg[1]<=mOp3_split;
              mOp3_register_reg[1]<=mOp3_register;
              mOp3_LSQ_reg[1]<=mOp3_LSQ;
              mOp3_II_reg[1]<=mOp3_II;
              mOp3_WQ_reg[1]<=mOp3_WQ;
              mOp3_lsflag_reg[1]<=mOp3_lsflag;
              mOp3_lsfwd_reg[1]<=mOp3_lsfwd;
              mOp3_data_reg[1]<=mOp3_data;
              mOp3_brdbanks_reg[1]<=mOp3_brdbanks;

              thrreginh[1][4]<=1'b0;
              mOp4_addrEven_reg[1]<=mOp4_addrEven;
              mOp4_addrOdd_reg[1]<=mOp4_addrOdd;
              mOp4_sz_reg[1]<=mOp4_sz;
              mOp4_first_reg[1]<=mOp4_first;
              mOp4_bank0_reg[1]<=mOp4_bank0;
              mOp4_odd_reg[1]<=mOp4_odd;
              mOp4_addr_low_reg[1]<=mOp4_addr_low;
              mOp4_split_reg[1]<=mOp4_split;
              mOp4_data_reg[1]<=mOp4_data;
              mOp4_bank1_reg[1]<=mOp4_bank1;
              mOp4_II_reg[1]<=mOp4_II;
              mOp4_bgn_b_reg[1]<=mOp4_bgn_b;
              mOp4_end_b_reg[1]<=mOp4_end_b;

              thrreginh[1][5]<=1'b0;
              mOp5_addrEven_reg[1]<=mOp5_addrEven;
              mOp5_addrOdd_reg[1]<=mOp5_addrOdd;
              mOp5_sz_reg[1]<=mOp5_sz;
              mOp5_first_reg[1]<=mOp5_first;
              mOp5_bank0_reg[1]<=mOp5_bank0;
              mOp5_odd_reg[1]<=mOp5_odd;
              mOp5_addr_low_reg[1]<=mOp5_addr_low;
              mOp5_split_reg[1]<=mOp5_split;
              mOp5_data_reg[1]<=mOp5_data;
              mOp5_bank1_reg[1]<=mOp5_bank1;
              mOp5_II_reg[1]<=mOp5_II;
              mOp5_bgn_b_reg[1]<=mOp5_bgn_b;
              mOp5_end_b_reg[1]<=mOp5_end_b;
              for(r=2;r<=3;r=r+1) begin
                  thrreginh[r][0]<=thrreginh[r-1][0] || (mOp0_thread_reg[r-1]~^excpt_thread && except);
	          mOp0_thread_reg[r]<=mOp0_thread_reg[r-1];
                  mOp0_addrEven_reg[r]<=mOp0_addrEven_reg[r-1];
                  mOp0_addrOdd_reg[r]<=mOp0_addrOdd_reg[r-1];
                  mOp0_sz_reg[r]<=mOp0_sz_reg[r-1];
                  mOp0_st_reg[r]<=mOp0_st_reg[r-1];
                  mOp0_banks_reg[r]<=mOp0_banks_reg[r-1];
                  mOp0_bank0_reg[r]<=mOp0_bank0_reg[r-1];
                  mOp0_odd_reg[r]<=mOp0_odd_reg[r-1];
                  mOp0_addr_low_reg[r]<=mOp0_addr_low_reg[r-1];
                  mOp0_split_reg[r]<=mOp0_split_reg[r-1];
                  mOp0_register_reg[r]<=mOp0_register_reg[r-1];
                  mOp0_LSQ_reg[r]<=mOp0_LSQ_reg[r-1];
                  mOp0_II_reg[r]<=mOp0_II_reg[r-1];
                  mOp0_WQ_reg[r]<=mOp0_WQ_reg[r-1];
                  mOp0_lsflag_reg[r]<=mOp0_lsflag_reg[r-1];

                  thrreginh[r][1]<=thrreginh[r-1][1] || (mOp1_thread_reg[r-1]~^excpt_thread && except);
	          mOp1_thread_reg[r]<=mOp1_thread_reg[r-1];
                  mOp1_addrEven_reg[r]<=mOp1_addrEven_reg[r-1];
                  mOp1_addrOdd_reg[r]<=mOp1_addrOdd_reg[r-1];
                  mOp1_sz_reg[r]<=mOp1_sz_reg[r-1];
                  mOp1_st_reg[r]<=mOp1_st_reg[r-1];
                  mOp1_banks_reg[r]<=mOp1_banks_reg[r-1];
                  mOp1_bank0_reg[r]<=mOp1_bank0_reg[r-1];
                  mOp1_odd_reg[r]<=mOp1_odd_reg[r-1];
                  mOp1_addr_low_reg[r]<=mOp1_addr_low_reg[r-1];
                  mOp1_split_reg[r]<=mOp1_split_reg[r-1];
                  mOp1_register_reg[r]<=mOp1_register_reg[r-1];
                  mOp1_LSQ_reg[r]<=mOp1_LSQ_reg[r-1];
                  mOp1_II_reg[r]<=mOp1_II_reg[r-1];
                  mOp1_WQ_reg[r]<=mOp1_WQ_reg[r-1];
                  mOp1_lsflag_reg[r]<=mOp1_lsflag_reg[r-1];

                  thrreginh[r][2]<=thrreginh[r-1][2] || (mOp2_thread_reg[r-1]~^excpt_thread && except);
	          mOp2_thread_reg[r]<=mOp2_thread_reg[r-1];
                  mOp2_addrEven_reg[r]<=mOp2_addrEven_reg[r-1];
                  mOp2_addrOdd_reg[r]<=mOp2_addrOdd_reg[r-1];
                  mOp2_sz_reg[r]<=mOp2_sz_reg[r-1];
                  mOp2_st_reg[r]<=mOp2_st_reg[r-1];
                  mOp2_banks_reg[r]<=mOp2_banks_reg[r-1];
                  mOp2_bank0_reg[r]<=mOp2_bank0_reg[r-1];
                  mOp2_odd_reg[r]<=mOp2_odd_reg[r-1];
                  mOp2_addr_low_reg[r]<=mOp2_addr_low_reg[r-1];
                  mOp2_split_reg[r]<=mOp2_split_reg[r-1];
                  mOp2_register_reg[r]<=mOp2_register_reg[r-1];
                  mOp2_LSQ_reg[r]<=mOp2_LSQ_reg[r-1];
                  mOp2_II_reg[r]<=mOp2_II_reg[r-1];
                  mOp2_WQ_reg[r]<=mOp2_WQ_reg[r-1];
                  mOp2_lsflag_reg[r]<=mOp2_lsflag_reg[r-1];
                  
                  thrreginh[r][3]<=thrreginh[r-1][3] || (mOp3_thread_reg[r-1]~^excpt_thread && except);
	          mOp3_thread_reg[r]<=mOp3_thread_reg[r-1];
                  mOp3_addrEven_reg[r]<=mOp3_addrEven_reg[r-1];
                  mOp3_addrOdd_reg[r]<=mOp3_addrOdd_reg[r-1];
                  mOp3_sz_reg[r]<=mOp3_sz_reg[r-1];
                  mOp3_st_reg[r]<=mOp3_st_reg[r-1];
                  mOp3_banks_reg[r]<=mOp3_banks_reg[r-1];
                  mOp3_bank0_reg[r]<=mOp3_bank0_reg[r-1];
                  mOp3_odd_reg[r]<=mOp3_odd_reg[r-1];
                  mOp3_addr_low_reg[r]<=mOp3_addr_low_reg[r-1];
                  mOp3_split_reg[r]<=mOp3_split_reg[r-1];
                  mOp3_register_reg[r]<=mOp3_register_reg[r-1];
                  mOp3_LSQ_reg[r]<=mOp3_LSQ_reg[r-1];
                  mOp3_II_reg[r]<=mOp3_II_reg[r-1];
                  mOp3_WQ_reg[r]<=mOp3_WQ_reg[r-1];
                  mOp3_lsflag_reg[r]<=mOp3_lsflag_reg[r-1];
                  mOp3_data_reg[r]<=mOp3_data_reg[r-1];
                  mOp3_lsfwd_reg[r]<=mOp3_lsfwd_reg[r-1];
                  mOp3_brdbanks_reg[r]<=mOp3_brdbanks_reg[r-1];

                 // thrreginh[r][4]<=thrreginh[r-1][4] || (mOp4_thread_reg[r-1]~^excpt_thread && except);
                  mOp4_addrEven_reg[r]<=mOp4_addrEven_reg[r-1];
                  mOp4_addrOdd_reg[r]<=mOp4_addrOdd_reg[r-1];
                  mOp4_sz_reg[r]<=mOp4_sz_reg[r-1];
                  mOp4_first_reg[r]<=mOp4_first_reg[r-1];
                  mOp4_bank0_reg[r]<=mOp4_bank0_reg[r-1];
                  mOp4_odd_reg[r]<=mOp4_odd_reg[r-1];
                  mOp4_addr_low_reg[r]<=mOp4_addr_low_reg[r-1];
                  mOp4_split_reg[r]<=mOp4_split_reg[r-1];
                  mOp4_data_reg[r]<=mOp4_data_reg[r-1];
                  mOp4_bank1_reg[r]<=mOp4_bank1_reg[r-1];
                  mOp4_II_reg[r]<=mOp4_II_reg[r-1];
                  mOp4_bgn_b_reg[r]<=mOp4_bgn_b_reg[r-1];
                  mOp4_end_b_reg[r]<=mOp4_end_b_reg[r-1];

                 // thrreginh[r][5]<=thrreginh[r-1][5] || (mOp5_thread_reg[r-1]~^excpt_thread && except);
                  mOp5_addrEven_reg[r]<=mOp5_addrEven_reg[r-1];
                  mOp5_addrOdd_reg[r]<=mOp5_addrOdd_reg[r-1];
                  mOp5_sz_reg[r]<=mOp5_sz_reg[r-1];
                  mOp5_first_reg[r]<=mOp5_first_reg[r-1];
                  mOp5_bank0_reg[r]<=mOp5_bank0_reg[r-1];
                  mOp5_odd_reg[r]<=mOp5_odd_reg[r-1];
                  mOp5_addr_low_reg[r]<=mOp5_addr_low_reg[r-1];
                  mOp5_split_reg[r]<=mOp5_split_reg[r-1];
                  mOp5_data_reg[r]<=mOp5_data_reg[r-1];
                  mOp5_bank1_reg[r]<=mOp5_bank1_reg[r-1];
                  mOp5_II_reg[r]<=mOp5_II_reg[r-1];
                  mOp5_bgn_b_reg[r]<=mOp5_bgn_b_reg[r-1];
                  mOp5_end_b_reg[r]<=mOp5_end_b_reg[r-1];
              end
          end
          if (rst) begin
              init<=1'b1;
              initCount<=4'd0;
          end else if (init) begin
              initCount<=initCount_next;
              if (initCount==4'hf) init<=1'b0;
          end
    end
  
endmodule



