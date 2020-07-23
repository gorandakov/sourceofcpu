`include "../struct.sv"

module cole(
  clk,
  rst,
  bus_data,
  bus_slot,
  bus_en,
  req_addr,
  req_slot,
  req_en,
  outp_data,
  outp_addr,
  outp_slot,
  outp_en,
  );
  localparam PHYS_WIDTH=44;
  localparam VIRT_WIDTH=64;
  localparam IP_WIDTH=48;
  localparam [31:0] INIT_IP=32'h0;
  localparam BUS_BANK=32;
  localparam BUS_WIDTH=BUS_BANK*16;
  localparam DATA_WIDTH=65*8;
  localparam INSTR_WIDTH=80;
  localparam CLS_WIDTH=12;
  localparam INSTR_WIDTH=80;
  localparam INSTRQ_WIDTH=`instrQ_width;
  localparam EXTRACONST_WIDTH=`extraconst_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam REG_WIDTH=6;
  localparam IP_WIDTH=48;
  localparam REG_BP=5;
  localparam REG_SP=4;
  localparam PORT_LOAD=4'd1;
  localparam PORT_STORE=4'd2;
  localparam PORT_SHIFT=4'd3;
  localparam PORT_ALU=4'd4;
  localparam PORT_MUL=4'd5;
  localparam PORT_FADD=4'd6;
  localparam PORT_FMUL=4'd7;
  localparam PORT_FANY=4'd8;
  localparam PORT_VADD=4'd9;
  localparam PORT_VCMP=4'd10;
  localparam PORT_VANY=4'd11;
  localparam REOR_WIDTH=24; 
  localparam TRICNT_TOP=40;//really 38; 2 redundant
  parameter [4:0] BUS_ID=0;
 
  input clk;
  input rst;
  input [BUS_WIDTH-1:0] bus_data;
  input [9:0] bus_slot;
  input bus_en;
  output [36:0] req_addr;
  output [9:0] req_slot;
  output req_en;
  output [BUS_WIDTH-1:0] outp_data;
  output [36:0] outp_addr;
  output [9:0] outp_slot;
  output outp_en;
  
  
  wire except;
  wire [VIRT_WIDTH-18:0] exceptIP;
  wire exceptThread;
  wire exceptDueJump;
  wire [7:0] exceptJumpGHT;
  wire exceptLDConfl;
  wire [3:0] except_jmask;
  wire except_jmask_en;
  wire jupd0_en;
  wire jupdt0_en;
  wire jupd0_ght_en;
  wire [15:0] jupd0_addr;
  wire [12:0] jupd0_baddr;
  wire [1:0] jupd0_sc;
  wire jupd0_tk;
  wire jupd1_en=1'b0;
  wire jupdt1_en=1'b0;
  wire jupd1_ght_en=1'b0;
  wire [15:0] jupd1_addr=16'b0;
  wire [12:0] jupd1_baddr=13'b0;
  wire [1:0] jupd1_sc=2'b0;
  wire jupd1_tk=1'b0;



  wire [36:0] cc_req_addr;
  wire [9:0] cc_req_slot;
  wire cc_req_en;
  wire cc_req_tlbEn;

  wire [`ctlbData_width-1:0] cc_bus_tlb_data;
  wire [9:0] cc_bus_tlb_slot;
  wire cc_bus_tlb_en;

  wire [INSTR_WIDTH-1:0] instr0;
  wire [INSTR_WIDTH-1:0] instr1;
  wire [INSTR_WIDTH-1:0] instr2;
  wire [INSTR_WIDTH-1:0] instr3;
  wire [INSTR_WIDTH-1:0] instr4;
  wire [INSTR_WIDTH-1:0] instr5;
  wire [INSTR_WIDTH-1:0] instr6;
  wire [INSTR_WIDTH-1:0] instr7;
  wire [INSTR_WIDTH-1:0] instr8;
  wire [INSTR_WIDTH-1:0] instr9;

  wire [`instrQ_width-1:0] extra0;
  wire [`instrQ_width-1:0] extra1;
  wire [`instrQ_width-1:0] extra2;
  wire [`instrQ_width-1:0] extra3;
  wire [`instrQ_width-1:0] extra4;
  wire [`instrQ_width-1:0] extra5;
  wire [`instrQ_width-1:0] extra6;
  wire [`instrQ_width-1:0] extra7;
  wire [`instrQ_width-1:0] extra8;
  wire [`instrQ_width-1:0] extra9;


  wire [9:0] instrEat;
  wire [9:0] iAvail;
  wire stall;

  assign instrEat[9:2]=8'b0;
  
  wire [2:0] btbl_step;
  wire [IP_WIDTH-2:0] btbl_IP0;
  wire [IP_WIDTH-2:0] btbl_IP1;
  wire [3:0] btbl_mask0;
  wire [3:0] btbl_mask1;
  
  wire csrss_en;
  wire [15:0] csrss_addr;
  wire [63:0] csrss_data;


  frontend1 fend_moe(
  clk,
  rst,
  except,
  exceptIP,
  exceptThread,
  exceptDueJump,
  exceptJumpGHT,
  exceptLDConfl,
  except_jmask,
  except_jmask_en,
  jupd0_en,jupdt0_en,jupd0_ght_en,jupd0_addr,jupd0_baddr,jupd0_sc,jupd0_tk,
  jupd1_en,jupdt1_en,jupd1_ght_en,jupd1_addr,jupd1_baddr,jupd1_sc,jupd1_tk,
  bus_data,
  bus_slot,
  bus_en,
  req_addr,
  req_slot,
  req_en,
  req_tlbEn,
  bus_tlb_data,
  bus_tlb_slot,
  bus_tlb_en,
  instr0,instr1,instr2,instr3,
  instr4,instr5,instr6,instr7,
  instr8,instr9,
  extra0,extra1,extra2,extra3,
  extra4,extra5,extra6,extra7,
  extra8,extra9,
  instrEat,
  iAvail,
  stall,
  btbl_step,
  btbl_IP0,
  btbl_IP1,
  btbl_mask0,
  btbl_mask1,
  csrss_en,csrss_addr,csrss_data
  );

  
  
  wire [OPERATION_WIDTH-1:0] i0_operation;
  wire can_jump_csr;
  wire [REG_WIDTH-1:0] i0_rA;
  wire i0_rA_use;
  wire [REG_WIDTH-1:0] i0_rB;
  wire i0_rB_use;
  wire [REG_WIDTH-1:0] i0_rC;
  wire i0_rC_use;
  wire i0_useCRet;
  wire i0_useBConst;
//  output reg useBSmall;//small constant use; used for call/pop/push
  wire [63:0] i0_constant;
//  output reg [3:0] smallConst; //signed
  wire [REG_WIDTH-1:0] i0_rT;
  wire i0_rT_use;
  wire [3:0] i0_port;
  wire i0_useRs;
  wire i0_rA_useF,i0_rB_useF,i0_rT_useF,i0_rC_useF,i0_maskOp;
  wire i0_rA_isV,i0_rB_isV,i0_rT_isV,i0_rBT_copyV;
  wire i0_flags_use;
  wire i0_flags_write;
  wire i0_instr_fsimd;
  wire i0_halt;
  
  wire i0_isJump;
  wire i0_jumpTaken;
  wire [4:0] i0_jumpType;
  wire i0_jumpBtbHit;
  wire i0_jumpIndir;
  
  wire i0_prevSpecLoad;
  wire i0_thisSpecLoad;
  wire i0_isIPRel;
  wire i0_rAlloc;
  wire reor_en;
  wire [39:0] reor_val;
  wire i0_reor_en_out;
  wire [39:0] i0_reor_val_out;
  wire i0_error;

 smallInstr_decoder dec0(
  clk,
  rst,
  1'b1,
  extra0_swp,
  instr0_swp,
  i0_operation,
  can_jump_csr,//?
  i0_rA,i0_rA_use,
  i0_rB,i0_rB_use,i0_useBConst,//useBSmall,
  i0_rC,i0_rC_use,i0_useCRet,
  i0_constant,
//  smallConst,
  i0_rT,i0_rT_use,
  i0_port,
  i0_useRs,
  i0_rA_useF,i0_rB_useF,i0_rT_useF,i0_rC_useF,i0_maskOp,
  i0_rA_isV,i0_rB_isV,i0_rT_isV,
  i0_rBT_copyV,
  ,,
  ,
  i0_flags_use,
  i0_flags_write,
  i0_instr_fsimd,//choose simd-like over extended instr
  i0_halt,
  
  ,
  ,
  i0_isJump,
  i0_jumpTaken,
  i0_jumpType,
  i0_jumpBtbHit,
  i0_jumpIndir,
  i0_prevSpecLoad,
  i0_thisSpecLoad,
  i0_isIPRel,
  i0_rAlloc,
  reor_en,
  reor_val,
  i0_reor_en_out,
  i0_reor_val_out,
  i0_error
  );
 
  wire [OPERATION_WIDTH-1:0] i1_operation;
  wire [REG_WIDTH-1:0] i1_rA;
  wire i1_rA_use;
  wire [REG_WIDTH-1:0] i1_rB;
  wire i1_rB_use;
  wire [REG_WIDTH-1:0] i1_rC;
  wire i1_rC_use;
  wire i1_useCRet;
  wire i1_useBConst;
//  output reg useBSmall;//small constant use; used for call/pop/push
  wire [63:0] i1_constant;
//  output reg [3:0] smallConst; //signed
  wire [REG_WIDTH-1:0] i1_rT;
  wire i1_rT_use;
  wire [3:0] i1_port;
  wire i1_useRs;
  wire i1_rA_useF,i1_rB_useF,i1_rT_useF,i1_rC_useF,i1_maskOp;
  wire i1_rA_isV,i1_rB_isV,i1_rT_isV,i1_rBT_copyV;
  wire i1_flags_use;
  wire i1_flags_write;
  wire i1_instr_fsimd;
  wire i1_halt;
  
  wire i1_isJump;
  wire i1_jumpTaken;
  wire [4:0] i1_jumpType;
  wire i1_jumpBtbHit;
  wire i1_jumpIndir;
  
  wire i1_prevSpecLoad;
  wire i1_thisSpecLoad;
  wire i1_isIPRel;
  wire i1_rAlloc;
  wire i1_reor_en_out;
  wire [39:0] i1_reor_val_out;
  wire i1_error;

 smallInstr_decoder dec1(
  clk,
  rst,
  1'b1,
  extra1_swp,
  instr1_swp,
  i1_operation,
  can_jump_csr,//?
  i1_rA,i1_rA_use,
  i1_rB,i1_rB_use,i1_useBConst,//useBSmall,
  i1_rC,i1_rC_use,i1_useCRet,
  i1_constant,
//  smallConst,
  i1_rT,i1_rT_use,
  i1_port,
  i1_useRs,
  i1_rA_useF,i1_rB_useF,i1_rT_useF,i1_rC_useF,i1_maskOp,
  i1_rA_isV,i1_rB_isV,i1_rT_isV,
  i1_rBT_copyV,
  ,,
  ,
  i1_flags_use,
  i1_flags_write,
  i1_instr_fsimd,//choose simd-like over extended instr
  i1_halt,
  
  ,
  ,
  i1_isJump,
  i1_jumpTaken,
  i1_jumpType,
  i1_jumpBtbHit,
  i1_jumpIndir,
  i1_prevSpecLoad,
  i1_thisSpecLoad,
  i1_isIPRel,
  i1_rAlloc,
  reor_en,
  reor_val,
  i1_reor_en_out,
  i1_reor_val_out,
  i1_error
  );

  wire [CLS_WIDTH-1:0] class0;
  wire [CLS_WIDTH-1:0] class1;
  wire busy_wait;

  assign instrEat[0]=~busy_wait;
  assign instrEat[1]=(class0[`iclass_store] || class0[`iclass_jump])^
    (class1[`iclass_store] || class1[`iclass_jump]) ||
    class0[`iclass_load] ^ class1[`iclass_load];

  wire [64:0] i0_dataA_pre;
  wire [64:0] i0_dataB_pre;
  wire [64:0] i1_dataA_pre;
  wire [64:0] i1_dataB_pre;
  wire [64:0] i1_stdata_pre;

  rrf #(67) regI0_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(clkEn),
  .read0_addr(i0_rA),.read0_data(i0_dataA_pre),.read0_oe(1'b1),
  .read1_addr(i0_rB),.read1_data(i0_dataB_pre),.read1_oe(1'b1),
  .read2_addr(i1_rA),.read2_data(i1_dataA_pre),.read2_oe(1'b1),
  .read3_addr(i1_rB),.read3_data(i1_dataB_pre),.read3_oe(1'b1),
  .read4_addr(i1_rC_reg),.read4_data(i1_stdata_pre),.read4_oe(1'b1),
  .read5_addr(i1_rA_reg),.read5_data(i1_dataA_cmp1),.read5_oe(1'b1),
  .read6_addr(i1_rB_reg),.read6_data(i1_dataB_cmp1),.read6_oe(1'b1),
  .read7_addr(5'b0),.read7_data(),.read7_oe(1'b1),
  .read8_addr(5'b0),.read8_data(),.read8_oe(1'b1),
  .write0_addr(i0_rT_reg),.write0_data(al0_res),.write0_wen(al0_en_reg),
  .write1_addr(ld0_addr),.write1_data(ld0_res),.write1_wen(ld0_en_reg),
  .write2_addr(i1_rT_reg),.write2_data(al1_res),.write2_wen(al1_en_reg),
  .write3_addr(i0_rT_p_reg),.write3_data(x_alu0_res),.write3_wen(al0_en_reg6|
    al1_en_reg6),
  .write4_addr(i1_rT_p_reg5),.write4_data(x_alu1_res),.write4_wen(mul_en_reg5),
  .write5_addr(5'b0),.write5_data(),.write5_wen(1'b0),
  .write6_addr(5'b0),.write6_data(),.write6_wen(1'b0),
  .write7_addr(5'b0),.write7_data(),.write7_wen(1'b0),
  .write8_addr(5'b0),.write8_data(),.write8_wen(1'b0),
  .read_thread(1'b0),
  .write_thread(1'b0)
  );

  rrf #(67) regI1_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(clkEn),
  .read0_addr(i0_rA_p),.read0_data(i0_dataA_post),.read0_oe(1'b1),
  .read1_addr(i0_rB_p),.read1_data(i0_dataB_post),.read1_oe(1'b1),
  .read2_addr(i1_rA_p),.read2_data(i1_dataA_cmp2),.read2_oe(1'b1),
  .read3_addr(i1_rB_p),.read3_data(i1_dataB_cmp2),.read3_oe(1'b1),
  .read4_addr(i1_rC_p_reg),.read4_data(i1_stdata_post),.read4_oe(1'b1),
  .read5_addr(5'b0),.read5_data(),.read5_oe(1'b1),
  .read6_addr(5'b0),.read6_data(),.read6_oe(1'b1),
  .read7_addr(5'b0),.read7_data(),.read7_oe(1'b1),
  .read8_addr(5'b0),.read8_data(),.read8_oe(1'b1),
  .write0_addr(i0_rT_p_reg),.write0_data(x_alu0_res),.write0_wen(al0_en_reg6|
    al1_en_reg6),
  .write1_addr(ld0_addr),.write1_data(ld0_res),.write1_wen(ld0_en_reg),
  .write2_addr(i1_rT_p_reg5),.write2_data(x_alu1_res),.write2_wen(mul_en_reg5),
  .write3_addr(5'b0),.write3_data(),.write3_wen(1'b0),
  .write4_addr(5'b0),.write4_data(),.write4_wen(1'b0),
  .write5_addr(5'b0),.write5_data(),.write5_wen(1'b0),
  .write6_addr(5'b0),.write6_data(),.write6_wen(1'b0),
  .write7_addr(5'b0),.write7_data(),.write7_wen(1'b0),
  .write8_addr(5'b0),.write8_data(),.write8_wen(1'b0),
  .read_thread(1'b0),
  .write_thread(1'b0)
  );

  assign conflA0_mem=
  (i0_rA==i0_rT_reg5 && i0_rA_use && i0_rT_use_reg5) ||
  (i0_rA==i0_rT_reg4 && i0_rA_use && i0_rT_use_reg4) ||
  (i0_rA==i0_rT_reg3 && i0_rA_use && i0_rT_use_reg3) ||
  (i0_rA==i0_rT_reg2 && i0_rA_use && i0_rT_use_reg2) ||
  (i0_rA==i0_rT_reg  && i0_rA_use && i0_rT_use_reg ) ||
  (i0_rA==i1_rT_reg5 && i0_rA_use && i1_rT_use_reg5) ||
  (i0_rA==i1_rT_reg4 && i0_rA_use && i1_rT_use_reg4) ||
  (i0_rA==i1_rT_reg3 && i0_rA_use && i1_rT_use_reg3) ||
  (i0_rA==i1_rT_reg2 && i0_rA_use && i1_rT_use_reg2) ||
  (i0_rA==i1_rT_reg  && i0_rA_use && i1_rT_use_reg );
  assign conflA1_mem=
  (i1_rA==i0_rT_reg5 && i1_rA_use && i0_rT_use_reg5) ||
  (i1_rA==i0_rT_reg4 && i1_rA_use && i0_rT_use_reg4) ||
  (i1_rA==i0_rT_reg3 && i1_rA_use && i0_rT_use_reg3) ||
  (i1_rA==i0_rT_reg2 && i1_rA_use && i0_rT_use_reg2) ||
  (i1_rA==i0_rT_reg  && i1_rA_use && i0_rT_use_reg ) ||
  (i1_rA==i1_rT_reg5 && i1_rA_use && i1_rT_use_reg5) ||
  (i1_rA==i1_rT_reg4 && i1_rA_use && i1_rT_use_reg4) ||
  (i1_rA==i1_rT_reg3 && i1_rA_use && i1_rT_use_reg3) ||
  (i1_rA==i1_rT_reg2 && i1_rA_use && i1_rT_use_reg2) ||
  (i1_rA==i1_rT_reg  && i1_rA_use && i1_rT_use_reg );
  assign conflB0_mem=
  (i0_rB==i0_rT_reg5 && i0_rB_use && i0_rT_use_reg5) ||
  (i0_rB==i0_rT_reg4 && i0_rB_use && i0_rT_use_reg4) ||
  (i0_rB==i0_rT_reg3 && i0_rB_use && i0_rT_use_reg3) ||
  (i0_rB==i0_rT_reg2 && i0_rB_use && i0_rT_use_reg2) ||
  (i0_rB==i0_rT_reg  && i0_rB_use && i0_rT_use_reg ) ||
  (i0_rB==i1_rT_reg5 && i0_rB_use && i1_rT_use_reg5) ||
  (i0_rB==i1_rT_reg4 && i0_rB_use && i1_rT_use_reg4) ||
  (i0_rB==i1_rT_reg3 && i0_rB_use && i1_rT_use_reg3) ||
  (i0_rB==i1_rT_reg2 && i0_rB_use && i1_rT_use_reg2) ||
  (i0_rB==i1_rT_reg  && i0_rB_use && i1_rT_use_reg );
  assign conflB1_mem=
  (i1_rB==i0_rT_reg5 && i1_rB_use && i0_rT_use_reg5) ||
  (i1_rB==i0_rT_reg4 && i1_rB_use && i0_rT_use_reg4) ||
  (i1_rB==i0_rT_reg3 && i1_rB_use && i0_rT_use_reg3) ||
  (i1_rB==i0_rT_reg2 && i1_rB_use && i0_rT_use_reg2) ||
  (i1_rB==i0_rT_reg  && i1_rB_use && i0_rT_use_reg ) ||
  (i1_rB==i1_rT_reg5 && i1_rB_use && i1_rT_use_reg5) ||
  (i1_rB==i1_rT_reg4 && i1_rB_use && i1_rT_use_reg4) ||
  (i1_rB==i1_rT_reg3 && i1_rB_use && i1_rT_use_reg3) ||
  (i1_rB==i1_rT_reg2 && i1_rB_use && i1_rT_use_reg2) ||
  (i1_rB==i1_rT_reg  && i1_rB_use && i1_rT_use_reg );

  assign al0_res[65]=conflA0_reg | conflB0_reg;
  assign al1_res[65]=conflA1_reg | conflB1_reg;
  assign x_alu0_res[65]=1'b0;
  assign x_alu1_res[65]=1'b0;
  assign ld0_res[65]=1'b0;

  assign stall_int=
  (al0_en_reg | (~conflA0_red && ~conflB0_reg) | ~instrEat_reg2[0]) &&
  (al1_en_reg | (~conflA1_red && ~conflB1_reg) | ~instrEat_reg2[1]);

  assign stall_int_dep=class0_REG2[`iclass_alu] | class0_REG2[
    `iclass_shift] && class1_REG2[`iclass_load] && i0_rT_use_reg &&
    (i1_rA_reg==i0_rT_reg && i1_rA_use) |(i1_rB_reg==i0_rT_reg && i1_rB_use)|
    (i1_rC_reg==i0_rT_reg && i1_rC_use);

  assign al0_en=~class0_reg[`iclass_load] && i0_rT_use;
  assign al1_en=i1_rT_use;
  assign ld0_en=class0_reg[`iclass_load] && i0_rT_use;
  
  

  fu_alu alu_fu(
  .clk(clk),
  .rst(rst),
  .except(1'b0),
  .u1_A(i1_dataA_cmp1[64:0]),.u1_B(i1_dataB_cmp1[64:0]),.u1_S(flags_cmp1),
    .u1_op(i1_operation_reg),.u1_ret(i1_rtEnC),.u1_rten(i1_rtEnC),
    .u1_clkEn(al1_en_reg),
    .u1_A_fufwd(i1_Ac1_f),.u1_A_fuufwd(i1_Ac1_ff),
    .u1_B_fufwd(i1_Bc1_f),.u1_B_fuufwd(i1_Bc1_ff),
    .u1_S_fufwd(Sc1_f),.u1_S_fuufwd(Sc1_ff),
  .u2_A(i0_dataA_pre[64:0]),.u2_B(i0_dataB_pre[64:0]),.u2_S(flags_pre),
    .u2_op(i0_operation),.u2_ret(i0_rtEn),.u2_rten(i0_rtEn),
    .u2_clkEn(al0_en),
    .u2_A_fufwd(i0_A_f),.u2_A_fuufwd(i0_A_ff),
    .u2_B_fufwd(i0_B_f),.u2_B_fuufwd(i0_B_ff),
    .u2_S_fufwd(S_f),.u2_S_fuufwd(S_ff),
  .u3_A(i1_dataA_cmp2[64:0]),.u3_B(i1_dataB_cmp2[64:0]),.u3_S(flags_cmp2),
    .u3_op(i1_operation_post),.u3_ret(i1_rtEnC),.u3_rten(i1_rtEnC),
    .u3_clkEn(al1_en_post),
    .u3_A_fufwd(i1_Ac2_f),.u3_A_fuufwd(i1_Ac2_ff),
    .u3_B_fufwd(i1_Bc2_f),.u3_B_fuufwd(i1_Bc2_ff),
    .u3_S_fufwd(Sc2_f),.u3_S_fuufwd(Sc2_ff),
  .u4_A(i1_dataA_pre[64:0]),.u4_B(i1_dataB_pre[64:0]),.u4_S(flags_pre),
    .u4_op(i1_operation),.u4_ret(i1_rtEn),.u4_rten(i1_rtEn),
    .u4_clkEn(al1_en),
    .u4_A_fufwd(i1_A_f),.u4_A_fuufwd(i1_A_ff),
    .u4_B_fufwd(i1_B_f),.u4_B_fuufwd(i1_B_ff),
    .u4_S_fufwd(S_f),.u4_S_fuufwd(S_ff),
  .u5_A(65'b0),.u5_B(65'b0),.u5_S(65'b0),
    .u5_nDataAlt(1'b0),.u5_op(13'b0),.u5_ret(),.u5_rten(),
    .u5_clkEn(1'b0),
    .u5_A_fufwd(4'hf),.u5_A_fuufwd(4'hf),.u5_B_fufwd(4'hf),
    .u5_B_fuufwd(4'hf),
    .u5_S_fufwd(4'hf),.u5_S_fuufwd(4'hf),
  .u6_A(i0_dataA_post[64:0]),.u6_B(i0_dataB_post[64:0]),.u6_S(flags_post),
    .u6_op(i0_operation_post),.u6_ret(i0_rtEn_p),.u6_rten(i0_rtEn_p),
    .u6_clkEn(al0_en_post),
    .u6_A_fufwd(i0_Ap_f),.u6_A_fuufwd(i0_Ap_ff),
    .u6_B_fufwd(i0_Bp_f),.u6_B_fuufwd(i0_Bp_ff),
    .u6_S_fufwd(Sp_f),.u6_S_fuufwd(Sp_ff),
  .FU0(65'b0), .FU1(65'b0),  .FU2(65'b0),  .FU3(ld0_res[64:0]),
  .FU4(65'b0), .FU5(al0_res[64:0]),  .FU6(x_alu1_res[64:0]),  .FU7(al1_res[64:0]),
  .FU8(65'b0), .FU9(x_alu0_res[64:0]),
  FUS1,  FUS2,  FUS3,
  FUS4, FUS5,  FUS6,  FUS7,
  FUS8,FUS9,
  fxFRT_alten_reg,
  fcvtout,
  DataAlt
  );

  always @(posedge clk) begin
    if (rst) begin
        instr0_swp<=80'b0;
        extra0_swp<={INSTRQ_WIDTH{1'b0}};
        instr1_swp<=80'b0;
        extra1_swp<={INSTRQ_WIDTH{1'b0}};
        instrEat_reg<=2'b0;
    end else if (clkEn) begin
        instr0_swp<=(class0[`iclass_store] | class0[`iclass_jump] |(class0[
          `iclass_alu] & ~class0[`iclass_jump] & class1[`iclass_load]) && 
          instrEat[1]) ? instr1 : instr0;
        instr1_swp<=(class0[`iclass_store] | class0[`iclass_jump] |(class0[
          `iclass_alu] & ~class0[`iclass_jump] & class1[`iclass_load]) && 
          instrEat[1]) ?
          instr0 : instr1;
        extra0_swp<=(class0[`iclass_store] | class0[`iclass_jump] |(class0[
          `iclass_alu] & ~class0[`iclass_jump] & class1[`iclass_load]) && 
          extraEat[1]) ? extra1 : extra0;
        extra1_swp<=(class0[`iclass_store] | class0[`iclass_jump] |(class0[
          `iclass_alu] & ~class0[`iclass_jump] & class1[`iclass_load]) && 
          instrEat[1]) ?
          extra0 : extra1;
        instrEat_reg<=instrEat_reg[1:0];
    end
  end
