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

//compile stq to hard macro with 1x horizontal x2 wire and 1x vertical x2 wire
//do not delete redundant outputs

module stq(
  clk,
  rst,
  excpt,
  stall,
  doStall,
  aStall,
  aDoStall,
  st_stall,
  rsStall,
  rsDoStall,//needs to get registered again outside module
  do_retire,
  ret_xbreak,
  ret_II,
  ret_II_out,
  chk0_adata,chk0_en,chk0_enD,
  chk1_adata,chk1_en,chk1_enD,
  chk2_adata,chk2_en,chk2_enD,
  chk3_adata,chk3_en,chk3_enD,
  chk4_adata,chk4_en,chk4_enD,
  chk5_adata,chk5_en,chk5_enD, 
  chk_rdy,
  LSQ_shr_data, 
  wrt0_adata,wrt0_en,wrt0_LSQ,
  wrt1_adata,wrt1_en,wrt1_LSQ,
  confl,confl_SMP,confl_X,
  confl_out,
  upd0_WQ,upd0_en,upd0_data,upd0_pbit,//upd0_sz,//store data
  upd1_WQ,upd1_en,upd1_data,upd1_pbit,//upd1_sz,//store data 2
  pse0_en,
  pse1_en,
  wb1_adata,wb1_LSQ,wb1_data,wb1_dataN,wb1_pbit,wb1_bnkEn,wb1_bnkEnS,wb1_en,wb1_chk,
  wb0_adata,wb0_LSQ,wb0_data,wb0_dataN,wb0_pbit,wb0_bnkEn,wb0_bnkEnS,wb0_en,wb0_chk,wb0_way,
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

  input st_stall;

  input rsStall;
  output reg [3:0] rsDoStall;

  input do_retire;
  input [15:0] ret_xbreak;
  input [5:0] ret_II;
  output [5:0] ret_II_out;

  input [`lsaddr_width-1:0] chk0_adata;
  input chk0_en;
  input [1:0] chk0_enD;

  input [`lsaddr_width-1:0] chk1_adata;
  input chk1_en;
  input [1:0] chk1_enD;

  input [`lsaddr_width-1:0] chk2_adata;
  input chk2_en;
  input [1:0] chk2_enD;

  input [`lsaddr_width-1:0] chk3_adata;
  input chk3_en;
  input [1:0] chk3_enD;

  input [`lsaddr_width-1:0] chk4_adata;
  input chk4_en;
  input [1:0] chk4_enD;

  input [`lsaddr_width-1:0] chk5_adata;
  input chk5_en;
  input [1:0] chk5_enD;

  input chk_rdy;

  input [`lsqshare_width-1:0] LSQ_shr_data;
  
  input [`lsaddr_width-1:0] wrt0_adata;
  input wrt0_en;
  input [8:0] wrt0_LSQ;

  input [`lsaddr_width-1:0] wrt1_adata;
  input wrt1_en;
  input [8:0] wrt1_LSQ;

  input [5:0] confl;
  input [5:0] confl_SMP;
  input [5:0] confl_X;
  output reg [5:0] confl_out;

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

  output reg [`lsaddr_width-1:0] wb1_adata;
  output [8:0] wb1_LSQ;
  output [135:0] wb1_data;
  output [135:0] wb1_dataN;
  output reg [1:0] wb1_pbit;
  output [16:0] wb1_bnkEn;
  output [16:0] wb1_bnkEnS;
  output wb1_en;
  output [5:0] wb1_chk;

  output reg [`lsaddr_width-1:0] wb0_adata;
  output [8:0] wb0_LSQ;
  output [135:0] wb0_data;
  output [135:0] wb0_dataN;
  output reg [1:0] wb0_pbit;
  output [16:0] wb0_bnkEn;
  output [16:0] wb0_bnkEnS;
  output wb0_en;
  output [5:0] wb0_chk;
  output [1:0] wb0_way;
  
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
  wire [5:0] WLN1_WQ_inc;
  wire [5:0] WLN1_WQ_inc2;
  
  wire [139:0] WLN0_dataX;
  wire [139:0] WLN1_dataX;

  wire [5:0] confl0;

  reg [5:0] WLN0_WQ;
  reg [5:0] WLN1_WQ;
  wire [5:0] WNL0_WQ;
  wire [5:0] WNL1_WQ;
  wire [`lsaddr_width-1:0] WLN0_adata0;
  wire [`lsaddr_width-1:0] WLN1_adata0;
  wire WLN0_en0;
  wire WLN1_en0;
  wire [`lsaddr_width-1:0] WNL0_adata;
  wire [`lsaddr_width-1:0] WNL1_adata;
  wire WNL0_en;
  wire WNL1_en;
	  
  reg [5:0] chk_wb0_reg;
  reg [5:0] chk_wb0_reg2;
  reg  chk_wb0_has_reg;
  reg  chk_wb0_has_reg2;
  reg [5:0][16:0] chk_bytes_reg;
  reg [5:0][16:0] chk_bytes_reg2;
  reg [5:0] chk_wb1_reg;
  reg [5:0] chk_wb1_reg2;
  reg  chk_wb1_has_reg;
  reg  chk_wb1_has_reg2;
  
  wire [7:0] chk0_subBNK;
  wire [7:0] chk1_subBNK;
  wire [7:0] chk2_subBNK;
  wire [7:0] chk3_subBNK;
  wire [7:0] chk4_subBNK;
  wire [7:0] chk5_subBNK;
  wire [7:0] WNL0_subBNK;
  wire [7:0] WNL1_subBNK;
  wire [7:0] chk0_subBNK2;
  wire [7:0] chk1_subBNK2;
  wire [7:0] chk2_subBNK2;
  wire [7:0] chk3_subBNK2;
  wire [7:0] chk4_subBNK2;
  wire [7:0] chk5_subBNK2;
  wire [7:0] WNL0_subBNK2;
  wire [7:0] WNL1_subBNK2;
  wire [3:0] chk0_odd0;
  wire [3:0] chk1_odd0;
  wire [3:0] chk2_odd0;
  wire [3:0] chk3_odd0;
  wire [3:0] chk4_odd0;
  wire [3:0] chk5_odd0;
  wire [3:0] WNL0_odd0;
  wire [3:0] WNL1_odd0;
  wire [7:0][3:0] chk0_odd1;
  wire [7:0][3:0] chk1_odd1;
  wire [7:0][3:0] chk2_odd1;
  wire [7:0][3:0] chk3_odd1;
  wire [7:0][3:0] chk4_odd1;
  wire [7:0][3:0] chk5_odd1;
  wire [7:0][3:0] WNL0_odd1;
  wire [7:0][3:0] WNL1_odd1;
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
  wire [31:0] WNL0_banks;
  wire [31:0] WNL1_banks;
  wire [31:0] chk0_banks2;
  wire [31:0] chk1_banks2;
  wire [31:0] chk2_banks2;
  wire [31:0] chk3_banks2;
  wire [31:0] chk4_banks2;
  wire [31:0] chk5_banks2;
  wire [31:0] WNL0_banks2;
  wire [31:0] WNL1_banks2;
  wire [63:0] WLN0_match;
  wire [63:0] WLN1_match;
  wire [63:0] WNL0_en0;
  wire [63:0] WNL1_en0;
  wire [63:0] wrt0_en0;
  wire [63:0] wrt1_en0;
  wire [63:0] upd0_en0;
  wire [63:0] upd1_en0;
  wire [63:0] passe_en;
  wire [63:0] passe;
  wire [63:0] free;
  wire [63:0] upd;

  
  wire [5:0][139:0] chk_data;
  wire [5:0][1:0] chk_pbit;
  wire [5:0][16:0] chk_bytes;
  wire [135:0] wb0_dataW;
  wire [1:0]  wb0_pbitW;
  wire [16:0] wb0_bytesW;
  wire [16:0] wb0_bytesX;
  wire [135:0] wb1_dataW;
  wire [1:0]  wb1_pbitW;
  wire [16:0] wb1_bytesW;
  wire [16:0] wb1_bytesX;
  wire [135:0] WLN0_data;
  wire [135:0] WLN1_data;

  wire [5:0][`lsaddr_width-1:0] chk_adata;
  wire [`lsaddr_width-1:0] wb0_adataW;
  wire [`lsaddr_width-1:0] wb1_adataW;
  reg  [`lsaddr_width-1:0] wb0_adataW_reg;
  reg  [`lsaddr_width-1:0] wb1_adataW_reg;
  wire [135:0] wb0_dataW;
  wire [135:0] wb1_dataW;
  reg [135:0] wb0_dataW_reg;
  reg [135:0] wb1_dataW_reg;


  wire [4:0] upd0_begin0;
  wire [4:0] upd1_begin0;

  wire chk0_pre0,chk0_pre1;
  wire chk1_pre0,chk1_pre1;
  wire chk2_pre0,chk2_pre1;
  wire chk3_pre0,chk3_pre1;
  wire chk4_pre0,chk4_pre1;
  wire chk5_pre0,chk5_pre1;

  wire [3:0] chk0_match_has;
  wire [3:0] chk1_match_has;
  wire [3:0] chk2_match_has;
  wire [3:0] chk3_match_has;
  wire [3:0] chk4_match_has;
  wire [3:0] chk5_match_has;

  wire [5:0][1:0] chk_enD;

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
  wire [7:0][1:0] chk0_matchW;
  wire [7:0][1:0] chk1_matchW;
  wire [7:0][1:0] chk2_matchW;
  wire [7:0][1:0] chk3_matchW;
  wire [7:0][1:0] chk4_matchW;
  wire [7:0][1:0] chk5_matchW;
  wire [7:0][1:0] chk0_partialW;
  wire [7:0][1:0] chk1_partialW;
  wire [7:0][1:0] chk2_partialW;
  wire [7:0][1:0] chk3_partialW;
  wire [7:0][1:0] chk4_partialW;
  wire [7:0][1:0] chk5_partialW;
  wire [7:0][1:0] chk0_matchW2;
  wire [7:0][1:0] chk1_matchW2;
  wire [7:0][1:0] chk2_matchW2;
  wire [7:0][1:0] chk3_matchW2;
  wire [7:0][1:0] chk4_matchW2;
  wire [7:0][1:0] chk5_matchW2;
  wire [7:0][1:0] chk0_partialW2;
  wire [7:0][1:0] chk1_partialW2;
  wire [7:0][1:0] chk2_partialW2;
  wire [7:0][1:0] chk3_partialW2;
  wire [7:0][1:0] chk4_partialW2;
  wire [7:0][1:0] chk5_partialW2;

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

  wire chk0_odd;
  wire chk1_odd;
  wire chk2_odd;
  wire chk3_odd;
  wire chk4_odd;
  wire chk5_odd;
  wire WNL0_odd;
  wire WNL1_odd;

  wire [7:0][3:0] chk0_bytes;
  wire [7:0][3:0] chk1_bytes;
  wire [7:0][3:0] chk2_bytes;
  wire [7:0][3:0] chk3_bytes;
  wire [7:0][3:0] chk4_bytes;
  wire [7:0][3:0] chk5_bytes;
  wire [7:0][3:0] WNL0_bytes;
  wire [7:0][3:0] WNL1_bytes;

  wire [63:0][1:0] chk0_addrEO;
  wire [63:0][1:0] chk1_addrEO;
  wire [63:0][1:0] chk2_addrEO;
  wire [63:0][1:0] chk3_addrEO;
  wire [63:0][1:0] chk4_addrEO;
  wire [63:0][1:0] chk5_addrEO;

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

  wire [5:0] rdy={chk5_en,chk4_en,chk3_en,chk2_en,chk1_en,chk0_en};
  wire [5:0] chk_wb={chk5_adata[`lsaddr_flag] & chk5_en,chk4_adata[`lsaddr_flag] & chk4_en,chk3_adata[`lsaddr_flag] & chk3_en,
      chk2_adata[`lsaddr_flag] & chk2_en,chk1_adata[`lsaddr_flag] & chk1_en,chk0_adata[`lsaddr_flag] & chk0_en};
  wire [5:0] chk_wb0;
  wire [5:0] chk_wb1;
  wire chk_wb0_has,chk_wb1_has,chk_wb2_has;
  reg [5:0] chk_mask;
  reg [63:0] mask;
  reg [63:0] nmask;
  reg [63:0] mask2;
  
  function [31:0] lowt;
      input [31:0] data;
      begin
          lowt=data&{data[0],data[31:1]};
      end
  endfunction
  function [3:0] get_ld_bytes;
      input [4:0] sz;
      input [7:0] banks;
      input [2:0] index;
      input [1:0] low;
      reg [7:0] first;
      reg [7:0] last;
      begin
          first=banks&~{banks[6:0],banks[7]};
          last=banks&~{banks[0],banks[7:1]};
	  get_ld_bytes=4'b0;
	  if (first[index]) begin
	      case(sz)
		  5'h10:get_ld_bytes[low]=1'b1;
		  5'h11:begin
			  get_ld_bytes[low]=1'b1;
			  if (low!=2'b11) get_ld_bytes[low+1]=1'b1;
		  end
	          default:get_ld_bytes=4'b1111;
	      endcase
	  end else if (last[index]) begin
	      case(sz)
		  5'h11:begin
			  if (low==2'b11) get_ld_bytes[0]=1'b1;
		  end
	          5'h3: get_ld_bytes=4'b11;
	          default:get_ld_bytes=4'b1111;
	      endcase
           end else begin
	      get_ld_bytes=4'hf;
           end
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
          last=banks&~{banks[0],banks[31:1]};
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
      wire [3:0][32:0] WLN0_dataX0;
      wire [3:0][32:0] WLN1_dataX0;
      wire [3:0][32:0] chk0_data0;
      wire [3:0][32:0] chk1_data0;
      wire [3:0][32:0] chk2_data0;
      wire [3:0][32:0] chk3_data0;
      wire [3:0][32:0] chk4_data0;
      wire [3:0][32:0] chk5_data0;
  generate
      genvar a,b,x;
      for(b=0;b<8;b=b+1) begin : L
          assign chk0_subBNK[b]=|{chk0_banks[24+b],chk0_banks[16+b],chk0_banks[8+b],chk0_banks[0+b]};
          assign chk0_odd1[b]=chk0_banks[24+b] && |chk0_banks[3:0] ? chk0_odd0^4'b1 : chk0_odd0;

          assign chk1_subBNK[b]=|{chk1_banks[24+b],chk1_banks[16+b],chk1_banks[8+b],chk1_banks[0+b]};
          assign chk1_odd1[b]=chk1_banks[24+b] && |chk1_banks[3:0] ? chk1_odd0^4'b1 : chk1_odd0;

          assign chk2_subBNK[b]=|{chk2_banks[24+b],chk2_banks[16+b],chk2_banks[8+b],chk2_banks[0+b]};
          assign chk2_odd1[b]=chk2_banks[24+b] && |chk2_banks[3:0] ? chk2_odd0^4'b1 : chk2_odd0;

          assign chk3_subBNK[b]=|{chk3_banks[24+b],chk3_banks[16+b],chk3_banks[8+b],chk3_banks[0+b]};
          assign chk3_odd1[b]=chk3_banks[24+b] && |chk3_banks[3:0] ? chk3_odd0^4'b1 : chk3_odd0;

          assign chk4_subBNK[b]=|{chk4_banks[24+b],chk4_banks[16+b],chk4_banks[8+b],chk4_banks[0+b]};
          assign chk4_odd1[b]=chk4_banks[24+b] && |chk4_banks[3:0] ? chk4_odd0^4'b1 : chk4_odd0;

          assign chk5_subBNK[b]=|{chk5_banks[24+b],chk5_banks[16+b],chk5_banks[8+b],chk5_banks[0+b]};
          assign chk5_odd1[b]=chk5_banks[24+b] && |chk5_banks[3:0] ? chk5_odd0^4'b1 : chk5_odd0;
          
          assign WNL0_subBNK[b]=|{WNL0_banks[24+b],WNL0_banks[16+b],WNL0_banks[8+b],WNL0_banks[0+b]};
          assign WNL0_odd1[b]=WNL0_banks[24+b] && |WNL0_banks[3:0] ? WNL0_odd0^4'b1 : WNL0_odd0;

          assign WNL1_subBNK[b]=|{WNL1_banks[24+b],WNL1_banks[16+b],WNL1_banks[8+b],WNL1_banks[0+b]};
          assign WNL1_odd1[b]=WNL1_banks[24+b] && |WNL1_banks[3:0] ? WNL1_odd0^4'b1 : WNL1_odd0;

          assign chk0_subBNK2[b]=|{chk0_banks2[24+b],chk0_banks2[16+b],chk0_banks2[8+b],chk0_banks2[0+b]};
          assign chk1_subBNK2[b]=|{chk1_banks2[24+b],chk1_banks2[16+b],chk1_banks2[8+b],chk1_banks2[0+b]};
          assign chk2_subBNK2[b]=|{chk2_banks2[24+b],chk2_banks2[16+b],chk2_banks2[8+b],chk2_banks2[0+b]};
          assign chk3_subBNK2[b]=|{chk3_banks2[24+b],chk3_banks2[16+b],chk3_banks2[8+b],chk3_banks2[0+b]};
          assign chk4_subBNK2[b]=|{chk4_banks2[24+b],chk4_banks2[16+b],chk4_banks2[8+b],chk4_banks2[0+b]};
          assign chk5_subBNK2[b]=|{chk5_banks2[24+b],chk5_banks2[16+b],chk5_banks2[8+b],chk5_banks2[0+b]};
          assign WNL0_subBNK2[b]=|{WNL0_banks2[24+b],WNL0_banks2[16+b],WNL0_banks2[8+b],WNL0_banks2[0+b]};
          assign WNL1_subBNK2[b]=|{WNL1_banks2[24+b],WNL1_banks2[16+b],WNL1_banks2[8+b],WNL1_banks2[0+b]};

	  assign chk0_bytes[b]=get_ld_bytes(chk0_adata[`lsaddr_sz],chk0_subBNK,b[2:0],chk0_adata[`lsaddr_low]);
	  assign chk1_bytes[b]=get_ld_bytes(chk1_adata[`lsaddr_sz],chk1_subBNK,b[2:0],chk1_adata[`lsaddr_low]);
	  assign chk2_bytes[b]=get_ld_bytes(chk2_adata[`lsaddr_sz],chk2_subBNK,b[2:0],chk2_adata[`lsaddr_low]);
	  assign chk3_bytes[b]=get_ld_bytes(chk3_adata[`lsaddr_sz],chk3_subBNK,b[2:0],chk3_adata[`lsaddr_low]);
	  assign chk4_bytes[b]=get_ld_bytes(chk4_adata[`lsaddr_sz],chk4_subBNK,b[2:0],chk4_adata[`lsaddr_low]);
	  assign chk5_bytes[b]=get_ld_bytes(chk5_adata[`lsaddr_sz],chk5_subBNK,b[2:0],chk5_adata[`lsaddr_low]);
	  assign WNL0_bytes[b]=get_ld_bytes(WNL0_adata[`lsaddr_sz],WNL0_subBNK,b[2:0],WNL0_adata[`lsaddr_low]);
	  assign WNL1_bytes[b]=get_ld_bytes(WNL1_adata[`lsaddr_sz],WNL1_subBNK,b[2:0],WNL1_adata[`lsaddr_low]);

          if (b<4) begin
              bit_find_last_bit #(64) chkBit0A(chk0_match[b]&mask,chk0_firstA[b],chk0_hasA[b]);
              bit_find_last_bit #(64) chkBit0B(chk0_match[b]&~mask,chk0_firstB[b],chk0_hasB[b]);
              assign chk0_match_first[b]=chk0_hasA[b] ? chk0_firstA[b]|chk0_firstA[b+4] : chk0_firstB[b]|chk0_firstB[b+4];
	      assign chk0_match_has[b]=chk0_hasA[b] | chk0_hasB[b] | chk0_hasA[b+4] | chk0_hasB[b+4];
              bit_find_last_bit #(64) chkBit1A(chk1_match[b]&mask,chk1_firstA[b],chk1_hasA[b]);
              bit_find_last_bit #(64) chkBit1B(chk1_match[b]&~mask,chk1_firstB[b],chk1_hasB[b]);
              assign chk1_match_first[b]=chk1_hasA[b] ? chk1_firstA[b]|chk1_firstA[b+4] : chk1_firstB[b]|chk1_firstB[b+4];
	      assign chk1_match_has[b]=chk1_hasA[b] | chk1_hasB[b] | chk1_hasA[b+4] | chk1_hasB[b+4];
              bit_find_last_bit #(64) chkBit2A(chk2_match[b]&mask,chk2_firstA[b],chk2_hasA[b]);
              bit_find_last_bit #(64) chkBit2B(chk2_match[b]&~mask,chk2_firstB[b],chk2_hasB[b]);
              assign chk2_match_first[b]=chk2_hasA[b] ? chk2_firstA[b]|chk2_firstA[b+4] : chk2_firstB[b]|chk2_firstB[b+4];
	      assign chk2_match_has[b]=chk2_hasA[b] | chk2_hasB[b] | chk2_hasA[b+4] | chk2_hasB[b+4];
              bit_find_last_bit #(64) chkBit3A(chk3_match[b]&mask,chk3_firstA[b],chk3_hasA[b]);
              bit_find_last_bit #(64) chkBit3B(chk3_match[b]&~mask,chk3_firstB[b],chk3_hasB[b]);
              assign chk3_match_first[b]=chk3_hasA[b] ? chk3_firstA[b]|chk3_firstA[b+4] : chk3_firstB[b]|chk3_firstB[b+4];
	      assign chk3_match_has[b]=chk3_hasA[b] | chk3_hasB[b] | chk3_hasA[b+4] | chk3_hasB[b+4];
              bit_find_last_bit #(64) chkBit4A(chk4_match[b]&mask,chk4_firstA[b],chk4_hasA[b]);
              bit_find_last_bit #(64) chkBit4B(chk4_match[b]&~mask,chk4_firstB[b],chk4_hasB[b]);
              assign chk4_match_first[b]=chk4_hasA[b] ? chk4_firstA[b]|chk4_firstA[b+4] : chk4_firstB[b]|chk4_firstB[b+4];
	      assign chk4_match_has[b]=chk4_hasA[b] | chk4_hasB[b] | chk4_hasA[b+4] | chk4_hasB[b+4];
              bit_find_last_bit #(64) chkBit5A(chk5_match[b]&mask,chk5_firstA[b],chk5_hasA[b]);
              bit_find_last_bit #(64) chkBit5B(chk5_match[b]&~mask,chk5_firstB[b],chk5_hasB[b]);
              assign chk5_match_first[b]=chk5_hasA[b] ? chk5_firstA[b]|chk5_firstA[b+4] : chk5_firstB[b]|chk5_firstB[b+4];
	      assign chk5_match_has[b]=chk5_hasA[b] | chk5_hasB[b] | chk5_hasA[b+4] | chk5_hasB[b+4];
          end
	  if (b==0) begin : with_free
              stq_buf_L_array arr0_mod(
              clk,
              rst,
              aStall|aDoStall,
              excpt,
              WNL0_en0, WNL0_en, WNL0_WQ, WNL0_odd1[b], WNL0_bytes[b], WNL0_subBNK[b], WNL0_subBNK2[b],
              WNL1_en0, WNL1_en, WNL1_WQ, WNL1_odd1[b], WNL1_bytes[b], WNL1_subBNK[b], WNL1_subBNK2[b],
              chk0_en, chk0_addrEO, chk0_odd1[b], chk0_bytes[b], chk0_subBNK[b], chk0_subBNK2[b], chk0_match[b], chk0_partial[b],
	      chk0_matchW[b],chk0_partialW[b],chk0_pre0,chk0_pre1,
              chk1_en, chk1_addrEO, chk1_odd1[b], chk1_bytes[b], chk1_subBNK[b], chk1_subBNK2[b], chk1_match[b], chk1_partial[b],
	      chk1_matchW[b],chk1_partialW[b],chk1_pre0,chk1_pre1,
              chk2_en, chk2_addrEO, chk2_odd1[b], chk2_bytes[b], chk2_subBNK[b], chk2_subBNK2[b], chk2_match[b], chk2_partial[b],
	      chk2_matchW[b],chk2_partialW[b],chk2_pre0,chk2_pre1,
              chk3_en, chk3_addrEO, chk3_odd1[b], chk3_bytes[b], chk3_subBNK[b], chk3_subBNK2[b], chk3_match[b], chk3_partial[b],
	      chk3_matchW[b],chk3_partialW[b],chk3_pre0,chk3_pre1,
              chk4_en, chk4_addrEO, chk4_odd1[b], chk4_bytes[b], chk4_subBNK[b], chk4_subBNK2[b], chk4_match[b], chk4_partial[b],
	      chk4_matchW[b],chk4_partialW[b],chk4_pre0,chk4_pre1,
              chk5_en, chk5_addrEO, chk5_odd1[b], chk5_bytes[b], chk5_subBNK[b], chk5_subBNK2[b], chk5_match[b], chk5_partial[b],
	      chk5_matchW[b],chk5_partialW[b],chk5_pre0,chk5_pre1,
              upd0_en0, 
              upd1_en0, 
              free_en,free,upd,passe,passe_en);

          end else begin : wout_free
              stq_buf_L_array arr0_mod(
              clk,
              rst,
              aStall|aDoStall,
              excpt,
              WNL0_en0, WNL0_en, WNL0_WQ, WNL0_odd1[b], WNL0_bytes[b], WNL0_subBNK[b], WNL0_subBNK2[b],
              WNL1_en0, WNL1_en, WNL1_WQ, WNL1_odd1[b], WNL1_bytes[b], WNL1_subBNK[b], WNL1_subBNK2[b],
              chk0_en, chk0_addrEO, chk0_odd1[b], chk0_bytes[b], chk0_subBNK[b], chk0_subBNK2[b], chk0_match[b], chk0_partial[b],
	      chk0_matchW[b],chk0_partialW[b],chk0_pre0,chk0_pre1,
              chk1_en, chk1_addrEO, chk1_odd1[b], chk1_bytes[b], chk1_subBNK[b], chk1_subBNK2[b], chk1_match[b], chk1_partial[b],
	      chk1_matchW[b],chk1_partialW[b],chk1_pre0,chk1_pre1,
              chk2_en, chk2_addrEO, chk2_odd1[b], chk2_bytes[b], chk2_subBNK[b], chk2_subBNK2[b], chk2_match[b], chk2_partial[b],
	      chk2_matchW[b],chk2_partialW[b],chk2_pre0,chk2_pre1,
              chk3_en, chk3_addrEO, chk3_odd1[b], chk3_bytes[b], chk3_subBNK[b], chk3_subBNK2[b], chk3_match[b], chk3_partial[b],
	      chk3_matchW[b],chk3_partialW[b],chk3_pre0,chk3_pre1,
              chk4_en, chk4_addrEO, chk4_odd1[b], chk4_bytes[b], chk4_subBNK[b], chk4_subBNK2[b], chk4_match[b], chk4_partial[b],
	      chk4_matchW[b],chk4_partialW[b],chk4_pre0,chk4_pre1,
              chk5_en, chk5_addrEO, chk5_odd1[b], chk5_bytes[b], chk5_subBNK[b], chk5_subBNK2[b], chk5_match[b], chk5_partial[b],
	      chk5_matchW[b],chk5_partialW[b],chk5_pre0,chk5_pre1,
              upd0_en0, 
              upd1_en0, 
              free_en,,,,passe_en);
	  end
	  //verilator lint_off WIDTH
          if (b<4)
          stq_data_array #(32+!b[0]) dat_mod(
          clk,
          rst,
          upd0_en0[63:0],{upd0_pbit[upd0_b[b][1]],upd0_data[32*Rupd0_b[b]+:32]},
          upd1_en0[63:0],{upd1_pbit[upd1_b[b][1]],upd1_data[32*Rupd1_b[b]+:32]},
          chk0_match_first[b],chk0_data0[b],chk0_pre0,chk0_pre1,
          chk1_match_first[b],chk1_data0[b],chk1_pre0,chk1_pre1,
          chk2_match_first[b],chk2_data0[b],chk2_pre0,chk2_pre1,
          chk3_match_first[b],chk3_data0[b],chk3_pre0,chk3_pre1,
          chk4_match_first[b],chk4_data0[b],chk4_pre0,chk4_pre1,
          chk5_match_first[b],chk5_data0[b],chk5_pre0,chk5_pre1,
          WLN0_match,WLN0_dataX0[b],
          WLN1_match,WLN1_dataX0[b]
          );
	  //verilator lint_on WIDTH
          
          if (b<4) begin
	      assign WLN0_dataX[33*b+:33]=WLN0_dataX0[b];
	      assign WLN1_dataX[33*b+:33]=WLN1_dataX0[b];
	      assign chk_data[0][33*b+:33]=chk0_data0[chk0_b[b]];
	      assign chk_data[1][33*b+:33]=chk1_data0[chk1_b[b]];
	      assign chk_data[2][33*b+:33]=chk2_data0[chk2_b[b]];
	      assign chk_data[3][33*b+:33]=chk3_data0[chk3_b[b]];
	      assign chk_data[4][33*b+:33]=chk4_data0[chk4_b[b]];
	      assign chk_data[5][33*b+:33]=chk5_data0[chk5_b[b]];
	      assign chk_bytes[0][4*b+:4]=chk0_bytes[chk0_b[b]] & {4{chk0_match_has[chk0_b[b]]}};
	      assign chk_bytes[1][4*b+:4]=chk1_bytes[chk1_b[b]] & {4{chk1_match_has[chk1_b[b]]}};
	      assign chk_bytes[2][4*b+:4]=chk2_bytes[chk2_b[b]] & {4{chk2_match_has[chk2_b[b]]}};
	      assign chk_bytes[3][4*b+:4]=chk3_bytes[chk3_b[b]] & {4{chk3_match_has[chk3_b[b]]}};
	      assign chk_bytes[4][4*b+:4]=chk4_bytes[chk4_b[b]] & {4{chk4_match_has[chk4_b[b]]}};
	      assign chk_bytes[5][4*b+:4]=chk5_bytes[chk5_b[b]] & {4{chk5_match_has[chk5_b[b]]}};
              assign WLN0_data[32*b+:32]=WLN0_dataX[33*WLN0_b[b]+:32];
              assign WLN1_data[32*b+:32]=WLN1_dataX[33*WLN1_b[b]+:32];
	      //verilator lint_off WIDTH
              assign WLN0_b[b]=-(WLN0_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign WLN1_b[b]=-(WLN1_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk0_b[b]=-(chk0_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk1_b[b]=-(chk1_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk2_b[b]=-(chk2_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk3_b[b]=-(chk3_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk4_b[b]=-(chk4_adata[`lsaddr_bank0]&3)+b[1:0]; 
              assign chk5_b[b]=-(chk5_adata[`lsaddr_bank0]&3)+b[1:0]; 
	      //verilator lint_on WIDTH
              assign upd0_b[b]=-(upd0_begin0[1:0]&3)+b[1:0]; 
              assign upd1_b[b]=-(upd1_begin0[1:0]&3)+b[1:0]; 
              assign Rupd0_b[b]=(upd0_begin0[1:0]&3)+b[1:0]; 
              assign Rupd1_b[b]=(upd1_begin0[1:0]&3)+b[1:0]; 
	      assign WLN0_pbit[WLN0_b[b][1]]=WLN0_b[b][0] ? 1'bz : WLN0_dataX[33*b+32+:1];
	      assign WLN1_pbit[WLN1_b[b][1]]=WLN1_b[b][0] ? 1'bz : WLN1_dataX[33*b+32+:1];
          end
	  wire [7:0] chk0_data1;
	  wire [7:0] chk1_data1;
	  wire [7:0] chk2_data1;
	  wire [7:0] chk3_data1;
	  wire [7:0] chk4_data1;
	  wire [7:0] chk5_data1;
          if (b==3)
          stq_data_array #(8) datX_mod(
          clk,
          rst,
          upd0_en0[63:0],upd0_data[135:128],
          upd1_en0[63:0],upd1_data[135:128],
          chk0_match_first[chk0_b[b]],chk0_data1,chk0_pre0,chk0_pre1,
          chk1_match_first[chk1_b[b]],chk1_data1,chk1_pre0,chk1_pre1,
          chk2_match_first[chk2_b[b]],chk2_data1,chk2_pre0,chk2_pre1,
          chk3_match_first[chk3_b[b]],chk3_data1,chk3_pre0,chk3_pre1,
          chk4_match_first[chk4_b[b]],chk4_data1,chk4_pre0,chk4_pre1,
          chk5_match_first[chk5_b[b]],chk5_data1,chk5_pre0,chk5_pre1,
          WLN0_match,WLN0_data[135:128],
          WLN1_match,WLN1_data[135:128]
          );
	  if (b==3) begin
              assign chk_data[0][139:132]=chk0_data1;
              assign chk_data[1][139:132]=chk1_data1;
              assign chk_data[2][139:132]=chk2_data1;
              assign chk_data[3][139:132]=chk3_data1;
              assign chk_data[4][139:132]=chk4_data1;
              assign chk_data[5][139:132]=chk5_data1;
	      assign chk_bytes[0][16]=chk0_bytes[chk0_b[3]][3]&&chk0_adata[`lsaddr_sz]==15 &&chk0_match_has[chk0_b[3]];
	      assign chk_bytes[1][16]=chk1_bytes[chk1_b[3]][3]&&chk1_adata[`lsaddr_sz]==15 &&chk1_match_has[chk1_b[3]];
	      assign chk_bytes[2][16]=chk2_bytes[chk2_b[3]][3]&&chk2_adata[`lsaddr_sz]==15 &&chk2_match_has[chk2_b[3]];
	      assign chk_bytes[3][16]=chk3_bytes[chk3_b[3]][3]&&chk3_adata[`lsaddr_sz]==15 &&chk3_match_has[chk3_b[3]];
	      assign chk_bytes[4][16]=chk4_bytes[chk4_b[3]][3]&&chk4_adata[`lsaddr_sz]==15 &&chk4_match_has[chk4_b[3]];
	      assign chk_bytes[5][16]=chk5_bytes[chk5_b[3]][3]&&chk5_adata[`lsaddr_sz]==15 &&chk5_match_has[chk5_b[3]];
	      assign chk_enD[0]=chk0_enD;	      
	      assign chk_enD[1]=chk1_enD;	      
	      assign chk_enD[2]=chk2_enD;	      
	      assign chk_enD[3]=chk3_enD;	      
	      assign chk_enD[4]=chk4_enD;	      
	      assign chk_enD[5]=chk5_enD;	      
	  end

      end
      for(x=0;x<64;x=x+1) begin : X
          assign WLN0_match[x]=WLN0_WQ==x && WLN0_en;
          assign WLN1_match[x]=WLN1_WQ==x && WLN1_en;
          assign WNL0_en0[x]=WNL0_WQ==x && WNL0_en;
          assign WNL1_en0[x]=WNL1_WQ==x && WNL1_en;
          assign wrt0_en0[x]=wrt0_adata[`lsaddr_WQ]==x && wrt0_en;
          assign wrt1_en0[x]=wrt1_adata[`lsaddr_WQ]==x && wrt1_en;
          assign upd0_en0[x]=upd0_WQ==x && upd0_en;
          assign upd1_en0[x]=upd1_WQ==x && upd1_en;
          assign passe_en[x]=(WNL0_WQ==x && WNL0_en) || (WNL1_WQ==x && WNL1_en);
	  assign free_en[x]=(WLN0_WQ==x && WLN0_en && !st_stall) || (WLN1_WQ==x && WLN1_en && !st_stall);
      end
      for(a=0;a<6;a=a+1) begin : wrt
          assign WNL0_en=LSQ_shr_data[`lsqshare_wrt0]==a ? &rdy[a:0] & chk_rdy : 1'bz;
          assign WNL1_en=LSQ_shr_data[`lsqshare_wrt1]==a ? &rdy[a:0] & chk_rdy : 1'bz;
          assign WNL0_adata=LSQ_shr_data[`lsqshare_wrt0]==a ? chk_adata[a] : {`lsaddr_width{1'bz}};
          assign WNL1_adata=LSQ_shr_data[`lsqshare_wrt1]==a ? chk_adata[a] : {`lsaddr_width{1'bz}};
          assign WNL0_WQ=LSQ_shr_data[`lsqshare_wrt0]==a ? chk_adata[a][`lsaddr_WQ] : 'z;
          assign WNL1_WQ=LSQ_shr_data[`lsqshare_wrt1]==a ? chk_adata[a][`lsaddr_WQ] : 'z;
	  assign wb0_adataW=chk_wb[a] ? chk_adata[a] : {`lsaddr_width{1'bz}};
	  assign wb1_adataW=chk_wb1[a] ? chk_adata[a] : {`lsaddr_width{1'bz}};
	  assign wb0_dataW[31:0]=chk_wb[a] ? chk_data[a][31:0] : 'z;
	  assign wb1_dataW[31:0]=chk_wb1[a] ? chk_data[a][31:0] : 'z;
	  assign wb0_dataW[63:32]=chk_wb[a] ? chk_data[a][64:33] : 'z;
	  assign wb1_dataW[63:32]=chk_wb1[a] ? chk_data[a][64:33] : 'z;
	  assign wb0_dataW[95:64]=chk_wb[a] ? chk_data[a][97:66] : 'z;
	  assign wb1_dataW[95:64]=chk_wb1[a] ? chk_data[a][97:66] : 'z;
	  assign wb0_dataW[127:96]=chk_wb[a] ? chk_data[a][130:99] : 'z;
	  assign wb1_dataW[127:96]=chk_wb1[a] ? chk_data[a][130:99] : 'z;
	  assign wb0_dataW[135:128]=chk_wb[a] ? chk_data[a][139:132] : 8'bz;
	  assign wb1_dataW[135:128]=chk_wb1[a] ? chk_data[a][139:132] : 8'bz;
	  assign wb0_pbitW[0]=chk_wb[a] ? chk_data[a][32] : 1'bz;
	  assign wb1_pbitW[0]=chk_wb1[a] ? chk_data[a][32] : 1'bz;
	  assign wb0_pbitW[1]=chk_wb[a] ? chk_data[a][98] : 1'bz;
	  assign wb1_pbitW[1]=chk_wb1[a] ? chk_data[a][98] : 1'bz;
	  assign wb0_bnkEn=chk_wb0_reg2[a] ?  chk_bytes_reg2[a]&{17{~|chk_enD[a]&~chk_wb0_has_reg2}} : 17'bz;
	  assign wb1_bnkEn=chk_wb1_reg2[a] ? chk_bytes_reg2[a]&{17{~|chk_enD[a]&~chk_wb1_has_reg2}} : 17'bz;
	  assign wb0_bnkEnS=chk_wb0_reg2[a] ?  chk_bytes_reg2[a]&{17{|chk_enD[a]|chk_wb0_has_reg2}} : 17'bz;
	  assign wb1_bnkEnS=chk_wb1_reg2[a] ? chk_bytes_reg2[a]&{17{|chk_enD[a]|chk_wb1_has_reg2}} : 17'bz;
      end
  endgenerate
  assign wb0_adataW=chk_wb0_has ? {`lsaddr_width{1'bz}} : {`lsaddr_width{1'b0}};
  assign wb1_adataW=chk_wb1_has ? {`lsaddr_width{1'bz}} : {`lsaddr_width{1'b0}};
  assign wb0_dataW[31:0]=chk_wb0_has ? 32'bz : 32'b0;
  assign wb1_dataW[31:0]=chk_wb1_has ? 32'bz : 32'b0;
  assign wb0_dataW[63:32]=chk_wb0_has ? 32'bz : 32'b0;
  assign wb1_dataW[63:32]=chk_wb1_has ? 32'bz : 32'b0;
  assign wb0_dataW[95:64]=chk_wb0_has ? 32'bz : 32'b0;
  assign wb1_dataW[95:64]=chk_wb1_has ? 32'bz : 32'b0;
  assign wb0_dataW[127:96]=chk_wb0_has ? 32'bz : 32'b0;
  assign wb1_dataW[127:96]=chk_wb1_has ? 32'bz : 32'b0;
  assign wb0_dataW[135:128]=chk_wb0_has ? 8'bz : 8'b0;
  assign wb1_dataW[135:128]=chk_wb1_has ? 8'bz : 8'b0;
  assign wb0_pbitW[0]=chk_wb0_has ? 1'bz : 1'b0;
  assign wb1_pbitW[0]=chk_wb1_has ? 1'bz : 1'b0;
  assign wb0_pbitW[1]=chk_wb0_has ? 1'bz : 1'b0;
  assign wb1_pbitW[1]=chk_wb1_has ? 1'bz : 1'b0;
  assign wb0_bnkEn=chk_wb0_has_reg2 ? 17'bz : 17'b0;
  assign wb1_bnkEn=chk_wb1_has_reg2 ? 17'bz : 17'b0;
  assign wb0_bnkEnS=chk_wb0_has_reg2 ? 17'bz : 17'b0;
  assign wb1_bnkEnS=chk_wb1_has_reg2 ? 17'bz : 17'b0;


  assign wb0_data[31:0]=wb0_adata[`lsaddr_sz]==5'h10 && wb0_adata[`lsaddr_low]==2'd1 ? {24'b0,wb0_dataW_reg[15:8]} :32'bz;
  assign wb0_data[31:0]=wb0_adata[`lsaddr_sz]==5'h10 && wb0_adata[`lsaddr_low]==2'd2 ? {24'b0,wb0_dataW_reg[23:16]} :32'bz;
  assign wb0_data[31:0]=wb0_adata[`lsaddr_sz]==5'h10 && wb0_adata[`lsaddr_low]==2'd3 ? {24'b0,wb0_dataW_reg[31:24]} :32'bz;
  assign wb0_data[31:0]=wb0_adata[`lsaddr_sz]==5'h11 && wb0_adata[`lsaddr_low]==2'd1 ? {16'b0,wb0_dataW_reg[23:8]} :32'bz;
  assign wb0_data[31:0]=wb0_adata[`lsaddr_sz]==5'h11 && wb0_adata[`lsaddr_low]==2'd2 ? {16'b0,wb0_dataW_reg[31:16]} :32'bz;
  assign wb0_data[31:0]=wb0_adata[`lsaddr_sz]==5'h11 && wb0_adata[`lsaddr_low]==2'd3 ? {16'b0,wb0_dataW_reg[39:24]} :32'bz;
  assign wb0_data[31:0]=wb0_adata[`lsaddr_sz]!=5'h10 || wb0_adata[`lsaddr_sz]!=5'h11 || wb0_adata[`lsaddr_low]==2'd0 ? 
      wb0_dataW[31:0] :32'bz;
  assign wb0_data[135:32]=wb0_dataW_reg[135:32];

  assign wb1_data[31:0]=wb1_adata[`lsaddr_sz]==5'h10 && wb1_adata[`lsaddr_low]==2'd1 ? {24'b0,wb1_dataW_reg[15:8]} :32'bz;
  assign wb1_data[31:0]=wb1_adata[`lsaddr_sz]==5'h10 && wb1_adata[`lsaddr_low]==2'd2 ? {24'b0,wb1_dataW_reg[23:16]} :32'bz;
  assign wb1_data[31:0]=wb1_adata[`lsaddr_sz]==5'h10 && wb1_adata[`lsaddr_low]==2'd3 ? {24'b0,wb1_dataW_reg[31:24]} :32'bz;
  assign wb1_data[31:0]=wb1_adata[`lsaddr_sz]==5'h11 && wb1_adata[`lsaddr_low]==2'd1 ? {16'b0,wb1_dataW_reg[23:8]} :32'bz;
  assign wb1_data[31:0]=wb1_adata[`lsaddr_sz]==5'h11 && wb1_adata[`lsaddr_low]==2'd2 ? {16'b0,wb1_dataW_reg[31:16]} :32'bz;
  assign wb1_data[31:0]=wb1_adata[`lsaddr_sz]==5'h11 && wb1_adata[`lsaddr_low]==2'd3 ? {16'b0,wb1_dataW_reg[39:24]} :32'bz;
  assign wb1_data[31:0]=wb1_adata[`lsaddr_sz]!=5'h10 || wb1_adata[`lsaddr_sz]!=5'h11 || wb1_adata[`lsaddr_low]==2'd0 ? 
      wb1_dataW[31:0] :32'bz;
  assign wb1_data[135:32]=wb1_dataW_reg[135:32];

  assign wb0_dataN=~wb0_data;
  assign wb1_dataN=~wb1_data;

  assign wb0_en=chk_wb0_has;
  assign wb1_en=chk_wb1_has;

  assign wb0_chk=chk_wb0;
  assign wb1_chk=chk_wb1;

  assign WNL0_odd=WNL0_adata[`lsaddr_odd];
  assign WNL1_odd=WNL1_adata[`lsaddr_odd];
  assign chk0_odd=chk0_adata[`lsaddr_odd];
  assign chk1_odd=chk1_adata[`lsaddr_odd];
  assign chk2_odd=chk2_adata[`lsaddr_odd];
  assign chk3_odd=chk3_adata[`lsaddr_odd];
  assign chk4_odd=chk4_adata[`lsaddr_odd];
  assign chk5_odd=chk5_adata[`lsaddr_odd];

  assign chk0_pre0=1'b0;
  assign chk0_pre1=1'b0;

  assign chk1_pre0=LSQ_shr_data[`lsqshare_wrt0]==3'd0;
  assign chk1_pre1=1'b0;

  assign chk2_pre0=LSQ_shr_data[`lsqshare_wrt0+1]==2'b0;
  assign chk2_pre1=LSQ_shr_data[`lsqshare_wrt1+1]==2'b0;

  assign chk3_pre0=LSQ_shr_data[`lsqshare_wrt0+1]==2'b0 || LSQ_shr_data[`lsqshare_wrt0]==3'd2;
  assign chk3_pre1=LSQ_shr_data[`lsqshare_wrt1+1]==2'b0 || LSQ_shr_data[`lsqshare_wrt1]==3'd2;
 
  assign chk4_pre0=LSQ_shr_data[`lsqshare_wrt0+2]==1'b0;
  assign chk4_pre1=LSQ_shr_data[`lsqshare_wrt1+2]==1'b0;

  assign chk5_pre0=LSQ_shr_data[`lsqshare_wrt0+2]==1'b0 || LSQ_shr_data[`lsqshare_wrt0]==3'd4;
  assign chk5_pre1=LSQ_shr_data[`lsqshare_wrt1+2]==1'b0 || LSQ_shr_data[`lsqshare_wrt1]==3'd4;
 


  assign aDoStall=(|chk0_partial | |chk0_partialW && chk_adata[0][`lsaddr_flag]) || (|chk1_partial | |chk1_partialW && chk_adata[1][`lsaddr_flag]) ||
	  (|chk2_partial | |chk2_partialW && chk_adata[2][`lsaddr_flag]) || (|chk3_partial | |chk3_partialW && chk_adata[3][`lsaddr_flag]) ||
	  (|chk4_partial | |chk4_partialW && chk_adata[4][`lsaddr_flag]) || (|chk5_partial | |chk5_partialW && chk_adata[5][`lsaddr_flag]) ||
	  chk_wb2_has ||  |rsDoStall | rsStall;
  assign confl0[0]=(|chk0_partial | |chk0_partialW || |chk0_match | |chk0_matchW) && chk0_en && !chk_adata[0][`lsaddr_flag] &&
	  !chk_adata[0][`lsaddr_st];
  assign confl0[1]=(|chk1_partial | |chk1_partialW || |chk1_match | |chk0_matchW) && chk1_en && !chk_adata[1][`lsaddr_flag] &&
	  !chk_adata[1][`lsaddr_st];
  assign confl0[2]=(|chk2_partial | |chk2_partialW || |chk2_match | |chk0_matchW) && chk2_en && !chk_adata[2][`lsaddr_flag] &&
	  !chk_adata[2][`lsaddr_st];
  assign confl0[3]=(|chk3_partial | |chk3_partialW || |chk3_match | |chk0_matchW) && chk3_en && !chk_adata[3][`lsaddr_flag] &&
	  !chk_adata[3][`lsaddr_st];
  assign confl0[4]=(|chk4_partial | |chk4_partialW || |chk4_match | |chk0_matchW) && chk4_en && !chk_adata[4][`lsaddr_flag] &&
	  !chk_adata[4][`lsaddr_st];
  assign confl0[5]=(|chk5_partial | |chk5_partialW || |chk5_match | |chk0_matchW) && chk5_en && !chk_adata[5][`lsaddr_flag] &&
	  !chk_adata[5][`lsaddr_st];
//  assign WLN0_en=upd[WLN0_WQ];
//  assign WLN1_en=upd[WLN1_WQ];
  //assign WLN0_adata=LSQ_shr_data[`lsqshare_wrt0]==3'd7 ? {`lsaddr_width{1'b0}} : {`lsaddr_width{1'bz}};
  //assign WLN1_adata=LSQ_shr_data[`lsqshare_wrt1]==3'd7 ? {`lsaddr_width{1'b0}} : {`lsaddr_width{1'bz}};
  
  assign WNL0_en=LSQ_shr_data[`lsqshare_wrt0]==3'd7 ? 1'b0 : 1'bz;
  assign WNL1_en=LSQ_shr_data[`lsqshare_wrt1]==3'd7 ? 1'b0 : 1'bz;
  assign WNL0_adata=LSQ_shr_data[`lsqshare_wrt0]==3'd7 ? {`lsaddr_width{1'b0}} : {`lsaddr_width{1'bz}};
  assign WNL1_adata=LSQ_shr_data[`lsqshare_wrt1]==3'd7 ? {`lsaddr_width{1'b0}} : {`lsaddr_width{1'bz}};
  assign WNL0_WQ=LSQ_shr_data[`lsqshare_wrt0]==3'd7 ? 6'b0 : 6'bz;
  assign WNL1_WQ=LSQ_shr_data[`lsqshare_wrt1]==3'd7 ? 6'b0 : 6'bz;
 
  assign ret_II_out=WLN0_adata[`lsaddr_II+4];

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
  
  assign WNL0_banks=(WNL0_adata[`lsaddr_sz]==5'h11 || WNL0_adata[`lsaddr_sz]==5'h10 || WNL0_adata[`lsaddr_low]==2'b0) ?
    WNL0_adata[`lsaddr_banks] : lowt(WNL0_adata[`lsaddr_banks]);
  assign WNL0_odd0[2:0]=(WNL0_adata[`lsaddr_sz]==5'h11 || WNL0_adata[`lsaddr_sz]==5'h10) ? {2'b0,WNL0_odd} : {WNL0_adata[`lsaddr_low],WNL0_odd}; 
  assign WNL0_odd0[3]=WNL0_adata[`lsaddr_sz]==5'hf;

  assign WNL1_banks=(WNL1_adata[`lsaddr_sz]==5'h11 || WNL1_adata[`lsaddr_sz]==5'h10 || WNL1_adata[`lsaddr_low]==2'b0) ?
    WNL1_adata[`lsaddr_banks] : lowt(WNL1_adata[`lsaddr_banks]);
  assign WNL1_odd0[2:0]=(WNL1_adata[`lsaddr_sz]==5'h11 || WNL1_adata[`lsaddr_sz]==5'h10) ? {2'b0,WNL1_odd} : {WNL1_adata[`lsaddr_low],WNL1_odd}; 
  assign WNL1_odd0[3]=WNL1_adata[`lsaddr_sz]==5'hf;
  
  assign chk0_banks=chk0_adata[`lsaddr_banks];
  assign chk1_banks=chk1_adata[`lsaddr_banks];
  assign chk2_banks=chk2_adata[`lsaddr_banks];
  assign chk3_banks=chk3_adata[`lsaddr_banks];
  assign chk4_banks=chk4_adata[`lsaddr_banks];
  assign chk5_banks=chk5_adata[`lsaddr_banks];
  assign WNL0_banks=WNL0_adata[`lsaddr_banks];
  assign WNL1_banks=WNL1_adata[`lsaddr_banks];

  assign chk_adata[0]=chk0_adata;
  assign chk_adata[1]=chk1_adata;
  assign chk_adata[2]=chk2_adata;
  assign chk_adata[3]=chk3_adata;
  assign chk_adata[4]=chk4_adata;
  assign chk_adata[5]=chk5_adata;

  bit_find_first_bit #(6) first_wb_mod(chk_wb&~chk_mask&
	  ~{chk5_enD[1],chk4_enD[1],chk3_enD[1],chk2_enD[1],chk1_enD[1],chk0_enD[1]},chk_wb0,chk_wb0_has);
  bit_find_first_bit #(6) first_wb1_mod(chk_wb&~chk_wb0&~chk_mask,chk_wb1,chk_wb1_has);

  assign chk_wb2_has=(chk_wb&~chk_wb0&~chk_mask&~chk_wb1)!=6'd0;
  
  stq_buf_A_array A0_mod(
  clk,
  rst,
  aStall|aDoStall,
  excpt,
  wrt0_en0, wrt0_adata[`lsaddr_addrE], wrt0_adata[`lsaddr_addrO], 
  wrt1_en0, wrt1_adata[`lsaddr_addrE], wrt1_adata[`lsaddr_addrO], 
  chk0_en, chk0_addrEO, chk0_adata[`lsaddr_addrE], chk0_adata[`lsaddr_addrO],
  chk1_en, chk1_addrEO, chk1_adata[`lsaddr_addrE], chk1_adata[`lsaddr_addrO],
  chk2_en, chk2_addrEO, chk2_adata[`lsaddr_addrE], chk2_adata[`lsaddr_addrO],
  chk3_en, chk3_addrEO, chk3_adata[`lsaddr_addrE], chk3_adata[`lsaddr_addrO],
  chk4_en, chk4_addrEO, chk4_adata[`lsaddr_addrE], chk4_adata[`lsaddr_addrO],
  chk5_en, chk5_addrEO, chk5_adata[`lsaddr_addrE], chk5_adata[`lsaddr_addrO],
  upd0_en0, 
  upd1_en0, 
  free_en,,,,passe_en);

  stq_adata_ram ramA_mod(
  clk,
  rst,
  ~st_stall & WLN0_en,
  ~WLN0_WQ[0] ? WLN0_WQ[5:1] : WLN1_WQ[5:1],
  {WLN0_adata0,WLN0_en0},
  (~WLN0_WQ[0] ? WNL0_en:WNL1_en) & ~aStall & ~aDoStall,
  ~WLN0_WQ[0] ? WNL0_WQ[5:1] : WNL1_WQ[5:1],
  ~WNL0_WQ[0] ? {WNL0_adata,WNL0_en} : {WNL1_adata,WNL1_en}
  );

  assign WLN0_adata=~WLN0_WQ[0] ? WLN0_adata0 : WLN1_adata0;
  assign WLN0_en=~WLN0_WQ[0] ? WLN0_en0 & upd[WLN0_WQ] & mask2[WLN0_WQ] && ret_II==WLN0_adata[`lsaddr_II+4] && 
	  ret_xbreak[WLN0_adata[-6+`lsaddr_II]] :
	  WLN1_en0 & upd[WLN1_WQ] & mask2[WLN1_WQ] && ret_II==WLN1_adata[`lsaddr_II+4] && ret_xbreak[WLN1_adata[-6+`lsaddr_II]];
  assign WLN1_adata=WLN0_WQ[0] ? WLN0_adata0 : WLN1_adata0;
  assign WLN1_en=WLN0_WQ[0] ? WLN0_en0 & upd[WLN0_WQ] & mask2[WLN0_WQ] && ret_II==WLN0_adata[`lsaddr_II+4] && 
	  ret_xbreak[WLN0_adata[-6+`lsaddr_II]] :
	  WLN1_en0 & upd[WLN1_WQ] & mask2[WLN1_WQ] && ret_II==WLN1_adata[`lsaddr_II+4] && ret_xbreak[WLN1_adata[-6+`lsaddr_II]];
  
  stq_adata_ram ramB_mod(
  clk,
  rst,
  ~st_stall & WLN0_en,
  ~WLN0_WQ[0] ? WLN1_WQ[5:1] : WLN0_WQ[5:1],
  {WLN1_adata0,WLN1_en0},
  (~WLN0_WQ[0] ? WNL1_en:WNL0_en) & ~aStall & ~aDoStall,
  ~WNL0_WQ[0] ? WNL1_WQ[5:1] : WNL0_WQ[5:1],
  ~WNL0_WQ[0]  ? {WNL1_adata,WNL1_en} : {WNL0_adata,WNL0_en}
  );
  
  stq_adata bgn_mod(
  clk,
  rst,
  wrt0_en,wrt0_adata[`lsaddr_WQ],wrt0_adata[`lsaddr_bank0],
  wrt1_en,wrt1_adata[`lsaddr_WQ],wrt1_adata[`lsaddr_bank0],
  upd0_WQ,upd0_begin0,
  upd1_WQ,upd1_begin0);

  adder_inc #(6) inc_pseA_mod(pse1_WQ,pse1_WQ_inc,1'b1,);
  adder_inc #(5) inc_pseB_mod(pse1_WQ[5:1],pse1_WQ_inc2[5:1],1'b1,);
  assign pse1_WQ_inc2[0]=pse1_WQ[0];
  adder_inc #(6) inc_WLNA_mod(WLN1_WQ,WLN1_WQ_inc,1'b1,);
  adder_inc #(5) inc_WLNB_mod(WLN1_WQ[5:1],WLN1_WQ_inc2[5:1],1'b1,);
  assign WLN1_WQ_inc2[0]=WLN1_WQ[0];
 // always @(free) $display("stq_free: %x,%x",free,upd);
  always @(posedge clk) begin
      if (rst) begin
	  confl_out<=6'b0;
	  pse0_WQ<=6'd0;
	  pse1_WQ<=6'd0;
	  WLN0_WQ<=6'd0;
	  WLN1_WQ<=6'd1;
	  chk_mask<=6'd0;
	  mask=64'b0;
	  mask2=64'b0;
	  nmask=64'b0;
	  rsDoStall<=4'b0000;
	  wb0_adata<=0;
	  wb1_adata<=0;
	  chk_wb0_reg<=0;
	  chk_wb0_reg2<=0;
	  chk_wb0_has_reg<=0;
	  chk_wb0_has_reg2<=0;
	  chk_bytes_reg<=0;
	  chk_bytes_reg2<=0;
	  chk_wb1_reg<=0;
	  chk_wb1_reg2<=0;
	  chk_wb1_has_reg<=0;
	  chk_wb1_has_reg2<=0;
      end else begin
	  confl_out<=confl0;
	  wb0_adata<=wb0_adataW;
	  wb1_adata<=wb1_adataW;
	  if (!stall && !doStall && pse0_en && ~pse1_en & ~excpt) begin
	      pse0_WQ<=pse1_WQ;
	      pse1_WQ<=pse1_WQ_inc;
	      if (!mask[63]) mask[pse0_WQ]=1'b1; else nmask[pse0_WQ]=1'b1;
	  end else if (!stall && !doStall && pse0_en && ~excpt) begin
	      pse0_WQ<=pse1_WQ_inc;
	      pse1_WQ<=pse1_WQ_inc2;
	      if (!mask[63]) mask[pse0_WQ]=1'b1; else nmask[pse0_WQ]=1'b1;
	      if (!mask[62]) mask[pse1_WQ]=1'b1; else nmask[pse1_WQ]=1'b1;
	  end
	  if (!aStall && !aDoStall && WNL0_en && ~WNL1_en & ~excpt) begin
	      mask2[WNL0_WQ]=1'b1;
	  end else if (!aStall && !aDoStall && WNL0_en && ~excpt) begin
	      mask2[WNL0_WQ]=1'b1;
	      mask2[WNL1_WQ]=1'b1;
	  end
	  if (!st_stall &&  WLN0_en && ~WLN1_en) begin
	      WLN0_WQ<=WLN1_WQ;
	      WLN1_WQ<=WLN1_WQ_inc;
	      mask2[WLN0_WQ]=1'b0;
	      mask[WLN0_WQ]=1'b0;
	      if (WLN0_WQ==63) begin mask=nmask; nmask=64'b0; end
	  end else if (!st_stall && WLN0_en) begin
	      WLN0_WQ<=WLN1_WQ_inc;
	      WLN1_WQ<=WLN1_WQ_inc2;
	      mask2[WLN0_WQ]=1'b0;
	      mask2[WLN1_WQ]=1'b0;
	      mask[WLN0_WQ]=1'b0;
	      mask[WLN1_WQ]=1'b0;
	      if (WLN0_WQ==63 || WLN1_WQ==63) begin mask=nmask; nmask=64'b0; end
	  end
	  if (excpt) begin
	      mask=64'b0;
	      mask2=64'b0;
	      nmask=64'b0;
	      WLN0_WQ<=pse0_WQ;
	      WLN1_WQ<=pse1_WQ;
	  end
	  if (!aStall && !aDoStall && chk_rdy) begin
	      chk_mask<=6'd0;
	  end else if (!(|rsDoStall & rsStall)) begin
	      chk_mask<=chk_mask|chk_wb0|chk_wb1;
	  end
	  if (!(|rsDoStall & rsStall)) begin
	      rsDoStall[0]<=wb1_en && wb0_way==2'd0;
	      rsDoStall[1]<=wb1_en && wb0_way==2'd1;
	      rsDoStall[2]<=wb1_en && wb0_way==2'd2;
	      rsDoStall[3]<=wb1_en;
          end
	  chk_wb0_reg<=chk_wb0;
	  chk_wb0_reg2<=chk_wb0_reg;
	  chk_wb0_has_reg<=chk_wb0_has;
	  chk_wb0_has_reg2<=chk_wb0_has_reg;
	  chk_bytes_reg<=chk_bytes;
	  chk_bytes_reg2<=chk_bytes_reg;
	  chk_wb1_reg<=chk_wb1;
	  chk_wb1_reg2<=chk_wb1_reg;
	  chk_wb1_has_reg<=chk_wb1_has;
	  chk_wb1_has_reg2<=chk_wb1_has_reg;
      end
      wb0_dataW_reg<=wb0_dataW;
      wb1_dataW_reg<=wb1_dataW;
      wb0_pbit<=wb0_pbitW;
      wb1_pbit<=wb1_pbitW;
  end
endmodule