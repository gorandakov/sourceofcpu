`include "../fpoperations.sv"
`include "../struct.sv"

module fadd(
  clk,
  rst,
  A,
  A_alt,
  B,
  B_hi,
  B_exp_hi,
  B_sgn_hi,
  isSub,//inclusive of isRSub
  isRSub,
  fpcsr,
  raise,
  rmode,
  en,
  copyA,
  logic_en,
  logic_sel,
  res
  );
  localparam ROUND_TRUNC=0;
  localparam ROUND_ROUND=1;
  localparam ROUND_EVEN =2;
  localparam ROUND_PLUS =3;
  localparam ROUND_MINUS=4;
  localparam ROUND_UP   =5;
  localparam ROUND_DOWN =6;

  input clk;
  input rst;
  input [64:0] A;
  input [64:0] A_alt;
  input [64:0] B;
  input [105:0] B_hi;
  input [11:0] B_exp_hi;
  input B_sgn_hi;
  input isSub;
  input isRSub;
  input [31:0] fpcsr;
  output [10:0] raise;
  input [2:0] rmode;
  input en;
  input copyA;
  input logic_en;
  input [1:0] logic_sel;
  output [67:0] res;
  output [15:0] res_hi;
//need to set bit 53 to one if isDBL; not yet done
//need to clear/set bits 63-54 if isDBL and corresponging conditions
//if no isDBL, set one op low bits to 0, other to one depening on rounding
//width

  wire sxor;
  reg sxor_reg;
  wire a_more;
  wire [105:0] opA;
  wire [105:0] opB;
  wire moreAD,moreAE;
  wire [11:0] expdiffA;
  wire [11:0] expdiffB;
  wire [11:0] expdiff;
  reg  [11:0] expdiff_reg;
  wire [105:0] opBs1;
  wire [105:0] opBs;
  reg [105:0] opBs1_reg;
  reg [105:0] opA_reg;
//  reg [63:0] opB_reg;
  wire [106:0] partM0;
  wire [106:0] partM1;
  wire [106:0] partMs0;
  wire [106:0] partMs1;
  wire [52:0] resS1;
  wire [52:0] resSR1;
  reg [52:0] resS1_reg;
  reg [52:0] resSR1_reg;
  wire resS_rnbit;
  wire res_rnbit,res_tail,res_andtail;
  wire res_rnbitC,res_tailC,res_andtailC;
  wire res_rnbitL,res_tailL,res_andtailL;
  wire expoor;//completely off-precision shift!
  reg expoor_reg; 
  wire alt_en;
  wire A_s,B_s,A_s1,B_s1;
  reg A_s1_reg;
  wire renor_simple,renor_round;
  wire Smain_simple,Smain_round;
  wire Smain_simpleC,Smain_roundC,Smain_simpleRC;
  wire Smain_simpleL,Smain_roundL,Smain_subroundL;
  wire [63:0] renorS;
  wire [63:0] renorSR;
  wire [7:0] andtailBs1;
  wire [7:0] andtailBs;
  wire [7:0] andtailBs1_c;
  wire [7:0] andtailBs_c;
  wire [7:0] andtailBs1_L;
  wire [7:0] andtailBs_L;
  wire [7:0] tailBs1;
  wire [7:0] tailBs;
  wire [7:0] tailBs1_c;
  wire [7:0] tailBs_c;
  wire [7:0] tailBs1_L;
  wire [7:0] tailBs_L;
  reg andtailBs1_reg;
  reg andtailBs1_c_reg;
  reg andtailBs1_L_reg;
  reg tailBs1_reg;
  reg tailBs1_c_reg;
  reg tailBs1_L_reg;
  wire [105:0] resM1;
  wire [105:0] resMR1;
  wire [105:0] resM2;
  wire [105:0] resMR2;
  wire cout64_M1_ns,cout64_MR1_ns,cout53_M1_ns,cout53_MR1_ns;
  wire cout64_M2_ns,cout64_MR2_ns,cout53_M2_ns,cout53_MR2_ns;
  wire cout64_SZ1,cout64_SZR1,cout53_SZ1,cout53_SZR1;
  wire cout64_Sz1,cout64_SzR1,cout53_Sz1,cout53_SzR1;
  wire cout64_S1,cout64_SR1,cout53_S1,cout53_SR1;
  wire [53:0] par1Off_A;
  wire [53:0] par1Off_B;
  wire [53:0] part_A;
  wire [53:0] part_B;
  wire [53:0] partt_A;
  wire [53:0] partt_B;
  reg [7:0] expdiffeq;
  wire [9:0] xop1;
  reg [9:0] xop1_reg;
  reg isrnd_zero,isrnd_even,isrnd_plus;

  wire Smain_lo,Smain_ulo;
  wire [11:0] opA_exp;
  wire [11:0] opA_exp_inc;
  wire [11:0] opA_exp_dec;
  reg [11:0] opA_exp_reg;
  wire altpath;
  reg altpath_reg;
  wire rndpath;
  reg rndpath_reg;
  reg opB_reg;
  wire [11:0] A_exp;
  wire [11:0] B_exp;
  wire A_zero,A_infty,A_nan;
  wire B_zero,B_infty,B_nan;
  wire spec_snan,spec_qnan,spec_pinf,spec_ninf,spec_A,spec_B;
  reg spec_snan_reg,spec_qnan_reg,spec_pinf_reg,spec_ninf_reg,spec_A_reg,spec_B_reg;
  wire [3:0] spec_logic;
  reg [3:0] spec_logic_reg;
  reg spec_any;
  wire [64:0] res_spec;
  reg [64:0] A_reg;
  reg [64:0] B_reg;
  wire A_s2;
  reg en_reg;
  wire [11:0] emsk=isDBL ? 16'h87f : 16'hfff;
  integer m;

  wire renor_any,exp_dec_non_denor_IEEE_0,exp_dec_non_denor_IEEE_1,exp_dec_non_denor,exp_inc_oor_IEEE,exp_inc_oor,
	  exp_dec_non_denor_IEEE;
  wire [11:0] exp_min_IEEE;
  wire [11:0] exp_max_IEEE;
  wire [11:0] exp_min_kludge;
  wire [11:0] exp_max;
  reg exp_inc_oor_reg,exp_inc_oor_IEEE_reg,exp_dec_non_denor_reg,exp_dec_non_denor_IEEE_reg;
  wire [3:0] xpon;
  wire [3:0] X_xpon;
  wire [3:0] Y_xpon;
  wire invExcpt;

  assign A_exp={A[64],A[62:52]};
  assign B_exp=isFMA ? B_exp_hi : {B[64],B[62:52]};

 // assign A_h=isDBL ? {|A[51:0]} : {|A[62:0]}; 
 // assign B_h=isDBL ? {|B[51:0]} : {|B[62:0]}; 

  assign A_zero=(A_exp&emsk)==12'b0;
  assign A_infty=(A_exp|~emsk)==12'hffe;
  assign A_nan=(A_exp|~emsk)==12'hfff;
  
  assign B_zero=(B_exp&emsk)==12'b0;
  assign B_infty=(B_exp|~emsk)==12'hffe;
  assign B_nan=(B_exp|~emsk)==12'hfff;

  assign invExcpt=fpcsr[`csrfpu_inv_excpt];

  assign spec_snan=A_nan & ~B_infty & invExcpt & ~copyA || B_nan & ~A_infty & invExcpt & ~copyA || A_infty & B_infty & sxor & invExcpt & ~copyA;  
  assign spec_qnan=A_nan & ~B_infty & ~invExcpt & ~copyA || B_nan & ~A_infty & ~invExcpt & ~copyA || A_infty & B_infty & sxor & ~invExcpt & ~copyA;
  assign spec_pinf=(A_infty && ~A_s && ~B_infty|~B_s && ~copyA) || (B_infty && ~B_s && ~A_infty|~A_s && ~copyA);   
  assign spec_ninf=(A_infty && A_s && ~B_infty|B_s && ~copyA) || (B_infty && B_s && ~A_infty|A_s && ~copyA);
  assign spec_A=(B_zero && ~A_zero|~A_s|B_s && ~A_nan && ~A_infty)||copyA;
  assign spec_B=(A_zero && ~B_zero|(~B_s&A_s) && ~B_nan && ~B_infty)&&~copyA;
  assign spec_logic[0]=logic_en && logic_sel==2'd0 && ~copyA;
  assign spec_logic[1]=logic_en && logic_sel==2'd1 && ~copyA;
  assign spec_logic[2]=logic_en && logic_sel==2'd2 && ~copyA;
  assign spec_logic[3]=logic_en && logic_sel==2'd3 && ~copyA;
 
 
  assign opA=a_more ?  {1'b1,A[51:0],53'b0} : 106'bz;
  assign opB=(sxor & a_more) ?  ~(isFMA ? B_hi : {1'b1,B[51:0],53'b0}) : 106'bz;
  assign opA=(~a_more) ?  (isFMA ? B_hi : {1'b1,B[51:0],53'b0}) : 106'bz;
  assign opB=(sxor & ~a_more) ?  ~{1'b1,A[51:0],53'b0} : 106'bz;
  assign opB=(~sxor & a_more) ?  (isFMA ? B_hi : {1'b1,B[51:0],53'b0}) : 106'bz;
  assign opB=(~sxor & ~a_more) ?  {1'b1,A[51:0],53'b0} : 106'bz;
  
  assign opA_exp=(a_more ) ? A_exp : B_exp;
  
  assign expdiff=a_more ? expdiffA : expdiffB;
  
//  assign Bx=is_alt ? B_alt : B;

  assign opBs1=expoor ? {106{sxor_reg}} : 106'bz;
  assign opBs=expoor_reg ? {106{sxor_reg}} : 106'bz;
  assign res_rnbit=expoor_reg ? xop1_reg[1]^(res_andtail&sxor_reg) : 1'bz;
//  assign res_rnbitC=expoor_reg ?  : 1'bz;
  assign res_rnbitL=expoor_reg ? xop1_reg[0]^(res_andtailL&sxor_reg) : 1'bz;
  assign xop1[1:0]=(expoor && expdiff[11:1]!=11'h20) ? {2{sxor}} : 2'bz;
  
  assign a_more=moreAD;

  assign sxor=A[63]^B[63]^isSub;
  assign A_s=A[63]^(isRSub);
  assign B_s=B[63]^(isSub&~isRSub);
  assign A_s1=a_more ? A_s : B_s;
  assign B_s1=a_more ? B_s : A_s;
  assign A_s2=(a_more & ~(expdiffA==0 && alt_en && sxor)) ? A_s : B_s;

  assign alt_en=~cout53_SZ1;

  assign resS_rnbit=(expdiffA!=0) ? ~opB[0] : 1'b0;
  assign altpath=(expdiffA==0 || expdiffA==1 || expdiffB==1) && sxor;
  assign rndpath=(expdiffA==1 || expdiffB==1) && sxor;
 
  assign res[67:66]=en_reg ? `ptype_dbl : 2'bz;

  assign res[52:0]=(renor_simple & ~spec_any & en_reg) ? {renorS[62:43],1'b0,renorS[42:11]} : 53'bz;
  assign {res[65],res[63:53]}=(renor_simple & ~spec_any & en_reg) ? {renorE[11],renorE[10:0]} : 12'bz;
  
  assign res[52:0]=(renor_round & ~spec_any & en_reg) ? {renorSR[62:43],1'b0,renorSR[42:11]} : 53'bz;
  assign {res[65],res[63:53]}=(renor_round & en_reg & ~spec_any) ? {renorER[11],renorER[10:0]} : 12'bz;

  assign res[64]=(renor_simple & en_reg & ~spec_any) ? A_s1_reg : 1'bz;
  assign res[64]=(renor_round & en_reg & ~spec_any) ? A_s1_reg : 1'bz;
  

  //assign res[65:0]=(~renor_simple && ~renor_round &&  ~spec_any && en_reg) ? {resX[64:32],1'b0,resX[31:0]} : 66'bz;

  assign {res[65],res[64:0]}=(spec_any & en_reg) ? {res_spec[64],res_spec[63:32],1'b0,res_spec[31:0]} : 66'bz;  

  assign res_spec=spec_A_reg ? A_reg : 65'bz;
  assign res_spec=spec_B_reg ? B_reg : 65'bz;
  assign res_spec=(spec_snan_reg) ? {65'h1fff0000000000001} : 65'bz;
  assign res_spec=(spec_qnan_reg) ? {65'h1fff4000000000001} : 65'bz;
  assign res_spec=(spec_pinf_reg) ? {65'h17fe8000000000000} : 65'bz;
  assign res_spec=(spec_ninf_reg) ? {65'h1ffe8000000000000} : 65'bz;
  assign res_spec=spec_logic_reg[0] ? A_reg&B_reg : 65'bz;
  assign res_spec=spec_logic_reg[1] ? A_reg|B_reg : 65'bz;
  assign res_spec=spec_logic_reg[2] ? A_reg^B_reg : 65'bz;
  assign res_spec=spec_logic_reg[3] ? A_reg&~B_reg : 65'bz;
  assign res_spec=spec_any ?  65'bz :  65'b0;

  assign renor_round=rndpath_reg && !(opB_reg || isrnd_zero ||(isrnd_even && resSR1_reg[0])) &&
  resS1_reg[52];
  
  assign renor_simple=altpath_reg && ~renor_round;
  
  assign expoor=expdiff[11:6]!=6'b0 ;//&& expdiff!=16'h40; 

  get_carry #(12) cmp1_mod(opA_exp,~exp_max,1'b1,exp_inc_oor);
  get_carry #(12) cmp2_mod(opA_exp,~exp_max_IEEE,1'b1,exp_inc_oor_IEEE);
  get_carry #(12) cmp3_mod(opA_exp,~exp_min_IEEE,1'b1,exp_dec_non_denor_IEEE_0);
  get_carry #(12) cmp4_mod(opA_exp,~exp_min_kludge,1'b1,exp_dec_non_denor_IEEE_1);
  assign exp_dec_non_denor=opA_exp[11:1]!=0;
  assign exp_dec_non_denor_IEEE=altpath ? exp_dec_non_denor_IEEE_1 : exp_dec_non_denor_IEEE_0;

  assign exp_max=12'hffd;
  assign exp_max_IEEE=12'hbfe;
  assign exp_min_IEEE=12'h401;
  assign exp_min_kludge=12'h436;

  assign raise[`csrfpu_inv_excpt]=spec_snan_reg;
  assign raise[`csrfpu_under_excpt]=A_s1_reg & exp_inc_oor_reg & xpon[1] & ~spec_any;
  assign raise[`csrfpu_over_excpt]=~A_s1_reg & exp_inc_oor_reg & xpon[1] & ~spec_any;
  assign raise[`csrfpu_under_ieee_excpt]=A_s1_reg & exp_inc_oor_IEEE_reg & xpon[1] & ~spec_any;
  assign raise[`csrfpu_over_ieee_excpt]=~A_s1_reg & exp_inc_oor_IEEE_reg & xpon[1] & ~spec_any;
  assign raise[`csrfpu_denor_excpt]=~exp_dec_non_denor_reg & xpon[0] & ~spec_any;
  assign raise[`csrfpu_denor_ieee_excpt]=~exp_dec_non_denor_IEEE_reg & xpon[0] & ~spec_any;
  assign raise[`csrfpu_inexact_excpt]=!|xpon[3:2]; 
  assign raise[`csrfpu_inexact_ieee_excpt]=!|xpon[3:2]; 
  assign raise[`csrfpu_denor_consume_excpt]=1'b0;
  assign raise[`csrfpu_denor_produce_excpt]=1'b0;

  assign xpon=Smain_simple ? {res_rnbit,res_tail,2'b00} : 4'bz;
  assign xpon=Smain_round ? {res_rnbit,res_tail,2'b00} : 4'bz;
  assign xpon=Smain_simpleC ? {res_rnbitC,res_tailC,2'b10} : 4'bz;
  assign xpon=Smain_roundC ? {res_rnbitC,res_tailC,2'b10} : 4'bz;
  assign xpon=Smain_simpleRC ? {res_rnbit,res_tail,2'b10} : 4'bz;
  assign xpon=Smain_simpleL ? {res_rnbitL,res_tailL,2'b01} : 4'bz;
  assign xpon=Smain_roundL ? {res_rnbitL,res_tailL,2'b00} : 4'bz;
  
  assign xpon=renor_simple | renor_round ? {renor_round,3'b001} : 4'bz;
   
  assign res[51:0]=Smain_simple ? resM1[104:53] : 52'bz;
  assign res[51:0]=Smain_round ? resMR1[104:53] : 52'bz;
  assign res[51:0]=Smain_simpleC ? resM1[105:54] : 52'bz;
  assign res[51:0]=Smain_roundC ? resM2[105:54] : 52'bz;
  assign res[51:0]=Smain_simpleRC ? resMR1[105:54] : 52'bz;
  assign res[51:0]=Smain_simpleL ? {resM1[103:53],res_rnbit^Smain_subroundL} : 52'bz;
  assign res[51:0]=Smain_roundL ? {resMR1[103:53],1'b0} : 52'bz;
  
  assign {res[64],res[62:52]}=Smain_simple ? {opA_exp_reg[15],opA_exp_reg[10:0]} : 12'bz;
  assign {res[64],res[62:52]}=Smain_round ? {opA_exp_reg[15],opA_exp_reg[10:0]} : 12'bz;
  assign {res[64],res[62:52]}=Smain_simpleC ? {opA_exp_inc[15],opA_exp_inc[10:0]} : 12'bz;
  assign {res[64],res[62:52]}=Smain_roundC ? {opA_exp_inc[15],opA_exp_inc[10:0]} : 12'bz;
  assign {res[64],res[62:52]}=Smain_simpleRC ? {opA_exp_inc[15],opA_exp_inc[10:0]} : 12'bz;
  assign {res[64],res[62:52]}=Smain_simpleL ? {opA_exp_dec[15],opA_exp_dec[10:0]} : 12'bz;
  assign {res[64],res[62:52]}=Smain_roundL ? {opA_exp_dec[15],opA_exp_dec[10:0]} : 12'bz;
  
  assign Smain_lo=~resM1[105] && ~(resM1[106]);
  assign Smain_ulo=Smain_lo && resMR1[105];
  
  
  assign Smain_simple=~Smain_lo && (~res_rnbit & ~(res_tail & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tail&&resMR1[53])) && ~(resM1[106]&~sxor_reg);
  assign Smain_round=(~Smain_lo && !(~res_rnbit & ~(res_tail & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tail&&resMR1[53])) && ~(resMR1[106]&~sxor_reg)) ||
    (Smain_ulo && !(~res_rnbitL & ~(res_tailL & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tailL&&~res_rnbit)
    ) );
  assign Smain_roundC=~Smain_lo && !(~res_rnbitC & ~(res_tailC & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tailC&&resM2[54])) && (resM1[106]&~sxor_reg) &&
   (~res_rnbit & ~(res_tail & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tail&resMR1[0]));
  assign Smain_simpleC=~Smain_lo && ((~res_rnbitC & ~(res_tailC & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tailC&&resM2[54])) && (resM1[106]&~sxor_reg) &&
    (~res_rnbit & ~(res_tail & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tail&&resMR1[0]))); 
  assign Smain_simpleRC=~Smain_lo && (!(~res_rnbit & ~(res_tail & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tail&&resMR1[53])) && (resMR1[106]&~sxor_reg));
  assign Smain_simpleL=Smain_lo && ((~res_rnbitL & ~(res_tailL & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tailL&&~res_rnbit)) ||
    ~res_rnbit);/* && 
   ~(res_rnbit && (res_rnbitL^sxor_reg) && res_andtailL);*/
  assign Smain_roundL=Smain_lo && !(~res_rnbitL & ~(res_tailL & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tailL&&~res_rnbit)) && ~Smain_ulo &&
   res_rnbit;
  assign Smain_subroundL=Smain_lo && !(~res_rnbitL & ~(res_tailL & isrnd_plus) || isrnd_zero || (isrnd_even && ~res_tailL&&~res_rnbit)) && ~Smain_ulo;//|~res_rnbitL;
  
  assign res_rnbitC=resM1[53];
  assign xop1[9:2]=opBs1[7:0];
  assign res_tail=sxor_reg ? ~res_andtail : |{tailBs,tailBs1_reg};
  assign res_tailC=sxor_reg ? ~res_andtailC : |{tailBs_c,tailBs1_c_reg};
  assign res_tailL=sxor_reg ? ~res_andtailL : |{tailBs_L,tailBs1_L_reg};
  assign res_andtail=&{andtailBs,andtailBs1_reg};
  assign res_andtailC=&{andtailBs_c,andtailBs1_c_reg};
  assign res_andtailL=&{andtailBs_L,andtailBs1_L_reg};

  //up to here
  generate
      genvar k;
      for(k=0;k<8;k=k+1) begin
          if (k!=0) assign {opBs1,xop1[1:0]}=(expdiff[5:3]==k && ~expoor) ? {{k*8{sxor}},opB[63:k*8-2]} : 66'bz;
          else begin
              assign opBs1=(expdiff[5:3]==k && ~expoor) ? {{k*8{sxor}},opB[63:k*8]} : 64'bz;
              assign xop1[1:0]=(expdiff[5:3]==3'b0 && ~expoor) ? 2'b0 : 2'bz;
              assign xop1[1:0]=(expdiff==16'h40) ? opB[63:62] : 2'bz;
              assign xop1[1:0]=(expdiff==16'h41) ? {sxor,opB[63]} : 2'bz;
          end
          if (k<8) begin 
              wire e_more,e_eq,e_eq2;
              get_carry #(4) cmp8_mod(~(k[3:0]+4'b1),expdiff[6:3],1'b1,e_more);
              assign e_eq=expdiff[5:3]==(k+1) && expdiff[2:0]==3'b0;
              assign e_eq2=expdiff[5:3]==(k+1) && expdiff[2:1]==2'b0;
              assign tailBs1[k]=e_more|expoor && (|{opB[k*8+:7],opB[k*8+7]&~e_eq});
              assign tailBs1_c[k]=e_more|expoor && |opB[k*8+:8];
              assign tailBs1_L[k]=e_more|expoor && (|{opB[k*8+:6],opB[k*8+6+:2]&~{e_eq2,e_eq}});
              assign andtailBs1[k]=~e_more&~expoor || (&{opB[k*8+:7],opB[k*8+7]|e_eq});
              assign andtailBs1_c[k]=~e_more&~expoor || &opB[k*8+:8];
              assign andtailBs1_L[k]=~e_more&~expoor || (&{opB[k*8+:6],opB[k*8+6+:2]|{e_eq2,e_eq}});
             // assign rnbit_s1[k]=e_eq;
          end
          
          //wire [7:0] expdiffeq;
          //assign expdiffeq[k]=expdiff[2:0]==k[2:0];
	      assign opBs=expdiffeq[k] ? {{k{sxor_reg}},opBs1_reg[63:k]} : 64'bz;
	      assign res_rnbit=expdiffeq[k] ? xop1_reg[k+1]^(res_andtail&sxor_reg) : 1'bz;
	      assign res_rnbitL=expdiffeq[k] ? xop1_reg[k]^(res_andtailL&sxor_reg) : 1'bz;
	   //   assign res_rnbitC=expdiffeq[k] ? xop1_reg[k+1] : 1'bz;
          if (k<8) begin 
              wire e_more,e_eq,e_eq2;
              get_carry #(4) cmp8_mod(~(k[3:0]+4'b1),{1'b0,expdiff_reg[2:0]},1'b1,e_more);
              assign e_eq=expdiff_reg[2:0]==(k+1);
              assign e_eq2=expdiff_reg[2:0]==(k+2);
              assign tailBs[k]=e_more & opBs1_reg[k] & ~e_eq;
              assign tailBs_c[k]=e_more & opBs1_reg[k];
              assign tailBs_L[k]=e_more & opBs1_reg[k] & ~e_eq & ~e_eq2;
              assign andtailBs[k]=~e_more | opBs1_reg[k] | e_eq;
              assign andtailBs_c[k]=~e_more | opBs1_reg[k];
              assign andtailBs_L[k]=~e_more | opBs1_reg[k] | e_eq | e_eq2;
           //   assign rnbit_s[k]=e_eq;
          end
      end

  endgenerate

//  adder2c #(64) fracCmp(fracxfrmA(A[63:0],isDBL,isSingle,isSngDbl),fracxfrmB(~Bx,isDBL,isSingle,isSngDbl),
//      ,,1'b1,1'b1,1'b1,1'b1,moreAFE,,moreAFD,);
  fpuadd_renor renor_mod(
  .A(isDBL_reg ? {resS1_reg[52:0],~opB_reg&&expdiff_reg!=0,10'b0} : resS1_reg),
  .exp(opA_exp_reg),.Ax(~opB_reg&&expdiff_reg!=0&&~isDBL_reg),
  .A_out(renorS),.exp_out(renorE)
  );

  fpuadd_renor renorR_mod(
  .A(isDBL_reg ? {resSR1_reg[52:0],~opB_reg&&expdiff_reg!=0,10'b0} : resSR1_reg),
  .exp(opA_exp_reg),.Ax(~opB_reg&&expdiff_reg!=0&&~isDBL_reg),
  .A_out(renorSR),.exp_out(renorER)
  );

  adder_CSA #(64) mainCSA(opA_reg,opBs,{63'b0,sxor_reg&res_andtail&~res_rnbit},partM0,partM1);
  adder_CSA #(64) mainCSAs(opA_reg,opBs,{62'b0,1'b1,sxor_reg&res_andtail&~res_rnbit},partMs0,partMs1);
  
  adder2c #(64) mainAddNoShift(partM0[63:0],partM1[63:0],resM1,resMR1,1'b0,1'b1,1'b1,1'b1,
    cout64_M1_ns,cout64_MR1_ns,cout53_M1_ns,cout53_MR1_ns);
  adder2c #(64) mainAddShift(partMs0[63:0],partMs1[63:0],resM2,resMR2,1'b0,1'b1,1'b1,1'b1,
    cout64_M2_ns,cout64_MR2_ns,cout53_M2_ns,cout53_MR2_ns);
  
  adder_CSA #(64) suppCSAOneOff (opA,{1'b1,opB[63:1]},{63'b0,opB[0]}, par1Off_A,par1Off_B);
  adder_CSA #(64) suppCSAxx (~opA,~opB,64'b1, part_A,part_B);
  adder_CSA #(64) suppCSAx (opA,opB,64'b1,partt_A,partt_B);
  
  adder2c #(64) suppAddZeroOff(partt_A[63:0],partt_B[63:0],
      resS1,resSR1,1'b0,1'b1,expdiffA==0 && ~alt_en,expdiffA==0&& ~alt_en,cout64_SZ1,cout64_SZR1,cout53_SZ1,cout53_SZR1);
  adder2c #(64) suppAddZeroOffz(part_A[63:0],part_B[63:0],
      resS1,resSR1,1'b0,1'b1,expdiffA==0 && alt_en,expdiffA==0 && alt_en,cout64_Sz1,cout64_SzR1,cout53_Sz1,cout53_SzR1);
  adder2c #(64) suppAddOneOff (par1Off_A[63:0],par1Off_B[63:0],resS1,resSR1,
      1'b0,1'b1,expdiffA!=0,expdiffA!=0,cout64_S1,cout64_SR1,cout53_S1,cout53_SR1);

  adder #(16) expAE_mod({A[80],A[78:64]},~{B[80],B[78:64]},expdiffA,1'b1,~isDBL,moreAE,,,);
  adder #(16) expBE_mod(~{A[80],A[78:64]},{B[80],B[78:64]},expdiffB,1'b1,~isDBL,,,,);
  
  adder #(16) expAD_mod({4'b0,A[80],A[62:52]},~{4'b0,B[80],B[62:52]},expdiffA,1'b1,isDBL,moreAD,,,);
  adder #(16) expBD_mod(~{4'b0,A[80],A[62:52]},{4'b0,B[80],B[62:52]},expdiffB,1'b1,isDBL,,,,);
  
  adder_inc #(16) aExpInc(opA_exp_reg,opA_exp_inc,1'b1,);
  adder #(16) aExpDec(opA_exp_reg,16'hffff,opA_exp_dec,1'b0,1'b1,,,,);
  //verilator lint_off COMBDLY 
  always @(*) begin
      if (rst) begin
          expdiffeq<=8'b1;
          opA_exp_reg<=16'b0;
          sxor_reg<=1'b0;
          expdiff_reg<=16'b0;
          expoor_reg<=1'b0;
          opBs1_reg<=64'b0;
          opA_reg<=64'b0;
          resS1_reg<=64'b0;
          resSR1_reg<=64'b0;
          xop1_reg<=10'b0;
          andtailBs1_reg<=1'b0;
          andtailBs1_c_reg<=1'b0;
          andtailBs1_L_reg<=1'b0;
          tailBs1_reg<=1'b0;
          tailBs1_c_reg<=1'b0;
          tailBs1_L_reg<=1'b0;
          isrnd_zero<=1'b1;
          isrnd_even<=1'b0;
	  isrnd_plus<=1'b0;
          isDBL_reg<=1'b1;
          altpath_reg<=1'b0;
          rndpath_reg<=rndpath;
          A_s1_reg<=1'b0;
          opB_reg<=1'b0;
          spec_snan_reg<=1'b0;
	  spec_qnan_reg<=1'b0;
	  spec_pinf_reg<=1'b0;
	  spec_ninf_reg<=1'b0;
	  spec_A_reg<=1'b0;
	  spec_B_reg<=1'b0;
	  spec_any<=1'b0;
	  A_reg<=81'b0;
	  B_reg<=81'b0;
	  en_reg<=1'b1;
          exp_inc_oor_reg<=1'b0;
	  exp_inc_oor_IEEE_reg<=1'b0;
	  exp_dec_non_denor_reg<=1'b0;
	  exp_dec_non_denor_IEEE_reg<=1'b0;
      end else begin
	  for (m=0;m<8;m=m+1) expdiffeq[m]<=expdiff[2:0]==m[2:0] && ~expoor;
          sxor_reg<=sxor;
          expdiff_reg<=expdiff;
          opA_exp_reg<=opA_exp;
          expoor_reg<=expoor;
          opBs1_reg<=opBs1;
          opA_reg<=opA;
          resS1_reg<=resS1;
          resSR1_reg<=resSR1;
          xop1_reg<=xop1;
          andtailBs1_reg<=&andtailBs1;
          andtailBs1_c_reg<=&andtailBs1_c;
          andtailBs1_L_reg<=&andtailBs1_L;
          tailBs1_reg<=|tailBs1;
          tailBs1_c_reg<=|tailBs1_c;
          tailBs1_L_reg<=|tailBs1_L;
          case(rmode)
            ROUND_TRUNC: begin isrnd_even<=1'b0; isrnd_zero<=1'b1; isrnd_plus<=1'b0; end
            ROUND_ROUND: begin isrnd_even<=1'b0; isrnd_zero<=1'b0; isrnd_plus<=1'b0; end
            ROUND_EVEN : begin isrnd_even<=1'b1; isrnd_zero<=1'b0; isrnd_plus<=1'b0; end
            ROUND_PLUS : begin isrnd_even<=1'b0; isrnd_zero<=A_s2; isrnd_plus<=1'b0; end
            ROUND_MINUS: begin isrnd_even<=1'b0; isrnd_zero<=~A_s2; isrnd_plus<=1'b0; end
            ROUND_UP   : begin isrnd_even<=1'b0; isrnd_zero<=A_s2; isrnd_plus<=~A_s2; end
            ROUND_DOWN : begin isrnd_even<=1'b0; isrnd_zero<=~A_s2; isrnd_plus<=A_s2; end
          endcase
          isDBL_reg<=isDBL;
          altpath_reg<=altpath;
          rndpath_reg<=rndpath;
          A_s1_reg<=(expdiffA==0 && sxor && alt_en) ? B_s1 : A_s1;
          opB_reg<=opB[0];
          spec_snan_reg<=spec_snan;
	  spec_qnan_reg<=spec_qnan;
	  spec_pinf_reg<=spec_pinf;
	  spec_ninf_reg<=spec_ninf;
	  spec_A_reg<=spec_A;
	  spec_B_reg<=spec_B;
          spec_any<=|{spec_snan,spec_qnan,spec_pinf,spec_ninf,spec_A,spec_B,spec_logic};
	  spec_logic_reg<=spec_logic;
          A_reg<=copyA ? {A_alt[64],16'b0,A_alt[63:0]} : A;
          B_reg<=B;
	  en_reg<=en;
          exp_inc_oor_reg<=exp_inc_oor;
	  exp_inc_oor_IEEE_reg<=exp_inc_oor_IEEE;
	  exp_dec_non_denor_reg<=exp_dec_non_denor;
	  exp_dec_non_denor_IEEE_reg<=exp_dec_non_denor_IEEE;
      end
  end
  //verilator lint_on COMBDLY
endmodule


module fpuadd_renor(
  A,exp,Ax,
  A_out,exp_out
  );

  input [63:0] A;
  input [15:0] exp;
  input Ax;
  output [63:0] A_out;
  output [15:0] exp_out;

  wire [63:0] A_first;
  wire [7:0] A_first8;
  wire A_has,A_has8;
  wire [63:0] A_medE;
  wire [63:0] A_outE;
  wire [2:0] xadde1_c;
  wire [2:0] xadde1_nc;
  wire xaddeCO_c;
  wire xaddeCO_nc;
  wire [7:0][12:0] adde8_c;
  wire [7:0][12:0] adde8_nc;
  wire [7:0][2:0] adde1_c;
  wire [7:0][2:0] adde1_nc;
  wire [7:0] addeCO_nc;
  wire [7:0] addeCO_c;
  wire [15:0] exp_outE;
  wire [7:0] A_firstE;

  bit_find_last_bit #(64) first_mod(A,A_first,A_has);
  bit_find_last_bit #(8) first8_mod({|A[63:56],|A[55:48],|A[47:40],|A[39:32],
      |A[31:24],|A[23:16],|A[15:8],|A[7:0]},A_first8,A_has8);

  generate
      genvar t,p;
      for (t=0;t<8;t=t+1) begin
	  if ((7-t)>0) assign A_medE=A_first8[t] ? {A[63-8*(7-t):0],Ax,{8*(7-t)-1{1'b0}}} : 64'bz;
	  else assign A_medE=A_first8[t] ? A : 64'bz;
	  assign A_firstE=A_first8 [t] ? A_first[8*t+:8] : 8'bz;
	  
      if ((7-t)>1) assign A_outE=A_firstE[t] ? {A_medE[63-(7-t):0],Ax,{(7-t)-1{1'b0}}} : 64'bz;
      else if ((7-t)==1) assign A_outE=A_firstE[t] ? {A_medE[63-(7-t):0],Ax} : 64'bz;
	  else assign A_outE=A_firstE[t] ? A_medE : 64'bz;

          adder2c #(13) upperAdd_mod(exp[15:3],~t[12:0],adde8_nc[t],adde8_c[t],1'b0,1'b1,1'b1,1'b1,,,,);
          adder2c #(3)  lowerAdd_mod(exp[2:0],~t[2:0],adde1_nc[t],adde1_c[t],1'b0,1'b1,1'b1,1'b1,
            addeCO_nc[t],addeCO_c[t],,);
          
          assign xadde1_nc=A_firstE[t] ? adde1_nc[7-t] : 3'bz;
          assign xadde1_c=A_firstE[t] ? adde1_c[7-t] : 3'bz;
          assign xaddeCO_nc=A_firstE[t] ? addeCO_nc[7-t] : 1'bz;
          assign xaddeCO_c=A_firstE[t] ? addeCO_c[7-t] : 1'bz;
        
          assign exp_outE=(A_first8[7-t] & xaddeCO_c) ?  {adde8_c[t],xadde1_c} : 16'bz;
          assign exp_outE=(A_first8[7-t] & ~xaddeCO_c) ?  {adde8_nc[t],xadde1_c} : 16'bz;
      end
          assign xadde1_nc=A_has ?  3'bz : 3'b0;
          assign xadde1_c=A_has ? 3'bz : 3'b0;
          assign xaddeCO_nc=A_has ? 1'bz : 1'b0;
          assign xaddeCO_c=A_has ? 1'bz : 1'b0;
  endgenerate

/*  assign xadde1_nc[t]=A_has ?  3'bz : 3'b0;
  assign xadde1_c[t]=A_has ? 3'bz : 3'b0;
  assign xaddeCO_nc[t]=A_has ? 1'bz : 1'b0;
  assign xaddeCO_c[t]=A_has ? 1'bz : 1'b0;*/
  assign exp_outE=A_has ?  16'bz : 16'b0;
  assign A_outE=A_has ? 64'bz : {Ax,63'b0};
  assign A_medE=A_has ? 64'bz : 64'b0;
  assign A_firstE=A_has ? 8'bz : 8'b0;
  assign A_out=A_outE;
  assign exp_out=(A_has | Ax) ? exp_outE : 16'b0;
endmodule


