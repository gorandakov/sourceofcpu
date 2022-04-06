`include "../struct.sv"
`include "../operations.sv"

module fu_alu(
  clk,
  rst,
  except,
  u1_A,u1_B,u1_S,u1_op,u1_ret,u1_rten,u1_clkEn,
    u1_A_fufwd,u1_A_fuufwd,u1_B_fufwd,u1_B_fuufwd,
    u1_S_fufwd,u1_S_fuufwd,
  u2_A,u2_B,u2_S,u2_op,u2_ret,u2_rten,u2_clkEn,
    u2_A_fufwd,u2_A_fuufwd,u2_B_fufwd,u2_B_fuufwd,
    u2_S_fufwd,u2_S_fuufwd,
  u3_A,u3_B,u3_S,u3_op,u3_ret,u3_rten,u3_clkEn,
    u3_A_fufwd,u3_A_fuufwd,u3_B_fufwd,u3_B_fuufwd,
    u3_S_fufwd,u3_S_fuufwd,
  u4_A,u4_B,u4_S,u4_op,u4_ret,u4_rten,u4_clkEn,
    u4_A_fufwd,u4_A_fuufwd,u4_B_fufwd,u4_B_fuufwd,
    u4_S_fufwd,u4_S_fuufwd,
  u5_A,u5_B,u5_S,u5_nDataAlt,u5_op,u5_ret,u5_rten,u5_clkEn,
    u5_A_fufwd,u5_A_fuufwd,u5_B_fufwd,u5_B_fuufwd,
    u5_S_fufwd,u5_S_fuufwd,
  u6_A,u6_B,u6_S,u6_op,u6_ret,u6_rten,u6_clkEn,
    u6_A_fufwd,u6_A_fuufwd,u6_B_fufwd,u6_B_fuufwd,
    u6_S_fufwd,u6_S_fuufwd,
  FU0, FU1,  FU2,  FU3,
  FU4, FU5,  FU6,  FU7,
  FU8, FU9,
  FUS1,  FUS2,  FUS3,
  FUS4, FUS5,  FUS6,  FUS7,
  FUS8,FUS9,
  fxFRT_alten_reg,
  fcvtout,
  DataAlt,
  FUCVTIN
  );

  input clk;
  input rst;
  input except;

  input [64:0]          u1_A;
  input [64:0]          u1_B;
  input [5:0]           u1_S;
  input [12:0]          u1_op;
  output [8:0]          u1_ret;
  output                u1_rten;
  input                 u1_clkEn;
  input [3:0]           u1_A_fufwd;
  input [3:0]           u1_A_fuufwd;
  input [3:0]           u1_B_fufwd;
  input [3:0]           u1_B_fuufwd;
  input [3:0]           u1_S_fufwd;
  input [3:0]           u1_S_fuufwd;

  input [64:0]          u2_A;
  input [64:0]          u2_B;
  input [5:0]           u2_S;
  input [12:0]          u2_op;
  output [8:0]          u2_ret;
  output                u2_rten;
  input                 u2_clkEn;
  input [3:0]           u2_A_fufwd;
  input [3:0]           u2_A_fuufwd;
  input [3:0]           u2_B_fufwd;
  input [3:0]           u2_B_fuufwd;
  input [3:0]           u2_S_fufwd;
  input [3:0]           u2_S_fuufwd;

  input [64:0]          u3_A;
  input [64:0]          u3_B;
  input [5:0]           u3_S;
  input [12:0]          u3_op;
  output [8:0]          u3_ret;
  output                u3_rten;
  input                 u3_clkEn;
  input [3:0]           u3_A_fufwd;
  input [3:0]           u3_A_fuufwd;
  input [3:0]           u3_B_fufwd;
  input [3:0]           u3_B_fuufwd;
  input [3:0]           u3_S_fufwd;
  input [3:0]           u3_S_fuufwd;

  input [64:0]          u4_A;
  input [64:0]          u4_B;
  input [5:0]           u4_S;
  input [12:0]          u4_op;
  output [8:0]          u4_ret;
  output                u4_rten;
  input                 u4_clkEn;
  input [3:0]           u4_A_fufwd;
  input [3:0]           u4_A_fuufwd;
  input [3:0]           u4_B_fufwd;
  input [3:0]           u4_B_fuufwd;
  input [3:0]           u4_S_fufwd;
  input [3:0]           u4_S_fuufwd;

  input [64:0]          u5_A;
  input [64:0]          u5_B;
  input [5:0]           u5_S;
  input                 u5_nDataAlt;
  input [12:0]          u5_op;
  output [8:0]          u5_ret;
  output                u5_rten;
  input                 u5_clkEn;
  input [3:0]           u5_A_fufwd;
  input [3:0]           u5_A_fuufwd;
  input [3:0]           u5_B_fufwd;
  input [3:0]           u5_B_fuufwd;
  input [3:0]           u5_S_fufwd;
  input [3:0]           u5_S_fuufwd;

  input [64:0]          u6_A;
  input [64:0]          u6_B;
  input [5:0]           u6_S;
  input [12:0]          u6_op;
  output [8:0]          u6_ret;
  output                u6_rten;
  input                 u6_clkEn;
  input [3:0]           u6_A_fufwd;
  input [3:0]           u6_A_fuufwd;
  input [3:0]           u6_B_fufwd;
  input [3:0]           u6_B_fuufwd;
  input [3:0]           u6_S_fufwd;
  input [3:0]           u6_S_fuufwd;

  input [64:0] FU0;
  input [64:0] FU1;
  input [64:0] FU2;
  input [64:0] FU3;
  inout [64:0] FU4;
  inout [64:0] FU5;
  inout [64:0] FU6;
  inout [64:0] FU7;
  inout [64:0] FU8;
  inout [64:0] FU9;

  input [5:0] FUS1;
  input [5:0] FUS2;
  input [5:0] FUS3;
  input [5:0] FUS4;
  input [5:0] FUS5;
  input [5:0] FUS6;
  input [5:0] FUS7;
  input [5:0] FUS8;
  input [5:0] FUS9;

  input fxFRT_alten_reg;

  output [83:0] fcvtout;
  output [1:0] DataAlt;
  input [63:0] FUCVTIN;

  reg [1:0] nDataAlt;
  reg [1:0] nDataAlt_reg;
  reg u5_nDataAlt_reg;
  reg [64:0] FU0_reg;
  reg [64:0] FU1_reg;
  reg [64:0] FU2_reg;
  reg [64:0] FU3_reg;
  reg [64:0] FU4_reg;
  reg [64:0] FU5_reg;
  reg [64:0] FU6_reg;
  reg [64:0] FU7_reg;
  reg [64:0] FU8_reg;
  reg [64:0] FU9_reg;
  
  reg [5:0] FUS1_reg;
  reg [5:0] FUS2_reg;
  reg [5:0] FUS3_reg;
  reg [5:0] FUS4_reg;
  reg [5:0] FUS5_reg;
  reg [5:0] FUS6_reg;
  reg [5:0] FUS7_reg;
  reg [5:0] FUS8_reg;
  reg [5:0] FUS9_reg;
  
  reg [3:0]           u1_S_fufwd_reg;
  reg [3:0]           u1_S_fuufwd_reg;
  reg [3:0]           u2_S_fufwd_reg;
  reg [3:0]           u2_S_fuufwd_reg;
  reg [3:0]           u3_S_fufwd_reg;
  reg [3:0]           u3_S_fuufwd_reg;
  reg [3:0]           u4_S_fufwd_reg;
  reg [3:0]           u4_S_fuufwd_reg;
  reg [3:0]           u5_S_fufwd_reg;
  reg [3:0]           u5_S_fuufwd_reg;
  reg [3:0]           u6_S_fufwd_reg;
  reg [3:0]           u6_S_fuufwd_reg;

  wire [64:0] uu_A1;
  wire [64:0] uu_B1;
  wire [64:0] uu_A2;
  wire [64:0] uu_B2;
  wire [64:0] uu_A3;
  wire [64:0] uu_B3;
  wire [64:0] uu_A4;
  wire [64:0] uu_B4;
  wire [64:0] uu_A5;
  wire [64:0] uu_B5;
  wire [64:0] uu_A6;
  wire [64:0] uu_B6;

  wire [5:0] uu_S1;
  wire [5:0] uu_S2;
  wire [5:0] uu_S3;
  wire [5:0] uu_S4;
  wire [5:0] uu_S5;
  wire [5:0] uu_S6;

  wire [81:0] FUCVT2_0;
  wire [1:0] FUTYPE_0;
  wire [64:0] FUMUL;
  wire [5:0] MULFL;

  reg [3:0] u2_sz;
  reg       u2_arith;
  reg       u2_dir;
  reg [3:0] u4_sz;
  reg       u4_arith;
  reg       u4_dir;
  reg [3:0] u6_sz;
  reg       u6_arith;
  reg       u6_dir;
  
  reg fxFRT_alten_reg2;
  reg fxFRT_alten_reg3;

  reg [12:0] u1_op_reg;
  reg [12:0] u2_op_reg;
  reg [12:0] u3_op_reg;
  reg [12:0] u4_op_reg;
  reg [12:0] u5_op_reg;
  reg [12:0] u6_op_reg;
  reg [12:0] u6_op_reg2;
  reg [12:0] u6_op_reg3;
  reg [12:0] u6_op_reg4;

  reg [5:0] u1_isSub_reg;
  reg [5:0] u2_isSub_reg;
  reg [5:0] u3_isSub_reg;
  reg [5:0] u4_isSub_reg;
  reg [5:0] u5_isSub_reg;
  reg [5:0] u6_isSub_reg;

  reg u1_clkEn_reg;
  reg u2_clkEn_reg;
  reg u3_clkEn_reg;
  reg u4_clkEn_reg;
  reg u5_clkEn_reg;
  reg u6_clkEn_reg;

  reg [8:0] u6_ret_reg;
  reg [8:0] u6_ret_reg2;
  reg [8:0] u6_ret_reg3;

  rs_write_forward #(65) u1_A_fwd(
  clk,rst,
  ~u1_clkEn,
  u1_A,uu_A1,
  u1_A_fufwd,u1_A_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) u1_B_fwd(
  clk,rst,
  ~u1_clkEn,
  u1_B,uu_B1,
  u1_B_fufwd,u1_B_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(65) u2_A_fwd(
  clk,rst,
  ~u2_clkEn,
  u2_A,uu_A2,
  u2_A_fufwd,u2_A_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) u2_B_fwd(
  clk,rst,
  ~u2_clkEn,
  u2_B,uu_B2,
  u2_B_fufwd,u2_B_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(65) u3_A_fwd(
  clk,rst,
  ~u3_clkEn,
  u3_A,uu_A3,
  u3_A_fufwd,u3_A_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) u3_B_fwd(
  clk,rst,
  ~u3_clkEn,
  u3_B,uu_B3,
  u3_B_fufwd,u3_B_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(65) u4_A_fwd(
  clk,rst,
  ~u4_clkEn,
  u4_A,uu_A4,
  u4_A_fufwd,u4_A_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) u4_B_fwd(
  clk,rst,
  ~u4_clkEn,
  u4_B,uu_B4,
  u4_B_fufwd,u4_B_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(65) u5_A_fwd(
  clk,rst,
  ~u5_clkEn,
  u5_A,uu_A5,
  u5_A_fufwd,u5_A_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) u5_B_fwd(
  clk,rst,
  ~u5_clkEn,
  u5_B,uu_B5,
  u5_B_fufwd,u5_B_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(65) u6_A_fwd(
  clk,rst,
  ~u6_clkEn,
  u6_A,uu_A6,
  u6_A_fufwd,u6_A_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) u6_B_fwd(
  clk,rst,
  ~u6_clkEn,
  u6_B,uu_B6,
  u6_B_fufwd,u6_B_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_writeiS_forward #(6) u1_S_fwd(
  clk,rst,
  ~u1_clkEn,
  u1_S,uu_S1,
  u1_S_fufwd_reg,u1_S_fuufwd_reg,
  FUS1,FUS1_reg,
  FUS2,FUS2_reg,
  FUS3,FUS3_reg,
  6'b0,6'b0,
  FUS4,FUS4_reg,
  FUS5,FUS5_reg,
  FUS6,FUS6_reg,
  FUS7,FUS7_reg,
  FUS8,FUS8_reg,
  FUS9,FUS9_reg
  );

  rs_writeiS_forward #(6) u2_S_fwd(
  clk,rst,
  ~u2_clkEn,
  u2_S,uu_S2,
  u2_S_fufwd_reg,u2_S_fuufwd_reg,
  FUS1,FUS1_reg,
  FUS2,FUS2_reg,
  FUS3,FUS3_reg,
  6'b0,6'b0,
  FUS4,FUS4_reg,
  FUS5,FUS5_reg,
  FUS6,FUS6_reg,
  FUS7,FUS7_reg,
  FUS8,FUS8_reg,
  FUS9,FUS9_reg
  );


  rs_writeiS_forward #(6) u3_S_fwd(
  clk,rst,
  ~u3_clkEn,
  u3_S,uu_S3,
  u3_S_fufwd_reg,u3_S_fuufwd_reg,
  FUS1,FUS1_reg,
  FUS2,FUS2_reg,
  FUS3,FUS3_reg,
  6'b0,6'b0,
  FUS4,FUS4_reg,
  FUS5,FUS5_reg,
  FUS6,FUS6_reg,
  FUS7,FUS7_reg,
  FUS8,FUS8_reg,
  FUS9,FUS9_reg
  );


  rs_writeiS_forward #(6) u4_S_fwd(
  clk,rst,
  ~u4_clkEn,
  u4_S,uu_S4,
  u4_S_fufwd_reg,u4_S_fuufwd_reg,
  FUS1,FUS1_reg,
  FUS2,FUS2_reg,
  FUS3,FUS3_reg,
  6'b0,6'b0,
  FUS4,FUS4_reg,
  FUS5,FUS5_reg,
  FUS6,FUS6_reg,
  FUS7,FUS7_reg,
  FUS8,FUS8_reg,
  FUS9,FUS9_reg
  );


  rs_writeiS_forward #(6) u5_S_fwd(
  clk,rst,
  ~u5_clkEn,
  u5_S,uu_S5,
  u5_S_fufwd_reg,u5_S_fuufwd_reg,
  FUS1,FUS1_reg,
  FUS2,FUS2_reg,
  FUS3,FUS3_reg,
  6'b0,6'b0,
  FUS4,FUS4_reg,
  FUS5,FUS5_reg,
  FUS6,FUS6_reg,
  FUS7,FUS7_reg,
  FUS8,FUS8_reg,
  FUS9,FUS9_reg
  );


  rs_writeiS_forward #(6) u6_S_fwd(
  clk,rst,
  ~u6_clkEn,
  u6_S,uu_S6,
  u6_S_fufwd_reg,u6_S_fuufwd_reg,
  FUS1,FUS1_reg,
  FUS2,FUS2_reg,
  FUS3,FUS3_reg,
  6'b0,6'b0,
  FUS4,FUS4_reg,
  FUS5,FUS5_reg,
  FUS6,FUS6_reg,
  FUS7,FUS7_reg,
  FUS8,FUS8_reg,
  FUS9,FUS9_reg
  );



  alu alu0(clk,rst,except,1'b0,1'b0,u1_op_reg,u1_isSub_reg,u1_clkEn_reg,1'b1,
    u1_ret,u1_rten,uu_A1,uu_B1,uu_S1,FU4);
  alu #(1'b0)  alu1(clk,rst,except,1'b0,1'b0,u2_op_reg,u2_isSub_reg,u2_clkEn_reg,1'b1,
    u2_ret,u2_rten,uu_A2,uu_B2,uu_S2,FU7);
  
  alu alu2(clk,rst,except,1'b0,1'b0,u3_op_reg,u3_isSub_reg,u3_clkEn_reg,1'b1,
    u3_ret,u3_rten,uu_A3,uu_B3,uu_S3,FU5);
  alu #(1'b0)  alu3(clk,rst,except,1'b0,1'b0,u4_op_reg,u4_isSub_reg,u4_clkEn_reg,1'b1,
    u4_ret,u4_rten,uu_A4,uu_B4,uu_S4,FU8);
  
  alu alu4(clk,rst,except,1'b0,1'b0,u5_op_reg,u5_isSub_reg,u5_clkEn_reg,u5_nDataAlt&&(&nDataAlt),
    u5_ret,u5_rten,uu_A5,uu_B5,uu_S5,FU6);
  alu #(1'b0)  alu5(clk,rst,except,1'b0,1'b0,u6_op_reg,u6_isSub_reg,u6_clkEn_reg,1'b1,
    u6_ret,u6_rten,uu_A6,uu_B6,uu_S6,FU9);
  
  alu_shift sh2_alu(
  clk,
  rst,
  except,
  1'b0,
  u2_op_reg,
  u2_sz,{1'b0,u2_sz[3],1'b1,1'b0},u2_arith,u2_dir,
  u2_clkEn_reg,
  1'b1,
  u2_ret,
  uu_S2,
  uu_A2[63:0],
  uu_B2[63:0],
  FU7[63:0]
  );
  
  alu_shift sh4_alu(
  clk,
  rst,
  except,
  1'b0,
  u4_op_reg,
  u4_sz,{1'b0,u4_sz[3],1'b1,1'b0},u4_arith,u4_dir,
  u4_clkEn_reg,
  1'b1,
  u4_ret,
  uu_S4,
  uu_A4[63:0],
  uu_B4[63:0],
  FU8[63:0]
  );

  alu_shift sh6_alu(
  clk,
  rst,
  except,
  1'b0,
  u6_op_reg,
  u6_sz,{1'b0,u6_sz[3],1'b1,1'b0},u6_arith,u6_dir,
  u6_clkEn_reg,
  1'b1,
  u6_ret,
  uu_S6,
  uu_A6[63:0],
  uu_B6[63:0],
  FU9[63:0]
  );
  
  ifconv_mod g2fp_mod(
  .clk(clk),
  .rst(rst),
  .clkEn(~(|fxFRT_alten_reg3)),
  .A(uu_B6[63:0]),
  .en(u6_op_reg[11] && u6_clkEn_reg && ((u6_op_reg[7:0]==`op_cvtD) ||
    (u6_op_reg[7:0]==`op_cvtE) || (u6_op_reg[7:0]==`op_cvtS))),
  .toDBL(u6_op_reg[7:0]!=`op_cvtE && u6_op_reg[7:0]!=`op_cvtS),
  .toEXT(u6_op_reg[7:0]==`op_cvtE),
  .toSNG(u6_op_reg[7:0]==`op_cvtS),
  .isS(u6_op_reg[10]),
  .res(FUCVT2_0),
  .rtyp(FUTYPE_0),
  .alt(DataAlt[1])
  );

  assign fcvtout={FUCVT2_0[81:66],FUTYPE_0,FUCVT2_0[65:0]};
 
  assign FU6=(~&nDataAlt) ? FUMUL : 65'bz;
  assign FU6=(~u5_nDataAlt) ? {1'b0,FUCVTIN} : 65'bz;
  
  assign u5_ret=(~u5_nDataAlt_reg|(~nDataAlt_reg[1])) ? {6'b0,1'b0,2'd2} : 
    9'bz; 
  assign u5_ret=u5_nDataAlt_reg&~nDataAlt_reg[0] ? {MULFL,~u6_op_reg4[12],
    2'd2} : 9'bz; 
  assign u5_rten=(~u5_nDataAlt_reg|(~&nDataAlt_reg)) ? 1'b1 : 
    1'bz; 

  imul imul_mod(
  .clk(clk),
  .rst(rst),
  .clkEn(~(|fxFRT_alten_reg3)),
  .op_prev(u6_op),
  .en(u6_clkEn_reg && u6_op_reg[11] && (u6_op_reg[7:0]==1 || u6_op_reg[7:0]
    ==2 || u6_op_reg[7:0]==3 || u6_op_reg[7:0]==9 || u6_op_reg[7:0]==10 ||
    u6_op_reg[7:0]==11 || u6_op_reg[7:0]==5 || u6_op_reg[7:0]==7)),  
  .R(uu_A6),.C(uu_B6),
  .alt(DataAlt[0]),
  .Res(FUMUL),
  .flg(MULFL)
 );
 
  always @(posedge clk) begin

      FU0_reg<=FU0;
      FU1_reg<=FU1;
      FU2_reg<=FU2;
      FU3_reg<=FU3;
      FU4_reg<=FU4;
      FU5_reg<=FU5;
      FU6_reg<=FU6;
      FU7_reg<=FU7;
      FU8_reg<=FU8;
      FU9_reg<=FU9;
      
      FUS1_reg<=FUS1;
      FUS2_reg<=FUS2;
      FUS3_reg<=FUS3;
      FUS4_reg<=FUS4;
      FUS5_reg<=FUS5;
      FUS6_reg<=FUS6;
      FUS7_reg<=FUS7;
      FUS8_reg<=FUS8;
      FUS9_reg<=FUS9;

      u1_clkEn_reg<=u1_clkEn;
      u2_clkEn_reg<=u2_clkEn;
      u3_clkEn_reg<=u3_clkEn;
      u4_clkEn_reg<=u4_clkEn;
      u5_clkEn_reg<=u5_clkEn;
      u6_clkEn_reg<=u6_clkEn;

      u1_op_reg<=u1_op;
      u2_op_reg<=u2_op;
      u3_op_reg<=u3_op;
      u4_op_reg<=u4_op;
      u5_op_reg<=u5_op;
      u6_op_reg<=u6_op;
      u6_op_reg2<=u6_op_reg;
      u6_op_reg3<=u6_op_reg2;
      u6_op_reg4<=u6_op_reg3;

      u1_S_fufwd_reg<= u1_S_fufwd;
      u1_S_fuufwd_reg<=u1_S_fuufwd;
      u2_S_fufwd_reg<= u2_S_fufwd;
      u2_S_fuufwd_reg<=u2_S_fuufwd;
      u3_S_fufwd_reg<= u3_S_fufwd;
      u3_S_fuufwd_reg<=u3_S_fuufwd;
      u4_S_fufwd_reg<= u4_S_fufwd;
      u4_S_fuufwd_reg<=u4_S_fuufwd;
      u5_S_fufwd_reg<= u5_S_fufwd;
      u5_S_fuufwd_reg<=u5_S_fuufwd;
      u6_S_fufwd_reg<= u6_S_fufwd;
      u7_S_fuufwd_reg<=u6_S_fuufwd;

      if(u2_op==`op_shl64 || u2_op==`op_shr64 || u2_op==`op_sar64)
          u2_sz<=4'b1000; else u2_sz<=4'b0100;
      if(u4_op==`op_shl64 || u4_op==`op_shr64 || u4_op==`op_sar64)
          u4_sz<=4'b1000; else u4_sz<=4'b0100;
      if(u6_op==`op_shl64 || u6_op==`op_shr64 || u6_op==`op_sar64)
          u6_sz<=4'b1000; else u6_sz<=4'b0100;
      u2_arith<=u2_op==`op_sar64 || u2_op==`op_sar32;
      u4_arith<=u4_op==`op_sar64 || u4_op==`op_sar32;
      u6_arith<=u6_op==`op_sar64 || u6_op==`op_sar32;
      u2_dir<=u2_op!=`op_shl64 && u2_op!=`op_shl32;
      u4_dir<=u4_op!=`op_shl64 && u4_op!=`op_shl32;
      u6_dir<=u6_op!=`op_shl64 && u6_op!=`op_shl32;
      fxFRT_alten_reg2<=fxFRT_alten_reg;
      fxFRT_alten_reg3<=fxFRT_alten_reg2;
      u6_ret_reg<=u6_ret;
      u6_ret_reg2<=u6_ret_reg;
      u6_ret_reg3<=u6_ret_reg2;
      nDataAlt<=~DataAlt;
      nDataAlt_reg<=nDataAlt;
      u5_nDataAlt_reg<=u5_nDataAlt;
      if (u1_op[7:1]==30) begin
	  u1_isSub_reg[0]=u1_op[0] && ~u1_op[8];
	  u1_isSub_reg[1]=~u1_op[0] && ~u1_op[8];
	  u1_isSub_reg[2]=u1_op[8];
	  u1_isSub_reg[3]=u1_op[9] && ~u1_op[10];
	  u1_isSub_reg[4]=~u1_op[9] && ~u1_op[10];
	  u1_isSub_reg[5]=u1_op[10];
      end else begin
	  u1_isSub_reg[0]=u1_op[7:0]!=`op_sub64 && u1_op[7:0]!=`op_sub32;
	  u1_isSub_reg[1]=u1_op[7:0]==`op_sub64 || u1_op[7:0]==`op_sub32;
	  u1_isSub_reg[2]=1'b0;
	  u1_isSub_reg[5:3]=3'd1;
      end
      if (u2_op[7:1]==30) begin
	  u2_isSub_reg[0]=u2_op[0] && ~u2_op[8];
	  u2_isSub_reg[1]=~u2_op[0] && ~u2_op[8];
	  u2_isSub_reg[2]=u2_op[8];
	  u2_isSub_reg[3]=u2_op[9] && ~u2_op[10];
	  u2_isSub_reg[4]=~u2_op[9] && ~u2_op[10];
	  u2_isSub_reg[5]=u2_op[10];
      end else begin
	  u2_isSub_reg[0]=u2_op[7:0]!=`op_sub64 && u2_op[7:0]!=`op_sub32;
	  u2_isSub_reg[1]=u2_op[7:0]==`op_sub64 || u2_op[7:0]==`op_sub32;
	  u2_isSub_reg[2]=1'b0;
	  u2_isSub_reg[5:3]=3'd1;
      end
      if (u3_op[7:1]==30) begin
	  u3_isSub_reg[0]=u3_op[0] && ~u3_op[8];
	  u3_isSub_reg[1]=~u3_op[0] && ~u3_op[8];
	  u3_isSub_reg[2]=u3_op[8];
	  u3_isSub_reg[3]=u3_op[9] && ~u3_op[10];
	  u3_isSub_reg[4]=~u3_op[9] && ~u3_op[10];
	  u3_isSub_reg[5]=u3_op[10];
      end else begin
	  u3_isSub_reg[0]=u3_op[7:0]!=`op_sub64 && u3_op[7:0]!=`op_sub32;
	  u3_isSub_reg[1]=u3_op[7:0]==`op_sub64 || u3_op[7:0]==`op_sub32;
	  u3_isSub_reg[2]=1'b0;
	  u3_isSub_reg[5:3]=3'd1;
      end
      if (u4_op[7:1]==30) begin
	  u4_isSub_reg[0]=u4_op[0] && ~u4_op[8];
	  u4_isSub_reg[1]=~u4_op[0] && ~u4_op[8];
	  u4_isSub_reg[2]=u4_op[8];
	  u4_isSub_reg[3]=u4_op[9] && ~u4_op[10];
	  u4_isSub_reg[4]=~u4_op[9] && ~u4_op[10];
	  u4_isSub_reg[5]=u4_op[10];
      end else begin
	  u4_isSub_reg[0]=u4_op[7:0]!=`op_sub64 && u4_op[7:0]!=`op_sub32;
	  u4_isSub_reg[1]=u4_op[7:0]==`op_sub64 || u4_op[7:0]==`op_sub32;
	  u4_isSub_reg[2]=1'b0;
	  u4_isSub_reg[5:3]=3'd1;
      end
      if (u5_op[7:1]==30) begin
	  u5_isSub_reg[0]=u5_op[0] && ~u5_op[8];
	  u5_isSub_reg[1]=~u5_op[0] && ~u5_op[8];
	  u5_isSub_reg[2]=u5_op[8];
	  u5_isSub_reg[3]=u5_op[9] && ~u5_op[10];
	  u5_isSub_reg[4]=~u5_op[9] && ~u5_op[10];
	  u5_isSub_reg[5]=u5_op[10];
      end else begin
	  u5_isSub_reg[0]=u5_op[7:0]!=`op_sub64 && u5_op[7:0]!=`op_sub32;
	  u5_isSub_reg[1]=u5_op[7:0]==`op_sub64 || u5_op[7:0]==`op_sub32;
	  u5_isSub_reg[2]=1'b0;
	  u5_isSub_reg[5:3]=3'd1;
      end
      if (u6_op[7:1]==30) begin
	  u6_isSub_reg[0]=u6_op[0] && ~u6_op[8];
	  u6_isSub_reg[1]=~u6_op[0] && ~u6_op[8];
	  u6_isSub_reg[2]=u6_op[8];
	  u6_isSub_reg[3]=u6_op[9] && ~u6_op[10];
	  u6_isSub_reg[4]=~u6_op[9] && ~u6_op[10];
	  u6_isSub_reg[5]=u6_op[10];
      end else begin
	  u6_isSub_reg[0]=u6_op[7:0]!=`op_sub64 && u6_op[7:0]!=`op_sub32;
	  u6_isSub_reg[1]=u6_op[7:0]==`op_sub64 || u6_op[7:0]==`op_sub32;
	  u6_isSub_reg[2]=1'b0;
	  u6_isSub_reg[5:3]=3'd1;
      end
  end
endmodule

