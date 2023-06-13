module fma(
  clk,
  rst,
  fpcsr,
  en,
  en_is_add,
  en_is_mul,
  A,B,C,
  res,
  raise);
  localparam [15:0] BIAS=16'h7fff;
  localparam ROUND_TRUNC=0;
  localparam ROUND_ROUND=1;
  localparam ROUND_EVEN =2;
  localparam ROUND_PLUS =3;
  localparam ROUND_MINUS=4;
  localparam ROUND_UP   =5;
  localparam ROUND_DOWN =6;

  wire A_h; 
  wire B_h; 

  wire A_zero,A_infty,A_nan;
  
  wire B_zero,B_infty,B_nan;

  wire spec_zero,spec_infty,spec_nan,spec_snan,spec_qnan,spec_A;
  reg spec_zero_reg,spec_infty_reg,spec_snan_reg,spec_qnan_reg,spec_A_reg;
  reg spec_zero_reg2,spec_infty_reg2,spec_snan_reg2,spec_qnan_reg2,spec_A_reg2;
  reg spec_any;
  wire [64:0] res_spec;

  adder_CSA #(12) extAdd_mod(expA,expB,-BIAS,expart0,expart1);
  adder2c #(13) expAdd2_mod(expart0,expart1,exp_exp,exp_exp1,1'b0,1'b1,1'b1,1'b1,,,,);

  get_carry #(13) cmp0_mod(exp_max,~(exp_exp^13'h1000),1'b1,exp_oor);
  get_carry #(13) cmp1_mod(exp_max,~(exp_exp1^13'h1000),1'b1,exp1_oor);
  get_carry #(13) cmp2_mod(exp_max_IEEE,~(exp_exp^13'h1000),1'b1,exp_oor_IEEE);
  get_carry #(13) cmp3_mod(exp_max_IEEE,~(exp_exp1^13'h1000),1'b1,exp1_oor_IEEE);
  get_carry #(13) cmp4_mod(~exp_denor_IEEE,(exp_exp^13'h1000),1'b1,exp_non_denor_IEEE);
  get_carry #(13) cmp5_mod(~exp_denor_IEEE,(exp_exp1^13'h1000),1'b1,exp_non_denor_IEEE);

  assign exp_exp_d=exp_oor & ~fpcsr[`csrfpu_clip_IEEE] ? exp_max : 13'b0;
  assign exp_exp_d=exp_oor_IEEE & fpcsr[`csrfpu_clip_IEEE] ? exp_max_IEEE : 13'bz;
  assign exp_exp_d=~exp_non_denor_IEEE & fpcsr[`csrfpu_daz] || (exp_exp^17'h10000)!=0 ? 13'b0 : 13'bz;
  assign exp_exp_d=~(exp_oor & ~fpcsr[`csrfpu_clip_IEEE]) & 
    ~(exp_oor_IEEE & fpcsr[`csrfpu_clip_IEEE]) & 
    ~(~exp_non_denor_IEEE & fpcsr[`csrfpu_daz] || (exp_exp^13'h1000)!=0) ? (exp_exp^13'h1000) : 13'bz;
  
  assign exp_exp1_d=exp1_oor & ~fpcsr[`csrfpu_clip_IEEE] ? exp_max : 13'b0;
  assign exp_exp1_d=exp1_oor_IEEE & fpcsr[`csrfpu_clip_IEEE] ? exp_max_IEEE : 13'bz;
  assign exp_exp1_d=~exp1_non_denor_IEEE & fpcsr[`csrfpu_daz] || (exp_exp1^17'h1000)!=0 ? 13'b0 : 13'bz;
  assign exp_exp1_d=~(exp1_oor & ~fpcsr[`csrfpu_clip_IEEE]) & 
    ~(exp1_oor_IEEE & fpcsr[`csrfpu_clip_IEEE]) & 
    ~(~exp1_non_denor_IEEE & fpcsr[`csrfpu_daz] || (exp_exp1^13'h1000)!=0) ? (exp_exp1^13'h1000) : 13'bz;

  compress cmpr_mod(clk,rst,{1'b1,A[51:0]},{1'b1,B[51:0]},prod_part0, prod_part1);

  assign expon=(prod_reg2[105] & ~spec_any) ?
    {~DBL_rnbit1 & ~ DBL_tail1,exp_exp1_reg[12],exp1_non_denor_IEEE_reg,exp1_oor_IEEE_reg,exp1_oor_reg} : 5'bz;
  assign expon=(~prod_reg[105] & ~spec_any) ? 
    {~DBL_rnbit0 & ~ DBL_tail0,exp_exp_reg[12],exp_non_denor_IEEE_reg,exp_oor_IEEE_reg,exp_oor_reg} : 5'bz;
  assign expon=spec_any ? 5'd4 : 5'bz; 

  adder #(64) prodAddA(prod_part0[106:43],prod_part1[106:43], prod[106:43],c44,1'b1,cout_prod,,,);
  adder #(43) prodAddB(prod_part0[42:0],prod_part2[42:0],prod[42:0],1'b0,1'b1,c44,,,);

  shifter107 ashf(prod,expdiff_C_AB,prod_shA);
  shifter107 cshf({1'b1,C_reg[51:0],{54{sxor_reg}}},expdiff_AB_C,prod_shB);

  adder2c #(64) prodAddSHA({64{sxor_reg2}}^prod_shA[106:43],{1'b1,C_reg2[51:0],{12{sxor_reg2}}}, pre_res[106:43],pre_resR[106:43],
  1'b0,1'b1,,1'b1,cout_prodA,cout_prodAC,,,);
  assign pre_res[42:0]={43{sxor_reg2}};
  adder2c #(64) prodAddSHB({64{sxor_reg2}}^prod_shB[106:43],prod_reg2[106:43], pre_resB[106:43],pre_resBR[106:43],
  c44B,c44BC,pre_resB[106:43],pre_resBC[106:43],cout_prodB,cout_prodBC,,,);
  adder2c #(43) prodAddSHB({43{sxor_reg2}}^prod_shB[42:0],prod_reg2[42:0],pre_resB[42:0],pre_resBC[42:0],1'b0,1'b1,1'b1,c44B,c44BC,,,);
  
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

  assign AxB_zero=A_zero|B_zero;
  assign AxB_infty=A_infty & ~B_zero & ~B_nan || B_infty & ~A_zero & ~A_nany;
  assign AxB_NaN=A_nan & ~B_zero || B_nan & ~A_zero;

  assign C_zero=(expC)==16'b0;
  assign C_infty=(expC)==16'hffe;
  assign C_nan=(expC)==16'hfff;
 
  assign specxy_snan=AxB_nan_reg2 & ~C_infty_reg2 & invExcpt & ~copyA_reg2 || C_nan_reg2 & ~AxB_infty_reg2 & invExcpt & ~copyA_reg2
     || AxB_infty_reg2 & C_infty_reg2 & sxor_reg & invExcpt;
  assign specxy_qnan=AxB_nan_reg2 & ~C_infty_reg2 & ~invExcpt & ~copyA_reg2 || C_nan_reg2 & ~AxB_infty_reg2 & ~invExcpt & ~copyA_reg2
     || AxB_infty & C_infty_reg2 & sxor & ~invExcpt;
  assign specxy_pinf=(AxB_infty_reg2 && ~AxB_s && ~C_infty|~B_s && ~copyA_reg2) || (C_infty_reg2 && ~B_s && 
     ~AxB_infty_reg2|~A_s && ~copyA_reg2);
  assign specxy_ninf=(AxB_infty_reg2 && A_s && ~C_infty_reg2|B_s && ~copyA_reg2) || (C_infty_reg2 && B_s && 
     ~AxB_infty_reg2|A_s && ~copyA_reg2);
  assign specxy_A=(C_zero_reg2 && ~AxB_zero_reg2|~A_s|B_s && ~AxB_nan_reg2 && ~AxB_infty_reg2)||copyA_reg2;
  assign specxy_B=(AxB_zero_reg2 && ~C_zero_reg2|(~B_s&A_s) && ~C_nan_reg2 && ~C_infty_reg2)&&~copyA_reg2;
 
  assign spec_zero=A_zero_reg2&~B_infty_reg2&~copyA_reg2||B_zero_reg2&~A_infty_reg2&~copyA_reg2;
  assign spec_infty=A_infty_reg2&~B_zero_reg2&~copyA_reg2||B_infty_reg2&~A_zero_reg2&~copyA_reg2;
  assign spec_nan=(A_infty_reg2 & B_zero_reg2|| B_infty_reg2 & A_zero_reg2 || 
      A_nan_reg2&~B_infty_reg2&~B_zero_reg2 || B_nan_reg2&~A_infty_reg2&~A_zero_reg2) &~copyA_reg2;
  assign spec_A=copyA_reg2;
  assign spec_snan=fpcsr_reg2[`csrfpu_inv_excpt]&spec_nan;
  assign spec_qnan=~fpcsr_reg2[`csrfpu_inv_excpt]&spec_nan;

  assign sgn=isDBL ? A[63]^B[63] : A[79]^B[79];
  
  assign res_spec=spec_A ? A_reg2 : 65'bz;
  assign res_spec=(spec_snan) ? {13'h1fff,52'h0000000000001} : 65'bz;
  assign res_spec=(spec_qnan) ? {13'h1fff,52'h8000000000001} : 65'bz;
  assign res_spec=(spec_infty) ? {13'h1ffe,sgn_reg2,52'h0000000000000} : 65'bz;
  assign res_spec=spec_any ?  65'bz :  65'b0;

  assign res_specxy=specxy_A ? A_reg2 : 65'bz;
  assign res_specxy=specxy_B ? C_reg2 : 65'bz;
  assign res_specxy=(specxy_snan) ? {13'h1fff,52'h0000000000001} : 65'bz;
  assign res_specxy=(specxy_qnan) ? {13'h1fff,52'h8000000000001} : 65'bz;
  assign res_specxy=(specxy_infty) ? {13'h1ffe,sgn_reg2,52'h0000000000000} : 65'bz;
  assign res_specxy=specxy_any ?  65'bz :  65'b0;

  assign lower[`csrfpu_inv_excpt]=spec_snan;
  assign lower[`csrfpu_under_excpt]=sgn_reg2 && expon[0];
  assign lower[`csrfpu_under_ieee_excpt]=sgn_reg2 && expon[1];
  assign lower[`csrfpu_over_excpt]=~sgn_reg2 && expon[0];
  assign lower[`csrfpu_over_ieee_excpt]=~sgn_reg2 && expon[1];
  assign lower[`csrfpu_denor_ieee_excpt]=~expon[2] | expon[3];
  assign lower[`csrfpu_denor_excpt]=expon[3];
  assign lower[`csrfpu_inexact_excpt]=expon[4] | expon[3];
  assign lower[`csrfpu_inexact_ieee_excpt]=expon[4] | expon[3] | ~expon[2];
  assign lower[`csrfpu_denor_consume_excpt]=1'b0;//only for logic op
  assign lower[`csrfpu_denor_produce_excpt]=1'b0;// ==//==
  
  assign raise[`csrfpu_inv_excpt]=specxy_snan_reg;
  assign raise[`csrfpu_under_excpt]=A_s1_reg & exp_inc_oor_reg & xpon[1] & ~specxy_any;
  assign raise[`csrfpu_over_excpt]=~A_s1_reg & exp_inc_oor_reg & xpon[1] & ~specxy_any;
  assign raise[`csrfpu_under_ieee_excpt]=A_s1_reg & exp_inc_oor_IEEE_reg & xpon[1] & ~specxy_any;
  assign raise[`csrfpu_over_ieee_excpt]=~A_s1_reg & exp_inc_oor_IEEE_reg & xpon[1] & ~specxy_any;
  assign raise[`csrfpu_denor_excpt]=~exp_dec_non_denor_reg & xpon[0] & ~specxy_any;
  assign raise[`csrfpu_denor_ieee_excpt]=~exp_dec_non_denor_IEEE_reg & xpon[0] & ~specxy_any;
  assign raise[`csrfpu_inexact_excpt]=!|xpon[3:2]; 
  assign raise[`csrfpu_inexact_ieee_excpt]=!|xpon[3:2]; 
  assign raise[`csrfpu_denor_consume_excpt]=1'b0;
  assign raise[`csrfpu_denor_produce_excpt]=1'b0;

  //assign choose_A and choose_B

  double_normalise nrml_mod(pre_resX,expX,pre_res_out,exp_out);

  assign res=en_reg2 ? {sign_out,exp_out,pre_res_out} : 64'bz;
 
  always @(negedge clk) begin
      prod_part1_reg<=prod_part1;
      prod_part2_reg<=prod_part2;
  end

endmodule
