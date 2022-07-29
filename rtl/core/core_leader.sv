`include "../../rtl/struct.sv"


module heptane_core(
  clk,
  rst,
  rbusIn_signals,rbusIn_src_req,rbusIn_dst_req,rbusIn_address,
  rbusOut_signals,rbusOut_src_req,rbusOut_dst_req,rbusOut_address,rbusOut_can,rbusOut_want,rbusOut_sz,rbusOut_bank0,rbusOut_low,
  rbusDIn_signals,rbusDIn_src_req,rbusDIn_dst_req,rbusDIn_data,rbusDIn_dataPTR,
  rbusDOut_signals,rbusDOut_src_req,rbusDOut_dst_req,rbusDOut_data,rbusDOut_dataPTR,rbusDOut_can,rbusDOut_want,rbusDOut_replay,
  extIP_en,
  extIP_addr0,
  extIP_addr1
);
  parameter [4:0] BUS_ID=0;
  localparam PHYS_WIDTH=44;
  localparam VIRT_WIDTH=64;
  localparam IP_WIDTH=48;
  localparam [31:0] INIT_IP=32'h20;
  localparam BUS_BANK=32;
  localparam BUS_WIDTH=BUS_BANK*16;
  localparam DATA_WIDTH=65*4;
  localparam INSTR_WIDTH=80;
  localparam IN_REG_WIDTH=6;
  localparam OPERATION_WIDTH=`operation_width;
  localparam PORT_WIDTH=4;
  localparam RS_WIDTH=65;
  localparam REQ_WIDTH=10;

  input clk;
  input rst;
  input [`rbus_width-1:0] rbusIn_signals;
  input [9:0] rbusIn_src_req;
  input [9:0] rbusIn_dst_req;
  input [36:0] rbusIn_address;
  output [`rbus_width-1:0] rbusOut_signals;
  output [9:0] rbusOut_src_req;
  output [9:0] rbusOut_dst_req;
  output [36:0] rbusOut_address;
  output rbusOut_want;
  input rbusOut_can;
  output [4:0] rbusOut_sz;
  output [4:0] rbusOut_bank0;
  output [1:0] rbusOut_low;
  input [`rbusD_width-1:0] rbusDIn_signals;
  input [9:0] rbusDIn_src_req;
  input [9:0] rbusDIn_dst_req;
  input [511:0] rbusDIn_data;
  input [7:0] rbusDIn_dataPTR;
  output [`rbusD_width-1:0] rbusDOut_signals;
  output [9:0] rbusDOut_src_req;
  output [9:0] rbusDOut_dst_req;
  output [511:0] rbusDOut_data;
  output [7:0] rbusDOut_dataPTR;
  input rbusDOut_can;
  output rbusDOut_want;
  output rbusDOut_replay;
  output reg extIP_en;
  output reg [64:0] extIP_addr0;
  output reg [64:0] extIP_addr1;

 
 // reg [63:0] r02_data;
 // reg r02_en;
/*  wire [5:0] wrtII=bck_mod.PSTQ_en[0] ? bck_mod.PSTQ_data[0][117:112] : bck_mod.PSTQ_data[1][117:112];
  wire [5:0] dataAII=bck_mod.LSQ_dataA0[117:112];
  reg [63:0] wdata_reg[1:0];
  reg [63:0] wdata_reg2[1:0];
  reg [63:0] wdata_reg3[1:0];
*/
//  reg clk=1'b0;
//  reg clkX=1'b1;
//  reg rst=1'b1;
//  reg fstall=1'b0;
  wire [BUS_WIDTH-1:0] bus_data;
  wire [9:0] bus_slot;
  wire bus_en;
  
  wire [37:0] req_addr;
  wire [9:0] req_slot;
  wire req_en;
  wire req_tlbEn;
  wire [3:0] req_tlbAttr;
  reg [37:0] req_addr_reg;
  reg [9:0] req_slot_reg;
  reg req_en_reg;

  wire [`ctlbData_width-1:0] bus_tlb_data;
  reg [9:0] bus_tlb_slot;
  wire bus_tlb_en;

  wire [DATA_WIDTH-1:0] read_data;
  wire instrFed;
  wire [255:0] read_data_strip;
  
  wire except;
  wire fp_excpt_en;
  wire [10:0] fp_excpt_set; 
  wire [VIRT_WIDTH-2:0] exceptIP;

  wire exceptThread;
  wire [3:0] exceptAttr;
  wire exceptBoth;
  wire [5:0] exceptTrceAddr=6'b0;
  wire [4:0] exceptTrceAddrLow=5'b0;
  wire except_due_jump;
  wire [7:0] except_ght;
  wire except_flag;
  wire except_jmask_en;
  wire [3:0] except_jmask;
  wire jupd0_en;//jupd
  wire jupdt0_en;
  wire jupd0_ght_en;
  wire [15:0] jupd0_addr;
  wire [12:0] jupd0_baddr;
  wire [1:0] jupd0_sc;
  wire jupd0_tk;
  wire jupd1_en;
  wire jupdt1_en;
  wire jupd1_ght_en;
  wire [15:0] jupd1_addr;
  wire [12:0] jupd1_baddr;
  wire [1:0] jupd1_sc;
  wire jupd1_tk;

  reg jupd_reg,jupd_reg2;

  wire [`ctlbData_width-1:0] bus_tlb_data_d;

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


  wire [9:0] instrEn;
  wire [9:0] iAvail;
  wire stall;

  wire [2:0] btbl_step;
  wire [62:0] btbl_IP0;
  wire [62:0] btbl_IP1;
  wire [3:0] btbl_mask0;
  wire [3:0] btbl_mask1;
  wire [3:0] btbl_attr0;
  wire [3:0] btbl_attr1;
  
  wire [9:0] iUsed;
  
  
  wire halt;
  
  wire bundleFeed;
  

  wire [IN_REG_WIDTH-1:0] rs0i0_rA;
  wire rs0i0_rA_use;
  wire rs0i0_rA_useF;
  wire rs0i0_rA_isV;
  wire rs0i0_rA_isAnyV;
  wire [IN_REG_WIDTH-1:0] rs0i0_rB;
  wire rs0i0_rB_use;
  wire rs0i0_rB_useF;
  wire rs0i0_rB_isV;
  wire rs0i0_rB_isAnyV;
  wire rs0i0_useBConst;
  wire [IN_REG_WIDTH-1:0] rs0i0_rT;
  wire rs0i0_rT_use;
  wire rs0i0_rT_useF;
  wire rs0i0_rT_isV;
  wire [PORT_WIDTH-1:0] rs0i0_port;
  wire [OPERATION_WIDTH-1:0] rs0i0_operation;
  wire rs0i0_en;
  wire [RS_WIDTH-1:0] rs0i0_const;
  wire [3:0] rs0i0_index;
  wire rs0i0_IPRel;
  wire rs0i0_afterTaken;
  wire rs0i0_alt;
//  wire rs0i0_both;
  wire rs0i0_alloc;
  wire rs0i0_allocF;
  wire rs0i0_allocR;
  wire [5:0] rs0i0_lsi;
  wire rs0i0_ldst_flag;
  wire rs0i0_enA;
  wire rs0i0_enB;
 
  wire [IN_REG_WIDTH-1:0] rs0i1_rA;
  wire rs0i1_rA_use;
  wire rs0i1_rA_useF;
  wire rs0i1_rA_isV;
  wire rs0i1_rA_isAnyV;
  wire rs0i1_useAConst;
  wire [IN_REG_WIDTH-1:0] rs0i1_rB;
  wire rs0i1_rB_use;
  wire rs0i1_rB_useF;
  wire rs0i1_rB_isV;
  wire rs0i1_rB_isAnyV;
  wire rs0i1_useBConst;
  wire [IN_REG_WIDTH-1:0] rs0i1_rT;
  wire rs0i1_rT_use;
  wire rs0i1_rT_useF;
  wire rs0i1_rT_isV;
  wire [PORT_WIDTH-1:0] rs0i1_port;
  wire [OPERATION_WIDTH-1:0] rs0i1_operation;
  wire rs0i1_en;
  wire [RS_WIDTH-1:0] rs0i1_const;
  wire [3:0] rs0i1_index;
  wire rs0i1_IPRel;
  wire rs0i1_afterTaken;
  wire rs0i1_alloc;
  wire rs0i1_allocF;
  wire rs0i1_allocR;
  wire [3:0] rs0i1_flagDep;
  wire rs0i1_lastFl;
  wire [5:0] rs0i1_lsi;
  wire rs0i1_ldst_flag;
  wire rs0i1_flag_wr;
  
  wire [IN_REG_WIDTH-1:0] rs0i2_rA;
  wire rs0i2_rA_use;
  wire rs0i2_rA_useF;
  wire rs0i2_rA_isV;
  wire rs0i2_rA_isAnyV;
  wire rs0i2_useAConst;
  wire [IN_REG_WIDTH-1:0] rs0i2_rB;
  wire rs0i2_rB_use;
  wire rs0i2_rB_useF;
  wire rs0i2_rB_isV;
  wire rs0i2_rB_isAnyV;
  wire rs0i2_useBConst;
  wire [IN_REG_WIDTH-1:0] rs0i2_rT;
  wire rs0i2_rT_use;
  wire rs0i2_rT_useF;
  wire rs0i2_rT_isV;
  wire [PORT_WIDTH-1:0] rs0i2_port;
  wire [OPERATION_WIDTH-1:0] rs0i2_operation;
  wire rs0i2_en;
  wire [RS_WIDTH-1:0] rs0i2_const;
  wire [3:0] rs0i2_index;
  wire rs0i2_IPRel;
  wire rs0i2_afterTaken;
  wire rs0i2_alloc;
  wire rs0i2_allocF;
  wire rs0i2_allocR;
  wire [3:0] rs0i2_flagDep;
  wire rs0i2_lastFl;
  wire rs0i2_flag_wr;
  
  wire [IN_REG_WIDTH-1:0] rs1i0_rA;
  wire rs1i0_rA_use;
  wire rs1i0_rA_useF;
  wire rs1i0_rA_isV;
  wire rs1i0_rA_isAnyV;
  wire [IN_REG_WIDTH-1:0] rs1i0_rB;
  wire rs1i0_rB_use;
  wire rs1i0_rB_useF;
  wire rs1i0_rB_isV;
  wire rs1i0_rB_isAnyV;
  wire rs1i0_useBConst;
  wire [IN_REG_WIDTH-1:0] rs1i0_rT;
  wire rs1i0_rT_use;
  wire rs1i0_rT_useF;
  wire rs1i0_rT_isV;
  wire [PORT_WIDTH-1:0] rs1i0_port;
  wire [OPERATION_WIDTH-1:0] rs1i0_operation;
  wire rs1i0_en;
  wire [RS_WIDTH-1:0] rs1i0_const;
  wire [3:0] rs1i0_index;
  wire rs1i0_IPRel;
  wire rs1i0_afterTaken;
  wire rs1i0_alt;
//  wire rs1i0_both;
  wire rs1i0_alloc;
  wire rs1i0_allocF;
  wire rs1i0_allocR;
  wire [5:0] rs1i0_lsi;
  wire rs1i0_ldst_flag;
  wire rs1i0_enA;
  wire rs1i0_enB;
  
  wire [IN_REG_WIDTH-1:0] rs1i1_rA;
  wire rs1i1_rA_use;
  wire rs1i1_rA_useF;
  wire rs1i1_rA_isV;
  wire rs1i1_rA_isAnyV;
  wire rs1i1_useAConst;
  wire [IN_REG_WIDTH-1:0] rs1i1_rB;
  wire rs1i1_rB_use;
  wire rs1i1_rB_useF;
  wire rs1i1_rB_isV;
  wire rs1i1_rB_isAnyV;
  wire rs1i1_useBConst;
  wire [IN_REG_WIDTH-1:0] rs1i1_rT;
  wire rs1i1_rT_use;
  wire rs1i1_rT_useF;
  wire rs1i1_rT_isV;
  wire [PORT_WIDTH-1:0] rs1i1_port;
  wire [OPERATION_WIDTH-1:0] rs1i1_operation;
  wire rs1i1_en;
  wire [RS_WIDTH-1:0] rs1i1_const;
  wire [3:0] rs1i1_index;
  wire rs1i1_IPRel;
  wire rs1i1_afterTaken;
  wire rs1i1_alloc;
  wire rs1i1_allocF;
  wire rs1i1_allocR;
  wire [3:0] rs1i1_flagDep;
  wire rs1i1_lastFl;
  wire [5:0] rs1i1_lsi;
  wire rs1i1_ldst_flag;
  wire rs1i1_flag_wr;

  wire [IN_REG_WIDTH-1:0] rs1i2_rA;
  wire rs1i2_rA_use;
  wire rs1i2_rA_useF;
  wire rs1i2_rA_isV;
  wire rs1i2_rA_isAnyV;
  wire rs1i2_useAConst;
  wire [IN_REG_WIDTH-1:0] rs1i2_rB;
  wire rs1i2_rB_use;
  wire rs1i2_rB_useF;
  wire rs1i2_rB_isV;
  wire rs1i2_rB_isAnyV;
  wire rs1i2_useBConst;
  wire [IN_REG_WIDTH-1:0] rs1i2_rT;
  wire rs1i2_rT_use;
  wire rs1i2_rT_useF;
  wire rs1i2_rT_isV;
  wire [PORT_WIDTH-1:0] rs1i2_port;
  wire [OPERATION_WIDTH-1:0] rs1i2_operation;
  wire rs1i2_en;
  wire [RS_WIDTH-1:0] rs1i2_const;
  wire [3:0] rs1i2_index;
  wire rs1i2_IPRel;
  wire rs1i2_afterTaken;
  wire rs1i2_alloc;
  wire rs1i2_allocF;
  wire rs1i2_allocR;
  wire [3:0] rs1i2_flagDep;
  wire rs1i2_lastFl;
  wire rs1i2_flag_wr;

  wire [IN_REG_WIDTH-1:0] rs2i0_rA;
  wire rs2i0_rA_use;
  wire rs2i0_rA_useF;
  wire rs2i0_rA_isV;
  wire rs2i0_rA_isAnyV;
  wire [IN_REG_WIDTH-1:0] rs2i0_rB;
  wire rs2i0_rB_use;
  wire rs2i0_rB_useF;
  wire rs2i0_rB_isV;
  wire rs2i0_rB_isAnyV;
  wire rs2i0_useBConst;
  wire [IN_REG_WIDTH-1:0] rs2i0_rT;
  wire rs2i0_rT_use;
  wire rs2i0_rT_useF;
  wire rs2i0_rT_isV;
  wire [PORT_WIDTH-1:0] rs2i0_port;
  wire [OPERATION_WIDTH-1:0] rs2i0_operation;
  wire rs2i0_en;
  wire [RS_WIDTH-1:0] rs2i0_const;
  wire [3:0] rs2i0_index;
  wire rs2i0_IPRel;
  wire rs2i0_afterTaken;
  wire rs2i0_alt;
//  wire rs2i0_both;
  wire rs2i0_alloc;
  wire rs2i0_allocF;
  wire rs2i0_allocR;
  wire [5:0] rs2i0_lsi;
  wire rs2i0_ldst_flag;
  wire rs2i0_enA;
  wire rs2i0_enB;
  
  wire [IN_REG_WIDTH-1:0] rs2i1_rA;
  wire rs2i1_rA_use;
  wire rs2i1_rA_useF;
  wire rs2i1_rA_isV;
  wire rs2i1_rA_isAnyV;
  wire rs2i1_useAConst;
  wire [IN_REG_WIDTH-1:0] rs2i1_rB;
  wire rs2i1_rB_use;
  wire rs2i1_rB_useF;
  wire rs2i1_rB_isV;
  wire rs2i1_rB_isAnyV;
  wire rs2i1_useBConst;
  wire [IN_REG_WIDTH-1:0] rs2i1_rT;
  wire rs2i1_rT_use;
  wire rs2i1_rT_useF;
  wire rs2i1_rT_isV;
  wire [PORT_WIDTH-1:0] rs2i1_port;
  wire [OPERATION_WIDTH-1:0] rs2i1_operation;
  wire rs2i1_en;
  wire [RS_WIDTH-1:0] rs2i1_const;
  wire [3:0] rs2i1_index;
  wire rs2i1_IPRel;
  wire rs2i1_afterTaken;
  wire rs2i1_alloc;
  wire rs2i1_allocF;
  wire rs2i1_allocR;
  wire [3:0] rs2i1_flagDep;
  wire rs2i1_lastFl;
  wire [5:0] rs2i1_lsi;
  wire rs2i1_ldst_flag;
  wire rs2i1_flag_wr;

  wire [IN_REG_WIDTH-1:0] rs2i2_rA;
  wire rs2i2_rA_use;
  wire rs2i2_rA_useF;
  wire rs2i2_rA_isV;
  wire rs2i2_rA_isAnyV;
  wire rs2i2_useAConst;
  wire [IN_REG_WIDTH-1:0] rs2i2_rB;
  wire rs2i2_rB_use;
  wire rs2i2_rB_useF;
  wire rs2i2_rB_isV;
  wire rs2i2_rB_isAnyV;
  wire rs2i2_useBConst;
  wire [IN_REG_WIDTH-1:0] rs2i2_rT;
  wire rs2i2_rT_use;
  wire rs2i2_rT_useF;
  wire rs2i2_rT_isV;
  wire [PORT_WIDTH-1:0] rs2i2_port;
  wire [OPERATION_WIDTH-1:0] rs2i2_operation;
  wire rs2i2_en;
  wire [RS_WIDTH-1:0] rs2i2_const;
  wire [3:0] rs2i2_index;
  wire rs2i2_IPRel;
  wire rs2i2_afterTaken;
  wire rs2i2_alloc;
  wire rs2i2_allocF;
  wire rs2i2_allocR;
  wire [3:0] rs2i2_flagDep;
  wire rs2i2_lastFl;
  wire rs2i2_mul;
  wire rs2i2_flag_wr;

  wire [IN_REG_WIDTH-1:0] instr0_rT;
  wire instr0_en;
  wire instr0_wren;
  wire [8:0] instr0_IPOff;
  wire instr0_afterTaken;
  wire instr0_rT_useF;
  wire instr0_rT_isV;
  wire [PORT_WIDTH-1:0] instr0_port;
  wire [3:0] instr0_magic;
  wire instr0_last;
  wire instr0_aft_spc;
  
  wire [IN_REG_WIDTH-1:0] instr1_rT;
  wire instr1_en;
  wire instr1_wren;
  wire [8:0] instr1_IPOff;
  wire instr1_afterTaken;
  wire instr1_rT_useF;
  wire instr1_rT_isV;
  wire [PORT_WIDTH-1:0] instr1_port;
  wire [3:0] instr1_magic;
  wire instr1_last;
  wire instr1_aft_spc;
  
  wire [IN_REG_WIDTH-1:0] instr2_rT;
  wire instr2_en;
  wire instr2_wren;
  wire [8:0] instr2_IPOff;
  wire instr2_afterTaken;
  wire instr2_rT_useF;
  wire instr2_rT_isV;
  wire [PORT_WIDTH-1:0] instr2_port;
  wire [3:0] instr2_magic;
  wire instr2_last;
  wire instr2_aft_spc;
  
  wire [IN_REG_WIDTH-1:0] instr3_rT;
  wire instr3_en;
  wire instr3_wren;
  wire [8:0] instr3_IPOff;
  wire instr3_afterTaken;
  wire instr3_rT_useF;
  wire instr3_rT_isV;
  wire [PORT_WIDTH-1:0] instr3_port;
  wire [3:0] instr3_magic;
  wire instr3_last;
  wire instr3_aft_spc;
  
  wire [IN_REG_WIDTH-1:0] instr4_rT;
  wire instr4_en;
  wire instr4_wren;
  wire [8:0] instr4_IPOff;
  wire instr4_afterTaken;
  wire instr4_rT_useF;
  wire instr4_rT_isV;
  wire [PORT_WIDTH-1:0] instr4_port;
  wire [3:0] instr4_magic;
  wire instr4_last;
  wire instr4_aft_spc;
  
  wire [IN_REG_WIDTH-1:0] instr5_rT;
  wire instr5_en;
  wire instr5_wren;
  wire [8:0] instr5_IPOff;
  wire instr5_afterTaken;
  wire instr5_rT_useF;
  wire instr5_rT_isV;
  wire [PORT_WIDTH-1:0] instr5_port;
  wire [3:0] instr5_magic;
  wire instr5_last;
  wire instr5_aft_spc;

  wire [IN_REG_WIDTH-1:0] instr6_rT;
  wire instr6_en;
  wire instr6_wren;
  wire [8:0] instr6_IPOff;
  wire instr6_afterTaken;
  wire instr6_rT_useF;
  wire instr6_rT_isV;
  wire [PORT_WIDTH-1:0] instr6_port;
  wire [3:0] instr6_magic;
  wire instr6_last;
  wire instr6_aft_spc;

  wire [IN_REG_WIDTH-1:0] instr7_rT;
  wire instr7_en;
  wire instr7_wren;
  wire [8:0] instr7_IPOff;
  wire instr7_afterTaken;
  wire instr7_rT_useF;
  wire instr7_rT_isV;
  wire [PORT_WIDTH-1:0] instr7_port;
  wire [3:0] instr7_magic;
  wire instr7_last;
  wire instr7_aft_spc;

  wire [IN_REG_WIDTH-1:0] instr8_rT;
  wire instr8_en;
  wire instr8_wren;
  wire [8:0] instr8_IPOff;
  wire instr8_afterTaken;
  wire instr8_rT_useF;
  wire instr8_rT_isV;
  wire [PORT_WIDTH-1:0] instr8_port;
  wire [3:0] instr8_magic;
  wire instr8_last;
  wire instr8_aft_spc;

  wire [IN_REG_WIDTH-1:0] instr9_rT;
  wire instr9_en;
  wire instr9_wren;
  wire [8:0] instr9_IPOff;
  wire instr9_afterTaken;
  wire instr9_rT_useF;
  wire instr9_rT_isV;
  wire [PORT_WIDTH-1:0] instr9_port;
  wire [3:0] instr9_magic;
  wire instr9_last;
  wire instr9_aft_spc;

  wire [4:0] jump0Type;
  wire [3:0] jump0Pos;
  wire jump0Taken;
  wire [4:0] jump1Type;
  wire [3:0] jump1Pos;
  wire jump1Taken;
  wire jump0BtbWay;
  wire [1:0] jump0JmpInd;
  wire [7:0] jump0GHT;
  wire jump1BtbWay;
  wire [1:0] jump1JmpInd;
  wire [7:0] jump1GHT;
  wire [1:0] jump0SC;
  wire jump0Miss;
  wire jump0TbufOnly;
  wire [1:0] jump1SC;
  wire jump1Miss;
  wire jump1TbufOnly;
  wire [9:0] instr_fsimd;
  wire [62:0] baseIP;
  wire [3:0] baseAttr;
  wire [5:0] wrt0;
  wire [5:0] wrt1;
  wire [5:0] wrt2;

  wire [15:0] csrss_no;
  wire csrss_en;
  wire [64:0] csrss_data;
  
  wire insBus_en;
  wire insBus_io;
  wire [REQ_WIDTH-1:0] insBus_req;
  wire insBus_dirty;
  wire insBus_exclusive;
  wire [511:0] insBus_data;
  wire [7:0] insBus_dataPTR;

  wire rinsBus_A,rinsBus_B;

  wire reqBus_en;
  wire [43:7] reqBus_addr;
  wire [REQ_WIDTH-1:0] reqBus_req;
  wire reqBus_want_excl;
  wire reqBus_dupl;
  wire reqBus_io;
  wire [4:0] reqBus_sz;
  wire [1:0] reqBus_low;
  wire [4:0] reqBus_bank0;
  
  wire [1:0] wr0_hit;
  wire [43:8] wr0_addrE;
  wire [43:8] wr0_addrO;
  wire [31:0] wr0_banks;
  wire [4:0] wr0_begin;
  wire [4:0] wr0_end;
  wire [3:0] wr0_bgn_ben;
  wire [3:0] wr0_end_ben;
  wire wr0_odd,wr0_split;
  wire [159:0] wr0_data;
  wire [1:0] wr0_pbit;
  wire       wr0_d128;
  wire [1:0] wr1_hit;
  wire [43:8] wr1_addrE;
  wire [43:8] wr1_addrO;
  wire [31:0] wr1_banks;
  wire [4:0] wr1_begin;
  wire [4:0] wr1_end;
  wire [3:0] wr1_bgn_ben;
  wire [3:0] wr1_end_ben;
  wire wr1_odd,wr1_split;
  wire [159:0] wr1_data;
  wire [1:0] wr1_pbit;
  wire       wr1_d128;
  
  wire dc2_io_en;
  reg dc2_io_en_reg;
  reg dc2_io_en_reg2;
  reg dc2_io_en_reg3;
  reg dc2_io_en_reg4;
  reg dc2_io_en_reg5;
  wire [63:0] dc2_dataIO;
  reg [63:0] dc2_dataIO_reg;
  reg [63:0] dc2_dataIO_reg2;
  reg [63:0] dc2_dataIO_reg3;
  wire dc2_rdEn;
  reg dc2_rdEn_reg;
  reg dc2_rdEn_reg2;
  reg dc2_rdEn_reg3;
  reg dc2_rdEn_reg4;
  wire dc2_rdEnX;
  reg dc2_rdEnX_reg;
  reg dc2_rdEnX_reg2;
  reg dc2_rdEnX_reg3;
  reg dc2_rdEnX_reg4;
  wire dc2_rdOdd;
  wire [4:0] dc2_req_rd;
  reg [4:0] dc2_req_rd_reg;
  reg [4:0] dc2_req_rd_reg2;
  reg [4:0] dc2_req_rd_reg3;
  reg [4:0] dc2_req_rd_reg4;
  reg [4:0] dc2_req_rd_reg5;
  wire dc2_dupl_rd;
  reg dc2_dupl_rd_reg;
  reg dc2_dupl_rd_reg2;
  reg dc2_dupl_rd_reg3;
  reg dc2_dupl_rd_reg4;
  wire dc2_want_excl;
  reg dc2_want_excl_reg;
  reg dc2_want_excl_reg2;
  reg dc2_want_excl_reg3;
  reg dc2_want_excl_reg4;
  wire [1023:0] dc2_rdataA0;
  wire [1023:0] dc2_rdataB0;
  wire [1023:0] dc2_rdataB1;
  wire [1023:0] dc2_rdataExpA0;
  wire [1023:0] dc2_rdataExpB0;
  wire [1023:0] dc2_rdataExpB1;
  wire [15:0] dc2_rdataPTRA0;
  wire [15:0] dc2_rdataPTRB0;
  wire [15:0] dc2_rdataPTRB1;
  wire [15:0] dc2_rdataExpPTRA0;
  wire [15:0] dc2_rdataExpPTRB0;
  wire [15:0] dc2_rdataExpPTRB1;
  reg [1023:512] dc2_rdataA0_reg;
  reg [1023:512] dc2_rdataB0_reg;
  reg [1023:512] dc2_rdataB1_reg;
  reg [1023:512] dc2_rdataExpA0_reg;
  reg [1023:512] dc2_rdataExpB0_reg;
  reg [1023:512] dc2_rdataExpB1_reg;
  reg [15:8] dc2_rdataPTRA0_reg;
  reg [15:8] dc2_rdataPTRB0_reg;
  reg [15:8] dc2_rdataPTRB1_reg;
  reg [15:8] dc2_rdataExpPTRA0_reg;
  reg [15:8] dc2_rdataExpPTRB0_reg;
  reg [15:8] dc2_rdataExpPTRB1_reg;
  wire [511:0] dc2_rdataA;
  wire [511:0] dc2_rdataB;
  wire [511:0] dc2_rdata;
  wire [511:0] dc2_rdataExpA;
  wire [511:0] dc2_rdataExpB;
  wire [511:0] dc2_rdataExp;
  wire [7:0] dc2_rdataPTRA;
  wire [7:0] dc2_rdataPTRB;
  wire [7:0] dc2_rdataPTR;
  reg  [7:0] dc2_rdataPTR_reg;
  wire [7:0] dc2_rdataExpPTRA;
  wire [7:0] dc2_rdataExpPTRB;
  wire [7:0] dc2_rdataExpPTR;
  reg  [7:0] dc2_rdataExpPTR_reg;
  wire dc2_hitE0,dc2_hitO0;
  wire [35:0] dc2_addrE0;
  wire [35:0] dc2_addrO0;
  wire [31:0] dc2_bankEn0; 
  wire [4:0] dc2_begin0;
  wire [4:0] dc2_end0;
  wire [3:0] dc2_bBen0;
  wire [3:0] dc2_enBen0;
  wire dc2_odd0,dc2_split0;
  wire [159:0] dc2_data0;
  wire [1:0]   dc2_pbit0;
  wire         dc2_d128_0;
  wire dc2_hitE1,dc2_hitO1;
  wire [35:0] dc2_addrE1;
  wire [35:0] dc2_addrO1;
  wire [31:0] dc2_bankEn1; 
  wire [4:0] dc2_begin1;
  wire [4:0] dc2_end1;
  wire [3:0] dc2_bBen1;
  wire [3:0] dc2_enBen1;
  wire dc2_odd1,dc2_split1;
  wire [159:0] dc2_data1;
  wire [1:0]   dc2_pbit1;
  wire         dc2_d128_1;
  wire dc2_rhitB0,dc2_rhitB1,dc2_rhitA0;
  reg dc2_rhitB0_reg,dc2_rhitB1_reg,dc2_rhitA0_reg;
  wire [4:0] dc2_rLRUA;
  wire [4:0] dc2_rLRUA0;
  wire [4:0] dc2_rLRUB;
  wire [4:0] dc2_rLRUB0;
  wire [4:0] dc2_rLRUB1;
  wire [4:0] dc2_rLRU;
  reg [4:0] dc2_rLRU_reg;
  wire dc2_rDirA;
  wire dc2_rDirA0;
  wire dc2_rDirB;
  wire dc2_rDirB0;
  wire dc2_rDirB1;
  wire dc2_rDir;
  wire dc2_rExclA;
  wire dc2_rExclA0;
  wire dc2_rExclB;
  wire dc2_rExclB0;
  wire dc2_rExclB1;
  wire dc2_rExcl;
  reg dc2_rhit;

  reg dc2_rhitExp;
  reg dc2_rhitExp_reg;
  wire dc2_rhitExpA0;
  wire dc2_rhitExpB0;
  wire dc2_rhitExpB1;
  reg dc2_rhitExpA0_reg;
  reg dc2_rhitExpB0_reg;
  reg dc2_rhitExpB1_reg;
  
  reg [36:0] dc2_rd_addr;
  reg [36:0] dc2_rd_addr_reg;
  reg [36:0] dc2_rd_addr_reg2;
  reg [36:0] dc2_rd_addr_reg3;
  reg [`rbusD_width-1:0] rbusDIn_signals_reg;
//  reg [9:0] rbusDIn_src_req_reg;
//  reg [9:0] rbusDIn_dst_req_reg;
  reg [511:0] rbusDIn_data_reg;
  reg [7:0] rbusDIn_dataPTR_reg;
  reg dc2_rDir_reg;
  reg dc2_rExcl_reg;
  reg dc2_rDir_reg2;
  reg dc2_rExcl_reg2;
  reg [511:0] dc2_rdata_reg;
  reg [511:0] dc2_rdataExp_reg;

  wire [35:0] L1_expAddr;
  wire L1_expAddr_en;
  reg L1_expAddr_en_reg;
  reg L1_expAddr_en_reg2;
  reg L1_expAddr_en_reg3;
  reg L1_expAddr_en_reg4;
  reg L1_expAddr_en_reg5;
  reg L1_expAddr_en_reg6;
  wire [36:0] MSI_expAddr;
  wire MSI_expAddr_en;
  wire MSI_req_excl;
  wire MSI_expect_swap;
  wire MSI_expAddr_hitCC;
  wire [3:0] dec_attr;
  reg  [36:0] MSI_expAddr_reg;
  reg  MSI_expAddr_en_reg;
//  wire MSI_swap_reply;

  wire [36:0] expun_bk_addr;
  wire expun_bk_en;
  wire [36:0] expun_fr_addr;
  wire expun_fr_en;

  wire wrStall;
//  reg ret_ebx_en;
//  reg [63:0] ret_ebx_data;
  
//  reg ret_r8d_en;
//  reg [63:0] ret_r8d_data;
  
//  assign bus_tlb_data_d[`ctlbData_sys]=1'b1;
//  assign bus_tlb_data_d[`ctlbData_na]=1'b0;
//  assign bus_tlb_data_d[`ctlbData_ne]=1'b0;
//  assign bus_tlb_data_d[`ctlbData_phys]=req_addr[31:0];
  
//  assign read_data_strip={read_data[258:195],read_data[193:130],read_data[128:65],read_data[63:0]};
  
  assign dc2_rdataB=dc2_rhitB0 ? dc2_rdataB0[511:0] : 512'bz;
  assign dc2_rdataB=dc2_rhitB0_reg ? dc2_rdataB0_reg[1023:512] : 512'bz;
  assign dc2_rdataB=dc2_rhitB1 ? dc2_rdataB1[511:0] : 512'bz;
  assign dc2_rdataB=dc2_rhitB1_reg ? dc2_rdataB1_reg[1023:512] : 512'bz;
  assign dc2_rdataB=(dc2_rhitB0 | dc2_rhitB0_reg | dc2_rhitB1 | dc2_rhitB1_reg) ?
    512'bz : 512'b0;
      
  assign dc2_rdataA=dc2_rhitA0 ? dc2_rdataA0[511:0] : 512'bz;
  assign dc2_rdataA=dc2_rhitA0_reg ? dc2_rdataA0_reg[1023:512] : 512'bz;
  assign dc2_rdataA=dc2_io_en_reg3 ? {448'b0,dc2_dataIO_reg3} : 512'bz;
  assign dc2_rdataA=(dc2_rhitA0 | dc2_rhitA0_reg | dc2_io_en_reg3 ) ? 512'bz : 512'b0;
 
  assign dc2_rdata=(dc2_rhitA0 | dc2_rhitA0_reg | dc2_io_en_reg3) ? dc2_rdataA : dc2_rdataB;
  
  assign dc2_rdataExpB=dc2_rhitExpB0 ? dc2_rdataExpB0[511:0] : 512'bz;
  assign dc2_rdataExpB=dc2_rhitExpB0_reg ? dc2_rdataExpB0_reg[1023:512] : 512'bz;
  assign dc2_rdataExpB=dc2_rhitExpB1 ? dc2_rdataExpB1[511:0] : 512'bz;
  assign dc2_rdataExpB=dc2_rhitExpB1_reg ? dc2_rdataExpB1_reg[1023:512] : 512'bz;
  assign dc2_rdataExpB=(dc2_rhitExpB0 | dc2_rhitExpB0_reg | dc2_rhitExpB1 | dc2_rhitExpB1_reg) ?
    512'bz : 512'b0;
      
  assign dc2_rdataExpA=dc2_rhitExpA0 ? dc2_rdataExpA0[511:0] : 512'bz;
  assign dc2_rdataExpA=dc2_rhitExpA0_reg ? dc2_rdataExpA0_reg[1023:512] : 512'bz;
  assign dc2_rdataExpA=dc2_io_en_reg3 ? {448'b0,dc2_dataIO_reg3} : 512'bz;
  assign dc2_rdataExpA=(dc2_rhitExpA0 | dc2_rhitExpA0_reg | dc2_io_en_reg3 ) ? 512'bz : 512'b0;
 
  assign dc2_rdataExp=(dc2_rhitExpA0 | dc2_rhitExpA0_reg | dc2_io_en_reg3) ? dc2_rdataExpA : dc2_rdataExpB;
  
//  assign stall=1'b0;
  assign dc2_rLRUB=dc2_rhitB0 ? dc2_rLRUB0 :  5'bz;
  assign dc2_rLRUB=dc2_rhitB1 ? dc2_rLRUB1 :  5'bz;
  assign dc2_rLRUB=(~dc2_rhitB1 & ~dc2_rhitB1) ? 5'b0 :  5'bz;
      
  assign dc2_rLRUA= dc2_rLRUA0 & {5{dc2_rhitA0}};
 
  assign dc2_rLRU=dc2_rhitA0 ? dc2_rLRUA : dc2_rLRUB;


  assign dc2_rDirB=dc2_rhitB0 ? dc2_rDirB0 :  1'bz;
  assign dc2_rDirB=dc2_rhitB1 ? dc2_rDirB1 :  1'bz;
  assign dc2_rDirB=(~dc2_rhitB1 & ~dc2_rhitB1) ? 1'b0 :  1'bz;
      
  assign dc2_rDirA= dc2_rDirA0 & dc2_rhitA0;
 
  assign dc2_rDir=dc2_rhitA0 ? dc2_rDirA : dc2_rDirB;


  assign dc2_rExclB=dc2_rhitB0 ? dc2_rExclB0 :  1'bz;
  assign dc2_rExclB=dc2_rhitB1 ? dc2_rExclB1 :  1'bz;
  assign dc2_rExclB=(~dc2_rhitB1 & ~dc2_rhitB1) ? 1'b0 :  1'bz;
      
  assign dc2_rExclA= dc2_rExclA0 & dc2_rhitA0;
 
  assign dc2_rExcl=dc2_rhitA0 ? dc2_rExclA : dc2_rExclB;
  
//  assign except=1'b0;//iAvail[0] && instr0[15:0]==16'h0023;
  assign rbusDOut_signals[`rbusD_second]=dc2_rhitExp_reg && L1_expAddr_en_reg6;
  assign rbusDOut_signals[`rbusD_used]=dc2_rhitExp & L1_expAddr_en_reg5 || dc2_rhitExp_reg & L1_expAddr_en_reg6;
  assign rbusDOut_signals[`rbusD_mem_reply]=dc2_rhitExp | dc2_rhitExp_reg;
  assign rbusDOut_signals[`rbusD_bcast]=1'b0;
  assign rbusDOut_signals[`rbusD_cc_reply]=1'b0;
  assign rbusDOut_signals[`rbusD_write_back]=1'b0;
  assign rbusDOut_signals[`rbusD_excl]=dc2_rhitExp ? dc2_rExcl_reg : dc2_rExcl_reg2;
  assign rbusDOut_signals[`rbusD_dirty]=dc2_rhitExp ? dc2_rDir_reg : dc2_rDir_reg2;
  assign rbusDOut_signals[`rbusD_iorpl]=1'b0;
  //other signals assign
  assign rbusDOut_src_req=10'h3ff;
  assign rbusDOut_dst_req=rbusDIn_data_reg[46:37];
  assign rbusDOut_data=dc2_rdataExp_reg;
  assign rbusDOut_dataPTR=dc2_rdataExpPTR_reg;
  assign rbusDOut_want=dc2_rhitExp & ~L1_expAddr_en_reg4 || dc2_rhitExp_reg & ~L1_expAddr_en_reg5;
  assign rbusDOut_replay=dc2_rhitExp & ~L1_expAddr_en_reg4;

  assign insBus_en=dc2_rhit && ~L1_expAddr_en_reg5;
  assign insBus_io=dc2_io_en_reg5;
  assign insBus_req={BUS_ID,dc2_req_rd_reg5};
  assign insBus_dirty=dc2_rDir_reg;
  assign insBus_exclusive=dc2_rExcl_reg;
  assign insBus_data=dc2_rdata_reg;
  assign insBus_dataPTR=dc2_rdataPTR_reg;

  assign MSI_expAddr=37'b0;
  assign MSI_expAddr_en=1'b0;

  dc2_cntrl dc2_cntrl_mod(
  .clk(clk),
  .rst(rst),
  .doSkip(wrStall),
  .read_addr(reqBus_addr),
  .read_en(reqBus_en),
  .read_req(reqBus_req[4:0]),
  .read_dupl(reqBus_dupl),
  .read_want_excl(reqBus_want_excl),
  .read_io(reqBus_io),
  .read_sz(reqBus_sz),
  .read_bank0(reqBus_bank0),
  .read_low(reqBus_low),
  .Cread_addr(req_addr_reg[36:0]),
  .Cread_en(req_en_reg),
  .Cread_req(req_slot_reg[4:0]),
//  .write0_clkEn({dc_wrHit[0] && dc_odd_wr_reg3[0] | dc_split_wr_reg3[0],dc_wrHit[0] && ~dc_odd_wr_reg3[0] | dc_split_wr_reg3[0]}),
  .write0_clkEn(wr0_hit),
  .write_addrE0(wr0_addrE),
  .write_addrO0(wr0_addrO),
  .write_bankEn0(wr0_banks), 
  .write_begin0(wr0_begin),.write_end0(wr0_end),
  .write_bBen0(wr0_bgn_ben),.write_enBen0(wr0_end_ben),
  .write_odd0(wr0_odd),.write_split0(wr0_split),
  .write_data0(wr0_data),
  .write_pbit0(wr0_pbit),
  .write_d128_0(wr0_d128),
  .write1_clkEn(wr1_hit),
  .write_addrE1(wr1_addrE), 
  .write_addrO1(wr1_addrO),
  .write_bankEn1(wr1_banks), 
  .write_begin1(wr1_begin),.write_end1(wr1_end),
  .write_bBen1(wr1_bgn_ben),.write_enBen1(wr1_end_ben),
  .write_odd1(wr1_odd),.write_split1(wr1_split),
  .write_data1(wr1_data),
  .write_pbit1(wr1_pbit),
  .write_d128_1(wr1_d128),
  //writeI0_clkEn,
  .writeI_addrE0(dc2_addrE0), .writeI_hitE0(dc2_hitE0),
  .writeI_addrO0(dc2_addrO0), .writeI_hitO0(dc2_hitO0),
  .writeI_bankEn0(dc2_bankEn0), 
  .writeI_begin0(dc2_begin0),.writeI_end0(dc2_end0),
  .writeI_bBen0(dc2_bBen0),.writeI_enBen0(dc2_enBen0),
  .writeI_odd0(dc2_odd0),.writeI_split0(dc2_split0),
  .writeI_data0(dc2_data0),
  .writeI_pbit0(dc2_pbit0),
  .writeI_d128_0(dc2_d128_0),
 //writeI1_clkEn,
  .writeI_addrE1(dc2_addrE1), .writeI_hitE1(dc2_hitE1),
  .writeI_addrO1(dc2_addrO1), .writeI_hitO1(dc2_hitO1),
  .writeI_bankEn1(dc2_bankEn1),
  .writeI_begin1(dc2_begin1),.writeI_end1(dc2_end1),
  .writeI_bBen1(dc2_bBen1),.writeI_enBen1(dc2_enBen1),
  .writeI_odd1(dc2_odd1),.writeI_split1(dc2_split1),
  .writeI_data1(dc2_data1),
  .writeI_pbit1(dc2_pbit1),
  .writeI_d128_1(dc2_d128_1),
  .writeI_exp(L1_expAddr_en),
  .readI_en(dc2_rdEn),.readI_en2(dc2_rdEnX),.readI_odd(dc2_rdOdd),.readI_req(dc2_req_rd),
  .readI_dupl(dc2_dupl_rd),.readI_want_excl(dc2_want_excl),
  .readI_io(dc2_io_en),.readI_dataIO(dc2_dataIO),
  .readI_ins_A(rinsBus_A),.readI_ins_B(rinsBus_B),
  .readI_code(),
  .miss_en(({dc2_rhitA0,dc2_rhitB0,dc2_rhitB1}==3'b0)|(~dc2_rExcl&dc2_want_excl_reg4) && dc2_rdEnX_reg4),
  .miss_addr(dc2_rd_addr_reg3),.miss_req(dc2_req_rd_reg4),
  .miss_dupl(~dc2_rExcl&dc2_want_excl_reg4&(dc2_rhitA0|dc2_rhitB0|dc2_rhitB1)||dc2_dupl_rd_reg4),
  .miss_want_excl(dc2_want_excl_reg4),
  .rbus_signals(rbusOut_signals),.rbus_src_req(rbusOut_src_req),
    .rbus_dst_req(rbusOut_dst_req),.rbus_address(rbusOut_address),
    .rbus_can(rbusOut_can),.rbus_want(rbusOut_want),
    .rbus_sz(rbusOut_sz),.rbus_bank0(rbusOut_bank0),.rbus_low(rbusOut_low),
  .rbusD_signals(rbusDIn_signals),.rbusD_src_req(rbusDIn_src_req),
  .rbusD_dst_req(rbusDIn_dst_req),.rbusD_data64(rbusDIn_data[63:0])
  );
  dcache2_block #(0) dc2A0_mod(
  .clk(clk),
  .rst(rst),
  .read_en(dc2_rdEn),.read_odd(dc2_rdOdd),
  .read_data(dc2_rdataA0),
  .read_dataX(dc2_rdataExpA0),
  .read_dataPTR(dc2_rdataPTRA0),
  .read_dataPTRx(dc2_rdataExpPTRA0),
  .write0_clkEn(dc2_hitE0 | dc2_hitO0),
  .write_addrE0(dc2_addrE0), .write_hitE0(dc2_hitE0),
  .write_addrO0(dc2_addrO0), .write_hitO0(dc2_hitO0),
  .write_bankEn0(dc2_bankEn0), 
  .write_pbit0(dc2_pbit0),.write_d128_0(dc2_d128_0), 
  .write_begin0(dc2_begin0),.write_end0(dc2_end0),
  .write_bBen0(dc2_bBen0),.write_enBen0(dc2_enBen0),
  .write_odd0(dc2_odd0),.write_split0(dc2_split0),
  .write_data0(dc2_data0),
  .write1_clkEn(dc2_hitE1 | dc2_hitO1),
  .write_addrE1(dc2_addrE1), .write_hitE1(dc2_hitE1),
  .write_addrO1(dc2_addrO1), .write_hitO1(dc2_hitO1),
  .write_bankEn1(dc2_bankEn1),
  .write_pbit1(dc2_pbit1),.write_d128_1(dc2_d128_1),
  .write_begin1(dc2_begin1),.write_end1(dc2_end1),
  .write_bBen1(dc2_bBen1),.write_enBen1(dc2_enBen1),
  .write_odd1(dc2_odd1),.write_split1(dc2_split1),
  .write_data1(dc2_data1),
  .busIns_data(rbusDIn_data_reg),
  .busIns_dataPTR(rbusDIn_dataPTR_reg),
  .insBus_A(rinsBus_A),
  .insBus_B(rinsBus_B),
  .insert(rinsBus_B),
  .insert_excl(rbusDIn_signals_reg[`rbusD_excl]),
  .insert_dirty(rbusDIn_signals_reg[`rbusD_dirty]),
  .insert_dupl(dc2_dupl_rd),
  .hit_LRU(dc2_rLRU_reg),.read_LRU(dc2_rLRUA0),.hit_any(dc2_rhitA0),
  .read_dir(dc2_rDirA0),.read_excl(dc2_rExclA0),
  //.read_expAddr(L1_expAddr),
  .read_expAddr_en(L1_expAddr_en),
  .imm_any(dc2_rhitExpA0),
  .read_expAddrOut(),
  .expun_cc_addr(expun_fr_addr),
  .expun_cc_en(expun_fr_en),
  .expun_dc_addr(expun_bk_addr),
  .expun_dc_en(expun_bk_en)
  );
  dcache2_block #(1) dc2B0_mod(
  .clk(clk),
  .rst(rst),
  .read_en(dc2_rdEn),.read_odd(dc2_rdOdd),
  .read_data(dc2_rdataB0),
  .read_dataX(dc2_rdataExpB0),
  .read_dataPTR(dc2_rdataPTRB0),
  .read_dataPTRx(dc2_rdataExpPTRB0),
  .write0_clkEn(dc2_hitE0 | dc2_hitO0),
  .write_addrE0(dc2_addrE0), .write_hitE0(dc2_hitE0),
  .write_addrO0(dc2_addrO0), .write_hitO0(dc2_hitO0),
  .write_bankEn0(dc2_bankEn0), 
  .write_pbit0(dc2_pbit0),.write_d128_0(dc2_d128_0), 
  .write_begin0(dc2_begin0),.write_end0(dc2_end0),
  .write_bBen0(dc2_bBen0),.write_enBen0(dc2_enBen0),
  .write_odd0(dc2_odd0),.write_split0(dc2_split0),
  .write_data0(dc2_data0),
  .write1_clkEn(dc2_hitE1 | dc2_hitO1),
  .write_addrE1(dc2_addrE1), .write_hitE1(dc2_hitE1),
  .write_addrO1(dc2_addrO1), .write_hitO1(dc2_hitO1),
  .write_bankEn1(dc2_bankEn1),
  .write_pbit1(dc2_pbit1),.write_d128_1(dc2_d128_1), 
  .write_begin1(dc2_begin1),.write_end1(dc2_end1),
  .write_bBen1(dc2_bBen1),.write_enBen1(dc2_enBen1),
  .write_odd1(dc2_odd1),.write_split1(dc2_split1),
  .write_data1(dc2_data1),
  .busIns_data(rbusDIn_data_reg),
  .busIns_dataPTR(rbusDIn_dataPTR_reg),
  .insBus_A(rinsBus_A),
  .insBus_B(rinsBus_B),
  .insert(rinsBus_B),
  .insert_excl(rbusDIn_signals_reg[`rbusD_excl]),
  .insert_dirty(rbusDIn_signals_reg[`rbusD_dirty]),
  .insert_dupl(dc2_dupl_rd),
  .hit_LRU(dc2_rLRU_reg),.read_LRU(dc2_rLRUB0),.hit_any(dc2_rhitB0),
  .read_dir(dc2_rDirB0),.read_excl(dc2_rExclB0),
  //.read_expAddr(L1_expAddr),
  .read_expAddr_en(L1_expAddr_en),
  .imm_any(dc2_rhitExpB0),
  .read_expAddrOut(),
  .expun_cc_addr(expun_fr_addr),
  .expun_cc_en(expun_fr_en),
  .expun_dc_addr(expun_bk_addr),
  .expun_dc_en(expun_bk_en)
  );
  dcache2_block #(2) dc2B1_mod(
  .clk(clk),
  .rst(rst),
  .read_en(dc2_rdEn),.read_odd(dc2_rdOdd),
  .read_data(dc2_rdataB1),
  .read_dataX(dc2_rdataExpB1),
  .read_dataPTR(dc2_rdataPTRB1),
  .read_dataPTRx(dc2_rdataExpPTRB1),
  .write0_clkEn(dc2_hitE0 | dc2_hitO0),
  .write_addrE0(dc2_addrE0), .write_hitE0(dc2_hitE0),
  .write_addrO0(dc2_addrO0), .write_hitO0(dc2_hitO0),
  .write_bankEn0(dc2_bankEn0), 
  .write_pbit0(dc2_pbit0),.write_d128_0(dc2_d128_0), 
  .write_begin0(dc2_begin0),.write_end0(dc2_end0),
  .write_bBen0(dc2_bBen0),.write_enBen0(dc2_enBen0),
  .write_odd0(dc2_odd0),.write_split0(dc2_split0),
  .write_data0(dc2_data0),
  .write1_clkEn(dc2_hitE1 | dc2_hitO1),
  .write_addrE1(dc2_addrE1), .write_hitE1(dc2_hitE1),
  .write_addrO1(dc2_addrO1), .write_hitO1(dc2_hitO1),
  .write_bankEn1(dc2_bankEn1),
  .write_pbit1(dc2_pbit1),.write_d128_1(dc2_d128_1), 
  .write_begin1(dc2_begin1),.write_end1(dc2_end1),
  .write_bBen1(dc2_bBen1),.write_enBen1(dc2_enBen1),
  .write_odd1(dc2_odd1),.write_split1(dc2_split1),
  .write_data1(dc2_data1),
  .busIns_data(rbusDIn_data_reg),
  .busIns_dataPTR(rbusDIn_dataPTR_reg),
  .insBus_A(rinsBus_A),
  .insBus_B(rinsBus_B),
  .insert(rinsBus_B),
  .insert_excl(rbusDIn_signals_reg[`rbusD_excl]),
  .insert_dirty(rbusDIn_signals_reg[`rbusD_dirty]),
  .insert_dupl(dc2_dupl_rd),
  .hit_LRU(dc2_rLRU_reg),.read_LRU(dc2_rLRUB1),.hit_any(dc2_rhitB1),
  .read_dir(dc2_rDirB1),.read_excl(dc2_rExclB1),
  //.read_expAddr(L1_expAddr),
  .imm_any(dc2_rhitExpB1),
  .read_expAddr_en(L1_expAddr_en),
  .read_expAddrOut(),
  .expun_cc_addr(expun_fr_addr),
  .expun_cc_en(expun_fr_en),
  .expun_dc_addr(expun_bk_addr),
  .expun_dc_en(expun_bk_en)
  );

  frontend1 #(BUS_ID) front_mod(
  clk,
  rst,
  except,
  {exceptIP,1'b0},
//
  exceptThread,
  exceptAttr,
  except_due_jump,
  except_ght,
  except_flag,
  except_jmask,
  except_jmask_en,
  jupd0_en,jupdt0_en,jupd0_ght_en,jupd0_addr,jupd0_baddr,jupd0_sc,jupd0_tk,
  jupd1_en,jupdt1_en,jupd1_ght_en,jupd1_addr,jupd1_baddr,jupd1_sc,jupd1_tk,
//
  insBus_data,
  insBus_req,
  insBus_en,
  req_addr,
  req_slot,
  req_en,
  req_tlbEn,
  req_tlbAttr,
  bus_tlb_data,
  bus_tlb_slot,
  bus_tlb_en,
  instr0,instr1,instr2,instr3,
  instr4,instr5,instr6,instr7,
  instr8,instr9,
  extra0,extra1,extra2,extra3,
  extra4,extra5,extra6,extra7,
  extra8,extra9,
  instrEn,
  iAvail,
  stall,
  btbl_step,
  btbl_IP0,
  btbl_IP1,
  btbl_mask0,btbl_mask1,
  btbl_attr0,btbl_attr1,
  csrss_en,csrss_no,csrss_data[63:0],
  MSI_expAddr_reg,
  MSI_expAddr_en_reg,
  MSI_expAddr_hitCC,
  //dec_attr
  expun_fr_addr,
  expun_fr_en
  );
  

  
  decoder dec_mod(
  clk,
  rst,
  stall,
  except,
  {exceptIP,1'b0},
  exceptAttr,
  
  btbl_step,
  
  iAvail,
  instrEn,
  instr0,extra0,
  instr1,extra1,
  instr2,extra2,
  instr3,extra3,
  instr4,extra4,
  instr5,extra5,
  instr6,extra6,
  instr7,extra7,
  instr8,extra8,
  instr9,extra9,
  
  btbl_IP0,
  btbl_IP1,

  btbl_attr0,
  btbl_attr1,
  
  halt,
  
  1'b1,//all_retired,
  fp_excpt_en,
  fp_excpt_set,

  bundleFeed,
//begin instructions ordered by rs input port
  rs0i0_rA,rs0i0_rA_use,rs0i0_rA_useF,rs0i0_rA_isV,rs0i0_rA_isAnyV,
  rs0i0_rB,rs0i0_rB_use,rs0i0_rB_useF,rs0i0_rB_isV,rs0i0_rB_isAnyV,rs0i0_useBConst,
  rs0i0_rT,rs0i0_rT_use,rs0i0_rT_useF,rs0i0_rT_isV, 
  rs0i0_port,
  rs0i0_operation,
  rs0i0_en,
  rs0i0_const,
  rs0i0_index,
  rs0i0_IPRel,
  rs0i0_afterTaken,
  rs0i0_alt,
  rs0i0_alloc,
  rs0i0_allocF,
  rs0i0_allocR,
  rs0i0_lsi,
  rs0i0_ldst_flag,
  rs0i0_enA,
  rs0i0_enB,

  rs0i1_rA,rs0i1_rA_use,rs0i1_rA_useF,rs0i1_rA_isV,rs0i1_rA_isAnyV,rs0i1_useAConst,
  rs0i1_rB,rs0i1_rB_use,rs0i1_rB_useF,rs0i1_rB_isV,rs0i1_rB_isAnyV,rs0i1_useBConst,
  rs0i1_rT,rs0i1_rT_use,rs0i1_rT_useF,rs0i1_rT_isV,
  rs0i1_port,
  rs0i1_operation,
  rs0i1_en,
  rs0i1_const,
  rs0i1_index,
  rs0i1_IPRel,
  rs0i1_afterTaken,
  rs0i1_alloc,
  rs0i1_allocF,
  rs0i1_allocR,
  rs0i1_flagDep,
  rs0i1_lastFl,
  rs0i1_lsi,
  rs0i1_ldst_flag,
  rs0i1_flag_wr,

  rs0i2_rA,rs0i2_rA_use,rs0i2_rA_useF,rs0i2_rA_isV,rs0i2_rA_isAnyV,rs0i2_useAConst,
  rs0i2_rB,rs0i2_rB_use,rs0i2_rB_useF,rs0i2_rB_isV,rs0i2_rB_isAnyV,rs0i2_useBConst,
  rs0i2_rT,rs0i2_rT_use,rs0i2_rT_useF,rs0i2_rT_isV,
  rs0i2_port,
  rs0i2_operation,
  rs0i2_en,
  rs0i2_const,
  rs0i2_index,
  rs0i2_IPRel,
  rs0i2_afterTaken,
  rs0i2_alloc,
  rs0i2_allocF,
  rs0i2_allocR,
  rs0i2_flagDep,
  rs0i2_lastFl,
  rs0i2_flag_wr,

  rs1i0_rA,rs1i0_rA_use,rs1i0_rA_useF,rs1i0_rA_isV,rs1i0_rA_isAnyV,
  rs1i0_rB,rs1i0_rB_use,rs1i0_rB_useF,rs1i0_rB_isV,rs1i0_rB_isAnyV,rs1i0_useBConst,
  rs1i0_rT,rs1i0_rT_use,rs1i0_rT_useF,rs1i0_rT_isV,
  rs1i0_port,
  rs1i0_operation,
  rs1i0_en,
  rs1i0_const,
  rs1i0_index,
  rs1i0_IPRel,
  rs1i0_afterTaken,
  rs1i0_alt,
  rs1i0_alloc,
  rs1i0_allocF,
  rs1i0_allocR,
  rs1i0_lsi,
  rs1i0_ldst_flag,
  rs1i0_enA,
  rs1i0_enB,

  rs1i1_rA,rs1i1_rA_use,rs1i1_rA_useF,rs1i1_rA_isV,rs1i1_rA_isAnyV,rs1i1_useAConst,
  rs1i1_rB,rs1i1_rB_use,rs1i1_rB_useF,rs1i1_rB_isV,rs1i1_rB_isAnyV,rs1i1_useBConst,
  rs1i1_rT,rs1i1_rT_use,rs1i1_rT_useF,rs1i1_rT_isV,
  rs1i1_port,
  rs1i1_operation,
  rs1i1_en,
  rs1i1_const,
  rs1i1_index,
  rs1i1_IPRel,
  rs1i1_afterTaken,
  rs1i1_alloc,
  rs1i1_allocF,
  rs1i1_allocR,
  rs1i1_flagDep,
  rs1i1_lastFl,
  rs1i1_lsi,
  rs1i1_ldst_flag,
  rs1i1_flag_wr,

  rs1i2_rA,rs1i2_rA_use,rs1i2_rA_useF,rs1i2_rA_isV,rs1i2_rA_isAnyV,rs1i2_useAConst,
  rs1i2_rB,rs1i2_rB_use,rs1i2_rB_useF,rs1i2_rB_isV,rs1i2_rB_isAnyV,rs1i2_useBConst,
  rs1i2_rT,rs1i2_rT_use,rs1i2_rT_useF,rs1i2_rT_isV,
  rs1i2_port,
  rs1i2_operation,
  rs1i2_en,
  rs1i2_const,
  rs1i2_index,
  rs1i2_IPRel,
  rs1i2_afterTaken,
  rs1i2_alloc,
  rs1i2_allocF,
  rs1i2_allocR,
  rs1i2_flagDep,
  rs1i2_lastFl,
  rs1i2_flag_wr,

  rs2i0_rA,rs2i0_rA_use,rs2i0_rA_useF,rs2i0_rA_isV,rs2i0_rA_isAnyV,
  rs2i0_rB,rs2i0_rB_use,rs2i0_rB_useF,rs2i0_rB_isV,rs2i0_rB_isAnyV,rs2i0_useBConst,
  rs2i0_rT,rs2i0_rT_use,rs2i0_rT_useF,rs2i0_rT_isV,
  rs2i0_port,
  rs2i0_operation,
  rs2i0_en,
  rs2i0_const,
  rs2i0_index,
  rs2i0_IPRel,
  rs2i0_afterTaken,
  rs2i0_alt,
  rs2i0_alloc,
  rs2i0_allocF,
  rs2i0_allocR,
  rs2i0_lsi,
  rs2i0_ldst_flag,
  rs2i0_enA,
  rs2i0_enB,
  
  rs2i1_rA,rs2i1_rA_use,rs2i1_rA_useF,rs2i1_rA_isV,rs2i1_rA_isAnyV,rs2i1_useAConst,
  rs2i1_rB,rs2i1_rB_use,rs2i1_rB_useF,rs2i1_rB_isV,rs2i1_rB_isAnyV,rs2i1_useBConst,
  rs2i1_rT,rs2i1_rT_use,rs2i1_rT_useF,rs2i1_rT_isV,
  rs2i1_port,
  rs2i1_operation,
  rs2i1_en,
  rs2i1_const,
  rs2i1_index,
  rs2i1_IPRel,
  rs2i1_afterTaken,
  rs2i1_alloc,
  rs2i1_allocF,
  rs2i1_allocR,
  rs2i1_flagDep,
  rs2i1_lastFl,
  rs2i1_lsi,
  rs2i1_ldst_flag,
  rs2i1_flag_wr,

  rs2i2_rA,rs2i2_rA_use,rs2i2_rA_useF,rs2i2_rA_isV,rs2i2_rA_isAnyV,rs2i2_useAConst,
  rs2i2_rB,rs2i2_rB_use,rs2i2_rB_useF,rs2i2_rB_isV,rs2i2_rB_isAnyV,rs2i2_useBConst,
  rs2i2_rT,rs2i2_rT_use,rs2i2_rT_useF,rs2i2_rT_isV,
  rs2i2_port,
  rs2i2_operation,
  rs2i2_en,
  rs2i2_const,
  rs2i2_index,
  rs2i2_IPRel,
  rs2i2_afterTaken,
  rs2i2_alloc,
  rs2i2_allocF,
  rs2i2_allocR,
  rs2i2_flagDep,
  rs2i2_lastFl,
  rs2i2_mul,
  rs2i2_flag_wr,

//end reordered small instructions
//begin instructions in program order
  instr0_rT, 
  instr0_en,
  instr0_wren, 
  instr0_IPOff,
  instr0_afterTaken,
  instr0_rT_useF,
  instr0_rT_isV,
  instr0_port,
  instr0_magic,
  instr0_last,
  instr0_aft_spc,
  
  instr1_rT,
  instr1_en,
  instr1_wren,
  instr1_IPOff,
  instr1_afterTaken,
  instr1_rT_useF,
  instr1_rT_isV,
  instr1_port,
  instr1_magic,
  instr1_last,
  instr1_aft_spc,
    
  instr2_rT,
  instr2_en,
  instr2_wren,
  instr2_IPOff,
  instr2_afterTaken,
  instr2_rT_useF,
  instr2_rT_isV,
  instr2_port,
  instr2_magic,
  instr2_last,
  instr2_aft_spc,
  
  instr3_rT,
  instr3_en,
  instr3_wren,
  instr3_IPOff,
  instr3_afterTaken,
  instr3_rT_useF,
  instr3_rT_isV,
  instr3_port,
  instr3_magic,
  instr3_last,
  instr3_aft_spc,
  
  instr4_rT,
  instr4_en,
  instr4_wren,
  instr4_IPOff,
  instr4_afterTaken,
  instr4_rT_useF,
  instr4_rT_isV,
  instr4_port,
  instr4_magic,
  instr4_last,
  instr4_aft_spc,
  
  instr5_rT,
  instr5_en,
  instr5_wren,
  instr5_IPOff,
  instr5_afterTaken,
  instr5_rT_useF,
  instr5_rT_isV,
  instr5_port,
  instr5_magic,
  instr5_last,
  instr5_aft_spc,

  instr6_rT,
  instr6_en,
  instr6_wren,
  instr6_IPOff,
  instr6_afterTaken,
  instr6_rT_useF,
  instr6_rT_isV,
  instr6_port,
  instr6_magic,
  instr6_last,
  instr6_aft_spc,

  instr7_rT,
  instr7_en,
  instr7_wren,
  instr7_IPOff,
  instr7_afterTaken,
  instr7_rT_useF,
  instr7_rT_isV,
  instr7_port,
  instr7_magic,
  instr7_last,
  instr7_aft_spc,

  instr8_rT,
  instr8_en,
  instr8_wren,
  instr8_IPOff,
  instr8_afterTaken,
  instr8_rT_useF,
  instr8_rT_isV,
  instr8_port,
  instr8_magic,
  instr8_last,
  instr8_aft_spc,

  instr9_rT,
  instr9_en,
  instr9_wren,
  instr9_IPOff,
  instr9_afterTaken,
  instr9_rT_useF,
  instr9_rT_isV,
  instr9_port,
  instr9_magic,
  instr9_last,
  instr9_aft_spc,
  jump0Type,jump0Pos,jump0Taken,
  jump1Type,jump1Pos,jump1Taken,
  jump0BtbWay,jump0JmpInd,jump0GHT,
  jump1BtbWay,jump1JmpInd,jump1GHT,
  jump0SC,jump0Miss,jump0TbufOnly,
  jump1SC,jump1Miss,jump1TbufOnly,
  instr_fsimd,
  baseIP,
  baseAttr,
  wrt0,wrt1,wrt2,
  csrss_no,csrss_en,csrss_data
  );

  backend bck_mod(
  clk,
  rst,
  stall,

  1'b0,
  bundleFeed,
  except,
  exceptIP,
  exceptAttr,
  except_due_jump,
  except_flag,
  except_ght,
  except_jmask_en,
  except_jmask, 
  req_addr[30:0],
  req_tlbAttr,
  req_tlbEn,
  bus_tlb_data,
  bus_tlb_en,
  dec_attr,
  MSI_expAddr_reg,
  MSI_expAddr_en_reg,
  1'b0,//unused
  1'b0,//unused
  expun_bk_addr,
  expun_bk_en,
  rs0i0_rA,rs0i0_rA_use,rs0i0_rA_useF,rs0i0_rA_isV,rs0i0_rA_isAnyV,
  rs0i0_rB,rs0i0_rB_use,rs0i0_rB_useF,rs0i0_rB_isV,rs0i0_rB_isAnyV,rs0i0_useBConst,
  rs0i0_rT,rs0i0_rT_use,rs0i0_rT_useF,rs0i0_rT_isV, 
  rs0i0_port,
  rs0i0_operation,
  rs0i0_en,
  rs0i0_const,
  rs0i0_index,
  rs0i0_IPRel,
  rs0i0_afterTaken,
  rs0i0_alt,
  rs0i0_alloc,
  rs0i0_allocF,
  rs0i0_allocR,
  rs0i0_lsi,
  rs0i0_ldst_flag,
  rs0i0_enA,
  rs0i0_enB,

  rs0i1_rA,rs0i1_rA_use,rs0i1_rA_useF,rs0i1_rA_isV,rs0i1_rA_isAnyV,rs0i1_useAConst,
  rs0i1_rB,rs0i1_rB_use,rs0i1_rB_useF,rs0i1_rB_isV,rs0i1_rB_isAnyV,rs0i1_useBConst,
  rs0i1_rT,rs0i1_rT_use,rs0i1_rT_useF,rs0i1_rT_isV,
  rs0i1_port,
  rs0i1_operation,
  rs0i1_en,
  rs0i1_const,
  rs0i1_index,
  rs0i1_IPRel,
  rs0i1_afterTaken,
  rs0i1_alloc,
  rs0i1_allocF,
  rs0i1_allocR,
  rs0i1_flagDep,
  rs0i1_lastFl,
  rs0i1_lsi,
  rs0i1_ldst_flag,
  rs0i1_flag_wr,

  rs0i2_rA,rs0i2_rA_use,rs0i2_rA_useF,rs0i2_rA_isV,rs0i2_rA_isAnyV,rs0i2_useAConst,
  rs0i2_rB,rs0i2_rB_use,rs0i2_rB_useF,rs0i2_rB_isV,rs0i2_rB_isAnyV,rs0i2_useBConst,
  rs0i2_rT,rs0i2_rT_use,rs0i2_rT_useF,rs0i2_rT_isV,
  rs0i2_port,
  rs0i2_operation,
  rs0i2_en,
  rs0i2_const,
  rs0i2_index,
  rs0i2_IPRel,
  rs0i2_afterTaken,
  rs0i2_alloc,
  rs0i2_allocF,
  rs0i2_allocR,
  rs0i2_flagDep,
  rs0i2_lastFl,
  rs0i2_flag_wr,

  rs1i0_rA,rs1i0_rA_use,rs1i0_rA_useF,rs1i0_rA_isV,rs1i0_rA_isAnyV,
  rs1i0_rB,rs1i0_rB_use,rs1i0_rB_useF,rs1i0_rB_isV,rs1i0_rB_isAnyV,rs1i0_useBConst,
  rs1i0_rT,rs1i0_rT_use,rs1i0_rT_useF,rs1i0_rT_isV,
  rs1i0_port,
  rs1i0_operation,
  rs1i0_en,
  rs1i0_const,
  rs1i0_index,
  rs1i0_IPRel,
  rs1i0_afterTaken,
  rs1i0_alt,
  rs1i0_alloc,
  rs1i0_allocF,
  rs1i0_allocR,
  rs1i0_lsi,
  rs1i0_ldst_flag,
  rs1i0_enA,
  rs1i0_enB,

  rs1i1_rA,rs1i1_rA_use,rs1i1_rA_useF,rs1i1_rA_isV,rs1i1_rA_isAnyV,rs1i1_useAConst,
  rs1i1_rB,rs1i1_rB_use,rs1i1_rB_useF,rs1i1_rB_isV,rs1i1_rB_isAnyV,rs1i1_useBConst,
  rs1i1_rT,rs1i1_rT_use,rs1i1_rT_useF,rs1i1_rT_isV,
  rs1i1_port,
  rs1i1_operation,
  rs1i1_en,
  rs1i1_const,
  rs1i1_index,
  rs1i1_IPRel,
  rs1i1_afterTaken,
  rs1i1_alloc,
  rs1i1_allocF,
  rs1i1_allocR,
  rs1i1_flagDep,
  rs1i1_lastFl,
  rs1i1_lsi,
  rs1i1_ldst_flag,
  rs1i1_flag_wr,

  rs1i2_rA,rs1i2_rA_use,rs1i2_rA_useF,rs1i2_rA_isV,rs1i2_rA_isAnyV,rs1i2_useAConst,
  rs1i2_rB,rs1i2_rB_use,rs1i2_rB_useF,rs1i2_rB_isV,rs1i2_rB_isAnyV,rs1i2_useBConst,
  rs1i2_rT,rs1i2_rT_use,rs1i2_rT_useF,rs1i2_rT_isV,
  rs1i2_port,
  rs1i2_operation,
  rs1i2_en,
  rs1i2_const,
  rs1i2_index,
  rs1i2_IPRel,
  rs1i2_afterTaken,
  rs1i2_alloc,
  rs1i2_allocF,
  rs1i2_allocR,
  rs1i2_flagDep,
  rs1i2_lastFl,
  rs1i2_flag_wr,

  rs2i0_rA,rs2i0_rA_use,rs2i0_rA_useF,rs2i0_rA_isV,rs2i0_rA_isAnyV,
  rs2i0_rB,rs2i0_rB_use,rs2i0_rB_useF,rs2i0_rB_isV,rs2i0_rB_isAnyV,rs2i0_useBConst,
  rs2i0_rT,rs2i0_rT_use,rs2i0_rT_useF,rs2i0_rT_isV,
  rs2i0_port,
  rs2i0_operation,
  rs2i0_en,
  rs2i0_const,
  rs2i0_index,
  rs2i0_IPRel,
  rs2i0_afterTaken,
  rs2i0_alt,
  rs2i0_alloc,
  rs2i0_allocF,
  rs2i0_allocR,
  rs2i0_lsi,
  rs2i0_ldst_flag,
  rs2i0_enA,
  rs2i0_enB,

  rs2i1_rA,rs2i1_rA_use,rs2i1_rA_useF,rs2i1_rA_isV,rs2i1_rA_isAnyV,rs2i1_useAConst,
  rs2i1_rB,rs2i1_rB_use,rs2i1_rB_useF,rs2i1_rB_isV,rs2i1_rB_isAnyV,rs2i1_useBConst,
  rs2i1_rT,rs2i1_rT_use,rs2i1_rT_useF,rs2i1_rT_isV,
  rs2i1_port,
  rs2i1_operation,
  rs2i1_en,
  rs2i1_const,
  rs2i1_index,
  rs2i1_IPRel,
  rs2i1_afterTaken,
  rs2i1_alloc,
  rs2i1_allocF,
  rs2i1_allocR,
  rs2i1_flagDep,
  rs2i1_lastFl,
  rs2i1_lsi,
  rs2i1_ldst_flag,
  rs2i1_flag_wr,

  rs2i2_rA,rs2i2_rA_use,rs2i2_rA_useF,rs2i2_rA_isV,rs2i2_rA_isAnyV,rs2i2_useAConst,
  rs2i2_rB,rs2i2_rB_use,rs2i2_rB_useF,rs2i2_rB_isV,rs2i2_rB_isAnyV,rs2i2_useBConst,
  rs2i2_rT,rs2i2_rT_use,rs2i2_rT_useF,rs2i2_rT_isV,
  rs2i2_port,
  rs2i2_operation,
  rs2i2_en,
  rs2i2_const,
  rs2i2_index,
  rs2i2_IPRel,
  rs2i2_afterTaken,
  rs2i2_alloc,
  rs2i2_allocF,
  rs2i2_allocR,
  rs2i2_flagDep,
  rs2i2_lastFl,
  rs2i2_mul,
  rs2i2_flag_wr,
//end reordered small instructions
//begin instructions in program order
  instr0_rT, 
  instr0_en,
  instr0_wren, 
  instr0_IPOff,
  instr0_afterTaken,
  instr0_rT_useF,
  instr0_rT_isV,
  instr0_port,
  instr0_magic,
  instr0_last,
  instr0_aft_spc,
  
  instr1_rT,
  instr1_en,
  instr1_wren,
  instr1_IPOff,
  instr1_afterTaken,
  instr1_rT_useF,
  instr1_rT_isV,
  instr1_port,
  instr1_magic,
  instr1_last,
  instr1_aft_spc,
    
  instr2_rT,
  instr2_en,
  instr2_wren,
  instr2_IPOff,
  instr2_afterTaken,
  instr2_rT_useF,
  instr2_rT_isV,
  instr2_port,
  instr2_magic,
  instr2_last,
  instr2_aft_spc,
  
  instr3_rT,
  instr3_en,
  instr3_wren,
  instr3_IPOff,
  instr3_afterTaken,
  instr3_rT_useF,
  instr3_rT_isV,
  instr3_port,
  instr3_magic,
  instr3_last,
  instr3_aft_spc,
  
  instr4_rT,
  instr4_en,
  instr4_wren,
  instr4_IPOff,
  instr4_afterTaken,
  instr4_rT_useF,
  instr4_rT_isV,
  instr4_port,
  instr4_magic,
  instr4_last,
  instr4_aft_spc,
  
  instr5_rT,
  instr5_en,
  instr5_wren,
  instr5_IPOff,
  instr5_afterTaken,
  instr5_rT_useF,
  instr5_rT_isV,
  instr5_port,
  instr5_magic,
  instr5_last,
  instr5_aft_spc,

  instr6_rT,
  instr6_en,
  instr6_wren,
  instr6_IPOff,
  instr6_afterTaken,
  instr6_rT_useF,
  instr6_rT_isV,
  instr6_port,
  instr6_magic,
  instr6_last,
  instr6_aft_spc,

  instr7_rT,
  instr7_en,
  instr7_wren,
  instr7_IPOff,
  instr7_afterTaken,
  instr7_rT_useF,
  instr7_rT_isV,
  instr7_port,
  instr7_magic,
  instr7_last,
  instr7_aft_spc,

  instr8_rT,
  instr8_en,
  instr8_wren,
  instr8_IPOff,
  instr8_afterTaken,
  instr8_rT_useF,
  instr8_rT_isV,
  instr8_port,
  instr8_magic,
  instr8_last,
  instr8_aft_spc,

  instr9_rT,
  instr9_en,
  instr9_wren,
  instr9_IPOff,
  instr9_afterTaken,
  instr9_rT_useF,
  instr9_rT_isV,
  instr9_port,
  instr9_magic,
  instr9_last,
  instr9_aft_spc,

  jump0Type,jump0Pos,jump0Taken,{btbl_IP0,1'b0},btbl_mask0,btbl_attr0,
  jump1Type,jump1Pos,jump1Taken,{btbl_IP1,1'b0},btbl_mask1,btbl_attr1,
  jump0BtbWay,jump0JmpInd,jump0GHT,
  jump1BtbWay,jump1JmpInd,jump1GHT,
  jump0SC,jump0Miss,jump0TbufOnly,
  jump1SC,jump1Miss,jump1TbufOnly,
  instr_fsimd,
  baseIP,
  wrt0,wrt1,wrt2,

  jupd0_en,jupdt0_en,jupd0_ght_en,jupd0_addr,jupd0_baddr,jupd0_sc,jupd0_tk,
  jupd1_en,jupdt1_en,jupd1_ght_en,jupd1_addr,jupd1_baddr,jupd1_sc,jupd1_tk,
  
  csrss_no,csrss_en,csrss_data,

  insBus_en&&~insBus_req[4]|insBus_req[3],
  insBus_io,
  insBus_req,
  insBus_dirty,
  insBus_exclusive,
  insBus_data,
  insBus_dataPTR,
  reqBus_en,
  reqBus_addr,
  reqBus_req,
  reqBus_want_excl,
  reqBus_dupl,
  reqBus_io,
  reqBus_sz,
  reqBus_low,
  reqBus_bank0,
  wr0_hit,
  wr0_addrE,wr0_addrO,
  wr0_banks,
  wr0_begin,wr0_end,
  wr0_bgn_ben,wr0_end_ben,
  wr0_odd,wr0_split,
  wr0_data,
  wr0_pbit,wr0_d128,
  wr1_hit,
  wr1_addrE,wr1_addrO,
  wr1_banks,
  wr1_begin,wr1_end,
  wr1_bgn_ben,wr1_end_ben,
  wr1_odd,wr1_split,
  wr1_data,
  wr1_pbit,wr1_d128,
  wrStall
  );
  
  

  
  always @(posedge clk)
  begin
    
    if (rst) begin
        bus_tlb_slot<=10'b0;
        req_addr_reg<=38'b0;
        req_en_reg<=1'b0;
        req_slot_reg<=10'b0;
        dc2_rhitA0_reg<=1'b0;
        dc2_rhitB0_reg<=1'b0;
        dc2_rhitB1_reg<=1'b0;
        dc2_rhitExpA0_reg<=1'b0;
        dc2_rhitExpB0_reg<=1'b0;
        dc2_rhitExpB1_reg<=1'b0;
        dc2_rd_addr<=37'b0;
        dc2_rd_addr_reg<=37'b0;
        dc2_rd_addr_reg2<=37'b0;
        dc2_rd_addr_reg3<=37'b0;
        dc2_rdEn_reg<=1'b0;
        dc2_rdEn_reg2<=1'b0;
        dc2_rdEn_reg3<=1'b0;
        dc2_rdEn_reg4<=1'b0;
        dc2_rdEnX_reg<=1'b0;
        dc2_rdEnX_reg2<=1'b0;
        dc2_rdEnX_reg3<=1'b0;
        dc2_rdEnX_reg4<=1'b0;
        dc2_dupl_rd_reg<=1'b0;
        dc2_dupl_rd_reg2<=1'b0;
        dc2_dupl_rd_reg3<=1'b0;
        dc2_dupl_rd_reg4<=1'b0;
        dc2_want_excl_reg<=1'b0;
        dc2_want_excl_reg2<=1'b0;
        dc2_want_excl_reg3<=1'b0;
        dc2_want_excl_reg4<=1'b0;
        dc2_req_rd_reg<=5'b0;
        dc2_req_rd_reg2<=5'b0;
        dc2_req_rd_reg3<=5'b0;
        dc2_req_rd_reg4<=5'b0;
        dc2_req_rd_reg5<=5'b0;
        rbusDIn_data_reg<=512'b0;
	rbusDIn_dataPTR_reg<=8'b0;
        rbusDIn_signals_reg<={`rbusD_width{1'b0}};
        dc2_rhit<=1'b0;
        dc2_rhitExp<=1'b0;
        dc2_rhitExp_reg<=1'b0;
        dc2_rDir_reg<=1'b0;
        dc2_rExcl_reg<=1'b0;
        dc2_rDir_reg2<=1'b0;
        dc2_rExcl_reg2<=1'b0;
        dc2_rdata_reg<=512'b0;
        dc2_rdataExp_reg<=512'b0;
	dc2_rdataPTR_reg<=8'b0;
	dc2_rdataExpPTR_reg<=8'b0;
        dc2_rLRU_reg<=5'b0;
	dc2_io_en_reg<=1'b0;
	dc2_io_en_reg2<=1'b0;
	dc2_io_en_reg3<=1'b0;
	dc2_io_en_reg4<=1'b0;
	dc2_io_en_reg5<=1'b0;
	dc2_dataIO_reg<=64'b0;
	dc2_dataIO_reg2<=64'b0;
	dc2_dataIO_reg3<=64'b0;
        L1_expAddr_en_reg<=1'b0;
        L1_expAddr_en_reg2<=1'b0;
        L1_expAddr_en_reg3<=1'b0;
        L1_expAddr_en_reg4<=1'b0;
        L1_expAddr_en_reg5<=1'b0;
    end else begin
        MSI_expAddr_reg<=MSI_expAddr;
        MSI_expAddr_en_reg<=MSI_expAddr_en;
        if (req_tlbEn) begin
            bus_tlb_slot<=req_slot;
        end
        req_addr_reg<=req_addr;
        req_en_reg<=req_en;
        req_slot_reg<=req_slot;
        dc2_rhitA0_reg<=dc2_rhitA0;
        dc2_rhitB0_reg<=dc2_rhitB0;
        dc2_rhitB1_reg<=dc2_rhitB1;
        dc2_rhitExpA0_reg<=dc2_rhitExpA0;
        dc2_rhitExpB0_reg<=dc2_rhitExpB0;
        dc2_rhitExpB1_reg<=dc2_rhitExpB1;
        dc2_rd_addr<=dc2_rdOdd ? {dc2_addrO0,1'b1} : {dc2_addrE0,1'b0};
        dc2_rd_addr_reg<=dc2_rd_addr;
        dc2_rd_addr_reg2<=dc2_rd_addr_reg;
        dc2_rd_addr_reg3<=dc2_rd_addr_reg2;
        dc2_rdEn_reg<=dc2_rdEn;
        dc2_rdEn_reg2<=dc2_rdEn_reg;
        dc2_rdEn_reg3<=dc2_rdEn_reg2;
        dc2_rdEn_reg4<=dc2_rdEn_reg3;
        dc2_rdEnX_reg<=dc2_rdEnX;
        dc2_rdEnX_reg2<=dc2_rdEnX_reg;
        dc2_rdEnX_reg3<=dc2_rdEnX_reg2;
        dc2_rdEnX_reg4<=dc2_rdEnX_reg3;
        dc2_dupl_rd_reg<=dc2_dupl_rd;
        dc2_dupl_rd_reg2<=dc2_dupl_rd_reg;
        dc2_dupl_rd_reg3<=dc2_dupl_rd_reg2;
        dc2_dupl_rd_reg4<=dc2_dupl_rd_reg3;
        dc2_want_excl_reg<=dc2_want_excl;
        dc2_want_excl_reg2<=dc2_want_excl_reg;
        dc2_want_excl_reg3<=dc2_want_excl_reg2;
        dc2_want_excl_reg4<=dc2_want_excl_reg3;
        dc2_req_rd_reg<=dc2_req_rd;
        dc2_req_rd_reg2<=dc2_req_rd_reg;
        dc2_req_rd_reg3<=dc2_req_rd_reg2;
        dc2_req_rd_reg4<=dc2_req_rd_reg3;
        dc2_req_rd_reg5<=dc2_req_rd_reg4;
        rbusDIn_data_reg<=rbusDIn_data;
        rbusDIn_dataPTR_reg<=rbusDIn_dataPTR;
        rbusDIn_signals_reg<=rbusDIn_signals;
        dc2_rhit<=dc2_rhitA0|dc2_rhitB0|dc2_rhitB1;
        dc2_rhitExp<=dc2_rhitExpA0|dc2_rhitExpB0|dc2_rhitExpB1;
	dc2_rhitExp_reg<=dc2_rhitExp;
        dc2_rDir_reg<=dc2_rDir;
        dc2_rExcl_reg<=dc2_rExcl;
        dc2_rDir_reg2<=dc2_rDir_reg;
        dc2_rExcl_reg2<=dc2_rExcl_reg;
        dc2_rdata_reg<=dc2_rdata;
        dc2_rdataExp_reg<=dc2_rdataExp;
	dc2_rdataPTR_reg<=dc2_rdataPTR;
        dc2_rdataExpPTR_reg<=dc2_rdataExpPTR;
        dc2_rLRU_reg<=dc2_rLRU;
        dc2_rdataA0_reg<=dc2_rdataA0[1023:512];
        dc2_rdataB0_reg<=dc2_rdataB0[1023:512];
        dc2_rdataB1_reg<=dc2_rdataB1[1023:512];
        dc2_rdataExpA0_reg<=dc2_rdataExpA0[1023:512];
        dc2_rdataExpB0_reg<=dc2_rdataExpB0[1023:512];
        dc2_rdataExpB1_reg<=dc2_rdataExpB1[1023:512];
	dc2_io_en_reg<=dc2_io_en;
	dc2_io_en_reg2<=dc2_io_en_reg;
	dc2_io_en_reg3<=dc2_io_en_reg2;
	dc2_io_en_reg4<=dc2_io_en_reg3;
	dc2_io_en_reg5<=dc2_io_en_reg4;
	dc2_dataIO_reg<=dc2_dataIO;
	dc2_dataIO_reg2<=dc2_dataIO_reg;
	dc2_dataIO_reg3<=dc2_dataIO_reg2;
        L1_expAddr_en_reg<=L1_expAddr_en;
        L1_expAddr_en_reg2<=L1_expAddr_en_reg;
        L1_expAddr_en_reg3<=L1_expAddr_en_reg2;
        L1_expAddr_en_reg4<=L1_expAddr_en_reg3;
        L1_expAddr_en_reg5<=L1_expAddr_en_reg4;
        L1_expAddr_en_reg5<=L1_expAddr_en_reg5;
    end
  end
endmodule



