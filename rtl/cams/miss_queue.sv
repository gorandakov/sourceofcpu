`include "../struct.sv"


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

  localparam DATA_WIDTH=2*128;
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

module missQ_datax_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=2*128+16+10+4;
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
  nowfl,
  WB_fwd,
  mOpW_brdread,
  mOpW_data,
  mOpW_pbit,
  mOpW_en,
  mOpW_thread,
  mOpW_addrEven,
  mOpW_addrOdd,
  mOpW_sz,
  mOpW_st,
  mOpW_banks,
  mOpW_bank0,
  mOpW_odd,
  mOpW_addr_low,
  mOpW_split,
  mOpW_register,
  mOpW_type,
  mOpW_LSQ,
  mOpW_II,
  mOpW_WQ,
  mOpW_lsflag,
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
  mOp0_type,
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
  mOp0_type_o,
  mOp0_LSQ_o,
  mOp0_II_o,
  mOp0_WQ_o,
  mOp0_lsflag_o,
  mOp0_lsfwd_o,
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
  mOp1_type,
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
  mOp1_type_o,
  mOp1_LSQ_o,
  mOp1_II_o,
  mOp1_WQ_o,
  mOp1_lsflag_o,
  mOp1_lsfwd_o,
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
  mOp2_type,
  mOp2_clHit,
  mOp2_LSQ,
  mOp2_II,
  mOp2_WQ,
  mOp2_lsflag,
  mOp2_en_o,
  mOp2_thread_o,
  mOp2_addrEven_o,
  mOp2_addrOdd_o,
  mOp2_sz_o,
  mOp2_st_o,
  mOp2_banks_o,
  mOp2_bank0_o,
  mOp2_odd_o,
  mOp2_addr_low_o,
  mOp2_split_o,
  mOp2_register_o,
  mOp2_type_o,
  mOp2_LSQ_o,
  mOp2_II_o,
  mOp2_WQ_o,
  mOp2_lsflag_o,
  mOp2_lsfwd_o,
  mOp2_data_o,
  mOp2_pbit_o,
  mOp2_brdread_o,
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
  mOp3_type,
  mOp3_clHit,
  mOp3_LSQ,
  mOp3_II,
  mOp3_WQ,
  mOp3_lsflag,
  mOp3_lsfwd,
  mOp3_data,
  mOp3_pbit,
  mOp3_brdbanks,
  mOp3_en_o,
  mOp3_thread_o,
  mOp3_addrEven_o,
  mOp3_addrOdd_o,
  mOp3_sz_o,
  mOp3_st_o,
  mOp3_banks_o,
  mOp3_bank0_o,
  mOp3_odd_o,
  mOp3_addr_low_o,
  mOp3_split_o,
  mOp3_register_o,
  mOp3_type_o,
  mOp3_LSQ_o,
  mOp3_II_o,
  mOp3_WQ_o,
  mOp3_lsflag_o,
  mOp3_lsfwd_o,
  mOp3_data_o,
  mOp3_pbit_o,
  mOp3_brdbanks_o,
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
  mOp4_pbit,
  mOp4_type,
  mOp4_II,
  mOp4_en_o,
//  mOp4_dupl_o,
  //mOp4_thread_o,
  mOp4_addrEven_o,
  mOp4_addrOdd_o,
  mOp4_sz_o,
//  mOp4_first_o,
  mOp4_banks_o,
  mOp4_bank0_o,
  mOp4_bank1_o,
  mOp4_bgn_b_o,
  mOp4_end_b_o,
  mOp4_odd_o,
  mOp4_addr_low_o,
  mOp4_split_o,
  mOp4_data_o,
  mOp4_pbit_o,
  mOp4_type_o,
  mOp4_II_o,
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
  mOp5_pbit,
  mOp5_type,
  mOp5_II,
  mOp5_en_o,
//  mOp5_dupl_o,
 // mOp5_thread_o,
  mOp5_addrEven_o,
  mOp5_addrOdd_o,
  mOp5_sz_o,
//  mOp5_first_o,
  mOp5_banks_o,
  mOp5_bank0_o,
  mOp5_bank1_o,
  mOp5_bgn_b_o,
  mOp5_end_b_o,
  mOp5_odd_o,
  mOp5_addr_low_o,
  mOp5_split_o,
  mOp5_data_o,
  mOp5_pbit_o,
  mOp5_type_o,
  mOp5_II_o,

  mOp_noBanks,
  mOp_noBanks_o,
  mOp_write_clear,
  mOpR_en,
  mOpR_addrEven,
  mOpR_addrOdd,
  mOpR_sz,
  mOpR_st,
//  mOpR_first,
//  mOpR_banks,
  mOpR_bank0,
  mOpR_io,
  mOpR_odd,
  mOpR_addr_low,
  mOpR_split,
  mOpR_clHit,
  mOpR_dupl,
  alt_bus_hold,
  alt_bus_addr
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
  localparam DDATA_WIDTH=2*128;
  localparam DXDATA_WIDTH=2*128+16+10+4;
 
  input clk;
  input rst;
  input except;
  input excpt_thread;
  input read_clkEn;
  input last_inserted;
  output reg doSkip;
  output do_bus_hold;
  output reg do_unlock;
  output nowfl;
  
  input [2:0] WB_fwd;
  input [4:0] mOpW_brdread;
  input [127+8:0] mOpW_data;
  input [1:0] mOpW_pbit;

  input mOpW_en;
  input mOpW_thread;
  input [PADDR_WIDTH-1:8] mOpW_addrEven;
  input [PADDR_WIDTH-1:8] mOpW_addrOdd;
  input [4:0] mOpW_sz;
  input mOpW_st;
  input [BANK_COUNT-1:0] mOpW_banks;
  input [4:0] mOpW_bank0;
  input mOpW_odd;
  input [1:0] mOpW_addr_low;
  input mOpW_split;
  input [REG_WIDTH-1:0] mOpW_register;
  input [1:0] mOpW_type;
  input [8:0] mOpW_LSQ;
  input [9:0] mOpW_II;
  input [7:0] mOpW_WQ;
  input mOpW_lsflag;

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
  input [1:0] mOp0_type;
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
  output [1:0] mOp0_type_o;
  output [8:0] mOp0_LSQ_o;
  output [9:0] mOp0_II_o;
  output [7:0] mOp0_WQ_o;
  output mOp0_lsflag_o;
  output mOp0_lsfwd_o;

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
  input [1:0] mOp1_type;
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
  output [1:0] mOp1_type_o;
  output [8:0] mOp1_LSQ_o;
  output [9:0] mOp1_II_o;
  output [7:0] mOp1_WQ_o;
  output mOp1_lsflag_o;
  output mOp1_lsfwd_o;

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
  input [1:0] mOp2_type;
  input [1:0] mOp2_clHit;
  input [8:0] mOp2_LSQ;
  input [9:0] mOp2_II;
  input [7:0] mOp2_WQ;
  input mOp2_lsflag;

  output mOp2_en_o;
  output mOp2_thread_o;
  output [PADDR_WIDTH-1:8] mOp2_addrEven_o;
  output [PADDR_WIDTH-1:8] mOp2_addrOdd_o;
  output [4:0] mOp2_sz_o;
  output mOp2_st_o;
  output [BANK_COUNT-1:0] mOp2_banks_o;
  output [4:0] mOp2_bank0_o;
  output mOp2_odd_o;
  output [1:0] mOp2_addr_low_o;
  output mOp2_split_o;
  output [REG_WIDTH-1:0] mOp2_register_o;
  output [1:0] mOp2_type_o;
  output [8:0] mOp2_LSQ_o;
  output [9:0] mOp2_II_o;
  output [7:0] mOp2_WQ_o;
  output mOp2_lsflag_o;
  output mOp2_lsfwd_o;
  output [135:0] mOp2_data_o;
  output [1:0] mOp2_pbit_o;
  output [4:0] mOp2_brdread_o;

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
  input [1:0] mOp3_type;
  input [1:0] mOp3_clHit;
  input [8:0] mOp3_LSQ;
  input [9:0] mOp3_II;
  input [7:0] mOp3_WQ;
  input mOp3_lsflag;
  input mOp3_lsfwd;
  input [135:0] mOp3_data;
  input [1:0] mOp3_pbit;
  input [4:0] mOp3_brdbanks;

  output mOp3_en_o;
  output mOp3_thread_o;
  output [PADDR_WIDTH-1:8] mOp3_addrEven_o;
  output [PADDR_WIDTH-1:8] mOp3_addrOdd_o;
  output [4:0] mOp3_sz_o;
  output mOp3_st_o;
  output [BANK_COUNT-1:0] mOp3_banks_o;
  output [4:0] mOp3_bank0_o;
  output mOp3_odd_o;
  output [1:0] mOp3_addr_low_o;
  output mOp3_split_o;
  output [REG_WIDTH-1:0] mOp3_register_o;
  output [1:0] mOp3_type_o;
  output [8:0] mOp3_LSQ_o;
  output [9:0] mOp3_II_o;
  output [7:0] mOp3_WQ_o;
  output mOp3_lsflag_o;
  output mOp3_lsfwd_o;
  output [127+8:0] mOp3_data_o;
  output [1:0] mOp3_pbit_o;
  output [3+1:0] mOp3_brdbanks_o;

  input miss4;
  input mOp4_en;
  input [1:0] mOp4_dupl;
 // in out mOp4_thread;
  input [PADDR_WIDTH-1:8] mOp4_addrEven;
  input [PADDR_WIDTH-1:8] mOp4_addrOdd;
  input [4:0] mOp4_sz;
  input mOp4_first;
  input [BANK_COUNT-1:0] mOp4_banks;
  input [4:0] mOp4_bank0;
  input [4:0] mOp4_bank1;
  input [3:0] mOp4_bgn_b;
  input [3:0] mOp4_end_b;
  input mOp4_odd;
  input [1:0] mOp4_addr_low;
  input mOp4_split;
  input [1:0] mOp4_clHit;
  input [159:0] mOp4_data;
  input [1:0] mOp4_pbit;
  input [1:0] mOp4_type;
  input [9:0] mOp4_II;

  output mOp4_en_o;
  //output [1:0] mOp4_dupl_o;
  output [PADDR_WIDTH-1:8] mOp4_addrEven_o;
  output [PADDR_WIDTH-1:8] mOp4_addrOdd_o;
  output [4:0] mOp4_sz_o;
 // output mOp4_first_o;
  output [BANK_COUNT-1:0] mOp4_banks_o;
  output [4:0] mOp4_bank0_o;
  output [4:0] mOp4_bank1_o;
  output [3:0] mOp4_bgn_b_o;
  output [3:0] mOp4_end_b_o;
  output mOp4_odd_o;
  output [1:0] mOp4_addr_low_o;
  output mOp4_split_o;
  output [159:0] mOp4_data_o;
  output [1:0] mOp4_pbit_o;
  output [1:0] mOp4_type_o;
  output [9:0] mOp4_II_o;

  input miss5;
  input mOp5_en;
  input [1:0] mOp5_dupl;
//  in out mOp5_thread;
  input [PADDR_WIDTH-1:8] mOp5_addrEven;
  input [PADDR_WIDTH-1:8] mOp5_addrOdd;
  input [4:0] mOp5_sz;
  input mOp5_first;
  input [BANK_COUNT-1:0] mOp5_banks;
  input [4:0] mOp5_bank0;
  input [4:0] mOp5_bank1;
  input [3:0] mOp5_bgn_b;
  input [3:0] mOp5_end_b;
  input mOp5_odd;
  input [1:0] mOp5_addr_low;
  input mOp5_split;
  input [1:0] mOp5_clHit;
  input [159:0] mOp5_data;
  input [1:0] mOp5_pbit;
  input [1:0] mOp5_type;
  input [9:0] mOp5_II;
  
  output mOp5_en_o;
 // output [1:0] mOp5_dupl_o;
  output [PADDR_WIDTH-1:8] mOp5_addrEven_o;
  output [PADDR_WIDTH-1:8] mOp5_addrOdd_o;
  output [4:0] mOp5_sz_o;
//  output mOp5_first_o;
  output [BANK_COUNT-1:0] mOp5_banks_o;
  output [4:0] mOp5_bank0_o;
  output [4:0] mOp5_bank1_o;
  output [3:0] mOp5_bgn_b_o;
  output [3:0] mOp5_end_b_o;
  output mOp5_odd_o;
  output [1:0] mOp5_addr_low_o;
  output mOp5_split_o;
  output [159:0] mOp5_data_o;
  output [1:0] mOp5_pbit_o;
  output [1:0] mOp5_type_o;
  output [9:0] mOp5_II_o;
  
  input [31:0] mOp_noBanks;
  output [31:0] mOp_noBanks_o;
  output mOp_write_clear; //uses mOp{4|5}_first

  output mOpR_en;
  output [PADDR_WIDTH-1:8] mOpR_addrEven;
  output [PADDR_WIDTH-1:8] mOpR_addrOdd;
  output [4:0] mOpR_sz;
  output mOpR_st;
//  output mOpR_first;
//  output [BANK_COUNT-1:0] mOpR_banks;
  output [4:0] mOpR_bank0;
  output mOpR_io;
  output mOpR_odd;
  output [1:0] mOpR_addr_low;
  output mOpR_split;
  output [1:0] mOpR_clHit;
  output [1:0] mOpR_dupl;
  input alt_bus_hold;
  input [36:0] alt_bus_addr;

  wire [5:0] curConfl;
//  wire [5:0] write_confl;
  wire [5:0] read_confl;
  wire [5:0] sel;  
  wire conflFound;
  wire doStep;
  
  reg [ADDR_WIDTH-1:0] read_addr;
  wire [ADDR_WIDTH-1:0] read_addr_d;
  wire [ADDR_WIDTH-1:0] read_addrA_d;
  wire [ADDR_WIDTH-1:0] read_addrB_d;
  wire [ADDR_WIDTH-1:0] read_addrEA_d;
  wire [ADDR_WIDTH-1:0] read_addrEB_d;
  wire [ADDR_WIDTH-1:0] read_addrRA_d;
  wire [ADDR_WIDTH-1:0] read_addrRB_d;
 // reg [ADDR_WIDTH-1:0] read_addr_old;
  reg [ADDR_WIDTH-1:0] read_addr_begin;
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  reg [ADDR_WIDTH-1:0] write_addr_end;
  reg [ADDR_WIDTH-1:0] write_addr_end2;
 // wire [ADDR_WIDTH-1:0] write_addr_end_d;
  reg [ADDR_WIDTH-1:0] write_addr;
  wire [ADDR_WIDTH-1:0] write_addr_d;
  wire [16:0] count0;
  wire [16:0] count;
  wire [16:0] countR;
  wire [16:0] count1;
  wire [16:1] cmore;
  wire wen;
  //wire [3:0] write_addr_dec;
 
  wire [1:0] mOp4_dupl_dummy;
  wire [1:0] mOp5_dupl_dummy; 
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
  wire [DXDATA_WIDTH-1:0] read_dxdata;
  wire [DXDATA_WIDTH-1:0] write_dxdata;
  
  
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
  reg [1:0] mOp0_type_reg[3:1];
  reg [9:0] mOp0_II_reg[3:1];
  reg [7:0] mOp0_WQ_reg[3:1];
  reg mOp0_lsflag_reg[3:1];
  reg mOp0_lsfwd_reg[3:1];

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
  reg [1:0] mOp1_type_reg[3:1];
  reg [9:0] mOp1_II_reg[3:1];
  reg [7:0] mOp1_WQ_reg[3:1];
  reg mOp1_lsflag_reg[3:1];
  reg mOp1_lsfwd_reg[3:1];

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
  reg [1:0] mOp2_type_reg[3:1];
  reg [9:0] mOp2_II_reg[3:1];
  reg [7:0] mOp2_WQ_reg[3:1];
  reg mOp2_lsflag_reg[3:1];
  reg mOp2_lsfwd_reg[3:1];
  reg [127+8:0] mOp2_data_reg[3:1];
  reg [4:0] mOp2_brdread_reg[3:1];

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
  reg [1:0] mOp3_type_reg[3:1];
  reg [9:0] mOp3_II_reg[3:1];
  reg [7:0] mOp3_WQ_reg[3:1];
  reg mOp3_lsflag_reg[3:1];
  reg mOp3_lsfwd_reg[3:1];
  reg [127+8:0] mOp3_data_reg[3:1];
  reg [4:0] mOp3_brdbanks_reg[3:1];

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
  reg [1:0] mOp4_type_reg[3:1];
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
  reg [1:0] mOp5_type_reg[3:1];
  reg [3:0] mOp5_bgn_b_reg[3:1];
  reg [3:0] mOp5_end_b_reg[3:1];

  reg [31:0] bank4;
  reg [31:0] bank5;
  reg [4:0] sz4;
  reg [4:0] sz5;
  
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
  reg [2:0] opsize4;
  reg [2:0] opsize5; 

  genvar k;
  integer r,q;
  
  reg init;
  reg [3:0] initCount;
  wire [3:0] initCount_next;
 
  reg [15:0] validS[1:0]; 
  reg [15:0] valid[1:0]; 
  reg [15:0] valid_rd; 
  reg [15:0] vMask; 
  reg [15:0] vMaskN;
  reg vOn_next;
  reg [15:0] validSR[1:0]; 
  reg [15:0] validR[1:0]; 
  reg [15:0] vMaskR; 
  reg [15:0] vMaskRN;
  reg vOn_nextR;
  wire [15:0] rdvalid0;
  wire rdvalid0_found;
  wire [15:0] rdvalid1;
  wire rdvalid1_found;
  wire [15:0] rdvalidR0;
  wire rdvalidR0_found;
  wire [15:0] rdvalidR1;
  wire rdvalidR1_found;
  wire [15:0] rdvalidEA0;
  wire rdvalidEA0_found;
  wire [15:0] rdvalidEA1;
  wire rdvalidEA1_found;
  wire [15:0] rdvalidEB0;
  wire rdvalidEB0_found;
  wire [15:0] rdvalidEB1;
  wire rdvalidEB1_found;
  wire [15:0] rdvalidRA0;
  wire rdvalidRA0_found;
  wire [15:0] rdvalidRA1;
  wire rdvalidRA1_found;
  wire [15:0] rdvalidRB0;
  wire rdvalidRB0_found;
  wire [15:0] rdvalidRB1;
  wire rdvalidRB1_found;

  wire [5:0] read_thread; 
  wire [5:0] thrinhibitconfl;
  reg [5:0] thrreginh[3:1];
  reg pwned;

  wire [4:0] dummy5;

  assign write_dataA={miss1&~thrreginh[3][1],miss0&~thrreginh[3][0],write_mop[1],write_mop[0]}&{DATA_WIDTH{~init}};
  assign write_dataB={miss3&~thrreginh[3][3],miss2&~thrreginh[3][2],write_mop[3],write_mop[2]}&{DATA_WIDTH{~init}};
  assign write_dataC={miss5&~thrreginh[3][5],miss4&~thrreginh[3][4],write_mop[5],write_mop[4]}&{DATA_WIDTH{~init}};
  assign write_ddata={mOp5_data_reg[3][159:32],mOp4_data_reg[3][159:32]}&{DDATA_WIDTH{~init}};
  assign write_dxdata={mOp3_pbit_reg[3],mOp3_data_reg[3],mOp3_brdbanks_reg[3],mOp2_pbit_reg[3],mOp2_data_reg[3],mOp2_brdread_reg[3]}
    &{DXDATA_WIDTH{~init}};
  
  assign wen=miss0&~thrreginh[3][0]||miss1&~thrreginh[3][1]||miss2&~thrreginh[3][2]||
      miss3&~thrreginh[3][3]||miss4&~thrreginh[3][4]||miss5&~thrreginh[3][5];
  assign write_addr_d=(~wen & ~rst) ? write_addr : 4'bz; 
  
  assign write_addr_d=rst ? 4'b0:4'bz;
  
  
  assign {read_confl[1:0],read_mop[1],read_mop[0]}=read_dataA;
  assign {read_confl[3:2],read_mop[3],read_mop[2]}=read_dataB;
  assign {read_confl[5:4],read_mop[5],read_mop[4]}=read_dataC;

  assign do_bus_hold=now_flushing_reg;
  
  assign mOp_noBanks_o=now_flushing_reg2 ? 
    ~(rdbanks[0]|rdbanks[1]|rdbanks[2]|rdbanks[3]) : 32'bz;
  assign mOp_noBanks_o=alt_bus_hold ? {32{1'b1}} : 32'bz;
 assign mOp_noBanks_o=~now_flushing_reg2 && ~alt_bus_hold ? mOp_noBanks : 32'bz;

  assign read_thread={2'b0,read_mop[3][`mOp1_thr],read_mop[2][`mOp1_thr],read_mop[1][`mOp1_thr],read_mop[0][`mOp1_thr]};

  assign thrinhibitconfl={2'b0,read_mop[3][`mOp1_regNo]!=9'h1fc && except,{3{except}}}|{2'b0,
	  read_mop[3][`mOp1_regNo]!=9'h1fc&&~valid_rd[read_addr],{3{~valid_rd[read_addr]}}}; 

  assign mOp0_thread_o=now_flushing_reg2 && ~WB_fwd[0] ?   read_mop[0][`mOp1_thr] : 1'bz;
  assign mOp0_thread_o=~now_flushing_reg2 && ~WB_fwd[0] ? mOp0_thread : 1'bz;
  assign mOp0_thread_o=WB_fwd[0] ? mOpW_thread : 1'bz;
  assign mOp0_addrEven_o=now_flushing_reg2 && ~WB_fwd[0] ? read_mop[0][`mOp1_addrEven] : 36'bz; 
  assign mOp0_addrEven_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[0] ? mOp0_addrEven : 36'bz;
  assign mOp0_addrEven_o=alt_bus_hold & ~ WB_fwd[0] ? alt_bus_addr[36:1] : 36'bz;
  assign mOp0_addrEven_o=WB_fwd[0] ? mOpW_addrEven : 36'bz;
  assign mOp0_addrOdd_o=now_flushing_reg2 && ~WB_fwd[0] ? read_mop[0][`mOp1_addrOdd] : 36'bz; 
  assign mOp0_addrOdd_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[0] ? mOp0_addrOdd : 36'bz;
  assign mOp0_addrOdd_o=alt_bus_hold & ~ WB_fwd[0] ? alt_bus_addr[36:1] : 36'bz;
  assign mOp0_addrOdd_o=WB_fwd[0] ? mOpW_addrOdd : 36'bz;
  assign mOp0_sz_o=now_flushing_reg2 & ~WB_fwd[0] ?       read_mop[0][`mOp1_sz] : 5'bz; 
  assign mOp0_sz_o=~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_sz : 5'bz; 
  assign mOp0_sz_o=WB_fwd[0] ? mOpW_sz : 5'bz;
  assign mOp0_st_o=now_flushing_reg2 & ~WB_fwd[0] ?       read_mop[0][`mOp1_st] : 1'bz; 
  assign mOp0_st_o=~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_st : 1'bz; 
  assign mOp0_st_o=WB_fwd[0] ? mOpW_st : 1'bz;
  assign mOp0_split_o=now_flushing_reg2 & ~WB_fwd[0] ?    read_mop[0][`mOp1_split] : 1'bz; 
  assign mOp0_split_o=~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_split : 1'bz; 
  assign mOp0_split_o=WB_fwd[0] ? mOpW_split : 1'bz;
  assign mOp0_addr_low_o=now_flushing_reg2 & ~WB_fwd[0] ? read_mop[0][`mOp1_low] : 2'bz;
  assign mOp0_addr_low_o=~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_addr_low : 2'bz; 
  assign mOp0_addr_low_o=WB_fwd[0] ? mOpW_addr_low : 2'bz;
  assign mOp0_odd_o=now_flushing_reg2 & ~WB_fwd[0] ? read_mop[0][`mOp1_odd] : 1'bz; 
  assign mOp0_odd_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[0] ? mOp0_odd : 1'bz;
  assign mOp0_odd_o=alt_bus_hold && ~WB_fwd[0]? alt_bus_addr[0] : 1'bz;
  assign mOp0_odd_o=WB_fwd[0] ? mOpW_odd : 1'bz;
  assign mOp0_banks_o=now_flushing_reg2 && ~WB_fwd[0] ?    read_mop[0][`mOp1_banks] : 32'bz;
  assign mOp0_banks_o=alt_bus_hold && ~WB_fwd[0] ? 32'b0 : 32'bz;
  assign mOp0_banks_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[0] ? mOp0_banks : 32'bz;
  assign mOp0_banks_o=WB_fwd[0] ? mOpW_banks : 32'bz;
  assign mOp0_bank0_o=now_flushing_reg2 & ~WB_fwd[0] ?    read_mop[0][`mOp1_bank0] : 5'bz; 
  assign mOp0_bank0_o=~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_bank0 : 5'bz; 
  assign mOp0_bank0_o=WB_fwd[0] ? mOpW_bank0 : 5'bz;
  assign mOp0_register_o=now_flushing_reg2 && ~WB_fwd[0] ? read_mop[0][`mOp1_regNo] : 9'bz;
  assign mOp0_register_o=alt_bus_hold & ~ WB_fwd[0] ? 9'h1ef : 9'bz;
  assign mOp0_register_o=~alt_bus_hold & ~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_register : 9'bz;
  assign mOp0_register_o=WB_fwd[0] ? mOpW_register : 9'bz;
  assign mOp0_type_o=now_flushing_reg2 && ~WB_fwd[0] ? read_mop[0][`mOp1_type] : 2'bz;
  assign mOp0_type_o=alt_bus_hold & ~WB_fwd[0] ? 2'b0 : 2'bz;
  assign mOp0_type_o=~alt_bus_hold & ~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_type : 2'bz;
  assign mOp0_type_o=WB_fwd[0] ? mOpW_type : 2'bz;
  assign mOp0_en_o=now_flushing_reg2 && ~WB_fwd[0] ?       read_confl[0]&~thrinhibitconfl[0]  : 1'bz;
  assign mOp0_en_o=alt_bus_hold & ~WB_fwd[0] ? 1'b1 : 1'bz;
  assign mOp0_en_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[0] ? mOp0_en : 1'bz;
  assign mOp0_en_o=WB_fwd[0] ? mOpW_en : 1'bz;
  assign mOp0_LSQ_o=now_flushing_reg2 & ~WB_fwd[0] ?      read_mop[0][`mOp1_LSQ] : 9'bz; 
  assign mOp0_LSQ_o=~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_LSQ : 9'bz; 
  assign mOp0_LSQ_o=WB_fwd[0] ? mOpW_LSQ : 9'bz;
  assign mOp0_II_o=now_flushing_reg2 & ~WB_fwd[0] ?       read_mop[0][`mOp1_II] : 10'bz; 
  assign mOp0_II_o=~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_II : 10'bz; 
  assign mOp0_II_o=WB_fwd[0] ? mOpW_II : 10'bz;
  assign mOp0_WQ_o=now_flushing_reg2 & ~WB_fwd[0] ?       read_mop[0][`mOp1_WQ] : 8'bz; 
  assign mOp0_WQ_o=~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_WQ : 8'bz; 
  assign mOp0_WQ_o=WB_fwd[0] ? mOpW_WQ : 8'bz;
  assign mOp0_lsflag_o=now_flushing_reg2 & ~WB_fwd[0] ?   read_mop[0][`mOp1_lsf] : 1'bz; 
  assign mOp0_lsflag_o=~now_flushing_reg2 & ~WB_fwd[0] ? mOp0_lsflag : 1'bz; 
  assign mOp0_lsflag_o=WB_fwd[0] ? mOpW_lsflag : 1'bz;
  assign mOp0_lsfwd_o=now_flushing_reg2 ?    read_mop[0][`mOp1_lsfwd] :  WB_fwd[0];

  assign mOp1_thread_o=now_flushing_reg2 && ~WB_fwd[1] ?   read_mop[1][`mOp1_thr] : 1'bz;
  assign mOp1_thread_o=~now_flushing_reg2 && ~WB_fwd[1] ? mOp1_thread : 1'bz;
  assign mOp1_thread_o=WB_fwd[1] ? mOpW_thread : 1'bz;
  assign mOp1_addrEven_o=now_flushing_reg2 && ~WB_fwd[1] ? read_mop[1][`mOp1_addrEven] : 36'bz; 
  assign mOp1_addrEven_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[1] ? mOp1_addrEven : 36'bz;
  assign mOp1_addrEven_o=alt_bus_hold & ~ WB_fwd[1] ? alt_bus_addr[36:1] : 36'bz;
  assign mOp1_addrEven_o=WB_fwd[1] ? mOpW_addrEven : 36'bz;
  assign mOp1_addrOdd_o=now_flushing_reg2 && ~WB_fwd[1] ? read_mop[1][`mOp1_addrOdd] : 36'bz; 
  assign mOp1_addrOdd_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[1] ? mOp1_addrOdd : 36'bz;
  assign mOp1_addrOdd_o=alt_bus_hold & ~ WB_fwd[1] ? alt_bus_addr[36:1] : 36'bz;
  assign mOp1_addrOdd_o=WB_fwd[1] ? mOpW_addrOdd : 36'bz;
  assign mOp1_sz_o=now_flushing_reg2 & ~WB_fwd[1] ?       read_mop[1][`mOp1_sz] : 5'bz; 
  assign mOp1_sz_o=~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_sz : 5'bz; 
  assign mOp1_sz_o=WB_fwd[1] ? mOpW_sz : 5'bz;
  assign mOp1_st_o=now_flushing_reg2 & ~WB_fwd[1] ?       read_mop[1][`mOp1_st] : 1'bz; 
  assign mOp1_st_o=~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_st : 1'bz; 
  assign mOp1_st_o=WB_fwd[1] ? mOpW_st : 1'bz;
  assign mOp1_split_o=now_flushing_reg2 & ~WB_fwd[1] ?    read_mop[1][`mOp1_split] : 1'bz; 
  assign mOp1_split_o=~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_split : 1'bz; 
  assign mOp1_split_o=WB_fwd[1] ? mOpW_split : 1'bz;
  assign mOp1_addr_low_o=now_flushing_reg2 & ~WB_fwd[1] ? read_mop[1][`mOp1_low] : 2'bz;
  assign mOp1_addr_low_o=~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_addr_low : 2'bz; 
  assign mOp1_addr_low_o=WB_fwd[1] ? mOpW_addr_low : 2'bz;
  assign mOp1_odd_o=now_flushing_reg2 & ~WB_fwd[1] ? read_mop[1][`mOp1_odd] : 1'bz; 
  assign mOp1_odd_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[1] ? mOp1_odd : 1'bz;
  assign mOp1_odd_o=alt_bus_hold && ~WB_fwd[1]? alt_bus_addr[1] : 1'bz;
  assign mOp1_odd_o=WB_fwd[1] ? mOpW_odd : 1'bz;
  assign mOp1_banks_o=now_flushing_reg2 && ~WB_fwd[1] ?    read_mop[1][`mOp1_banks] : 32'bz;
  assign mOp1_banks_o=alt_bus_hold && ~WB_fwd[1] ? 32'b0 : 32'bz;
  assign mOp1_banks_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[1] ? mOp1_banks : 32'bz;
  assign mOp1_banks_o=WB_fwd[1] ? mOpW_banks : 32'bz;
  assign mOp1_bank0_o=now_flushing_reg2 & ~WB_fwd[1] ?    read_mop[1][`mOp1_bank0] : 5'bz; 
  assign mOp1_bank0_o=~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_bank0 : 5'bz; 
  assign mOp1_bank0_o=WB_fwd[1] ? mOpW_bank0 : 5'bz;
  assign mOp1_register_o=now_flushing_reg2 && ~WB_fwd[1] ? read_mop[1][`mOp1_regNo] : 9'bz;
  assign mOp1_register_o=alt_bus_hold & ~ WB_fwd[1] ? 9'h1ef : 9'bz;
  assign mOp1_register_o=~alt_bus_hold & ~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_register : 9'bz;
  assign mOp1_register_o=WB_fwd[1] ? mOpW_register : 9'bz;
  assign mOp1_type_o=now_flushing_reg2 && ~WB_fwd[1] ? read_mop[1][`mOp1_type] : 2'bz;
  assign mOp1_type_o=alt_bus_hold & ~WB_fwd[1] ? 2'b0 : 2'bz;
  assign mOp1_type_o=~alt_bus_hold & ~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_type : 2'bz;
  assign mOp1_type_o=WB_fwd[1] ? mOpW_type : 2'bz;
  assign mOp1_en_o=now_flushing_reg2 && ~WB_fwd[1] ?       read_confl[1]&~thrinhibitconfl[1]  : 1'bz;
  assign mOp1_en_o=alt_bus_hold & ~WB_fwd[1] ? 1'b1 : 1'bz;
  assign mOp1_en_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[1] ? mOp1_en : 1'bz;
  assign mOp1_en_o=WB_fwd[1] ? mOpW_en : 1'bz;
  assign mOp1_LSQ_o=now_flushing_reg2 & ~WB_fwd[1] ?      read_mop[1][`mOp1_LSQ] : 9'bz; 
  assign mOp1_LSQ_o=~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_LSQ : 9'bz; 
  assign mOp1_LSQ_o=WB_fwd[1] ? mOpW_LSQ : 9'bz;
  assign mOp1_II_o=now_flushing_reg2 & ~WB_fwd[1] ?       read_mop[1][`mOp1_II] : 10'bz; 
  assign mOp1_II_o=~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_II : 10'bz; 
  assign mOp1_II_o=WB_fwd[1] ? mOpW_II : 10'bz;
  assign mOp1_WQ_o=now_flushing_reg2 & ~WB_fwd[1] ?       read_mop[1][`mOp1_WQ] : 8'bz; 
  assign mOp1_WQ_o=~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_WQ : 8'bz; 
  assign mOp1_WQ_o=WB_fwd[1] ? mOpW_WQ : 8'bz;
  assign mOp1_lsflag_o=now_flushing_reg2 & ~WB_fwd[1] ?   read_mop[1][`mOp1_lsf] : 1'bz; 
  assign mOp1_lsflag_o=~now_flushing_reg2 & ~WB_fwd[1] ? mOp1_lsflag : 1'bz; 
  assign mOp1_lsflag_o=WB_fwd[1] ? mOpW_lsflag : 1'bz;
  assign mOp1_lsfwd_o=now_flushing_reg2 ?    read_mop[1][`mOp1_lsfwd] : WB_fwd[1];

  assign mOp2_thread_o=now_flushing_reg2 && ~WB_fwd[2] ?   read_mop[2][`mOp1_thr] : 1'bz;
  assign mOp2_thread_o=~now_flushing_reg2 && ~WB_fwd[2] ? mOp2_thread : 1'bz;
  assign mOp2_thread_o=WB_fwd[2] ? mOpW_thread : 1'bz;
  assign mOp2_addrEven_o=now_flushing_reg2 && ~WB_fwd[2] ? read_mop[2][`mOp1_addrEven] : 36'bz; 
  assign mOp2_addrEven_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[2] ? mOp2_addrEven : 36'bz;
  assign mOp2_addrEven_o=alt_bus_hold & ~ WB_fwd[2] ? alt_bus_addr[36:1] : 36'bz;
  assign mOp2_addrEven_o=WB_fwd[2] ? mOpW_addrEven : 36'bz;
  assign mOp2_addrOdd_o=now_flushing_reg2 && ~WB_fwd[2] ? read_mop[2][`mOp1_addrOdd] : 36'bz; 
  assign mOp2_addrOdd_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[2] ? mOp2_addrOdd : 36'bz;
  assign mOp2_addrOdd_o=alt_bus_hold & ~ WB_fwd[2] ? alt_bus_addr[36:1] : 36'bz;
  assign mOp2_addrOdd_o=WB_fwd[2] ? mOpW_addrOdd : 36'bz;
  assign mOp2_sz_o=now_flushing_reg2 & ~WB_fwd[2] ?       read_mop[2][`mOp1_sz] : 5'bz; 
  assign mOp2_sz_o=~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_sz : 5'bz; 
  assign mOp2_sz_o=WB_fwd[2] ? mOpW_sz : 5'bz;
  assign mOp2_st_o=now_flushing_reg2 & ~WB_fwd[2] ?       read_mop[2][`mOp1_st] : 1'bz; 
  assign mOp2_st_o=~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_st : 1'bz; 
  assign mOp2_st_o=WB_fwd[2] ? mOpW_st : 1'bz;
  assign mOp2_split_o=now_flushing_reg2 & ~WB_fwd[2] ?    read_mop[2][`mOp1_split] : 1'bz; 
  assign mOp2_split_o=~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_split : 1'bz; 
  assign mOp2_split_o=WB_fwd[2] ? mOpW_split : 1'bz;
  assign mOp2_addr_low_o=now_flushing_reg2 & ~WB_fwd[2] ? read_mop[2][`mOp1_low] : 2'bz;
  assign mOp2_addr_low_o=~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_addr_low : 2'bz; 
  assign mOp2_addr_low_o=WB_fwd[2] ? mOpW_addr_low : 2'bz;
  assign mOp2_odd_o=now_flushing_reg2 & ~WB_fwd[2] ? read_mop[2][`mOp1_odd] : 1'bz; 
  assign mOp2_odd_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[2] ? mOp2_odd : 1'bz;
  assign mOp2_odd_o=alt_bus_hold && ~WB_fwd[2]? alt_bus_addr[2] : 1'bz;
  assign mOp2_odd_o=WB_fwd[2] ? mOpW_odd : 1'bz;
  assign mOp2_banks_o=now_flushing_reg2 && ~WB_fwd[2] ?    read_mop[2][`mOp1_banks] : 32'bz;
  assign mOp2_banks_o=alt_bus_hold && ~WB_fwd[2] ? 32'b0 : 32'bz;
  assign mOp2_banks_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[2] ? mOp2_banks : 32'bz;
  assign mOp2_banks_o=WB_fwd[2] ? mOpW_banks : 32'bz;
  assign mOp2_bank0_o=now_flushing_reg2 & ~WB_fwd[2] ?    read_mop[2][`mOp1_bank0] : 5'bz; 
  assign mOp2_bank0_o=~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_bank0 : 5'bz; 
  assign mOp2_bank0_o=WB_fwd[2] ? mOpW_bank0 : 5'bz;
  assign mOp2_register_o=now_flushing_reg2 && ~WB_fwd[2] ? read_mop[2][`mOp1_regNo] : 9'bz;
  assign mOp2_register_o=alt_bus_hold & ~ WB_fwd[2] ? 9'h1ef : 9'bz;
  assign mOp2_register_o=~alt_bus_hold & ~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_register : 9'bz;
  assign mOp2_register_o=WB_fwd[2] ? mOpW_register : 9'bz;
  assign mOp2_type_o=now_flushing_reg2 && ~WB_fwd[2] ? read_mop[2][`mOp1_type] : 2'bz;
  assign mOp2_type_o=alt_bus_hold & ~WB_fwd[2] ? 2'b0 : 2'bz;
  assign mOp2_type_o=~alt_bus_hold & ~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_type : 2'bz;
  assign mOp2_type_o=WB_fwd[2] ? mOpW_type : 2'bz;
  assign mOp2_en_o=now_flushing_reg2 && ~WB_fwd[2] ?       read_confl[2]&~thrinhibitconfl[2]  : 1'bz;
  assign mOp2_en_o=alt_bus_hold & ~WB_fwd[2] ? 1'b1 : 1'bz;
  assign mOp2_en_o=~now_flushing_reg2 & ~alt_bus_hold & ~WB_fwd[2] ? mOp2_en : 1'bz;
  assign mOp2_en_o=WB_fwd[2] ? mOpW_en : 1'bz;
  assign mOp2_LSQ_o=now_flushing_reg2 & ~WB_fwd[2] ?      read_mop[2][`mOp1_LSQ] : 9'bz; 
  assign mOp2_LSQ_o=~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_LSQ : 9'bz; 
  assign mOp2_LSQ_o=WB_fwd[2] ? mOpW_LSQ : 9'bz;
  assign mOp2_II_o=now_flushing_reg2 & ~WB_fwd[2] ?       read_mop[2][`mOp1_II] : 10'bz; 
  assign mOp2_II_o=~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_II : 10'bz; 
  assign mOp2_II_o=WB_fwd[2] ? mOpW_II : 10'bz;
  assign mOp2_WQ_o=now_flushing_reg2 & ~WB_fwd[2] ?       read_mop[2][`mOp1_WQ] : 8'bz; 
  assign mOp2_WQ_o=~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_WQ : 8'bz; 
  assign mOp2_WQ_o=WB_fwd[2] ? mOpW_WQ : 8'bz;
  assign mOp2_lsflag_o=now_flushing_reg2 & ~WB_fwd[2] ?   read_mop[2][`mOp1_lsf] : 1'bz; 
  assign mOp2_lsflag_o=~now_flushing_reg2 & ~WB_fwd[2] ? mOp2_lsflag : 1'bz; 
  assign mOp2_lsflag_o=WB_fwd[2] ? mOpW_lsflag : 1'bz;
  assign mOp2_lsfwd_o=now_flushing_reg2 ?    read_mop[2][`mOp1_lsfwd] : WB_fwd[2];
  assign mOp2_data_o=now_flushing_reg2 ?     read_dxdata[127+8+5:5] : mOpW_data;
  assign mOp2_pbit_o=now_flushing_reg2 ?     read_dxdata[127+8+5+3:127+8+5+1] : mOpW_data;
  assign mOp2_brdread_o=now_flushing_reg2 ? read_dxdata[4:0] : mOpW_brdread;




  assign mOp3_thread_o=now_flushing_reg2 ?   read_mop[3][`mOp1_thr] : mOp3_thread;
  assign mOp3_addrEven_o=now_flushing_reg2 ? read_mop[3][`mOp1_addrEven] : 36'bz; 
  assign mOp3_addrEven_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp3_addrEven : 36'bz;
  assign mOp3_addrEven_o=alt_bus_hold ? alt_bus_addr[36:1] : 36'bz;
  assign mOp3_addrOdd_o=now_flushing_reg2 ? read_mop[3][`mOp1_addrOdd] : 36'bz; 
  assign mOp3_addrOdd_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp3_addrOdd : 36'bz;
  assign mOp3_addrOdd_o=alt_bus_hold ? alt_bus_addr[36:1] : 36'bz;
  assign mOp3_sz_o=now_flushing_reg2 ?       read_mop[3][`mOp1_sz] : mOp3_sz;
  assign mOp3_st_o=now_flushing_reg2 ?       read_mop[3][`mOp1_st] : mOp3_st;
  assign mOp3_split_o=now_flushing_reg2 ?    read_mop[3][`mOp1_split] : mOp3_split;
  assign mOp3_addr_low_o=now_flushing_reg2 ? read_mop[3][`mOp1_low] : mOp3_addr_low;
  assign mOp3_odd_o=now_flushing_reg2 ? read_mop[3][`mOp1_odd] : 1'bz; 
  assign mOp3_odd_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp3_odd : 1'bz;
  assign mOp3_odd_o=alt_bus_hold ? alt_bus_addr[0] : 1'bz;
  assign mOp3_banks_o=now_flushing_reg2 ?    read_mop[3][`mOp1_banks] : 32'bz;
  assign mOp3_banks_o=alt_bus_hold ? 32'b0 : 32'bz;
  assign mOp3_banks_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp3_banks : 32'bz;
  assign mOp3_bank0_o=now_flushing_reg2 ?    read_mop[3][`mOp1_bank0] : mOp3_bank0;
  assign mOp3_register_o=now_flushing_reg2 ? read_mop[3][`mOp1_regNo] : 9'bz;
  assign mOp3_register_o=alt_bus_hold ? 9'h1ef : 9'bz;
  assign mOp3_register_o=~alt_bus_hold & ~now_flushing_reg2 ? mOp3_register : 9'bz;
  assign mOp3_type_o=now_flushing_reg2 ? read_mop[3][`mOp1_type] : 2'bz;
  assign mOp3_type_o=alt_bus_hold ? 2'b0 : 2'bz;
  assign mOp3_type_o=~alt_bus_hold & ~now_flushing_reg2 ? mOp3_type : 2'bz;
  assign mOp3_en_o=now_flushing_reg2 ?       read_confl[3]&~thrinhibitconfl[3]  : 1'bz;
  assign mOp3_en_o=alt_bus_hold ? 1'b1 : 1'bz;
  assign mOp3_en_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp3_en : 1'bz;;
  assign mOp3_LSQ_o=now_flushing_reg2 ?      read_mop[3][`mOp1_LSQ] : mOp3_LSQ;
  assign mOp3_II_o=now_flushing_reg2 ?       read_mop[3][`mOp1_II] : mOp3_II;
  assign mOp3_WQ_o=now_flushing_reg2 ?       read_mop[3][`mOp1_WQ] : mOp3_WQ;
  assign mOp3_lsflag_o=now_flushing_reg2 ?   read_mop[3][`mOp1_lsf] : mOp3_lsflag;
  assign mOp3_lsfwd_o=now_flushing_reg2 ?    read_mop[3][`mOp1_lsfwd] : mOp3_lsfwd;
  assign mOp3_data_o=now_flushing_reg2 ?     read_dxdata[145+127+8+5:145+5] : mOp3_data;
  assign mOp3_pbit_o=now_flushing_reg2 ?     read_dxdata[145+127+8+5+4:145+128+8+5+1] : mOp3_data;
  assign mOp3_brdbanks_o=now_flushing_reg2 ? read_dxdata[145+4:145] : mOp3_brdbanks;

//  assign mOp4_thread=now_flushing_reg2 ?   read_mop[4][`mOp1_thr] : 1'bz;
  assign mOp4_addrEven_o=now_flushing_reg2 ? read_mop[4][`mOp1_addrEven] : 36'bz; 
  assign mOp4_addrEven_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp4_addrEven : 36'bz;
  assign mOp4_addrEven_o=alt_bus_hold ? alt_bus_addr[36:1] : 36'bz;
  assign mOp4_addrOdd_o=now_flushing_reg2 ? read_mop[4][`mOp1_addrOdd] : 36'bz; 
  assign mOp4_addrOdd_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp4_addrOdd : 36'bz;
  assign mOp4_addrOdd_o=alt_bus_hold ? alt_bus_addr[36:1] : 36'bz;
  assign mOp4_sz_o=now_flushing_reg2 ?       read_mop[4][`mOp1_sz] : mOp4_sz;
//  assign mOp4_first_o=now_flushing_reg2 ?    read_mop[4][`mOp1_st] : mOp4_first;
  assign mOp4_split_o=now_flushing_reg2 ?    read_mop[4][`mOp1_split] : mOp4_split;
  assign mOp4_odd_o=now_flushing_reg2 ? read_mop[4][`mOp1_odd] : 1'bz; 
  assign mOp4_odd_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp4_odd : 1'bz;
  assign mOp4_odd_o=alt_bus_hold ? alt_bus_addr[0] : 1'bz;
  assign mOp4_addr_low_o=now_flushing_reg2 ? read_mop[4][`mOp1_low] : mOp4_addr_low;
  assign mOp4_bank0_o=now_flushing_reg2 ?    read_mop[4][`mOp1_bank0] : mOp4_bank0;
  assign mOp4_banks_o=now_flushing_reg2 ?    bank4 : 32'bz;
  assign mOp4_banks_o=alt_bus_hold ? 32'hffff_ffff : 32'bz;
  assign mOp4_banks_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp4_banks : 32'bz;
  assign mOp4_data_o=now_flushing_reg2 ? {read_ddata[127:0],read_mop[4][`mOp1_banks]} : mOp4_data;
  assign mOp4_type_o=now_flushing_reg2 ? read_mop[4][`mOp1_type] : 2'bz;
  assign mOp4_type_o=alt_bus_hold ? 2'b0 : 2'bz;
  assign mOp4_type_o=~alt_bus_hold & ~now_flushing_reg2 ? mOp4_type : 2'bz;
  assign mOp4_en_o=now_flushing_reg2 ?       read_confl[4]&~thrinhibitconfl[4]  : 1'bz;
  assign mOp4_en_o=alt_bus_hold ? 1'b0 : 1'bz;
  assign mOp4_en_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp4_en : 1'bz;;
  assign {mOp4_pbit_o,mOp4_dupl_dummy,mOp4_bank1_o}=now_flushing_reg2 ?    read_mop[4][`mOp1_LSQ] : {mOp4_pbit,2'b0,mOp4_bank1};
  assign mOp4_II_o=now_flushing_reg2 ?       read_mop[4][`mOp1_II] : mOp4_II;
  assign {mOp4_bgn_b_o,mOp4_end_b_o}=now_flushing_reg2 ? read_mop[4][`mOp1_WQ] : 8'bz;
  assign {mOp4_bgn_b_o,mOp4_end_b_o}=alt_bus_hold ? 8'hff : 8'bz;
  assign {mOp4_bgn_b_o,mOp4_end_b_o}=~now_flushing_reg2 & ~alt_bus_hold ? {mOp4_bgn_b,mOp4_end_b} : 8'bz;

//  assign mOp5_thread=now_flushing_reg2 ?   read_mop[5][`mOp1_thr] : 1'bz;
  assign mOp5_addrEven_o=now_flushing_reg2 ? read_mop[5][`mOp1_addrEven] : 36'bz; 
  assign mOp5_addrEven_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp5_addrEven : 36'bz;
  assign mOp5_addrEven_o=alt_bus_hold ? alt_bus_addr[36:1] : 36'bz;
  assign mOp5_addrOdd_o=now_flushing_reg2 ? read_mop[5][`mOp1_addrOdd] : 36'bz; 
  assign mOp5_addrOdd_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp5_addrOdd : 36'bz;
  assign mOp5_addrOdd_o=alt_bus_hold ? alt_bus_addr[36:1] : 36'bz;
  assign mOp5_sz_o=now_flushing_reg2 ?       read_mop[5][`mOp1_sz] : mOp5_sz;
//  assign mOp5_first_o=now_flushing_reg2 ?    read_mop[5][`mOp1_st] : mOp5_first;
  assign mOp5_split_o=now_flushing_reg2 ?    read_mop[5][`mOp1_split] : mOp5_split;
  assign mOp5_odd_o=now_flushing_reg2 ? read_mop[5][`mOp1_odd] : 1'bz; 
  assign mOp5_odd_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp5_odd : 1'bz;
  assign mOp5_odd_o=alt_bus_hold ? alt_bus_addr[0] : 1'bz;
  assign mOp5_addr_low_o=now_flushing_reg2 ? read_mop[5][`mOp1_low] : mOp5_addr_low;
  assign mOp5_bank0_o=now_flushing_reg2 ?    read_mop[5][`mOp1_bank0] : mOp5_bank0;
  assign mOp5_banks_o=now_flushing_reg2 ?    bank5 : 32'bz;
  assign mOp5_banks_o=alt_bus_hold ? 32'b0 : 32'bz;
  assign mOp5_banks_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp5_banks : 32'bz;
  assign mOp5_data_o=now_flushing_reg2 ? {read_ddata[255:128],read_mop[5][`mOp1_banks]} : mOp5_data;
  assign mOp5_type_o=now_flushing_reg2 ? read_mop[5][`mOp1_type] : 2'bz;
  assign mOp5_type_o=alt_bus_hold ? 2'b0 : 2'bz;
  assign mOp5_type_o=~alt_bus_hold & ~now_flushing_reg2 ? mOp5_type : 2'bz;
  assign mOp5_en_o=now_flushing_reg2 ?       read_confl[5]&~thrinhibitconfl[5]  : 1'bz;
  assign mOp5_en_o=alt_bus_hold ? 1'b0 : 1'bz;
  assign mOp5_en_o=~now_flushing_reg2 & ~alt_bus_hold ? mOp5_en : 1'bz;;
  assign {mOp5_pbit_o,mOp5_dupl_dummy,mOp5_bank1_o}=now_flushing_reg2 ?    read_mop[5][`mOp1_LSQ] : {mOp5_pbit,2'b0,mOp5_bank1};
  assign mOp5_II_o=now_flushing_reg2 ?       read_mop[5][`mOp1_II] : mOp5_II;
  assign {mOp5_bgn_b_o,mOp5_end_b_o}=now_flushing_reg2 ? read_mop[5][`mOp1_WQ] : 8'bz;
  assign {mOp5_bgn_b_o,mOp5_end_b_o}=alt_bus_hold ? 8'hff : 8'bz;
  assign {mOp5_bgn_b_o,mOp5_end_b_o}=~now_flushing_reg2 & ~alt_bus_hold ? {mOp5_bgn_b,mOp5_end_b} : 8'bz;

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
  assign write_mop[0][`mOp1_type]=    mOp0_type_reg[3];
  assign write_mop[0][`mOp1_LSQ]=     mOp0_LSQ_reg[3];
  assign write_mop[0][`mOp1_II]=      mOp0_II_reg[3];
  assign write_mop[0][`mOp1_WQ]=      mOp0_WQ_reg[3];
  assign write_mop[0][`mOp1_lsf]=     mOp0_lsflag_reg[3];
  assign write_mop[0][`mOp1_lsfwd]=   mOp0_lsfwd_reg[3];

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
  assign write_mop[1][`mOp1_type]=    mOp1_type_reg[3];
  assign write_mop[1][`mOp1_LSQ]=     mOp1_LSQ_reg[3];
  assign write_mop[1][`mOp1_II]=      mOp1_II_reg[3];
  assign write_mop[1][`mOp1_WQ]=      mOp1_WQ_reg[3];
  assign write_mop[1][`mOp1_lsf]=     mOp1_lsflag_reg[3];
  assign write_mop[1][`mOp1_lsfwd]=   mOp1_lsfwd_reg[3];

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
  assign write_mop[2][`mOp1_type]=    mOp2_type_reg[3];
  assign write_mop[2][`mOp1_LSQ]=     mOp2_LSQ_reg[3];
  assign write_mop[2][`mOp1_II]=      mOp2_II_reg[3];
  assign write_mop[2][`mOp1_WQ]=      mOp2_WQ_reg[3];
  assign write_mop[2][`mOp1_lsf]=     mOp2_lsflag_reg[3];
  assign write_mop[2][`mOp1_lsfwd]=   mOp2_lsfwd_reg[3];

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
  assign write_mop[3][`mOp1_type]=    mOp3_type_reg[3];
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
  assign write_mop[4][`mOp1_type]=    mOp4_type_reg[3];
  assign write_mop[4][`mOp1_clHit]=   mOp4_clHit;
  assign write_mop[4][`mOp1_LSQ]=     {mOp4_pbit_reg[3],mOp4_dupl,mOp4_bank1_reg[3]};
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
  assign write_mop[5][`mOp1_type]=    mOp5_type_reg[3];
  assign write_mop[5][`mOp1_clHit]=   mOp5_clHit;
  assign write_mop[5][`mOp1_LSQ]=     {mOp5_pbit_reg[3],mOp5_dupl,mOp5_bank1_reg[3]};
  assign write_mop[5][`mOp1_II]=      mOp5_II_reg[3];
  assign write_mop[5][`mOp1_WQ]=      {mOp5_bgn_b_reg[3],mOp5_end_b_reg[3]};
  assign write_mop[5][`mOp1_lsfwd]=   1'b0;


  assign mOpR_en=conflFound && ~init && ~count0[0] && ~now_flushing_reg2 && ~begin_flush_reg2;

  assign mOpR_addrEven=(!conflFound) ? {PADDR_WIDTH-8{1'B0}} : {PADDR_WIDTH-8{1'BZ}};
  assign mOpR_addrOdd=(!conflFound) ? {PADDR_WIDTH-8{1'B0}} : {PADDR_WIDTH-8{1'BZ}};
  assign mOpR_sz=(!conflFound) ? 5'B0 : 5'BZ;
  assign mOpR_st=(!conflFound) ? 1'B0 : 1'BZ;
  assign mOpR_split=(!conflFound) ? 1'B0 : 1'BZ;
  assign mOpR_odd=(!conflFound) ? 1'B0 : 1'BZ;
  assign mOpR_addr_low=(!conflFound) ? 2'B0 : 2'BZ;
//  assign mOpR_banks=(!conflFound) ? 32'b0 : 32'BZ;
  assign mOpR_bank0=(!conflFound) ? 5'b0 : 5'BZ;
  assign mOpR_io=(!conflFound) ? 1'B0 : 1'BZ;
  assign mOpR_clHit=(!conflFound) ? 2'b0 : 2'BZ;
//  assign mOpR_first=(!conflFound) ? 1'b0 : 1'BZ;
  assign mOpR_dupl=(!conflFound) ? 2'b0 : 2'BZ;
  
  assign curConfl=read_confl&confl_mask;

  //assign rdwr_match2=read_addr==write_addr_end;
  //assign rdwr_match=countF==5'd1;
  assign flush_end=now_flushing_reg2 ? count1[2:0]!=0 && now_flushing : (countR[2:1]!=0) & now_flushing_reg & (~wen|countR[1]) || 
	  (countR[1:0]!=0) & now_flushing & ~now_flushing_reg & ~wen;// && ~wen|countR[0];
//  assign flush_end=now_flushing_reg2 ? count1[2] && now_flushing : (countR[2:1]!=0) & now_flushing_reg || 
//	  countR[1] & now_flushing & ~now_flushing_reg;// && ~wen|countR[0];
//need to take care of case with only one flush
  //assign flush_end_else=count0[1] && now_flushing && ~wen;
  assign mOp_write_clear=begin_flush_reg;
  assign nowfl=now_flushing_reg2;

  generate
    for(k=0;k<=5;k=k+1)  begin
        assign mOpR_addrEven=sel[k] ? read_mop[k][`mOp1_addrEven] : {PADDR_WIDTH-8{1'BZ}};
        assign mOpR_addrOdd=sel[k] ? read_mop[k][`mOp1_addrOdd] : {PADDR_WIDTH-8{1'BZ}};
        assign mOpR_sz=sel[k] ? read_mop[k][`mOp1_sz] : 5'BZ;
        assign mOpR_st=sel[k] ? read_mop[k][`mOp1_st] : 1'BZ;
  //      assign mOpR_first=sel[k] ? read_mop[k][`mOp1_st] : 1'BZ;
        assign mOpR_split=sel[k] ? read_mop[k][`mOp1_split] : 1'BZ;
        assign mOpR_odd=sel[k] ? read_mop[k][`mOp1_odd] : 1'BZ;
        assign mOpR_addr_low=sel[k] ? read_mop[k][`mOp1_low] : 2'BZ;
    //    assign mOpR_banks=sel[k] ? read_mop[k][`mOp1_banks] : 32'BZ;
        assign mOpR_bank0=sel[k] ? read_mop[k][`mOp1_bank0] : 5'BZ;
	assign mOpR_io=sel[k] ? read_mop[k][`mOp1_type]==2'b10 : 1'BZ;
        assign mOpR_clHit=sel[k] ? read_mop[k][`mOp1_clHit] : 2'BZ;
        if (k>=4)
          /* verilator lint_off WIDTH */
          assign {mOpR_dupl,dummy5}=sel[k] ? read_mop[k][`mOp1_LSQ] : 9'bz;
          /* verilator lint_on WIDTH */
        else
          assign mOpR_dupl=sel[k] ? 2'b0 : 2'bz;
        if (k<4) assign rdbanks[k]=read_mop[k][`mOp1_banks] & {32{read_confl[k]}};        
    end

    genvar p;
    for(p=0;p<16;p=p+1) begin
	assign read_addrA_d=(rdvalid0[p] || rdvalid1[p] & ~rdvalid0_found)
          ? p[3:0] : 4'bz;
	assign read_addrB_d=(rdvalidR0[p] || rdvalidR1[p] & ~rdvalidR0_found)
          ? p[3:0] : 4'bz;
	assign read_addrEA_d=(rdvalidEA0[p] || rdvalidEA1[p] & ~rdvalidEA0_found)
          ? p[3:0] : 4'bz;
	assign read_addrEB_d=(rdvalidEB0[p] || rdvalidEB1[p] & ~rdvalidEB0_found)
          ? p[3:0] : 4'bz;
	assign read_addrRA_d=(rdvalidRA0[p] || rdvalidRA1[p] & ~rdvalidRA0_found)
          ? p[3:0] : 4'bz;
	assign read_addrRB_d=(rdvalidRB0[p] || rdvalidRB1[p] & ~rdvalidRB0_found)
          ? p[3:0] : 4'bz;
    end
    assign read_addrRA_d=~rdvalidRA0_found && ~rdvalidRA1_found
      ? write_addr : 4'bz;
    assign read_addrRB_d=~rdvalidRB0_found && ~rdvalidRB1_found
      ? write_addr : 4'bz;

    assign read_addrEA_d=~rdvalidEA0_found && ~rdvalidEA1_found
      ? write_addr : 4'bz;
    assign read_addrEB_d=~rdvalidEB0_found && ~rdvalidEB1_found
      ? write_addr : 4'bz;

    assign read_addrA_d=~rdvalid0_found && ~rdvalid1_found
      ? write_addr : 4'bz;
    assign read_addrB_d=~rdvalidR0_found && ~rdvalidR1_found
      ? write_addr : 4'bz;

    
  endgenerate
  
 // adder_inc #(4) read_inc_mod(read_addr,read_addr_d,doStep &~begin_flush_reg2 &~rst,);
  adder_inc #(4) write_inc_mod(write_addr,write_addr_d,wen&~rst,);
//  adder_inc #(5) count_inc_mod(count,count_d,~now_flushing & wen & ~rst);
//  adder #(5) count_dec_mod(count,5'b11111,count_d,1'b0,now_flushing & ~wen & ~rst);
  //adder #(4) wrEndAdd_mod(write_addr,4'hf,write_addr_end_d,1'b0,1'b1);
//  adder #(5) coundF_dec_mod(countF,5'b11111,countF_d,1'b0,1'b1); 
  adder_inc #(4) initAdd_mod(initCount,initCount_next,1'b1,);

  bit_find_first_bit #(16) rdfirst0_mod((valid[0]|valid[1])&vMask,rdvalid0,rdvalid0_found);
  bit_find_first_bit #(16) rdfirst1_mod((valid[0]|valid[1])&vMaskN,rdvalid1,rdvalid1_found);
  bit_find_first_bit #(16) rdfirstR0_mod((validR[0]|validR[1])&vMaskR,rdvalidR0,rdvalidR0_found);
  bit_find_first_bit #(16) rdfirstR1_mod((validR[0]|validR[1])&vMaskRN,rdvalidR1,rdvalidR1_found);
  bit_find_first_bit #(16) rdfirstEA0_mod((valid[0]|validS[1])&vMask,rdvalidEA0,rdvalidEA0_found);
  bit_find_first_bit #(16) rdfirstEA1_mod((valid[0]|validS[1])&vMaskN,rdvalidEA1,rdvalidEA1_found);
  bit_find_first_bit #(16) rdfirstEB0_mod((validS[0]|valid[1])&vMask,rdvalidEB0,rdvalidEB0_found);
  bit_find_first_bit #(16) rdfirstEB1_mod((validS[0]|valid[1])&vMaskN,rdvalidEB1,rdvalidEB1_found);
  bit_find_first_bit #(16) rdfirstRA0_mod((validR[0]|validSR[1])&vMaskR,rdvalidRA0,rdvalidRA0_found);
  bit_find_first_bit #(16) rdfirstRA1_mod((validR[0]|validSR[1])&vMaskRN,rdvalidRA1,rdvalidRA1_found);
  bit_find_first_bit #(16) rdfirstRB0_mod((validSR[0]|validR[1])&vMaskR,rdvalidRB0,rdvalidRB0_found);
  bit_find_first_bit #(16) rdfirstRB1_mod((validSR[0]|validR[1])&vMaskRN,rdvalidRB1,rdvalidRB1_found);

//  popcnt16 cntMod(valid[0]|valid[1]|validR[0]|validR[1],count);
  popcnt16_or_more cntM_mod(valid[0]|valid[1]&~(vMask|vMaskN),cmore);
  popcnt16 cntMod0(valid[0]|valid[1]&(vMask|vMaskN),count0);
  popcnt16 cntMod1((valid[0]|valid[1])&~(validR[0]|validR[1])&(vMask|vMaskN),count1);
  popcnt16 cntModR(validR[0]|validR[1]&(vMaskR|vMaskRN),countR);
  
  bit_find_first_bit #(6) findConfl_mod(curConfl,sel,conflFound);

  assign doSkip_d=cmore[STALL_COUNT];
//  adder #(4) write_dec_mod(write_addr,4'hf,write_addr_dec,1'b0,1'b1);
  

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

  missQ_datax_ram ramXD_mod(
  clk,
  rst,
  doStep|begin_flush_reg2,
  read_addr_d,
  read_dxdata,
  init ? initCount : write_addr,
  write_dxdata,
  wen|init
  );

  assign doStep=now_flushing_reg2 || ((curConfl==6'b0001 || curConfl==6'b0010 || curConfl==6'b0100 || curConfl==6'b1000 ||
    curConfl==6'b10000 || curConfl==6'b100000) && read_clkEn && ~count1[0]) || except;

  assign read_addr_d=(begin_flush_reg2 || ~rdvalid0_found & ~ rdvalid1_found) & ~except ? read_addrB_d : 4'bz;
  assign read_addr_d=(~begin_flush_reg2 && rdvalid0_found | rdvalid1_found) & ~ except ? read_addrA_d : 4'bz;
  assign read_addr_d=(begin_flush_reg2 || ~rdvalidEA0_found & ~ rdvalidEA1_found) & except & excpt_thread ? read_addrRA_d : 4'bz;
  assign read_addr_d=(begin_flush_reg2 || ~rdvalidEB0_found & ~ rdvalidEB1_found) & except &~excpt_thread ? read_addrRB_d : 4'bz;
  assign read_addr_d=(~begin_flush_reg2 && rdvalidEA0_found | rdvalidEA1_found) & except & excpt_thread ? read_addrEA_d : 4'bz;
  assign read_addr_d=(~begin_flush_reg2 && rdvalidEB0_found | rdvalidEB1_found) & except &~excpt_thread ? read_addrEB_d : 4'bz;

  always @* begin
      stepOver4=read_mop[4][`mOp1_low]!=2'd0;
      stepOver5=read_mop[5][`mOp1_low]!=2'd0;
      stepOver42=read_mop[4][`mOp1_low]==2'd3;
      stepOver52=read_mop[5][`mOp1_low]==2'd3;
  end
   
  always @* begin
      sz4=read_mop[4][`mOp1_sz];
      sz5=read_mop[5][`mOp1_sz];
      case(sz4)
         5'd16: opsize4=0;
         5'd17: opsize4=1;
         5'd18: opsize4=2;
         5'd19: opsize4=3;
         5'h3:  opsize4=4; //long double
         5'h4,5'h5,5'h9,5'hd:  opsize4=3; //double
         5'h6,5'h7,5'h8:  opsize4=2; //single
	 5'hf: opsize4=6;
	 default: opsize4=5; //128 bit
      endcase
      case(sz5)
         5'd16: opsize5=0;
         5'd17: opsize5=1;
         5'd18: opsize5=2;
         5'd19: opsize5=3;
         5'h3:  opsize5=4; //long double
         5'h4,5'h5,5'h9,5'hd:  opsize5=3; //double
         5'h6,5'h7,5'h8:  opsize5=2; //single
	 5'hf: opsize5=6;
	 default: opsize5=5; //128 bit
      endcase
  /* verilator lint_off WIDTH */
      for(q=0;q<32;q=q+1) begin
          bank4[q]=read_mop[4][`mOp1_bank0]==q[4:0] || 
          ((opsize4==3 || opsize4[2] || (stepOver4 && opsize4==2) || 
            (stepOver42 && opsize4==1)) && read_mop[4][`mOp1_bank0]==((q-1)&5'h1f)) ||
          (((opsize4==3 && stepOver4) | opsize4[2]) && read_mop[4][`mOp1_bank0]==((q-2)&5'h1f)) || 
          (((opsize4==4 && stepOver42) || opsize4==5 || opsize4==6) && read_mop[4][`mOp1_bank0]==((q-3)&5'h1f)) ||
          (((opsize4==5 && stepOver4)||opsize4==6) && read_mop[4][`mOp1_bank0]==((q-4)&5'h1f)) ;
          bank5[q]=read_mop[5][`mOp1_bank0]==q[4:0] || 
          ((opsize5==3 || opsize5[2] || (stepOver5 && opsize5==2) || 
            (stepOver52 && opsize5==1)) && read_mop[5][`mOp1_bank0]==((q-1)&5'h1f)) ||
          (((opsize5==3 && stepOver5) | opsize5[2]) && read_mop[5][`mOp1_bank0]==((q-2)&5'h1f)) || 
          (((opsize5==4 && stepOver52) || opsize5==5 || opsize5==6) && read_mop[5][`mOp1_bank0]==((q-3)&5'h1f)) ||
          (((opsize5==5 && stepOver5) || opsize5==6) && read_mop[5][`mOp1_bank0]==((q-4)&5'h1f)) ;
      end
      /* verilator lint_on WIDTH */
  end
  
  always @(posedge clk)
    begin
	  if (rst) begin
	      confl_mask<=6'b111111;
	  end else if (flush_end|doStep) begin
	      confl_mask<=6'b111111;
	  end else begin
	      if (count0[0] && wen) confl_mask<=6'h3f;
	      else if (cmore[1] && read_clkEn) confl_mask<=confl_mask&~sel;
	  end
          if (rst) read_addr<=4'b0;
	  else read_addr<=read_addr_d;
	  write_addr<=write_addr_d;
/*	  if (rst) begin
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
*/
          if (now_flushing_reg2) $display("flR ",read_addr," ",read_addr_d," ",valid[0],"&<",vMask);
	  if (wen) $display("flW ",write_addr," ",valid[0],"&<",vMask);
	  if (rst) begin
	      validR[0]=16'b0;
	      validR[1]=16'b0;
	      validSR[0]=16'b0;
	      validSR[1]=16'b0;
	      vOn_nextR=1'b0;
	      vMaskR=16'b0;
	      vMaskRN=16'b0;
	      valid[0]=16'b0;
	      valid[1]=16'b0;
	      validS[0]=16'b0;
	      validS[1]=16'b0;
	      valid_rd=16'b0;
	      vOn_next=1'b0;
	      vMask=16'b0;
	      vMaskN=16'b0;
	      pwned=1'b0;
	  end else begin
              pwned=1'b0;
	     if (except) begin
	         valid[0]=validS[0];
		 valid_rd=16'b0;
	     end
	     if (except) begin
                 validR[0]=validSR[0];
	     end
	      if (wen) begin
		  if (miss0 & ~thrreginh[3][0] & ~except||
                      miss1 & ~thrreginh[3][1] & ~except||
                      miss2 & ~thrreginh[3][2] & ~except||
                      miss3 & ~thrreginh[3][3] & ~(except && write_mop[3][`mOp1_regNo]!=9'h1fc)||
                      miss4 & ~thrreginh[3][4]||
                      miss5 & ~thrreginh[3][5]
		    )
	            valid[0][write_addr]=1'b1;
		  if (miss0 & ~thrreginh[3][0] & ~except||
                      miss1 & ~thrreginh[3][1] & ~except||
                      miss2 & ~thrreginh[3][2] & ~except||
                      miss3 & ~thrreginh[3][3] & ~(except && write_mop[3][`mOp1_regNo]!=9'h1fc)||
                      miss4 & ~thrreginh[3][4]||
                      miss5 & ~thrreginh[3][5]
		    )
	            valid_rd[write_addr]=1'b1;
		  if (
                     write_mop[3][`mOp1_regNo]==9'h1fc && miss3 & ~thrreginh[3][3]||
		     miss4 & ~thrreginh[3][4]||
                     miss5 & ~thrreginh[3][5]
		    )
	            validS[0][write_addr]=1'b1;
		  if (miss0 & ~thrreginh[3][0] & ~except||
                      miss1 & ~thrreginh[3][1] & ~except||
                      miss2 & ~thrreginh[3][2] & ~except||
                      miss3 & ~thrreginh[3][3] & ~(except && write_mop[3][`mOp1_regNo]!=9'h1fc)||
                      miss4 & ~thrreginh[3][4]||
                      miss5 & ~thrreginh[3][5]
		    )
	            validR[0][write_addr]=1'b1;
		  if (
                     write_mop[3][`mOp1_regNo]==9'h1fc && miss3 & ~thrreginh[3][3]||
                     miss4 & ~thrreginh[3][4]||
                     miss5 & ~thrreginh[3][5]
		    )
	            validSR[0][write_addr]=1'b1;
		  if (vMask!=0&&write_addr==0) begin
		        vMaskN=16'b1;
			vOn_next=1'b1;
			if (doStep&&~rdvalid0_found&&vMaskN!=0) begin
			    vMask=16'b1;
			    vOn_next=1'b0;
			    vMaskN=0;
			end
		  end else begin
		        if (vOn_next) vMaskN[write_addr]=1'b1;
		        else vMask[write_addr]=1'b1;
		        if (doStep) begin
		           if (~rdvalid0_found && vMaskN!=0) begin
				vOn_next=1'b0;
				vMask=vMaskN;
				vMaskN=0;
			    end
			end
		  end
		  if (vMaskR!=0&&write_addr==0) begin
		        vMaskRN=16'b1;
			vOn_nextR=1'b1;
		  end else begin
		        if (vOn_nextR) vMaskRN[write_addr]=1'b1;
		        else vMaskR[write_addr]=1'b1;
		  end
	          if (begin_flush_reg2) begin
			vMask=vMaskR;
			vMaskN=vMaskRN;
			valid[0]=validR[0]&~(rdvalidR0 | (rdvalidR1 & {16{~rdvalidR0_found}}));
			valid[1]=validR[1]&~(rdvalidR0 | (rdvalidR1 & {16{~rdvalidR0_found}}));
			vOn_next=vOn_nextR;
			if (validR[0]==16'b0) pwned=1'b1;
			validR[0]=16'b0;
			validR[1]=16'b0;
		        validSR[0]=16'b0;
		        validSR[1]=16'b0;
		        vMaskR=0;
		        vMaskRN=0;
			vOn_nextR=0;
		  end
	      end else begin
	          if (doStep) begin
	              if (~rdvalid0_found && vMaskN!=0) begin
	                  vOn_next=1'b0;
			  vMask=vMaskN;
			  vMaskN=0;
		     end
		  end
	          if (begin_flush_reg2) begin
		      vMask=vMaskR;
		      vMaskN=vMaskRN;
		      valid[0]=validR[0]&~(rdvalidR0 | (rdvalidR1 & {16{~rdvalidR0_found}}));
		      valid[1]=validR[1]&~(rdvalidR0 | (rdvalidR1 & {16{~rdvalidR0_found}}));
		      if (validR[0]==16'b0) pwned=1'b1;
		      vOn_next=vOn_nextR;
		      validR[0]=16'b0;
		      validR[1]=16'b0;
		      validSR[0]=16'b0;
		      validSR[1]=16'b0;
		      vMaskR=0;
		      vMaskRN=0;
	              vOn_nextR=0;
		  end
		  //usign    
	     end
             if (doStep && ~begin_flush_reg2) begin
	          valid[0][read_addr_d]=1'b0;
	          valid[1][read_addr_d]=1'b0;
	          validS[0][read_addr_d]=1'b0;
	          validS[1][read_addr_d]=1'b0;
		  if (now_flushing_reg2) begin
		      vMask[read_addr]=1'b0;
		      vMaskR[read_addr]=1'b0;
		  end
	     end 
	  end
	  
          if (rst) doSkip<=1'b0;
	  else if (doSkip_d || last_inserted) doSkip<=1'b1;
	  else if (flush_end|~locked && ~doSkip_d) doSkip<=1'b0;
	  
	  if (rst) begin
              //countF<=5'd0;
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
              //else if (now_flushing && ~(wen && begin_flush_reg|begin_flush_reg2)) countF<=countF_d;
	      if (begin_flush) now_flushing<=1'b1;
	      else if (flush_end|pwned) now_flushing<=1'b0;
	      begin_flush_reg<=begin_flush;
	      begin_flush_reg2<=begin_flush_reg;
	      now_flushing_reg<=now_flushing&~pwned&~(now_flushing_reg2&&count1[1:0]!=0);
	      now_flushing_reg2<=now_flushing_reg&~pwned&~(now_flushing_reg2&&count1[0]);
	      if (now_flushing_reg&pwned) $display("flX ",read_addr_d,validR[0]);
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
                  mOp0_type_reg[r]<=2'b0;
                  mOp0_LSQ_reg[r]<=9'b0;
                  mOp0_II_reg[r]<=10'b0;
                  mOp0_WQ_reg[r]<=8'b0;
                  mOp0_lsflag_reg[r]<=1'b0;
		  mOp0_lsfwd_reg[r]<=1'b0;

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
                  mOp1_type_reg[r]<=2'b0;
                  mOp1_LSQ_reg[r]<=9'b0;
                  mOp1_II_reg[r]<=10'b0;
                  mOp1_WQ_reg[r]<=8'b0;
                  mOp1_lsflag_reg[r]<=1'b0;
		  mOp1_lsfwd_reg[r]<=1'b0;
                  
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
                  mOp2_type_reg[r]<=2'b0;
                  mOp2_LSQ_reg[r]<=9'b0;
                  mOp2_II_reg[r]<=10'b0;
                  mOp2_WQ_reg[r]<=8'b0;
                  mOp2_lsflag_reg[r]<=1'b0;
		  mOp2_lsfwd_reg[r]<=1'b0;
                  mOp2_data_reg[r]<={8'b0,128'b0};
                  mOp2_pbit_reg[r]<=2'b0;
		  mOp2_brdread_reg[r]<=5'b0;
                  
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
                  mOp3_type_reg[r]<=2'b0;
                  mOp3_LSQ_reg[r]<=9'b0;
                  mOp3_II_reg[r]<=10'b0;
                  mOp3_WQ_reg[r]<=8'b0;
                  mOp3_lsflag_reg[r]<=1'b0;
                  mOp3_data_reg[r]<={8'b0,128'b0};
                  mOp3_pbit_reg[r]<=2'b0;
		  mOp3_lsfwd_reg[r]<=1'b0;
		  mOp3_brdbanks_reg[r]<=5'b0;

                  mOp4_addrEven_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp4_addrOdd_reg[r]<={PADDR_WIDTH-8{1'B0}};
                  mOp4_sz_reg[r]<=5'B0;
                  mOp4_first_reg[r]<=1'B0;
                  mOp4_bank0_reg[r]<=5'B0;
                  mOp4_odd_reg[r]<=1'B0;
                  mOp4_addr_low_reg[r]<=2'B0;
                  mOp4_split_reg[r]<=1'B0;
                  mOp4_data_reg[r]<=160'b0;
                  mOp4_pbit_reg[r]<=2'b0;
                  mOp4_bank1_reg[r]<=5'b0;
                  mOp4_type_reg[r]<=2'b0;
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
                  mOp5_pbit_reg[r]<=2'b0;
                  mOp5_bank1_reg[r]<=5'b0;
                  mOp5_type_reg[r]<=2'b0;
                  mOp5_II_reg[r]<=10'b0;
                  mOp5_bgn_b_reg[r]<=4'b0;
                  mOp5_end_b_reg[r]<=4'b0;

                  thrreginh[r]<=6'b0;
	      end
	  end else begin
              thrreginh[1][0]<=1'b0;
	      mOp0_thread_reg[1]<=mOp0_thread_o;
              mOp0_addrEven_reg[1]<=mOp0_addrEven_o;
              mOp0_addrOdd_reg[1]<=mOp0_addrOdd_o;
              mOp0_sz_reg[1]<=mOp0_sz_o;
              mOp0_st_reg[1]<=mOp0_st_o;
              mOp0_banks_reg[1]<=mOp0_banks_o;
              mOp0_bank0_reg[1]<=mOp0_bank0_o;
              mOp0_odd_reg[1]<=mOp0_odd_o;
              mOp0_addr_low_reg[1]<=mOp0_addr_low_o;
              mOp0_split_reg[1]<=mOp0_split_o;
              mOp0_register_reg[1]<=mOp0_register_o;
              mOp0_LSQ_reg[1]<=mOp0_LSQ_o;
              mOp0_type_reg[1]<=mOp0_type_o;
              mOp0_II_reg[1]<=mOp0_II_o;
              mOp0_WQ_reg[1]<=mOp0_WQ_o;
              mOp0_lsflag_reg[1]<=mOp0_lsflag_o;
              mOp0_lsfwd_reg[1]<=mOp0_lsfwd_o;

              thrreginh[1][1]<=1'b0;
	      mOp1_thread_reg[1]<=mOp1_thread_o;
              mOp1_addrEven_reg[1]<=mOp1_addrEven_o;
              mOp1_addrOdd_reg[1]<=mOp1_addrOdd_o;
              mOp1_sz_reg[1]<=mOp1_sz_o;
              mOp1_st_reg[1]<=mOp1_st_o;
              mOp1_banks_reg[1]<=mOp1_banks_o;
              mOp1_bank0_reg[1]<=mOp1_bank0_o;
              mOp1_odd_reg[1]<=mOp1_odd_o;
              mOp1_addr_low_reg[1]<=mOp1_addr_low_o;
              mOp1_split_reg[1]<=mOp1_split_o;
              mOp1_register_reg[1]<=mOp1_register_o;
              mOp1_LSQ_reg[1]<=mOp1_LSQ_o;
              mOp1_type_reg[1]<=mOp1_type_o;
              mOp1_II_reg[1]<=mOp1_II_o;
              mOp1_WQ_reg[1]<=mOp1_WQ_o;
              mOp1_lsflag_reg[1]<=mOp1_lsflag_o;
              mOp1_lsfwd_reg[1]<=mOp1_lsfwd_o;

              thrreginh[1][2]<=1'b0;
	      mOp2_thread_reg[1]<=mOp2_thread_o;
              mOp2_addrEven_reg[1]<=mOp2_addrEven_o;
              mOp2_addrOdd_reg[1]<=mOp2_addrOdd_o;
              mOp2_sz_reg[1]<=mOp2_sz_o;
              mOp2_st_reg[1]<=mOp2_st_o;
              mOp2_banks_reg[1]<=mOp2_banks_o;
              mOp2_bank0_reg[1]<=mOp2_bank0_o;
              mOp2_odd_reg[1]<=mOp2_odd_o;
              mOp2_addr_low_reg[1]<=mOp2_addr_low_o;
              mOp2_split_reg[1]<=mOp2_split_o;
              mOp2_register_reg[1]<=mOp2_register_o;
              mOp2_LSQ_reg[1]<=mOp2_LSQ_o;
              mOp2_type_reg[1]<=mOp2_type_o;
              mOp2_II_reg[1]<=mOp2_II_o;
              mOp2_WQ_reg[1]<=mOp2_WQ_o;
              mOp2_lsflag_reg[1]<=mOp2_lsflag_o;
              mOp2_lsfwd_reg[1]<=mOp2_lsfwd_o;
              mOp2_data_reg[1]<=mOp2_data_o;
              mOp2_pbit_reg[1]<=mOp2_pbit_o;
              mOp2_brdread_reg[1]<=mOp2_brdread_o;
              
              thrreginh[1][3]<=1'b0;
	      mOp3_thread_reg[1]<=mOp3_thread_o;
              mOp3_addrEven_reg[1]<=mOp3_addrEven_o;
              mOp3_addrOdd_reg[1]<=mOp3_addrOdd_o;
              mOp3_sz_reg[1]<=mOp3_sz_o;
              mOp3_st_reg[1]<=mOp3_st_o;
              mOp3_banks_reg[1]<=mOp3_banks_o;
              mOp3_bank0_reg[1]<=mOp3_bank0_o;
              mOp3_odd_reg[1]<=mOp3_odd_o;
              mOp3_addr_low_reg[1]<=mOp3_addr_low_o;
              mOp3_split_reg[1]<=mOp3_split_o;
              mOp3_register_reg[1]<=mOp3_register_o;
              mOp3_type_reg[1]<=mOp3_type_o;
              mOp3_LSQ_reg[1]<=mOp3_LSQ_o;
              mOp3_II_reg[1]<=mOp3_II_o;
              mOp3_WQ_reg[1]<=mOp3_WQ_o;
              mOp3_lsflag_reg[1]<=mOp3_lsflag_o;
              mOp3_lsfwd_reg[1]<=mOp3_lsfwd_o;
              mOp3_data_reg[1]<=mOp3_data_o;
              mOp3_pbit_reg[1]<=mOp3_pbit_o;
              mOp3_brdbanks_reg[1]<=mOp3_brdbanks_o;

              thrreginh[1][4]<=1'b0;
              mOp4_addrEven_reg[1]<=mOp4_addrEven_o;
              mOp4_addrOdd_reg[1]<=mOp4_addrOdd_o;
              mOp4_sz_reg[1]<=mOp4_sz_o;
              mOp4_first_reg[1]<=mOp4_first;
              mOp4_bank0_reg[1]<=mOp4_bank0_o;
              mOp4_odd_reg[1]<=mOp4_odd_o;
              mOp4_addr_low_reg[1]<=mOp4_addr_low_o;
              mOp4_split_reg[1]<=mOp4_split_o;
              mOp4_data_reg[1]<=mOp4_data_o;
              mOp4_pbit_reg[1]<=mOp4_pbit_o;
              mOp4_type_reg[1]<=mOp4_type_o;
              mOp4_bank1_reg[1]<=mOp4_bank1_o;
              mOp4_II_reg[1]<=mOp4_II_o;
              mOp4_bgn_b_reg[1]<=mOp4_bgn_b_o;
              mOp4_end_b_reg[1]<=mOp4_end_b_o;

              thrreginh[1][5]<=1'b0;
              mOp5_addrEven_reg[1]<=mOp5_addrEven_o;
              mOp5_addrOdd_reg[1]<=mOp5_addrOdd_o;
              mOp5_sz_reg[1]<=mOp5_sz_o;
              mOp5_first_reg[1]<=mOp5_first;
              mOp5_bank0_reg[1]<=mOp5_bank0_o;
              mOp5_odd_reg[1]<=mOp5_odd_o;
              mOp5_addr_low_reg[1]<=mOp5_addr_low_o;
              mOp5_split_reg[1]<=mOp5_split_o;
              mOp5_data_reg[1]<=mOp5_data_o;
              mOp5_pbit_reg[1]<=mOp5_pbit_o;
              mOp5_bank1_reg[1]<=mOp5_bank1_o;
              mOp5_type_reg[1]<=mOp5_type_o;
              mOp5_II_reg[1]<=mOp5_II_o;
              mOp5_bgn_b_reg[1]<=mOp5_bgn_b_o;
              mOp5_end_b_reg[1]<=mOp5_end_b_o;
              for(r=2;r<=3;r=r+1) begin
                  thrreginh[r][0]<=thrreginh[r-1][0] || except;
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
                  mOp0_type_reg[r]<=mOp0_type_reg[r-1];
                  mOp0_II_reg[r]<=mOp0_II_reg[r-1];
                  mOp0_WQ_reg[r]<=mOp0_WQ_reg[r-1];
                  mOp0_lsflag_reg[r]<=mOp0_lsflag_reg[r-1];
                  mOp0_lsfwd_reg[r]<=mOp0_lsfwd_reg[r-1];

                  thrreginh[r][1]<=thrreginh[r-1][1] || except;
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
                  mOp1_type_reg[r]<=mOp1_type_reg[r-1];
                  mOp1_II_reg[r]<=mOp1_II_reg[r-1];
                  mOp1_WQ_reg[r]<=mOp1_WQ_reg[r-1];
                  mOp1_lsflag_reg[r]<=mOp1_lsflag_reg[r-1];
                  mOp1_lsfwd_reg[r]<=mOp1_lsfwd_reg[r-1];

                  thrreginh[r][2]<=thrreginh[r-1][2] || except;
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
                  mOp2_type_reg[r]<=mOp2_type_reg[r-1];
                  mOp2_II_reg[r]<=mOp2_II_reg[r-1];
                  mOp2_WQ_reg[r]<=mOp2_WQ_reg[r-1];
                  mOp2_lsflag_reg[r]<=mOp2_lsflag_reg[r-1];
                  mOp2_lsfwd_reg[r]<=mOp2_lsfwd_reg[r-1];
                  mOp2_data_reg[r]<=mOp2_data_reg[r-1];
                  mOp2_pbit_reg[r]<=mOp2_pbit_reg[r-1];
                  mOp2_brdread_reg[r]<=mOp2_brdread_reg[r-1];
                  
                  thrreginh[r][3]<=thrreginh[r-1][3] || (except && mOp3_register_reg[r-1]!=9'h1fc);
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
                  mOp3_type_reg[r]<=mOp3_type_reg[r-1];
                  mOp3_LSQ_reg[r]<=mOp3_LSQ_reg[r-1];
                  mOp3_II_reg[r]<=mOp3_II_reg[r-1];
                  mOp3_WQ_reg[r]<=mOp3_WQ_reg[r-1];
                  mOp3_lsflag_reg[r]<=mOp3_lsflag_reg[r-1];
                  mOp3_data_reg[r]<=mOp3_data_reg[r-1];
                  mOp3_pbit_reg[r]<=mOp3_pbit_reg[r-1];
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
                  mOp4_type_reg[r]<=mOp4_type_reg[r-1];
                  mOp4_pbit_reg[r]<=mOp4_pbit_reg[r-1];
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
                  mOp5_type_reg[r]<=mOp5_type_reg[r-1];
                  mOp5_pbit_reg[r]<=mOp5_pbit_reg[r-1];
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



