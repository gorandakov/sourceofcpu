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





module stq_buf_A(
  clk,
  rst,
  stallA,
  excpt,
  wrt0_en, wrt0_addrE, wrt0_addrEInv, wrt0_addrO, wrt0_addrOInv, 
  wrt1_en, wrt1_addrE, wrt1_addrEInv, wrt1_addrO, wrt1_addrOInv, 
  chk0_en, chk0_addrEO,  chk0_addrE, chk0_addrEInv, chk0_addrO, chk0_addrOInv,,
  chk1_en, chk1_addrEO,  chk1_addrE, chk1_addrEInv, chk1_addrO, chk1_addrOInv,,
  chk2_en, chk2_addrEO,  chk2_addrE, chk2_addrEInv, chk2_addrO, chk2_addrOInv,,
  chk3_en, chk3_addrEO,  chk3_addrE, chk3_addrEInv, chk3_addrO, chk3_addrOInv,,
  chk4_en, chk4_addrEO,  chk4_addrE, chk4_addrEInv, chk4_addrO, chk4_addrOInv,,
  chk5_en, chk5_addrEO,  chk5_addrE, chk5_addrEInv, chk5_addrO, chk5_addrOInv,,
  upd0_en, 
  upd1_en, 
  free_en,free,upd,passe,passe_en);
  localparam WIDTH=36;
  parameter [0:0] ODD=0;
  input clk;
  input rst;
  input stallA;
  input excpt;
  
  input wrt0_en;
  input [WIDTH-1:0] wrt0_addrE;
  input [WIDTH-1:0] wrt0_addrO;
  input [WIDTH-1:0] wrt0_addrEInv;
  input [WIDTH-1:0] wrt0_addrOInv;


  input wrt1_en;
  input [WIDTH-1:0] wrt1_addrE;
  input [WIDTH-1:0] wrt1_addrO;
  input [WIDTH-1:0] wrt1_addrEInv;
  input [WIDTH-1:0] wrt1_addrOInv;

  input chk0_en;
  output [1:0] chk0_addrEO;
  input [WIDTH-1:0] chk0_addrE;
  input [WIDTH-1:0] chk0_addrO;
  input [WIDTH-1:0] chk0_addrEInv;
  input [WIDTH-1:0] chk0_addrOInv;

  input chk1_en;
  output [1:0] chk1_addrEO;
  input [WIDTH-1:0] chk1_addrE;
  input [WIDTH-1:0] chk1_addrO;
  input [WIDTH-1:0] chk1_addrEInv;
  input [WIDTH-1:0] chk1_addrOInv;
  
  input chk2_en;
  output [1:0] chk2_addrEO;
  input [WIDTH-1:0] chk2_addrE;
  input [WIDTH-1:0] chk2_addrO;
  input [WIDTH-1:0] chk2_addrEInv;
  input [WIDTH-1:0] chk2_addrOInv;
  
  input chk3_en;
  output [1:0] chk3_addrEO;
  input [WIDTH-1:0] chk3_addrE;
  input [WIDTH-1:0] chk3_addrO;
  input [WIDTH-1:0] chk3_addrEInv;
  input [WIDTH-1:0] chk3_addrOInv;
  
  input chk4_en;
  output [1:0] chk4_addrEO;
  input [WIDTH-1:0] chk4_addrE;
  input [WIDTH-1:0] chk4_addrO;
  input [WIDTH-1:0] chk4_addrEInv;
  input [WIDTH-1:0] chk4_addrOInv;
  
  input chk5_en;
  output [1:0] chk5_addrEO;
  input [WIDTH-1:0] chk5_addrE;
  input [WIDTH-1:0] chk5_addrO;
  input [WIDTH-1:0] chk5_addrEInv;
  input [WIDTH-1:0] chk5_addrOInv;


  input upd0_en;
  input upd1_en;

  input free_en;
  output reg free;
  output reg upd;
  output reg passe;
  input passe_en;
  
  reg [WIDTH-1:0] addrE;
  reg [WIDTH-1:0] addrO;
//  reg upd;
 
  generate
      if (!ODD) begin : even
          assign chk0_addrEO[0]=chk0_addrE==addrE && ~free && ~passe;
          assign chk1_addrEO[0]=chk1_addrE==addrE && ~free && ~passe;
          assign chk2_addrEO[0]=chk2_addrE==addrE && ~free && ~passe;
          assign chk3_addrEO[0]=chk3_addrE==addrE && ~free && ~passe;
          assign chk4_addrEO[0]=chk4_addrE==addrE && ~free && ~passe;
          assign chk5_addrEO[0]=chk5_addrE==addrE && ~free && ~passe;

          assign chk0_addrEO[1]=chk0_addrO==addrO && ~free && ~passe;
          assign chk1_addrEO[1]=chk1_addrO==addrO && ~free && ~passe;
          assign chk2_addrEO[1]=chk2_addrO==addrO && ~free && ~passe;
          assign chk3_addrEO[1]=chk3_addrO==addrO && ~free && ~passe;
          assign chk4_addrEO[1]=chk4_addrO==addrO && ~free && ~passe;
          assign chk5_addrEO[1]=chk5_addrO==addrO && ~free && ~passe;
      end else begin :odd
          assign chk0_addrEO[0]=chk0_addrEInv==addrE && ~free && ~passe;
          assign chk1_addrEO[0]=chk1_addrEInv==addrE && ~free && ~passe;
          assign chk2_addrEO[0]=chk2_addrEInv==addrE && ~free && ~passe;
          assign chk3_addrEO[0]=chk3_addrEInv==addrE && ~free && ~passe;
          assign chk4_addrEO[0]=chk4_addrEInv==addrE && ~free && ~passe;
          assign chk5_addrEO[0]=chk5_addrEInv==addrE && ~free && ~passe;

          assign chk0_addrEO[1]=chk0_addrOInv==addrO && ~free && ~passe;
          assign chk1_addrEO[1]=chk1_addrOInv==addrO && ~free && ~passe;
          assign chk2_addrEO[1]=chk2_addrOInv==addrO && ~free && ~passe;
          assign chk3_addrEO[1]=chk3_addrOInv==addrO && ~free && ~passe;
          assign chk4_addrEO[1]=chk4_addrOInv==addrO && ~free && ~passe;
          assign chk5_addrEO[1]=chk5_addrOInv==addrO && ~free && ~passe;
      end
  endgenerate
  always @(posedge clk) begin
      if (rst) begin
          addrE<={36{ODD}};
          addrO<={36{ODD}};
          free<=1'b1;
          upd<=1'b1;
          passe<=1'b0;
      end else begin
          if (wrt0_en) begin
              addrE<=ODD ? wrt0_addrEInv : wrt0_addrE;
              addrO<=ODD ? wrt0_addrOInv : wrt0_addrO;
              free<=1'b0;
              //upd<=1'b0;
              passe<=1'b0;
          end
          if (wrt1_en) begin
              addrE<=ODD ? wrt1_addrEInv : wrt1_addrE;
              addrO<=ODD ? wrt1_addrOInv : wrt1_addrO;
              free<=1'b0;
              //upd<=1'b0;
              passe<=1'b0;
          end
          if (upd0_en|upd1_en) begin
              upd<=1'b1;
          end
          if (passe_en) begin
              passe<=1'b1;
              upd<=1'b0;
          end
          if (free_en) begin 
              free<=1'b1;
              passe<=1'b0;
          end
          if (excpt&free&passe) begin
              passe<=1'b0;
          end
      end
  end
endmodule


module stq_buf_A_array(
  clk,
  rst,
  stallA,
  excpt,
  wrt0_en, wrt0_addrE, wrt0_addrEInv, wrt0_addrO, wrt0_addrOInv, 
  wrt1_en, wrt1_addrE, wrt1_addrEInv, wrt1_addrO, wrt1_addrOInv, 
  chk0_en, chk0_addrEO, chk0_addrE, chk0_addrEInv, chk0_addrO, chk0_addrOInv,
  chk1_en, chk1_addrEO, chk1_addrE, chk1_addrEInv, chk1_addrO, chk1_addrOInv,
  chk2_en, chk2_addrEO, chk2_addrE, chk2_addrEInv, chk2_addrO, chk2_addrOInv,
  chk3_en, chk3_addrEO, chk3_addrE, chk3_addrEInv, chk3_addrO, chk3_addrOInv,
  chk4_en, chk4_addrEO, chk4_addrE, chk4_addrEInv, chk4_addrO, chk4_addrOInv,
  chk5_en, chk5_addrEO, chk5_addrE, chk5_addrEInv, chk5_addrO, chk5_addrOInv,
  upd0_en, 
  upd1_en, 
  free_en,free,upd,passe,passe_en);
  localparam WIDTH=36;
  localparam BUF_COUNT=32;
  input clk;
  input rst;
  input stallA;
  input excpt;
  
  input [BUF_COUNT-1:0] wrt0_en;
  input [WIDTH-1:0] wrt0_addrE;
  input [WIDTH-1:0] wrt0_addrO;
  input [WIDTH-1:0] wrt0_addrEInv;
  input [WIDTH-1:0] wrt0_addrOInv;

  input [BUF_COUNT-1:0] wrt1_en;
  input [WIDTH-1:0] wrt1_addrE;
  input [WIDTH-1:0] wrt1_addrO;
  input [WIDTH-1:0] wrt1_addrEInv;
  input [WIDTH-1:0] wrt1_addrOInv;

  input chk0_en;
  output [BUF_COUNT-1:0] [1:0] chk0_addrEO;
  input [WIDTH-1:0] chk0_addrE;
  input [WIDTH-1:0] chk0_addrO;
  input [WIDTH-1:0] chk0_addrEInv;
  input [WIDTH-1:0] chk0_addrOInv;

  input chk1_en;
  output [BUF_COUNT-1:0] [1:0] chk1_addrEO;
  input [WIDTH-1:0] chk1_addrE;
  input [WIDTH-1:0] chk1_addrO;
  input [WIDTH-1:0] chk1_addrEInv;
  input [WIDTH-1:0] chk1_addrOInv;
  
  input chk2_en;
  output [BUF_COUNT-1:0] [1:0] chk2_addrEO;
  input [WIDTH-1:0] chk2_addrE;
  input [WIDTH-1:0] chk2_addrO;
  input [WIDTH-1:0] chk2_addrEInv;
  input [WIDTH-1:0] chk2_addrOInv;
  
  input chk3_en;
  output [BUF_COUNT-1:0] [1:0] chk3_addrEO;
  input [WIDTH-1:0] chk3_addrE;
  input [WIDTH-1:0] chk3_addrO;
  input [WIDTH-1:0] chk3_addrEInv;
  input [WIDTH-1:0] chk3_addrOInv;
  
  input chk4_en;
  output [BUF_COUNT-1:0] [1:0] chk4_addrEO;
  input [WIDTH-1:0] chk4_addrE;
  input [WIDTH-1:0] chk4_addrO;
  input [WIDTH-1:0] chk4_addrEInv;
  input [WIDTH-1:0] chk4_addrOInv;
  
  input chk5_en;
  output [BUF_COUNT-1:0] [1:0] chk5_addrEO;
  input [WIDTH-1:0] chk5_addrE;
  input [WIDTH-1:0] chk5_addrO;
  input [WIDTH-1:0] chk5_addrEInv;
  input [WIDTH-1:0] chk5_addrOInv;


  input [BUF_COUNT-1:0] upd0_en;
  input [BUF_COUNT-1:0] upd1_en;

  input [BUF_COUNT-1:0] free_en;
  output [BUF_COUNT-1:0]  free;
  output [BUF_COUNT-1:0]  upd;
  output [BUF_COUNT-1:0]  passe;
  input [BUF_COUNT-1:0]  passe_en;
  
  generate
      genvar t;
      for(t=0;t<BUF_COUNT;t=t+1) begin :  buf_gen
          stq_buf_A buf_mod(
          clk,
          rst,
          stallA,
          excpt,
          wrt0_en[t], wrt0_addrE, wrt0_addrEInv, wrt0_addrO, wrt0_addrOInv, 
          wrt1_en[t], wrt1_addrE, wrt1_addrEInv, wrt1_addrO, wrt1_addrOInv, 
          chk0_en, chk0_addrEO[t], chk0_addrE, chk0_addrEInv, chk0_addrO, chk0_addrOInv,
          chk1_en, chk1_addrEO[t], chk1_addrE, chk1_addrEInv, chk1_addrO, chk1_addrOInv,
          chk2_en, chk2_addrEO[t], chk2_addrE, chk2_addrEInv, chk2_addrO, chk2_addrOInv,
          chk3_en, chk3_addrEO[t], chk3_addrE, chk3_addrEInv, chk3_addrO, chk3_addrOInv,
          chk4_en, chk4_addrEO[t], chk4_addrE, chk4_addrEInv, chk4_addrO, chk4_addrOInv,
          chk5_en, chk5_addrEO[t], chk5_addrE, chk5_addrEInv, chk5_addrO, chk5_addrOInv,
          upd0_en[t], 
          upd1_en[t], 
          free_en[t],free[t],upd[t],passe[t],passe_en[t]);
      end
  endgenerate
endmodule
