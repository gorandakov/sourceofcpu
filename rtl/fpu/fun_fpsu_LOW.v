/*
Copyright 2022 Goran Dakov

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

`include "../struct.sv"
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module fun_fpuSL(
  clk,
  rst,
  fpcsr,
  u1_A,u1_B,u1_Bx,u1_Bxo,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_ret_en,u1_XSUB,u1_FX,
  u3_A,u3_B,u3_Bx,u3_Bxo,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_ret,u3_ret_en,u3_XSUB,u3_FX,
  u5_A,u5_B,u5_Bx,u5_Bxo,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_ret,u5_ret_en,u5_XSUB,u5_FX,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  FUF4X,FUF5X,FUF6X,
  xdataD,xdata2D,
  xdataB,xdata2B,
  xdataC,xdata2C,
  ALTDATA0,ALTDATA1,
  ALT_INP,
  FOOSL0_out,
  FOOSL1_out,
  FOOSL2_out,
  XI_dataS
  );
  localparam [0:0] H=1'b0;
  localparam SIMD_WIDTH=68; //half width
  input clk;
  input rst;
  input [31:0] fpcsr;
  input [67:0] u1_A;
  input [67:0] u1_B;
  input [67:0] u1_Bx;
  output [67:0] u1_Bxo;
  input [3:0] u1_en;
  input [12:0] u1_op;
  input [3:0] u1_fufwd_A;
  input [3:0] u1_fuufwd_A;
  input [3:0] u1_fufwd_B;
  input [3:0] u1_fuufwd_B;
  output [13:0] u1_ret;
  output u1_ret_en;
  input u1_XSUB;
  input u1_FX;

  input [67:0] u3_A;
  input [67:0] u3_B;
  input [67:0] u3_Bx;
  output [67:0] u3_Bxo;
  input [3:0] u3_en;
  input [12:0] u3_op;
  input [3:0] u3_fufwd_A;
  input [3:0] u3_fuufwd_A;
  input [3:0] u3_fufwd_B;
  input [3:0] u3_fuufwd_B;
  output [13:0] u3_ret;
  output u3_ret_en;
  input u3_XSUB;
  input u3_FX;
  
  input [67:0] u5_A;
  input [67:0] u5_B;
  input [67:0] u5_Bx;
  output [67:0] u5_Bxo;
  input [3:0] u5_en;
  input [12:0] u5_op;
  input [3:0] u5_fufwd_A;
  input [3:0] u5_fuufwd_A;
  input [3:0] u5_fufwd_B;
  input [3:0] u5_fuufwd_B;
  output [13:0] u5_ret;
  output u5_ret_en;
  input u5_XSUB;
  input u5_FX;
  

  (* register equiload *) input [67:0] FUF0;
  (* register equiload *) input [67:0] FUF1;
  (* register equiload *) input [67:0] FUF2;
  (* register equiload *) input [67:0] FUF3;
  (* register equiload *) output [67:0] FUF4;
  (* register equiload *) output [67:0] FUF5;
  (* register equiload *) output [67:0] FUF6;
  (* register equiload *) output [67:0] FUF7;
  (* register equiload *) output [67:0] FUF8;
  (* register equiload *) output [67:0] FUF9;
  (* register equiload *) output [67:0] FUF4X;
  (* register equiload *) output [67:0] FUF5X;
  (* register equiload *) output [67:0] FUF6X;
  input [67:0] xdataD;
  output [67:0] xdata2D;
  input [67:0] xdataB;
  output [67:0] xdata2B;
  input [67:0] xdataC;
  output [67:0] xdata2C;

  input [1:0] ALT_INP;
  input [67:0] ALTDATA0;
  input [67:0] ALTDATA1;
  
 
  (* register equiload *) output [5:0] FOOSL0_out;
  (* register equiload *) output [5:0] FOOSL1_out;
  (* register equiload *) output [5:0] FOOSL2_out;

  output [67:0] XI_dataS;

  

  fun_fpsu #(0,0) fpu0_mod(
  clk,
  rst,
  fpcsr,
  u1_A,u1_B,u1_Bx,u1_Bxo,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_ret_en,u1_XSUB,u1_FX,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF4X,FUF5X,FUF6X,
  FUF9,
  xdataD,xdata2D,
  68'b0,68'b0,
  2'b0,
  FOOSL0_out,
  );

  fun_fpsu #(1,0) fpu1_mod(
  clk,
  rst,
  fpcsr,
  u3_A,u3_B,u3_Bx,u3_Bxo,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_ret,u3_ret_en,u3_XSUB,u3_FX,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  FUF4X,FUF5X,FUF6X,
  xdataB,xdata2B,
  68'b0,68'b0,
  2'b0,
  FOOSL1_out,
  );

  fun_fpsu #(2,0) fpu2_mod(
  clk,
  rst,
  fpcsr,
  u5_A,u5_B,u5_Bx,u5_Bxo,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_ret,u5_ret_en,u5_XSUB,u5_FX,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  FUF4X,FUF5X,FUF6X,
  xdataC,xdata2C,
  ALTDATA0,ALTDATA1,
  ALT_INP,
  FOOSL2_out,
  XI_dataS
  );

endmodule
