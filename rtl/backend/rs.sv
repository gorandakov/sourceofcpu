
`include "../struct.sv"

 

module rs_wakeUp_logic(
  clk,rst,stall,
  isData,
  outEq,
  buffree,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  FUreg0,FU0wen,
  FUreg1,FU1wen,
  FUreg2,FU2wen,
  FUreg3,FU3wen,
  FUreg4,FU4wen,
  FUreg5,FU5wen,
  FUreg6,FU6wen,
  FUreg7,FU7wen,
  FUreg8,FU8wen,
  FUreg9,FU9wen,
  FUreg4_reg,FU4wen_reg,
  FUreg5_reg,FU5wen_reg,
  FUreg6_reg,FU6wen_reg,
  FUreg7_reg4,FU7wen_reg4,
  FUreg8_reg4,FU8wen_reg4,
  FUreg9_reg4,FU9wen_reg4,
  newRsSelect0,newReg0,newFunit0,newGazump0,newIsFP0,newIsV0,newEQ0,
  newRsSelect1,newReg1,newFunit1,newGazump1,newIsFP1,newIsV1,newEQ1,
  newRsSelect2,newReg2,newFunit2,newGazump2,newIsFP2,newIsV2,newEQ2,
  fuFwd,
  outRsSelect0,outDataEn0,outFuFwd0,outFuuFwd0,
  outRsSelect1,outDataEn1,outFuFwd1,outFuuFwd1,
  outRsSelect2,outDataEn2,outFuFwd2,outFuuFwd2
  );
  parameter DATA_WIDTH=`alu_width;
  localparam REG_WIDTH=`reg_addr_width;
  localparam FN_WIDTH=10;

  input clk;
  input rst;
  input stall;
  output wire isData;
  output [5:0] outEq;
  input buffree;
  input FU0Hit;
  input FU1Hit;
  input FU2Hit;
  input FU3Hit;
//functional units inputs/outputs
  input [REG_WIDTH-1:0] FUreg0;
  input FU0wen;
  
  input [REG_WIDTH-1:0] FUreg1;
  input FU1wen;

  input [REG_WIDTH-1:0] FUreg2;
  input FU2wen;

  input [REG_WIDTH-1:0] FUreg3;
  input FU3wen;

  input [REG_WIDTH-1:0] FUreg4;
  input FU4wen;

  input [REG_WIDTH-1:0] FUreg5;
  input FU5wen;

  input [REG_WIDTH-1:0] FUreg6;
  input FU6wen;

  input [REG_WIDTH-1:0] FUreg7;
  input FU7wen;

  input [REG_WIDTH-1:0] FUreg8;
  input FU8wen;

  input [REG_WIDTH-1:0] FUreg9;
  input FU9wen;

  input [REG_WIDTH-1:0] FUreg4_reg;
  input FU4wen_reg;

  input [REG_WIDTH-1:0] FUreg5_reg;
  input FU5wen_reg;

  input [REG_WIDTH-1:0] FUreg6_reg;
  input FU6wen_reg;

  input [REG_WIDTH-1:0] FUreg7_reg4;
  input FU7wen_reg4;

  input [REG_WIDTH-1:0] FUreg8_reg4;
  input FU8wen_reg4;

  input [REG_WIDTH-1:0] FUreg9_reg4;
  input FU9wen_reg4;

  input newRsSelect0;
  input [REG_WIDTH-1:0] newReg0;
  input [FN_WIDTH-1:0] newFunit0;
  input [10:0] newGazump0;
  input newIsFP0,newIsV0;
  input [1:0] newEQ0;

  input newRsSelect1;
  input [REG_WIDTH-1:0] newReg1;
  input [FN_WIDTH-1:0] newFunit1;
  input [10:0] newGazump1;
  input newIsFP1,newIsV1;
  input [1:0] newEQ1;

  input newRsSelect2;
  input [REG_WIDTH-1:0] newReg2;
  input [FN_WIDTH-1:0] newFunit2;
  input [10:0] newGazump2;
  input newIsFP2,newIsV2;
  input [1:0] newEQ2;
  
  output reg [3:0] fuFwd;
  
  input outRsSelect0;
  input outDataEn0;
  output [3:0] outFuFwd0;
  output [3:0] outFuuFwd0;
  input outRsSelect1;
  input outDataEn1;
  output [3:0] outFuFwd1;
  output [3:0] outFuuFwd1;
  input outRsSelect2;
  input outDataEn2;
  output [3:0] outFuFwd2;
  output [3:0] outFuuFwd2;
  
  wire [3:0] fuFwd_d;
// equals wires
  wire [1:0] eq;

  wire [1:0] eq_new;

  reg [1:0] eq_reg;
//  reg [1:0] eq_reg2;
//  reg [1:0] eq_reg3;
//  reg [1:0] eq_reg4;
//  reg [1:0] eq_reg5;
  
  reg [1:0] eq_mask;

  reg [9:0] outEq0;

  wire [REG_WIDTH-1:0] register_d;
  reg [REG_WIDTH-1:0] register;

  wire [FN_WIDTH-1:0] funit_d;
  reg [FN_WIDTH-1:0] funit;
  wire [18:0] funit0;

  reg [3:0] fuuFwd;
  
  wire [10:0] gazump;
  wire [3:0] gzFwd;

  wire [8:0] Treg0;
  wire Twen0;
  wire [8:0] Treg1;
  wire Twen1;

  wire [8:0] FUreg[18:0];
  wire [18:0] FUwen;

  reg isFP;
  wire isFP_d;
  reg isV;
  wire isV_d;
  
//  wire isDataF,isDataI,isDataV;
  wire sel;

  assign sel=outRsSelect0&outDataEn0||outRsSelect1&outDataEn1||outRsSelect2&outDataEn2||buffree&~newRsSelect0&~newRsSelect1&~newRsSelect2;

  assign FUreg[0]=FUreg0;
  assign FUreg[1]=FUreg1;
  assign FUreg[2]=FUreg2;
  assign FUreg[3]=FUreg3;
  assign FUreg[4]=FUreg4;
  assign FUreg[5]=FUreg5;
  assign FUreg[6]=FUreg6;
  assign FUreg[7]=FUreg7;
  assign FUreg[8]=FUreg8;
  assign FUreg[9]=FUreg9;
  assign FUreg[10]=FUreg4_reg;
  assign FUreg[11]=FUreg5_reg;
  assign FUreg[12]=FUreg6_reg;
  assign FUreg[13]=FUreg7_reg4;
  assign FUreg[14]=FUreg8_reg4;
  assign FUreg[15]=FUreg9_reg4;

  assign FUwen[0]=FU0wen;
  assign FUwen[1]=FU1wen;
  assign FUwen[2]=FU2wen;
  assign FUwen[3]=FU3wen;
  assign FUwen[4]=FU4wen;
  assign FUwen[5]=FU5wen;
  assign FUwen[6]=FU6wen;
  assign FUwen[7]=FU7wen;
  assign FUwen[8]=FU8wen;
  assign FUwen[9]=FU9wen;
  assign FUwen[10]=FU4wen_reg;
  assign FUwen[11]=FU5wen_reg;
  assign FUwen[12]=FU6wen_reg;
  assign FUwen[13]=FU7wen_reg4;
  assign FUwen[14]=FU8wen_reg4;
  assign FUwen[15]=FU9wen_reg4;

//  assign funM=|funit_d[2:0];
//  assign funAdd=|funit_d[6:4];
//  assign funMul=|funit_d[9:7];

  assign funit0[3:0]=funit_d[3:0];
  assign funit0[6:4]=funit_d[6:4] & {3{~isFP_d & ~isV_d}};
  assign funit0[9:7]=funit_d[9:7] & {3{~isFP_d & ~isV_d}};
  assign funit0[15:10]=funit_d[9:4] & {6{isFP_d | isV_d}};
  
  assign gazump=(newRsSelect0 & ~stall) ? newGazump0 : 11'bz;
  assign gazump=(newRsSelect1 & ~stall) ? newGazump1 : 11'bz;
  assign gazump=(newRsSelect2 & ~stall) ? newGazump2 : 11'bz;
  assign gazump=(~newRsSelect0 & ~newRsSelect1 & ~newRsSelect2 || stall) ? 11'b10000000000 : 11'bz;

  assign isFP_d=(newRsSelect0 & ~stall) ? newIsFP0 : 1'bz;
  assign isFP_d=(newRsSelect1 & ~stall) ? newIsFP1 : 1'bz;
  assign isFP_d=(newRsSelect2 & ~stall) ? newIsFP2 : 1'bz;
  assign isFP_d=(~newRsSelect0 & ~newRsSelect1 & ~newRsSelect2 || stall) ? isFP : 1'bz;

  assign isV_d=(newRsSelect0 & ~stall) ? newIsV0 : 1'bz;
  assign isV_d=(newRsSelect1 & ~stall) ? newIsV1 : 1'bz;
  assign isV_d=(newRsSelect2 & ~stall) ? newIsV2 : 1'bz;
  assign isV_d=(~newRsSelect0 & ~newRsSelect1 & ~newRsSelect2 || stall) ? isV : 1'bz;
  
  assign eq[0]=(register==Treg0) & Twen0 & ~newRsSelect0 & ~newRsSelect1 & ~newRsSelect2 & eq_mask[0];
  assign eq[1]=(register==Treg1) & Twen1 & ~newRsSelect0 & ~newRsSelect1 & ~newRsSelect2 & eq_mask[1];

  assign eq_new=eq|({2{newRsSelect0&~stall}}&newEQ0)|({2{newRsSelect1&~stall}}&newEQ1)|
    ({2{newRsSelect2&~stall}}&newEQ2);

  assign isData=|eq_new;
/*  assign isDataV=(|{eq_new&&funM,eq_new&&funAdd,eq_reg&&funMul});
  assign isDataF=(|{eq_new&&funM,eq_reg2&&funAdd,eq_reg4&&funMul});
  assign isData=isFP_d ? isDataF : 1'bz;
  assign isData=isV_d ? isDataV : 1'bz;
  assign isData=(~isFP_d & ~isV_d) ? isDataI : 1'bz;
*/  
  assign fuFwd_d=(eq_new[0] & funit_d[0]) ? 4'd0 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[1]) ? 4'd1 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[2]) ? 4'd2 : 4'bz;
  assign fuFwd_d=(eq_new[1] & funit_d[3]) ? 4'd3 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[4]) ? 4'd4 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[5]) ? 4'd5 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[6]) ? 4'd6 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[7]) ? 4'd7 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[8]) ? 4'd8 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[9]) ? 4'd9 : 4'bz;
  assign fuFwd_d=(eq_new[0]|(eq_new[1]&funit_d[3])&&~rst) ? 4'bz : 4'd15;

  assign gzFwd=gazump[0] ? 4'd0 : 4'bz;
  assign gzFwd=gazump[1] ? 4'd1 : 4'bz;
  assign gzFwd=gazump[2] ? 4'd2 : 4'bz;
  assign gzFwd=gazump[3] ? 4'd3 : 4'bz;
  assign gzFwd=gazump[4] ? 4'd4 : 4'bz;
  assign gzFwd=gazump[5] ? 4'd5 : 4'bz;
  assign gzFwd=gazump[6] ? 4'd6 : 4'bz;
  assign gzFwd=gazump[7] ? 4'd7 : 4'bz;
  assign gzFwd=gazump[8] ? 4'd8 : 4'bz;
  assign gzFwd=gazump[9] ? 4'd9 : 4'bz;
  assign gzFwd=gazump[10] ? 4'd15 : 4'bz;

  assign outEq={|outEq0[9:5],outEq0[9:5]|outEq0[4:0]};

  assign outFuFwd0=outRsSelect0 ? fuFwd : {4{1'bz}};
  assign outFuFwd1=outRsSelect1 ? fuFwd : {4{1'bz}};
  assign outFuFwd2=outRsSelect2 ? fuFwd : {4{1'bz}};

  assign outFuuFwd0=outRsSelect0 ? fuuFwd : {4{1'bz}};
  assign outFuuFwd1=outRsSelect1 ? fuuFwd : {4{1'bz}};
  assign outFuuFwd2=outRsSelect2 ? fuuFwd : {4{1'bz}};

  assign register_d=(newRsSelect0 & ~rst & ~stall) ? newReg0 : {REG_WIDTH{1'bz}};
  assign register_d=(newRsSelect1 & ~rst & ~stall) ? newReg1 : {REG_WIDTH{1'bz}};
  assign register_d=(newRsSelect2 & ~rst & ~stall) ? newReg2 : {REG_WIDTH{1'bz}};
  assign register_d=rst ? {REG_WIDTH{1'b1}} : {REG_WIDTH{1'bz}};
  assign register_d=(~newRsSelect0 & ~newRsSelect1 & ~newRsSelect2 & ~rst || stall &~rst) ? register : {REG_WIDTH{1'bz}};

  assign funit_d=(newRsSelect0 & ~rst & ~stall) ? newFunit0 : {FN_WIDTH{1'bz}};
  assign funit_d=(newRsSelect1 & ~rst & ~stall) ? newFunit1 : {FN_WIDTH{1'bz}};
  assign funit_d=(newRsSelect2 & ~rst & ~stall) ? newFunit2 : {FN_WIDTH{1'bz}};
  assign funit_d=rst ? 10'b1001 : {FN_WIDTH{1'bz}};
  assign funit_d=(~newRsSelect0 & ~newRsSelect1 & ~newRsSelect2 & ~rst || stall &~rst) ? funit : {FN_WIDTH{1'bz}};

  generate
    genvar n;
    for(n=0;n<=16;n=n+1) begin : treg_gen
	if (n!=3) assign Treg0=funit0[n] ? FUreg[n] : 9'bz;
	else assign Treg1=FUreg[3];
	if (n!=3) assign Twen0=funit0[n] ? FUwen[n] : 1'bz;
	else assign Twen1=FUwen[3] & funit[3];
    end
  endgenerate
  
  always @(posedge clk)
    begin
	  if (rst)
	    begin
		  fuFwd<=4'b0;
		  fuuFwd<=4'b0;
		  isFP<=1'b0;
		  isV<=1'b0;
		  outEq0<=10'b0;
		  eq_mask<=2'b0;
		  eq_reg<=2'b0;
	    end
          else
	    begin
	      if (newRsSelect0|newRsSelect1|newRsSelect2 && ~stall) begin
              eq_mask<=2'h3 & ~eq_new;
          end else begin
              eq_mask<=(eq_mask & ~eq_new) | {eq_reg[1]&~FU3Hit&funit[3], eq_reg[0]&~FU2Hit&funit[2] || 
		  eq_reg[0]&~FU1Hit&funit[1] || eq_reg[0]&~FU0Hit&funit[0]};
          end
		  fuFwd<=fuFwd_d;
		  fuuFwd<=gazump[10] ? fuFwd|{4{newRsSelect0|newRsSelect1|newRsSelect2}} : gzFwd;
		  isFP<=isFP_d;
		  isV<=isV_d;
		  eq_reg<=eq_new&(eq_mask|{2{newRsSelect0|newRsSelect1|newRsSelect2 && ~stall}})&{2{~sel}};
		  
		  outEq0[0]<=(eq_reg[0]&funit[0]||gazump[0])&FU0Hit&~sel;
		  outEq0[1]<=(eq_reg[0]&funit[1]||gazump[1])&FU1Hit&~sel;
		  outEq0[2]<=(eq_reg[0]&funit[2]||gazump[2])&FU2Hit&~sel;
		  outEq0[3]<=(eq_reg[1]&funit[3]||gazump[3])&FU3Hit&~sel;
		  outEq0[4]<=(eq_reg[0]&funit[4])|gazump[4]&&~sel;
		  outEq0[5]<=(eq_reg[0]&funit[5])|gazump[5]&&~sel;
		  outEq0[6]<=(eq_reg[0]&funit[6])|gazump[6]&&~sel;
		  outEq0[7]<=(eq_reg[0]&funit[7])|gazump[7]&&~sel;
		  outEq0[8]<=(eq_reg[0]&funit[8])|gazump[8]&&~sel;
		  outEq0[9]<=(eq_reg[0]&funit[9])|gazump[9]&&~sel;
		  
		end
	  register<=register_d;
	  funit<=funit_d;
    end
 
endmodule


module rs_wakeUp_logic_array(
  clk,rst,stall,
  isData,
  outEq,
  buffree,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  FUreg0,FU0wen,
  FUreg1,FU1wen,
  FUreg2,FU2wen,
  FUreg3,FU3wen,
  FUreg4,FU4wen,
  FUreg5,FU5wen,
  FUreg6,FU6wen,
  FUreg7,FU7wen,
  FUreg8,FU8wen,
  FUreg9,FU9wen,
  newRsSelect0,newReg0,newFunit0,newGazump0,newIsFP0,newIsV0,
  newRsSelect1,newReg1,newFunit1,newGazump1,newIsFP1,newIsV1,
  newRsSelect2,newReg2,newFunit2,newGazump2,newIsFP2,newIsV2,
  fuFwd,
  outRsSelect0,outDataEn0,outBank0,outFound0,outFuFwd0,outFuuFwd0,
  outRsSelect1,outDataEn1,outBank1,outFound1,outFuFwd1,outFuuFwd1,
  outRsSelect2,outDataEn2,outBank2,outFound2,outFuFwd2,outFuuFwd2
  );
  parameter DATA_WIDTH=`alu_width;
  localparam REG_WIDTH=`reg_addr_width;
  localparam BUF_COUNT=32;
  localparam FN_WIDTH=10;
   
  input clk;
  input rst;
  input stall;
  output [BUF_COUNT-1:0] isData;
  output [BUF_COUNT*6-1:0] outEq;
  input [BUF_COUNT-1:0] buffree;
  
//functional units inputs/outputs
  input FU0Hit;
  input FU1Hit;
  input FU2Hit;
  input FU3Hit;

  input [REG_WIDTH-1:0] FUreg0;
  input FU0wen;
  
  input [REG_WIDTH-1:0] FUreg1;
  input FU1wen;

  input [REG_WIDTH-1:0] FUreg2;
  input FU2wen;

  input [REG_WIDTH-1:0] FUreg3;
  input FU3wen;

  input [REG_WIDTH-1:0] FUreg4;
  input FU4wen;

  input [REG_WIDTH-1:0] FUreg5;
  input FU5wen;

  input [REG_WIDTH-1:0] FUreg6;
  input FU6wen;

  input [REG_WIDTH-1:0] FUreg7;
  input FU7wen;

  input [REG_WIDTH-1:0] FUreg8;
  input FU8wen;

  input [REG_WIDTH-1:0] FUreg9;
  input FU9wen;


  input [BUF_COUNT-1:0] newRsSelect0;
  input [REG_WIDTH-1:0] newReg0;
  input [FN_WIDTH-1:0] newFunit0;
  input [10:0] newGazump0;
  input newIsFP0,newIsV0;

  input [BUF_COUNT-1:0] newRsSelect1;
  input [REG_WIDTH-1:0] newReg1;
  input [FN_WIDTH-1:0] newFunit1;
  input [10:0] newGazump1;
  input newIsFP1,newIsV1;

  input [BUF_COUNT-1:0] newRsSelect2;
  input [REG_WIDTH-1:0] newReg2;
  input [FN_WIDTH-1:0] newFunit2;
  input [10:0] newGazump2;
  input newIsFP2,newIsV2;
  
  output [BUF_COUNT*4-1:0] fuFwd;
  
  input [BUF_COUNT-1:0] outRsSelect0;
  input outDataEn0;
  input [3:0] outBank0;
  input outFound0;
  output [3:0] outFuFwd0;
  output [3:0] outFuuFwd0;
  input [BUF_COUNT-1:0] outRsSelect1;
  input outDataEn1;
  input [3:0] outBank1;
  input outFound1;
  output [3:0] outFuFwd1;
  output [3:0] outFuuFwd1;
  input [BUF_COUNT-1:0] outRsSelect2;
  input outDataEn2;
  input [3:0] outBank2;
  input outFound2;
  output [3:0] outFuFwd2;
  output [3:0] outFuuFwd2;

  wire [1:0] newEQ[2:0];
  wire [8:0] register[2:0];
  wire [9:0] funit[2:0];

  wire [2:0][8:0] Treg0;
  wire [2:0] Twen0;
  wire [2:0][8:0] Treg1;
  wire [2:0] Twen1;

  wire [8:0] FUreg[18:0];
  wire [18:0] FUwen;
  
  reg [REG_WIDTH-1:0] FUreg4_reg;
  reg FU4wen_reg;

  reg [REG_WIDTH-1:0] FUreg5_reg;
  reg FU5wen_reg;

  reg [REG_WIDTH-1:0] FUreg6_reg;
  reg FU6wen_reg;

  reg [REG_WIDTH-1:0] FUreg7_reg;
  reg FU7wen_reg;

  reg [REG_WIDTH-1:0] FUreg8_reg;
  reg FU8wen_reg;

  reg [REG_WIDTH-1:0] FUreg9_reg;
  reg FU9wen_reg;

  reg [REG_WIDTH-1:0] FUreg4_reg2;
  reg FU4wen_reg2;

  reg [REG_WIDTH-1:0] FUreg5_reg2;
  reg FU5wen_reg2;

  reg [REG_WIDTH-1:0] FUreg6_reg2;
  reg FU6wen_reg2;

  reg [REG_WIDTH-1:0] FUreg7_reg2;
  reg FU7wen_reg2;

  reg [REG_WIDTH-1:0] FUreg8_reg2;
  reg FU8wen_reg2;

  reg [REG_WIDTH-1:0] FUreg9_reg2;
  reg FU9wen_reg2;

  reg [REG_WIDTH-1:0] FUreg7_reg3;
  reg FU7wen_reg3;

  reg [REG_WIDTH-1:0] FUreg8_reg3;
  reg FU8wen_reg3;

  reg [REG_WIDTH-1:0] FUreg9_reg3;
  reg FU9wen_reg3;

  reg [REG_WIDTH-1:0] FUreg7_reg4;
  reg FU7wen_reg4;

  reg [REG_WIDTH-1:0] FUreg8_reg4;
  reg FU8wen_reg4;

  reg [REG_WIDTH-1:0] FUreg9_reg4;
  reg FU9wen_reg4;

  wire [18:0] funit0[2:0];
  wire [2:0] isFP;
  wire [2:0] isV;

  assign register[0]=newReg0;
  assign register[1]=newReg1;
  assign register[2]=newReg2;

  assign funit[0]=newFunit0;
  assign funit[1]=newFunit1;
  assign funit[2]=newFunit2;

  assign isFP[0]=newIsFP0;
  assign isFP[1]=newIsFP1;
  assign isFP[2]=newIsFP2;
  
  assign isV[0]=newIsV0;
  assign isV[1]=newIsV1;
  assign isV[2]=newIsV2;
  
  assign FUreg[0]=FUreg0;
  assign FUreg[1]=FUreg1;
  assign FUreg[2]=FUreg2;
  assign FUreg[3]=FUreg3;
  assign FUreg[4]=FUreg4;
  assign FUreg[5]=FUreg5;
  assign FUreg[6]=FUreg6;
  assign FUreg[7]=FUreg7;
  assign FUreg[8]=FUreg8;
  assign FUreg[9]=FUreg9;
  assign FUreg[10]=FUreg7_reg;
  assign FUreg[11]=FUreg8_reg;
  assign FUreg[12]=FUreg9_reg;
  assign FUreg[13]=FUreg4_reg2;
  assign FUreg[14]=FUreg5_reg2;
  assign FUreg[15]=FUreg6_reg2;
  assign FUreg[16]=FUreg7_reg4;
  assign FUreg[17]=FUreg8_reg4;
  assign FUreg[18]=FUreg9_reg4;

  assign FUwen[0]=FU0wen;
  assign FUwen[1]=FU1wen;
  assign FUwen[2]=FU2wen;
  assign FUwen[3]=FU3wen;
  assign FUwen[4]=FU4wen;
  assign FUwen[5]=FU5wen;
  assign FUwen[6]=FU6wen;
  assign FUwen[7]=FU7wen;
  assign FUwen[8]=FU8wen;
  assign FUwen[9]=FU9wen;
  assign FUwen[10]=FU7wen_reg;
  assign FUwen[11]=FU8wen_reg;
  assign FUwen[12]=FU9wen_reg;
  assign FUwen[13]=FU4wen_reg2;
  assign FUwen[14]=FU5wen_reg2;
  assign FUwen[15]=FU6wen_reg2;
  assign FUwen[16]=FU7wen_reg4;
  assign FUwen[17]=FU8wen_reg4;
  assign FUwen[18]=FU9wen_reg4;
  
  generate
      genvar j,k,p,q;
      for (j=0;j<4;j=j+1) begin : banks_gen
          wire [3:0] fuFwdk;
          wire [3:0] fuuFwdk;
          
          wire [3:0] outFuFwd0k;
          wire [3:0] outFuuFwd0k;
          wire [3:0] outFuFwd1k;
          wire [3:0] outFuuFwd1k;
          wire [3:0] outFuFwd2k;
          wire [3:0] outFuuFwd2k;
          for (k=0;k<8;k=k+1) begin : bufs_gen
              rs_wakeUp_logic #(DATA_WIDTH) buf_mod(
              clk,rst,stall,
              isData[k+8*j],
              outEq[(k+8*j)*6+:6],
              buffree[k+8*j],
              FU0Hit,FU1Hit,FU2Hit,FU3Hit,
              FUreg0,FU0wen,
              FUreg1,FU1wen,
              FUreg2,FU2wen,
              FUreg3,FU3wen,
              FUreg4,FU4wen,
              FUreg5,FU5wen,
              FUreg6,FU6wen,
              FUreg7,FU7wen,
              FUreg8,FU8wen,
              FUreg9,FU9wen,
              FUreg4_reg2,FU4wen_reg,
              FUreg5_reg2,FU5wen_reg,
              FUreg6_reg2,FU6wen_reg,
              FUreg7_reg4,FU7wen_reg4,
              FUreg8_reg4,FU8wen_reg4,
              FUreg9_reg4,FU9wen_reg4,
              newRsSelect0[k+8*j],newReg0,newFunit0,newGazump0,newIsFP0,newIsV0,newEQ[0],
              newRsSelect1[k+8*j],newReg1,newFunit1,newGazump1,newIsFP1,newIsV1,newEQ[1],
              newRsSelect2[k+8*j],newReg2,newFunit2,newGazump2,newIsFP2,newIsV2,newEQ[2],
              fuFwd[(k+8*j)*4+:4],
              outRsSelect0[k+8*j],outDataEn0,outFuFwd0k,outFuuFwd0k,
              outRsSelect1[k+8*j],outDataEn1,outFuFwd1k,outFuuFwd1k,
              outRsSelect2[k+8*j],outDataEn2,outFuFwd2k,outFuuFwd2k
              );
          end
          
          
          assign outFuFwd0=outBank0[j] ? outFuFwd0k : 4'bz;
          assign outFuFwd1=outBank1[j] ? outFuFwd1k : 4'bz;
          assign outFuFwd2=outBank2[j] ? outFuFwd2k : 4'bz;

          assign outFuuFwd0=outBank0[j] ? outFuuFwd0k : 4'bz;
          assign outFuuFwd1=outBank1[j] ? outFuuFwd1k : 4'bz;
          assign outFuuFwd2=outBank2[j] ? outFuuFwd2k : 4'bz;

          
          assign outFuFwd0k=outBank0[j] ? 4'bz : 4'hf;
          assign outFuFwd1k=outBank1[j] ? 4'bz : 4'hf;
          assign outFuFwd2k=outBank2[j] ? 4'bz : 4'hf;

          assign outFuuFwd0k=outBank0[j] ? 4'bz : 4'hf;
          assign outFuuFwd1k=outBank1[j] ? 4'bz : 4'hf;
          assign outFuuFwd2k=outBank2[j] ? 4'bz : 4'hf;
      end
      for(p=0;p<3;p=p+1) begin : newEQ_gen
          assign newEQ[p][0]=(register[p]==Treg0[p]) & Twen0[p];
          assign newEQ[p][1]=(register[p]==Treg1[p]) & Twen1[p];
        
	  assign funit0[p][3:0]=funit[p][3:0];
          assign funit0[p][6:4]=funit[p][6:4] & {3{~isFP[p]}};
          assign funit0[p][9:7]=funit[p][9:7] & {3{~isFP[p] & ~isV[p]}};
          assign funit0[p][12:10]=funit[p][9:7] & {3{isV[p]}};
          assign funit0[p][18:13]=funit[p][9:4] & {6{isFP[p]}};

	  for(q=0;q<19;q=q+1) begin : funit_gen
	      if (q!=3) assign Treg0[p]=funit0[p][q] ? FUreg[q] : 9'bz;
	      else assign Treg1[p]=FUreg[3];
	      if (q!=3) assign Twen0[p]=funit0[p][q] ? FUwen[q] : 1'bz;
	      else assign Twen1[p]=FUwen[3] & funit[p][3];
	  end
      end
  endgenerate

         
  assign outFuFwd0=outFound0 ? 4'bz : 4'hf;
  assign outFuFwd1=outFound1 ? 4'bz : 4'hf;
  assign outFuFwd2=outFound2 ? 4'bz : 4'hf;

  assign outFuuFwd0=outFound0 ? 4'bz : 4'hf;
  assign outFuuFwd1=outFound1 ? 4'bz : 4'hf;
  assign outFuuFwd2=outFound2 ? 4'bz : 4'hf;
 
  always @(posedge clk) begin
    if (rst) begin
	FUreg4_reg<=9'h1ff;
	FU4wen_reg<=1'b0;
	FUreg5_reg<=9'h1ff;
	FU5wen_reg<=1'b0;
	FUreg6_reg<=9'h1ff;
	FU6wen_reg<=1'b0;
	FUreg7_reg<=9'h1ff;
	FU7wen_reg<=1'b0;
	FUreg8_reg<=9'h1ff;
	FU8wen_reg<=1'b0;
	FUreg9_reg<=9'h1ff;
	FU9wen_reg<=1'b0;
	FUreg4_reg2<=9'h1ff;
	FU4wen_reg2<=1'b0;
	FUreg5_reg2<=9'h1ff;
	FU5wen_reg2<=1'b0;
	FUreg6_reg2<=9'h1ff;
	FU6wen_reg2<=1'b0;
	FUreg7_reg2<=9'h1ff;
	FU7wen_reg2<=1'b0;
	FUreg8_reg2<=9'h1ff;
	FU8wen_reg2<=1'b0;
	FUreg9_reg2<=9'h1ff;
	FU9wen_reg2<=1'b0;
	FUreg7_reg3<=9'h1ff;
	FU7wen_reg3<=1'b0;
	FUreg8_reg3<=9'h1ff;
	FU8wen_reg3<=1'b0;
	FUreg9_reg3<=9'h1ff;
	FU9wen_reg3<=1'b0;
	FUreg7_reg4<=9'h1ff;
	FU7wen_reg4<=1'b0;
	FUreg8_reg4<=9'h1ff;
	FU8wen_reg4<=1'b0;
	FUreg9_reg4<=9'h1ff;
	FU9wen_reg4<=1'b0;
    end else begin
	FUreg4_reg<=FUreg4;
	FU4wen_reg<=FU4wen;
	FUreg5_reg<=FUreg5;
	FU5wen_reg<=FU5wen;
	FUreg6_reg<=FUreg6;
	FU6wen_reg<=FU6wen;
	FUreg7_reg<=FUreg7;
	FU7wen_reg<=FU7wen;
	FUreg8_reg<=FUreg8;
	FU8wen_reg<=FU8wen;
	FUreg9_reg<=FUreg9;
	FU9wen_reg<=FU9wen;
	FUreg4_reg2<=FUreg4_reg;
	FU4wen_reg2<=FU4wen_reg;
	FUreg5_reg2<=FUreg5_reg;
	FU5wen_reg2<=FU5wen_reg;
	FUreg6_reg2<=FUreg6_reg;
	FU6wen_reg2<=FU6wen_reg;
	FUreg7_reg2<=FUreg7_reg;
	FU7wen_reg2<=FU7wen_reg;
	FUreg8_reg2<=FUreg8_reg;
	FU8wen_reg2<=FU8wen_reg;
	FUreg9_reg2<=FUreg9_reg;
	FU9wen_reg2<=FU9wen_reg;
	FUreg7_reg3<=FUreg7_reg2;
	FU7wen_reg3<=FU7wen_reg2;
	FUreg8_reg3<=FUreg8_reg2;
	FU8wen_reg3<=FU8wen_reg2;
	FUreg9_reg3<=FUreg9_reg2;
	FU9wen_reg3<=FU9wen_reg2;
	FUreg7_reg4<=FUreg7_reg3;
	FU7wen_reg4<=FU7wen_reg3;
	FUreg8_reg4<=FUreg8_reg3;
	FU8wen_reg4<=FU8wen_reg3;
	FUreg9_reg4<=FUreg9_reg3;
	FU9wen_reg4<=FU9wen_reg3;
    end
  end 
endmodule

module rs_wakeUp_data(
  clk,rst,stall,
  newRsSelect0,newData0,
  newRsSelect1,newData1,
  newRsSelect2,newData2,
  outEq,
  FU0,FU1,FU2,FU3,
  FU4,FU5,FU6,
  FU7,FU8,FU9,
  outRsSelect0,outData0,
  outRsSelect1,outData1,
  outRsSelect2,outData2
  );

  parameter WIDTH=`alu_width;
  
  input clk;
  input rst;
  input stall;
  input newRsSelect0;
  input [WIDTH-1:0] newData0;
  input newRsSelect1;
  input [WIDTH-1:0] newData1;
  input newRsSelect2;
  input [WIDTH-1:0] newData2;
  input outRsSelect0;
  
  input [5:0] outEq;
  input [WIDTH-1:0] FU0;
  input [WIDTH-1:0] FU1;
  input [WIDTH-1:0] FU2;
  input [WIDTH-1:0] FU3;
  input [WIDTH-1:0] FU4;
  input [WIDTH-1:0] FU5;
  input [WIDTH-1:0] FU6;
  input [WIDTH-1:0] FU7;
  input [WIDTH-1:0] FU8;
  input [WIDTH-1:0] FU9;
  
  output [WIDTH-1:0] outData0;
  input outRsSelect1;
  output [WIDTH-1:0] outData1;
  input outRsSelect2;
  output [WIDTH-1:0] outData2;
  

  wire data_en;
  wire [WIDTH-1:0] data_d;
  wire [WIDTH-1:0] data_d0;
  wire [WIDTH-1:0] data_d1;
  reg [WIDTH-1:0] data_q;


  assign data_en=|{outEq,newRsSelect0,newRsSelect1,newRsSelect2};

  assign data_d0=outEq[0] ? FU0 : {WIDTH{1'bz}};
  assign data_d0=outEq[1] ? FU1 : {WIDTH{1'bz}};
  assign data_d0=outEq[2] ? FU2 : {WIDTH{1'bz}};
  assign data_d0=outEq[3] ? FU3 : {WIDTH{1'bz}};
  assign data_d0=outEq[4] ? FU4 : {WIDTH{1'bz}};
  assign data_d0=|outEq[4:0] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
  assign data_d1=outEq[0] ? FU5 : {WIDTH{1'bz}};
  assign data_d1=outEq[1] ? FU6 : {WIDTH{1'bz}};
  assign data_d1=outEq[2] ? FU7 : {WIDTH{1'bz}};
  assign data_d1=outEq[3] ? FU8 : {WIDTH{1'bz}};
  assign data_d1=outEq[4] ? FU9 : {WIDTH{1'bz}};
  assign data_d1=|outEq[4:0] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
  assign data_d=(newRsSelect0 & ~rst & ~stall) ? newData0 : {WIDTH{1'bz}};
  assign data_d=(newRsSelect1 & ~rst & ~stall) ? newData1 : {WIDTH{1'bz}};
  assign data_d=(newRsSelect2 & ~rst & ~stall) ? newData2 : {WIDTH{1'bz}};

  assign data_d=rst ? {WIDTH{1'b0}} : {WIDTH{1'bz}};

  assign data_d=(data_en & ~(stall && newRsSelect0|newRsSelect1|newRsSelect2) || rst) ? {WIDTH{1'bz}} : data_q;
  assign data_d=(|outEq[4:0] && outEq[5]) ? data_d1 : {WIDTH{1'BZ}};
  assign data_d=(|outEq[4:0] && ~outEq[5]) ? data_d0 : {WIDTH{1'BZ}};
  assign outData0=outRsSelect0 ? data_q : {WIDTH{1'bz}};
  assign outData1=outRsSelect1 ? data_q : {WIDTH{1'bz}};
  assign outData2=outRsSelect2 ? data_q : {WIDTH{1'bz}};

  always @(posedge clk)
    begin
      data_q<=data_d;
    end
    
endmodule


module rs_wakeUp_data_array(
  clk,rst,stall,
  newRsSelect0,newData0,
  newRsSelect1,newData1,
  newRsSelect2,newData2,
  outEq,
  FU0,FU1,FU2,FU3,
  FU4,FU5,FU6,
  FU7,FU8,FU9,
  outRsSelect0,outBank0,outFound0,outData0,
  outRsSelect1,outBank1,outFound1,outData1,
  outRsSelect2,outBank2,outFound2,outData2
  );

  parameter WIDTH=`alu_width+1;
  localparam BUF_COUNT=32;
  
  input clk;
  input rst;
  input stall;
  input [BUF_COUNT-1:0] newRsSelect0;
  input [WIDTH-1:0] newData0;
  input [BUF_COUNT-1:0] newRsSelect1;
  input [WIDTH-1:0] newData1;
  input [BUF_COUNT-1:0] newRsSelect2;
  input [WIDTH-1:0] newData2;
  
  input [6*BUF_COUNT-1:0] outEq;
  input [WIDTH-1:0] FU0;
  input [WIDTH-1:0] FU1;
  input [WIDTH-1:0] FU2;
  input [WIDTH-1:0] FU3;
  input [WIDTH-1:0] FU4;
  input [WIDTH-1:0] FU5;
  input [WIDTH-1:0] FU6;
  input [WIDTH-1:0] FU7;
  input [WIDTH-1:0] FU8;
  input [WIDTH-1:0] FU9;
  
  input [BUF_COUNT-1:0] outRsSelect0;
  input [3:0] outBank0;
  input outFound0;
  output [WIDTH-1:0] outData0;
  input [BUF_COUNT-1:0] outRsSelect1;
  input [3:0] outBank1;
  input outFound1;
  output [WIDTH-1:0] outData1;
  input [BUF_COUNT-1:0] outRsSelect2;
  input [3:0] outBank2;
  input outFound2;
  output [WIDTH-1:0] outData2;

  generate
      genvar j,k;
      for (j=0;j<4;j=j+1) begin : tile_gen
          wire [WIDTH-1:0] outData0k;
          wire [WIDTH-1:0] outData1k;
          wire [WIDTH-1:0] outData2k;
          
          for (k=0;k<8;k=k+1) begin : buf_gen
              rs_wakeUp_data #(WIDTH) buf_mod(
              clk,rst,stall,
              newRsSelect0[k+8*j],newData0,
              newRsSelect1[k+8*j],newData1,
              newRsSelect2[k+8*j],newData2,
              outEq[(k+8*j)*6+:6],
              FU0,FU1,FU2,FU3,
              FU4,FU5,FU6,
              FU7,FU8,FU9,              
              outRsSelect0[k+8*j],outData0k,
              outRsSelect1[k+8*j],outData1k,
              outRsSelect2[k+8*j],outData2k
              );
          end
          assign outData0=outBank0[j] ? outData0k : {WIDTH{1'BZ}};
          assign outData1=outBank1[j] ? outData1k : {WIDTH{1'BZ}};
          assign outData2=outBank2[j] ? outData2k : {WIDTH{1'BZ}};

          assign outData0k=outBank0[j] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
          assign outData1k=outBank1[j] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
          assign outData2k=outBank2[j] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
      end
  endgenerate

  assign outData0=outFound0 ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
  assign outData1=outFound1 ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
  assign outData2=outFound2 ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
  
endmodule


//has error
module rs_wakeUpS_logic(
  clk,rst,stall,
  isData,
  outEq,
  buffree,
//  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
//  FUreg0,FU0wen,
//  FUreg1,FU1wen,
//  FUreg2,FU2wen,
//  FUreg3,FU3wen,
  FUreg4,FU4wen,
  FUreg5,FU5wen,
  FUreg6,FU6wen,
  FUreg7,FU7wen,
  FUreg8,FU8wen,
  FUreg9,FU9wen,
  FUreg4_reg4,FU4wen_reg4,
  FUreg5_reg4,FU5wen_reg4,
  FUreg6_reg4,FU6wen_reg4,
  newRsSelect1,newReg1,newFunit1,newGazump1,newIsFP1,newEQ1,
  newRsSelect2,newReg2,newFunit2,newGazump2,newIsFP2,newEQ2,
  fuFwd,
  outRsSelect1,outDataEn1,outFuFwd1,outFuuFwd1,
  outRsSelect2,outDataEn2,outFuFwd2,outFuuFwd2
  );
  parameter DATA_WIDTH=`alu_width;
  localparam REG_WIDTH=`reg_addr_width;
  localparam FN_WIDTH=10;

  input clk;
  input rst;
  input stall;
  output wire isData;
  output [5:0] outEq;

  input buffree;

  input [REG_WIDTH-1:0] FUreg4;
  input FU4wen;

  input [REG_WIDTH-1:0] FUreg5;
  input FU5wen;

  input [REG_WIDTH-1:0] FUreg6;
  input FU6wen;

  input [REG_WIDTH-1:0] FUreg7;
  input FU7wen;

  input [REG_WIDTH-1:0] FUreg8;
  input FU8wen;

  input [REG_WIDTH-1:0] FUreg9;
  input FU9wen;

  input [REG_WIDTH-1:0] FUreg4_reg4;
  input FU4wen_reg4;

  input [REG_WIDTH-1:0] FUreg5_reg4;
  input FU5wen_reg4;

  input [REG_WIDTH-1:0] FUreg6_reg4;
  input FU6wen_reg4;



  input newRsSelect1;
  input [REG_WIDTH-1:0] newReg1;
  input [FN_WIDTH-1:0] newFunit1;
  input [10:0] newGazump1;
  input newIsFP1;
  input [1:0] newEQ1;

  input newRsSelect2;
  input [REG_WIDTH-1:0] newReg2;
  input [FN_WIDTH-1:0] newFunit2;
  input [10:0] newGazump2;
  input newIsFP2;
  input [1:0] newEQ2;
  
  output reg [3:0] fuFwd;
  
  input outRsSelect1;
  input outDataEn1;
  output [3:0] outFuFwd1;
  output [3:0] outFuuFwd1;
  input outRsSelect2;
  input outDataEn2;
  output [3:0] outFuFwd2;
  output [3:0] outFuuFwd2;
  
  wire [3:0] fuFwd_d;
// equals wires
  wire [1:0] eq;
  wire [1:0] eq_new;


  reg [1:0] eq_reg;

  reg [1:0] eq_mask;
   
  wire [REG_WIDTH-1:0] register_d;
  reg [REG_WIDTH-1:0] register;

  wire [FN_WIDTH-1:0] funit_d;
  reg [FN_WIDTH-1:0] funit;

  reg [3:0] fuuFwd;
  
  wire [10:0] gazump;
  wire [3:0] gzFwd;
  
  wire [8:0] Treg0;
  wire Twen0;
  wire [8:0] Treg1;
  wire Twen1;

  wire [8:0] FUreg[9:0];
  wire [9:0] FUwen;

  reg isFP;
  wire isFP_d;
  
  wire isDataF,isDataI;

  wire sel;

  wire funM,funAdd,funMul;

  reg [9:1] outEq0;
  
  assign sel=outRsSelect1&outDataEn1||outRsSelect2&outDataEn2||buffree&~newRsSelect1&~newRsSelect2;

  assign FUreg[3]=9'b0;
  assign FUreg[0]=FUreg4_reg4;
  assign FUreg[1]=FUreg5_reg4;
  assign FUreg[2]=FUreg6_reg4;
  assign FUreg[4]=FUreg4;
  assign FUreg[5]=FUreg5;
  assign FUreg[6]=FUreg6;
  assign FUreg[7]=FUreg7;
  assign FUreg[8]=FUreg8;
  assign FUreg[9]=FUreg9;

  assign FUwen[3]=1'b0;
  assign FUwen[0]=FU4wen_reg4;
  assign FUwen[1]=FU5wen_reg4;
  assign FUwen[2]=FU6wen_reg4;
  assign FUwen[4]=FU4wen;
  assign FUwen[5]=FU5wen;
  assign FUwen[6]=FU6wen;
  assign FUwen[7]=FU7wen;
  assign FUwen[8]=FU8wen;
  assign FUwen[9]=FU9wen;

  assign funM=|funit_d[2:0];
  assign funAdd=|funit_d[6:4];
  assign funMul=|funit_d[9:7];
  
  assign gazump=(newRsSelect1 & ~stall) ? newGazump1 : 11'bz;
  assign gazump=(newRsSelect2  & ~stall) ? newGazump2 : 11'bz;
  assign gazump=(~newRsSelect1 & ~newRsSelect2 || stall) ? 11'b10000000000 : 11'bz;

  assign isFP_d=(newRsSelect1 & ~stall) ? newIsFP1 : 1'bz;
  assign isFP_d=(newRsSelect2 & ~stall) ? newIsFP2 : 1'bz;
  assign isFP_d=(~newRsSelect1 & ~newRsSelect2 || stall) ? isFP : 1'bz;

  assign eq[0]=(register==Treg0) & Twen0 & ~newRsSelect1 & ~newRsSelect2 &eq_mask[0];
  assign eq[1]=(register==Treg1) & Twen1 & ~newRsSelect1 & ~newRsSelect2 &eq_mask[1];

  assign eq_new=eq|({2{newRsSelect1&~stall}}&newEQ1)|({2{newRsSelect2&~stall}}&newEQ2);

  assign isDataI=|eq_new;
  assign isData=isDataI;

  assign fuFwd_d=(eq_new[0] & funit_d[0]) ? 4'd0 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[1]) ? 4'd1 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[2]) ? 4'd2 : 4'bz;
 // assign fuFwd_d=(eq_new[1] & funit[3]) ? 4'd3 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[4]) ? 4'd4 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[5]) ? 4'd5 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[6]) ? 4'd6 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[7]) ? 4'd7 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[8]) ? 4'd8 : 4'bz;
  assign fuFwd_d=(eq_new[0] & funit_d[9]) ? 4'd9 : 4'bz;
  assign fuFwd_d=(eq_new[0]&~rst) ? 4'bz : 4'd15;

  assign gzFwd=gazump[0] ? 4'd0 : 4'bz;
  assign gzFwd=gazump[1] ? 4'd1 : 4'bz;
  assign gzFwd=gazump[2] ? 4'd2 : 4'bz;
  assign gzFwd=gazump[3] ? 4'd3 : 4'bz;
  assign gzFwd=gazump[4] ? 4'd4 : 4'bz;
  assign gzFwd=gazump[5] ? 4'd5 : 4'bz;
  assign gzFwd=gazump[6] ? 4'd6 : 4'bz;
  assign gzFwd=gazump[7] ? 4'd7 : 4'bz;
  assign gzFwd=gazump[8] ? 4'd8 : 4'bz;
  assign gzFwd=gazump[9] ? 4'd9 : 4'bz;
  assign gzFwd=gazump[10] ? 4'd15 : 4'bz;

  assign outEq={|outEq0[9:5],outEq0[9:5]|{outEq0[4:1],1'b0}};

  assign outFuFwd1=outRsSelect1 ? fuFwd : {4{1'bz}};
  assign outFuFwd2=outRsSelect2 ? fuFwd : {4{1'bz}};

  assign outFuuFwd1=outRsSelect1 ? fuuFwd : {4{1'bz}};
  assign outFuuFwd2=outRsSelect2 ? fuuFwd : {4{1'bz}};

  assign register_d=(newRsSelect1 & ~rst & ~stall) ? newReg1 : {REG_WIDTH{1'bz}};
  assign register_d=(newRsSelect2 & ~rst & ~stall) ? newReg2 : {REG_WIDTH{1'bz}};
  assign register_d=rst ? {REG_WIDTH{1'b1}} : {REG_WIDTH{1'bz}};
  assign register_d=(~newRsSelect1 & ~newRsSelect2 & ~rst || stall &~rst) ? register : {REG_WIDTH{1'bz}};

  assign funit_d=(newRsSelect1 & ~rst & ~stall) ? newFunit1 : {FN_WIDTH{1'bz}};
  assign funit_d=(newRsSelect2 & ~rst & ~stall) ? newFunit2 : {FN_WIDTH{1'bz}};
  assign funit_d=rst ? 10'b1 : {FN_WIDTH{1'bz}};
  assign funit_d=(~newRsSelect1 & ~newRsSelect2 & ~rst || stall &~rst) ? funit : {FN_WIDTH{1'bz}};
  
  generate
    genvar n;
    for(n=0;n<10;n=n+1) begin : treg_gen
	if (n!=3) assign Treg0=funit[n] ? FUreg[n] : 9'bz;
	else assign Treg1=FUreg[3];
	if (n!=3) assign Twen0=funit[n] ? FUwen[n] : 1'bz;
	else assign Twen1=FUwen[3] & funit[3];
    end
  endgenerate
  
  always @(posedge clk)
    begin
//      data_q<=data_d;
       if (rst) begin
		  fuFwd<=4'b0;
		  fuuFwd<=4'b0;
		  isFP<=1'b0;
		  eq_reg<=2'b0;
		  outEq0<=9'b0;
		  eq_mask<=2'b0;
       end else begin
          if (newRsSelect1|newRsSelect2 && ~stall) begin
              eq_mask<=2'h3 & ~eq_new;
          end else begin
              eq_mask<=eq_mask & ~eq_new;
          end
	  fuFwd<=fuFwd_d;
	  fuuFwd<=gazump[10] ? fuFwd|{4{newRsSelect1|newRsSelect2}} : gzFwd;
	  isFP<=isFP_d;
	  eq_reg<=eq_new&(eq_mask|{2{newRsSelect1|newRsSelect2 & ~stall}})&{2{~sel}};
		  
	  outEq0[4]<=(~isFP & eq_reg[0]&funit[4])|gazump[0]&&~sel;
          outEq0[5]<=(~isFP & eq_reg[0]&funit[5])|gazump[1]&&~sel;
          outEq0[6]<=(~isFP & eq_reg[0]&funit[6])|gazump[2]&&~sel;
	  outEq0[1]<=(isFP & eq_reg[0]&funit[0])|gazump[6]&&~sel;
	  outEq0[2]<=(isFP & eq_reg[0]&funit[1])|gazump[7]&&~sel;
	  outEq0[3]<=(isFP & eq_reg[0]&funit[2])|gazump[8]&&~sel;
	  outEq0[7]<=(~isFP & eq_reg[0]&funit[7])|gazump[3]&&~sel;
	  outEq0[8]<=(~isFP & eq_reg[0]&funit[8])|gazump[4]&&~sel;
	  outEq0[9]<=(~isFP & eq_reg[0]&funit[9])|gazump[5]&&~sel;
       end
       register<=register_d;
       funit<=funit_d;
    end
 
endmodule


module rs_wakeUpS_logic_array(
  clk,rst,stall,
  isData,
  outEq,
  buffree,
  FUreg0,FU0wen,
  FUreg1,FU1wen,
  FUreg2,FU2wen,
  FUreg3,FU3wen,
  FUreg4,FU4wen,
  FUreg5,FU5wen,
  FU6wen,FU7wen,FU8wen,
  newRsSelect1,newReg1,newFunit1,newGazump1,newIsFP1,
  newRsSelect2,newReg2,newFunit2,newGazump2,newIsFP2,
  fuFwd,
  outRsSelect1,outDataEn1,outBank1,outFound1,outFuFwd1,outFuuFwd1,
  outRsSelect2,outDataEn2,outBank2,outFound2,outFuFwd2,outFuuFwd2
  );
  parameter DATA_WIDTH=`alu_width;
  localparam REG_WIDTH=`reg_addr_width;
  localparam BUF_COUNT=32;
  localparam FN_WIDTH=10;
  
  input clk;
  input rst;
  input stall;
  output [BUF_COUNT-1:0] isData;
  output [BUF_COUNT*6-1:0] outEq;
  
  input [BUF_COUNT-1:0] buffree;
  
//functional units inputs/outputs

  input [REG_WIDTH-1:0] FUreg0;
  input FU0wen;
  
  input [REG_WIDTH-1:0] FUreg1;
  input FU1wen;

  input [REG_WIDTH-1:0] FUreg2;
  input FU2wen;

  input [REG_WIDTH-1:0] FUreg3;
  input FU3wen;

  input [REG_WIDTH-1:0] FUreg4;
  input FU4wen;

  input [REG_WIDTH-1:0] FUreg5;
  input FU5wen;

  input FU6wen;
  input FU7wen;
  input FU8wen;



  input [BUF_COUNT-1:0] newRsSelect1;
  input [REG_WIDTH-1:0] newReg1;
  input [FN_WIDTH-1:0] newFunit1;
  input [10:0] newGazump1;
  input newIsFP1;

  input [BUF_COUNT-1:0] newRsSelect2;
  input [REG_WIDTH-1:0] newReg2;
  input [FN_WIDTH-1:0] newFunit2;
  input [10:0] newGazump2;
  input newIsFP2;
  
  output [BUF_COUNT*4-1:0] fuFwd;
  
  input [BUF_COUNT-1:0] outRsSelect1;
  input outDataEn1;
  input [3:0] outBank1;
  input outFound1;
  output [3:0] outFuFwd1;
  output [3:0] outFuuFwd1;
  input [BUF_COUNT-1:0] outRsSelect2;
  input outDataEn2;
  input [3:0] outBank2;
  input outFound2;
  output [3:0] outFuFwd2;
  output [3:0] outFuuFwd2;

  wire [1:0] newEQ[2:1];
  wire [8:0] register[2:1];
  wire [9:0] funit[2:1];

  wire [2:1][8:0] Treg0;
  wire [2:1] Twen0;
  wire [2:1][8:0] Treg1;
  wire [2:1] Twen1;

  wire [8:0] FUreg[9:0];
  wire [9:0] FUwen;
  
  reg [REG_WIDTH-1:0] FUreg0_reg;
  reg FU0wen_reg;
  reg [REG_WIDTH-1:0] FUreg1_reg;
  reg FU1wen_reg;
  reg [REG_WIDTH-1:0] FUreg2_reg;
  reg FU2wen_reg;

  reg [REG_WIDTH-1:0] FUreg3_reg;
  reg FU3wen_reg;
  reg [REG_WIDTH-1:0] FUreg4_reg;
  reg FU4wen_reg;
  reg [REG_WIDTH-1:0] FUreg5_reg;
  reg FU5wen_reg;

  reg [REG_WIDTH-1:0] FUreg0_reg2;
  reg FU0wen_reg2;
  reg [REG_WIDTH-1:0] FUreg1_reg2;
  reg FU1wen_reg2;
  reg [REG_WIDTH-1:0] FUreg2_reg2;
  reg FU2wen_reg2;

  reg [REG_WIDTH-1:0] FUreg0_reg3;
  reg FU0wen_reg3;
  reg [REG_WIDTH-1:0] FUreg1_reg3;
  reg FU1wen_reg3;
  reg [REG_WIDTH-1:0] FUreg2_reg3;
  reg FU2wen_reg3;

  reg [REG_WIDTH-1:0] FUreg0_reg4;
  reg FU0wen_reg4;
  reg [REG_WIDTH-1:0] FUreg1_reg4;
  reg FU1wen_reg4;
  reg [REG_WIDTH-1:0] FUreg2_reg4;
  reg FU2wen_reg4;

  reg FU6wen_reg;
  reg FU7wen_reg;
  reg FU8wen_reg;

  assign register[1]=newReg1;
  assign register[2]=newReg2;

  assign funit[1]=newFunit1;
  assign funit[2]=newFunit2;

  assign FUreg[3]=9'b0;
  assign FUreg[0]=FUreg0_reg3;
  assign FUreg[1]=FUreg1_reg3;
  assign FUreg[2]=FUreg2_reg3;
  assign FUreg[4]=FUreg0;
  assign FUreg[5]=FUreg1;
  assign FUreg[6]=FUreg2;
  assign FUreg[7]=FUreg3;
  assign FUreg[8]=FUreg4;
  assign FUreg[9]=FUreg5;

  assign FUwen[3]=1'b0;
  assign FUwen[0]=FU0wen_reg3;
  assign FUwen[1]=FU1wen_reg3;
  assign FUwen[2]=FU2wen_reg3;
  assign FUwen[4]=FU0wen;
  assign FUwen[5]=FU1wen;
  assign FUwen[6]=FU2wen;
  assign FUwen[7]=FU3wen;
  assign FUwen[8]=FU4wen;
  assign FUwen[9]=FU5wen;
  generate
      genvar j,k,p,q;
      for (j=0;j<4;j=j+1) begin : banks_gen
          wire [3:0] fuFwdk;
          wire [3:0] fuuFwdk;
          
          wire [3:0] outFuFwd0k;
          wire [3:0] outFuuFwd0k;
          wire [3:0] outFuFwd1k;
          wire [3:0] outFuuFwd1k;
          wire [3:0] outFuFwd2k;
          wire [3:0] outFuuFwd2k;
          
          for (k=0;k<8;k=k+1) begin : bufs_gen
              rs_wakeUpS_logic #(DATA_WIDTH) buf_mod(
              clk,rst,stall,
              isData[k+8*j],
              outEq[(k+8*j)*6+:6],
              buffree[k+8*j],
              FUreg0,FU0wen,
              FUreg1,FU1wen,
              FUreg2,FU2wen,
              FUreg3,FU3wen,
              FUreg4,FU4wen,
              FUreg5,FU5wen,
              FUreg0_reg3,FU0wen_reg3,
              FUreg1_reg3,FU1wen_reg3,
              FUreg2_reg3,FU2wen_reg3,
              newRsSelect1[k+8*j],newReg1,newFunit1,newGazump1,newIsFP1,newEQ[1],
              newRsSelect2[k+8*j],newReg2,newFunit2,newGazump2,newIsFP2,newEQ[2],
              fuFwd[(k+8*j)*4+:4],
              outRsSelect1[k+8*j],outDataEn1,outFuFwd1k,outFuuFwd1k,
              outRsSelect2[k+8*j],outDataEn2,outFuFwd2k,outFuuFwd2k
              );
          end
          
          
          assign outFuFwd1=outBank1[j] ? outFuFwd1k : 4'bz;
          assign outFuFwd2=outBank2[j] ? outFuFwd2k : 4'bz;

          assign outFuuFwd1=outBank1[j] ? outFuuFwd1k : 4'bz;
          assign outFuuFwd2=outBank2[j] ? outFuuFwd2k : 4'bz;

          
          assign outFuFwd1k=outBank1[j] ? 4'bz : 4'hf;
          assign outFuFwd2k=outBank2[j] ? 4'bz : 4'hf;

          assign outFuuFwd1k=outBank1[j] ? 4'bz : 4'hf;
          assign outFuuFwd2k=outBank2[j] ? 4'bz : 4'hf;
      end
      for(p=1;p<3;p=p+1) begin : newEQ_gen
          assign newEQ[p][0]=(register[p]==Treg0[p]) & Twen0[p];
          assign newEQ[p][1]=(register[p]==Treg1[p]) & Twen1[p];
	  for(q=0;q<10;q=q+1) begin : funit_gen
	      if (q!=3) assign Treg0[p]=funit[p][q] ? FUreg[q] : 9'bz;
	      else assign Treg1[p]=FUreg[3];
	      if (q!=3) assign Twen0[p]=funit[p][q] ? FUwen[q] : 1'bz;
	      else assign Twen1[p]=FUwen[3] & funit[p][3];
	  end
      end
  endgenerate

         
  assign outFuFwd1=outFound1 ? 4'bz : 4'hf;
  assign outFuFwd2=outFound2 ? 4'bz : 4'hf;

  assign outFuuFwd1=outFound1 ? 4'bz : 4'hf;
  assign outFuuFwd2=outFound2 ? 4'bz : 4'hf;
 
  always @(posedge clk) begin
    FUreg0_reg<=FUreg0;
    FU0wen_reg<=FU0wen;
    FUreg1_reg<=FUreg1;
    FU1wen_reg<=FU1wen;
    FUreg2_reg<=FUreg2;
    FU2wen_reg<=FU2wen;
    FUreg3_reg<=FUreg3;
    FU3wen_reg<=FU3wen;
    FUreg4_reg<=FUreg4;
    FU4wen_reg<=FU4wen;
    FUreg5_reg<=FUreg5;
    FU5wen_reg<=FU5wen;
    FU6wen_reg<=FU6wen;
    FU7wen_reg<=FU7wen;
    FU8wen_reg<=FU8wen;
    FUreg0_reg2<=FUreg0_reg;
    FU0wen_reg2<=FU6wen_reg;
    FUreg1_reg2<=FUreg1_reg;
    FU1wen_reg2<=FU7wen_reg;
    FUreg2_reg2<=FUreg2_reg;
    FU2wen_reg2<=FU8wen_reg;
    FUreg0_reg3<=FUreg0_reg2;
    FU0wen_reg3<=FU0wen_reg2;
    FUreg1_reg3<=FUreg1_reg2;
    FU1wen_reg3<=FU1wen_reg2;
    FUreg2_reg3<=FUreg2_reg2;
    FU2wen_reg3<=FU2wen_reg2;
    FUreg0_reg4<=FUreg0_reg3;
    FU0wen_reg4<=FU0wen_reg3;
    FUreg1_reg4<=FUreg1_reg3;
    FU1wen_reg4<=FU1wen_reg3;
    FUreg2_reg4<=FUreg2_reg3;
    FU2wen_reg4<=FU2wen_reg3;
  end 
endmodule

module rs_nonWakeUp_DFF(
  clk,rst,stall,
  newRsSelect0,newData0,
  newRsSelect1,newData1,
  newRsSelect2,newData2,
  
  outRsSelect0,outData0,
  outRsSelect1,outData1,
  outRsSelect2,outData2
  );

  parameter WIDTH=`alu_width;
  
  input clk;
  input rst;
  input stall;
  input newRsSelect0;
  input [WIDTH-1:0] newData0;
  input newRsSelect1;
  input [WIDTH-1:0] newData1;
  input newRsSelect2;
  input [WIDTH-1:0] newData2;
  input outRsSelect0;
  output [WIDTH-1:0] outData0;
  input outRsSelect1;
  output [WIDTH-1:0] outData1;
  input outRsSelect2;
  output [WIDTH-1:0] outData2;
  

  wire data_en;
  wire [WIDTH-1:0] data_d;
  reg [WIDTH-1:0] data_q;


  assign data_en=|{newRsSelect0,newRsSelect1,newRsSelect2,rst};

  assign data_d=(newRsSelect0 & ~rst & ~stall) ? newData0 : {WIDTH{1'bz}};
  assign data_d=(newRsSelect1 & ~rst & ~stall) ? newData1 : {WIDTH{1'bz}};
  assign data_d=(newRsSelect2 & ~rst & ~stall) ? newData2 : {WIDTH{1'bz}};

  assign data_d=rst ? {WIDTH{1'b0}} : {WIDTH{1'bz}};

  assign data_d=(data_en & ~stall) ? {WIDTH{1'bz}} : data_q;
  
  assign outData0=(outRsSelect0) ? data_q : {WIDTH{1'bz}};
  assign outData1=(outRsSelect1) ? data_q : {WIDTH{1'bz}};
  assign outData2=(outRsSelect2) ? data_q : {WIDTH{1'bz}};

  always @(posedge clk)
    begin
      data_q<=data_d;
    end
    
endmodule


module rs_nonWakeUp_array(
  clk,rst,stall,
  newRsSelect0,newData0,
  newRsSelect1,newData1,
  newRsSelect2,newData2,
  
  outRsSelect0,outBank0,outFound0,outData0,
  outRsSelect1,outBank1,outFound1,outData1,
  outRsSelect2,outBank2,outFound2,outData2
  );

  parameter WIDTH=32;
  localparam BUF_COUNT=32;
  
  input clk;
  input rst;
  input stall;
  input [BUF_COUNT-1:0] newRsSelect0;
  input [WIDTH-1:0] newData0;
  input [BUF_COUNT-1:0] newRsSelect1;
  input [WIDTH-1:0] newData1;
  input [BUF_COUNT-1:0] newRsSelect2;
  input [WIDTH-1:0] newData2;
  input [BUF_COUNT-1:0] outRsSelect0;
  input [3:0] outBank0;
  input outFound0;
  output [WIDTH-1:0] outData0;
  input [BUF_COUNT-1:0] outRsSelect1;
  input [3:0] outBank1;
  input outFound1;
  output [WIDTH-1:0] outData1;
  input [BUF_COUNT-1:0] outRsSelect2;
  input [3:0] outBank2;
  input outFound2;
  output [WIDTH-1:0] outData2;

  generate
      genvar j,k;
      for (j=0;j<4;j=j+1) begin : tile_gen
          wire [WIDTH-1:0] outData0k;
          wire [WIDTH-1:0] outData1k;
          wire [WIDTH-1:0] outData2k;
          
          for (k=0;k<8;k=k+1) begin : buf_gen
              rs_nonWakeUp_DFF #(WIDTH) buf_mod(
              clk,rst,stall,
              newRsSelect0[k+8*j],newData0,
              newRsSelect1[k+8*j],newData1,
              newRsSelect2[k+8*j],newData2,
              
              outRsSelect0[k+8*j],outData0k,
              outRsSelect1[k+8*j],outData1k,
              outRsSelect2[k+8*j],outData2k
              );
          end
          assign outData0=outBank0[j] ? outData0k : {WIDTH{1'BZ}};
          assign outData1=outBank1[j] ? outData1k : {WIDTH{1'BZ}};
          assign outData2=outBank2[j] ? outData2k : {WIDTH{1'BZ}};

          assign outData0k=outBank0[j] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
          assign outData1k=outBank1[j] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
          assign outData2k=outBank2[j] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
      end
  endgenerate

  assign outData0=outFound0 ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
  assign outData1=outFound1 ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
  assign outData2=outFound2 ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
  
endmodule

module rs_nonWakeUp_datad_DFF(
  clk,rst,stall,
  data_q,
  data_d,
  newRsSelect0,newData0,
  newRsSelect1,newData1,
  newRsSelect2,newData2
  );

  parameter WIDTH=32;
  
  input clk;
  input rst;
  input stall;
  output reg [WIDTH-1:0] data_q;
  output [WIDTH-1:0] data_d;
  input newRsSelect0;
  input [WIDTH-1:0] newData0;
  input newRsSelect1;
  input [WIDTH-1:0] newData1;
  input newRsSelect2;
  input [WIDTH-1:0] newData2;

  wire data_en;


  assign data_en=|{newRsSelect0,newRsSelect1,newRsSelect2,rst};

  assign data_d=(newRsSelect0 & ~rst & ~stall) ? ~newData0 : {WIDTH{1'bz}};
  assign data_d=(newRsSelect1 & ~rst & ~stall) ? ~newData1 : {WIDTH{1'bz}};
  assign data_d=(newRsSelect2 & ~rst & ~stall) ? ~newData2 : {WIDTH{1'bz}};

  assign data_d=rst ? {WIDTH{1'b1}} : {WIDTH{1'bz}};

  assign data_d=(data_en & ~stall) ? {WIDTH{1'bz}} : data_q;

  always @(posedge clk)
    begin
      data_q<=data_d;
    end
    
endmodule




module rs_buf(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newANeeded0,newBNeeded0,newSNeeded0,newRsSelect0,newPort0,
  newANeeded1,newBNeeded1,newSNeeded1,newRsSelect1,newPort1,
  newANeeded2,newBNeeded2,newSNeeded2,newRsSelect2,newPort2,
// wires to get values out of buffer
  outRsSelect0,portReady0,outDataEn0,outThread0,//agu
  outRsSelect1,portReady1,outDataEn1,outThread1,//alu 1
  outRsSelect2,portReady2,outDataEn2,outThread2,//alu 2
  fuFwdA,fuFwdB,
  isDataA,isDataB,isDataS,
// 1 if buffer is free  
  bufFree
);
  localparam DATA_WIDTH=`alu_width;
  localparam REG_WIDTH=`reg_addr_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam LSQ_WIDTH=`lsqRsNo_width;
  localparam CONST_WIDTH=64;
  localparam FLAGS_WIDTH=`flags_width;
  localparam ROB_WIDTH=10;  
  
  input clk;
  input dataRst;
  input nonDataRst;
  input rst_thread;
  input stall;
  input FU0Hit;
  input FU1Hit;
  input FU2Hit;
  input FU3Hit;
  input new_thread;
//Input of new data from registeres
  input newANeeded0;
  input newBNeeded0;
  input newSNeeded0;
  input newRsSelect0;
  input [3:0] newPort0;

  input newANeeded1;
  input newBNeeded1;
  input newSNeeded1;
  input newRsSelect1;
  input [3:0] newPort1;  

  input newANeeded2;
  input newBNeeded2;
  input newSNeeded2;
  input newRsSelect2;
  input [3:0] newPort2;  

// output data to functional units

  input outRsSelect0;
  output wire portReady0;
  output [3:0] outDataEn0;
  output outThread0;
    
  input outRsSelect1;
  output wire portReady1;
  output [3:0] outDataEn1;
  output outThread1;

  input outRsSelect2;
  output wire portReady2;
  output [3:0] outDataEn2;
  output outThread2;

  input [3:0] fuFwdA;
  input [3:0] fuFwdB;

  input isDataA;
  input isDataB;
  input isDataS;

// free output
  output wire bufFree;
// wires
// wires - new data
  
  

  wire portReady0_d;
  wire portReady0_q;

  wire portReady1_d;
  wire portReady1_q;

  wire portReady2_d;
  wire portReady2_q;

 

  wire [3:0] portNo_new;

  wire port0_d;
  wire port0_en;
  wire port0_q;

  wire port1_d;
  wire port1_en;
  wire port1_q;

  wire port2_d;
  wire port2_en;
  wire port2_q;

 

  wire [REG_WIDTH-1:0] regA_q;
  wire [REG_WIDTH-1:0] regA_d;

  wire [REG_WIDTH-1:0] regB_q;
  wire [REG_WIDTH-1:0] regB_d;

  wire [REG_WIDTH-1:0] regS_q;
  wire [REG_WIDTH-1:0] regS_d;


  wire newRsSelectAny=newRsSelect0 | newRsSelect1 | newRsSelect2;

  wire dataAPending_en;
  wire dataAPending_d;
  wire dataAPending_q;
  wire dataAPending_gather;
  wire dataAPending_new;

  wire dataBPending_en;
  wire dataBPending_d;
  wire dataBPending_q;
  wire dataBPending_gather;
  wire dataBPending_new;

  wire dataSPending_en;
  wire dataSPending_d;
  wire dataSPending_q;
  wire dataSPending_gather;
  wire dataSPending_new;
 
// wires - end new data

// wires - gather data
  wire isReady;
// wires - free bit
  wire bufFree_d;
  wire bufFree_en;
  
  wire stall_n;
  
  
  wire unFwdCheck;
  wire fwdCheck0;
  wire fwdCheck1;
  wire fwdCheck2;
  wire fwdCheck3;

  wire unCheckA;
  wire unCheckB;

  wire forgetUpdate;
  
  wire thread_q;
  wire FP_q;
  wire Vec_q;
  
  wire nonDataRst0;
  
  wire new_stall_n;
    
  assign stall_n=~stall;  
  assign nonDataRst0=(rst_thread) ? nonDataRst & thread_q || dataRst : nonDataRst &~thread_q || dataRst;
//new data input into buffer 
  assign new_stall_n=~(newRsSelectAny & stall);


  DFF thread_mod(clk,newRsSelectAny|dataRst,new_thread&~dataRst,thread_q);
  DFF FP_mod(clk,newRsSelectAny|dataRst,portNo_new[3]&~dataRst,FP_q);
  DFF Vec_mod(clk,newRsSelectAny|dataRst,portNo_new[2]&~dataRst,Vec_q);
  
  DFF dataAPending_mod(clk,dataAPending_en,dataAPending_d,dataAPending_q);
  DFF dataBPending_mod(clk,dataBPending_en,dataBPending_d,dataBPending_q);
  DFF dataSPending_mod(clk,dataSPending_en,dataSPending_d,dataSPending_q);
  
  DFF port0_mod(clk,port0_en,port0_d,port0_q);
  DFF port1_mod(clk,port1_en,port1_d,port1_q); 
  DFF port2_mod(clk,port2_en,port2_d,port2_q);
  
  DFF portReady0_mod(clk,1'b1,portReady0_d,portReady0_q);
  DFF portReady1_mod(clk,1'b1,portReady1_d,portReady1_q);
  DFF portReady2_mod(clk,1'b1,portReady2_d,portReady2_q);
  
  assign dataAPending_gather=isDataA;
  assign dataBPending_gather=isDataB;
  assign dataSPending_gather=isDataS;

  assign fwdCheck0=fuFwdA==4'd0 || fuFwdB==4'd0; 
  assign fwdCheck1=fuFwdA==4'd1 || fuFwdB==4'd1; 
  assign fwdCheck2=fuFwdA==4'd2 || fuFwdB==4'd2;   
  assign fwdCheck3=fuFwdA==4'd3 || fuFwdB==4'd3;   

  assign unFwdCheck=fwdCheck0 & ~FU0Hit || fwdCheck1 & ~FU1Hit || fwdCheck2 & ~FU2Hit || fwdCheck3 & ~FU3Hit;

  assign portReady0=portReady0_q;
  assign portReady1=portReady1_q;
  assign portReady2=portReady2_q;
  
  assign unCheckA=(fuFwdA==4'd0 && ~FU0Hit) | (fuFwdA==4'd1 && ~FU1Hit) | (fuFwdA==4'd2 && ~FU2Hit) | (fuFwdA==4'd3 && ~FU3Hit);
  assign unCheckB=(fuFwdB==4'd0 && ~FU0Hit) | (fuFwdB==4'd1 && ~FU1Hit) | (fuFwdB==4'd2 && ~FU2Hit) | (fuFwdB==4'd3 && ~FU3Hit);

  assign portNo_new=(newRsSelect0 & ~stall) ? newPort0 : 4'bz;
  assign portNo_new=(newRsSelect1 & ~stall) ? newPort1 : 4'bz;
  assign portNo_new=(newRsSelect2 & ~stall) ? newPort2 : 4'bz;
  assign portNo_new=(newRsSelectAny & ~stall) ? 4'bz : 4'b0;


  assign port0_en=stall_n & newRsSelectAny || outRsSelect0 &~unFwdCheck || nonDataRst0;
  assign port1_en=stall_n & newRsSelectAny || outRsSelect1 &~unFwdCheck || nonDataRst0;
  assign port2_en=stall_n & newRsSelectAny || outRsSelect2 &~unFwdCheck || nonDataRst0;
  assign port0_d=newRsSelectAny ? (portNo_new[1:0]==2'd0) & ~nonDataRst0 :
    port0_q & (~outRsSelect0  | unFwdCheck)  & ~nonDataRst0;
  assign port1_d=newRsSelectAny ? (portNo_new[1:0]==2'd1) & ~nonDataRst0 :
    port1_q & (~outRsSelect1 | unFwdCheck)  & ~nonDataRst0;
  assign port2_d=newRsSelectAny ? (portNo_new[1:0]==2'd2) & ~nonDataRst0 : 
    port2_q & (~outRsSelect2 | unFwdCheck)  & ~nonDataRst0;
  


  assign dataAPending_new=(newRsSelect0 & ~stall) ? newANeeded0 : 1'bz;
  assign dataAPending_new=(newRsSelect1 & ~stall) ? newANeeded1 : 1'bz;
  assign dataAPending_new=(newRsSelect2 & ~stall) ? newANeeded2 : 1'bz;
  assign dataAPending_new=(newRsSelectAny & ~stall) ? 1'bz : 1'b0;
  
  assign dataAPending_en=newRsSelectAny | nonDataRst0 | unCheckA || dataAPending_gather ;
  assign dataAPending_d=newRsSelectAny ? dataAPending_new & ~nonDataRst0 & stall_n & ~dataAPending_gather:
    (~dataAPending_gather & dataAPending_q || unCheckA) & ~nonDataRst0;
  
  assign dataBPending_new=(newRsSelect0 & ~stall) ? newBNeeded0 : 1'bz;
  assign dataBPending_new=(newRsSelect1 & ~stall) ? newBNeeded1 : 1'bz;
  assign dataBPending_new=(newRsSelect2 & ~stall) ? newBNeeded2 : 1'bz;
  assign dataBPending_new=(newRsSelectAny & ~stall) ? 1'bz : 1'b0;

  assign dataBPending_en=newRsSelectAny  | nonDataRst0 | unCheckB || dataBPending_gather;
  assign dataBPending_d=newRsSelectAny ? dataBPending_new & ~nonDataRst0 & stall_n & ~dataBPending_gather:
    (~dataBPending_gather & dataBPending_q || unCheckB) & ~nonDataRst0;


  assign dataSPending_new=(newRsSelect0 & ~stall) ? newSNeeded0 : 1'bz;
  assign dataSPending_new=(newRsSelect1 & ~stall) ? newSNeeded1 : 1'bz;
  assign dataSPending_new=(newRsSelect2 & ~stall) ? newSNeeded2 : 1'bz;
  assign dataSPending_new=(newRsSelectAny & ~stall) ? 1'bz : 1'b0;

  assign dataSPending_en=newRsSelectAny  | nonDataRst0 || dataSPending_gather;
  assign dataSPending_d=newRsSelectAny ? dataSPending_new & ~nonDataRst0 & stall_n & ~dataSPending_gather:
    (~dataSPending_gather & dataSPending_q) & ~nonDataRst0;
	
// end new data input into buffer

// output from buffer

//outputs use inverting 3-state buffer, because it's faster and smaller than non-inverting
// issue port 0 -agu
  assign outDataEn0=outRsSelect0 ? {4{~unFwdCheck}} &{FP_q,Vec_q,~FP_q&~Vec_q,1'b1} : 4'bz;
  assign outThread0=outRsSelect0 ? thread_q : 1'bz;
  
// issue port 1 - alu 1
  assign outDataEn1=outRsSelect1 ? {4{~unFwdCheck}} &{FP_q,Vec_q,~FP_q&~Vec_q,1'b1} : 4'bz;
  assign outThread1=outRsSelect1 ? thread_q : 1'bz;
 
  
// issue port 2 - alu 2
  assign outDataEn2=outRsSelect2 ? {4{~unFwdCheck}} &{FP_q,Vec_q,~FP_q&~Vec_q,1'b1} : 4'bz;
  assign outThread2=outRsSelect2 ? thread_q : 1'bz;


// end data output


//  assign isReady=~dataAPending_d & ~dataBPending_d & ~dataDPending_d & ~dataSPending_d;

  assign isReady=dataAPending_gather | ~dataAPending_d && dataBPending_gather | ~dataBPending_d && 
    dataSPending_gather | ~dataSPending_d;
  
  assign portReady0_d=isReady & port0_d & ~unFwdCheck & new_stall_n;
  assign portReady1_d=isReady & port1_d & ~unFwdCheck & new_stall_n;
  assign portReady2_d=isReady & port2_d & ~unFwdCheck & new_stall_n;

// free bit
  DFF bufFree_mod(clk,bufFree_en,bufFree_d,bufFree);
  
  assign bufFree_en=stall_n & newRsSelectAny || (outRsSelect0 | outRsSelect1 | outRsSelect2
    && ~unFwdCheck) || nonDataRst0;
  assign bufFree_d=~newRsSelectAny || nonDataRst0;
  
endmodule





module rs_array(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newANeeded0,newBNeeded0,newSNeeded0,newRsSelect0,newPort0,
  newANeeded1,newBNeeded1,newSNeeded1,newRsSelect1,newPort1,
  newANeeded2,newBNeeded2,newSNeeded2,newRsSelect2,newPort2,
// wires to get values out of buffer
  outRsSelect0,outRsBank0,outFound0,portReady0,outDataEn0,outThread0,//agu
  outRsSelect1,outRsBank1,outFound1,portReady1,outDataEn1,outThread1,//alu 1
  outRsSelect2,outRsBank2,outFound2,portReady2,outDataEn2,outThread2,//alu 2
  fuFwdA,fuFwdB,
  isDataA,isDataB,isDataS,
// 1 if buffer is free  
  bufFree
);
  localparam DATA_WIDTH=`alu_width;
  localparam REG_WIDTH=`reg_addr_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam LSQ_WIDTH=`lsqRsNo_width;
  localparam CONST_WIDTH=64;
  localparam FLAGS_WIDTH=`flags_width;
  localparam ROB_WIDTH=10;  
  localparam BUF_COUNT=32;
  
  input clk;
  input dataRst;
  input nonDataRst;
  input rst_thread;
  input stall;
  input FU0Hit;
  input FU1Hit;
  input FU2Hit;
  input FU3Hit;
  input new_thread;
//Input of new data from registeres
  input newANeeded0;
  input newBNeeded0;
  input newSNeeded0;
  input [BUF_COUNT-1:0] newRsSelect0;
  input [3:0] newPort0;

  input newANeeded1;
  input newBNeeded1;
  input newSNeeded1;
  input [BUF_COUNT-1:0] newRsSelect1;
  input [3:0] newPort1;  

  input newANeeded2;
  input newBNeeded2;
  input newSNeeded2;
  input [BUF_COUNT-1:0] newRsSelect2;
  input [3:0] newPort2;  

// output data to functional units

  input [BUF_COUNT-1:0] outRsSelect0;
  input [3:0] outRsBank0;
  input outFound0;
  output [BUF_COUNT-1:0] portReady0;
  output [3:0] outDataEn0;
  output outThread0;
    
  input [BUF_COUNT-1:0] outRsSelect1;
  input [3:0] outRsBank1;
  input outFound1;
  output [BUF_COUNT-1:0] portReady1;
  output [3:0] outDataEn1;
  output outThread1;

  input [BUF_COUNT-1:0] outRsSelect2;
  input [3:0] outRsBank2;
  input outFound2;
  output [BUF_COUNT-1:0] portReady2;
  output [3:0] outDataEn2;
  output outThread2;

  input [BUF_COUNT*4-1:0] fuFwdA;
  input [BUF_COUNT*4-1:0] fuFwdB;

  input [BUF_COUNT-1:0] isDataA;
  input [BUF_COUNT-1:0] isDataB;
  input [BUF_COUNT-1:0] isDataS;

// free output
  output [BUF_COUNT-1:0]  bufFree;
// wires
// wires - new data
  generate
      genvar k,j;
      for (j=0;j<4;j=j+1) begin : banks_gen
          wire [3:0] outDataEn0a;
          wire [3:0] outDataEn1a;
          wire [3:0] outDataEn2a;
          wire outThread0a;
          wire outThread1a;
          wire outThread2a;
      for(k=0;k<8;k=k+1) begin : buffers_gen
          rs_buf buf_mod(
          clk,
          dataRst,nonDataRst,rst_thread,
          stall,
          FU0Hit,FU1Hit,FU2Hit,FU3Hit,
          new_thread,
// wires to store new values in a buffer
          newANeeded0,newBNeeded0,newSNeeded0,newRsSelect0[j*8+k],newPort0,
          newANeeded1,newBNeeded1,newSNeeded1,newRsSelect1[j*8+k],newPort1,
          newANeeded2,newBNeeded2,newSNeeded2,newRsSelect2[j*8+k],newPort2,
// wires to get values out of buffer
          outRsSelect0[j*8+k],portReady0[j*8+k],outDataEn0a,outThread0a,//agu
          outRsSelect1[j*8+k],portReady1[j*8+k],outDataEn1a,outThread1a,//alu 1
          outRsSelect2[j*8+k],portReady2[j*8+k],outDataEn2a,outThread2a,//alu 2
          fuFwdA[(j*8+k)*4+:4],fuFwdB[(j*8+k)*4+:4],
          isDataA[j*8+k],isDataB[j*8+k],isDataS[j*8+k],
// 1 if buffer is free  
          bufFree[j*8+k]
          );
      end
      assign outDataEn0a=outRsBank0[j] ? 4'bz : 4'b0;
      assign outDataEn1a=outRsBank1[j] ? 4'bz : 4'b0;
      assign outDataEn2a=outRsBank2[j] ? 4'bz : 4'b0;
      assign outDataEn0=outRsBank0[j] ? outDataEn0a : 4'bz;
      assign outDataEn1=outRsBank1[j] ? outDataEn1a : 4'bz;
      assign outDataEn2=outRsBank2[j] ? outDataEn2a : 4'bz;
      assign outThread0a=outRsBank0[j] ? 1'bz : 1'b0;
      assign outThread1a=outRsBank1[j] ? 1'bz : 1'b0;
      assign outThread2a=outRsBank2[j] ? 1'bz : 1'b0;
      assign outThread0=outRsBank0[j] ? outThread0a : 1'bz;
      assign outThread1=outRsBank1[j] ? outThread1a : 1'bz;
      assign outThread2=outRsBank2[j] ? outThread2a : 1'bz;
      end
  endgenerate

  assign outDataEn0=outFound0 ? 4'bz : 4'b0;
  assign outDataEn1=outFound1 ? 4'bz : 4'b0;
  assign outDataEn2=outFound2 ? 4'bz : 4'b0;

  assign outThread0=outFound0 ? 1'bz : 1'b0;
  assign outThread1=outFound1 ? 1'bz : 1'b0;
  assign outThread2=outFound2 ? 1'bz : 1'b0;

endmodule




module rs(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall,
  doStall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newDataA0,newDataB0,newDataC0,newRegA0,newRegB0,
    newANeeded0,newBNeeded0,newReg0,newOp0,newPort0,newInstrIndex0,newLSQ0,
    rsAlloc0,newGazumpA0,newGazumpB0,newFunitA0,newFunitB0,newWQ0,newLSFlag0,
    newAttr0,
  newDataA1,newDataB1,newDataC1,newDataS1,newRegA1,newRegB1,newRegS1,
    newANeeded1,newBNeeded1,newSNeeded1,newReg1,newRegSimd1,newOp1,newPort1,
    newInstrIndex1,newLSQ1,rsAlloc1,newGazumpA1,newGazumpB1,newGazumpS1,
    newFunitA1,newFunitB1,newFunitS1,newLSFlag1,newAttr1,
  newDataA2,newDataB2,newDataC2,newDataS2,newRegA2,newRegB2,newRegS2,
    newANeeded2,newBNeeded2,newSNeeded2,newReg2,newRegSimd2,newOp2,newPort2,
    newInstrIndex2,rsAlloc2,newGazumpA2,newGazumpB2,newGazumpS2,
    newFunitA2,newFunitB2,newFunitS2,newAttr2,
// wires to get values out of buffer
  outDataA0,outDataB0,outDataC0,outReg0,outOp0,outInstrIndex0,outWQ0,outLSFlag0,
    outFuFwdA0,outFuFwdB0,outFuuFwdA0,outFuuFwdB0,outLSQ0,outDataEn0,outThread0,//agu
    outAttr0,
  outDataA1,outDataB1,outDataC1,outDataS1,outReg1,outRegSimd1,outOp1,outInstrIndex1,
    outFuFwdA1,outFuFwdB1,outFuFwdS1,outFuuFwdA1,outFuuFwdB1,
    outFuuFwdS1,outDataEn1,outThread1,outAttr1,//alu 1
  outDataA2,outDataB2,outDataC2,outDataS2,outReg2,outRegSimd2,outOp2,outInstrIndex2,
    outFuFwdA2,outFuFwdB2,outFuFwdS2,outFuuFwdA2,outFuuFwdB2,
    outFuuFwdS2,outDataEn2,outThread2,outAttr2,//alu 2
// wires from functional units  
  FU0,FUreg0,FUwen0,
  FU1,FUreg1,FUwen1,
  FU2,FUreg2,FUwen2,
  FU3,FUreg3,FUwen3,
  FU4,FUreg4,FUwen4,
  FU5,FUreg5,FUwen5,
  FU6,FUreg6,FUwen6,
  FU7,FUreg7,FUwen7,
  FU8,FUreg8,FUwen8,
  FU9,FUreg9,FUwen9,
        
  outRsSelectR_reg,outBankR_reg,rsFoundNZR_reg,
  newRsSelect1R_reg,newRsSelect2R_reg,

  newDataVA1H,newDataVB1H,newDataVA1L,newDataVB1L,
  newDataVA2H,newDataVB2H,newDataVA2L,newDataVB2L,

  newDataFA1H,newDataFB1H,newDataFA1L,newDataFB1L,
  newDataFA2H,newDataFB2H,newDataFA2L,newDataFB2L,

  outDataVA1H,outDataVB1H,outDataVA1L,outDataVB1L,
  outDataVA2H,outDataVB2H,outDataVA2L,outDataVB2L,

  outDataFA1H,outDataFB1H,outDataFA1L,outDataFB1L,
  outDataFA2H,outDataFB2H,outDataFA2L,outDataFB2L,

  newDataVL1H,newDataVR1H,newDataVL1L,newDataVR1L,
  newDataVL2H,newDataVR2H,newDataVL2L,newDataVR2L,

  newDataFL1H,newDataFR1H,newDataFL1L,newDataFR1L,
  newDataFL2H,newDataFR2H,newDataFL2L,newDataFR2L,

  outDataVL1H,outDataVR1H,outDataVL1L,outDataVR1L,
  outDataVL2H,outDataVR2H,outDataVL2L,outDataVR2L,

  outDataFL1H,outDataFR1H,outDataFL1L,outDataFR1L,
  outDataFL2H,outDataFR2H,outDataFL2L,outDataFR2L,

  outEqR_reg,

  FUV0H,FUV0L,
  FUV1H,FUV1L,
  FUV2H,FUV2L,
  FUV3H,FUV3L,
  FUV4H,FUV4L,
  FUV5H,FUV5L,
  FUV6H,FUV6L,
  FUV7H,FUV7L,
  FUV8H,FUV8L,
  FUV9H,FUV9L,
  
  FUF0H,FUF0L,
  FUF1H,FUF1L,
  FUF2H,FUF2L,
  FUF3H,FUF3L,
  FUF4H,FUF4L,
  FUF5H,FUF5L,
  FUF6H,FUF6L,
  FUF7H,FUF7L,
  FUF8H,FUF8L,
  FUF9H,FUF9L,

  FUS0,FUS1,FUS2,
  FUS3,FUS4,FUS5,
  FUS6,FUS7,FUS8,
  FUSreg0,FUSwen0,
  FUSreg1,FUSwen1,
  FUSreg2,FUSwen2,
  FUSreg3,FUSwen3,
  FUSreg4,FUSwen4,
  FUSreg5,FUSwen5,
  FUSreg6,FUSwen6,
  FUSreg7,FUSwen7,
  FUSreg8,FUSwen8,
// 1 if buffer is free  
  pause0,foundAlt1,foundAlt2
);
  localparam DATA_WIDTH=`alu_width+1;
  localparam SIMD_WIDTH=68;//half-width
  localparam REG_WIDTH=`reg_addr_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam LSQ_WIDTH=`lsqRsNo_width;
  localparam CONST_WIDTH=65;
  localparam FLAGS_WIDTH=6;  
  localparam BUF_COUNT=`rs_buf_count;
  localparam II_WIDTH=10;  
  localparam FN_WIDTH=10;
  localparam WQ_WIDTH=6;
  localparam ATTR_WIDTH=4;
  parameter [0:0] odd=1'b0;
  
  input clk;
  input dataRst;
  input nonDataRst;
  input rst_thread;
  input stall;
  output doStall;
  input FU0Hit;
  input FU1Hit;
  input FU2Hit;
  input FU3Hit;
//Input of new data from registeres
  input new_thread;
  input [DATA_WIDTH-1:0]       newDataA0;
  input [DATA_WIDTH-1:0]       newDataB0;
  input [CONST_WIDTH-1:0]       newDataC0;
  input [REG_WIDTH-1:0] newRegA0; 
  input [REG_WIDTH-1:0] newRegB0; 
  input newANeeded0;
  input newBNeeded0;
  input [REG_WIDTH-1:0] newReg0;
  input [OPERATION_WIDTH-1:0]   newOp0;
  input [3:0] newPort0;
  input [II_WIDTH-1:0] newInstrIndex0;  
  input [LSQ_WIDTH-1:0] newLSQ0;
  input rsAlloc0;
  input [10:0] newGazumpA0;
  input [10:0] newGazumpB0;
  input [FN_WIDTH-1:0] newFunitA0;
  input [FN_WIDTH-1:0] newFunitB0;
  input [WQ_WIDTH-1:0] newWQ0;
  input newLSFlag0;
  input [ATTR_WIDTH-1:0] newAttr0;

  input [DATA_WIDTH-1:0]       newDataA1;
  input [DATA_WIDTH-1:0]       newDataB1;
  input [CONST_WIDTH-1:0]       newDataC1;
  input [FLAGS_WIDTH-1:0]       newDataS1;
  input [REG_WIDTH-1:0] newRegA1; 
  input [REG_WIDTH-1:0] newRegB1; 
  input [REG_WIDTH-1:0] newRegS1; 
  input newANeeded1;
  input newBNeeded1;
  input newSNeeded1;
  input [REG_WIDTH-1:0] newReg1;
  input [REG_WIDTH-1:0] newRegSimd1;
  input [OPERATION_WIDTH-1:0]   newOp1;
  input [3:0] newPort1;  
  input [II_WIDTH-1:0] newInstrIndex1;
  input [LSQ_WIDTH-1:0] newLSQ1;
  input rsAlloc1;
  input [10:0] newGazumpA1;
  input [10:0] newGazumpB1;
  input [10:0] newGazumpS1;
  input [FN_WIDTH-1:0] newFunitA1;
  input [FN_WIDTH-1:0] newFunitB1;
  input [FN_WIDTH-1:0] newFunitS1;
  input newLSFlag1;
  input [ATTR_WIDTH-1:0] newAttr1;

  input [DATA_WIDTH-1:0]       newDataA2;
  input [DATA_WIDTH-1:0]       newDataB2;
  input [FLAGS_WIDTH-1:0]       newDataS2;
  input [CONST_WIDTH-1:0]       newDataC2;
  input [REG_WIDTH-1:0] newRegA2; 
  input [REG_WIDTH-1:0] newRegB2; 
  input [REG_WIDTH-1:0] newRegS2; 
  input newANeeded2;
  input newBNeeded2;
  input newSNeeded2;
  input [REG_WIDTH-1:0] newReg2;
  input [REG_WIDTH-1:0] newRegSimd2;
  input [OPERATION_WIDTH-1:0]   newOp2;
  input [3:0] newPort2;  
  input [II_WIDTH-1:0] newInstrIndex2;
  input rsAlloc2;
  input [10:0] newGazumpA2;
  input [10:0] newGazumpB2;
  input [10:0] newGazumpS2;
  input [FN_WIDTH-1:0] newFunitA2;
  input [FN_WIDTH-1:0] newFunitB2;
  input [FN_WIDTH-1:0] newFunitS2;
  input [ATTR_WIDTH-1:0] newAttr2;
  
// output data to functional units

  output wire [DATA_WIDTH-1:0]       outDataA0;
  output wire [DATA_WIDTH-1:0]       outDataB0;//b USED AS BASE REG
  output wire [CONST_WIDTH-1:0]       outDataC0;
  output wire [REG_WIDTH-1:0] outReg0;
  output wire [OPERATION_WIDTH-1:0]   outOp0;
  output wire [II_WIDTH-1:0] outInstrIndex0;
  output wire [WQ_WIDTH-1:0] outWQ0;
  output outLSFlag0;
  output [3:0] outFuFwdA0;
  output [3:0] outFuFwdB0;
  output [3:0] outFuuFwdA0;
  output [3:0] outFuuFwdB0;
  output [LSQ_WIDTH-1:0] outLSQ0;
  output [3:0] outDataEn0;
  output outThread0;
  output [ATTR_WIDTH-1:0] outAttr0;
    
  output wire [DATA_WIDTH-1:0]       outDataA1;
  output wire [DATA_WIDTH-1:0]       outDataB1;
  output wire [CONST_WIDTH-1:0]       outDataC1;
  output wire [FLAGS_WIDTH-1:0]       outDataS1;
  output wire [REG_WIDTH-1:0] outReg1;
  output wire [REG_WIDTH-1:0] outRegSimd1;
  output wire [OPERATION_WIDTH-1:0]   outOp1;
  output wire [II_WIDTH-1:0] outInstrIndex1;
  output [3:0] outFuFwdA1;
  output [3:0] outFuFwdB1;
  output [3:0] outFuFwdS1;
  output [3:0] outFuuFwdA1;
  output [3:0] outFuuFwdB1;
  output [3:0] outFuuFwdS1;
  output [3:0] outDataEn1;
  output outThread1;
  output [ATTR_WIDTH-1:0] outAttr1;

  output wire [DATA_WIDTH-1:0]       outDataA2;
  output wire [DATA_WIDTH-1:0]       outDataB2;
  output wire [CONST_WIDTH-1:0]       outDataC2;
  output wire [FLAGS_WIDTH-1:0]       outDataS2;
  output wire [REG_WIDTH-1:0] outReg2;
  output wire [REG_WIDTH-1:0] outRegSimd2;
  output wire [OPERATION_WIDTH-1:0]   outOp2;
  output wire [II_WIDTH-1:0] outInstrIndex2;
  output [3:0] outFuFwdA2;
  output [3:0] outFuFwdB2;
  output [3:0] outFuFwdS2;
  output [3:0] outFuuFwdA2;
  output [3:0] outFuuFwdB2;
  output [3:0] outFuuFwdS2;
  output [3:0] outDataEn2;
  output outThread2;
  output [ATTR_WIDTH-1:0] outAttr2;

  

//functional units inputs/outputs
  input [DATA_WIDTH-1:0] FU0;
  input [REG_WIDTH-1:0] FUreg0;
  input FUwen0;
  
  input [DATA_WIDTH-1:0] FU1;
  input [REG_WIDTH-1:0] FUreg1;
  input FUwen1;

  input [DATA_WIDTH-1:0] FU2;
  input [REG_WIDTH-1:0] FUreg2;
  input FUwen2;

  input [DATA_WIDTH-1:0] FU3;
  input [REG_WIDTH-1:0] FUreg3;
  input FUwen3;

  input [DATA_WIDTH-1:0] FU4;
  input [REG_WIDTH-1:0] FUreg4;
  input FUwen4;

  input [DATA_WIDTH-1:0] FU5;
  input [REG_WIDTH-1:0] FUreg5;
  input FUwen5;

  input [DATA_WIDTH-1:0] FU6;
  input [REG_WIDTH-1:0] FUreg6;
  input FUwen6;

  input [DATA_WIDTH-1:0] FU7;
  input [REG_WIDTH-1:0] FUreg7;
  input FUwen7;

  input [DATA_WIDTH-1:0] FU8;
  input [REG_WIDTH-1:0] FUreg8;
  input FUwen8;

  input [DATA_WIDTH-1:0] FU9;
  input [REG_WIDTH-1:0] FUreg9;
  input FUwen9;
  
//SIMD
  input [SIMD_WIDTH-1:0] newDataVA1H;
  input [SIMD_WIDTH-1:0] newDataVB1H;
  input [SIMD_WIDTH-1:0] newDataVA1L;
  input [SIMD_WIDTH-1:0] newDataVB1L;
  
  input [SIMD_WIDTH-1:0] newDataVA2H;
  input [SIMD_WIDTH-1:0] newDataVB2H;
  input [SIMD_WIDTH-1:0] newDataVA2L;
  input [SIMD_WIDTH-1:0] newDataVB2L;
  
  input [SIMD_WIDTH-1:0] newDataFA1H;
  input [SIMD_WIDTH-1:0] newDataFB1H;
  input [16+SIMD_WIDTH-1:0] newDataFA1L;
  input [16+SIMD_WIDTH-1:0] newDataFB1L;
  
  input [SIMD_WIDTH-1:0] newDataFA2H;
  input [SIMD_WIDTH-1:0] newDataFB2H;
  input [16+SIMD_WIDTH-1:0] newDataFA2L;
  input [16+SIMD_WIDTH-1:0] newDataFB2L;
  
  output [SIMD_WIDTH-1:0] outDataVA1H;
  output [SIMD_WIDTH-1:0] outDataVB1H;
  output [SIMD_WIDTH-1:0] outDataVA1L;
  output [SIMD_WIDTH-1:0] outDataVB1L;
  
  output [SIMD_WIDTH-1:0] outDataVA2H;
  output [SIMD_WIDTH-1:0] outDataVB2H;
  output [SIMD_WIDTH-1:0] outDataVA2L;
  output [SIMD_WIDTH-1:0] outDataVB2L;
  
  output [SIMD_WIDTH-1:0] outDataFA1H;
  output [SIMD_WIDTH-1:0] outDataFB1H;
  output [16+SIMD_WIDTH-1:0] outDataFA1L;
  output [16+SIMD_WIDTH-1:0] outDataFB1L;
  
  output [SIMD_WIDTH-1:0] outDataFA2H;
  output [SIMD_WIDTH-1:0] outDataFB2H;
  output [16+SIMD_WIDTH-1:0] outDataFA2L;
  output [16+SIMD_WIDTH-1:0] outDataFB2L;
  
  input [SIMD_WIDTH-1:0] newDataVL1H;
  input [SIMD_WIDTH-1:0] newDataVR1H;
  input [SIMD_WIDTH-1:0] newDataVL1L;
  input [SIMD_WIDTH-1:0] newDataVR1L;
  
  input [SIMD_WIDTH-1:0] newDataVL2H;
  input [SIMD_WIDTH-1:0] newDataVR2H;
  input [SIMD_WIDTH-1:0] newDataVL2L;
  input [SIMD_WIDTH-1:0] newDataVR2L;
  
  input [SIMD_WIDTH-1:0] newDataFL1H;
  input [SIMD_WIDTH-1:0] newDataFR1H;
  input [16+SIMD_WIDTH-1:0] newDataFL1L;
  input [16+SIMD_WIDTH-1:0] newDataFR1L;
  
  input [SIMD_WIDTH-1:0] newDataFL2H;
  input [SIMD_WIDTH-1:0] newDataFR2H;
  input [16+SIMD_WIDTH-1:0] newDataFL2L;
  input [16+SIMD_WIDTH-1:0] newDataFR2L;
  
  output [SIMD_WIDTH-1:0] outDataVL1H;
  output [SIMD_WIDTH-1:0] outDataVR1H;
  output [SIMD_WIDTH-1:0] outDataVL1L;
  output [SIMD_WIDTH-1:0] outDataVR1L;
  
  output [SIMD_WIDTH-1:0] outDataVL2H;
  output [SIMD_WIDTH-1:0] outDataVR2H;
  output [SIMD_WIDTH-1:0] outDataVL2L;
  output [SIMD_WIDTH-1:0] outDataVR2L;
  
  output [SIMD_WIDTH-1:0] outDataFL1H;
  output [SIMD_WIDTH-1:0] outDataFR1H;
  output [16+SIMD_WIDTH-1:0] outDataFL1L;
  output [16+SIMD_WIDTH-1:0] outDataFR1L;
  
  output [SIMD_WIDTH-1:0] outDataFL2H;
  output [SIMD_WIDTH-1:0] outDataFR2H;
  output [16+SIMD_WIDTH-1:0] outDataFL2L;
  output [16+SIMD_WIDTH-1:0] outDataFR2L;

  input [6*BUF_COUNT-1:0] outEqR_reg;
  
  input [2:1][BUF_COUNT-1:0] outRsSelectR_reg;
  input [2:1][3:0] outBankR_reg;
  input [2:1] rsFoundNZR_reg;
  input [BUF_COUNT-1:0] newRsSelect1R_reg;
  input [BUF_COUNT-1:0] newRsSelect2R_reg;
  
  input [SIMD_WIDTH-1:0] FUV0H;
  input [SIMD_WIDTH-1:0] FUV0L;
  
  input [SIMD_WIDTH-1:0] FUV1H;
  input [SIMD_WIDTH-1:0] FUV1L;
  
  input [SIMD_WIDTH-1:0] FUV2H;
  input [SIMD_WIDTH-1:0] FUV2L;
  
  input [SIMD_WIDTH-1:0] FUV3H;
  input [SIMD_WIDTH-1:0] FUV3L;
  
  input [SIMD_WIDTH-1:0] FUV4H;
  input [SIMD_WIDTH-1:0] FUV4L;
  
  input [SIMD_WIDTH-1:0] FUV5H;
  input [SIMD_WIDTH-1:0] FUV5L;
  
  input [SIMD_WIDTH-1:0] FUV6H;
  input [SIMD_WIDTH-1:0] FUV6L;
  
  input [SIMD_WIDTH-1:0] FUV7H;
  input [SIMD_WIDTH-1:0] FUV7L;
  
  input [SIMD_WIDTH-1:0] FUV8H;
  input [SIMD_WIDTH-1:0] FUV8L;
  
  input [SIMD_WIDTH-1:0] FUV9H;
  input [SIMD_WIDTH-1:0] FUV9L;
  
  input [SIMD_WIDTH-1:0] FUF0H;
  input [16+SIMD_WIDTH-1:0] FUF0L;
  
  input [SIMD_WIDTH-1:0] FUF1H;
  input [16+SIMD_WIDTH-1:0] FUF1L;
  
  input [SIMD_WIDTH-1:0] FUF2H;
  input [16+SIMD_WIDTH-1:0] FUF2L;
  
  input [SIMD_WIDTH-1:0] FUF3H;
  input [16+SIMD_WIDTH-1:0] FUF3L;
  
  input [SIMD_WIDTH-1:0] FUF4H;
  input [16+SIMD_WIDTH-1:0] FUF4L;
  
  input [SIMD_WIDTH-1:0] FUF5H;
  input [16+SIMD_WIDTH-1:0] FUF5L;
  
  input [SIMD_WIDTH-1:0] FUF6H;
  input [16+SIMD_WIDTH-1:0] FUF6L;
  
  input [SIMD_WIDTH-1:0] FUF7H;
  input [16+SIMD_WIDTH-1:0] FUF7L;
  
  input [SIMD_WIDTH-1:0] FUF8H;
  input [16+SIMD_WIDTH-1:0] FUF8L;
  
  input [SIMD_WIDTH-1:0] FUF9H;
  input [16+SIMD_WIDTH-1:0] FUF9L;
  
  
  
//FLAGS FU*
  input [FLAGS_WIDTH-1:0] FUS0;
  input [FLAGS_WIDTH-1:0] FUS1;
  input [FLAGS_WIDTH-1:0] FUS2;
  input [FLAGS_WIDTH-1:0] FUS3;
  input [FLAGS_WIDTH-1:0] FUS4;
  input [FLAGS_WIDTH-1:0] FUS5;
  input [FLAGS_WIDTH-1:0] FUS6;
  input [FLAGS_WIDTH-1:0] FUS7;
  input [FLAGS_WIDTH-1:0] FUS8;
  input [REG_WIDTH-1:0] FUSreg0;
  input FUSwen0;
  input [REG_WIDTH-1:0] FUSreg1;
  input FUSwen1;
  input [REG_WIDTH-1:0] FUSreg2;
  input FUSwen2;
  input [REG_WIDTH-1:0] FUSreg3;
  input FUSwen3;
  input [REG_WIDTH-1:0] FUSreg4;
  input FUSwen4;
  input [REG_WIDTH-1:0] FUSreg5;
  input FUSwen5;
  input [REG_WIDTH-1:0] FUSreg6;
  input FUSwen6;
  input [REG_WIDTH-1:0] FUSreg7;
  input FUSwen7;
  input [REG_WIDTH-1:0] FUSreg8;
  input FUSwen8;

  
  input pause0;
  input foundAlt1;
  input foundAlt2;

  wire [BUF_COUNT-1:0] bufFree;
  
  wire [BUF_COUNT-1:0] newRsSelect0;
  wire [BUF_COUNT-1:0] newRsSelect1;
  wire [BUF_COUNT-1:0] newRsSelect2;
  
  wire [2:0][BUF_COUNT-1:0] outRsSelect;
  wire [BUF_COUNT-1:0] portReady[2:0];
  wire [2:0][3:0] outBank;
  wire [2:0] portEn;
  wire [2:0] rsFound;
  wire [2:0] rsFoundNZ;
  
  wire [127:0] fuFwdA;
  wire [127:0] fuFwdB;
  wire [BUF_COUNT-1:0] isDataA;
  wire [BUF_COUNT-1:0] isDataB;
  wire [BUF_COUNT-1:0] isDataS;

  wire [FLAGS_WIDTH-1:0] outDataS0;
  wire [3:0] outFuFwdS0;
  wire [3:0] outFuuFwdS0;
  wire [127:0] fuFwdS;

  wire [SIMD_WIDTH-1:0] outDataFA1HP;
  wire [SIMD_WIDTH-1:0] outDataFB1HP;
//  wire [SIMD_WIDTH-1:0] outDataFA1UHP;
//  wire [SIMD_WIDTH-1:0] outDataFB1UHP;
  
  wire [6*BUF_COUNT-1:0] outEqA;
  wire [6*BUF_COUNT-1:0] outEqB;
  wire [6*BUF_COUNT-1:0]  outEqS;
  wire [6*BUF_COUNT-1:0] outEqL;
  wire [6*BUF_COUNT-1:0]  outEqS_reg;
  wire [6*BUF_COUNT-1:0] outEqA_reg;
  wire [6*BUF_COUNT-1:0] outEqB_reg;
  wire [6*BUF_COUNT-1:0] outEqA_reg2;
  wire [6*BUF_COUNT-1:0] outEqB_reg2;
  wire [6*BUF_COUNT-1:0] outEqL_reg2;
  wire [6*BUF_COUNT-1:0] outEqR_reg2;
  wire [6*BUF_COUNT-1:0] outEqA_reg3;
  wire [6*BUF_COUNT-1:0] outEqB_reg3;
  wire [BUF_COUNT-1:0] newRsSelect0_reg;
  wire [BUF_COUNT-1:0] newRsSelect1_reg;
  wire [BUF_COUNT-1:0] newRsSelect2_reg;
  wire [BUF_COUNT-1:0] outRsSelect_reg[2:1];
  wire [3:0] outBank_reg[2:1];
  wire [2:1] rsFound_reg;
  wire [2:1] rsFoundNZ_reg;
  wire [BUF_COUNT-1:0] newRsSelect0_reg2;
  wire [BUF_COUNT-1:0] newRsSelect1_reg2;
  wire [BUF_COUNT-1:0] newRsSelect2_reg2;
  wire [BUF_COUNT-1:0] newRsSelect1R_reg2;
  wire [BUF_COUNT-1:0] newRsSelect2R_reg2;
  wire [BUF_COUNT-1:0] outRsSelect_reg2[2:1];
  wire [3:0] outBank_reg2[2:1];
  wire [2:1] rsFound_reg2;
  wire [2:1] rsFoundNZ_reg2;
  wire [BUF_COUNT-1:0] outRsSelectR_reg2[2:1];
  wire [3:0] outBankR_reg2[2:1];
  wire [2:1] rsFoundNZR_reg2;
  
  
  wire [3:0] outFuFwdA1_reg;
  wire [3:0] outFuFwdB1_reg;
  wire [3:0] outFuuFwdA1_reg;
  wire [3:0] outFuuFwdB1_reg;

  wire op_swp,op_swp_reg,op_swp_reg2,op_swp_reg3;
 
  function op_fpswap;
      input [OPERATION_WIDTH-1:0] op;
      op_fpswap=op[12] && op[7:4]==4'b0;
  endfunction 
  rs_array rs_mod(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall|doStall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newANeeded0,newBNeeded0,1'b0,newRsSelect0,newPort0,
  newANeeded1,newBNeeded1,newSNeeded1,newRsSelect1,newPort1,
  newANeeded2,newBNeeded2,newSNeeded2,newRsSelect2,newPort2,
// wires to get values out of buffer
  outRsSelect[0],outBank[0],rsFoundNZ[0],portReady[0],outDataEn0,outThread0,//agu
  outRsSelect[1],outBank[1],rsFound[1],portReady[1],outDataEn1,outThread1,//alu 1
  outRsSelect[2],outBank[2],rsFoundNZ[2],portReady[2],outDataEn2,outThread2,//alu 2
  fuFwdA,fuFwdB,
  isDataA,isDataB,isDataS,
// 1 if buffer is free  
  bufFree
  );
 
//  assign op_swp=op_fpswap(outOp1); 

 // assign outDataFA1H=op_swp_reg2 ? outDataFB1HP : outDataFA1HP;
 // assign outDataFB1H=op_swp_reg2 ? outDataFA1HP : outDataFB1HP;

//  assign outFuFwdAH1=op_swp_reg ? outFuFwdB1_reg : outFuFwdA1_reg;
//  assign outFuFwdBH1=op_swp_reg ? outFuFwdA1_reg : outFuFwdB1_reg;
//  assign outFuuFwdAH1=op_swp_reg ? outFuuFwdB1_reg : outFuuFwdA1_reg;
//  assign outFuuFwdBH1=op_swp_reg ? outFuuFwdA1_reg : outFuuFwdB1_reg;

  DFF2 #(1) outSwp_mod(clk,dataRst,1'b1,op_swp,op_swp_reg);
  DFF2 #(1) out2Swp_mod(clk,dataRst,1'b1,op_swp_reg,op_swp_reg2);
  //DFF2 #(1) out3Swp_mod(clk,dataRst,1'b1,op_swp_reg2,op_swp_reg3);
  
  DFF2 #(4) outFuA1_mod(clk,dataRst,1'b1,outFuFwdA1,outFuFwdA1_reg);
  DFF2 #(4) outFuB1_mod(clk,dataRst,1'b1,outFuFwdB1,outFuFwdB1_reg);
  DFF2 #(4) outFuuA1_mod(clk,dataRst,1'b1,outFuuFwdA1,outFuuFwdA1_reg);
  DFF2 #(4) outFuuB1_mod(clk,dataRst,1'b1,outFuuFwdB1,outFuuFwdB1_reg);
  
  DFF2 #(32*6) outEqA_mod(clk,dataRst,1'b1,outEqA,outEqA_reg);
  DFF2 #(32*6) outEqB_mod(clk,dataRst,1'b1,outEqB,outEqB_reg);
  DFF2 #(32*6) outEqS_mod(clk,dataRst,1'b1,outEqS,outEqS_reg);

  DFF2 #(32) outNew0_mod(clk,dataRst,1'b1,newRsSelect0,newRsSelect0_reg);
  DFF2 #(32) outNew1_mod(clk,dataRst,1'b1,newRsSelect1,newRsSelect1_reg);
  DFF2 #(32) outNew2_mod(clk,dataRst,1'b1,newRsSelect2,newRsSelect2_reg);
  DFF2 #(32) outSel1_mod(clk,dataRst,1'b1,outRsSelect[1],outRsSelect_reg[1]);
  DFF2 #(32) outSel2_mod(clk,dataRst,1'b1,outRsSelect[2],outRsSelect_reg[2]);
  DFF2 #(4) outBnk1_mod(clk,dataRst,1'b1,outBank[1],outBank_reg[1]);
  DFF2 #(4) outBnk2_mod(clk,dataRst,1'b1,outBank[2],outBank_reg[2]);
  DFF2 #(1) outFnd1_mod(clk,dataRst,1'b1,rsFound[1],rsFound_reg[1]);
  DFF2 #(1) outFnd2_mod(clk,dataRst,1'b1,rsFound[2],rsFound_reg[2]);
  DFF2 #(1) outFndX1_mod(clk,dataRst,1'b1,rsFoundNZ[1],rsFoundNZ_reg[1]);
  DFF2 #(1) outFndX2_mod(clk,dataRst,1'b1,rsFoundNZ[2],rsFoundNZ_reg[2]);

  DFF2 #(32*6) outEqA2_mod(clk,dataRst,1'b1,outEqA_reg,outEqA_reg2);
  DFF2 #(32*6) outEqB2_mod(clk,dataRst,1'b1,outEqB_reg,outEqB_reg2);
  DFF2 #(32*6) outEqL2_mod(clk,dataRst,1'b1,outEqL_reg,outEqL_reg2);
//  DFF2 #(32*6) outEqS2_mod(clk,dataRst,1'b1,outEqS_reg,outEqS_reg2);
  DFF2 #(32*6) outEqL2_mod(clk,dataRst,1'b1,outEqL_reg,outEqL_reg2);
  DFF2 #(32*6) outEqR2_mod(clk,dataRst,1'b1,outEqR_reg,outEqR_reg2);

  DFF2 #(32) outNew02_mod(clk,dataRst,1'b1,newRsSelect0_reg,newRsSelect0_reg2);
  DFF2 #(32) outNew12_mod(clk,dataRst,1'b1,newRsSelect1_reg,newRsSelect1_reg2);
  DFF2 #(32) outNew22_mod(clk,dataRst,1'b1,newRsSelect2_reg,newRsSelect2_reg2);
  DFF2 #(32) outNew12_mod(clk,dataRst,1'b1,newRsSelect1R_reg,newRsSelect1R_reg2);
  DFF2 #(32) outNew22_mod(clk,dataRst,1'b1,newRsSelect2R_reg,newRsSelect2R_reg2);
  DFF2 #(32) outSel12_mod(clk,dataRst,1'b1,outRsSelect_reg[1],outRsSelect_reg2[1]);
  DFF2 #(32) outSel22_mod(clk,dataRst,1'b1,outRsSelect_reg[2],outRsSelect_reg2[2]);
  DFF2 #(4) outBnk12_mod(clk,dataRst,1'b1,outBank_reg[1],outBank_reg2[1]);
  DFF2 #(4) outBnk22_mod(clk,dataRst,1'b1,outBank_reg[2],outBank_reg2[2]);
  DFF2 #(1) outFnd12_mod(clk,dataRst,1'b1,rsFound_reg[1],rsFound_reg2[1]);
  DFF2 #(1) outFnd22_mod(clk,dataRst,1'b1,rsFound_reg[2],rsFound_reg2[2]);
  DFF2 #(1) outFndX12_mod(clk,dataRst,1'b1,rsFoundNZ_reg[1],rsFoundNZ_reg2[1]);
  DFF2 #(1) outFndX22_mod(clk,dataRst,1'b1,rsFoundNZ_reg[2],rsFoundNZ_reg2[2]);
  DFF2 #(32) outSel12_mod(clk,dataRst,1'b1,outRsSelectR_reg[1],outRsSelectR_reg2[1]);
  DFF2 #(32) outSel22_mod(clk,dataRst,1'b1,outRsSelectR_reg[2],outRsSelectR_reg2[2]);
  DFF2 #(4) outBnk12_mod(clk,dataRst,1'b1,outBankR_reg[1],outBankR_reg2[1]);
  DFF2 #(4) outBnk22_mod(clk,dataRst,1'b1,outBankR_reg[2],outBankR_reg2[2]);
//  DFF2 #(1) outFnd12_mod(clk,dataRst,1'b1,rsFound_reg[1],rsFound_reg2[1]);
//  DFF2 #(1) outFnd22_mod(clk,dataRst,1'b1,rsFound_reg[2],rsFound_reg2[2]);
  DFF2 #(1) outFndX12_mod(clk,dataRst,1'b1,rsFoundNZR_reg[1],rsFoundNZR_reg2[1]);
  DFF2 #(1) outFndX22_mod(clk,dataRst,1'b1,rsFoundNZR_reg[2],rsFoundNZR_reg2[2]);

  generate
      genvar k;
      for (k=0;k<3;k=k+1) begin : sel_gen
          rsSelectFifo #(k!=0) sel0_mod(
          clk,
          dataRst,
          nonDataRst,
          portReady[k],
          portEn[k],
          rsFound[k],
	  rsFoundNZ[k],
          outRsSelect[k],
          outBank[k]
          );
      end
  
  endgenerate

  rsAlloc3 alloc_mod(
  clk,
  rsAlloc0,rsAlloc1,rsAlloc2,
  bufFree,
  newRsSelect0,
  newRsSelect1,
  newRsSelect2,
  doStall,
  stall
  );
  
  rs_wakeUp_logic_array #(DATA_WIDTH) dataA_L_mod(
  clk,dataRst,stall|doStall,
  isDataA,
  outEqA,
  bufFree,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  FUreg0,FUwen0,
  FUreg1,FUwen1,
  FUreg2,FUwen2,
  FUreg3,FUwen3,
  FUreg4,FUwen4,
  FUreg5,FUwen5,
  FUreg6,FUwen6,
  FUreg7,FUwen7,
  FUreg8,FUwen8,
  FUreg9,FUwen9,
  newRsSelect0,newRegA0,newFunitA0,newGazumpA0,newPort0[3],newPort0[2],
  newRsSelect1,newRegA1,newFunitA1,newGazumpA1,newPort1[3],newPort1[2],
  newRsSelect2,newRegA2,newFunitA2,newGazumpA2,newPort2[3],newPort2[2],
  fuFwdA,
  outRsSelect[0],outDataEn0[0],outBank[0],rsFoundNZ[0],outFuFwdA0,outFuuFwdA0,
  outRsSelect[1],outDataEn1[0],outBank[1],rsFoundNZ[1],outFuFwdA1,outFuuFwdA1,
  outRsSelect[2],outDataEn2[0],outBank[2],rsFoundNZ[2],outFuFwdA2,outFuuFwdA2
  );

  rs_wakeUp_logic_array #(DATA_WIDTH) dataB_L_mod(
  clk,dataRst,stall|doStall,
  isDataB,
  outEqB,
  bufFree,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  FUreg0,FUwen0,
  FUreg1,FUwen1,
  FUreg2,FUwen2,
  FUreg3,FUwen3,
  FUreg4,FUwen4,
  FUreg5,FUwen5,
  FUreg6,FUwen6,
  FUreg7,FUwen7,
  FUreg8,FUwen8,
  FUreg9,FUwen9,
  newRsSelect0,newRegB0,newFunitB0,newGazumpB0,newPort0[3],newPort0[2],
  newRsSelect1,newRegB1,newFunitB1,newGazumpB1,newPort1[3],newPort1[2],
  newRsSelect2,newRegB2,newFunitB2,newGazumpB2,newPort2[3],newPort2[2],
  fuFwdB,
  outRsSelect[0],outDataEn0[0],outBank[0],rsFoundNZ[0],outFuFwdB0,outFuuFwdB0,
  outRsSelect[1],outDataEn1[0],outBank[1],rsFoundNZ[1],outFuFwdB1,outFuuFwdB1,
  outRsSelect[2],outDataEn2[0],outBank[2],rsFoundNZ[2],outFuFwdB2,outFuuFwdB2
  );

  rs_wakeUpS_logic_array #(FLAGS_WIDTH) dataS_L_mod(
  clk,dataRst,stall|doStall,
  isDataS,
  outEqS,
  bufFree,
  FUSreg3,FUSwen3,
  FUSreg4,FUSwen4,
  FUSreg5,FUSwen5,
  FUSreg6,FUSwen6,
  FUSreg7,FUSwen7,
  FUSreg8,FUSwen8,
  FUSwen0,FUSwen1,FUSwen2,
  newRsSelect1,newRegS1,{newFunitS1[9:3],newFunitS1[6:4]&{3{|newPort1[3:2]}}},newGazumpS1,|newPort1[3:2],
  newRsSelect2,newRegS2,{newFunitS2[9:3],newFunitS2[6:4]&{3{|newPort2[3:2]}}},newGazumpS2,|newPort2[3:2],
  fuFwdS,
  outRsSelect[1],outDataEn1[0],outBank[1],rsFoundNZ[1],outFuFwdS1,outFuuFwdS1,
  outRsSelect[2],outDataEn2[0],outBank[2],rsFoundNZ[2],outFuFwdS2,outFuuFwdS2
  );

  rs_wakeUp_data_array genA_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newDataA0,
  newRsSelect1,newDataA1,
  newRsSelect2,newDataA2,
  outEqA,
  FU0,FU1,FU2,FU3,
  FU4,FU5,FU6,
  FU7,FU8,FU9,
  outRsSelect[0],outBank[0],rsFoundNZ[0],outDataA0,
  outRsSelect[1],outBank[1],rsFoundNZ[1],outDataA1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outDataA2
  );

  rs_wakeUp_data_array genB_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newDataB0,
  newRsSelect1,newDataB1,
  newRsSelect2,newDataB2,
  outEqB,
  FU0,FU1,FU2,FU3,
  FU4,FU5,FU6,
  FU7,FU8,FU9,
  outRsSelect[0],outBank[0],rsFoundNZ[0],outDataB0,
  outRsSelect[1],outBank[1],rsFoundNZ[1],outDataB1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outDataB2
  );

  rs_wakeUp_data_array #(6) genC(
  clk,dataRst,stall,
  32'b0,6'b0,
  newRsSelect1,newDataS1,
  newRsSelect2,newDataS2,
  outEqS,
  FUS0,FUS1,FUS2,6'b0,
  FUS3,FUS4,FUS5,
  FUS6,FUS7,FUS8,
  32'b0,4'b0,1'b0,,
  outRsSelect[1],outBank[1],rsFoundNZ[1],outDataS1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outDataS2
  );
  generate
    if (odd) begin : extradata
        rs_wakeUp_logic_array #(DATA_WIDTH) dataB_L_mod(
        clk,dataRst,stall|doStall,
        isDataL,
        outEqL,
        bufFree,
        FU0Hit,FU1Hit,FU2Hit,FU3Hit,
        FUreg0,FUwen0,
        FUreg1,FUwen1,
        FUreg2,FUwen2,
        FUreg3,FUwen3,
        FUreg4,FUwen4,
        FUreg5,FUwen5,
        FUreg6,FUwen6,
        FUreg7,FUwen7,
        FUreg8,FUwen8,
        FUreg9,FUwen9,
        newRsSelect0,newRegL0,newFunitL0,newGazumpL0,newPort0[3],newPort0[2],
        newRsSelect1,newRegL1,newFunitL1,newGazumpL1,newPort1[3],newPort1[2],
        newRsSelect2,newRegL2,newFunitL2,newGazumpL2,newPort2[3],newPort2[2],
        fuFwdL,
        outRsSelect[0],outDataEn0[0],outBank[0],rsFoundNZ[0],outFuFwdL0,outFuuFwdL0,
        outRsSelect[1],outDataEn1[0],outBank[1],rsFoundNZ[1],outFuFwdL1,outFuuFwdL1,
        outRsSelect[2],outDataEn2[0],outBank[2],rsFoundNZ[2],outFuFwdL2,outFuuFwdL2
        );

        rs_wakeUp_data_array #(SIMD_WIDTH) dataA_VH_mod(
        clk,dataRst,stall|doStall,
        32'b0,{SIMD_WIDTH{1'b0}},
        newRsSelect1_reg,newDataVL1H,
        newRsSelect2_reg,newDataVL2H,
        outEqL_reg,
        FUV0H,FUV1H,FUV2H,FUV3H,
        FUV4H,FUV5H,FUV6H,
        FUV7H,FUV8H,FUV9H,
        32'b0,4'b0,1'b0,,
        outRsSelect_reg[1],outBank_reg[1],rsFoundNZ_reg[1],outDataVL1H,
        outRsSelect_reg[2],outBank_reg[2],rsFoundNZ_reg[2],outDataVL2H
        );
  
        rs_wakeUp_data_array #(SIMD_WIDTH) dataA_VL_mod(
        clk,dataRst,stall|doStall,
        32'b0,{SIMD_WIDTH{1'b0}},
        newRsSelect1_reg,newDataVL1L,
        newRsSelect2_reg,newDataVL2L,
        outEqL_reg,
        FUV0L,FUV1L,FUV2L,FUV3L,
        FUV4L,FUV5L,FUV6L,
        FUV7L,FUV8L,FUV9L,
        32'b0,4'b0,1'b0,,
        outRsSelect_reg[1],outBank_reg[1],rsFoundNZ_reg[1],outDataVL1L,
        outRsSelect_reg[2],outBank_reg[2],rsFoundNZ_reg[2],outDataVL2L
        );
  
        rs_wakeUp_data_array #(SIMD_WIDTH) dataB_VH_mod(
        clk,dataRst,stall|doStall,
        32'b0,{SIMD_WIDTH{1'b0}},
        newRsSelectR1_reg,newDataVR1H,
        newRsSelectR2_reg,newDataVR2H,
        outEqR_reg,
        FUV0H,FUV1H,FUV2H,FUV3H,
        FUV4H,FUV5H,FUV6H,
        FUV7H,FUV8H,FUV9H,
        32'b0,4'b0,1'b0,,
        outRsSelectR_reg[1],outBankR_reg[1],rsFoundNZR_reg[1],outDataVR1H,
        outRsSelectR_reg[2],outBankR_reg[2],rsFoundNZR_reg[2],outDataVR2H
        );

        rs_wakeUp_data_array #(SIMD_WIDTH) dataB_VL_mod(
        clk,dataRst,stall|doStall,
        32'b0,{SIMD_WIDTH{1'b0}},
        newRsSelect1R_reg,newDataVR1L,
        newRsSelect2R_reg,newDataVR2L,
        outEqR_reg,
        FUV0L,FUV1L,FUV2L,FUV3L,
        FUV4L,FUV5L,FUV6L,
        FUV7L,FUV8L,FUV9L,
        32'b0,4'b0,1'b0,,
        outRsSelectR_reg[1],outBankR_reg[1],rsFoundNZR_reg[1],outDataVR1L,
        outRsSelectR_reg[2],outBankR_reg[2],rsFoundNZR_reg[2],outDataVR2L
        );

        rs_wakeUp_data_array #(SIMD_WIDTH) dataA_FH_mod(
        clk,dataRst,stall|doStall,
        32'b0,{SIMD_WIDTH{1'b0}},
        newRsSelect1_reg2,newDataFL1H,
        newRsSelect2_reg2,newDataFL2H,
        outEqL_reg2,
        FUF0H,FUF1H,FUF2H,FUF3H,
        FUF4H,FUF5H,FUF6H,
        FUF7H,FUF8H,FUF9H,
        32'b0,4'b0,1'b0,,
        outRsSelect_reg2[1],outBank_reg2[1],rsFoundNZ_reg2[1],outDataFL1H,
        outRsSelect_reg2[2],outBank_reg2[2],rsFoundNZ_reg2[2],outDataFL2H
        );
  
        rs_wakeUp_data_array #(16+SIMD_WIDTH) dataA_FL_mod(
        clk,dataRst,stall|doStall,
        32'b0,{16+SIMD_WIDTH{1'b0}},
        newRsSelect1_reg2,newDataFL1L,
        newRsSelect2_reg2,newDataFL2L,
        outEqL_reg2,
        FUF0L,FUF1L,FUF2L,FUF3L,
        FUF4L,FUF5L,FUF6L,
        FUF7L,FUF8L,FUF9L,
        32'b0,4'b0,1'b0,,
        outRsSelect_reg2[1],outBank_reg2[1],rsFoundNZ_reg2[1],outDataFL1L,
        outRsSelect_reg2[2],outBank_reg2[2],rsFoundNZ_reg2[2],outDataFL2L
        );
  
  
        rs_wakeUp_data_array #(SIMD_WIDTH) dataB_FH_mod(
        clk,dataRst,stall|doStall,
        32'b0,{SIMD_WIDTH{1'b0}},
        newRsSelect1R_reg2,newDataFR1H,
        newRsSelect2R_reg2,newDataFR2H,
        outEqR_reg2,
        FUF0H,FUF1H,FUF2H,FUF3H,
        FUF4H,FUF5H,FUF6H,
        FUF7H,FUF8H,FUF9H,
        32'b0,4'b0,1'b0,,
        outRsSelectR_reg2[1],outBankR_reg2[1],rsFoundNZR_reg2[1],outDataFR1H,
        outRsSelectR_reg2[2],outBankR_reg2[2],rsFoundNZR_reg2[2],outDataFR2H
        );

        rs_wakeUp_data_array #(16+SIMD_WIDTH) dataB_FL_mod(
        clk,dataRst,stall|doStall,
        32'b0,{16+SIMD_WIDTH{1'b0}},
        newRsSelect1R_reg2,newDataFR1L,
        newRsSelect2R_reg2,newDataFR2L,
        outEqR_reg2,
        FUF0L,FUF1L,FUF2L,FUF3L,
        FUF4L,FUF5L,FUF6L,
        FUF7L,FUF8L,FUF9L,
        32'b0,4'b0,1'b0,,
        outRsSelectR_reg2[1],outBankR_reg2[1],rsFoundNZR_reg2[1],outDataFR1L,
        outRsSelectR_reg2[2],outBankR_reg2[2],rsFoundNZR_reg2[2],outDataFR2L
        );
    end
  endgenerate
  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_VH_mod(
  clk,dataRst,stall|doStall,
  32'b0,{SIMD_WIDTH{1'b0}},
  newRsSelect1_reg,newDataVA1H,
  newRsSelect2_reg,newDataVA2H,
  outEqA_reg,
  FUV0H,FUV1H,FUV2H,FUV3H,
  FUV4H,FUV5H,FUV6H,
  FUV7H,FUV8H,FUV9H,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg[1],outBank_reg[1],rsFoundNZ_reg[1],outDataVA1H,
  outRsSelect_reg[2],outBank_reg[2],rsFoundNZ_reg[2],outDataVA2H
  );
  
  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_VL_mod(
  clk,dataRst,stall|doStall,
  32'b0,{SIMD_WIDTH{1'b0}},
  newRsSelect1_reg,newDataVA1L,
  newRsSelect2_reg,newDataVA2L,
  outEqA_reg,
  FUV0L,FUV1L,FUV2L,FUV3L,
  FUV4L,FUV5L,FUV6L,
  FUV7L,FUV8L,FUV9L,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg[1],outBank_reg[1],rsFoundNZ_reg[1],outDataVA1L,
  outRsSelect_reg[2],outBank_reg[2],rsFoundNZ_reg[2],outDataVA2L
  );
  
  
  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_VH_mod(
  clk,dataRst,stall|doStall,
  32'b0,{SIMD_WIDTH{1'b0}},
  newRsSelect1_reg,newDataVB1H,
  newRsSelect2_reg,newDataVB2H,
  outEqB_reg,
  FUV0H,FUV1H,FUV2H,FUV3H,
  FUV4H,FUV5H,FUV6H,
  FUV7H,FUV8H,FUV9H,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg[1],outBank_reg[1],rsFoundNZ_reg[1],outDataVB1H,
  outRsSelect_reg[2],outBank_reg[2],rsFoundNZ_reg[2],outDataVB2H
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_VL_mod(
  clk,dataRst,stall|doStall,
  32'b0,{SIMD_WIDTH{1'b0}},
  newRsSelect1_reg,newDataVB1L,
  newRsSelect2_reg,newDataVB2L,
  outEqB_reg,
  FUV0L,FUV1L,FUV2L,FUV3L,
  FUV4L,FUV5L,FUV6L,
  FUV7L,FUV8L,FUV9L,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg[1],outBank_reg[1],rsFoundNZ_reg[1],outDataVB1L,
  outRsSelect_reg[2],outBank_reg[2],rsFoundNZ_reg[2],outDataVB2L
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_FH_mod(
  clk,dataRst,stall|doStall,
  32'b0,{SIMD_WIDTH{1'b0}},
  newRsSelect1_reg2,newDataFA1H,
  newRsSelect2_reg2,newDataFA2H,
  outEqA_reg,
  FUF0H,FUF1H,FUF2H,FUF3H,
  FUF4H,FUF5H,FUF6H,
  FUF7H,FUF8H,FUF9H,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg2[1],outBank_reg2[1],rsFoundNZ_reg2[1],outDataFA1H,
  outRsSelect_reg2[2],outBank_reg2[2],rsFoundNZ_reg2[2],outDataFA2H
  );
  
  rs_wakeUp_data_array #(16+SIMD_WIDTH) dataA_FL_mod(
  clk,dataRst,stall|doStall,
  32'b0,{16+SIMD_WIDTH{1'b0}},
  newRsSelect1_reg2,newDataFA1L,
  newRsSelect2_reg2,newDataFA2L,
  outEqA_reg,
  FUF0L,FUF1L,FUF2L,FUF3L,
  FUF4L,FUF5L,FUF6L,
  FUF7L,FUF8L,FUF9L,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg2[1],outBank_reg2[1],rsFoundNZ_reg2[1],outDataFA1L,
  outRsSelect_reg2[2],outBank_reg2[2],rsFoundNZ_reg2[2],outDataFA2L
  );
  
  
  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_FH_mod(
  clk,dataRst,stall|doStall,
  32'b0,{SIMD_WIDTH{1'b0}},
  newRsSelect1_reg2,newDataFB1H,
  newRsSelect2_reg2,newDataFB2H,
  outEqB_reg,
  FUF0H,FUF1H,FUF2H,FUF3H,
  FUF4H,FUF5H,FUF6H,
  FUF7H,FUF8H,FUF9H,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg2[1],outBank_reg2[1],rsFoundNZ_reg2[1],outDataFB1H,
  outRsSelect_reg2[2],outBank_reg2[2],rsFoundNZ_reg2[2],outDataFB2H
  );

  rs_wakeUp_data_array #(16+SIMD_WIDTH) dataB_FL_mod(
  clk,dataRst,stall|doStall,
  32'b0,{16+SIMD_WIDTH{1'b0}},
  newRsSelect1_reg2,newDataFB1L,
  newRsSelect2_reg2,newDataFB2L,
  outEqB_reg,
  FUF0L,FUF1L,FUF2L,FUF3L,
  FUF4L,FUF5L,FUF6L,
  FUF7L,FUF8L,FUF9L,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg2[1],outBank_reg2[1],rsFoundNZ_reg2[1],outDataFB1L,
  outRsSelect_reg2[2],outBank_reg2[2],rsFoundNZ_reg2[2],outDataFB2L
  );

  
  
  rs_nonWakeUp_array #(CONST_WIDTH) dataC_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newDataC0,
  newRsSelect1,newDataC1,
  newRsSelect2,newDataC2,
  
  outRsSelect[0],outBank[0],rsFoundNZ[0],outDataC0,
  outRsSelect[1],outBank[1],rsFoundNZ[1],outDataC1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outDataC2
  );
  
  rs_nonWakeUp_array #(OPERATION_WIDTH) op_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newOp0,
  newRsSelect1,newOp1,
  newRsSelect2,newOp2,
  
  outRsSelect[0],outBank[0],rsFoundNZ[0],outOp0,
  outRsSelect[1],outBank[1],rsFound[1],outOp1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outOp2
  );
  
  rs_nonWakeUp_array #(ATTR_WIDTH) attr_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newAttr0,
  newRsSelect1,newAttr1,
  newRsSelect2,newAttr2,
  
  outRsSelect[0],outBank[0],rsFoundNZ[0],outAttr0,
  outRsSelect[1],outBank[1],rsFound[1],outAttr1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outAttr2
  );
  
  rs_nonWakeUp_array #(1) LSF_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newLSFlag0,
  newRsSelect1,newLSFlag1,
  32'b0,1'b0,
  
  outRsSelect[0],outBank[0],rsFoundNZ[0],outLSFlag0,
  32'b0,4'B0,1'b1,,
  32'b0,4'B0,1'b1,
  );
  
  rs_nonWakeUp_array #(REG_WIDTH) reg_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newReg0,
  newRsSelect1,newReg1,
  newRsSelect2,newReg2,
  
  outRsSelect[0],outBank[0],rsFoundNZ[0],outReg0,
  outRsSelect[1],outBank[1],rsFound[1],outReg1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outReg2
  );


  rs_nonWakeUp_array #(REG_WIDTH) regSIMD_mod(
  clk,dataRst,stall|doStall,
  32'b0,9'b0,
  newRsSelect1,newRegSimd1,
  newRsSelect2,newRegSimd2,
  
  outRsSelect[0],outBank[0],rsFoundNZ[0],,
  outRsSelect[1],outBank[1],rsFoundNZ[1],outRegSimd1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outRegSimd2
  );

  rs_nonWakeUp_array #(LSQ_WIDTH) LSQ_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newLSQ0,
  newRsSelect1,newLSQ1,
  32'b0,{LSQ_WIDTH{1'B0}},
  
  outRsSelect[0],outBank[0],rsFoundNZ[0],outLSQ0,
  32'b0,4'B0,1'b1,,
  32'b0,4'B0,1'b1,
  );

  rs_nonWakeUp_array #(WQ_WIDTH) WQ_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newWQ0,
  newRsSelect1,{WQ_WIDTH{1'B0}},
  32'b0,{WQ_WIDTH{1'B0}},
  
  outRsSelect[0],outBank[0],rsFoundNZ[0],outWQ0,
  32'b0,4'B0,1'b1,,
  32'b0,4'B0,1'b1,
  );

  rs_nonWakeUp_array #(II_WIDTH) ii_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newInstrIndex0,
  newRsSelect1,newInstrIndex1,
  newRsSelect2,newInstrIndex2,
  
  outRsSelect[0],outBank[0],rsFoundNZ[0],outInstrIndex0,
  outRsSelect[1],outBank[1],rsFound[1],outInstrIndex1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outInstrIndex2
  );

  
  assign portEn[0]=~pause0;
  assign portEn[1]=~foundAlt1;
  assign portEn[2]=~foundAlt2;
  
  
endmodule
