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

module stq(
  clk,
  rst,
  excpt,
  stall,
  doStall,
  aStall,
  aDoStall,
  rsStall,
  rsDoStall,
  chk0_adata,chk0_en,//chk0_LSQ,
  chk1_adata,chk1_en,//chk1_LSQ,
  chk2_adata,chk2_en,//chk2_LSQ,
  chk3_adata,chk3_en,//chk3_LSQ,
  chk4_adata,chk4_en,//chk4_LSQ,
  chk5_adata,chk5_en,//chk5_LSQ, 
  chk_rdy,
  LSQ_shr_data, 
  wrt0_adata,wrt0_en,wrt0_LSQ,
  wrt1_adata,wrt1_en,wrt1_LSQ,
  confl,confl_SMP,confl_X,
  upd0_WQ,upd0_en,upd0_data,upd0_pbit,//upd0_sz,
  upd1_WQ,upd1_en,upd1_data,upd1_pbit,//upd1_sz,
  pse0_en,
  pse1_en,
  wb1_adata,wb1_LSQ,wb1_data,wb1_pbit,wb1_bnkEn,wb1_en,wb1_way,
  wb0_adata,wb0_LSQ,wb0_data,wb0_pbit,wb0_bnkEn,wb0_en,
  WLN0_en,WLN0_adata,WLN0_data,WLN0_pbit,
  WLN1_en,WLN1_adata,WLN1_data,WLN1_pbit
  );
  input clk;

  input rst;

  input excpt;

  input stall;
  output doStall;

  input aStall;

  output aDoStall;

  input rsStall;
  output reg rsDoStall;

  input [`lsaddr_width-1:0] chk0_adata;
  input chk0_en;

  input [`lsaddr_width-1:0] chk1_adata;
  input chk1_en;

  input [`lsaddr_width-1:0] chk2_adata;
  input chk2_en;

  input [`lsaddr_width-1:0] chk3_adata;
  input chk3_en;

  input [`lsaddr_width-1:0] chk4_adata;
  input chk4_en;

  input [`lsaddr_width-1:0] chk5_adata;
  input chk5_en;

  input chk_rdy;

  input [`lsaddr_width-1:0] LSQ_shr_data;
  
  input [`lsaddr_width-1:0] wrt0_adata;
  input wrt0_en;
  input [8:0] wrt0_LSQ;

  input [`lsaddr_width-1:0] wrt1_adata;
  input wrt1_en;
  input [8:0] wrt1_LSQ;

  input [5:0] confl;
  input [5:0] confl_SMP;
  input [5:0] confl_X;

  input [5:0] upd0_WQ;
  input upd0_en;
  input [135:0] upd0_data;
  input [1:0] upd0_pbit;
//  input [4:0] upd0_sz;

  input [5:0] upd1_WQ;
  input upd1_en;
  input [135:0] upd1_data;
  input [1:0] upd1_pbit;
//  input [4:0] upd1_sz;

  input pse0_en;

  input pse1_en;

  output [`lsaddr_width-1:0] wb1_adata;
  output [8:0] wb1_LSQ;
  output [135:0] wb1_data;
  output [1:0] wb1_pbit;
  output [3:0] wb1_bnkEn;
  output wb1_en;
  output [1:0] wb1_way;

  output [`lsaddr_width-1:0] wb0_adata;
  output [8:0] wb0_LSQ;
  output [135:0] wb0_data;
  output [1:0] wb0_pbit;
  output [3:0] wb0_bnkEn;
  output wb0_en;
  
  output WLN0_en;
  output [`lsaddr_width-1:0] WLN0_adata;
  output [135:0] WLN0_data;
  output [1:0] WLN0_pbit;
  
  output WLN1_en;
  output [`lsaddr_width-1:0] WLN1_adata;
  output [135:0] WLN1_data;
  output [1:0] WLN1_pbit;
  
  reg [5:0] pse0_WQ;
  reg [5:0] pse1_WQ;
  wire [5:0] pse1_WQ_inc;
  wire [5:0] pse1_WQ_inc2;
  
  wire [135:0] WLN0_dataX;
  wire [135:0] WLN1_dataX;

  wire [5:0] WLN0_WQ;
  wire [5:0] WLN1_WQ;
  
  wire [7:0] chk0_subBNK;
  wire [7:0] chk1_subBNK;
  wire [7:0] chk2_subBNK;
  wire [7:0] chk3_subBNK;
  wire [7:0] chk4_subBNK;
  wire [7:0] chk5_subBNK;
  wire [7:0] wrt0_subBNK;
  wire [7:0] wrt1_subBNK;
  wire [7:0] chk0_subBNK2;
  wire [7:0] chk1_subBNK2;
  wire [7:0] chk2_subBNK2;
  wire [7:0] chk3_subBNK2;
  wire [7:0] chk4_subBNK2;
  wire [7:0] chk5_subBNK2;
  wire [7:0] wrt0_subBNK2;
  wire [7:0] wrt1_subBNK2;
  wire [3:0] chk0_odd0;
  wire [3:0] chk1_odd0;
  wire [3:0] chk2_odd0;
  wire [3:0] chk3_odd0;
  wire [3:0] chk4_odd0;
  wire [3:0] chk5_odd0;
  wire [3:0] wrt0_odd0;
  wire [3:0] wrt1_odd0;
  wire [3:0] chk0_odd1;
  wire [3:0] chk1_odd1;
  wire [3:0] chk2_odd1;
  wire [3:0] chk3_odd1;
  wire [3:0] chk4_odd1;
  wire [3:0] chk5_odd1;
  wire [3:0] wrt0_odd1;
  wire [3:0] wrt1_odd1;
  wire [63:0][1:0] chk0_addrOE;
  wire [63:0][1:0] chk1_addrOE;
  wire [63:0][1:0] chk2_addrOE;
  wire [63:0][1:0] chk3_addrOE;
  wire [63:0][1:0] chk4_addrOE;
  wire [63:0][1:0] chk5_addrOE;
  wire [31:0] chk0_banks;
  wire [31:0] chk1_banks;
  wire [31:0] chk2_banks;
  wire [31:0] chk3_banks;
  wire [31:0] chk4_banks;
  wire [31:0] chk5_banks;
  wire [31:0] wrt0_banks;
  wire [31:0] wrt1_banks;
  wire [31:0] chk0_banks2;
  wire [31:0] chk1_banks2;
  wire [31:0] chk2_banks2;
  wire [31:0] chk3_banks2;
  wire [31:0] chk4_banks2;
  wire [31:0] chk5_banks2;
  wire [31:0] wrt0_banks2;
  wire [31:0] wrt1_banks2;
  wire [63:0] WLN0_match;
  wire [63:0] WLN1_match;
  wire [63:0] wrt0_en0;
  wire [63:0] wrt1_en0;
  wire [63:0] upd0_en0;
  wire [63:0] upd1_en0;
  wire [63:0] passe_en;
  wire [63:0] passe;
  wire [63:0] free;
  wire [63:0] upd;
  
  wire [135:0] chk0_data;
  wire [135:0] chk1_data;
  wire [135:0] chk2_data;
  wire [135:0] chk3_data;
  wire [135:0] chk4_data;
  wire [135:0] chk5_data;
  wire [135:0] WLN0_data;
  wire [135:0] WLN1_data;
 
  wire [5:0][`lsaddr_width-1:0] chk_adata;

  wire [4:0] upd0_begin0;
  wire [4:0] upd1_begin0;

  wire [7:0][63:0] chk0_match;
  wire [7:0][63:0] chk1_match;
  wire [7:0][63:0] chk2_match;
  wire [7:0][63:0] chk3_match;
  wire [7:0][63:0] chk4_match;
  wire [7:0][63:0] chk5_match;
  wire [7:0][63:0] chk0_partial;
  wire [7:0][63:0] chk1_partial;
  wire [7:0][63:0] chk2_partial;
  wire [7:0][63:0] chk3_partial;
  wire [7:0][63:0] chk4_partial;
  wire [7:0][63:0] chk5_partial;
  wire [3:0][63:0] chk0_match_first;
  wire [3:0][63:0] chk1_match_first;
  wire [3:0][63:0] chk2_match_first;
  wire [3:0][63:0] chk3_match_first;
  wire [3:0][63:0] chk4_match_first;
  wire [3:0][63:0] chk5_match_first;

  wire [3:0][1:0] chk0_b;
  wire [3:0][1:0] chk1_b;
  wire [3:0][1:0] chk2_b;
  wire [3:0][1:0] chk3_b;
  wire [3:0][1:0] chk4_b;
  wire [3:0][1:0] chk5_b;
  wire [3:0][1:0] WLN0_b;
  wire [3:0][1:0] WLN1_b;
  wire [3:0][1:0] upd0_b;
  wire [3:0][1:0] upd1_b;
  wire [3:0][1:0] Rupd0_b;
  wire [3:0][1:0] Rupd1_b;

  wire [7:0] chk0_odd;
  wire [7:0] chk1_odd;
  wire [7:0] chk2_odd;
  wire [7:0] chk3_odd;
  wire [7:0] chk4_odd;
  wire [7:0] chk5_odd;
  wire [7:0] wrt0_odd;
  wire [7:0] wrt1_odd;

  wire [7:0][3:0] chk0_bytes;
  wire [7:0][3:0] chk1_bytes;
  wire [7:0][3:0] chk2_bytes;
  wire [7:0][3:0] chk3_bytes;
  wire [7:0][3:0] chk4_bytes;
  wire [7:0][3:0] chk5_bytes;
  wire [7:0][3:0] wrt0_bytes;
  wire [7:0][3:0] wrt1_bytes;

  wire [1:0] chk0_addrEO;
  wire [1:0] chk1_addrEO;
  wire [1:0] chk2_addrEO;
  wire [1:0] chk3_addrEO;
  wire [1:0] chk4_addrEO;
  wire [1:0] chk5_addrEO;

  wire [3:0][63:0] chk0_firstA;
  wire [3:0][63:0] chk1_firstA;
  wire [3:0][63:0] chk2_firstA;
  wire [3:0][63:0] chk3_firstA;
  wire [3:0][63:0] chk4_firstA;
  wire [3:0][63:0] chk5_firstA;
  wire [3:0][63:0] chk0_firstB;
  wire [3:0][63:0] chk1_firstB;
  wire [3:0][63:0] chk2_firstB;
  wire [3:0][63:0] chk3_firstB;
  wire [3:0][63:0] chk4_firstB;
  wire [3:0][63:0] chk5_firstB;
  wire [3:0] chk0_hasA;
  wire [3:0] chk1_hasA;
  wire [3:0] chk2_hasA;
  wire [3:0] chk3_hasA;
  wire [3:0] chk4_hasA;
  wire [3:0] chk5_hasA;
  wire [3:0] chk0_hasB;
  wire [3:0] chk1_hasB;
  wire [3:0] chk2_hasB;
  wire [3:0] chk3_hasB;
  wire [3:0] chk4_hasB;
  wire [3:0] chk5_hasB;

  wire [63:0] free_en;
  wire [63:0] free;

  wire [5:0] rdy=~confl&~confl_SMP&{chk5_en,chk4_en,chk3_en,chk2_en,chk1_en,chk0_en};
  wire [5:0] chk_wb={chk5_adata[`lsaddr_flag] & chk5_en,chk4_adata[`lsaddr_flag] & chk4_en,chk3_adata[`lsaddr_flag] & chk3_en,
      chk2_adata[`lsaddr_flag] & chk2_en,chk1_adata[`lsaddr_flag] & chk1_en,chk0_adata[`lsaddr_flag] & chk0_en};
  wire [5:0] chk_wb0;
  wire [5:0] chk_wb1;
  wire chk_wb0_has,chk_wb1_has,chk_wb2_has;
  reg [5:0] chk_mask;
  
  function [31:0] lowt;
      input [31:0] data;
      begin
          lowt=data&{data[0],data[31:1]};
      end
  endfunction
  function [0:0] get_ld_bytes;
      input [4:0] sz;
      input [31:0] banks;
      input [1:0] index;
      reg [31:0] first;
      reg [31:0] last;
      begin
          first=banks&~{banks[30:0],banks[31]};
          last=banks&~{banks[0],banks[31:0]};
          case (index)
              2'd0: begin
              end
              2'd1: begin
              end
              2'd2: begin
              end
              2'd3: begin
              end
          endcase
      end
  endfunction
  function [0:0] get_st_bytes;
      input [4:0] sz;
      input [31:0] banks;
      input [1:0] index;
      reg [31:0] first;
      reg [31:0] last;
      begin
          first=banks&~{banks[30:0],banks[31]};
          last=banks&~{banks[0],banks[31:0]};
          case (index)
              2'd0: begin
              end
              2'd1: begin
              end
              2'd2: begin
              end
              2'd3: begin
              end
          endcase
      end
  endfunction
  generate
      genvar a,b,x;
      for(b=0;b<8;b=b+1) begin : L
          assign chk0_subBNK[b]={chk0_banks[24+b],chk0_banks[16+b],chk0_banks[8+b],chk0_banks[0+b]};
          assign chk0_odd1[b]=chk0_banks[24+b] && |chk0_banks[3:0] ? chk0_odd0^4'b1 : chk0_odd0;

          assign chk1_subBNK[b]={chk1_banks[24+b],chk1_banks[16+b],chk1_banks[8+b],chk1_banks[0+b]};
          assign chk1_odd1[b]=chk1_banks[24+b] && |chk1_banks[3:0] ? chk1_odd0^4'b1 : chk1_odd0;

          assign chk2_subBNK[b]={chk2_banks[24+b],chk2_banks[16+b],chk2_banks[8+b],chk2_banks[0+b]};
          assign chk2_odd1[b]=chk2_banks[24+b] && |chk2_banks[3:0] ? chk2_odd0^4'b1 : chk2_odd0;

          assign chk3_subBNK[b]={chk3_banks[24+b],chk3_banks[16+b],chk3_banks[8+b],chk3_banks[0+b]};
          assign chk3_odd1[b]=chk3_banks[24+b] && |chk3_banks[3:0] ? chk3_odd0^4'b1 : chk3_odd0;

          assign chk4_subBNK[b]={chk4_banks[24+b],chk4_banks[16+b],chk4_banks[8+b],chk4_banks[0+b]};
          assign chk4_odd1[b]=chk4_banks[24+b] && |chk4_banks[3:0] ? chk4_odd0^4'b1 : chk4_odd0;

          assign chk5_subBNK[b]={chk5_banks[24+b],chk5_banks[16+b],chk5_banks[8+b],chk5_banks[0+b]};
          assign chk5_odd1[b]=chk5_banks[24+b] && |chk5_banks[3:0] ? chk5_odd0^4'b1 : chk5_odd0;
          
          assign wrt0_subBNK[b]={wrt0_banks[24+b],wrt0_banks[16+b],wrt0_banks[8+b],wrt0_banks[0+b]};
          assign wrt0_odd1[b]=wrt0_banks[24+b] && |wrt0_banks[3:0] ? wrt0_odd0^4'b1 : wrt0_odd0;

          assign wrt1_subBNK[b]={wrt1_banks[24+b],wrt1_banks[16+b],wrt1_banks[8+b],wrt1_banks[0+b]};
          assign wrt1_odd1[b]=wrt1_banks[24+b] && |wrt1_banks[3:0] ? wrt1_odd0^4'b1 : wrt1_odd0;

          assign chk0_subBNK2[b]={chk0_banks2[24+b],chk0_banks2[16+b],chk0_banks2[8+b],chk0_banks2[0+b]};
          assign chk1_subBNK2[b]={chk1_banks2[24+b],chk1_banks2[16+b],chk1_banks2[8+b],chk1_banks2[0+b]};
          assign chk2_subBNK2[b]={chk2_banks2[24+b],chk2_banks2[16+b],chk2_banks2[8+b],chk2_banks2[0+b]};
          assign chk3_subBNK2[b]={chk3_banks2[24+b],chk3_banks2[16+b],chk3_banks2[8+b],chk3_banks2[0+b]};
          assign chk4_subBNK2[b]={chk4_banks2[24+b],chk4_banks2[16+b],chk4_banks2[8+b],chk4_banks2[0+b]};
          assign chk5_subBNK2[b]={chk5_banks2[24+b],chk5_banks2[16+b],chk5_banks2[8+b],chk5_banks2[0+b]};
          assign wrt0_subBNK2[b]={wrt0_banks2[24+b],wrt0_banks2[16+b],wrt0_banks2[8+b],wrt0_banks2[0+b]};
          assign wrt1_subBNK2[b]={wrt1_banks2[24+b],wrt1_banks2[16+b],wrt1_banks2[8+b],wrt1_banks2[0+b]};

          if (b<4) begin
              bit_find_last_bit #(64) chkBit0A(chk0_match[b]&mask,chk0_firstA[b],chk0_hasA[b]);
              bit_find_last_bit #(64) chkBit0B(chk0_match[b]&~mask,chk0_firstB[b],chk0_hasB[b]);
              assign chk0_match_first[b]=chk0_hasA[b] ? chk0_firstA : chk0_firstB;
          end
          stq_buf_L_array arr0_mod(
          clk,
          rst,
          aStall|aDoStall,
          excpt,
          wrt0_en0, wrt0_odd1[b], wrt0_bytes[b], wrt0_subBNK[b], wrt0_subBNK2[b],
          wrt1_en0, wrt1_odd1[b], wrt1_bytes[b], wrt1_subBNK[b], wrt1_subBNK2[b],
          chk0_en, chk0_addrEO, chk0_odd1[b], chk0_bytes[b], chk0_subBNK[b], chk0_subBNK2[b], chk0_match[b][31:0], chk0_partial[b][31:0],
          chk1_en, chk1_addrEO, chk1_odd1[b], chk1_bytes[b], chk1_subBNK[b], chk1_subBNK2[b], chk1_match[b][31:0], chk1_partial[b][31:0],
          chk2_en, chk2_addrEO, chk2_odd1[b], chk2_bytes[b], chk2_subBNK[b], chk2_subBNK2[b], chk2_match[b][31:0], chk2_partial[b][31:0],
          chk3_en, chk3_addrEO, chk3_odd1[b], chk3_bytes[b], chk3_subBNK[b], chk3_subBNK2[b], chk3_match[b][31:0], chk3_partial[b][31:0],
          chk4_en, chk4_addrEO, chk4_odd1[b], chk4_bytes[b], chk4_subBNK[b], chk4_subBNK2[b], chk4_match[b][31:0], chk4_partial[b][31:0],
          chk5_en, chk5_addrEO, chk5_odd1[b], chk5_bytes[b], chk5_subBNK[b], chk5_subBNK2[b], chk5_match[b][31:0], chk5_partial[b][31:0],
          upd0_en0[31:0], 
          upd1_en0[31:0], 
          free_en[31:0],free[31:0],upd[31:0],passe[31:0],passe_en[31:0]);

          stq_buf_L_array arr1_mod(
          clk,
          rst,
          aStall|aDoStall,
          excpt,
          wrt0_en0, wrt0_odd[b], wrt0_bytes[b], wrt0_subBNK[b], wrt0_subBNK2[b],
          wrt1_en0, wrt1_odd[b], wrt1_bytes[b], wrt1_subBNK[b], wrt1_subBNK2[b],
          chk0_en, chk0_addrEO, chk0_odd[b], chk0_bytes[b], chk0_subBNK[b], chk0_subBNK2[b], chk0_match[b][63:32], chk0_partial[b][63:32],
          chk1_en, chk1_addrEO, chk1_odd[b], chk1_bytes[b], chk1_subBNK[b], chk1_subBNK2[b], chk1_match[b][63:32], chk1_partial[b][63:32],
          chk2_en, chk2_addrEO, chk2_odd[b], chk2_bytes[b], chk2_subBNK[b], chk2_subBNK2[b], chk2_match[b][63:32], chk2_partial[b][63:32],
          chk3_en, chk3_addrEO, chk3_odd[b], chk3_bytes[b], chk3_subBNK[b], chk3_subBNK2[b], chk3_match[b][63:32], chk3_partial[b][63:32],
          chk4_en, chk4_addrEO, chk4_odd[b], chk4_bytes[b], chk4_subBNK[b], chk4_subBNK2[b], chk4_match[b][63:32], chk4_partial[b][63:32],
          chk5_en, chk5_addrEO, chk5_odd[b], chk5_bytes[b], chk5_subBNK[b], chk5_subBNK2[b], chk5_match[b][63:32], chk5_partial[b][63:32],
          upd0_en0[63:32], 
          upd1_en0[63:32], 
          free_en[63:32],free[63:32],upd[63:32],passe[63:32],passe_en[63:32]);
          
          if (b<4)
          stq_data_array #(32+~b[0]) dat_mod(
          clk,
          rst,
          upd0_en0,{upd0_pbit[upd0_b[b][1]],upd0_data[32*Rupd0_b[b]+:32]},
          upd1_en0,{upd1_pbit[upd1_b[b][1]],upd1_data[32*Rupd1_b[b]+:32]},
          chk0_match_first[b],chk0_data[32*b+:32],
          chk1_match_first[b],chk1_data[32*b+:32],
          chk2_match_first[b],chk2_data[32*b+:32],
          chk3_match_first[b],chk3_data[32*b+:32],
          chk4_match_first[b],chk4_data[32*b+:32],
          chk5_match_first[b],chk5_data[32*b+:32],
          WLN0_match[b],{WLN0_pbit[WLN0_b[b]],WLN0_dataX[32*b+:32]},
          WLN1_match[b],{WLN1_pbit[WLN1_b[b]],WLN1_dataX[32*b+:32]}
          );
          
          if (b<4) begin
              assign WLN0_data[32*b+:32]=WLN0_dataX[32*WLN0_b[b]+:32];
              assign WLN1_data[32*b+:32]=WLN1_dataX[32*WLN1_b[b]+:32];
              assign WLN0_b[b]=-(WLN0_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign WLN1_b[b]=-(WLN1_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk0_b[b]=-(chk0_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk1_b[b]=-(chk1_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk2_b[b]=-(chk2_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk3_b[b]=-(chk3_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk4_b[b]=-(chk4_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk5_b[b]=-(chk5_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign upd0_b[b]=-(upd0_begin0&3)+b[1:0]; 
              assign upd1_b[b]=-(upd1_begin0&3)+b[1:0]; 
              assign Rupd0_b[b]=(upd0_begin0&3)+b[1:0]; 
              assign Rupd1_b[b]=(upd1_begin0&3)+b[1:0]; 
          end
          if (b==3)
          stq_data_array #(8) datX_mod(
          clk,
          rst,
          upd0_en0,upd0_data[135:128],
          upd1_en0,upd1_data[135:128],
          chk0_match_first[chk0_b[b]],chk0_data[135:128],
          chk1_match_first[chk1_b[b]],chk1_data[135:128],
          chk2_match_first[chk2_b[b]],chk2_data[135:128],
          chk3_match_first[chk3_b[b]],chk3_data[135:128],
          chk4_match_first[chk4_b[b]],chk4_data[135:128],
          chk5_match_first[chk5_b[b]],chk5_data[135:128],
          WLN0_match[b],WLN0_data[135:128],
          WLN1_match[b],WLN1_data[135:128]
          );

      end
      for(x=0;x<64;x=x+1) begin : X
          assign WLN0_match[x]=WLN0_adata[`lsaddr_WQ]==x && WLN0_en;
          assign WLN1_match[x]=WLN1_adata[`lsaddr_WQ]==x && WLN1_en;
          assign wrt0_en0[x]=wrt0_adata[`lsaddr_WQ]==x && wrt0_en;
          assign wrt1_en0[x]=wrt1_adata[`lsaddr_WQ]==x && wrt1_en;
          assign upd0_en0[x]=upd0_WQ==x && upd0_en;
          assign upd1_en0[x]=upd1_WQ==x && upd1_en;
          assign passe_en[x]=(pse0_WQ==x && pse0_en) || (pse1_WQ==x && pse1_en);
      end
      for(a=0;a<6;a=a+1) begin : wrt
          assign WLN0_en=LSQ_shr_data[`lsqshare_wrt0]==a ? &rdy[a:0] & chk_rdy : 1'bz;
          assign WLN1_en=LSQ_shr_data[`lsqshare_wrt1]==a ? &rdy[a:0] & chk_rdy : 1'bz;
          assign WLN0_adata=LSQ_shr_data[`lsqshare_wrt0]==a ? chk_adata[a] : {`lsaddr_width{1'bz}};
          assign WLN1_adata=LSQ_shr_data[`lsqshare_wrt1]==a ? chk_adata[a] : {`lsaddr_width{1'bz}};
          assign WLN0_WQ=LSQ_shr_data[`lsqshare_wrt0]==a ? chk_adata[a][`lsaddr_WQ] : {8{1'bz}};
          assign WLN1_WQ=LSQ_shr_data[`lsqshare_wrt1]==a ? chk_adata[a][`lsaddr_WQ] : {8{1'bz}};
	  assign wb0_adata=chk_wb[a] ? chk_adata[a] : {`lsaddr_width{1'bz}};
	  assign wb1_adata=chk_wb1[a] ? chk_adata[a] : {`lsaddr_width{1'bz}};
      end
  endgenerate
  assign wb0_adata=chk_wb_has ? {`lsaddr_width{1'bz}} : {`lsaddr_width{1'b0}};
  assign wb1_adata=chk_wb1_has ? {`lsaddr_width{1'bz}} : {`lsaddr_width{1'b0}};
  assign wb0_en=chk_wb_has;
  assign wb1_en=chk_wb1_has;

  assign aDoStall=|chk0_partial || |chk1_partial || |chk2_partial || |chk3_partial || |chk4_partial || |chk5_partial || chk_wb2_has;
  assign WLN0_en=LSQ_shr_data[`lsqshare_wrt0]==3'd7 ? 1'b0 : 1'bz;
  assign WLN1_en=LSQ_shr_data[`lsqshare_wrt1]==3'd7 ? 1'b0 : 1'bz;
  assign WLN0_adata=LSQ_shr_data[`lsqshare_wrt0]==3'd7 ? {`lsaddr_width{1'b0}} : {`lsaddr_width{1'bz}};
  assign WLN1_adata=LSQ_shr_data[`lsqshare_wrt1]==3'd7 ? {`lsaddr_width{1'b0}} : {`lsaddr_width{1'bz}};
  assign WLN0_WQ=LSQ_shr_data[`lsqshare_wrt0]==3'd7 ? 8'b0 : 8'bz;
  assign WLN1_WQ=LSQ_shr_data[`lsqshare_wrt1]==3'd7 ? 8'b0 : 8'bz;
  
  assign chk0_banks=(chk0_adata[`lsaddr_sz]==5'h11 || chk0_adata[`lsaddr_sz]==5'h10 || chk0_adata[`lsaddr_low]==2'b0) ?
    chk0_adata[`lsaddr_banks] : lowt(chk0_adata[`lsaddr_banks]);
  assign chk0_odd0[2:0]=(chk0_adata[`lsaddr_sz]==5'h11 || chk0_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk0_odd} : {chk0_adata[`lsaddr_low],chk0_odd}; 
  assign chk0_odd0[3]=chk0_adata[`lsaddr_sz]==5'hf;

  assign chk1_banks=(chk1_adata[`lsaddr_sz]==5'h11 || chk1_adata[`lsaddr_sz]==5'h10 || chk1_adata[`lsaddr_low]==2'b0) ?
    chk1_adata[`lsaddr_banks] : lowt(chk1_adata[`lsaddr_banks]);
  assign chk1_odd0[2:0]=(chk1_adata[`lsaddr_sz]==5'h11 || chk1_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk1_odd} : {chk1_adata[`lsaddr_low],chk1_odd}; 
  assign chk1_odd0[3]=chk1_adata[`lsaddr_sz]==5'hf;

  assign chk2_banks=(chk2_adata[`lsaddr_sz]==5'h11 || chk2_adata[`lsaddr_sz]==5'h10 || chk2_adata[`lsaddr_low]==2'b0) ?
    chk2_adata[`lsaddr_banks] : lowt(chk2_adata[`lsaddr_banks]);
  assign chk2_odd0[2:0]=(chk2_adata[`lsaddr_sz]==5'h11 || chk2_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk2_odd} : {chk2_adata[`lsaddr_low],chk2_odd}; 
  assign chk2_odd0[3]=chk2_adata[`lsaddr_sz]==5'hf;

  assign chk3_banks=(chk3_adata[`lsaddr_sz]==5'h11 || chk3_adata[`lsaddr_sz]==5'h10 || chk3_adata[`lsaddr_low]==2'b0) ?
    chk3_adata[`lsaddr_banks] : lowt(chk3_adata[`lsaddr_banks]);
  assign chk3_odd0[2:0]=(chk3_adata[`lsaddr_sz]==5'h11 || chk3_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk3_odd} : {chk3_adata[`lsaddr_low],chk3_odd}; 
  assign chk3_odd0[3]=chk3_adata[`lsaddr_sz]==5'hf;

  assign chk4_banks=(chk4_adata[`lsaddr_sz]==5'h11 || chk4_adata[`lsaddr_sz]==5'h10 || chk4_adata[`lsaddr_low]==2'b0) ?
    chk4_adata[`lsaddr_banks] : lowt(chk4_adata[`lsaddr_banks]);
  assign chk4_odd0[2:0]=(chk4_adata[`lsaddr_sz]==5'h11 || chk4_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk4_odd} : {chk4_adata[`lsaddr_low],chk4_odd}; 
  assign chk4_odd0[3]=chk4_adata[`lsaddr_sz]==5'hf;

  assign chk5_banks=(chk5_adata[`lsaddr_sz]==5'h11 || chk5_adata[`lsaddr_sz]==5'h10 || chk5_adata[`lsaddr_low]==2'b0) ?
    chk5_adata[`lsaddr_banks] : lowt(chk5_adata[`lsaddr_banks]);
  assign chk5_odd0[2:0]=(chk5_adata[`lsaddr_sz]==5'h11 || chk5_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk5_odd} : {chk5_adata[`lsaddr_low],chk5_odd}; 
  assign chk5_odd0[3]=chk5_adata[`lsaddr_sz]==5'hf;
  
  assign wrt0_banks=(wrt0_adata[`lsaddr_sz]==5'h11 || wrt0_adata[`lsaddr_sz]==5'h10 || wrt0_adata[`lsaddr_low]==2'b0) ?
    wrt0_adata[`lsaddr_banks] : lowt(wrt0_adata[`lsaddr_banks]);
  assign wrt0_odd0[2:0]=(wrt0_adata[`lsaddr_sz]==5'h11 || wrt0_adata[`lsaddr_sz]==5'h10) ? {2'b0,wrt0_odd} : {wrt0_adata[`lsaddr_low],wrt0_odd}; 
  assign wrt0_odd0[3]=wrt0_adata[`lsaddr_sz]==5'hf;

  assign wrt1_banks=(wrt1_adata[`lsaddr_sz]==5'h11 || wrt1_adata[`lsaddr_sz]==5'h10 || wrt1_adata[`lsaddr_low]==2'b0) ?
    wrt1_adata[`lsaddr_banks] : lowt(wrt1_adata[`lsaddr_banks]);
  assign wrt1_odd0[2:0]=(wrt1_adata[`lsaddr_sz]==5'h11 || wrt1_adata[`lsaddr_sz]==5'h10) ? {2'b0,wrt1_odd} : {wrt1_adata[`lsaddr_low],wrt1_odd}; 
  assign wrt1_odd0[3]=wrt1_adata[`lsaddr_sz]==5'hf;
  
  assign chk0_banks=chk0_adata[`lsaddr_banks];
  assign chk1_banks=chk1_adata[`lsaddr_banks];
  assign chk2_banks=chk2_adata[`lsaddr_banks];
  assign chk3_banks=chk3_adata[`lsaddr_banks];
  assign chk4_banks=chk4_adata[`lsaddr_banks];
  assign chk5_banks=chk5_adata[`lsaddr_banks];
  assign wrt0_banks=wrt0_adata[`lsaddr_banks];
  assign wrt1_banks=wrt1_adata[`lsaddr_banks];

  assign chk_adata[0]=chk0_adata;
  assign chk_adata[1]=chk1_adata;
  assign chk_adata[2]=chk2_adata;
  assign chk_adata[3]=chk3_adata;
  assign chk_adata[4]=chk4_adata;
  assign chk_adata[5]=chk5_adata;

  bit_find_first_bit #(6) first_wb_mod(chk_wb&~chk_wb_mask,chk_wb0,chk_wb0_has);
  bit_find_first_bit #(6) first_wb1_mod(chk_wb&~chk_wb0&~chk_wb_mask,chk_wb1,chk_wb1_has);

  assign chk_wb2_has=(chk_wb&~chk_wb0&~chk_wb_mask&~chk_wb1)!=6'd0;
  
  stq_buf_A_array A0_mod(
  clk,
  rst,
  aStall|aDoStall,
  excpt,
  wrt0_en0[31:0], wrt0_adata[`lsaddr_addrE], wrt0_adata[`lsaddr_addrO], 
  wrt1_en0[31:0], wrt1_adata[`lsaddr_addrE], wrt1_adata[`lsaddr_addrO], 
  chk0_en, chk0_addrEO[31:0], chk0_adata[`lsaddr_addrE], chk0_adata[`lsaddr_addrO],
  chk1_en, chk1_addrEO[31:0], chk1_adata[`lsaddr_addrE], chk1_adata[`lsaddr_addrO],
  chk2_en, chk2_addrEO[31:0], chk2_adata[`lsaddr_addrE], chk2_adata[`lsaddr_addrO],
  chk3_en, chk3_addrEO[31:0], chk3_adata[`lsaddr_addrE], chk3_adata[`lsaddr_addrO],
  chk4_en, chk4_addrEO[31:0], chk4_adata[`lsaddr_addrE], chk4_adata[`lsaddr_addrO],
  chk5_en, chk5_addrEO[31:0], chk5_adata[`lsaddr_addrE], chk5_adata[`lsaddr_addrO],
  upd0_en[31:0], 
  upd1_en[31:0], 
  free_en[31:0],,,,passe_en[31:0]);

  stq_buf_A_array A1_mod(
  clk,
  rst,
  aStall|aDoStall,
  excpt,
  wrt0_en0[63:32], wrt0_adata[`lsaddr_addrE], wrt0_adata[`lsaddr_addrO], 
  wrt1_en0[63:32], wrt1_adata[`lsaddr_addrE], wrt1_adata[`lsaddr_addrO], 
  chk0_en, chk0_addrEO[63:32], chk0_adata[`lsaddr_addrE], chk0_adata[`lsaddr_addrO],
  chk1_en, chk1_addrEO[63:32], chk1_adata[`lsaddr_addrE], chk1_adata[`lsaddr_addrO],
  chk2_en, chk2_addrEO[63:32], chk2_adata[`lsaddr_addrE], chk2_adata[`lsaddr_addrO],
  chk3_en, chk3_addrEO[63:32], chk3_adata[`lsaddr_addrE], chk3_adata[`lsaddr_addrO],
  chk4_en, chk4_addrEO[63:32], chk4_adata[`lsaddr_addrE], chk4_adata[`lsaddr_addrO],
  chk5_en, chk5_addrEO[63:32], chk5_adata[`lsaddr_addrE], chk5_adata[`lsaddr_addrO],
  upd0_en[63:32], 
  upd1_en[63:32], 
  free_en[63:32],,,,passe_en[63:32]);
  
  stq_adata bgn_mod(
  clk,
  rst,
  wrt0_en,wrt0_WQ,wrt0_adata[`lsaddr_bank0],
  wrt1_en,wrt1_WQ,wrt1_adata[`lsaddr_bank0],
  upd0_WQ,upd0_begin0,
  upd1_WQ,upd1_begin0);

  adder_inc #(6) inc_pseA_mod(pse1_WQ,pse1_WQ_inc,1'b1,);
  adder_inc #(5) inc_pseB_mod(pse1_WQ[5:1],pse1_WQ_inc2[5:1],1'b1,);
  assign pse1_WQ_inc2[0]=pse1_WQ[0];

  always @(posedge clk) begin
      if (rst) begin
	  pse0_WQ<=6'd0;
	  pse1_WQ<=6'd0;
	  chk_mask<=6'd0;
      end else begin
	  if (!stall && !doStall && pse0_en && ~pse1_en) begin
	      pse0_WQ<=pse1_WQ;
	      pse1_WQ<=pse1_WQ_inc;
	  end else if (!stall && !doStall && pse0_en) begin
	      pse0_WQ<=pse1_WQ_inc;
	      pse1_WQ<=pse1_WQ_inc2;
	  end
	  if (!aStall && !aDoStall && chk_en) begin
	      chk_mask<=6'd0;
	  end else if (!rs_stall) begin
	      chk_mask<=chk_mask|chk_wb0|chk_wb1;
	  end
      end
  end
endmodule
