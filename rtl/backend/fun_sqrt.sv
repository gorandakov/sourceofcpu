`include "../struct.sv"
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module fun_fpusqr0(
  clk,
  rst,
  except,
  fpcsr,
  u1_A,u1_B,u1_Av,u1_Bv,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_ret_en,
  u1_regNo,u1_II,
  en_early,op_early,
  u1_Bx,u1_Bxo,
  outEn,
  outII,
  outOp,
  FUreg,
  FUwen,
  outAltData,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  FUV0,FUV1,FUV2,
  FUV3,FUV4,FUV5,
  FUV6,FUV7,FUV8,
  FUV9,
  fxFRT_alten,
  fxFRT_pause
  );
  parameter [1:0] INDEX=2'd2;
  parameter [0:0] H=1'b0;
  localparam SIMD_WIDTH=68; //half width
  localparam [4:0] S={~H,3'b0};
  localparam REG_WIDTH=9;
  input clk;
  input rst;
  input except;
  input [31:0] fpcsr;
  input [S+67:0] u1_A;
  input [S+67:0] u1_B;
  input [67:0] u1_Av;
  input [67:0] u1_Bv;
  input [3:0] u1_en;
  input [12:0] u1_op;
  input [3:0] u1_fufwd_A;
  input [3:0] u1_fuufwd_A;
  input [3:0] u1_fufwd_B;
  input [3:0] u1_fuufwd_B;
  output [13:0] u1_ret;
  output u1_ret_en;
  input [REG_WIDTH-1:0] u1_regNo;
  input [9:0] u1_II;
  output [67:0] u1_Bx;
  input  [67:0] u1_Bxo;
  input [3:0] en_early;
  input [12:0] op_early;
  
  output [3:0] outEn;
  output [9:0] outII;
  output [12:0] outOp;
  output [8:0] FUreg;
  output FUwen;
  output [2*SIMD_WIDTH-1:0] outAltData;

  input [67:0] FUV0;
  input [67:0] FUV1;
  input [67:0] FUV2;
  input [67:0] FUV3;
  input [67:0] FUV4;
  input [67:0] FUV5;
  inout [67:0] FUV6;
  input [67:0] FUV7;
  input [67:0] FUV8;
  input [67:0] FUV9;

  input [S+67:0] FUF0;
  input [S+67:0] FUF1;
  input [S+67:0] FUF2;
  input [S+67:0] FUF3;
  input [S+67:0] FUF4;
  input [S+67:0] FUF5;
  inout [S+67:0] FUF6;
  input [S+67:0] FUF7;
  input [S+67:0] FUF8;
  input [S+67:0] FUF9;
  output [2:0][3:0] fxFRT_alten;//very fat wire
  output [3:0]      fxFRT_pause;//same here

  wire [1:0][10:0] fxFCADD_raise;
  reg [10:0] fxFCADD_raise_reg[1:0];
  reg [10:0] fxFCADD_raise_s_reg[1:0];
  wire [1:0][10:0] fxFADD_raise;
  reg [10:0] fxFADD_raise_reg[1:0];
  reg [10:0] fxFADD_raise_s_reg[1:0];
  wire [10:0] fraise2;
  wire [10:0] fraise3;
  wire [10:0] fmask2;
  wire [10:0] fmask3;
  //wire [15:0] u1_Bx=u1_BH[15:0];
  //wire [15:0] u2_Bx=u2_BH[15:0];
  integer k;

  reg [1:0] ALT_INP_reg;
  
  wire [2:0][3:0] fxFRT_alten;
  reg [2:0][3:0] fxFRT_alten_reg;
  reg [2:0][3:0] fxFRT_alten_reg2;
  reg [2:0][3:0] fxFRT_alten_reg3;
  reg [3:0] fxFRT_alten_reg4[2:2];
  reg [3:0] fxFRT_alten_reg5[2:2];
  reg [3:0] fxFRT_alten_reg6[2:2];
  wire [3:0] fxFRT_pause;
  wire [3:0] fxFRT_can;
  wire [3:0] fxFRT_don;
  reg [3:0] fxFRT_can_reg;
  reg [3:0] fxFRT_don_reg;
  reg [3:0] fxFRT_don_reg2;
  reg [3:0] fxFRT_don_reg3;
  reg [3:0] fxFRT_don_reg4;
  reg [4:0] fxFRT_steps;
  reg [2:0] fxFRT_type;
  reg [4:0] fxFRT_steps_reg;
  reg [2:0] fxFRT_type_reg;
  reg fxFRT_isRoot;
  reg fxFRT_isRoot_reg;
//  reg [1:0] fxFRT_don_reg;
  reg fxFRT_dbl_reg;
  reg fxFRT_ext_reg;
  reg fxFRT_sngl_reg;
  reg fxFRT_dbl;
  reg fxFRT_ext;
  reg fxFRT_sngl;
  reg fxFRT_dbl_s;
  reg fxFRT_ext_s;
  reg fxFRT_sngl_s;
  reg fxFRT_dbl_ns;
  reg fxFRT_ext_ns;
  reg fxFRT_sngl_ns;
  wire [63:-1] fxFRT_normA0;
  wire [15:0] fxFRT_expA;
  wire [63:-1] fxFRT_normB0;
  wire [15:0] fxFRT_expB;
  wire fxFRT_sgnA;
  wire fxFRT_sgnB;
  wire [3:0][8:0] rtReg;
  wire [3:0][9:0] rtII;
  wire [8:0] frtReg;
  wire [9:0] frtII;
  wire [12:0] frtOp;
  reg [8:0] frtReg_reg;
  reg [9:0] frtII_reg;
  reg [12:0] frtOp_reg;
  wire [3:0][12:0] rtOp;
  wire [3:0][S+67:0] rtRes;
  reg fxFRT_do;
  reg [12:0] u1_op_reg;
  reg [9:0]  u1_II_reg;
  reg [3:0]  u1_en_reg;

  wire [S+67:0] rtDataA;
  wire [S+67:0] rtDataB;
  reg  [S+67:0] rtDataA_reg;
  reg  [S+67:0] rtDataB_reg;

  wire [67:0] uu_Bv1;
  wire [67:0] uu_Av1;
  wire [S+67:0] uu_B1;
  wire [S+67:0] uu_A1;
  reg [67:0] uu_Bv_reg;
  reg [67:0] uu_Av_reg;

  reg [REG_WIDTH-1:0] u1_regNo_reg;

  rs_write_forward #(S+68) u1_A_fwd(
  clk,rst,
  ~u1_en[3],
  u1_A,uu_A1,
  u1_fufwd_A_reg,u1_fuufwd_A_reg,
  FUF0,FUF0_reg,
  FUF1,FUF1_reg,
  FUF2,FUF2_reg,
  FUF3,FUF3_reg,
  FUF4,FUF4_reg,
  FUF5,FUF5_reg,
  FUF6,FUF6_reg,
  FUF7,FUF7_reg,
  FUF8,FUF8_reg,
  FUF9,FUF9_reg
  );
  
  rs_write_forward #(S+68) u1_B_fwd(
  clk,rst,
  ~u1_en[3],
  u1_B,uu_B1,
  u1_fufwd_B_reg,u1_fuufwd_B_reg,
  FUF0,FUF0_reg,
  FUF1,FUF1_reg,
  FUF2,FUF2_reg,
  FUF3,FUF3_reg,
  FUF4,FUF4_reg,
  FUF5,FUF5_reg,
  FUF6,FUF6_reg,
  FUF7,FUF7_reg,
  FUF8,FUF8_reg,
  FUF9,FUF9_reg
  );
  
  rs_write_forward #(68) u1_Av_fwd(
  clk,rst,
  ~u1_en[2],
  u1_Av,uu_Av1,
  u1_fufwd_A,u1_fuufwd_A,
  FUV0,FUV0_reg,
  FUV1,FUV1_reg,
  FUV2,FUV2_reg,
  FUV3,FUV3_reg,
  FUV4,FUV4_reg,
  FUV5,FUV5_reg,
  FUV6,FUV6_reg,
  FUV7,FUV7_reg,
  FUV8,FUV8_reg,
  FUV9,FUV9_reg
  );
  
  rs_write_forward #(68) u1_Bv_fwd(
  clk,rst,
  ~u1_en[2],
  u1_Bv,uu_Bv1,
  u1_fufwd_B,u1_fuufwd_B,
  FUV0,FUV0_reg,
  FUV1,FUV1_reg,
  FUV2,FUV2_reg,
  FUV3,FUV3_reg,
  FUV4,FUV4_reg,
  FUV5,FUV5_reg,
  FUV6,FUV6_reg,
  FUV7,FUV7_reg,
  FUV8,FUV8_reg,
  FUV9,FUV9_reg
  );
  

/*
  assign fraise2[m]=fxFCADD_sn_reg5[m] ?
    (fxFCADD_raise_s_reg[0]|fxFCADD_raise_s_reg[1])&fpcsr[21:11] :
    (fxFCADD_raise_reg)&fpcsr[21:11];
  assign fmask2[m]=fxFCADD_sn_reg5[m] ?
    (fxFCADD_raise_s_reg[0]|fxFCADD_raise_s_reg[1]) :
    (fxFCADD_raise_reg);
  fexcpt fexcpt2_mod(fraise2_reg,{5'b0,FUS_alu1,ex_alu1},
    fmaks2_reg,|outEn_reg6[2][3:2],u2_ret,u2_ret_en);
  assign fraise3[m]=fxFADD_sn_reg5[m] ?
    (fxFADD_raise_s_reg2[0]|fxFADD_raise_s_reg2[1])&fpcsr[21:11] :
    (fxFADD_raise_reg)&fpcsr[21:11];
  assign fmask3[m]=fxFADD_sn_reg5[m] ?
    (fxFADD_raise_s_reg[0]|fxFADD_raise_s_reg[1]) :
    (fxFADD_raise_reg);
  fexcpt fexcpt3_mod(fraise3_reg,{5'b0,FUS_alu0,ex_alu0},
    fmaks3_reg,|outEn_reg6[1][3:2],u1_ret,u1_ret_en);*/
/*module fexcpt(
  mask,
  in,
  in_mask,
  in_en,
  no,
  en);
*/
  
  in_flip_rt #(16+SIMD_WIDTH+9+10) rtDatA_mod(
    .clk(clk),.rst(rst),.in_en(fxFRT_en),.pause(fxFRT_pause[2]),
    .d_in({u1_II_reg,u1_regNo_reg,u1_en_reg[3] ? uu_A1 : {16'b0,uu_Av_reg}}),
    .d_out({frtII,frtReg,rtDataA}),
    .dout_en((fxFRT_can[0] & ~fxFRT_don_reg[0] & ~fxFRT_don_reg2[0] & ~fxFRT_don_reg2[0] & ~fxFRT_don_reg3[0]) |
     (fxFRT_can[1] & ~fxFRT_don_reg[1] & ~fxFRT_don_reg2[1] & ~fxFRT_don_reg2[1] & ~fxFRT_don_reg3[1]) |
     (fxFRT_can[2] & ~fxFRT_don_reg[2] & ~fxFRT_don_reg2[2] & ~fxFRT_don_reg2[2] & ~fxFRT_don_reg3[2]) |
     (fxFRT_can[3] & ~fxFRT_don_reg[3] & ~fxFRT_don_reg2[3] & ~fxFRT_don_reg2[3] & ~fxFRT_don_reg3[3])),.do_(fxFRT_do));
  in_flip_rt #(13+16+SIMD_WIDTH) rtDatB_mod(
    .clk(clk),.rst(rst),.in_en(fxFRT_en),.pause(),
    .d_in({u1_op_reg,u1_en_reg[3] ? (u1_op_reg[8+H] ? {16'b0,u1_Bxo} : uu_B1) : {16'b0,uu_Bv_reg}}),
    .d_out({frtOp,rtDataB}),
    .dout_en((fxFRT_can[0] & ~fxFRT_don_reg[0] & ~fxFRT_don_reg2[0] & ~fxFRT_don_reg2[0] & ~fxFRT_don_reg3[0]) |
     (fxFRT_can[1] & ~fxFRT_don_reg[1] & ~fxFRT_don_reg2[1] & ~fxFRT_don_reg2[1] & ~fxFRT_don_reg3[1]) |
     (fxFRT_can[2] & ~fxFRT_don_reg[2] & ~fxFRT_don_reg2[2] & ~fxFRT_don_reg2[2] & ~fxFRT_don_reg3[2]) |
     (fxFRT_can[3] & ~fxFRT_don_reg[3] & ~fxFRT_don_reg2[3] & ~fxFRT_don_reg2[3] & ~fxFRT_don_reg3[3])),.do_());
  
  assign fxFRT_don[0]=fxFRT_do&fxFRT_can[0]&~fxFRT_don_reg[0]&~fxFRT_don_reg2[0]&~fxFRT_don_reg3[0];
  assign fxFRT_don[1]=fxFRT_do&&~fxFRT_can[0]|fxFRT_don_reg[0]|fxFRT_don_reg2[0]|fxFRT_don_reg3[0]
   && fxFRT_can[1] && ~fxFRT_don_reg[1]&&~fxFRT_don_reg2[1]&&~fxFRT_don_reg3[1];
  assign fxFRT_don[2]=fxFRT_do&&~fxFRT_can[0]|fxFRT_don_reg[0]|fxFRT_don_reg2[0]|fxFRT_don_reg3[0]
   && ~fxFRT_can[1]|fxFRT_don_reg[1]|fxFRT_don_reg2[1]|fxFRT_don_reg3[1] 
   && fxFRT_can[2] && ~fxFRT_don_reg[2]&&~fxFRT_don_reg2[2]&&~fxFRT_don_reg3[2];
  assign fxFRT_don[3]=fxFRT_do&&~fxFRT_can[0]|fxFRT_don_reg[0]|fxFRT_don_reg2[0]|fxFRT_don_reg3[0]
   && ~fxFRT_can[1]|fxFRT_don_reg[1]|fxFRT_don_reg2[1]|fxFRT_don_reg3[1] 
   && ~fxFRT_can[2]|fxFRT_don_reg[2]|fxFRT_don_reg2[2]|fxFRT_don_reg3[2] 
   && fxFRT_can[3] && ~fxFRT_don_reg[3]&&~fxFRT_don_reg2[3]&&~fxFRT_don_reg3[3];

  assign u1_Bx=uu_B1[67:0];

  assign fxFRT_expA=fxFRT_dbl ? {rtDataA_reg[65],{4{~rtDataA_reg[65]&&{rtDataA_reg[65],rtDataA_reg[63:53]}}},
    rtDataA_reg[63:53]} : 16'bz;
  assign fxFRT_expA=fxFRT_sngl ? {rtDataA_reg[65],{7{~rtDataA_reg[65]&&{rtDataA_reg[65],rtDataA_reg[30:23]}}},
    rtDataA_reg[30:23]} : 16'bz;
  assign fxFRT_expA=fxFRT_ext ? {rtDataA_reg[65],rtDataA_reg[SIMD_WIDTH+14:SIMD_WIDTH]} : 16'bz;
  assign fxFRT_expB=fxFRT_dbl? {rtDataB_reg[65],{4{~rtDataB_reg[65]&&{rtDataB_reg[65],rtDataB_reg[63:53]}}},
    rtDataB_reg[63:53]} : 16'bz;
  assign fxFRT_expB=fxFRT_sngl ? {rtDataB_reg[65],{7{~rtDataB_reg[65]&&{rtDataB_reg[65],rtDataB_reg[30:23]}}},
    rtDataB_reg[30:23]} : 16'bz;
  assign fxFRT_expB=fxFRT_ext ? {rtDataB_reg[65],rtDataB_reg[SIMD_WIDTH+14:SIMD_WIDTH]} : 16'bz;

  assign fxFRT_normA0=fxFRT_dbl_ns ? {1'b1,rtDataA_reg[52:33],rtDataA_reg[31:0],12'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_sngl_ns ?{1'b1,rtDataA_reg[22:0],21'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_ext_ns ? {rtDataA_reg[64:33],rtDataA_reg[31:0],1'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_dbl_s ? {2'b1,rtDataA_reg[52:33],rtDataA_reg[31:0],11'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_sngl_s ?{2'b1,rtDataA_reg[22:0],20'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_ext_s ? {1'b0,rtDataA_reg[64:33],rtDataA_reg[31:0]} : 65'bz;
  assign fxFRT_normB0=fxFRT_dbl ? {1'b1,rtDataB_reg[52:33],rtDataB_reg[31:0],12'b0} : 65'bz;
  assign fxFRT_normB0=fxFRT_sngl ?{1'b1,rtDataB_reg[22:0],21'b0} : 65'bz;
  assign fxFRT_normB0=fxFRT_ext ? {rtDataB_reg[64:33],rtDataB_reg[31:0],1'b0} : 65'bz;

  assign fxFRT_sgnA=fxFRT_dbl ? rtDataA_reg[64] : 1'bz;
  assign fxFRT_sgnA=fxFRT_sngl ? rtDataA_reg[31] : 1'bz;
  assign fxFRT_sgnA=fxFRT_ext ? rtDataA_reg[31] : 1'bz;
  assign fxFRT_sgnB=fxFRT_dbl ? rtDataB_reg[64] : 1'bz;
  assign fxFRT_sgnB=fxFRT_sngl ? rtDataB_reg[31] : 1'bz;
  assign fxFRT_sgnB=fxFRT_ext ? rtDataB_reg[31] : 1'bz;

  generate
      genvar n;
      for(n=0;n<4;n=n+1) begin : rt2_mod 
	  rt2_fp rt2_mod(
          .clk(clk),
          .rst(rst),
	  .except(except), //warning: not SMT-ed
          .rdy(fxFRT_can[n]),
          .start_process(fxFRT_don_reg3[n]),
          .step_cnt(fxFRT_steps),
          .type_(fxFRT_type),
          .is_root(fxFRT_isRoot),
          .rmode(fxFRT_type==3'd1 ? fpcsr[`csrfpu_rmodeE] : fpcsr[`csrfpu_rmode]),
	  .reg_in(frtReg_reg),
	  .outII_in(frtII_reg),
	  .oper_in(frtOp_reg),
          .normA(fxFRT_normA0),
          .expA({1'b0,fxFRT_expA}),
          .nsignA({1'b0,~fxFRT_sgnA}),
          .normB(fxFRT_normB0),
          .expB({1'b0,fxFRT_expB}),
          .nsignB({1'b0,~fxFRT_sgnB}),
          .result(rtRes[n]),
	  .reg_out(rtReg[n]),
	  .outII_out(rtII[n]),
	  .oper_out(rtOp[n]),
          .out_en(fxFRT_alten[2][n]),
          .out_can(!(({fxFRT_alten[2],4'b0}>>n)&4'hf))
          );
	  assign fxFRT_alten[1]=4'b0;
	  assign fxFRT_alten[0]=4'b0;

	  assign outEn=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst)?
	    4'b1001 : 4'bz;
	  assign outII=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst) ?
	    rtII[n] : {10{1'bz}};
	  assign outOp=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst) ?
	    rtOp[n] : {13{1'bz}};
	  assign FUreg=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst) ?
	    rtReg[n] : {REG_WIDTH{1'bz}};
	  assign FUwen=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst) ?
	    1'b1 : {REG_WIDTH{1'bz}};

	  assign outAltData=(fxFRT_alten_reg5[2][n]  && (!(({fxFRT_alten_reg5[2],4'b0}>>n)&4'hf)) && ~rst) ? 
	    rtRes[n] : {2*SIMD_WIDTH{1'bz}};//tri state close to target
      end
  endgenerate 

  assign outAltData=fxFRT_alten_reg5[2]==4'b0 ? {16+SIMD_WIDTH{1'b0}} : {16+SIMD_WIDTH{1'bz}};

  always @(posedge clk) begin
      if (rst) begin
	  fxFRT_dbl=1'b0;
	  fxFRT_ext=1'b0;
	  fxFRT_sngl=1'b0;
/*	  fxFRT_dblL_reg<=1'b0;
          fxFRT_dblH_reg<=1'b0;
          fxFRT_ext_reg<=1'b0;
          fxFRT_sngl_reg<=1'b0;*/
          fxFRT_isRoot=1'b0;
//	  fxFRT_isRoot_reg<=1'b0;
	  fxFRT_dbl_s<=1'b0;
          fxFRT_ext_s<=1'b0;
          fxFRT_sngl_s<=1'b0;
	  fxFRT_dbl_ns<=1'b0;
          fxFRT_ext_ns<=1'b0;
          fxFRT_sngl_ns<=1'b0;
	  fxFRT_steps<=5'd0;
	  fxFRT_type<=3'b0;
	  fxFRT_steps_reg<=5'd0;
	  fxFRT_type_reg<=3'b0;
	  fxFRT_don_reg<=4'b0;
	  fxFRT_en<=1'b0;
	  rtDataA_reg<={2*SIMD_WIDTH{1'b0}};
	  rtDataB_reg<={2*SIMD_WIDTH{1'b0}};
	  fxFRT_alten_reg[0]<=4'b0;
	  fxFRT_alten_reg2[0]<=4'b0;
	  fxFRT_alten_reg3[0]<=4'b0;
	  fxFRT_alten_reg[1]<=4'b0;
	  fxFRT_alten_reg2[1]<=4'b0;
	  fxFRT_alten_reg3[1]<=4'b0;
	  fxFRT_alten_reg[2]<=4'b0;
	  fxFRT_alten_reg2[2]<=4'b0;
	  fxFRT_alten_reg3[2]<=4'b0;
	  fxFRT_alten_reg4[2]<=4'b0;
	  fxFRT_alten_reg5[2]<=4'b0;
	  fxFRT_alten_reg6[2]<=4'b0;
	  fxFRT_can_reg<=4'd0;
	  fxFRT_don_reg<=4'd0;
	  fxFRT_don_reg2<=4'd0;
	  fxFRT_don_reg3<=4'd0;
	  fxFRT_don_reg4<=4'd0;
	  frtReg_reg<=9'b0;
	  frtII_reg<=10'b0;
	  frtOp_reg<=13'b0;
      end else begin
	  fxFRT_dbl=!H ? frtOp[7:0]==`fop_sqrtDL || frtOp[7:0]==`fop_divDL :
              frtOp[7:0]==`fop_sqrtDH || frtOp[7:0]==`fop_divDH;
          fxFRT_ext=frtOp[7:0]==`fop_sqrtE || frtOp[7:0]==`fop_divE;
          fxFRT_sngl=frtOp[7:0]==`fop_sqrtS || frtOp[7:0]==`fop_divS;
	  fxFRT_isRoot=frtOp[7:0]==`fop_sqrtDL || frtOp[7:0]==`fop_sqrtDH ||
                frtOp[7:0]==`fop_sqrtE || frtOp[7:0]==`fop_sqrtS; 
	  fxFRT_dbl_ns<=fxFRT_dbl && ~rtDataA[53]|~fxFRT_isRoot;
	  fxFRT_ext_ns<=fxFRT_ext && ~rtDataA[SIMD_WIDTH]|~fxFRT_isRoot;
	  fxFRT_sngl_ns<=fxFRT_sngl && ~rtDataA[23]|~fxFRT_isRoot;
	  fxFRT_dbl_s<=fxFRT_dbl && rtDataA[53]&fxFRT_isRoot;
	  fxFRT_ext_s<=fxFRT_ext && rtDataA[SIMD_WIDTH]&fxFRT_isRoot;
	  fxFRT_sngl_s<=fxFRT_sngl && rtDataA[23]&fxFRT_isRoot;
    /* 	  fxFRT_dblL_reg<=fxFRT_dblL;
          fxFRT_dblH_reg<=fxFRT_dblH;
          fxFRT_ext_reg<=fxFRT_ext;
          fxFRT_sngl_reg<=fxFRT_sngl;*/
     //     fxFRT_isRoot_reg<=fxFRT_isRoot;
	  fxFRT_en<=op_early[11] && en_early[3:2]!=0; 
	  if (frtOp[7:0]==`fop_sqrtDL || frtOp[7:0]==`fop_divDL ||
	    frtOp[7:0]==`fop_sqrtDH || frtOp[7:0]==`fop_divDH) begin
	      fxFRT_steps<=5'd13;
	      fxFRT_type<=3'b0;
	  end else if (frtOp[7:0]==`fop_sqrtE || frtOp[7:0]==`fop_divE) begin
	      fxFRT_steps<=5'd16;
	      fxFRT_type<=3'd1;
	  end else if (frtOp[7:0]==`fop_sqrtS || frtOp[7:0]==`fop_divS) begin
	      fxFRT_steps<=5'd6;
	      fxFRT_type<=3'd2;
	  end
	 /* fxFRT_steps_reg<=fxFRT_steps;
	  fxFRT_type_reg<=fxFRT_type;*/
	  fxFRT_don_reg<=fxFRT_don;
	  fxFRT_alten_reg[2]<=fxFRT_alten[2];
	  fxFRT_alten_reg2[2]<=fxFRT_alten_reg[2];
	  fxFRT_alten_reg3[2]<=fxFRT_alten_reg2[2];
	  fxFRT_alten_reg4[2]<=fxFRT_alten_reg3[2];
	  fxFRT_alten_reg5[2]<=fxFRT_alten_reg4[2];
	  fxFRT_alten_reg6[2]<=fxFRT_alten_reg5[2];
	  fxFRT_can_reg<=fxFRT_can;
	  fxFRT_don_reg<=fxFRT_don;
	  fxFRT_don_reg2<=fxFRT_don_reg;
	  fxFRT_don_reg3<=fxFRT_don_reg2;
	  fxFRT_don_reg4<=fxFRT_don_reg3;
	  frtReg_reg<=frtReg;
          frtII_reg<=frtII;
          frtOp_reg<=frtOp;
	  uu_Av_reg<=uu_Av1;
	  uu_Bv_reg<=uu_Bv1;
	  u1_regNo_reg<=u1_regNo;
	  u1_op_reg<=u1_op;
	  u1_II_reg<=u1_II;
	  u1_en_reg<=u1_en;

	  if (fxFRT_don_reg2) begin
              rtDataA_reg<=rtDataA;
	      rtDataB_reg<=rtDataB;
	  end
      end
  end

endmodule
