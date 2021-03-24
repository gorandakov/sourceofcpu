`include "../struct.sv"

module imul(
  clk,
  rst,
  clkEn,
  op_prev,
  en,
  R,C,
  alt,
  Res,
  flg
 );

  input clk;
  input rst;
  input clkEn;
  input [12:0] op_prev;
  input en;
  input [64:0] R;
  input [64:0] C;
  output [64:0] Res;
  output reg alt;
  output [5:0] flg;

  reg and1,is_sig,sig,sm_sig,upper,short;
  reg sig_reg,sig_reg2;
  reg sm_sig_reg,sm_sig_reg2;
  reg upper_reg,upper_reg2,short_reg,short_reg2;
  reg upper_reg3,short_reg3;
  reg upper_reg4,short_reg4;
  reg en_reg,en_reg2,en_reg3,clkEn_reg;
  reg and1_reg,and1_reg2,and1_reg3,and1_reg4;
  reg is_sec_reg,is_sec_reg2;
  reg is_sec_reg3;
  reg [63:0] sec_res_reg;
  reg [63:0] sec_res_reg2;

  wire [63:0] sec_res;
  wire [127:0] A_out;
  wire [127:0] B_out;
  reg [127:0] A_out_reg;
  reg [127:0] B_out_reg;
  wire [63:0] dummy;
  wire [63:0] dummy2;
  reg [63:0] Res_reg;
  reg [63:0] dummy2_reg;
  reg [63:0] dummy_reg;
  //reg [7:0] dummy8_reg;
  wire resz;
  wire resp;
  wire [31:0] resx;
  reg [31:0] resx_reg;
  wire [63:0] sec_res;
  //wire [63:0] resB;
  //reg bnd,bnd_reg,bnd_reg2,bnd_reg3;

  //assign alt=~(clkEn && en_reg2);
  assign resz=~|Res_reg;
  assign resp=~^Res_reg[7:0];

  assign flg=and1_reg4 && ~upper_reg4 ? {|dummy2_reg,~(&dummy2_reg&Res_reg[63]
    || ~|dummy2_reg&~Res_reg[63]),1'b0,Res_reg[63],resz,resp} : 6'bz; 
  assign flg=and1_reg4 && upper_reg4 ? {|Res_reg,~(&Res_reg&dummy_reg[63]
    || ~|Res_reg&~dummy_reg[63]),1'b0,Res_reg[63],resz&~|dummy_reg,~^dummy_reg[7:0]} : 6'bz; 
  assign flg=~and1_reg4 && ~short_reg4 ? {|Res_reg[63:32],~(&Res_reg[63:31]||
   ~|Res_reg[63:31]),1'b0,Res_reg[63],resz,resp} : 6'bz;
  assign flg=~and1_reg4 && short_reg4 ? {|resx_reg,~(&resx_reg&Res_reg[31] ||
    ~|resx_reg&~Res_reg[31]),1'b0,Res_reg[31],resz,resp} : 6'bz;

 // assign Res[64]=~bnd_reg3 ? 1'b0 : 1'bz;
 // assign Res=bnd_reg3 ? resB : 65'bz;

  icompr cmp_mod(clk,clkEn,R[63:0],C[63:0],A_out,B_out,and1,is_sig,sig,sm_sig);
  adder2oM #(128) add_mod(A_out_reg,B_out_reg,{dummy2,Res[63:0]},{Res[63:0],dummy},
    resx,1'b0,~upper_reg3&~is_sec_reg3,upper_reg3,short_reg3,,,,);

  assign Res[64:0]=is_sec_reg3 ? {ptr_reg2,sec_res_reg2} : {1'b0,64'bz};

  agusec_mul msec(R[63:0],C[11:0],sec_res);
  
  always @(posedge clk) begin
    clkEn_reg<=clkEn;
    if (clkEn) begin
      and1<=1'b1;
      is_sig<=1'b1;
      sig<=1'b1;
      sm_sig<=1'b1;
      upper<=1'b0;
      short<=1'b0;
      is_sec<=1'b0;
 //     bnd<=1'b0;
      case({4'b1000,op_prev[7:0]})
      `op_lmul64: begin
          is_sig<=1'b0;
	  sig<=1'b0;
	  sm_sig<=1'b0;
	  upper<=1'b1;
      end
      `op_mul64: begin
          is_sig<=1'b0;
	  sig<=1'b0;
	  sm_sig<=1'b0;
	  //upper<=1'b1;
      end
      `op_mul32_64: begin
          and1<=1'b0;
	  is_sig<=1'b0;
	  sig<=1'b0;
	  sm_sig<=1'b0;
      end
      `op_imul32_64: begin
          and1<=1'b0;
	  //is_sig<=1'b0;
	  sig<=1'b0;
	  //sm_sig<=1'b0;
      end
      `op_mul32: begin
          and1<=1'b0;
	  is_sig<=1'b0;
	  sig<=1'b0;
	  sm_sig<=1'b0;
	  short<=1'b1;
      end
      `op_imul32: begin
          and1<=1'b0;
	  sig<=1'b0;
	  short<=1'b1;
      end
      `op_imul64: begin
	  sm_sig<=1'b0;
      end
      `op_limul64: begin
	  sm_sig<=1'b0;
	  upper<=1'b1;
      end
      `op_sec64: begin
	  is_sec<=1'b1;
      end
  //    `op_ptrbnd: begin
  //        bnd<=1'b1;
  //    end
      endcase
      A_out_reg<=A_out ^ {sig_reg2,63'b0,sm_sig_reg2,63'b0};
      B_out_reg<=B_out;
      en_reg<=en;
      en_reg2<=en_reg;
      en_reg3<=en_reg2;
      alt<=en_reg;
      is_sec_reg<=is_sec;
      is_sec_reg2<=is_sec_reg;
      is_sec_reg3<=is_sec_reg2;
      upper_reg<=upper;
      upper_reg2<=upper_reg;
      upper_reg3<=upper_reg2;
      short_reg<=short;
      short_reg2<=short_reg;
      short_reg3<=short_reg2;
      sig_reg<=sig;
      sig_reg2<=sig_reg;
      sm_sig_reg<=sm_sig;
      sm_sig_reg2<=sm_sig_reg;
      and1_reg<=and1;
      and1_reg2<=and1_reg;
      and1_reg3<=and1_reg2;
      sec_res_reg<=sec_res;
      sec_res_reg2<=sec_res_reg;
      ptr_reg<=R[64];
      ptr_reg2<=ptr_reg;
    //  bnd_reg<=bnd;
    //  bnd_reg2<=bnd_reg;
    //  bnd_reg3<=bnd_reg2;
    end
    Res_reg<=Res;
    dummy2_reg<=dummy2;
    dummy_reg<=dummy;
    //dummy8_reg<=dummy[7:0];
    resx_reg<=resx;
    upper_reg4<=upper_reg3;
    short_reg4<=short_reg3;
    and1_reg4<=and1_reg3;
  end
endmodule

