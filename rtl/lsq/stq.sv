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
  pse0_WQ,pse0_en,
  pse1_WQ,pse1_en,
  wb1_adata,wb1_LSQ,wb1_data,wb1_bnkEn,wb1_en,wb1_way,
  wb0_adata,wb0_LSQ,wb0_data,wb0_bnkEn,wb0_en,
  );
  generate
      genvar b,x;
      for(b=0;b<4;b=b+1) begin : L
          stq_buf_L_array arr0_mod(
          clk,
          rst,
          aStall|aDoStall,
          excpt,
          wrt0_en, wrt0_addrEO[b], wrt0_odd[b], wrt0_bytes[b], wrt0_subBNK[b],
          wrt1_en, wrt1_addrEO[b], wrt1_odd[b], wrt1_bytes[b], wrt1_subBNK[b],
          chk0_en, chk0_addrEO[b], chk0_odd[b], chk0_bytes[b], chk0_subBNK[b], chk0_match[b][31:0], chk0_partial[b][31:0],
          chk1_en, chk1_addrEO[b], chk1_odd[b], chk1_bytes[b], chk1_subBNK[b], chk1_match[b][31:0], chk1_partial[b][31:0],
          chk2_en, chk2_addrEO[b], chk2_odd[b], chk2_bytes[b], chk2_subBNK[b], chk2_match[b][31:0], chk2_partial[b][31:0],
          chk3_en, chk3_addrEO[b], chk3_odd[b], chk3_bytes[b], chk3_subBNK[b], chk3_match[b][31:0], chk3_partial[b][31:0],
          chk4_en, chk4_addrEO[b], chk4_odd[b], chk4_bytes[b], chk4_subBNK[b], chk4_match[b][31:0], chk4_partial[b][31:0],
          chk5_en, chk5_addrEO[b], chk5_odd[b], chk5_bytes[b], chk5_subBNK[b], chk5_match[b][31:0], chk5_partial[b][31:0],
          upd0_en[31:0], 
          upd1_en[31:0], 
          free_en[31:0],free[31:0],upd[31:0],passe[31:0],passe_en[31:0]);end

          stq_buf_L_array arr1_mod(
          clk,
          rst,
          aStall|aDoStall,
          excpt,
          wrt0_en, wrt0_addrEO[b], wrt0_odd[b], wrt0_bytes[b], wrt0_subBNK[b],
          wrt1_en, wrt1_addrEO[b], wrt1_odd[b], wrt1_bytes[b], wrt1_subBNK[b],
          chk0_en, chk0_addrEO[b], chk0_odd[b], chk0_bytes[b], chk0_subBNK[b], chk0_match[b][31:0], chk0_partial[b][31:0],
          chk1_en, chk1_addrEO[b], chk1_odd[b], chk1_bytes[b], chk1_subBNK[b], chk1_match[b][31:0], chk1_partial[b][31:0],
          chk2_en, chk2_addrEO[b], chk2_odd[b], chk2_bytes[b], chk2_subBNK[b], chk2_match[b][31:0], chk2_partial[b][31:0],
          chk3_en, chk3_addrEO[b], chk3_odd[b], chk3_bytes[b], chk3_subBNK[b], chk3_match[b][31:0], chk3_partial[b][31:0],
          chk4_en, chk4_addrEO[b], chk4_odd[b], chk4_bytes[b], chk4_subBNK[b], chk4_match[b][31:0], chk4_partial[b][31:0],
          chk5_en, chk5_addrEO[b], chk5_odd[b], chk5_bytes[b], chk5_subBNK[b], chk5_match[b][31:0], chk5_partial[b][31:0],
          upd0_en[31:0], 
          upd1_en[31:0], 
          free_en[31:0],free[31:0],upd[31:0],passe[31:0],passe_en[31:0]);end
  endgenerate
endmodule
