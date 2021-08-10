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
  
  wire hitThis;
  wire hitThisOrAfter;
  wire hitBefore;
  wire hitAfter;
  wire [WIDTH-1:0] lru_next;
  
  assign hitThis=hitLRU==lru;
  assign hitAfter=hitThisOrAfter & ~hitThis;
  assign hitBefore=~hitThisOrAfter;
  
  assign newLRU=(hitThis & ~init &en) ? {WIDTH{1'B0}} : {WIDTH{1'BZ}};
  assign newLRU=(hitAfter & ~init &en) ? lru : {WIDTH{1'BZ}};
  assign newLRU=(hitBefore & ~init &en)? lru_next : {WIDTH{1'BZ}};
  assign newLRU=init ? INITVAL : {WIDTH{1'BZ}};
  assign newLRU=(~en & ~init) ? lru : {WIDTH{1'BZ}};
  
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
        assign newLRU= (hitLRU==k && ~init)  ? newLRUa[k] : {WIDTH{1'BZ}};		
	  end
  endgenerate
  
  assign newLRU=init ? INITVAL : {WIDTH{1'bz}};
  
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
  
  assign newLRU=(hitThisA & ~init &en) ? {WIDTH{1'B0}} : {WIDTH{1'BZ}};
  assign newLRU=(hitThisB & ~init &en & isDouble) ? 1 : {WIDTH{1'BZ}};

  assign newLRU=(hitAfter & ~init &en) ? lru : {WIDTH{1'BZ}};
  assign newLRU=(hitBefore1 & ~init &en)? lru_next : {WIDTH{1'BZ}};
  assign newLRU=(hitBefore2 & ~init &en)? lru_next2 : {WIDTH{1'BZ}};
  assign newLRU=init ? INITVAL : {WIDTH{1'BZ}};
  assign newLRU=(~en & ~init) ? lru : {WIDTH{1'BZ}};
  
  assign lru_next2[0]=lru[0];
  
  get_carry #(WIDTH) cmpA_mod (hitLRUA,~lru,1'b1,hitThisOrAfterA);   
  get_carry #(WIDTH) cmpB_mod (hitLRUB,~lru,1'b1,hitThisOrAfterB);   

  adder_inc #(WIDTH) incA_mod (lru,lru_next,1'b1,);
  adder_inc #(WIDTH-1) incB_mod (lru[WIDTH-1:1],lru_next2[WIDTH-1:1],1'b1,);

endmodule

