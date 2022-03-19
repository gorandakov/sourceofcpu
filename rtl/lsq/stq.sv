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

`include "../common.sv"

module stq(
  clk,
  rst,
  excpt,
  aStall,
  aDoStall,
  chk0_adata,chk0_en,chk0_LSQ,
  chk1_adata,chk1_en,chk1_LSQ,
  chk2_adata,chk2_en,chk2_LSQ,
  chk3_adata,chk3_en,chk3_LSQ,
  chk4_adata,chk4_en,chk4_LSQ,
  chk5_adata,chk5_en,chk5_LSQ,  
  wrt0_adata,wrt0_en,wrt0_LSQ,
  wrt1_adata,wrt1_en,wrt1_LSQ,
  upd0_WQ,upd0_en,upd0_data,upd0_pbit,upd0_sz,
  upd1_WQ,upd1_en,upd1_data,upd1_pbit,upd1_sz,
  pse0_WQ,pse0_en,
  pse1_WQ,pse1_en,
  wb1_adata,wb1_LSQ,wb1_data,wb1_bnkEn,wb1_en,wb1_way,
  wb0_adata,wb0_LSQ,wb0_data,wb0_bnkEn,wb0_en,
  );
  
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
      genvar b,x;
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

          stq_buf_L_array arr0_mod(
          clk,
          rst,
          aStall|aDoStall,
          excpt,
          wrt0_en0, wrt0_odd1[b], wrt0_bytes[b], wrt0_subBNK[b],
          wrt1_en0, wrt1_odd1[b], wrt1_bytes[b], wrt1_subBNK[b],
          chk0_en, chk0_addrEO, chk0_odd1[b], chk0_bytes[b], chk0_subBNK[b], chk0_match[b][31:0], chk0_partial[b][31:0],
          chk1_en, chk1_addrEO, chk1_odd1[b], chk1_bytes[b], chk1_subBNK[b], chk1_match[b][31:0], chk1_partial[b][31:0],
          chk2_en, chk2_addrEO, chk2_odd1[b], chk2_bytes[b], chk2_subBNK[b], chk2_match[b][31:0], chk2_partial[b][31:0],
          chk3_en, chk3_addrEO, chk3_odd1[b], chk3_bytes[b], chk3_subBNK[b], chk3_match[b][31:0], chk3_partial[b][31:0],
          chk4_en, chk4_addrEO, chk4_odd1[b], chk4_bytes[b], chk4_subBNK[b], chk4_match[b][31:0], chk4_partial[b][31:0],
          chk5_en, chk5_addrEO, chk5_odd1[b], chk5_bytes[b], chk5_subBNK[b], chk5_match[b][31:0], chk5_partial[b][31:0],
          upd0_en0[31:0], 
          upd1_en0[31:0], 
          free_en[31:0],free[31:0],upd[31:0],passe[31:0],passe_en[31:0]);end

          stq_buf_L_array arr1_mod(
          clk,
          rst,
          aStall|aDoStall,
          excpt,
          wrt0_en0, wrt0_odd[b], wrt0_bytes[b], wrt0_subBNK[b],
          wrt1_en0, wrt1_odd[b], wrt1_bytes[b], wrt1_subBNK[b],
          chk0_en, chk0_addrEO, chk0_odd[b], chk0_bytes[b], chk0_subBNK[b], chk0_match[b][63:32], chk0_partial[b][63:32],
          chk1_en, chk1_addrEO, chk1_odd[b], chk1_bytes[b], chk1_subBNK[b], chk1_match[b][63:32], chk1_partial[b][63:32],
          chk2_en, chk2_addrEO, chk2_odd[b], chk2_bytes[b], chk2_subBNK[b], chk2_match[b][63:32], chk2_partial[b][63:32],
          chk3_en, chk3_addrEO, chk3_odd[b], chk3_bytes[b], chk3_subBNK[b], chk3_match[b][63:32], chk3_partial[b][63:32],
          chk4_en, chk4_addrEO, chk4_odd[b], chk4_bytes[b], chk4_subBNK[b], chk4_match[b][63:32], chk4_partial[b][63:32],
          chk5_en, chk5_addrEO, chk5_odd[b], chk5_bytes[b], chk5_subBNK[b], chk5_match[b][63:32], chk5_partial[b][63:32],
          upd0_en0[63:32], 
          upd1_en0[63:32], 
          free_en[63:32],free[63:32],upd[63:32],passe[63:32],passe_en[63:32]);
          
          if (b<4)
          stq_data_array #(32+~b[0]) dat_mod(
          clk,
          rst,
          upd0_en0,{upd0_pbit[b/2],upd0_data[32*b+:32]},
          upd1_en0,{upd1_pbit[b/2],upd1_data[32*b+:32]},
          chk0_match_first[b],chk0_data[32*b+:32],
          chk1_match_first[b],chk1_data[32*b+:32],
          chk2_match_first[b],chk2_data[32*b+:32],
          chk3_match_first[b],chk3_data[32*b+:32],
          chk4_match_first[b],chk4_data[32*b+:32],
          chk5_match_first[b],chk5_data[32*b+:32],
          WLN0_match[b],{WLN0_pbit[b],WLN0_data[32*b+:32]},
          WLN1_match[b],{WLN1_pbit[b],WLN1_data[32*b+:32]}
          );
          
          if (b==3)
          stq_data_array #(8) datX_mod(
          clk,
          rst,
          upd0_en0,upd0_data[135:128],
          upd1_en0,upd1_data[135:128],
          chk0_match_first[b],chk0_data[135:128],
          chk1_match_first[b],chk1_data[135:128],
          chk2_match_first[b],chk2_data[135:128],
          chk3_match_first[b],chk3_data[135:128],
          chk4_match_first[b],chk4_data[135:128],
          chk5_match_first[b],chk5_data[135:128],
          WLN0_match[b],WLN0_data[135:128],
          WLN1_match[b],WLN1_data[135:128]
          );

      end
      for(x=0;x<64;x=x+1) begin : X
          assign WLN0_match[x]=WLN0_adata[`lsaddr_WQ]==x && WLN0_en;
          assign WLN1_match[x]=WLN1_adata[`lsaddr_WQ]==x && WNL1_en;
          assign wrt0_en0[x]=wrt0_adata[`lsaddr_WQ]==x && wrt0_en;
          assign wrt1_en0[x]=wrt1_adata[`lsaddr_WQ]==x && wrt1_en;
          assign upd0_en0[x]=upd0_WQ==x && upd0_en;
          assign upd1_en0[x]=upd1_WQ==x && upd1_en;
          assign passe_en[x]=(pse0_WQ==x && pse0_en) || (pse1_WQ==x && pse1_en);
      end
  endgenerate
  assign chk0_banks=(chk0_adata[`lsaddr_sz]==5'h11 || chk0_adata[`lsaddr_sz]==5'h10 || chk0_adata[`lsaddr_low]==2'b0) ?
    chk0_adata[`lsaddr_banks] : lowt(chk0_adata[`lsaddr_banks]);
  assign chk0_odd0[2:0]=(chk0_adata[`lsaddr_sz]==5'h11 || chk0_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk0_odd} : {chk0_adata{`lsaddr_low],chk0_odd}; 
  assign chk0_odd0[3]=chk0_adata[`lsaddr_sz]==5'hf;

  assign chk1_banks=(chk1_adata[`lsaddr_sz]==5'h11 || chk1_adata[`lsaddr_sz]==5'h10 || chk1_adata[`lsaddr_low]==2'b0) ?
    chk1_adata[`lsaddr_banks] : lowt(chk1_adata[`lsaddr_banks]);
  assign chk1_odd0[2:0]=(chk1_adata[`lsaddr_sz]==5'h11 || chk1_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk1_odd} : {chk1_adata{`lsaddr_low],chk1_odd}; 
  assign chk1_odd0[3]=chk1_adata[`lsaddr_sz]==5'hf;

  assign chk2_banks=(chk2_adata[`lsaddr_sz]==5'h11 || chk2_adata[`lsaddr_sz]==5'h10 || chk2_adata[`lsaddr_low]==2'b0) ?
    chk2_adata[`lsaddr_banks] : lowt(chk2_adata[`lsaddr_banks]);
  assign chk2_odd0[2:0]=(chk2_adata[`lsaddr_sz]==5'h11 || chk2_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk2_odd} : {chk2_adata{`lsaddr_low],chk2_odd}; 
  assign chk2_odd0[3]=chk2_adata[`lsaddr_sz]==5'hf;

  assign chk3_banks=(chk3_adata[`lsaddr_sz]==5'h11 || chk3_adata[`lsaddr_sz]==5'h10 || chk3_adata[`lsaddr_low]==2'b0) ?
    chk3_adata[`lsaddr_banks] : lowt(chk3_adata[`lsaddr_banks]);
  assign chk3_odd0[2:0]=(chk3_adata[`lsaddr_sz]==5'h11 || chk3_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk3_odd} : {chk3_adata{`lsaddr_low],chk3_odd}; 
  assign chk3_odd0[3]=chk3_adata[`lsaddr_sz]==5'hf;

  assign chk4_banks=(chk4_adata[`lsaddr_sz]==5'h11 || chk4_adata[`lsaddr_sz]==5'h10 || chk4_adata[`lsaddr_low]==2'b0) ?
    chk4_adata[`lsaddr_banks] : lowt(chk4_adata[`lsaddr_banks]);
  assign chk4_odd0[2:0]=(chk4_adata[`lsaddr_sz]==5'h11 || chk4_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk4_odd} : {chk4_adata{`lsaddr_low],chk4_odd}; 
  assign chk4_odd0[3]=chk4_adata[`lsaddr_sz]==5'hf;

  assign chk5_banks=(chk5_adata[`lsaddr_sz]==5'h11 || chk5_adata[`lsaddr_sz]==5'h10 || chk5_adata[`lsaddr_low]==2'b0) ?
    chk5_adata[`lsaddr_banks] : lowt(chk5_adata[`lsaddr_banks]);
  assign chk5_odd0[2:0]=(chk5_adata[`lsaddr_sz]==5'h11 || chk5_adata[`lsaddr_sz]==5'h10) ? {2'b0,chk5_odd} : {chk5_adata{`lsaddr_low],chk5_odd}; 
  assign chk5_odd0[3]=chk5_adata[`lsaddr_sz]==5'hf;
  
  assign wrt0_banks=(wrt0_adata[`lsaddr_sz]==5'h11 || wrt0_adata[`lsaddr_sz]==5'h10 || wrt0_adata[`lsaddr_low]==2'b0) ?
    wrt0_adata[`lsaddr_banks] : lowt(wrt0_adata[`lsaddr_banks]);
  assign wrt0_odd0[2:0]=(wrt0_adata[`lsaddr_sz]==5'h11 || wrt0_adata[`lsaddr_sz]==5'h10) ? {2'b0,wrt0_odd} : {wrt0_adata{`lsaddr_low],wrt0_odd}; 
  assign wrt0_odd0[3]=wrt0_adata[`lsaddr_sz]==5'hf;

  assign wrt1_banks=(wrt1_adata[`lsaddr_sz]==5'h11 || wrt1_adata[`lsaddr_sz]==5'h10 || wrt1_adata[`lsaddr_low]==2'b0) ?
    wrt1_adata[`lsaddr_banks] : lowt(wrt1_adata[`lsaddr_banks]);
  assign wrt1_odd0[2:0]=(wrt1_adata[`lsaddr_sz]==5'h11 || wrt1_adata[`lsaddr_sz]==5'h10) ? {2'b0,wrt1_odd} : {wrt1_adata{`lsaddr_low],wrt1_odd}; 
  assign wrt1_odd0[3]=wrt1_adata[`lsaddr_sz]==5'hf;
  
  stq_buf_A_array A0_mod(
  clk,
  rst,
  stallA,
  excpt,
  wrt0_en0[31:0], wrt0_addrE, wrt0_addrO, 
  wrt1_en0[31:0], wrt1_addrE, wrt1_addrO, 
  chk0_en, chk0_addrEO[31:0], chk0_addrE, chk0_addrO,
  chk1_en, chk1_addrEO[31:0], chk1_addrE, chk1_addrO,
  chk2_en, chk2_addrEO[31:0], chk2_addrE, chk2_addrO,
  chk3_en, chk3_addrEO[31:0], chk3_addrE, chk3_addrO,
  chk4_en, chk4_addrEO[31:0], chk4_addrE, chk4_addrO,
  chk5_en, chk5_addrEO[31:0], chk5_addrE, chk5_addrO,
  upd0_en[31:0], 
  upd1_en[31:0], 
  free_en[31:0],,,,passe_en[31:0]);

  stq_buf_A_array A1_mod(
  clk,
  rst,
  stallA,
  excpt,
  wrt0_en0[63:32], wrt0_addrE, wrt0_addrO, 
  wrt1_en0[63:32], wrt1_addrE, wrt1_addrO, 
  chk0_en, chk0_addrEO[63:32], chk0_addrE, chk0_addrO,
  chk1_en, chk1_addrEO[63:32], chk1_addrE, chk1_addrO,
  chk2_en, chk2_addrEO[63:32], chk2_addrE, chk2_addrO,
  chk3_en, chk3_addrEO[63:32], chk3_addrE, chk3_addrO,
  chk4_en, chk4_addrEO[63:32], chk4_addrE, chk4_addrO,
  chk5_en, chk5_addrEO[63:32], chk5_addrE, chk5_addrO,
  upd0_en[63:32], 
  upd1_en[63:32], 
  free_en[63:32],,,,passe_en[63:32]);
endmodule