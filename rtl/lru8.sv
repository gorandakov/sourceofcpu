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


`include "struct.sv"


module lru_single0(
  lru,
  newLRU,
  hitLRU,
  init,
  en
  );
  parameter WIDTH=3;
  parameter [WIDTH-1:0] INITVAL=0;
  
  input [WIDTH-1:0] lru;
  output [WIDTH-1:0] newLRU;
  input [WIDTH-1:0] hitLRU;
  input init;
  input en;
  
  wire [WIDTH-1:0] newLRU_X;
  assign newLRU=newLRU_X;
  
  wire hitThis;
  wire hitThisOrAfter;
  wire hitBefore;
  wire hitAfter;
  wire [WIDTH-1:0] lru_next;
  
  assign hitThis=hitLRU==lru;
  assign hitAfter=hitThisOrAfter & ~hitThis;
  assign hitBefore=~hitThisOrAfter;
  
  assign newLRU_X=(hitThis & ~init &en) ? {WIDTH{1'B0}} : {WIDTH{{1{1'bz}}}};
  assign newLRU_X=(hitAfter & ~init &en) ? lru : {WIDTH{{1{1'bz}}}};
  assign newLRU_X=(hitBefore & ~init &en)? lru_next : {WIDTH{{1{1'bz}}}};
  assign newLRU_X=init ? INITVAL : {WIDTH{{1{1'bz}}}};
  assign newLRU_X=(~en & ~init) ? lru : {WIDTH{{1{1'bz}}}};
  
  generate
      if (WIDTH>1) begin : adders_gen
          get_carry #(WIDTH) cmp_mod (lru,~hitLRU,1'b1,hitThisOrAfter);   
          adder_inc #(WIDTH) inc_mod (lru,lru_next,1'b1,);
      end else begin
          assign hitThisOrAfter=lru|~hitLRU;
          assign lru_next=~lru;
      end
  endgenerate
endmodule


module lru_single(
//save gate delay
  lru,
  newLRU,
  hitLRU,
  init,
  en
  );
  parameter WIDTH=2;
  parameter [WIDTH-1:0] INITVAL=0;
  localparam COUNT=1<<WIDTH;
  
  input [WIDTH-1:0] lru;
  output [WIDTH-1:0] newLRU;
  input [WIDTH-1:0] hitLRU;
  input init;
  input en;

  wire [COUNT-1:0][WIDTH-1:0] newLRUa;
  wire [WIDTH-1:0] newLRU_X;

  assign newLRU=newLRU_X;
  
  genvar k;
  
  generate
    for(k=0;k<COUNT;k=k+1)
	  begin : lru_gen
        lru_single0 #(WIDTH,INITVAL) lru_mod(
        lru,
        newLRUa[k],
        k[WIDTH-1:0],
        init,
        en
        );	
        assign newLRU_X= (hitLRU==k && ~init)  ? newLRUa[k] : {WIDTH{{1{1'bz}}}};		
	  end
  endgenerate
  
  assign newLRU_X=init ? INITVAL : {WIDTH{{1{1'bz}}}};
  
endmodule



module lru_double(
  lru,
  newLRU,
  hitLRUA,
  hitLRUB,
  isDouble,
  init,
  en
  );
  parameter WIDTH=3;
  parameter [WIDTH-1:0] INITVAL=0;
  
  input [WIDTH-1:0] lru;
  output [WIDTH-1:0] newLRU;
  input [WIDTH-1:0] hitLRUA;
  input [WIDTH-1:0] hitLRUB;
  input isDouble;
  input init;
  input en;
  
  wire hitThisA;
  wire hitThisB;
  wire hitThisOrAfterA;
  wire hitThisOrAfterB;
  wire hitBefore1;
  wire hitBefore2;
  wire hitAfter;
  wire [WIDTH-1:0] lru_next;
  wire [WIDTH-1:0] lru_next2;
  
  assign hitThisA=hitLRUA==lru;
  assign hitThisB=hitLRUB==lru;
  assign hitAfter=hitThisOrAfterA & ~hitThisA && (hitThisOrAfterB & ~hitThisB) | ~isDouble;
  assign hitBefore1=~hitThisOrAfterA ^ (~hitThisOrAfterB & isDouble);
  assign hitBefore2=~hitThisOrAfterA & ~hitThisOrAfterB & isDouble;
  
  assign newLRU=(hitThisA & ~init &en) ? {WIDTH{1'B0}} : {WIDTH{{1{1'bz}}}};
  assign newLRU=(hitThisB & ~init &en & isDouble) ? 1 : {WIDTH{{1{1'bz}}}};

  assign newLRU=(hitAfter & ~init &en) ? lru : {WIDTH{{1{1'bz}}}};
  assign newLRU=(hitBefore1 & ~init &en)? lru_next : {WIDTH{{1{1'bz}}}};
  assign newLRU=(hitBefore2 & ~init &en)? lru_next2 : {WIDTH{{1{1'bz}}}};
  assign newLRU=init ? INITVAL : {WIDTH{{1{1'bz}}}};
  assign newLRU=(~en & ~init) ? lru : {WIDTH{{1{1'bz}}}};
  
  assign lru_next2[0]=lru[0];
  
  get_carry #(WIDTH) cmpA_mod (hitLRUA,~lru,1'b1,hitThisOrAfterA);   
  get_carry #(WIDTH) cmpB_mod (hitLRUB,~lru,1'b1,hitThisOrAfterB);   

  adder_inc #(WIDTH) incA_mod (lru,lru_next,1'b1,);
  adder_inc #(WIDTH-1) incB_mod (lru[WIDTH-1:1],lru_next2[WIDTH-1:1],1'b1,);

endmodule

