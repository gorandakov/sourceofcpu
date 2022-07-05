`include "../struct.sv"

module WQ_wakeUP_logic(
  clk,
  rst,
  stall,
  newWQ0,newRsSelect0,newPortEn0,newEQ0,
  FUWQ0,FUWQen0,
  FUWQ1,FUWQen1,
  isData);

  input clk;
  input rst;
  input stall;
  input [5:0] newWQ0;
  input newRsSelect0;
  input   newPortEn0;
  input [1:0] newEQ0;
  input [5:0] FUWQ0;
  input     FUWQen0;
  input [5:0] FUWQ1;
  input     FUWQen1;
  output isData;

  reg port_en;
  reg [5:0] WQ;

  wire [5:0] WQ_d;
  wire newRsSelectAny;
  wire port_en_d;
  wire [1:0] eq;
  wire [1:0] eq_new;

  assign newRsSelectAny=newRsSelect0;

  assign WQ_d=newRsSelect0 ? newWQ0 : 6'bz;
  assign WQ_d=~newRsSelectAny ? WQ : 6'bz;
  
  assign port_en_d=newRsSelect0&~stall ? newPortEn0&~isData : 1'bz;
  assign port_en_d=~newRsSelectAny|stall ? port_en&~isData : 1'bz;
  
  assign eq[0]=(WQ==FUWQ0) & FUWQen0 & port_en & ~newRsSelect0 & ~newRsSelect1 & ~newRsSelect2;
  assign eq[1]=(WQ==FUWQ1) & FUWQen1 & port_en & ~newRsSelect0 & ~newRsSelect1 & ~newRsSelect2;

  assign eq_new=eq|({2{newRsSelect0&~stall}}&newEQ0)|({2{newRsSelect1&~stall}}&newEQ1)|
    ({2{newRsSelect2&~stall}}&newEQ2);

  assign isData=|eq_new;

  always @(posedge clk) begin 
      if (rst) begin
	  WQ<=0;
	  port_en<=0;
      end else begin
	  WQ<=WQ_d;
	  port_en<=port_en_d;
      end
  end
endmodule

module WQ_wakeUP_logic_array(
  clk,
  rst,
  stall,
  newWQ0,newRsSelect0,newPortEn0,
  FUWQ0,FUWQen0,
  FUWQ1,FUWQen1,
  isData);

  input clk;
  input rst;
  input stall;
  input [5:0] newWQ0;
  input [31:0] newRsSelect0;
  input   newPortEn0;
  input [5:0] FUWQ0;
  input     FUWQen0;
  input [5:0] FUWQ1;
  input     FUWQen1;
  output [31:0] isData;
  generate
      genvar x;
      for(x=0;x<32;x=x+1) begin : BUF
          WQ_wakeUP_logic buf_mod(
          clk,
          rst,
          stall,
          newWQ0,newRsSelect0[x],newPortEn0,2'b0,
          FUWQ0,FUWQen0,
          FUWQ1,FUWQen1,
          isData[x]
          );
      end
  endgenerate
endmodule


module rss_D_buf(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newANeeded0,newBNeeded0,newRsSelect0,newPort0,
  newANeeded1,newBNeeded1,newRsSelect1,newPort1,
  newANeeded2,newBNeeded2,newRsSelect2,newPort2,
// wires to get values out of buffer
  outRsSelect1,portReady1,outDataEn1,outThread1,//data
  fuFwdA,
  isDataA,isDataB,
// 1 if buffer is free  
  bufFree
);
  localparam DATA_WIDTH=`alu_width+1;
  localparam REG_WIDTH=`reg_addr_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam LSQ_WIDTH=`lsqRsNo_width;
  localparam CONST_WIDTH=32;
  localparam FLAGS_WIDTH=`flags_width;
  localparam ROB_WIDTH=10;  
  parameter [31:0] B=32'b0;

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
  input newRsSelect0;
  input [6:0] newPort0;

  input newANeeded1;
  input newBNeeded1;
  input newRsSelect1;
  input [6:0] newPort1;  

  input newANeeded2;
  input newBNeeded2;
  input newRsSelect2;
  input [6:0] newPort2;  

// output data to functional units

    
  input outRsSelect1;
  output wire portReady1;
  output [3:0] outDataEn1;
  output outThread1;

  input [3:0] fuFwdA;

  input isDataA;
  input isDataB;

// free output
  output wire bufFree;
// wires
// wires - new data
  
  


  wire portReady1_d;
  wire portReady1_q;


  wire [8:0] portNo_new;

  wire port1A_d;
  wire port1A_en;
  wire port1A_q;


  wire port1B_d;
  wire port1B_en;
  wire port1B_q;


  wire dataAPunding_new,dataAPunding_q; 
  wire dataBPunding_new,dataBPunding_q; 


  wire newRsSelectAny=newRsSelect0 | newRsSelect1 | newRsSelect2;

  wire dataAPending1_en;
  wire dataAPending1_d;
  wire dataAPending1_q;
  wire dataAPending1_new;
  wire dataAPending1_gather;

  wire dataBPending1_en;
  wire dataBPending1_d;
  wire dataBPending1_q;
  wire dataBPending1_new;
  wire dataBPending1_gather;
 
// wires - end new data

// wires - gather data
  wire isReady0,isReady1A,isReady1B;
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

  wire forgetUpdate;
  
  wire thread_q;
  wire FPA_q;
  wire VecA_q;
  wire FPB_q;
  wire VecB_q;
  
  wire nonDataRst0;
  
  wire new_stall_n;
    
  assign stall_n=~stall;  
  assign nonDataRst0=rst_thread ? nonDataRst & thread_q || dataRst : nonDataRst &~thread_q || dataRst;
//new data input into buffer 
  assign new_stall_n=~(newRsSelectAny & stall);


  DFF thread_mod(clk,newRsSelectAny|dataRst,new_thread&~dataRst,thread_q);
  DFF FPA_mod(clk,newRsSelectAny|dataRst,portNo_new[4]&~dataRst,FPA_q);
  DFF VecA_mod(clk,newRsSelectAny|dataRst,portNo_new[3]&~dataRst,VecA_q);
  DFF FPB_mod(clk,newRsSelectAny|dataRst,portNo_new[6]&~dataRst,FPB_q);
  DFF VecB_mod(clk,newRsSelectAny|dataRst,portNo_new[5]&~dataRst,VecB_q);
  
  DFF dataA1Pending_mod(clk,dataAPending1_en,dataAPending1_d,dataAPending1_q);
  DFF dataB1Pending_mod(clk,dataBPending1_en,dataBPending1_d,dataBPending1_q);

// "Punding" registers contain bits to indicate whether an agu register should be zeroed on output 
  DFF dataAPunding_mod(clk,newRsSelectAny & ~stall,dataAPunding_new,dataAPunding_q);
  DFF dataBPunding_mod(clk,newRsSelectAny & ~stall,dataBPunding_new,dataBPunding_q);
 
  DFF port1A_mod(clk,port1A_en,port1A_d,port1A_q); 
  DFF port1B_mod(clk,port1B_en,port1B_d,port1B_q); 
  
  DFF portReady1_mod(clk,1'b1,portReady1_d,portReady1_q);

  assign dataAPending1_gather=isDataA;
  assign dataBPending1_gather=isDataB;

  assign fwdCheck0=fuFwdA==4'd0; 
  assign fwdCheck1=fuFwdA==4'd1; 
  assign fwdCheck2=fuFwdA==4'd2;   
  assign fwdCheck3=fuFwdA==4'd3;   

  assign unFwdCheck=fwdCheck0 & ~FU0Hit || fwdCheck1 & ~FU1Hit || fwdCheck2 & ~FU2Hit || fwdCheck3 & ~FU3Hit;

  assign portReady1=portReady1_q;
  
  assign unCheckA=(fuFwdA==4'd0 && ~FU0Hit) | (fuFwdA==4'd1 && ~FU1Hit) | (fuFwdA==4'd2 && ~FU2Hit) | (fuFwdA==4'd3 && ~FU3Hit);

  assign portNo_new=(newRsSelect0 & ~stall) ? {newBNeeded0,newANeeded0,newPort0} : 9'bz;
  assign portNo_new=(newRsSelect1 & ~stall) ? {newBNeeded1,newANeeded1,newPort1} : 9'bz;
  assign portNo_new=(newRsSelect2 & ~stall) ? {newBNeeded2,newANeeded2,newPort2} : 9'bz;
  assign portNo_new=(newRsSelectAny & ~stall) ? 9'bz : 9'b0;


  assign port1A_en=stall_n & newRsSelectAny || outRsSelect1 &~unFwdCheck || nonDataRst0;
  assign port1B_en=stall_n & newRsSelectAny || outRsSelect1 &~unFwdCheck || nonDataRst0;
  assign port1A_d=newRsSelectAny ? (portNo_new[2] & portNo_new[7+B]) & ~nonDataRst0 :
    port1A_q & (~outRsSelect1 | unFwdCheck)  & ~nonDataRst0;
  assign port1B_d=newRsSelectAny ? (portNo_new[2] & portNo_new[7+B]) & ~nonDataRst0 :
    port1B_q & (~outRsSelect1 | unFwdCheck)  & ~nonDataRst0;
  

  assign dataAPending1_new=(newRsSelect0 & ~stall) ? newANeeded0 && (portNo_new[2])  : 1'bz;
  assign dataAPending1_new=(newRsSelect1 & ~stall) ? newANeeded1 && (portNo_new[2])  : 1'bz;
  assign dataAPending1_new=(newRsSelect2 & ~stall) ? newANeeded2 && (portNo_new[2])  : 1'bz;
  assign dataAPending1_new=(newRsSelectAny & ~stall) ? 1'bz : 1'b0;
  
  assign dataAPending1_en=newRsSelectAny | nonDataRst0 | unCheckA || dataAPending1_gather ;
  assign dataAPending1_d=newRsSelectAny ? dataAPending1_new & ~nonDataRst0 & stall_n & ~dataAPending1_gather:
    (~dataAPending1_gather & dataAPending1_q || unCheckA) & ~nonDataRst0;
  
  assign dataBPending1_new=(newRsSelect0 & ~stall) ? newBNeeded0 && (portNo_new[2])  : 1'bz;
  assign dataBPending1_new=(newRsSelect1 & ~stall) ? newBNeeded1 && (portNo_new[2])  : 1'bz;
  assign dataBPending1_new=(newRsSelect2 & ~stall) ? newBNeeded2 && (portNo_new[2])  : 1'bz;
  assign dataBPending1_new=(newRsSelectAny & ~stall) ? 1'bz : 1'b0;
  
  assign dataBPending1_en=newRsSelectAny | nonDataRst0 | | dataBPending1_gather ;
  assign dataBPending1_d=newRsSelectAny ? dataBPending1_new & ~nonDataRst0 & stall_n & ~dataBPending1_gather:
    (~dataBPending1_gather & dataBPending1_q) & ~nonDataRst0;


	
  
// issue port 1 - data
  assign outDataEn1=outRsSelect1 ? {4{~unFwdCheck}} &{FPB_q,VecB_q,~FPB_q&~VecB_q,1'b1} : 4'bz;
  assign outThread1=outRsSelect1 ? thread_q : 1'bz;
 
  
// end data output


//  assign isReady=~dataAPending_d & ~dataBPending_d & ~dataDPending_d & ~dataSPending_d;

  assign isReady1A=dataBPending1_gather | ~dataBPending1_d;
  assign isReady1B=dataAPending1_gather | ~dataAPending1_d;
  
  assign portReady1_d=isReady1A & port1B_d & ~unFwdCheck & new_stall_n;

// free bit
  DFF bufFree_mod(clk,bufFree_en,bufFree_d,bufFree);
  
  assign bufFree_en=stall_n & newRsSelectAny || (outRsSelect1 && ~unFwdCheck) || nonDataRst0;
  assign bufFree_d=~port1A_d || nonDataRst0;
  
endmodule







module rss_D_array(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newANeeded0,newBNeeded0,newRsSelect0,newPort0,
  newANeeded1,newBNeeded1,newRsSelect1,newPort1,
  newANeeded2,newBNeeded2,newRsSelect2,newPort2,
// wires to get values out of buffer
  outRsSelect1,outRsBank1,outFound1,portReady1,outDataEn1,outThread1,//data
  fuFwdA,
  isDataA,isDataB,
// 1 if buffer is free  
  bufFree
);
  localparam DATA_WIDTH=`alu_width;
  localparam REG_WIDTH=`reg_addr_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam LSQ_WIDTH=`lsqRsNo_width;
  localparam CONST_WIDTH=32;
  localparam FLAGS_WIDTH=`flags_width;
  localparam ROB_WIDTH=10;  
  localparam BUF_COUNT=32;
  parameter [31:0] B=32'b0;

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
  input [BUF_COUNT-1:0] newRsSelect0;
  input [6:0] newPort0;

  input newANeeded1;
  input newBNeeded1;
  input [BUF_COUNT-1:0] newRsSelect1;
  input [6:0] newPort1;  

  input newANeeded2;
  input newBNeeded2;
  input [BUF_COUNT-1:0] newRsSelect2;
  input [6:0] newPort2;  

// output data to functional units

  input [BUF_COUNT-1:0] outRsSelect1;
  input [3:0] outRsBank1;
  input outFound1;
  output [BUF_COUNT-1:0] portReady1;
  output [3:0] outDataEn1;
  output outThread1;

  input [BUF_COUNT*4-1:0] fuFwdA;

  input [BUF_COUNT-1:0] isDataA;
  input [BUF_COUNT-1:0] isDataB;

// free output
  output [BUF_COUNT-1:0]  bufFree;
// wires
// wires - new data
  generate
      genvar k,j;
      for (j=0;j<4;j=j+1) begin : banks_gen
          wire [3:0] outDataEn1a;
          wire outThread1a;
          for(k=0;k<8;k=k+1) begin : buffers_gen
              rss_D_buf #(B) buf_mod(
              clk,
              dataRst,nonDataRst,rst_thread,
              stall,
              FU0Hit,FU1Hit,FU2Hit,FU3Hit,
              new_thread,
//     wires to store new values in a buffer
              newANeeded0,newBNeeded0,newRsSelect0[j*8+k],newPort0,
              newANeeded1,newBNeeded1,newRsSelect1[j*8+k],newPort1,
              newANeeded2,newBNeeded2,newRsSelect2[j*8+k],newPort2,
//     wires to get values out of buffer
              outRsSelect1[j*8+k],portReady1[j*8+k],outDataEn1a,outThread1a,//data 1
              fuFwdA[(j*8+k)*4+:4],
              isDataA[j*8+k],isDataB[j*8+k],
//     1 if buffer is free  
              bufFree[j*8+k]
              );
          end
          assign outDataEn1a=outRsBank1[j] ? 4'bz : 4'b0;
          assign outDataEn1=outRsBank1[j] ? outDataEn1a : 4'bz;
          assign outThread1a=outRsBank1[j] ? 1'bz : 1'b0;
          assign outThread1=outRsBank1[j] ? outThread1a : 1'bz;
      end
  endgenerate

  assign outDataEn1=outFound1 ? 4'bz : 4'b0;

  assign outThread1=outFound1 ? 1'bz : 1'b0;

endmodule




module rs_s_d(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall,
  doStall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  rsEnab,
  new_thread,
// wires to store new values in a buffer
  newDataA0,newDataB0,newRegA0,newRegB0,newANeeded0,newBNeeded0,newOpA0,
    newOpB0,newPort0,newInstrIndexA0,newInstrIndexB0,newLSQA0,newLSQB0,newEnA0,newEnB0,
    rsAlloc0,newGazumpA0,newGazumpB0,newFunitA0,newFunitB0,newWQA0,newWQB0,newLSFlag0,
    newAttr0,
// wires to get values out of buffer
  outDataB1,outOp1,outInstrIndex1,outFuFwdB1,outFuuFwdB1,
    outLSQ1,outDataEn1,outThread1,outWQ1,//data
    outAttr1,
  outDataA3,outOp3,outInstrIndex3,outFuFwdA3,outFuuFwdA3,
    outLSQ3,outDataEn3,outThread3,outWQ3,//data
    outAttr3,
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

  FUWQ0,FUWQen0,
  FUWQ1,FUWQen1,

  newDataVA0H,newDataVB0H,newDataVA0L,newDataVB0L,
  newDataFA0H,newDataFB0H,newDataFA0L,newDataFB0L,

  outDataVB1H,outDataVB1L,
  outDataVA3H,outDataVA3L,

  outDataFB1H,outDataFB1L,
  outDataFA3H,outDataFA3L,

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
  FUF9H,FUF9L
);
  localparam DATA_WIDTH=`alu_width+1;
  localparam SIMD_WIDTH=68;
  localparam REG_WIDTH=`reg_addr_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam LSQ_WIDTH=`lsqRsNo_width;
  localparam CONST_WIDTH=33;
  localparam FLAGS_WIDTH=6;  
  localparam BUF_COUNT=`rs_buf_count;
  localparam II_WIDTH=10;  
  localparam FN_WIDTH=10;
  localparam WQ_WIDTH=6;
  localparam ATTR_WIDTH=4;

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
  input [3:0] rsEnab;
//Input of new data from registeres
  input new_thread;
  input [DATA_WIDTH-1:0]       newDataA0;
  input [DATA_WIDTH-1:0]       newDataB0;
  input [REG_WIDTH-1:0] newRegA0; 
  input [REG_WIDTH-1:0] newRegB0; 
  input newANeeded0;
  input newBNeeded0;
  input [OPERATION_WIDTH-1:0]   newOpA0;
  input [OPERATION_WIDTH-1:0]   newOpB0;
  input [6:0] newPort0;
  input [II_WIDTH-1:0] newInstrIndexA0;  
  input [II_WIDTH-1:0] newInstrIndexB0;  
  input [LSQ_WIDTH-1:0] newLSQA0;
  input [LSQ_WIDTH-1:0] newLSQB0;
  input newEnA0;
  input newEnB0;
  input rsAlloc0;
  input [10:0] newGazumpA0;
  input [10:0] newGazumpB0;
  input [FN_WIDTH-1:0] newFunitA0;
  input [FN_WIDTH-1:0] newFunitB0;
  input [WQ_WIDTH-1:0] newWQA0;
  input [WQ_WIDTH-1:0] newWQB0;
  input newLSFlag0;
  input [ATTR_WIDTH-1:0] newAttr0;

  output wire [DATA_WIDTH-1:0]       outDataB1;
  output wire [OPERATION_WIDTH-1:0]   outOp1;
  output wire [II_WIDTH-1:0] outInstrIndex1;
  output [3:0] outFuFwdB1;
  output [3:0] outFuuFwdB1;
  output [LSQ_WIDTH-1:0] outLSQ1;
  output [3:0] outDataEn1;
  output outThread1;
  output [WQ_WIDTH-1:0] outWQ1;
  output [ATTR_WIDTH-1:0] outAttr1;

  output wire [DATA_WIDTH-1:0]       outDataA3;
  output wire [OPERATION_WIDTH-1:0]   outOp3;
  output wire [II_WIDTH-1:0] outInstrIndex3;
  output [3:0] outFuFwdA3;
  output [3:0] outFuuFwdA3;
  output [LSQ_WIDTH-1:0] outLSQ3;
  output [3:0] outDataEn3;
  output outThread3;
  output [WQ_WIDTH-1:0] outWQ3;
  output [ATTR_WIDTH-1:0] outAttr3;

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

  input [5:0] FUWQ0;
  input FUWQen0;

  input [5:0] FUWQ1;
  input FUWQen1;

//SIMD
  input [SIMD_WIDTH-1:0] newDataVA0H;
  input [SIMD_WIDTH-1:0] newDataVB0H;
  input [SIMD_WIDTH-1:0] newDataVA0L;
  input [SIMD_WIDTH-1:0] newDataVB0L;
  
  input [SIMD_WIDTH-1:0] newDataFA0H;
  input [SIMD_WIDTH-1:0] newDataFB0H;
  input [16+SIMD_WIDTH-1:0] newDataFA0L;
  input [16+SIMD_WIDTH-1:0] newDataFB0L;
  

  output [SIMD_WIDTH-1:0] outDataVB1H;
  output [SIMD_WIDTH-1:0] outDataVB1L;
  
  output [SIMD_WIDTH-1:0] outDataVA3H;
  output [SIMD_WIDTH-1:0] outDataVA3L;
  
  output [SIMD_WIDTH-1:0] outDataFB1H;
  output [16+SIMD_WIDTH-1:0] outDataFB1L;
  
  output [SIMD_WIDTH-1:0] outDataFA3H;
  output [16+SIMD_WIDTH-1:0] outDataFA3L;
  
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
  
  
  
  wire [BUF_COUNT-1:0] bufFree;
  wire [BUF_COUNT-1:0] bufFreeA;
  wire [BUF_COUNT-1:0] bufFreeB;
  
  wire [BUF_COUNT-1:0] newRsSelect0;
  wire [BUF_COUNT-1:0] newRsSelect1;
  wire [BUF_COUNT-1:0] newRsSelect2;
  
  wire [3:0][BUF_COUNT-1:0] outRsSelect;
  wire [BUF_COUNT-1:0] portReady[3:0];
  wire [3:0][3:0] outBank;
  wire [3:0] portEn;
  wire [3:0] rsFound;
  
  wire [127:0] fuFwdA;
  wire [127:0] fuFwdB;
  wire [BUF_COUNT-1:0] isDataA;
  wire [BUF_COUNT-1:0] isDataB;
  wire [BUF_COUNT-1:0] isDataWQA;
  wire [BUF_COUNT-1:0] isDataWQB;

  wire [64:0] outDataA2P;
  wire [64:0] outDataB0P;
  wire outZeroB0,outZeroA2;

  wire [6*BUF_COUNT-1:0] outEqA;
  wire [6*BUF_COUNT-1:0] outEqB;
  wire [6*BUF_COUNT-1:0] outEqA_reg;
  wire [6*BUF_COUNT-1:0] outEqB_reg;
  wire [BUF_COUNT-1:0] newRsSelect0_reg;
  wire [BUF_COUNT-1:0] newRsSelect1_reg;
  wire [BUF_COUNT-1:0] newRsSelect2_reg;
  wire [BUF_COUNT-1:0] outRsSelect_reg[3:0];
  wire [3:0] outBank_reg[3:0];
  wire [3:0] rsFound_reg;
  wire [6*BUF_COUNT-1:0] outEqA_reg2;
  wire [6*BUF_COUNT-1:0] outEqB_reg2;
  wire [BUF_COUNT-1:0] newRsSelect0_reg2;
  wire [BUF_COUNT-1:0] newRsSelect1_reg2;
  wire [BUF_COUNT-1:0] newRsSelect2_reg2;
  wire [BUF_COUNT-1:0] outRsSelect_reg2[3:0];
  wire [3:0] outBank_reg2[3:0];
  wire [3:0] rsFound_reg2;
  
  
  wire [2:0] newIsFpA;
  wire [2:0] newIsFpB;
  wire [2:0] newIsVA;
  wire [2:0] newIsVB;

  assign outRsSelect_reg[2]=32'b0;
  assign outRsSelect_reg[0]=32'b0;
  
  assign outRsSelect_reg2[2]=32'b0;
  assign outRsSelect_reg2[0]=32'b0;
  
  assign newIsFpA[0]=newPort0[4] && (newPort0[2:0]==3'b010 || newPort0[2]);
  
  assign newIsFpB[0]=newPort0[6] && (newPort0[2:0]==3'b000 || newPort0[2]);

  assign newIsVA[0]=newPort0[3] && (newPort0[2:0]==3'b010 || newPort0[2]);
  
  assign newIsVB[0]=newPort0[5] && (newPort0[2:0]==3'b000 || newPort0[2]);

  assign outDataB0=outDataB0P&{65{~outZeroB0}};
  assign outDataA2=outDataA2P&{65{~outZeroA2}};

  rss_D_array rs0_mod(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall|doStall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newANeeded0,1'b1,newRsSelect0,newPort0,
  newANeeded1,1'b1,newRsSelect1,newPort1,
  newANeeded2,1'b1,newRsSelect2,newPort2,
// wires to get values out of buffer
  outRsSelect[1],outBank[1],rsFound[1],portReady[1],outDataEn1,outThread1,//data
  fuFwdA,
  isDataA,isDataWQA,
// 1 if buffer is free  
  bufFreeA
  );
  
  rss_D_array #(1) rs1_mod(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall|doStall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newBNeeded0,1'b1,newRsSelect0,newPort0,
  newBNeeded1,1'b1,newRsSelect1,newPort1,
  newBNeeded2,1'b1,newRsSelect2,newPort2,
// wires to get values out of buffer
  outRsSelect[3],outBank[3],rsFound[3],portReady[3],outDataEn3,outThread3,//data 2
  fuFwdB,
  isDataB,isDataWQB,
// 1 if buffer is free  
  bufFreeB
  );
  
  DFF2 #(192) outEqA_mod(clk,dataRst,1'b1,outEqA,outEqA_reg);
  DFF2 #(192) outEqB_mod(clk,dataRst,1'b1,outEqB,outEqB_reg);

  DFF2 #(32) outNew0_mod(clk,dataRst,1'b1,newRsSelect0,newRsSelect0_reg);
  DFF2 #(32) outNew1_mod(clk,dataRst,1'b1,newRsSelect1,newRsSelect1_reg);
  DFF2 #(32) outNew2_mod(clk,dataRst,1'b1,newRsSelect2,newRsSelect2_reg);
  DFF2 #(32) outSel1_mod(clk,dataRst,1'b1,outRsSelect[1],outRsSelect_reg[1]);
  DFF2 #(32) outSel2_mod(clk,dataRst,1'b1,outRsSelect[3],outRsSelect_reg[3]);
  DFF2 #(4) outBnk1_mod(clk,dataRst,1'b1,outBank[1],outBank_reg[1]);
  DFF2 #(4) outBnk3_mod(clk,dataRst,1'b1,outBank[3],outBank_reg[3]);
  DFF2 #(1) outFnd1_mod(clk,dataRst,1'b1,rsFound[1],rsFound_reg[1]);
  DFF2 #(1) outFnd3_mod(clk,dataRst,1'b1,rsFound[3],rsFound_reg[3]);

  DFF2 #(192) outEqA2_mod(clk,dataRst,1'b1,outEqA_reg,outEqA_reg2);
  DFF2 #(192) outEqB2_mod(clk,dataRst,1'b1,outEqB_reg,outEqB_reg2);

  DFF2 #(32) outNew02_mod(clk,dataRst,1'b1,newRsSelect0_reg,newRsSelect0_reg2);
  DFF2 #(32) outNew12_mod(clk,dataRst,1'b1,newRsSelect1_reg,newRsSelect1_reg2);
  DFF2 #(32) outNew22_mod(clk,dataRst,1'b1,newRsSelect2_reg,newRsSelect2_reg2);
  DFF2 #(32) outSel12_mod(clk,dataRst,1'b1,outRsSelect_reg[1],outRsSelect_reg2[1]);
  DFF2 #(32) outSel22_mod(clk,dataRst,1'b1,outRsSelect_reg[3],outRsSelect_reg2[3]);
  DFF2 #(4) outBnk12_mod(clk,dataRst,1'b1,outBank_reg[1],outBank_reg2[1]);
  DFF2 #(4) outBnk32_mod(clk,dataRst,1'b1,outBank_reg[3],outBank_reg2[3]);
  DFF2 #(1) outFnd12_mod(clk,dataRst,1'b1,rsFound_reg[1],rsFound_reg2[1]);
  DFF2 #(1) outFnd32_mod(clk,dataRst,1'b1,rsFound_reg[3],rsFound_reg2[3]);

  
  rsSelectFifo #(0) sel0_mod(
  clk,
  dataRst,
  nonDataRst,
  portReady[1],
  rsEnab[1],
  rsFound[1],,
  outRsSelect[1],
  outBank[1]
  );

  rsSelectFifo #(0) sel1_mod(
  clk,
  dataRst,
  nonDataRst,
  portReady[3],
  rsEnab[3],
  rsFound[3],,
  outRsSelect[3],
  outBank[3]
  );

  rsAlloc3 alloc_mod(
  clk,
  rsAlloc0,rsAlloc1,rsAlloc2,
  bufFree&bufFreeA&bufFreeB,
  newRsSelect0,
  32'b0,
  32'b0,
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
  newRsSelect0,newRegA0,newFunitA0,newGazumpA0,newIsFpA[0],newIsVA[0],
  newRsSelect1,newRegA1,newFunitA1,newGazumpA1,newIsFpA[1],newIsVA[1],
  newRsSelect2,newRegA2,newFunitA2,newGazumpA2,newIsFpA[2],newIsVA[2],
  fuFwdA,
  32'b0,4'b0,4'b0,1'b0,4'hf,4'hf,
  outRsSelect[3],outDataEn3[0],outBank[3],rsFound[3],outFuFwdA3,outFuuFwdA3,
  32'b0,4'b0,4'b0,1'b0,4'hf,4'hf
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
  newRsSelect0,newRegB0,newFunitB0,newGazumpB0,newIsFpB[0],newIsVB[0],
  newRsSelect1,newRegB1,newFunitB1,newGazumpB1,newIsFpB[1],newIsVB[1],
  newRsSelect2,newRegB2,newFunitB2,newGazumpB2,newIsFpB[2],newIsVB[2],
  fuFwdB,
  32'b0,4'b0,4'b0,1'b0,4'hf,4'hf,
  outRsSelect[1],outDataEn1[0],outBank[1],rsFound[1],outFuFwdB1,outFuuFwdB1,
  32'b0,4'b0,4'b0,1'b0,4'hf,4'hf
  );

  rs_wakeUp_data_array #(DATA_WIDTH) dataA_G_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newDataA0,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqA,
  FU0,FU1,FU2,FU3,
  FU4,FU5,FU6,
  FU7,FU8,FU9,
  32'b0,4'b0,1'b0,,
  outRsSelect[3],outBank[3],rsFound[3],outDataA3,
  32'b0,4'b0,1'b0,
  );
  
  rs_wakeUp_data_array #(DATA_WIDTH) dataB_G_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newDataB0,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqB,
  FU0,FU1,FU2,FU3,
  FU4,FU5,FU6,
  FU7,FU8,FU9,
  32'b0,4'b0,1'b0,,
  outRsSelect[1],outBank[1],rsFound[1],outDataB1,
  32'b0,4'b0,1'b0,
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_VH_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg,newDataVA0H,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqA_reg,
  FUV0H,FUV1H,FUV2H,FUV3H,
  FUV4H,FUV5H,FUV6H,
  FUV7H,FUV8H,FUV9H,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg[3],outBank_reg[3],rsFound_reg[3],outDataVA3H,
  32'b0,4'b0,1'b0,
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_VL_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg,newDataVA0L,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqA_reg,
  FUV0L,FUV1L,FUV2L,FUV3L,
  FUV4L,FUV5L,FUV6L,
  FUV7L,FUV8L,FUV9L,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg[3],outBank_reg[3],rsFound_reg[3],outDataVA3L,
  32'b0,4'b0,1'b0,
  );
  
  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_VH_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg,newDataVB0H,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqB_reg,
  FUV0H,FUV1H,FUV2H,FUV3H,
  FUV4H,FUV5H,FUV6H,
  FUV7H,FUV8H,FUV9H,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg[1],outBank_reg[1],rsFound_reg[1],outDataVB1H,
  32'b0,4'b0,1'b0,
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_VL_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg,newDataVB0L,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqB_reg,
  FUV0L,FUV1L,FUV2L,FUV3L,
  FUV4L,FUV5L,FUV6L,
  FUV7L,FUV8L,FUV9L,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg[1],outBank_reg[1],rsFound_reg[1],outDataVB1L,
  32'b0,4'b0,1'b0,
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_FH_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg2,newDataFA0H,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqA_reg2,
  FUF0H,FUF1H,FUF2H,FUF3H,
  FUF4H,FUF5H,FUF6H,
  FUF7H,FUF8H,FUF9H,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg2[3],outBank_reg2[3],rsFound_reg2[3],outDataFA3H,
  32'b0,4'b0,1'b0,
  );

  rs_wakeUp_data_array #(16+SIMD_WIDTH) dataA_FL_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg2,newDataFA0L,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqA_reg2,
  FUF0L,FUF1L,FUF2L,FUF3L,
  FUF4L,FUF5L,FUF6L,
  FUF7L,FUF8L,FUF9L,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg2[3],outBank_reg2[3],rsFound_reg2[3],outDataFA3L,
  32'b0,4'b0,1'b0,
  );
  
  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_FH_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg2,newDataFB0H,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqB_reg2,
  FUF0H,FUF1H,FUF2H,FUF3H,
  FUF4H,FUF5H,FUF6H,
  FUF7H,FUF8H,FUF9H,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg2[1],outBank_reg2[1],rsFound_reg2[1],outDataFB1H,
  32'b0,4'b0,1'b0,
  );

  rs_wakeUp_data_array #(16+SIMD_WIDTH) dataB_FL_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg2,newDataFB0L,
  32'b0,{DATA_WIDTH{1'b0}},
  32'b0,{DATA_WIDTH{1'b0}},
  outEqB_reg2,
  FUF0L,FUF1L,FUF2L,FUF3L,
  FUF4L,FUF5L,FUF6L,
  FUF7L,FUF8L,FUF9L,
  32'b0,4'b0,1'b0,,
  outRsSelect_reg2[1],outBank_reg2[1],rsFound_reg2[1],outDataFB1L,
  32'b0,4'b0,1'b0,
  );

 
  rs_nonWakeUp_array #(WQ_WIDTH) dataWQA_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newWQA0,
  32'b0,{WQ_WIDTH{1'b0}},
  32'b0,{WQ_WIDTH{1'b0}},
  
  32'b0,4'B0,1'b1,,
  outRsSelect[3],outBank[3],rsFound[3],outWQ3,
  32'b0,4'B0,1'b1,
  );

  rs_nonWakeUp_array #(WQ_WIDTH) dataWQB_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newWQB0,
  32'b0,{WQ_WIDTH{1'b0}},
  32'b0,{WQ_WIDTH{1'b0}},
  
  32'b0,4'B0,1'b1,,
  outRsSelect[1],outBank[1],rsFound[1],outWQ1,
  32'b0,4'B0,1'b1,
  );

  WQ_wakeUP_logic_array WQLA_mod(
  clk,
  dataRst|nonDataRst,
  stall,
  newWQA0,newRsSelect0,newPort0[2]&newANeeded0,
  FUWQ0,FUWQen0,
  FUWQ1,FUWQen1,
  isDataWQA);
  
  WQ_wakeUP_logic_array WQLB_mod(
  clk,
  dataRst|nonDataRst,
  stall,
  newWQB0,newRsSelect0,newPort0[2]&newBNeeded0,
  FUWQ0,FUWQen0,
  FUWQ1,FUWQen1,
  isDataWQB);


 
  rs_nonWakeUp_array #(1) LSF_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newLSFlag0,
  newRsSelect1,newLSFlag1,
  newRsSelect2,newLSFlag2,
  
  outRsSelect[0],outBank[0],rsFound[0],outLSFlag0,
  outRsSelect[2],outBank[2],rsFound[2],outLSFlag2,
  32'b0,4'B0,1'b1,
  );
  
  rs_nonWakeUp_array #(OPERATION_WIDTH) opA_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newOpA0,
  newRsSelect1,newOpA1,
  newRsSelect2,newOpA2,
  
  outRsSelect[0],outBank[0],rsFound[0],outOp0,
  outRsSelect[1],outBank[1],rsFound[1],outOp1,
  32'b0,4'b0,1'b0,
  );

  rs_nonWakeUp_array #(OPERATION_WIDTH) opB_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newOpB0,
  newRsSelect1,newOpB1,
  newRsSelect2,newOpB2,
  
  outRsSelect[2],outBank[2],rsFound[2],outOp2,
  outRsSelect[3],outBank[3],rsFound[3],outOp3,
  32'b0,4'b0,1'b0,
  );

  rs_nonWakeUp_array #(II_WIDTH) IIA_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newInstrIndexA0,
  newRsSelect1,newInstrIndexA1,
  newRsSelect2,newInstrIndexA2,
  
  outRsSelect[0],outBank[0],rsFound[0],outInstrIndex0,
  outRsSelect[1],outBank[1],rsFound[1],outInstrIndex1,
  32'b0,4'b0,1'b0,
  );

  rs_nonWakeUp_array #(II_WIDTH) IIB_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newInstrIndexB0,
  newRsSelect1,newInstrIndexB1,
  newRsSelect2,newInstrIndexB2,
  
  outRsSelect[2],outBank[2],rsFound[2],outInstrIndex2,
  outRsSelect[3],outBank[3],rsFound[3],outInstrIndex3,
  32'b0,4'b0,1'b0,
  );

  rs_nonWakeUp_array #(4) attrA_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newAttr0,
  newRsSelect1,newAttr1,
  newRsSelect2,newAttr2,
  
  outRsSelect[0],outBank[0],rsFound[0],outAttr0,
  outRsSelect[1],outBank[1],rsFound[1],outAttr1,
  32'b0,4'b0,1'b0,
  );

  rs_nonWakeUp_array #(4) attrB_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newAttr0,
  newRsSelect1,newAttr1,
  newRsSelect2,newAttr2,
  
  outRsSelect[2],outBank[2],rsFound[2],outAttr2,
  outRsSelect[3],outBank[3],rsFound[3],outAttr3,
  32'b0,4'b0,1'b0,
  );

  rs_nonWakeUp_array #(LSQ_WIDTH) lsqA_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newLSQA0,
  newRsSelect1,newLSQA1,
  newRsSelect2,newLSQA2,
  
  outRsSelect[0],outBank[0],rsFound[0],outLSQ0,
  outRsSelect[1],outBank[1],rsFound[1],outLSQ1,
  32'b0,4'b0,1'b0,
  );

  rs_nonWakeUp_array #(LSQ_WIDTH) lsqB_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newLSQB0,
  newRsSelect1,newLSQB1,
  newRsSelect2,newLSQB2,
  
  outRsSelect[2],outBank[2],rsFound[2],outLSQ2,
  outRsSelect[3],outBank[3],rsFound[3],outLSQ3,
  32'b0,4'b0,1'b0,
  );

endmodule
