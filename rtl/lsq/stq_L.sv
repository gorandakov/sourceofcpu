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



module stq_buf_L(
  clk,
  rst,
  stallA,
  excpt,
  wrt0_en, wrt0_odd, wrt0_bytes, wrt0_subBNK, wrt0_subBNK2, 
  wrt1_en, wrt1_odd, wrt1_bytes, wrt1_subBNK, wrt1_subBNK2, 
  chk0_en, chk0_addrEO, chk0_odd, chk0_bytes, chk0_subBNK, chk0_subBNK2, chk0_match, chk0_partial,
  chk1_en, chk1_addrEO, chk1_odd, chk1_bytes, chk1_subBNK, chk1_subBNK2, chk1_match, chk1_partial,
  chk2_en, chk2_addrEO, chk2_odd, chk2_bytes, chk2_subBNK, chk2_subBNK2, chk2_match, chk2_partial,
  chk3_en, chk3_addrEO, chk3_odd, chk3_bytes, chk3_subBNK, chk3_subBNK2, chk3_match, chk3_partial,
  chk4_en, chk4_addrEO, chk4_odd, chk4_bytes, chk4_subBNK, chk4_subBNK2, chk4_match, chk4_partial,
  chk5_en, chk5_addrEO, chk5_odd, chk5_bytes, chk5_subBNK, chk5_subBNK2, chk5_match, chk5_partial,
  upd0_en, 
  upd1_en, 
  free_en,free,upd,passe,passe_en);
  localparam WIDTH=2;
  input clk;
  input rst;
  input stallA;
  input excpt;
  
  input wrt0_en;
  input [3:0] wrt0_odd;
  input [3:0] wrt0_bytes;
  input wrt0_subBNK;
  input wrt0_subBNK2;

  input wrt1_en;
  input [3:0] wrt1_odd;
  input [3:0] wrt1_bytes;
  input wrt1_subBNK;
  input wrt1_subBNK2;

  input chk0_en;
  input [WIDTH-1:0] chk0_addrEO;
  input [3:0] chk0_odd;
  input [3:0] chk0_bytes;
  input chk0_subBNK;
  input chk0_subBNK2;
  output chk0_match;
  output chk0_partial;

  input chk1_en;
  input [WIDTH-1:0] chk1_addrEO;
  input [3:0] chk1_odd;
  input [3:0] chk1_bytes;
  input chk1_subBNK;
  input chk1_subBNK2;
  output chk1_match;
  output chk1_partial;

  input chk2_en;
  input [WIDTH-1:0] chk2_addrEO;
  input [3:0] chk2_odd;
  input [3:0] chk2_bytes;
  input chk2_subBNK;
  input chk2_subBNK2;
  output chk2_match;
  output chk2_partial;

  input chk3_en;
  input [WIDTH-1:0] chk3_addrEO;
  input [3:0] chk3_odd;
  input [3:0] chk3_bytes;
  input chk3_subBNK;
  input chk3_subBNK2;
  output chk3_match;
  output chk3_partial;

  input chk4_en;
  input [WIDTH-1:0] chk4_addrEO;
  input [3:0] chk4_odd;
  input [3:0] chk4_bytes;
  input chk4_subBNK;
  input chk4_subBNK2;
  output chk4_match;
  output chk4_partial;

  input chk5_en;
  input [WIDTH-1:0] chk5_addrEO;
  input [3:0] chk5_odd;
  input [3:0] chk5_bytes;
  input chk5_subBNK;
  input chk5_subBNK2;
  output chk5_match;
  output chk5_partial;

  input upd0_en;
  input upd1_en;

  input free_en;
  output reg free;
  output reg upd;
  output reg passe;
  input passe_en;
  
//  reg [WIDTH-1:0] addrEO;
  reg [3:0] bytes;
  reg subBNK;
  reg subBNK2;
  reg [3:0] odd;
//  reg upd;
  wire chk0_match0;
  wire chk1_match0;
  wire chk2_match0;
  wire chk3_match0;
  wire chk4_match0;
  wire chk5_match0;
  
  assign chk0_match0=chk0_addrEO[chk0_odd] && (chk0_subBNK2&subBNK2)!=0 && chk0_odd[0]==odd[0];
  assign chk1_match0=chk1_addrEO[chk1_odd] && (chk1_subBNK2&subBNK2)!=0 && chk1_odd[0]==odd[0];
  assign chk2_match0=chk2_addrEO[chk2_odd] && (chk2_subBNK2&subBNK2)!=0 && chk2_odd[0]==odd[0];
  assign chk3_match0=chk3_addrEO[chk3_odd] && (chk3_subBNK2&subBNK2)!=0 && chk3_odd[0]==odd[0];
  assign chk4_match0=chk4_addrEO[chk4_odd] && (chk4_subBNK2&subBNK2)!=0 && chk4_odd[0]==odd[0];
  assign chk5_match0=chk5_addrEO[chk5_odd] && (chk5_subBNK2&subBNK2)!=0 && chk5_odd[0]==odd[0];
  
  assign chk0_match=chk0_match0 && chk0_en && ~free && ~passe && (chk0_bytes&~bytes)==0 && upd && chk0_odd==odd && (chk0_subBNK&subBNK)!=0;
  assign chk1_match=chk1_match0 && chk1_en && ~free && ~passe && (chk1_bytes&~bytes)==0 && upd && chk1_odd==odd && (chk1_subBNK&subBNK)!=0;
  assign chk2_match=chk2_match0 && chk2_en && ~free && ~passe && (chk2_bytes&~bytes)==0 && upd && chk2_odd==odd && (chk2_subBNK&subBNK)!=0;
  assign chk3_match=chk3_match0 && chk3_en && ~free && ~passe && (chk3_bytes&~bytes)==0 && upd && chk3_odd==odd && (chk3_subBNK&subBNK)!=0;
  assign chk4_match=chk4_match0 && chk4_en && ~free && ~passe && (chk4_bytes&~bytes)==0 && upd && chk4_odd==odd && (chk4_subBNK&subBNK)!=0;
  assign chk5_match=chk5_match0 && chk5_en && ~free && ~passe && (chk5_bytes&~bytes)==0 && upd && chk5_odd==odd && (chk5_subBNK&subBNK)!=0;

  assign chk0_partial=chk0_match0 && chk0_en && ~free && ~passe && ((chk0_bytes&~bytes)!=0 || ~upd);
  assign chk1_partial=chk1_match0 && chk1_en && ~free && ~passe && ((chk1_bytes&~bytes)!=0 || ~upd);
  assign chk2_partial=chk2_match0 && chk2_en && ~free && ~passe && ((chk2_bytes&~bytes)!=0 || ~upd);
  assign chk3_partial=chk3_match0 && chk3_en && ~free && ~passe && ((chk3_bytes&~bytes)!=0 || ~upd);
  assign chk4_partial=chk4_match0 && chk4_en && ~free && ~passe && ((chk4_bytes&~bytes)!=0 || ~upd);
  assign chk5_partial=chk5_match0 && chk5_en && ~free && ~passe && ((chk5_bytes&~bytes)!=0 || ~upd);

  always @(posedge clk) begin
      if (rst) begin
  //        addrEO<=0;
          bytes<=0;
          subBNK<=0;
          subBNK2<=0;
          free<=1'b1;
          upd<=1'b1;
          passe<=1'b0;
          odd<=4'b0;
      end else begin
          if (wrt0_en) begin
//              addrEO<=wrt0_addrEO;
              bytes<=wrt0_bytes;
              subBNK<=wrt0_subBNK;
              subBNK2<=wrt0_subBNK2;
              odd<=wrt0_odd;
              free<=1'b0;
              //upd<=1'b0;
              passe<=1'b0;
          end
          if (wrt1_en) begin
//              addrEO<=wrt1_addrEO;
              bytes<=wrt1_bytes;
              subBNK<=wrt1_subBNK;
              subBNK2<=wrt1_subBNK2;
              odd<=wrt1_odd;
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

module stq_buf_L_array(
  clk,
  rst,
  stallA,
  excpt,
  wrt0_en, wrt0_odd, wrt0_bytes, wrt0_subBNK, wrt0_subBNK2, 
  wrt1_en, wrt1_odd, wrt1_bytes, wrt1_subBNK, wrt1_subBNK2, 
  chk0_en, chk0_addrEO, chk0_odd, chk0_bytes, chk0_subBNK, chk0_subBNK2, chk0_match, chk0_partial,
  chk1_en, chk1_addrEO, chk1_odd, chk1_bytes, chk1_subBNK, chk1_subBNK2, chk1_match, chk1_partial,
  chk2_en, chk2_addrEO, chk2_odd, chk2_bytes, chk2_subBNK, chk2_subBNK2, chk2_match, chk2_partial,
  chk3_en, chk3_addrEO, chk3_odd, chk3_bytes, chk3_subBNK, chk3_subBNK2, chk3_match, chk3_partial,
  chk4_en, chk4_addrEO, chk4_odd, chk4_bytes, chk4_subBNK, chk4_subBNK2, chk4_match, chk4_partial,
  chk5_en, chk5_addrEO, chk5_odd, chk5_bytes, chk5_subBNK, chk5_subBNK2, chk5_match, chk5_partial,
  upd0_en, 
  upd1_en, 
  free_en,free,upd,passe,passe_en);
  localparam WIDTH=2;
  localparam BUF_COUNT=32;//2 rows of 32
  input clk;
  input rst;
  input stallA;
  input excpt;
  
  input [BUF_COUNT-1:0] wrt0_en;
  input [3:0] wrt0_odd;
  input [3:0] wrt0_bytes;
  input wrt0_subBNK;
  input wrt0_subBNK2;

  input [BUF_COUNT-1:0] wrt1_en;
  input [3:0] wrt1_odd;
  input [3:0] wrt1_bytes;
  input wrt1_subBNK;
  input wrt1_subBNK2;

  input chk0_en;
  input [BUF_COUNT-1:0][WIDTH-1:0] chk0_addrEO;
  input [3:0] chk0_odd;
  input [3:0] chk0_bytes;
  input chk0_subBNK;
  input chk0_subBNK2;
  output [BUF_COUNT-1:0] chk0_match;
  output [BUF_COUNT-1:0] chk0_partial;

  input chk1_en;
  input [BUF_COUNT-1:0][WIDTH-1:0] chk1_addrEO;
  input [3:0] chk1_odd;
  input [3:0] chk1_bytes;
  input chk1_subBNK;
  input chk1_subBNK2;
  output [BUF_COUNT-1:0] chk1_match;
  output [BUF_COUNT-1:0] chk1_partial;

  input chk2_en;
  input [BUF_COUNT-1:0][WIDTH-1:0] chk2_addrEO;
  input [3:0] chk2_odd;
  input [3:0] chk2_bytes;
  input chk2_subBNK;
  input chk2_subBNK2;
  output [BUF_COUNT-1:0] chk2_match;
  output [BUF_COUNT-1:0] chk2_partial;

  input chk3_en;
  input [BUF_COUNT-1:0][WIDTH-1:0] chk3_addrEO;
  input [3:0] chk3_odd;
  input [3:0] chk3_bytes;
  input chk3_subBNK;
  input chk3_subBNK2;
  output [BUF_COUNT-1:0] chk3_match;
  output [BUF_COUNT-1:0] chk3_partial;

  input chk4_en;
  input [BUF_COUNT-1:0][WIDTH-1:0] chk4_addrEO;
  input [3:0] chk4_odd;
  input [3:0] chk4_bytes;
  input chk4_subBNK;
  input chk4_subBNK2;
  output [BUF_COUNT-1:0] chk4_match;
  output [BUF_COUNT-1:0] chk4_partial;

  input chk5_en;
  input [BUF_COUNT-1:0][WIDTH-1:0] chk5_addrEO;
  input [3:0] chk5_odd;
  input [3:0] chk5_bytes;
  input chk5_subBNK;
  input chk5_subBNK2;
  output [BUF_COUNT-1:0] chk5_match;
  output [BUF_COUNT-1:0] chk5_partial;

  input [BUF_COUNT-1:0] upd0_en;
  input [BUF_COUNT-1:0] upd1_en;

  input  [BUF_COUNT-1:0] free_en;
  output [BUF_COUNT-1:0] free;
  output [BUF_COUNT-1:0] upd;
  output [BUF_COUNT-1:0] passe;
  input  [BUF_COUNT-1:0] passe_en;
  
  generate
      genvar t;
      for(t=0;t<BUF_COUNT;t=t+1) begin : buf_gen
          stq_buf_L buf_mod(
          clk,
          rst,
          stallA,
          excpt,
          wrt0_en[t], wrt0_odd, wrt0_bytes, wrt0_subBNK, wrt0_subBNK2, 
          wrt1_en[t], wrt1_odd, wrt1_bytes, wrt1_subBNK, wrt1_subBNK2, 
          chk0_en, chk0_addrEO[t], chk0_odd, chk0_bytes, chk0_subBNK, chk0_subBNK2, chk0_match[t], chk0_partial[t],
          chk1_en, chk1_addrEO[t], chk1_odd, chk1_bytes, chk1_subBNK, chk1_subBNK2, chk1_match[t], chk1_partial[t],
          chk2_en, chk2_addrEO[t], chk2_odd, chk2_bytes, chk2_subBNK, chk2_subBNK2, chk2_match[t], chk2_partial[t],
          chk3_en, chk3_addrEO[t], chk3_odd, chk3_bytes, chk3_subBNK, chk3_subBNK2, chk3_match[t], chk3_partial[t],
          chk4_en, chk4_addrEO[t], chk4_odd, chk4_bytes, chk4_subBNK, chk4_subBNK2, chk4_match[t], chk4_partial[t],
          chk5_en, chk5_addrEO[t], chk5_odd, chk5_bytes, chk5_subBNK, chk5_subBNK2, chk5_match[t], chk5_partial[t],
          upd0_en[t], 
          upd1_en[t], 
          free_en[t],free[t],upd[t],passe[t],passe_en[t]);
      end
  endgenerate
endmodule
