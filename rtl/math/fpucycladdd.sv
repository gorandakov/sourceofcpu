`include "../struct.sv"
`include "../fpoperations.sv"

module fpucadd(clk,rst,A,A_alt,B,copyA,en,rmode,res,res_hi,exp_hi,sgn_hi,fpcsr,raise,is_rndS,isFMA,isFNMA);
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
  input [64:0] A;
  input [64:0] A_alt;
  input [64:0] B;
  input copyA;
  input en;
  input [2:0] rmode;
  output [67:0] res;
  output [105:0] res_hi;
  output [11:0] exp_hi;
  output sgn_hi;
  input [31:0] fpcsr;
  output [10:0] raise;
  input is_rndS; 
  input isFMA;
  input isFNMA; 
  //reg [80:0] A_reg;
 // reg [80:0] B_reg;
  wire [105:0] part0;
  wire [105:0] part1;

  wire [11:0] expA;
  wire [11:0] expB;
  wire [12:0] exp_exp;
  wire [12:0] exp_exp1;
  wire [12:0] expart0;
  wire [12:0] expart1;
  reg en_reg;
  reg en_reg2,en_reg3;
  wire sgn;
  reg sgn_reg,sgn_reg2,sgn_reg3;
  reg [12:0] exp_max;
  reg [12:0] exp_max_IEEE;
  reg [12:0] exp_denor;
  reg [12:0] exp_denor_IEEE;
  reg [12:0] exp_exp_reg;
  reg [12:0] exp_exp1_reg;
  wire [12:0] exp_exp_d;
  wire [12:0] exp_exp1_d;
  reg [12:0] exp_exp_reg2;
  reg [12:0] exp_exp1_reg2;
  reg [12:0] exp_exp_reg3;
  reg [12:0] exp_exp1_reg3;
  wire exp_oor,exp1_oor,exp_oor_IEEE,exp1_oor_IEEE;
  wire exp_non_denor_IEEE,exp1_non_denor_IEEE;
  reg exp_oor_reg,exp1_oor_reg,exp_oor_IEEE_reg,exp1_oor_IEEE_reg;
  reg exp_non_denor_IEEE_reg,exp1_non_denor_IEEE_reg;
  reg exp_oor_reg2,exp1_oor_reg2,exp_oor_IEEE_reg2,exp1_oor_IEEE_reg2;
  reg exp_non_denor_IEEE_reg2,exp1_non_denor_IEEE_reg2;

  reg [105:0] prod_reg;
  wire DBL_rnbit0,DBL_tail0,DBL_rnflip0;
  wire DBL_rnbitX,DBL_tailX,DBL_rnflipX;
  wire DBL_rnbit1,DBL_tail1;
  wire DBL_rnd0,DBL_rnd1,DBL_rndX;
  reg [51:-1] rndbit_dbl;
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
  wire [64:0] res_spec;
  reg isrnd_zero,isrnd_plus,isrnd_even;
  wire [105:0] prod;
  reg is_rndD_reg;
  reg is_rndS_reg; 
  reg is_rndD_reg2;
  reg is_rndS_reg2;
  reg is_rounder,is_rounderD,is_rounderS; 
  wire dummy1_1;
  wire dummy1_2;
  wire dummy1_3;
  wire dummy1_4;
  wire [11:0] emsk=isDBL ? 12'h87f : 12'hfff;
//  reg or1,and1;
 //tbd: enable bit 
  fpucadd_compress compr_mod(clk,{1'b1,A[51:0]},{1'b1,B[51:0]},part0,part1);
  adder #(106) prodAdd_mod(part0,part1,prod,1'b0,1'b1,,,,);

  adder2oi #(53) resAddD_mod(enbit_dbl,prod_reg[104:52],rndbit_dbl,{res[52:33],res[31:0],dummy1_3},{dummy1_4,res[52:33],res[31:0]},1'b0,
      prod_reg[105] & DBL_rnd1 & ~spec_any & en_reg3 ||
      ~prod_reg[105] & DBL_rnd0 & DBL_rnflip0 & ~spec_any & en_reg3,
      ~prod_reg[105] & DBL_rnd0 & ~DBL_rnflip0 & ~spec_any & en_reg3,,,,);

  
  adder_CSA #(12) extAdd_mod(expA,expB,-BIAS,expart0,expart1);
  adder2c #(13) expAdd2_mod(expart0,expart1,exp_exp,exp_exp1,1'b0,1'b1,1'b1,1'b1,,,,);

  get_carry #(13) cmp0_mod(exp_max,~exp_exp_reg,1'b1,exp_oor);
  get_carry #(13) cmp1_mod(exp_max,~exp_exp1_reg,1'b1,exp1_oor);
  get_carry #(13) cmp2_mod(exp_max_IEEE,~exp_exp_reg,1'b1,exp_oor_IEEE);
  get_carry #(13) cmp3_mod(exp_max_IEEE,~exp_exp1_reg,1'b1,exp1_oor_IEEE);
  get_carry #(13) cmp4_mod(~exp_denor_IEEE,exp_exp_reg,1'b1,exp_non_denor_IEEE);
  get_carry #(13) cmp5_mod(~exp_denor_IEEE,exp_exp1_reg,1'b1,exp_non_denor_IEEE);

  assign exp_exp_d=exp_oor & ~fpcsr_reg[`csrfpu_clip_IEEE] ? exp_max : 13'b0;
  assign exp_exp_d=exp_oor_IEEE & fpcsr_reg[`csrfpu_clip_IEEE] ? exp_max_IEEE : 13'bz;
  assign exp_exp_d=~exp_non_denor_IEEE & fpcsr_reg[`csrfpu_daz] || exp_exp_reg[12] ? 13'b0 : 13'bz;
  assign exp_exp_d=~(exp_oor & ~fpcsr_reg[`csrfpu_clip_IEEE]) & 
    ~(exp_oor_IEEE & fpcsr_reg[`csrfpu_clip_IEEE]) & 
    ~(~exp_non_denor_IEEE & fpcsr_reg[`csrfpu_daz] || exp_exp_reg[12]) ? exp_exp_reg : 13'bz;
  
  assign exp_exp1_d=exp1_oor & ~fpcsr_reg[`csrfpu_clip_IEEE] ? exp_max : 13'b0;
  assign exp_exp1_d=exp1_oor_IEEE & fpcsr_reg[`csrfpu_clip_IEEE] ? exp_max_IEEE : 13'bz;
  assign exp_exp1_d=~exp1_non_denor_IEEE & fpcsr_reg[`csrfpu_daz] || exp_exp1_reg[12] ? 13'b0 : 13'bz;
  assign exp_exp1_d=~(exp1_oor & ~fpcsr_reg[`csrfpu_clip_IEEE]) & 
    ~(exp1_oor_IEEE & fpcsr_reg[`csrfpu_clip_IEEE]) & 
    ~(~exp1_non_denor_IEEE & fpcsr_reg[`csrfpu_daz] || exp_exp1_reg[12]) ? exp_exp1_reg : 13'bz;


  assign {res[52:33],res[31:0]}=(prod_reg[105] & ~DBL_rnd1 & ~spec_any & en_reg3) ? prod_reg[104:53]:52'bz;
  assign {res[52:33],res[31:0]}=(~prod_reg[105] & ~DBL_rnd0 & ~spec_any & en_reg3) ? prod_reg[103:52]:52'bz;
   
  assign {res[65],res[64:53]}=(prod_reg[105] & ~spec_any & en_reg3) ? {exp_exp1_reg3[11],sgn_reg3,exp_exp1_reg3[10:0]} : 13'bz;
  assign {res[65],res[64:53]}=(~prod_reg[105] &  ~spec_any & en_reg3) ? {exp_exp_reg3[11],sgn_reg3,exp_exp_reg3[10:0]} : 13'bz;
  
  assign expon=(prod_reg[105] & ~spec_any) ?
    {~DBL_rnbit1 & ~ DBL_tail1,exp_exp1_reg3[12],exp1_non_denor_IEEE_reg2,exp1_oor_IEEE_reg2,exp1_oor_reg2} : 5'bz;
  assign expon=(~prod_reg[105] & ~spec_any) ? 
    {~DBL_rnbit0 & ~ DBL_tail0,exp_exp_reg3[12],exp_non_denor_IEEE_reg2,exp_oor_IEEE_reg2,exp_oor_reg2} : 5'bz;
  assign expon=spec_any ? 5'd4 : 5'bz; 

  assign {res[65],res[64:33],res[31:0]}=(spec_any & en_reg3) ? {res_spec[64],res_spec[63:0]} : 65'bz;
  assign res_hi=(spec_any & en_reg3) ? 52'b0:  52'bz;
  
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

  
    //begin exp/sgn  
  assign expA={A[64],A[62:52]};  
  assign expB={B[64],B[62:52]};
  
  assign A_zero=(expA&emsk)==12'b0;
  assign A_infty=(expA|~emsk)==12'hffe;
  assign A_nan=(expA|~emsk)==12'hfff;
  
  assign B_zero=(expB&emsk)==12'b0;
  assign B_infty=(expB|~emsk)==12'hffe;
  assign B_nan=(expB|~emsk)==12'hfff;

  assign spec_zero=A_zero&~B_infty&~copyA||B_zero&~A_infty&~copyA;
  assign spec_infty=A_infty&~B_zero&~copyA||B_infty&~A_zero&~copyA;
  assign spec_nan=(A_infty & B_zero|| B_infty & A_zero || 
      A_nan&~B_infty&~B_zero || B_nan&~A_infty&~A_zero) &~copyA;
  assign spec_A=copyA;
  assign spec_snan=fpcsr[`csrfpu_inv_excpt]&spec_nan;
  assign spec_qnan=~fpcsr[`csrfpu_inv_excpt]&spec_nan;

  assign sgn=A[63]^B[63];
  
  assign res_spec=spec_A_reg3 ? A_reg3 : 65'bz;
  assign res_spec=(spec_snan_reg3) ? {65'h17ff0000000000000} : 65'bz;
  assign res_spec=(spec_qnan_reg3) ? {65'h17ff4000000000000} : 65'bz;
  assign res_spec=(spec_infty_reg3) ? {1'b1,sgn_reg3,62'h7fe8000000000000} : 65'bz;
  assign res_spec=spec_any ?  65'bz :  65'b0;

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
      en_reg<=en;
      en_reg2<=en_reg;
      en_reg3<=en_reg2;
      is_rndS_reg<=is_rndS; 
      is_rndS_reg2<=is_rndS_reg;
      is_rounder<=is_rndS_reg2; 
      is_rounderS<=is_rndS_reg2; 
      exp_exp_reg<=exp_exp^13'h1000;
      exp_exp1_reg<=exp_exp1^13'h1000;
      exp_exp_reg2<=exp_exp_d;
      exp_exp1_reg2<=exp_exp1_d;
      exp_exp_reg3<=exp_exp_reg2;
      exp_exp1_reg3<=exp_exp1_reg2;
      exp_max<=13'hffe;
      exp_max_IEEE<=13'hbff;
      exp_denor_IEEE<=13'h401;
      fpcsr_reg<=fpcsr;
      if (~is_rndS_reg2) begin
          rndbit_dbl={51'b0,prod_reg[105],~prod_reg[105]};
	  enbit_dbl=53'h1f_ffff_ffff_ffff;//add ahrdware denot? 
      end else begin
	  rndbit_dbl={23'b0,1'b1,29'b0};
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
      A_reg<=copyA ? {A_alt[64],A_alt[63:0]} : A;
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


