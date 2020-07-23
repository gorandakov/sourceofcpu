`include "../struct.sv"
`include "../fpoperations.sv"

module fpucadd(clk,rst,A,A_alt,B,and1,or1,copyA,prc_in,en,rmode,res,res_hi,res_alt,isDBL,fpcsr,raise,is_rndD,is_rndS);
  localparam [15:0] BIAS=16'h7fff;
  localparam ROUND_TRUNC=0;
  localparam ROUND_ROUND=1;
  localparam ROUND_EVEN =2;
  localparam ROUND_PLUS =3;
  localparam ROUND_MINUS=4;
  localparam ROUND_UP   =5;
  localparam ROUND_DOWN =6;
  parameter [0:0] H=0;//"high" nibble

  input clk;
  input rst;
  input [80:0] A;
  input [64:0] A_alt;
  input [80:0] B;
  input and1;
  input or1;
  input copyA;
  input prc_in;
  input en;
  input [2:0] rmode;
  output [67:0] res;
  output [15:0] res_hi;
  inout [67:0] res_alt; //connected between "high" and "low"
  input isDBL;
  input [31:0] fpcsr;
  output [10:0] raise;
  input is_rndD;
  input is_rndS; 
  
  //reg [80:0] A_reg;
 // reg [80:0] B_reg;
  wire [127:0] part0;
  wire [127:0] part1;

  wire [15:0] expA;
  wire [15:0] expB;
  wire [16:0] exp_exp;
  wire [16:0] exp_exp1;
  wire [16:0] expart0;
  wire [16:0] expart1;
  reg isDBL_reg;
  reg isDBL_reg2;
  reg isDBL_reg3;
  reg en_reg;
  reg en_reg2,en_reg3;
  wire sgn;
  reg sgn_reg,sgn_reg2,sgn_reg3;
  reg [16:0] exp_max;
  reg [16:0] exp_max_IEEE;
  reg [16:0] exp_denor;
  reg [16:0] exp_denor_IEEE;
  reg [16:0] exp_exp_reg;
  reg [16:0] exp_exp1_reg;
  wire [16:0] exp_exp_d;
  wire [16:0] exp_exp1_d;
  reg [16:0] exp_exp_reg2;
  reg [16:0] exp_exp1_reg2;
  reg [16:0] exp_exp_reg3;
  reg [16:0] exp_exp1_reg3;
  wire exp_oor,exp1_oor,exp_oor_IEEE,exp1_oor_IEEE;
  wire exp_non_denor_IEEE,exp1_non_denor_IEEE;
  reg exp_oor_reg,exp1_oor_reg,exp_oor_IEEE_reg,exp1_oor_IEEE_reg;
  reg exp_non_denor_IEEE_reg,exp1_non_denor_IEEE_reg;
  reg exp_oor_reg2,exp1_oor_reg2,exp_oor_IEEE_reg2,exp1_oor_IEEE_reg2;
  reg exp_non_denor_IEEE_reg2,exp1_non_denor_IEEE_reg2;

  reg [127:0] prod_reg;
  wire DBL_rnbit0,DBL_tail0,DBL_rnflip0;
  wire DBL_rnbitX,DBL_tailX,DBL_rnflipX;
  wire DBL_rnbit1,DBL_tail1;
  wire EXT_rnbit0,EXT_tail0,EXT_rnflip0;
  wire EXT_rnbitX,EXT_tailX,EXT_rnflipX;
  wire EXT_rnbitY,EXT_tailY,EXT_rnflipY;
  wire EXT_rnbit1,EXT_tail1;
  wire DBL_rnd0,DBL_rnd1,DBL_rndX;
  wire EXT_rnd0,EXT_rnd1,EXT_rndX,EXT_rndY;
  reg [62:-1] rndbit_ext;
  reg [51:-1] rndbit_dbl;
  //wire [62:-1] rndbit_ext={62'b0,prod_reg[127],~prod_reg[127]};
  //wire [51:-1] rndbit_dbl={51'b0,prod_reg[105],~prod_reg[105]};
  reg [62:-1] enbit_ext;
  reg [51:-1] enbit_dbl;
  reg [31:0] fpcsr_reg;
  reg [80:0] A_reg;
  reg [80:0] A_reg2;
  reg [80:0] A_reg3;
  wire [4:0] expon;
 // reg [1:0] expon_reg;

  wire A_h; 
  wire B_h; 

  wire A_zero,A_infty,A_nan;
  
  wire B_zero,B_infty,B_nan;

  wire spec_zero,spec_infty,spec_nan,spec_snan,spec_qnan,spec_A;
  reg spec_zero_reg,spec_infty_reg,spec_snan_reg,spec_qnan_reg,spec_A_reg;
  reg spec_zero_reg2,spec_infty_reg2,spec_snan_reg2,spec_qnan_reg2,spec_A_reg2;
  reg spec_zero_reg3,spec_infty_reg3,spec_snan_reg3,spec_qnan_reg3,spec_A_reg3;
  reg spec_any;
  wire [80:0] res_spec;
  reg isrnd_zero,isrnd_plus,isrnd_even;
  wire [127:0] prod;
  reg is_rndD_reg;
  reg is_rndS_reg; 
  reg is_rndD_reg2;
  reg is_rndS_reg2;
  reg is_rounder,is_rounderD,is_rounderS; 
  wire dummy1_1;
  wire dummy1_2;
  wire dummy1_3;
  wire dummy1_4;
  wire [15:0] emsk=isDBL ? 16'h87ff : 16'hffff;
//  reg or1,and1;
 //tbd: enable bit 
  fpucadd_compress compr_mod(clk,A[63:0],B[63:0],part0,part1,or1,and1);
  adder #(128) prodAdd_mod(part0,part1,prod,1'b0,1'b1,,,,);

  adder2oi #(64) resAddE_mod(enbit_ext,prod_reg[126:63],rndbit_ext,{res[63:33],res[31:0],dummy1_1},{dummy1_2,res[63:33],res[31:0]},1'b0,
      prod_reg[127] & EXT_rnd1 & ~spec_any & en_reg3 ||
      ~prod_reg[127] & EXT_rnd0 & EXT_rnflip0 & ~isDBL_reg3 & ~spec_any & en_reg3,
      ~prod_reg[127] & EXT_rnd0 & ~EXT_rnflip0 & ~isDBL_reg3 & ~spec_any & en_reg3,,,,);
  adder2oi #(53) resAddD_mod(enbit_dbl,prod_reg[104:52],rndbit_dbl,{res[52:33],res[31:0],dummy1_3},{dummy1_4,res[52:33],res[31:0]},1'b0,
      prod_reg[105] & DBL_rnd1 & isDBL_reg3 & ~spec_any & en_reg3 ||
      ~prod_reg[105] & DBL_rnd0 & DBL_rnflip0 & isDBL_reg3 & ~spec_any & en_reg3,
      ~prod_reg[105] & DBL_rnd0 & ~DBL_rnflip0 & isDBL_reg3 & ~spec_any & en_reg3,,,,);

  
  adder_CSA #(16) extAdd_mod(expA,expB,-BIAS,expart0,expart1);
  adder2c #(17) expAdd2_mod(expart0,expart1,exp_exp,exp_exp1,1'b0,1'b1,1'b1,1'b1,,,,);

  get_carry #(17) cmp0_mod(exp_max,~exp_exp_reg,1'b1,exp_oor);
  get_carry #(17) cmp1_mod(exp_max,~exp_exp1_reg,1'b1,exp1_oor);
  get_carry #(17) cmp2_mod(exp_max_IEEE,~exp_exp_reg,1'b1,exp_oor_IEEE);
  get_carry #(17) cmp3_mod(exp_max_IEEE,~exp_exp1_reg,1'b1,exp1_oor_IEEE);
  get_carry #(17) cmp4_mod(~exp_denor_IEEE,exp_exp_reg,1'b1,exp_non_denor_IEEE);
  get_carry #(17) cmp5_mod(~exp_denor_IEEE,exp_exp1_reg,1'b1,exp_non_denor_IEEE);

  generate
      if (!H) begin
          assign {res_alt[52:33],res_alt[31:0]}=prod_reg[105] ? prod_reg[104:53] :
              prod_reg[103:52];
          assign {res_alt[65],res_alt[64:53]}=prod_reg[105] ? {exp_exp1_reg3[15],sgn_reg3,exp_exp1_reg3[10:0]} : 
              {exp_exp_reg3[15],sgn_reg3,exp_exp_reg3[10:0]} : 13'bz;
          assign res_alt[32]=1'b0;
	  assign res_alt[67:66]=`ptype_dbl;
      end
  endgenerate
  assign exp_exp_d=exp_oor & ~fpcsr_reg[`csrfpu_clip_IEEE] ? exp_max : 17'b0;
  assign exp_exp_d=exp_oor_IEEE & fpcsr_reg[`csrfpu_clip_IEEE] ? exp_max_IEEE : 17'bz;
  assign exp_exp_d=~exp_non_denor_IEEE & fpcsr_reg[`csrfpu_daz] || exp_exp_reg[16] ? 17'b0 : 17'bz;
  assign exp_exp_d=~(exp_oor & ~fpcsr_reg[`csrfpu_clip_IEEE]) & 
    ~(exp_oor_IEEE & fpcsr_reg[`csrfpu_clip_IEEE]) & 
    ~(~exp_non_denor_IEEE & fpcsr_reg[`csrfpu_daz] || exp_exp_reg[16]) ? exp_exp_reg : 17'bz;
  
  assign exp_exp1_d=exp1_oor & ~fpcsr_reg[`csrfpu_clip_IEEE] ? exp_max : 17'b0;
  assign exp_exp1_d=exp1_oor_IEEE & fpcsr_reg[`csrfpu_clip_IEEE] ? exp_max_IEEE : 17'bz;
  assign exp_exp1_d=~exp1_non_denor_IEEE & fpcsr_reg[`csrfpu_daz] || exp_exp1_reg[16] ? 17'b0 : 17'bz;
  assign exp_exp1_d=~(exp1_oor & ~fpcsr_reg[`csrfpu_clip_IEEE]) & 
    ~(exp1_oor_IEEE & fpcsr_reg[`csrfpu_clip_IEEE]) & 
    ~(~exp1_non_denor_IEEE & fpcsr_reg[`csrfpu_daz] || exp_exp1_reg[16]) ? exp_exp1_reg : 17'bz;


  assign {res[63:33],res[31:0]}=(prod_reg[127] & ~isDBL_reg3 & ~EXT_rnd1 & ~spec_any & en_reg3) ? prod_reg[126:64]:63'bz;
  assign {res[63:33],res[31:0]}=(~prod_reg[127] & ~isDBL_reg3 & ~EXT_rnd0 & ~spec_any & en_reg3) ? prod_reg[125:63]:63'bz;
  assign {res[52:33],res[31:0]}=(prod_reg[105] & isDBL_reg3 & ~DBL_rnd1 & ~spec_any & en_reg3) ? prod_reg[104:53]:52'bz;
  assign {res[52:33],res[31:0]}=(~prod_reg[105] & isDBL_reg3 & ~DBL_rnd0 & ~spec_any & en_reg3) ? prod_reg[103:52]:52'bz;
   
  assign {res[65],res_hi,res[64]}=(prod_reg[127] & ~isDBL_reg3 & ~spec_any & en_reg3) ? {exp_exp1_reg3[15],sgn_reg3,exp_exp1_reg3[14:0],1'b1} : 18'bz;
  assign {res[65],res_hi,res[64]}=(~prod_reg[127] & ~isDBL_reg3 & ~spec_any & en_reg3) ? {exp_exp_reg3[15],sgn_reg3,exp_exp_reg3[14:0],1'b1} : 18'bz;
  assign {res[65],res[64:53]}=(prod_reg[105] & isDBL_reg3 & ~spec_any & en_reg3) ? {exp_exp1_reg3[15],sgn_reg3,exp_exp1_reg3[10:0]} : 13'bz;
  assign {res[65],res[64:53]}=(~prod_reg[105] & isDBL_reg3 & ~spec_any & en_reg3) ? {exp_exp_reg3[15],sgn_reg3,exp_exp_reg3[10:0]} : 13'bz;
  
  assign expon=(prod_reg[127] & ~isDBL_reg3 & ~spec_any) ? 
    {~EXT_rnbit1 & ~ EXT_tail1,exp_exp1_reg3[16],exp1_non_denor_IEEE_reg2,exp1_oor_IEEE_reg2,exp1_oor_reg2} : 5'bz;
  assign expon=(~prod_reg[127] & ~isDBL_reg3 & ~spec_any) ? 
    {~EXT_rnbit0 & ~ EXT_tail0,exp_exp_reg3[16],exp_non_denor_IEEE_reg2,exp_oor_IEEE_reg2,exp_oor_reg2} : 5'bz;
  assign expon=(prod_reg[105] & isDBL_reg3 & ~spec_any) ?
    {~DBL_rnbit1 & ~ DBL_tail1,exp_exp1_reg3[16],exp1_non_denor_IEEE_reg2,exp1_oor_IEEE_reg2,exp1_oor_reg2} : 5'bz;
  assign expon=(~prod_reg[105] & isDBL_reg3 & ~spec_any) ? 
    {~DBL_rnbit0 & ~ DBL_tail0,exp_exp_reg3[16],exp_non_denor_IEEE_reg2,exp_oor_IEEE_reg2,exp_oor_reg2} : 5'bz;
  assign expon=spec_any ? 5'd4 : 5'bz; 

  assign {res[65],res[64:33],res[31:0]}=(spec_any & en_reg3) ? {res_spec[80],res_spec[63:0]} : 65'bz;
  assign res_hi=(spec_any & ~isDBL_reg3 & en_reg3) ? res_spec[79:64] : 16'bz;
  
  assign res[67:66]=en_reg3 ? `ptype_dbl : 2'bz;
  assign res[32]=en_reg3 ? 1'b0 : 1'bz;

  assign DBL_rnbit0=prod_reg[51];
  assign DBL_tail0=|prod_reg[50:0];
  assign DBL_rnflip0=&prod_reg[103:52];
  assign DBL_rnbit1=prod_reg[52];
  assign DBL_tail1=DBL_tail0|DBL_rnbit0;
  assign DBL_rnbitX=prod_reg[80];
  assign DBL_tailX=|prod_reg[79:52];
  assign DBL_rnflipX=&prod_reg[103:81];

  assign DBL_rnd0=(~is_rounder && ~isrnd_zero && (DBL_rnbit0 & ~(isrnd_even & ~DBL_tail0 & prod_reg[52]) 
    || (isrnd_plus && DBL_rnbit0 | DBL_tail0))) | DBL_rndX;  
  assign DBL_rnd1=~isrnd_zero && (DBL_rnbit1 & ~(isrnd_even & ~DBL_tail1 & prod_reg[53]) 
    || (isrnd_plus && DBL_rnbit1 | DBL_tail1));  
  assign DBL_rndX=is_rounder && ~isrnd_zero && (DBL_rnbitX & ~(isrnd_even & ~DBL_tailX & prod_reg[52]) 
    || (isrnd_plus && DBL_rnbitX | DBL_tailX));  

  assign EXT_rnbit0=prod_reg[62];
  assign EXT_tail0=|prod_reg[61:51]|DBL_tail0;
  assign EXT_rnflip0=&prod_reg[125:63];
  assign EXT_rnbit1=prod_reg[63];
  assign EXT_tail1=|prod_reg[62:51]|DBL_tail0;
  assign EXT_rnbitX=prod_reg[73];
  assign EXT_tailX=|prod_reg[72:63];
  assign EXT_rnflipX=&prod_reg[125:74];
  assign EXT_rnbitY=prod_reg[102];
  assign EXT_tailY=|prod_reg[103:63];
  assign EXT_rnflipY=&prod_reg[125:103];
  
  assign EXT_rnd0=(~is_rounder && ~isrnd_zero && (EXT_rnbit0 & ~(isrnd_even & ~EXT_tail0 & prod_reg[63]) 
    || (isrnd_plus && EXT_rnbit0 | EXT_tail0))) | EXT_rndX | EXT_rndY;  
  assign EXT_rnd1=~isrnd_zero && (EXT_rnbit1 & ~(isrnd_even & ~EXT_tail1 & prod_reg[64]) 
    || (isrnd_plus && EXT_rnbit1 | EXT_tail1)); 
  assign EXT_rndX=is_rounderD && ~isrnd_zero && (EXT_rnbitX & ~(isrnd_even & ~EXT_tailX & prod_reg[63]) 
    || (isrnd_plus && EXT_rnbitX | EXT_tailX));  
  assign EXT_rndY=is_rounderS && ~isrnd_zero && (EXT_rnbitY & ~(isrnd_even & ~EXT_tailY & prod_reg[63]) 
    || (isrnd_plus && EXT_rnbitY | EXT_tailY));  
  
    //begin exp/sgn  
  assign expA=isDBL ? {A[80],{4{~A[80]}},A[62:52]} : {A[80],A[78:64]};  
  assign expB=isDBL ? {B[80],{4{~B[80]}},B[62:52]} : {B[80],B[78:64]};
  
 // assign A_h=isDBL ? {|A[51:0]} : {|A[62:0]}; 
 // assign B_h=isDBL ? {|B[51:0]} : {|B[62:0]}; 

  assign A_zero=(expA&emsk)==16'b0;
  assign A_infty=(expA|~emsk)==16'hfffe;
  assign A_nan=(expA|~emsk)==16'hffff;
  
  assign B_zero=(expB&emsk)==16'b0;
  assign B_infty=(expB|~emsk)==16'hfffe;
  assign B_nan=(expB|~emsk)==16'hffff;

  assign spec_zero=A_zero&~B_infty&~copyA||B_zero&~A_infty&~copyA;
  assign spec_infty=A_infty&~B_zero&~copyA||B_infty&~A_zero&~copyA;
  assign spec_nan=(A_infty & B_zero|| B_infty & A_zero || 
      A_nan&~B_infty&~B_zero || B_nan&~A_infty&~A_zero) &~copyA;
  assign spec_A=copyA;
  assign spec_snan=fpcsr[`csrfpu_inv_excpt]&spec_nan;
  assign spec_qnan=~fpcsr[`csrfpu_inv_excpt]&spec_nan;

  assign sgn=isDBL ? A[63]^B[63] : A[79]^B[79];
  
  assign res_spec=spec_A_reg3 ? A_reg3 : 81'bz;
  assign res_spec=(spec_snan_reg3 & ~isDBL_reg3) ? {17'h1ffff,64'b1} : 81'bz;
  assign res_spec=(spec_qnan_reg3 & ~isDBL_reg3) ? {17'h1ffff,64'h8000000000000001} : 81'bz;
  assign res_spec=(spec_infty_reg3 & ~isDBL_reg3) ? {1'b1,sgn_reg3,15'h7ffe,64'b0} : 81'bz;
  assign res_spec=(spec_snan_reg3 & isDBL_reg3) ? {17'h1ffff,64'hfff0000000000001} : 81'bz;
  assign res_spec=(spec_qnan_reg3 & isDBL_reg3) ? {17'h1ffff,64'hfff8000000000001} : 81'bz;
  assign res_spec=(spec_infty_reg3 & isDBL_reg3) ? {17'h1efff,sgn_reg3,63'h7fe0000000000000} : 81'bz;
  assign res_spec=spec_any ?  81'bz :  81'b0;

  assign raise[`csrfpu_inv_excpt]=spec_snan_reg3;
  assign raise[`csrfpu_under_excpt]=sgn_reg3 && expon[0];
  assign raise[`csrfpu_under_ieee_excpt]=sgn_reg3 && expon[1];
  assign raise[`csrfpu_over_excpt]=~sgn_reg3 && expon[0];
  assign raise[`csrfpu_over_ieee_excpt]=~sgn_reg3 && expon[1];
  assign raise[`csrfpu_denor_ieee_excpt]=~expon[2] | expon[3];
  assign raise[`csrfpu_denor_excpt]=expon[3];
  assign raise[`csrfpu_inexact_excpt]=expon[4] | expon[3];
  assign raise[`csrfpu_inexact_ieee_excpt]=expon[4] | expon[3] | ~expon[2];
  assign raise[`csrfpu_denor_consume_excpt]=1'b0;//only for logic op
  assign raise[`csrfpu_denor_produce_excpt]=1'b0;// ==//==

  always @(negedge clk)

  begin
      isDBL_reg<=isDBL;
      isDBL_reg2<=isDBL_reg;
      isDBL_reg3<=isDBL_reg2;
      en_reg<=en;
      en_reg2<=en_reg;
      en_reg3<=en_reg2;
      is_rndD_reg<=is_rndD;
      is_rndS_reg<=is_rndS; 
      is_rndD_reg2<=is_rndD_reg;
      is_rndS_reg2<=is_rndS_reg;
      is_rounder<=is_rndD_reg2|is_rndS_reg2; 
      is_rounderD<=is_rndD_reg2; 
      is_rounderS<=is_rndS_reg2; 
      exp_exp_reg<=exp_exp^17'h10000;
      exp_exp1_reg<=exp_exp1^17'h10000;
      exp_exp_reg2<=exp_exp_d;
      exp_exp1_reg2<=exp_exp1_d;
      exp_exp_reg3<=exp_exp_reg2;
      exp_exp1_reg3<=exp_exp1_reg2;
      exp_max<=isDBL ? 17'hffe : 17'hfffe;
      exp_max_IEEE<=isDBL ? 17'h7ff : 17'h7fff;
      exp_denor_IEEE<=isDBL ? 17'h401 : 17'h4001;
      fpcsr_reg<=fpcsr;
      if (~is_rndD_reg2 & ~is_rndS_reg2) begin
	  rndbit_ext={62'b0,prod_reg[127],~prod_reg[127]};
          rndbit_dbl={51'b0,prod_reg[105],~prod_reg[105]};
	  enbit_ext=64'hffff_ffff_ffff_ffff;
	  enbit_dbl=53'h1f_ffff_ffff_ffff;
      end else if (is_rndD_reg2) begin
	  rndbit_ext={52'b0,1'b1,11'b0};
          rndbit_dbl={51'b0,prod_reg[105],~prod_reg[105]};
	  enbit_ext=64'hffff_ffff_ffff_0000;
	  enbit_dbl=53'h1f_ffff_ffff_ffff;
      end else begin
	  rndbit_ext={23'b0,1'b1,40'b0};
	  rndbit_dbl={23'b0,1'b1,29'b0};
	  enbit_ext=64'hffff_ff00_0000_0000;
	  enbit_dbl=53'h1f_ffff_e000_0000;
      end
      sgn_reg<=sgn;
      sgn_reg2<=sgn_reg;
      sgn_reg3<=sgn_reg2;
      spec_zero_reg<=spec_zero;
      spec_infty_reg<=spec_infty;
      spec_snan_reg<=spec_snan;
      spec_qnan_reg<=spec_qnan;
      spec_A_reg<=spec_A;
      spec_zero_reg2<=spec_zero_reg;
      spec_infty_reg2<=spec_infty_reg;
      spec_snan_reg2<=spec_snan_reg;
      spec_qnan_reg2<=spec_qnan_reg;
      spec_A_reg2<=spec_A_reg;
      spec_zero_reg3<=spec_zero_reg2;
      spec_infty_reg3<=spec_infty_reg2;
      spec_snan_reg3<=spec_snan_reg2;
      spec_qnan_reg3<=spec_qnan_reg2;
      spec_A_reg3<=spec_A_reg2;
      spec_any<=spec_zero_reg2|spec_infty_reg2|spec_snan_reg2|spec_qnan_reg2|spec_A_reg2;
      exp_oor_reg<=exp_oor;
      exp1_oor_reg<=exp1_oor;
      exp_oor_IEEE_reg<=exp_oor_IEEE;
      exp1_oor_IEEE_reg<=exp1_oor_IEEE;
      exp_non_denor_IEEE_reg<=exp_non_denor_IEEE;
      exp1_non_denor_IEEE_reg<=exp1_non_denor_IEEE;
      exp_oor_reg2<=exp_oor_reg;
      exp1_oor_reg2<=exp1_oor_reg;
      exp_oor_IEEE_reg2<=exp_oor_IEEE_reg;
      exp1_oor_IEEE_reg2<=exp1_oor_IEEE_reg;
      exp_non_denor_IEEE_reg2<=exp_non_denor_IEEE_reg;
      exp1_non_denor_IEEE_reg2<=exp1_non_denor_IEEE_reg;
      A_reg<=copyA ? {A_alt[64],16'b0,A_alt[63:0]} : A;
      A_reg2<=A_reg;
      A_reg3<=A_reg2;
      prod_reg<=prod;
      case(rmode)
        ROUND_TRUNC: begin isrnd_even<=1'b0; isrnd_zero<=1'b1; isrnd_plus<=1'b0; end
        ROUND_ROUND: begin isrnd_even<=1'b0; isrnd_zero<=1'b0; isrnd_plus<=1'b0; end
        ROUND_EVEN : begin isrnd_even<=1'b1; isrnd_zero<=1'b0; isrnd_plus<=1'b0; end
        ROUND_PLUS : begin isrnd_even<=1'b0; isrnd_zero<=sgn_reg2; isrnd_plus<=1'b0; end
        ROUND_MINUS: begin isrnd_even<=1'b0; isrnd_zero<=~sgn_reg2; isrnd_plus<=1'b0; end
        ROUND_UP   : begin isrnd_even<=1'b0; isrnd_zero<=sgn_reg2; isrnd_plus<=~sgn_reg2; end
        ROUND_DOWN : begin isrnd_even<=1'b0; isrnd_zero<=~sgn_reg2; isrnd_plus<=sgn_reg2; end
      endcase
  end

endmodule


