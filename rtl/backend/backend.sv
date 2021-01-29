`include "../struct.sv"
`include "../fpoperations.sv"

//warning: rs*_alloc means allocate rat entry, not register
//rs*_alt means use store rs

module backend(
  clk,
  rst,
  doStall,

  thread,
  bundle_in,
  except,
  exceptIP,
  excpt_thread,
  excpt_both,
  excpt_due_jump,
  except_set_flag,
  excpt_ght,
  except_jmp_mask_en,
  except_jmp_mask,
  req_addr,
  req_tlbAttr,
  req_tlbEn,
  bus_tlb_data,
  bus_tlb_en,

  newAttr,

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
  rs0i0_ldst_flg,
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
  rs0i1_ldst_flg,

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
  rs1i0_ldst_flg,
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
  rs1i1_ldst_flg,

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
  rs2i0_ldst_flg,
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
  rs2i1_ldst_flg,

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

  jump0Type,jump0Pos,jump0Pred,jump0IP,jump0Mask,
  jump1Type,jump1Pos,jump1Pred,jump1IP,jump1Mask,
  jump0TbufWay,jump0JmpInd,jump0GHT,
  jump1TbufWay,jump1JmpInd,jump1GHT,
  jump0SC,jump0Miss,jump0TbufOnly,
  jump1SC,jump1Miss,jump1TbufOnly,
  instr_fsimd,
  baseIP,
  wrt0,wrt1,wrt2,

  jupd0_en,jupdt0_en,jupd0_ght_en,jupd0_addr,jupd0_baddr,jupd0_sc,jupd0_tk,
  jupd1_en,jupdt1_en,jupd1_ght_en,jupd1_addr,jupd1_baddr,jupd1_sc,jupd1_tk,
  
  csrss_no,csrss_en,csrss_data,
  
  insBus_en,
  insBus_io,
  insBus_req,
  insBus_dirty,
  insBus_exclusive,
  insBus_data,
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
  wr1_hit,
  wr1_addrE,wr1_addrO,
  wr1_banks,
  wr1_begin,wr1_end,
  wr1_bgn_ben,wr1_end_ben,
  wr1_odd,wr1_split,
  wr1_data,
  wrStall
//  extBus_en,
//  extBus_addr,
//  extBus_req,
//  extBus_want_excl
//  wbBus_en,
//  wbBus_req
  );
  localparam DATA_WIDTH=`alu_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam RRF_WIDTH=6;
  localparam IN_REG_WIDTH=6;
  localparam PORT_WIDTH=4;
  localparam REG_WIDTH=9;
  localparam IP_WIDTH=48;
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
  localparam BUS_WIDTH=512;
  localparam REQ_WIDTH=10;
  localparam PADDR_WIDTH=44;
  localparam BANK_WIDTH=`dcache1_data_width;
  localparam FN_WIDTH=10;
  localparam SIMD_WIDTH=68;//half width
  localparam CONST_WIDTH=33;
  parameter [4:0] BUS_ID=5'd0;
  
  input clk;
  input rst;
  output doStall;
  
  input thread;
  input bundle_in;

  output except;
  output [62:0] exceptIP;
  output excpt_thread;
  output excpt_both;
  output excpt_due_jump;
  output [7:0] excpt_ght;
  output except_set_flag;
  output except_jmp_mask_en;
  output [3:0] except_jmp_mask;

  input [35:0] req_addr; 
  input [3:0] req_tlbAttr;
  input req_tlbEn;
  output [`ctlbData_width-1:0] bus_tlb_data;
  output bus_tlb_en;

  input [3:0] newAttr;
  
  input [IN_REG_WIDTH-1:0] rs0i0_rA;
  input rs0i0_rA_use;
  input rs0i0_rA_useF;
  input rs0i0_rA_isV;
  input rs0i0_rA_isAnyV;
  input [IN_REG_WIDTH-1:0] rs0i0_rB;
  input rs0i0_rB_use;
  input rs0i0_rB_useF;
  input rs0i0_rB_isV;
  input rs0i0_rB_isAnyV;
  input rs0i0_useBConst;
  input [IN_REG_WIDTH-1:0] rs0i0_rT;
  input rs0i0_rT_use;
  input rs0i0_rT_useF;
  input rs0i0_rT_isV;
  input [PORT_WIDTH-1:0] rs0i0_port;
  input [OPERATION_WIDTH-1:0] rs0i0_operation;
  input rs0i0_en;
  input [DATA_WIDTH-1:0] rs0i0_const;
  input [3:0] rs0i0_index;
  input rs0i0_IPRel;
  input rs0i0_afterTaken;
  input rs0i0_alt;
  input rs0i0_alloc;
  input rs0i0_allocF;
  input rs0i0_allocR;
  input [5:0] rs0i0_lsi; 
  input rs0i0_ldst_flg; 
  input rs0i0_enA;
  input rs0i0_enB; 
 
  input [IN_REG_WIDTH-1:0] rs0i1_rA;
  input rs0i1_rA_use;
  input rs0i1_rA_useF;
  input rs0i1_rA_isV;
  input rs0i1_rA_isAnyV;
  input rs0i1_useAConst;
  input [IN_REG_WIDTH-1:0] rs0i1_rB;
  input rs0i1_rB_use;
  input rs0i1_rB_useF;
  input rs0i1_rB_isV;
  input rs0i1_rB_isAnyV;
  input rs0i1_useBConst;
  input [IN_REG_WIDTH-1:0] rs0i1_rT;
  input rs0i1_rT_use;
  input rs0i1_rT_useF;
  input rs0i1_rT_isV;
  input [PORT_WIDTH-1:0] rs0i1_port;
  input [OPERATION_WIDTH-1:0] rs0i1_operation;
  input rs0i1_en;
  input [DATA_WIDTH-1:0] rs0i1_const;
  input [3:0] rs0i1_index;
  input rs0i1_IPRel;
  input rs0i1_afterTaken;
  input rs0i1_alloc;
  input rs0i1_allocF;
  input rs0i1_allocR;
  input [3:0] rs0i1_flagDep;
  input rs0i1_lastFl;
  input [5:0] rs0i1_lsi;  
  input rs0i1_ldst_flg; 
  
  input [IN_REG_WIDTH-1:0] rs0i2_rA;
  input rs0i2_rA_use;
  input rs0i2_rA_useF;
  input rs0i2_rA_isV;
  input rs0i2_rA_isAnyV;
  input rs0i2_useAConst;
  input [IN_REG_WIDTH-1:0] rs0i2_rB;
  input rs0i2_rB_use;
  input rs0i2_rB_useF;
  input rs0i2_rB_isV;
  input rs0i2_rB_isAnyV;
  input rs0i2_useBConst;
  input [IN_REG_WIDTH-1:0] rs0i2_rT;
  input rs0i2_rT_use;
  input rs0i2_rT_useF;
  input rs0i2_rT_isV;
  input [PORT_WIDTH-1:0] rs0i2_port;
  input [OPERATION_WIDTH-1:0] rs0i2_operation;
  input rs0i2_en;
  input [DATA_WIDTH-1:0] rs0i2_const;
  input [3:0] rs0i2_index;
  input rs0i2_IPRel;
  input rs0i2_afterTaken;
  input rs0i2_alloc;
  input rs0i2_allocF;
  input rs0i2_allocR;
  input [3:0] rs0i2_flagDep;
  input rs0i2_lastFl;
  
  input [IN_REG_WIDTH-1:0] rs1i0_rA;
  input rs1i0_rA_use;
  input rs1i0_rA_useF;
  input rs1i0_rA_isV;
  input rs1i0_rA_isAnyV;
  input [IN_REG_WIDTH-1:0] rs1i0_rB;
  input rs1i0_rB_use;
  input rs1i0_rB_useF;
  input rs1i0_rB_isV;
  input rs1i0_rB_isAnyV;
  input rs1i0_useBConst;
  input [IN_REG_WIDTH-1:0] rs1i0_rT;
  input rs1i0_rT_use;
  input rs1i0_rT_useF;
  input rs1i0_rT_isV;
  input [PORT_WIDTH-1:0] rs1i0_port;
  input [OPERATION_WIDTH-1:0] rs1i0_operation;
  input rs1i0_en;
  input [DATA_WIDTH-1:0] rs1i0_const;
  input [3:0] rs1i0_index;
  input rs1i0_IPRel;
  input rs1i0_afterTaken;
  input rs1i0_alt;
  input rs1i0_alloc;
  input rs1i0_allocF;
  input rs1i0_allocR;
  input [5:0] rs1i0_lsi;  
  input rs1i0_ldst_flg; 
  input rs1i0_enA;
  input rs1i0_enB; 
  
  input [IN_REG_WIDTH-1:0] rs1i1_rA;
  input rs1i1_rA_use;
  input rs1i1_rA_useF;
  input rs1i1_rA_isV;
  input rs1i1_rA_isAnyV;
  input rs1i1_useAConst;
  input [IN_REG_WIDTH-1:0] rs1i1_rB;
  input rs1i1_rB_use;
  input rs1i1_rB_useF;
  input rs1i1_rB_isV;
  input rs1i1_rB_isAnyV;
  input rs1i1_useBConst;
  input [IN_REG_WIDTH-1:0] rs1i1_rT;
  input rs1i1_rT_use;
  input rs1i1_rT_useF;
  input rs1i1_rT_isV;
  input [PORT_WIDTH-1:0] rs1i1_port;
  input [OPERATION_WIDTH-1:0] rs1i1_operation;
  input rs1i1_en;
  input [DATA_WIDTH-1:0] rs1i1_const;
  input [3:0] rs1i1_index;
  input rs1i1_IPRel;
  input rs1i1_afterTaken;
  input rs1i1_alloc;
  input rs1i1_allocF;
  input rs1i1_allocR;
  input [3:0] rs1i1_flagDep;
  input rs1i1_lastFl;
  input [5:0] rs1i1_lsi;  
  input rs1i1_ldst_flg; 

  input [IN_REG_WIDTH-1:0] rs1i2_rA;
  input rs1i2_rA_use;
  input rs1i2_rA_useF;
  input rs1i2_rA_isV;
  input rs1i2_rA_isAnyV;
  input rs1i2_useAConst;
  input [IN_REG_WIDTH-1:0] rs1i2_rB;
  input rs1i2_rB_use;
  input rs1i2_rB_useF;
  input rs1i2_rB_isV;
  input rs1i2_rB_isAnyV;
  input rs1i2_useBConst;
  input [IN_REG_WIDTH-1:0] rs1i2_rT;
  input rs1i2_rT_use;
  input rs1i2_rT_useF;
  input rs1i2_rT_isV;
  input [PORT_WIDTH-1:0] rs1i2_port;
  input [OPERATION_WIDTH-1:0] rs1i2_operation;
  input rs1i2_en;
  input [DATA_WIDTH-1:0] rs1i2_const;
  input [3:0] rs1i2_index;
  input rs1i2_IPRel;
  input rs1i2_afterTaken;
  input rs1i2_alloc;
  input rs1i2_allocF;
  input rs1i2_allocR;
  input [3:0] rs1i2_flagDep;
  input rs1i2_lastFl;

  input [IN_REG_WIDTH-1:0] rs2i0_rA;
  input rs2i0_rA_use;
  input rs2i0_rA_useF;
  input rs2i0_rA_isV;
  input rs2i0_rA_isAnyV;
  input [IN_REG_WIDTH-1:0] rs2i0_rB;
  input rs2i0_rB_use;
  input rs2i0_rB_useF;
  input rs2i0_rB_isV;
  input rs2i0_rB_isAnyV;
  input rs2i0_useBConst;
  input [IN_REG_WIDTH-1:0] rs2i0_rT;
  input rs2i0_rT_use;
  input rs2i0_rT_useF;
  input rs2i0_rT_isV;
  input [PORT_WIDTH-1:0] rs2i0_port;
  input [OPERATION_WIDTH-1:0] rs2i0_operation;
  input rs2i0_en;
  input [DATA_WIDTH-1:0] rs2i0_const;
  input [3:0] rs2i0_index;
  input rs2i0_IPRel;
  input rs2i0_afterTaken;
  input rs2i0_alt;
  input rs2i0_alloc;
  input rs2i0_allocF;
  input rs2i0_allocR;
  input [5:0] rs2i0_lsi;  
  input rs2i0_ldst_flg; 
  input rs2i0_enA;
  input rs2i0_enB; 
  
  input [IN_REG_WIDTH-1:0] rs2i1_rA;
  input rs2i1_rA_use;
  input rs2i1_rA_useF;
  input rs2i1_rA_isV;
  input rs2i1_rA_isAnyV;
  input rs2i1_useAConst;
  input [IN_REG_WIDTH-1:0] rs2i1_rB;
  input rs2i1_rB_use;
  input rs2i1_rB_useF;
  input rs2i1_rB_isV;
  input rs2i1_rB_isAnyV;
  input rs2i1_useBConst;
  input [IN_REG_WIDTH-1:0] rs2i1_rT;
  input rs2i1_rT_use;
  input rs2i1_rT_useF;
  input rs2i1_rT_isV;
  input [PORT_WIDTH-1:0] rs2i1_port;
  input [OPERATION_WIDTH-1:0] rs2i1_operation;
  input rs2i1_en;
  input [DATA_WIDTH-1:0] rs2i1_const;
  input [3:0] rs2i1_index;
  input rs2i1_IPRel;
  input rs2i1_afterTaken;
  input rs2i1_alloc;
  input rs2i1_allocF;
  input rs2i1_allocR;
  input [3:0] rs2i1_flagDep;
  input rs2i1_lastFl;
  input [5:0] rs2i1_lsi;  
  input rs2i1_ldst_flg; 

  input [IN_REG_WIDTH-1:0] rs2i2_rA;
  input rs2i2_rA_use;
  input rs2i2_rA_useF;
  input rs2i2_rA_isV;
  input rs2i2_rA_isAnyV;
  input rs2i2_useAConst;
  input [IN_REG_WIDTH-1:0] rs2i2_rB;
  input rs2i2_rB_use;
  input rs2i2_rB_useF;
  input rs2i2_rB_isV;
  input rs2i2_rB_isAnyV;
  input rs2i2_useBConst;
  input [IN_REG_WIDTH-1:0] rs2i2_rT;
  input rs2i2_rT_use;
  input rs2i2_rT_useF;
  input rs2i2_rT_isV;
  input [PORT_WIDTH-1:0] rs2i2_port;
  input [OPERATION_WIDTH-1:0] rs2i2_operation;
  input rs2i2_en;
  input [DATA_WIDTH-1:0] rs2i2_const;
  input [3:0] rs2i2_index;
  input rs2i2_IPRel;
  input rs2i2_afterTaken;
  input rs2i2_alloc;
  input rs2i2_allocF;
  input rs2i2_allocR;
  input [3:0] rs2i2_flagDep;
  input rs2i2_lastFl;
  input rs2i2_mul;
  
  input [IN_REG_WIDTH-1:0] instr0_rT;
  input instr0_en;
  input instr0_wren;
  input [12:0] instr0_IPOff;
  input instr0_afterTaken;
  input instr0_rT_useF;
  input instr0_rT_isV;
  input [PORT_WIDTH-1:0] instr0_port;
  input [3:0] instr0_magic;
  input instr0_last;
  input instr0_aft_spc;
  
  input [IN_REG_WIDTH-1:0] instr1_rT;
  input instr1_en;
  input instr1_wren;
  input [12:0] instr1_IPOff;
  input instr1_afterTaken;
  input instr1_rT_useF;
  input instr1_rT_isV;
  input [PORT_WIDTH-1:0] instr1_port;
  input [3:0] instr1_magic;
  input instr1_last;
  input instr1_aft_spc;
  
  input [IN_REG_WIDTH-1:0] instr2_rT;
  input instr2_en;
  input instr2_wren;
  input [12:0] instr2_IPOff;
  input instr2_afterTaken;
  input instr2_rT_useF;
  input instr2_rT_isV;
  input [PORT_WIDTH-1:0] instr2_port;
  input [3:0] instr2_magic;
  input instr2_last;
  input instr2_aft_spc;
  
  input [IN_REG_WIDTH-1:0] instr3_rT;
  input instr3_en;
  input instr3_wren;
  input [12:0] instr3_IPOff;
  input instr3_afterTaken;
  input instr3_rT_useF;
  input instr3_rT_isV;
  input [PORT_WIDTH-1:0] instr3_port;
  input [3:0] instr3_magic;
  input instr3_last;
  input instr3_aft_spc;
  
  input [IN_REG_WIDTH-1:0] instr4_rT;
  input instr4_en;
  input instr4_wren;
  input [12:0] instr4_IPOff;
  input instr4_afterTaken;
  input instr4_rT_useF;
  input instr4_rT_isV;
  input [PORT_WIDTH-1:0] instr4_port;
  input [3:0] instr4_magic;
  input instr4_last;
  input instr4_aft_spc;
  
  input [IN_REG_WIDTH-1:0] instr5_rT;
  input instr5_en;
  input instr5_wren;
  input [12:0] instr5_IPOff;
  input instr5_afterTaken;
  input instr5_rT_useF;
  input instr5_rT_isV;
  input [PORT_WIDTH-1:0] instr5_port;
  input [3:0] instr5_magic;
  input instr5_last;
  input instr5_aft_spc;

  input [IN_REG_WIDTH-1:0] instr6_rT;
  input instr6_en;
  input instr6_wren;
  input [12:0] instr6_IPOff;
  input instr6_afterTaken;
  input instr6_rT_useF;
  input instr6_rT_isV;
  input [PORT_WIDTH-1:0] instr6_port;
  input [3:0] instr6_magic;
  input instr6_last;
  input instr6_aft_spc;

  input [IN_REG_WIDTH-1:0] instr7_rT;
  input instr7_en;
  input instr7_wren;
  input [12:0] instr7_IPOff;
  input instr7_afterTaken;
  input instr7_rT_useF;
  input instr7_rT_isV;
  input [PORT_WIDTH-1:0] instr7_port;
  input [3:0] instr7_magic;
  input instr7_last;
  input instr7_aft_spc;

  input [IN_REG_WIDTH-1:0] instr8_rT;
  input instr8_en;
  input instr8_wren;
  input [12:0] instr8_IPOff;
  input instr8_afterTaken;
  input instr8_rT_useF;
  input instr8_rT_isV;
  input [PORT_WIDTH-1:0] instr8_port;
  input [3:0] instr8_magic;
  input instr8_last;
  input instr8_aft_spc;

  input [IN_REG_WIDTH-1:0] instr9_rT;
  input instr9_en;
  input instr9_wren;
  input [12:0] instr9_IPOff;
  input instr9_afterTaken;
  input instr9_rT_useF;
  input instr9_rT_isV;
  input [PORT_WIDTH-1:0] instr9_port;
  input [3:0] instr9_magic;
  input instr9_last;
  input instr9_aft_spc;
  
  input [4:0] jump0Type;
  input [3:0] jump0Pos;
  input jump0Pred;
  input [63:0] jump0IP;
  input [3:0] jump0Mask;
  input [4:0] jump1Type;
  input [3:0] jump1Pos;
  input jump1Pred;
  input [63:0] jump1IP;
  input [3:0] jump1Mask;
  input [2:0] jump0TbufWay;
  input [1:0] jump0JmpInd;
  input [7:0] jump0GHT;
  input [2:0] jump1TbufWay;
  input [1:0] jump1JmpInd;
  input [7:0] jump1GHT;
  input [1:0] jump0SC;
  input jump0Miss;
  input jump0TbufOnly;
  input [1:0] jump1SC;
  input jump1Miss;
  input jump1TbufOnly;
  input [9:0] instr_fsimd;
  input [46:0] baseIP;
  input [5:0] wrt0;
  input [5:0] wrt1;
  input [5:0] wrt2;

  output jupd0_en;
  output jupdt0_en;
  output jupd0_ght_en;
  output [15:0] jupd0_addr;
  output [12:0] jupd0_baddr;
  output [1:0] jupd0_sc;
  output jupd0_tk;
  output jupd1_en;
  output jupdt1_en;
  output jupd1_ght_en;
  output [15:0] jupd1_addr;
  output [12:0] jupd1_baddr;
  output [1:0] jupd1_sc;
  output jupd1_tk;
  
  output [15:0] csrss_no;
  output csrss_en;
  output [63:0] csrss_data;
  
  input insBus_en;
  input insBus_io;
  input [REQ_WIDTH-1:0] insBus_req;
  input insBus_dirty;
  input insBus_exclusive;
  input [BUS_WIDTH-1:0] insBus_data;

  output reg reqBus_en;
  output reg [43:7] reqBus_addr;
  output reg [REQ_WIDTH-1:0] reqBus_req;
  output reg reqBus_want_excl;
  output reg reqBus_dupl;
  output reg reqBus_io;
  output reg [4:0] reqBus_sz;
  output reg [1:0] reqBus_low;
  output reg [4:0] reqBus_bank0;
  
  output [1:0] wr0_hit;
  output [35:0] wr0_addrE;
  output [35:0] wr0_addrO;
  output [31:0] wr0_banks;
  output [4:0] wr0_begin;
  output [4:0] wr0_end;
  output [3:0] wr0_bgn_ben;
  output [3:0] wr0_end_ben;
  output wr0_odd,wr0_split;
  output [159:0] wr0_data;
  output [1:0] wr1_hit;
  output [35:0] wr1_addrE;
  output [35:0] wr1_addrO;
  output [31:0] wr1_banks;
  output [4:0] wr1_begin;
  output [4:0] wr1_end;
  output [3:0] wr1_bgn_ben;
  output [3:0] wr1_end_ben;
  output [159:0] wr1_data;
  output wr1_odd,wr1_split;
  input wrStall;
/*
  reg reqBus_en;
  reg [43:7] reqBus_addr;
  reg [REQ_WIDTH-1:0] reqBus_req;
  reg reqBus_want_excl;
*/
  wire [2:0] useBConstW;
  wire [2:0] useAConstW;
  wire [2:0] rs_rAW_use;
  wire [2:0] rs_rAW_useF;
  wire [2:0] rs_rBW_use;
  wire [2:0] rs_rBW_useF;
  reg [2:0] rs_rAW_useF_reg;
  reg [2:0] rs_rBW_useF_reg;
  reg [2:0] rs_rAW_useF_reg2;
  reg [2:0] rs_rBW_useF_reg2;

  reg [3:0] newAttr_reg;
  reg [3:0] newAttr_reg2;

  wire [2:0][IN_REG_WIDTH-1:0] rrfAW;
  wire [2:0][IN_REG_WIDTH-1:0] rrfBW;
  wire [2:0][REG_WIDTH-1:0] regAW;
  wire [2:0][REG_WIDTH-1:0] regBW;
  wire [2:0][REG_WIDTH-1:0] regAWF;
  wire [2:0][REG_WIDTH-1:0] regBFW;
  wire [2:0] retAW;
  wire [2:0] retBW;
  wire [2:0] retAWF;
  wire [2:0] retBFW;
  reg [REG_WIDTH-1:0] regAW_reg[2:0];
  reg [REG_WIDTH-1:0] regBW_reg[2:0];
  reg [REG_WIDTH-1:0] regAWF_reg[2:0];
  reg [REG_WIDTH-1:0] regBFW_reg[2:0];
  reg [REG_WIDTH-1:0] regAWF_reg2[2:0];
  reg [REG_WIDTH-1:0] regBFW_reg2[2:0];
  reg [2:0] retAWF_reg;
  reg [2:0] retBFW_reg;
  reg [2:0] retAWF_reg2;
  reg [2:0] retBFW_reg2;
  reg [IN_REG_WIDTH-1:0] rrfAW_reg[2:0];
  reg [IN_REG_WIDTH-1:0] rrfBW_reg[2:0];
  reg [IN_REG_WIDTH-1:0] rrfAW_reg2[2:0];
  reg [IN_REG_WIDTH-1:0] rrfBW_reg2[2:0];
 
  wire [2:0] isAWF;
  wire [2:0] isBFW;
  reg [2:0] isAWF_reg;
  reg [2:0] isBFW_reg;
  wire [2:0] isAWV;
  wire [2:0] isBVW;
  reg [2:0] isAWV_reg;
  reg [2:0] isBVW_reg;

  wire [8:0][REG_WIDTH-1:0] regA;
  wire [8:0][REG_WIDTH-1:0] regB;
  wire [8:0][REG_WIDTH-1:0] regAF;
  wire [8:0][REG_WIDTH-1:0] regBF;
  wire [8:0][REG_WIDTH-1:0] regS;
  reg [REG_WIDTH-1:0] regA_reg[8:0];
  reg [REG_WIDTH-1:0] regB_reg[8:0];
  reg [REG_WIDTH-1:0] regS_reg[8:0];
  reg [REG_WIDTH-1:0] regAF_reg[8:0];
  reg [REG_WIDTH-1:0] regBF_reg[8:0];
  reg [REG_WIDTH-1:0] regAF_reg2[8:0];
  reg [REG_WIDTH-1:0] regBF_reg2[8:0];
  wire [2:0][REG_WIDTH-1:0] WregA;
  wire [2:0][REG_WIDTH-1:0] WregB;
  wire [8:0] retA;
  wire [8:0] retB;
  wire [8:0] retAF;
  wire [8:0] retBF;
  wire [8:0] retS;
  reg [8:0] retAF_reg;
  reg [8:0] retBF_reg;
  reg [8:0] retAF_reg2;
  reg [8:0] retBF_reg2;
  
  wire stall_alloc;
  wire doStall_alloc;
  wire [3:0] doStall_rs;
  wire [3:0] stall_rs;
  wire stall_LSQ;
  wire doStall_LSQ;
  wire stall_cntrl;
  wire doStall_cntrl;
  wire stall_LDQ;
  wire doStall_LDQ;
  wire stall_STQ;
  wire doStall_STQ;
  wire stall_WQ;
  wire doStall_WQ;

  wire [8:0][REG_WIDTH-1:0] newR;
  reg [REG_WIDTH-1:0] newR_reg[8:0];

  wire [8:0][FN_WIDTH-1:0] newU;
  wire [8:0][1:0] newD;

//  reg [REG_WIDTH-1:0] newU_reg[8:0];


  wire [8:0][REG_WIDTH-1:0] clrR;
  wire [8:0] clr;
  wire [8:0] clrS;
  reg [REG_WIDTH-1:0] clrR_reg[8:0];
  reg [8:0] clr_reg;
  reg [8:0] clrS_reg;

  reg [IN_REG_WIDTH-1:0] rs0i0_rT_reg;
  reg [IN_REG_WIDTH-1:0] rs0i1_rT_reg;
  reg [IN_REG_WIDTH-1:0] rs0i2_rT_reg;
  reg [IN_REG_WIDTH-1:0] rs1i0_rT_reg;
  reg [IN_REG_WIDTH-1:0] rs1i1_rT_reg;
  reg [IN_REG_WIDTH-1:0] rs1i2_rT_reg;
  reg [IN_REG_WIDTH-1:0] rs2i0_rT_reg;
  reg [IN_REG_WIDTH-1:0] rs2i1_rT_reg;
  reg [IN_REG_WIDTH-1:0] rs2i2_rT_reg;

  reg [IN_REG_WIDTH-1:0] rs0i0_rA_reg;
  reg [IN_REG_WIDTH-1:0] rs0i1_rA_reg;
  reg [IN_REG_WIDTH-1:0] rs0i2_rA_reg;
  reg [IN_REG_WIDTH-1:0] rs1i0_rA_reg;
  reg [IN_REG_WIDTH-1:0] rs1i1_rA_reg;
  reg [IN_REG_WIDTH-1:0] rs1i2_rA_reg;
  reg [IN_REG_WIDTH-1:0] rs2i0_rA_reg;
  reg [IN_REG_WIDTH-1:0] rs2i1_rA_reg;
  reg [IN_REG_WIDTH-1:0] rs2i2_rA_reg;

  reg [IN_REG_WIDTH-1:0] rs0i0_rB_reg;
  reg [IN_REG_WIDTH-1:0] rs0i1_rB_reg;
  reg [IN_REG_WIDTH-1:0] rs0i2_rB_reg;
  reg [IN_REG_WIDTH-1:0] rs1i0_rB_reg;
  reg [IN_REG_WIDTH-1:0] rs1i1_rB_reg;
  reg [IN_REG_WIDTH-1:0] rs1i2_rB_reg;
  reg [IN_REG_WIDTH-1:0] rs2i0_rB_reg;
  reg [IN_REG_WIDTH-1:0] rs2i1_rB_reg;
  reg [IN_REG_WIDTH-1:0] rs2i2_rB_reg;
  
  reg [IN_REG_WIDTH-1:0] rs0i0_rA_reg2;
  reg [IN_REG_WIDTH-1:0] rs0i1_rA_reg2;
  reg [IN_REG_WIDTH-1:0] rs0i2_rA_reg2;
  reg [IN_REG_WIDTH-1:0] rs1i0_rA_reg2;
  reg [IN_REG_WIDTH-1:0] rs1i1_rA_reg2;
  reg [IN_REG_WIDTH-1:0] rs1i2_rA_reg2;
  reg [IN_REG_WIDTH-1:0] rs2i0_rA_reg2;
  reg [IN_REG_WIDTH-1:0] rs2i1_rA_reg2;
  reg [IN_REG_WIDTH-1:0] rs2i2_rA_reg2;

  reg [IN_REG_WIDTH-1:0] rs0i0_rB_reg2;
  reg [IN_REG_WIDTH-1:0] rs0i1_rB_reg2;
  reg [IN_REG_WIDTH-1:0] rs0i2_rB_reg2;
  reg [IN_REG_WIDTH-1:0] rs1i0_rB_reg2;
  reg [IN_REG_WIDTH-1:0] rs1i1_rB_reg2;
  reg [IN_REG_WIDTH-1:0] rs1i2_rB_reg2;
  reg [IN_REG_WIDTH-1:0] rs2i0_rB_reg2;
  reg [IN_REG_WIDTH-1:0] rs2i1_rB_reg2;
  reg [IN_REG_WIDTH-1:0] rs2i2_rB_reg2;
  
  reg [IN_REG_WIDTH-1:0] rs0i0_rA_reg3;
  reg [IN_REG_WIDTH-1:0] rs0i1_rA_reg3;
  reg [IN_REG_WIDTH-1:0] rs0i2_rA_reg3;
  reg [IN_REG_WIDTH-1:0] rs1i0_rA_reg3;
  reg [IN_REG_WIDTH-1:0] rs1i1_rA_reg3;
  reg [IN_REG_WIDTH-1:0] rs1i2_rA_reg3;
  reg [IN_REG_WIDTH-1:0] rs2i0_rA_reg3;
  reg [IN_REG_WIDTH-1:0] rs2i1_rA_reg3;
  reg [IN_REG_WIDTH-1:0] rs2i2_rA_reg3;

  reg [IN_REG_WIDTH-1:0] rs0i0_rB_reg3;
  reg [IN_REG_WIDTH-1:0] rs0i1_rB_reg3;
  reg [IN_REG_WIDTH-1:0] rs0i2_rB_reg3;
  reg [IN_REG_WIDTH-1:0] rs1i0_rB_reg3;
  reg [IN_REG_WIDTH-1:0] rs1i1_rB_reg3;
  reg [IN_REG_WIDTH-1:0] rs1i2_rB_reg3;
  reg [IN_REG_WIDTH-1:0] rs2i0_rB_reg3;
  reg [IN_REG_WIDTH-1:0] rs2i1_rB_reg3;
  reg [IN_REG_WIDTH-1:0] rs2i2_rB_reg3;
  
  reg rs0i0_alloc_reg;
  reg rs0i1_alloc_reg;
  reg rs0i2_alloc_reg;
  reg rs1i0_alloc_reg;
  reg rs1i1_alloc_reg;
  reg rs1i2_alloc_reg;
  reg rs2i0_alloc_reg;
  reg rs2i1_alloc_reg;
  reg rs2i2_alloc_reg;

  reg rs0i0_allocF_reg;
  reg rs0i1_allocF_reg;
  reg rs0i2_allocF_reg;
  reg rs1i0_allocF_reg;
  reg rs1i1_allocF_reg;
  reg rs1i2_allocF_reg;
  reg rs2i0_allocF_reg;
  reg rs2i1_allocF_reg;
  reg rs2i2_allocF_reg;

  reg rs0i0_allocR_reg;
  reg rs0i1_allocR_reg;
  reg rs0i2_allocR_reg;
  reg rs1i0_allocR_reg;
  reg rs1i1_allocR_reg;
  reg rs1i2_allocR_reg;
  reg rs2i0_allocR_reg;
  reg rs2i1_allocR_reg;
  reg rs2i2_allocR_reg;

  reg rs0i0_en_reg;
  reg rs0i1_en_reg;
  reg rs0i2_en_reg;
  reg rs1i0_en_reg;
  reg rs1i1_en_reg;
  reg rs1i2_en_reg;
  reg rs2i0_en_reg;
  reg rs2i1_en_reg;
  reg rs2i2_en_reg;
  
  reg rs0i0_useBConst_reg;
  reg rs0i1_useBConst_reg;
  reg rs0i2_useBConst_reg;
  reg rs1i0_useBConst_reg;
  reg rs1i1_useBConst_reg;
  reg rs1i2_useBConst_reg;
  reg rs2i0_useBConst_reg;
  reg rs2i1_useBConst_reg;
  reg rs2i2_useBConst_reg;
  
  reg [DATA_WIDTH-1:0] rs_const[8:0];
  reg [DATA_WIDTH-1:0] rs_const_reg[8:0];
  reg [DATA_WIDTH-1:0] rs_const_new[8:0];
  reg [8:0] rs_IPRel;
  reg [8:0] rs_afterTK;

  reg rs_en[8:0];
  reg rs_en_reg[8:0];
  reg [2:0] rs_enA;
  reg [2:0] rs_enB;
  reg [2:0] rs_enA_reg;
  reg [2:0] rs_enB_reg;
  reg [8:0] rs_ldst_flg;
  reg [8:0] rs_ldst_flg_reg;
  
  wire [2:0] rs_enAW;
  wire [2:0] rs_enBW;
  reg [2:0] rs_enAW_reg;
  reg [2:0] rs_enBW_reg;

  reg [3:0] rs0i0_index_reg;
  reg [3:0] rs0i1_index_reg;
  reg [3:0] rs0i2_index_reg;
  reg [3:0] rs1i0_index_reg;
  reg [3:0] rs1i1_index_reg;
  reg [3:0] rs1i2_index_reg;
  reg [3:0] rs2i0_index_reg;
  reg [3:0] rs2i1_index_reg;
  reg [3:0] rs2i2_index_reg;

  reg rs2i2_mul_reg;

  reg [3:0] rs0i1_flagDep_reg;
  reg [3:0] rs0i2_flagDep_reg;
  reg [3:0] rs1i1_flagDep_reg;
  reg [3:0] rs1i2_flagDep_reg;
  reg [3:0] rs2i1_flagDep_reg;
  reg [3:0] rs2i2_flagDep_reg;

  reg [3:0] rs0i1_flagDep_reg2;
  reg [3:0] rs0i2_flagDep_reg2;
  reg [3:0] rs1i1_flagDep_reg2;
  reg [3:0] rs1i2_flagDep_reg2;
  reg [3:0] rs2i1_flagDep_reg2;
  reg [3:0] rs2i2_flagDep_reg2;

  reg rs0i1_lastFl_reg;
  reg rs0i2_lastFl_reg;
  reg rs1i1_lastFl_reg;
  reg rs1i2_lastFl_reg;
  reg rs2i1_lastFl_reg;
  reg rs2i2_lastFl_reg;

  reg [OPERATION_WIDTH-1:0] rs_operation[8:0];
  reg [OPERATION_WIDTH-1:0] rs_operation_reg[8:0];
  reg [OPERATION_WIDTH-1:0] rs_operation_reg2[8:0];

  reg [3:0] rs_port[8:0];
  reg [3:0] rs_port_reg[8:0];
  reg [3:0] rs_port_sch[8:0];
  
  reg [3:0] rs_index[8:0];
  reg [3:0] rs_index_reg[8:0];
  
  reg [8:0] rs_rA_use;
  reg [8:0] rs_rB_use;

  reg [8:0] rs_rA_useF;
  reg [8:0] rs_rB_useF;

  reg [8:0] rs_rA_useF_reg;
  reg [8:0] rs_rB_useF_reg;

  reg [8:0] rs_rA_useF_reg2;
  reg [8:0] rs_rB_useF_reg2;
  
  reg [8:0] rs_useBConst;
  reg [8:0] rs_useBConst_reg;
  reg [8:0] rs_useAConst;
  
  reg [5:0] rs_lsi[5:0];
  reg [2:0] rs_lsi_reg[5:0];

  reg [2:0] rs_alt;
  reg [2:0] rs_alt_reg;

  reg [8:0] rs_rA_isV;
  reg [8:0] rs_rA_isAnyV;
  reg [8:0] rs_rB_isV;
  reg [8:0] rs_rB_isAnyV;
  reg [8:0] rs_rT_isV;
  reg [8:0] rs_rT_use;
  reg [8:0] rs_rT_useF;

  wire [8:0] domErrA;
  wire [8:0] domErrB;
 
  wire [9:0] lsi_cnt;
  reg  [5:0] lsi_cnt_reg;
  wire [5:0] lsi_bits;
 
  reg [IN_REG_WIDTH-1:0] instr_rT[9:0];
  reg [9:0] instr_en;
  reg [9:0] instr_wren;
  reg [12:0] instr_IPOff[9:0];
  reg [9:0] instr_afterTaken;
  reg [9:0] instr_rT_useF;
  reg [9:0] instr_rT_isV;
  reg [PORT_WIDTH-1:0] instr_port[9:0];
  reg [3:0] instr_magic[9:0];
  reg [9:0] instr_last;
  reg [9:0] instr_aft_spc;
  
  reg [4:0] jump0Type_reg;
  reg [3:0] jump0Pos_reg;
  reg jump0Pred_reg;
  reg [63:0] jump0IP_reg;
  reg [3:0] jump0Mask_reg;
  reg [4:0] jump1Type_reg;
  reg [3:0] jump1Pos_reg;
  reg jump1Pred_reg;
  reg [63:0] jump1IP_reg;
  reg [3:0] jump1Mask_reg;
  reg [9:0] instr_fsimd_reg;
  reg [46:0] baseIP_reg;
  reg [5:0] wrt0_reg;
  reg [5:0] wrt1_reg;
  reg [5:0] wrt2_reg;
  
  reg [2:0] jump0TbufWay_reg;
  reg [1:0] jump0JmpInd_reg;
  reg [7:0] jump0GHT_reg;
  reg [2:0] jump1TbufWay_reg;
  reg [1:0] jump1JmpInd_reg;
  reg [7:0] jump1GHT_reg;
  reg [1:0] jump0SC_reg;
  reg jump0Miss_reg;
  reg jump0TbufOnly_reg;
  reg [1:0] jump1SC_reg;
  reg jump1Miss_reg;
  reg jump1TbufOnly_reg;

  reg [IN_REG_WIDTH-1:0] instr_rT_reg[9:0];
  reg [9:0] instr_en_reg;
  reg [9:0] instr_wren_reg;
  reg [12:0] instr_IPOff_reg[9:0];
  reg [9:0] instr_afterTaken_reg;
  reg [9:0] instr_rT_useF_reg;
  reg [9:0] instr_rT_isV_reg;
  reg [PORT_WIDTH-1:0] instr_port_reg[9:0];
//  reg [3:0] instr_magic_reg[9:0];
  reg [9:0] instr_last_reg;

  reg [2:0] instr_magicOff[9:0];
  reg [9:0] instr_gen;
  reg [9:0] instr_vec;
  reg [9:0] instr_aft_spc_reg;

  reg [4:0] jump0Type_reg2;
  reg [3:0] jump0Pos_reg2;
  reg jump0Pred_reg2;
  reg [63:0] jump0IP_reg2;
  reg [3:0] jump0Mask_reg2;
  reg [4:0] jump1Type_reg2;
  reg [3:0] jump1Pos_reg2;
  reg jump1Pred_reg2;
  reg [63:0] jump1IP_reg2;
  reg [3:0] jump1Mask_reg2;
  reg [9:0] instr_fsimd_reg2;
//  reg [46:0] baseIP_reg2;

  reg [2:0] jump0TbufWay_reg2;
  reg [1:0] jump0JmpInd_reg2;
  reg [7:0] jump0GHT_reg2;
  reg [2:0] jump1TbufWay_reg2;
  reg [1:0] jump1JmpInd_reg2;
  reg [7:0] jump1GHT_reg2;
  reg [1:0] jump0SC_reg2;
  reg jump0Miss_reg2;
  reg jump0TbufOnly_reg2;
  reg [1:0] jump1SC_reg2;
  reg jump1Miss_reg2;
  reg jump1TbufOnly_reg2;

  wire [3:0] wrtII0;
  wire [3:0] wrtII1;
  wire [3:0] wrtII2;
  wire [2:0] wrtO0;
  wire [2:0] wrtO1;
  wire [2:0] wrtO2;
  reg [3:0] wrtII0_reg;
  reg [3:0] wrtII1_reg;
  reg [3:0] wrtII2_reg;
  reg [2:0] wrtO0_reg;
  reg [2:0] wrtO1_reg;
  reg [2:0] wrtO2_reg;
//functional units
  wire [9:0][DATA_WIDTH-1:0] FU;
  wire [9:0][REG_WIDTH-1:0] FUreg;
  wire [9:0]FUwen;
  reg FUwen0;
  reg FUwen1;
  reg FUwen2;
  reg FUwen3;
  wire [DATA_WIDTH-1:0] FUMUL;
  wire [DATA_WIDTH-1:0] FUCVT1;
  wire [81:0] FUCVT2;
  reg  [81:0] FUCVT2_reg;
  reg  [81:0] FUCVT2_reg2;
  reg  [81:0] FUCVT2_reg3;
  reg  [81:0] FUCVT2_reg4;
  reg  [81:0] FUCVT2_reg5;
  reg  [81:0] FUCVT2_reg6;
  wire [1:0] FUTYPE;
  reg  [1:0] FUTYPE_reg;
  reg  [1:0] FUTYPE_reg2;
  reg  [1:0] FUTYPE_reg3;
  reg  [1:0] FUTYPE_reg4;
  reg  [1:0] FUTYPE_reg5;
  reg  [1:0] FUTYPE_reg6;
  wire [9:0][SIMD_WIDTH-1:0] FUVH;
  wire [9:0][SIMD_WIDTH-1:0] FUVL;
  wire [9:0][SIMD_WIDTH-1:0] FUFH;
  wire [9:0][16+SIMD_WIDTH-1:0] FUFL;
  wire [5:0][SIMD_WIDTH-1:0] FOOFH;
  wire [5:0][16+SIMD_WIDTH-1:0] FOOFL;
  reg [SIMD_WIDTH-1:0] FOOFH_reg[5:0];
  reg [16+SIMD_WIDTH-1:0] FOOFL_reg[5:0];
//  wire [9:0][SIMD_WIDTH-1:0] FUFUH;
//  wire [9:0][SIMD_WIDTH-1:0] FUFUL;
  wire [2:0][5:0] FOOSH;
  wire [2:0][5:0] FOOSL;
  wire [2:0][5:0] FOOS;
  reg  [2:0][5:0] FOOS_reg;
  reg  [2:0][5:0] FOOS_reg2;

  wire [5:0][DATA_WIDTH-1:0] FU_alu;
  wire [5:0][5:0] FUS_alu;
  wire [5:0][2:0] ex_alu;
  wire [5:0] enS_alu;
  wire [2:0][5:0] FUX_alu;
  wire [2:0][2:0] exx_alu;
  reg [5:0] FUS_alu_reg[5:0];
  reg [2:0] ex_alu_reg[5:0];
  reg [5:0] enS_alu_reg;
  reg [5:0] FUS_alu_reg2[5:0];
  reg [2:0] ex_alu_reg2[5:0];
  reg [5:0] enS_alu_reg2;
  reg [5:0] FUS_alu_reg3[5:0];
  reg [2:0] ex_alu_reg3[5:0];
  reg [5:0] enS_alu_reg3;
  reg [5:0] FUS_alu_reg4[5:0];
  reg [2:0] ex_alu_reg4[5:0];
  reg [5:0] enS_alu_reg4;
  reg [5:0] FUS_alu_reg5[5:0];
  reg [2:0] ex_alu_reg5[5:0];
  reg [5:0] enS_alu_reg5;
  reg [5:0] FUS_alu_reg6[5:0];
  reg [2:0] ex_alu_reg6[5:0];
  reg [5:0] enS_alu_reg6;
  
  wire [1:0] dalt;
/*  reg [5:0] FUX_alu_reg;
  reg [2:0] exx_alu_reg;
  reg [5:0] FUX_alu_reg2;
  reg [2:0] exx_alu_reg2;
  reg [5:0] FUX_alu_reg3;
  reg [2:0] exx_alu_reg3;
  reg [5:0] FUX_alu_reg4;
  reg [2:0] exx_alu_reg4;
  reg [5:0] FUX_alu_reg5;
  reg [2:0] exx_alu_reg5;
*/
  
//FLAGS FU*
  wire [5:0] FUS1;
  wire [5:0] FUS2;
  wire [5:0] FUS3;
  wire [5:0] FUS4;
  wire [5:0] FUS5;
  wire [5:0] FUS6;
  wire [5:0] FUS7;
  wire [5:0] FUS8;
  wire [5:0] FUS9;

  
  wire FU0Hit,FU1Hit,FU2Hit,FU3Hit;
  wire FU0HitP,FU1HitP,FU2HitP,FU3HitP;
  reg FU0Hit_reg,FU1Hit_reg,FU2Hit_reg,FU3Hit_reg;
  reg FU0Hit_reg2,FU1Hit_reg2,FU2Hit_reg2,FU3Hit_reg2;
//  wire FU0HitP,FU1HitP,FU2HitP,FU3HitP;
  reg [3:0] fxLD_dbl;
  reg [3:0] fxLD_ext;
  reg [3:0] fxLD_dblext;
  reg [3:0] fxLD_sin;
  reg [3:0] fxLD_dbl_t;
  reg [3:0] fxLD_ext_t;
  reg [3:0] fxLD_sngl_t;
  reg [3:0] fxLD_spair_t;
  
  reg [DATA_WIDTH-1:0] FU_reg[9:0];
  reg [DATA_WIDTH-1:0] FU_reg2[9:0];

  reg [REG_WIDTH-1:0] FUreg_reg[9:0];
  reg FUwen_reg[9:0];
  reg [REG_WIDTH-1:0] FUreg_reg2[9:0];
  reg FUwen_reg2[9:0];
  reg [REG_WIDTH-1:0] FUreg_reg3[9:0];
  reg FUwen_reg3[9:0];
  reg [REG_WIDTH-1:0] FUreg_reg4[9:0];
  reg FUwen_reg4[9:0];
  reg [REG_WIDTH-1:0] FUreg_reg5[9:0];
  reg FUwen_reg5[9:0];
  reg [REG_WIDTH-1:0] FUreg_reg6[9:0];
  reg FUwen_reg6[9:0];
  reg [REG_WIDTH-1:0] FUreg_reg7[9:0];
  reg FUwen_reg7[9:0];
  reg [SIMD_WIDTH-1:0] FUVH_reg[9:0];
  reg [SIMD_WIDTH-1:0] FUVL_reg[9:0];
  reg [SIMD_WIDTH-1:0] FUFH_reg[9:0];
  reg [16+SIMD_WIDTH-1:0] FUFL_reg[9:0];
  reg [SIMD_WIDTH-1:0] FUVH_reg2[9:0];
  reg [SIMD_WIDTH-1:0] FUVL_reg2[9:0];
  reg [SIMD_WIDTH-1:0] FUFH_reg2[9:0];
  reg [16+SIMD_WIDTH-1:0] FUFL_reg2[9:0];

  reg [5:0] FUS1_reg;
  reg [5:0] FUS2_reg;
  reg [5:0] FUS3_reg;
  reg [5:0] FUS4_reg;
  reg [5:0] FUS5_reg;
  reg [5:0] FUS6_reg;
  reg [5:0] FUS7_reg;
  reg [5:0] FUS8_reg;
  reg [5:0] FUS9_reg;


  wire [8:0][DATA_WIDTH-1:0] dataA;
  wire [8:0][DATA_WIDTH-1:0] dataB;
  wire [2:0][DATA_WIDTH-1:0] WdataA;
  wire [2:0][DATA_WIDTH-1:0] WdataB;
  wire [8:0] inflA;
  wire [8:0] inflB;
  wire [2:0] WinflA;
  wire [2:0] WinflB;
  wire inflS;
  wire [8:0] Sinfl;
  wire [8:0][10:0] gazumpA;
  wire [8:0][10:0] gazumpB;
  wire [2:0][10:0] WgazumpA;
  wire [2:0][10:0] WgazumpB;
  wire [8:0][10:0] gazumpAG;
  wire [8:0][10:0] gazumpBG;
  wire [8:0][10:0] gazumpAV;
  wire [8:0][10:0] gazumpBV;
  wire [8:0][10:0] gazumpFA;
  wire [8:0][10:0] gazumpFB;
  wire [10:0] gazumpS;
  wire [5:0] dataS;
  
  wire [8:0] isAV;
  wire [8:0] isBV;
  reg [8:0] isAV_reg;
  reg [8:0] isBV_reg;
  wire [8:0] isAF;
  wire [8:0] isBF;
  reg [8:0] isAF_reg;
  reg [8:0] isBF_reg;

  wire [2:0][6:0] Wport;
  reg [6:0] Wport_reg[2:0];
  
  wire [8:0][SIMD_WIDTH-1:0] dataAVH;
  wire [8:0][SIMD_WIDTH-1:0] dataAVL;
  wire [8:0][SIMD_WIDTH-1:0] dataAFH;
  wire [8:0][16+SIMD_WIDTH-1:0] dataAFL;

  wire [8:0][SIMD_WIDTH-1:0] dataBVH;
  wire [8:0][16+SIMD_WIDTH-1:0] dataBVL;
  wire [8:0][SIMD_WIDTH-1:0] dataBFH;
  wire [8:0][16+SIMD_WIDTH-1:0] dataBFL;

  wire [2:0][SIMD_WIDTH-1:0] WdataAVH;
  wire [2:0][SIMD_WIDTH-1:0] WdataAVL;
  wire [2:0][SIMD_WIDTH-1:0] WdataAFH;
  wire [2:0][16+SIMD_WIDTH-1:0] WdataAFL;

  wire [2:0][SIMD_WIDTH-1:0] WdataBVH;
  wire [2:0][SIMD_WIDTH-1:0] WdataBVL;
  wire [2:0][SIMD_WIDTH-1:0] WdataBFH;
  wire [2:0][16+SIMD_WIDTH-1:0] WdataBFL;

  wire [8:0][DATA_WIDTH-1:0] ret_dataA;
  wire [8:0][DATA_WIDTH-1:0] ret_dataB;
  
  wire [8:0][SIMD_WIDTH-1:0] ret_dataAVH;
  wire [8:0][SIMD_WIDTH-1:0] ret_dataAVL;
  wire [8:0][SIMD_WIDTH-1:0] ret_dataAFH;
  wire [8:0][16+SIMD_WIDTH-1:0] ret_dataAFL;

  wire [8:0][SIMD_WIDTH-1:0] ret_dataBVH;
  wire [8:0][SIMD_WIDTH-1:0] ret_dataBVL;
  wire [8:0][SIMD_WIDTH-1:0] ret_dataBFH;
  wire [8:0][16+SIMD_WIDTH-1:0] ret_dataBFL;

  wire [8:0] depA;
  wire [8:0] depB;
  wire [8:0] depAF;
  wire [8:0] depBF;
  reg [8:0] depA_reg;
  reg [8:0] depB_reg;
  
  wire [8:0][FN_WIDTH-1:0] funA;
  wire [8:0][FN_WIDTH-1:0] funB;
  wire [8:0][FN_WIDTH-1:0] funAF;
  wire [8:0][FN_WIDTH-1:0] funBF;
  reg [FN_WIDTH-1:0] funA_reg[8:0];
  reg [FN_WIDTH-1:0] funB_reg[8:0];
  wire [2:0][FN_WIDTH-1:0] WfunA;
  wire [2:0][FN_WIDTH-1:0] WfunB;

  wire [8:0][FN_WIDTH-1:0] funS;
  reg [FN_WIDTH-1:0] funS_reg[8:0];

  wire [8:0][1:0] domA;
  wire [8:0][1:0] domB;
 // wire [8:0][1:0] domAF;
 // wire [8:0][1:0] domBF;

  reg [1:0] domA_reg[8:0];
  reg [1:0] domB_reg[8:0];
  
  wire [3:0] retcnt;
  wire [8:0] retclr;

  wire [8:0][DATA_WIDTH-1:0] outDataA;
  wire [8:0][DATA_WIDTH-1:0] outDataB;
  wire [5:0][SIMD_WIDTH-1:0] outDataAVH;
  wire [5:0][SIMD_WIDTH-1:0] outDataBVH;
  wire [5:0][SIMD_WIDTH-1:0] outDataAVL;
  wire [5:0][SIMD_WIDTH-1:0] outDataBVL;
  wire [5:0][SIMD_WIDTH-1:0] outDataAFH;
  wire [5:0][SIMD_WIDTH-1:0] outDataBFH;
  wire [5:0][16+SIMD_WIDTH-1:0] outDataAFL;
  wire [5:0][16+SIMD_WIDTH-1:0] outDataBFL;
  wire [2:0][32:0] outDataC;
  wire [8:0][5:0] outDataS;
  wire [8:0][REG_WIDTH-1:0] outReg;
  wire [8:0][OPERATION_WIDTH-1:0] outOp;
  wire [8:0][9:0] outII;
  wire [8:0][3:0] outEn;
  wire [2:0][8:0] outLSQ;
  wire [2:0][7:0] outWQ;
  wire [8:0][3:0] fuFwdA;
  wire [8:0][3:0] fuFwdB;
  wire [8:0][3:0] fuFwdS;
  wire [8:0][3:0] fuuFwdA;
  wire [8:0][3:0] fuuFwdB;
  wire [8:0][3:0] fuuFwdS;
  wire [8:0] outThr;
  wire [8:0][3:0] outAttr;
  wire [2:0] outLSflag;
  wire [2:0][3:0] fuFwdAH;
  wire [2:0][3:0] fuFwdBH;
  wire [2:0][3:0] fuuFwdAH;
  wire [2:0][3:0] fuuFwdBH;
  
  wire [2:0][3:0] outShiftSize;
  
  reg [3:0] fuFwdA_reg[8:0];
  reg [3:0] fuFwdB_reg[8:0];
  reg [3:0] fuFwdA_reg2[8:0];
  reg [3:0] fuFwdB_reg2[8:0];
  reg [3:0] fuuFwdA_reg[8:0];
  reg [3:0] fuuFwdB_reg[8:0];
  reg [3:0] fuuFwdA_reg2[8:0];
  reg [3:0] fuuFwdB_reg2[8:0];
  reg [3:0] fuFwdAH_reg[2:0];
  reg [3:0] fuFwdBH_reg[2:0];
  reg [3:0] fuuFwdAH_reg[2:0];
  reg [3:0] fuuFwdBH_reg[2:0];
  wire [REG_WIDTH-1:0] regFl;
  wire retFl;
//  wire [FN_WIDTH-1:0] funFl;
  
  wire [1:0][DATA_WIDTH-1:0] WoutDataA;
  wire [1:0][DATA_WIDTH-1:0] WoutDataB;
  wire [1:0][CONST_WIDTH-1:0] WoutDataC;
  wire [1:0][OPERATION_WIDTH-1:0] WoutOp;
  wire [1:0][9:0] WoutII;
  wire [1:0][7:0] WoutWQ;
  wire [1:0][3:0] WfuFwdA;
  wire [1:0][3:0] WfuFwdB;
  wire [1:0][3:0] WfuuFwdA;
  wire [1:0][3:0] WfuuFwdB;
  wire [1:0][8:0] WoutLSQ;
  wire [1:0][3:0] WoutDataEn;
  wire [1:0]WoutThread;
  wire [1:0][3:0] WoutShiftSize;
  wire [1:0]Wagu_blockRS;
  reg Wagu_blockRS_reg[1:0];
  wire alu_jupdate=enS_alu[5];
  wire [1:0] WoutLSflag;
  wire [1:0][3:0] WoutAttr;
  
  wire [1:0][DATA_WIDTH-1:0] WfxDataA;
  wire [1:0][DATA_WIDTH-1:0] WfxDataB;
  wire [1:0][CONST_WIDTH-1:0] WfxDataC;
  wire [1:0][OPERATION_WIDTH-1:0] WfxOp;
  wire [1:0][9:0] WfxII;
  wire [1:0][7:0] WfxWQ;
  wire [1:0][8:0] WfxLSQ;
  wire [1:0][3:0] WfxDataEn;
  wire [1:0]WfxThread;
  wire [1:0][3:0] WfxShiftSize;
  wire [1:0] WfxLSflag;
  
  reg [DATA_WIDTH-1:0] WfxDataA_reg[1:0];
  reg [DATA_WIDTH-1:0] WfxDataB_reg[1:0];
  reg [CONST_WIDTH-1:0] WfxDataC_reg[1:0];
  reg [OPERATION_WIDTH-1:0] WfxOp_reg[1:0];
  reg [9:0] WfxII_reg[1:0];
  reg [7:0] WfxWQ_reg[1:0];
  reg [8:0] WfxLSQ_reg[1:0];
  reg [3:0] WfxDataEn_reg[1:0];
  reg WfxThread_reg[1:0];
  reg [3:0] WfxShiftSize_reg[1:0];
  
  wire [1:0][DATA_WIDTH-1:0] WDoutData;
  wire [1:0][OPERATION_WIDTH-1:0] WDoutOp;
  reg [1:0][OPERATION_WIDTH-1:0] WDoutOp_reg;
  reg [1:0][OPERATION_WIDTH-1:0] WDoutOp_reg2;
  reg [1:0][OPERATION_WIDTH-1:0] WDoutOp_reg3;
  wire [1:0][9:0] WDoutII;
  wire [1:0][3:0] WDoutFuFwd;
  wire [1:0][3:0] WDoutFuuFwd;
  reg [3:0] WDoutFuFwd_reg[1:0];
  reg [3:0] WDoutFuuFwd_reg[1:0];
  reg [3:0] WDoutFuFwd_reg2[1:0];
  reg [3:0] WDoutFuuFwd_reg2[1:0];
  wire [1:0][8:0] WDoutLSQ;
  wire [1:0][3:0] WDoutDataEn;
  reg [3:0] WDoutDataEn_reg[1:0];
  reg [3:0] WDoutDataEn_reg2[1:0];
  wire [1:0][7:0] WDoutWQ;
  wire [1:0]WDoutThread;
  wire [1:0][SIMD_WIDTH-1:0] WDoutDataVH;
  wire [1:0][SIMD_WIDTH-1:0] WDoutDataVL;
  wire [1:0][SIMD_WIDTH-1:0] WDoutDataFH;
  wire [1:0][16+SIMD_WIDTH-1:0] WDoutDataFL;
  
  wire [1:0][DATA_WIDTH-1:0] WDfxData;
  reg  [DATA_WIDTH-1:0] WDfxData_reg[1:0];
  reg  [DATA_WIDTH-1:0] WDfxData_reg2[1:0];
  reg  [DATA_WIDTH-1:0] WDfxData_reg3[1:0];
  wire [1:0][SIMD_WIDTH-1:0] WDfxDataVH;
  wire [1:0][SIMD_WIDTH-1:0] WDfxDataVL;
  wire [1:0][SIMD_WIDTH-1:0] WDfxDataFH;
  wire [1:0][16+SIMD_WIDTH-1:0] WDfxDataFL;
  wire [1:0][OPERATION_WIDTH-1:0] WDfxOp;
  wire [1:0][9:0] WDfxII;
  reg [9:0] WDfxII_reg[1:0];
  reg [9:0] WDfxII_reg2[1:0];
  reg [9:0] WDfxII_reg3[1:0];
  wire [1:0][3:0] WDfxDataEn;
  reg  [3:0] WDfxDataEn_reg[1:0];
  reg  [3:0] WDfxDataEn_reg2[1:0];
  reg  [3:0] WDfxDataEn_reg3[1:0];
  reg  [3:0] WDfxDataEn_reg4[1:0];
  wire [1:0][8:0] WDfxLSQ;
  wire [1:0][7:0] WDfxWQ;
  reg  [7:0] WDfxWQ_reg[1:0];
  reg  [7:0] WDfxWQ_reg2[1:0];
  reg  [7:0] WDfxWQ_reg3[1:0];
  reg  [7:0] WDfxWQ_reg4[1:0];
  wire [1:0] WDfxThr;
 
  wire [1:0][127:0] lsw_wdataF0;
  wire [1:0][127:0] lsw_wdataF1;
  wire [1:0][127:0] lsw_wdataF;
  reg [127:0] lsw_wdataF_reg[1:0];
  wire [1:0][127:0] lsw_wdataV;
  reg [127:0] lsw_wdataV_reg[1:0];
  wire [1:0][127:0] lsw_wdata; 

  wire pause_agu;
  wire miss_pause_agu;
  reg miss_pause_agu_reg;
  reg miss_pause_agu_reg2;
  wire [2:0] agu_blockRS;
  wire miss_holds_agu;
  reg miss_holds_agu_reg;
  reg miss_holds_agu_reg2;
  
  
  wire [2:0][2:0] nDataAlt;
  reg [2:0][2:0] nDataAlt_reg;
  reg [2:0][2:0] nDataAlt_reg2;
  reg [2:0][2:0] nDataAlt_reg3;
  reg [2:0][2:0] nDataAlt_reg4;
  reg [2:0][2:0] nDataAlt_reg5;
  reg [2:0] gxFADD_hi;
  reg [2:0] gxFADD_en;
  reg [2:0] gxFADD_en_reg;
  reg [2:0] gxFADD_en_reg2;
  reg [2:0] gxFADD_dbl;
  reg [2:0] gxFADD_ext;
  reg [2:0] gxFADD_sn;
  reg [2:0] gxFADD_sin;
  reg [2:0] gxFADD_ord;
  reg [2:0] gxFADD_pkdS;
  reg [2:0] gxFADD_pkdD;
/*  wire fxAlt1;
  wire fxAlt2;
  reg fxAlt1_reg;
  reg fxAlt1_reg2;
  reg [2:0] fxAlt1_reg3;
  reg fxAlt2_reg;
  reg fxAlt2_reg2;
  reg fxAlt2_reg3;*/
  reg [2:0] fxFADD_dbl;
  reg [2:0] fxFADD_ext;
  reg [2:0] fxFADD_sin;
  reg [2:0] fxFADD_dblext;
  reg [5:0] fxFADD_sub;
  reg [2:0] fxFADD_rsub;
  reg [5:0] fxFADD_copyA;
  reg [3:0] fxFADD_copySA[5:0];
  reg [1:0] fxFADD_com[2:0];
  reg [2:0] fxFADD_pswp;
  reg [2:0] fxFADD_dupl;
  reg [2:0] fxFADD_pcmp;
  reg [2:0] fxFADD_lo;
  reg [2:0][3:0] fxFADD_loSel;
  reg [2:0] fxFCADD_dbl;
  reg [2:0] fxFCADD_ext;
  reg [2:0] fxFCADD_sn;
  reg [2:0] fxFCADD_dblext;
  reg [5:0] fxFCADD_copyA;
  reg [3:0] fxFCADD_copyASN[5:0];
  reg [1:0] fxFCADD_com[2:0];
  reg [2:0] fxFCADD_pswp;
  reg [2:0] fxFCADD_dupl;
  reg [2:0] fxFCADD_rndD;
  reg [2:0] fxFCADD_rndS;
  reg [2:0] fxFADD_dbl_nreg;
  reg [2:0] fxFADD_ext_nreg;
  reg [2:0] fxFADD_dblext_nreg;
  reg [5:0] fxFADD_sub_nreg;
  reg [2:0] fxFADD_rsub_nreg;
  reg [5:0] fxFADD_copyA_nreg;
  reg [1:0] fxFADD_com_nreg[2:0];
  reg [2:0] fxFADD_pswp_nreg;
  reg [2:0] fxFCADD_dbl_nreg;
  reg [2:0] fxFCADD_ext_nreg;
  reg [2:0] fxFCADD_dblext_nreg;
  reg [5:0] fxFCADD_copyA_nreg;
  reg [1:0] fxFCADD_com_nreg[2:0];
  reg [2:0] fxFCADD_pswp_nreg;
  wire [5:0][10:0] fxFCADD_raise;
  reg [10:0] fxFCADD_raise_reg[5:0];

  wire [2:0][3:0] fxFRT_alten;
  reg [2:0][3:0] fxFRT_alten_reg;
  reg [2:0][3:0] fxFRT_alten_reg2;
  reg [2:0][3:0] fxFRT_alten_reg3;
  reg [3:0] fxFRT_alten_reg4[2:2];
  reg [3:0] fxFRT_alten_reg5[2:2];
  reg [3:0] fxFRT_alten_reg6[2:2];
  wire [3:0] fxFRT_pause;
  wire [3:0] fxFRT_can;
  wire [3:0] fxFRT_don;
  reg [3:0] fxFRT_can_reg;
  reg [3:0] fxFRT_don_reg;
  reg [3:0] fxFRT_don_reg2;
  reg [3:0] fxFRT_don_reg3;
  reg [3:0] fxFRT_don_reg4;
  reg [4:0] fxFRT_steps;
  reg [2:0] fxFRT_type;
  reg [4:0] fxFRT_steps_reg;
  reg [2:0] fxFRT_type_reg;
  reg fxFRT_isRoot;
  reg fxFRT_isRoot_reg;
//  reg [1:0] fxFRT_don_reg;
  reg fxFRT_dblL_reg;
  reg fxFRT_dblH_reg;
  reg fxFRT_ext_reg;
  reg fxFRT_sngl_reg;
  reg fxFRT_dblL;
  reg fxFRT_dblH;
  reg fxFRT_ext;
  reg fxFRT_sngl;
  reg fxFRT_dblL_s;
  reg fxFRT_dblH_s;
  reg fxFRT_ext_s;
  reg fxFRT_sngl_s;
  reg fxFRT_dblL_ns;
  reg fxFRT_dblH_ns;
  reg fxFRT_ext_ns;
  reg fxFRT_sngl_ns;
  wire [63:-1] fxFRT_normA0;
  wire [15:0] fxFRT_expA;
  wire [63:-1] fxFRT_normB0;
  wire [15:0] fxFRT_expB;
  wire fxFRT_sgnA;
  wire fxFRT_sgnB;
  wire [3:0][8:0] rtReg;
  wire [3:0][9:0] rtII;
  wire [8:0] frtReg;
  wire [9:0] frtII;
  reg [8:0] frtReg_reg;
  reg [9:0] frtII_reg;
  wire [OPERATION_WIDTH-1:0] frtOp;
  reg [OPERATION_WIDTH-1:0] frtOp_reg;
  wire [3:0][OPERATION_WIDTH-1:0] rtOp;
  wire [2*SIMD_WIDTH-1:0] rtDataA;
  wire [2*SIMD_WIDTH-1:0] rtDataB;
  reg [2*SIMD_WIDTH-1:0] rtDataA_reg;
  reg [2*SIMD_WIDTH-1:0] rtDataB_reg;
  wire [3:0][2*SIMD_WIDTH-1:0] rtRes;
  wire fxFRT_do;
  reg fxFRT_en;
  wire [8:0][DATA_WIDTH-1:0] fxDataA;
  wire [8:0][DATA_WIDTH-1:0] fxDataB;
  wire [5:0][SIMD_WIDTH-1:0] fxDataAVH;
  wire [5:0][SIMD_WIDTH-1:0] fxDataBVH;
  wire [5:0][SIMD_WIDTH-1:0] fxDataAVL;
  wire [5:0][SIMD_WIDTH-1:0] fxDataBVL;
  wire [5:0][SIMD_WIDTH-1:0] fxDataAFH;
  reg  [SIMD_WIDTH-1:0] fxDataAFH_reg[5:0];
  reg  [SIMD_WIDTH-1:0] fxDataAXH_reg[5:0];
  reg  [SIMD_WIDTH-1:0] fxDataAFH_REG[5:0];
  wire [5:0][SIMD_WIDTH-1:0] fxDataBFH;
  wire [5:0][16+SIMD_WIDTH-1:0] fxDataAFL;
  reg  [16+SIMD_WIDTH-1:0] fxDataAFL_reg[5:0];
  reg  [16+SIMD_WIDTH-1:0] fxDataAXL_reg[5:0];
  reg  [16+SIMD_WIDTH-1:0] fxDataAFL_REG[5:0];
  wire [5:0][16+SIMD_WIDTH-1:0] fxDataBFL;
  wire [5:0][SIMD_WIDTH-1:0] gxDataBFH;
  reg  [SIMD_WIDTH-1:0] gxDataBFH_reg[5:0];
  reg  [SIMD_WIDTH-1:0] gxDataBXH_reg[5:0];
  wire [5:0][16+SIMD_WIDTH-1:0] gxDataBFL;
  reg  [16+SIMD_WIDTH-1:0] gxDataBFL_reg[5:0];
  reg  [16+SIMD_WIDTH-1:0] gxDataBXL_reg[5:0];
  wire [8:0][5:0] fxDataS;
  
  wire [2:0][32:0] fxDataC;
  wire [2:0][REG_WIDTH-1:0] fxReg;
  wire [2:0][OPERATION_WIDTH-1:0] fxOp;
  wire [2:0][9:0] fxII;
  wire [2:0] fxEn;
  wire [2:0][8:0] fxLSQ;
  wire [2:0][7:0] fxWQ;
  wire [2:0] fxThr;
  wire [2:0] fxLSflag;
  
  wire [2:0][3:0] fxShiftSize;

  reg [REG_WIDTH-1:0] outReg_reg[8:0];
  reg [REG_WIDTH-1:0] outReg_reg2[8:0];
  reg [REG_WIDTH-1:0] outReg_reg3[8:0];
  reg [OPERATION_WIDTH-1:0] outOp_reg[8:0];
  reg [OPERATION_WIDTH-1:0] outOp_reg2[8:0];
  reg [OPERATION_WIDTH-1:0] outOp_reg3[8:0];
  reg [OPERATION_WIDTH-1:0] outOp_reg4[8:0];
  reg [OPERATION_WIDTH-1:0] outOp_reg5[8:0];
  reg [OPERATION_WIDTH-1:0] outOp_reg6[8:0];
  reg [OPERATION_WIDTH-1:0] outOp_reg7[8:0];
  reg [OPERATION_WIDTH-1:0] outOp_reg8[8:0];
  reg [9:0] outII_reg[8:0];
  reg [9:0] outII_reg2[8:0];
  reg [9:0] outII_reg3[8:0];
  reg [9:0] outII_reg4[8:0];
  reg [9:0] outII_reg5[8:0];
  reg [9:0] outII_reg6[8:0];
  reg [9:0] outII_reg7[8:0];
  reg [9:0] outII_reg8[8:0];
  reg [3:0] outEn_reg[8:0];
  reg [3:0] outEn_reg2[8:0];
  reg [3:0] outEn_reg3[8:0];
  reg [3:0] outEn_reg4[8:0];
  reg [3:0] outEn_reg5[8:0];
  reg [3:0] outEn_reg6[8:0];
  reg [3:0] outEn_reg7[8:0];
  reg [3:0] outEn_reg8[8:0];
  reg [8:0] outThr_reg;
  
  wire thread_both=1'b0;
  reg thread_reg;
  reg thread_reg2;
  reg thread_reg3;
  reg bundle_in_reg;
  reg bundle_in_reg2;
  
  wire [5:0] II_upper;
  
  reg bus_holds_agu,bus_holds_agu_reg,bus_holds_agu_reg2;
  reg bus_holds_agu_reg3,bus_holds_agu_reg4,bus_holds_agu_reg5;
  
  reg [15:0] proc0;
  reg [15:0] proc1;

  wire [3:0][PADDR_WIDTH-9:0] dci_rdAddrE;
  wire [3:0][PADDR_WIDTH-9:0] dci_rdAddrO;
  wire [3:0][63:0] dci_rdAddr;
  wire [3:0][31:0] dci_rdBanks;
  wire [3:0][31:0] dci_rdRsBanks;
  wire [3:0] dci_rdEn; 
  wire [3:0] dci_rsEn; 
  wire [3:0] dci_odd;
  wire [3:0] dci_split;
  wire [3:0][1:0] dci_type;
  wire [3:0][127:0] dci_rdataA;
  wire [3:0][4:0] dci_rdBeginA;
  wire [3:0][1:0] dci_low;
  wire [3:0][4:0] dci_size;
  wire [3:0][1:0] dci_rdHitCl;
//  wire [3:0] dc_store;
  wire [3:0] dci_confl;
  wire [2:0] dci_tlb_miss;
  wire [3:0] dci_st;
  wire [31:0] dci_bankNone;
  wire [3:0][REG_WIDTH-1:0] dci_rdReg;
  wire [3:0][8:0] dci_LSQ;
  wire [3:0][9:0] dci_II;
  wire [3:0][7:0] dci_WQ;
  wire [3:0] dci_thr;
  wire [3:0] dci_lsflags;
//  wire [3:0] dc_pconfl;
  wire dci_lsfwd3;
  wire [3:0] dci_bread3;
  wire [127:0] dci_data3;
  
  wire [3:0][PADDR_WIDTH-9:0] dc_rdAddrE;
  wire [3:0][PADDR_WIDTH-9:0] dc_rdAddrO;
  wire [3:0][63:0] dc_rdAddr;
  wire [3:0][31:0] dc_rdBanks;
  wire [3:0][31:0] dc_rdRsBanks;
  wire [3:0][1:0] dc_type;
  wire [3:0] dc_rdEn; 
  wire [3:0] dc_rsEn; 
  wire [3:0] dc_odd;
  wire [3:0] dc_split;
  wire [3:0][127+8:0] dc_rdataA;
  wire [3:0][4:0] dc_rdBeginA;
  wire [3:0][1:0] dc_low;
  wire [3:0][4:0] dc_size;
  wire [3:0][1:0] dc_rdHitCl;
//  wire [3:0] dc_store;
  wire [3:0] dc_confl;
  wire [2:0] dc_tlb_miss;
  wire [3:0] dc_st;
  wire [31:0] dc_bankNone;
  wire [3:0][REG_WIDTH-1:0] dc_rdReg;
  wire [3:0][8:0] dc_LSQ;
  wire [3:0][9:0] dc_II;
  wire [3:0][7:0] dc_WQ;
  wire [3:0] dc_thr;
  wire [3:0] dc_lsflags;
//  wire [3:0] dc_pconfl;
  wire dc_lsfwd3;
  wire [3:0] dc_bread3;
  wire [127:0] dc_data3;
  wire dc_ioEn3;
  wire dc_ioEn3_ack;

  reg [PADDR_WIDTH-9:0] dc_rdAddrE_reg[3:0];
  reg [PADDR_WIDTH-9:0] dc_rdAddrO_reg[3:0];
  reg [PADDR_WIDTH-9:0] dc_rdAddrE_chk[3:0];
  reg [PADDR_WIDTH-9:0] dc_rdAddrO_chk[3:0];
  reg [31:0] dc_rdBanks_reg[3:0];
  reg [31:0] dc_rdRsBanks_reg[3:0];
  reg [3:0] dc_odd_reg;
  reg [3:0] dc_split_reg;
  reg [127:0] dc_rdataA_reg[3:0];
  reg [4:0] dc_rdBeginA_reg[3:0];
  reg [1:0] dc_low_reg[3:0];
  reg [4:0] dc_size_reg[3:0];
  reg [4:0] dc_size_reg2[3:0];
  reg [4:0] dc_size_reg3[3:0];
//  reg [3:0] dc_store_reg;
  reg [3:0] dc_confl_reg;
  reg [3:0] dc_st_reg;
  reg [3:0][1:0] dc_type_reg;
  reg [3:0][1:0] dc_type_reg2;
  reg [3:0][1:0] dc_type_reg3;
 // reg [31:0] dc_bankNone_reg;
  
  reg [2:0] dc_tlb_miss_reg;  
  reg [3:0] dc_rdEn_reg; 
  reg [3:0] dc_rdEn_reg2; 
  reg [3:0] dc_rdEn_reg3;
  reg [3:0] dc_rsEn_reg; 
  reg [REG_WIDTH-1:0] dc_rdReg_reg[3:0];
  reg [REG_WIDTH-1:0] dc_rdReg_reg2[3:0];
  reg [REG_WIDTH-1:0] dc_rdReg_reg3[3:0];
  reg [3:0] dc_confl_reg2;
  reg [8:0] dc_LSQ_reg[3:0];
  reg [9:0] dc_II_reg[3:0];
  reg [9:0] dc_II_reg2[3:0];
  reg [9:0] dc_II_reg3[3:0];
  reg [7:0] dc_WQ_reg[3:0];
  reg [3:0] dc_thr_reg;
  reg [3:0] dc_thr_reg2;
  reg [3:0] dc_lsflags_reg;
  reg [3:0] dc_lsflags_reg2;
  reg [3:0] dc_lsflags_reg3;
  reg dc_lsfwd3_reg;
  reg dc_lsfwd3_reg2;
  reg dc_lsfwd3_reg3;
  reg dc_lsfwd3_reg4;
  reg [3:0] dc_bread3_reg;
  reg [3:0] dc_bread3_reg2;
  reg [3:0] dc_bread3_reg3;
  reg [3:0] dc_bread3_reg4;
  reg [127:0] dc_data3_reg;
  reg [127:0] dc_data3_reg2;
  reg [127:0] dc_data3_reg3;
  reg [127:0] dc_data3_reg4;

  wire [1:0][PADDR_WIDTH-9:0] dci_wrAddrE;
  wire [1:0][PADDR_WIDTH-9:0] dci_wrAddrO;
  wire [1:0][31:0] dci_wrBanks;
  wire [1:0] dci_wrEn; 
  wire [1:0] dci_odd_wr;
  wire [1:0] dci_split_wr;
  wire [1:0][5*32-1:0] dci_wdata;
  wire [1:0][4*32-1:0] dci_wdataP;
  wire [1:0][4:0] dci_wrBegin;
  wire [1:0][4:0] dci_size_wr;
  wire [1:0][1:0] dci_wrHitCl;
  wire [1:0][1:0] dci_wrDuplCl;
  wire [1:0][1:0] dci_wspecdata;
  wire [1:0][9:0] dci_II_wr;
  wire [1:0] dci_wrHit;
  wire [1:0][4:0] dci_wrEnd;
  wire [1:0][3:0] dci_wrBGN_BNK;
  wire [1:0][3:0] dci_wrEND_BNK;
  wire [1:0][1:0] dci_wr_low;
  wire [1:0][1:0] dci_wrTyp;
  
  wire [1:0][PADDR_WIDTH-9:0] dc_wrAddrE;
  wire [1:0][PADDR_WIDTH-9:0] dc_wrAddrO;
  wire [1:0][31:0] dc_wrBanks;
  wire [1:0] dc_wrEn; 
  reg [1:0] dc_wrEn_reg; 
  reg [1:0] dc_wrEn_reg2; 
  reg [1:0] dc_wrEn_reg3; 
  wire [1:0] dc_odd_wr;
  wire [1:0] dc_split_wr;
  wire [1:0][5*32-1:0] dc_wdata;
  wire [1:0][4*32-1:0] dc_wdataP;
  reg [4*32-1:0] dc_wdataP_reg[1:0];
  wire [1:0][4:0] dc_wrBegin;
  wire [1:0][4:0] dc_size_wr;
  wire [1:0][1:0] dc_wrHitCl;
  wire [1:0][1:0] dc_wrDuplCl;
  wire [1:0][1:0] dc_wspecdata;
  wire [1:0][9:0] dc_II_wr;
  reg [9:0] dc_II_wr_reg[1:0];
  reg [9:0] dc_II_wr_reg2[1:0];
  reg [9:0] dc_II_wr_reg3[1:0];
  wire [1:0] dc_wrHit;
  wire [1:0][4:0] dc_wrEnd;
  wire [1:0][3:0] dc_wrBGN_BNK;
  wire [1:0][3:0] dc_wrEND_BNK;
  wire [1:0][1:0] dc_wr_low;
  wire [1:0][1:0] dc_wrTyp;

  reg [PADDR_WIDTH-9:0] dc_wrAddrE_reg[1:0];
  reg [PADDR_WIDTH-9:0] dc_wrAddrO_reg[1:0];
  reg [31:0] dc_wrBanks_reg[1:0];
  reg [1:0] dc_odd_wr_reg;
  reg [1:0] dc_split_wr_reg;
  reg [4:0] dc_wrBegin_reg[1:0];
  reg [4:0] dc_wrEnd_reg[1:0];
  reg [3:0] dc_wrBGN_BNK_reg[1:0];
  reg [3:0] dc_wrEND_BNK_reg[1:0];
  reg [5*32-1:0] dc_wdata_reg[1:0];

  reg [PADDR_WIDTH-9:0] dc_wrAddrE_reg2[1:0];
  reg [PADDR_WIDTH-9:0] dc_wrAddrO_reg2[1:0];
  reg [31:0] dc_wrBanks_reg2[1:0];
  reg [1:0] dc_odd_wr_reg2;
  reg [1:0] dc_split_wr_reg2;
  reg [4:0] dc_wrBegin_reg2[1:0];
  reg [4:0] dc_wrEnd_reg2[1:0];
  reg [3:0] dc_wrBGN_BNK_reg2[1:0];
  reg [3:0] dc_wrEND_BNK_reg2[1:0];
  reg [5*32-1:0] dc_wdata_reg2[1:0];

  reg [PADDR_WIDTH-9:0] dc_wrAddrE_reg3[1:0];
  reg [PADDR_WIDTH-9:0] dc_wrAddrO_reg3[1:0];
  reg [31:0] dc_wrBanks_reg3[1:0];
  reg [1:0] dc_odd_wr_reg3;
  reg [1:0] dc_split_wr_reg3;
  reg [4:0] dc_wrBegin_reg3[1:0];
  reg [4:0] dc_wrEnd_reg3[1:0];
  reg [3:0] dc_wrBGN_BNK_reg3[1:0];
  reg [3:0] dc_wrEND_BNK_reg3[1:0];
  reg [5*32-1:0] dc_wdata_reg3[1:0];

  wire [8:0] retfl_rF;
  wire [5:0] retfl_data;
  wire retfl_enG;

  wire [1:0][63:0] Wqj_wrAddr;
  wire [1:0][31:0] Wqj_wrBanks;
  wire [1:0] Wqj_wrEn; 
  wire [1:0] Wqj_rsEn; 
  wire [1:0] Wqj_odd;
  wire [1:0] Wqj_split;
  wire [1:0][4:0] Wqj_wrBeginA;
  wire [1:0][4:0] Wqj_wrBeginB;
  wire [1:0][1:0] Wqj_low;
  wire [1:0][4:0] Wqj_size;
  wire [1:0][8:0] Wqj_LSQ;
  wire [1:0][9:0] Wqj_II;
  wire [1:0][7:0] Wqj_WQ;
  wire [1:0][1:0] Wqj_type;
  wire [1:0] Wqj_thr;
  wire [1:0] Wqj_lsflags;

  wire [1:0][PADDR_WIDTH-9:0] Wq_wrAddrE;
  wire [1:0][PADDR_WIDTH-9:0] Wq_wrAddrO;
  wire [1:0][63:0] Wq_wrAddr;
  wire [1:0][31:0] Wq_wrBanks;
  wire [1:0] Wq_wrEn; 
  wire [1:0] Wq_rsEn; 
  wire [1:0] Wq_odd;
  wire [1:0] Wq_split;
  wire [1:0][4:0] Wq_wrBeginA;
  wire [1:0][4:0] Wq_wrBeginB;
  wire [1:0][1:0] Wq_low;
  wire [1:0][4:0] Wq_size;
  wire [1:0][8:0] Wq_LSQ;
  wire [1:0][1:0] Wq_type;
  wire [1:0][9:0] Wq_II;
  wire [1:0][7:0] Wq_WQ;
  wire [1:0] Wq_thr;
  wire [1:0] Wq_lsflags;
//  wire [3:0] Wq_store;
//  wire [3:0] Wq_confl;
  wire [1:0] Wq_tlb_miss;
//  wire [3:0] Wq_st;
//  wire [31:0] Wq_bankNone;
//  wire [3:0][REG_WIDTH-1:0] Wq_wrReg;
  wire wt_pause_agu;
  reg wt_pause_agu_reg;
  reg wt_pause_agu_reg2;

  reg [PADDR_WIDTH-9:0] Wq_wrAddrE_reg[1:0];
  reg [PADDR_WIDTH-9:0] Wq_wrAddrO_reg[1:0];
//  wire [1:0][63:0] Wq_wrAddr;
  reg [31:0] Wq_wrBanks_reg[1:0];
 // reg [1:0] Wq_wrEn_reg; 
  reg [1:0] Wq_wrEn_reg; 
  reg [1:0] Wq_odd_reg;
  reg [1:0] Wq_split_reg;
  reg [4:0] Wq_wrBeginA_reg[1:0];
  reg [4:0] Wq_wrBeginB_reg[1:0];
  reg [1:0] Wq_low_reg[1:0];
  reg [4:0] Wq_size_reg[1:0];
  reg [8:0] Wq_LSQ_reg[1:0];
  reg [1:0] Wq_type_reg[1:0];
  reg [9:0] Wq_II_reg[1:0];
  reg [7:0] Wq_WQ_reg[1:0];
  reg [1:0] Wq_thr_reg;
//  wire [3:0] Wq_store;
//  wire [3:0] Wq_confl;
 // reg [1:0] Wq_tlb_miss_reg;
//  wire [3:0] Wq_st;
  reg [31:0] Wq_bankNone_reg;
//  wire [3:0][REG_WIDTH-1:0] Wq_wrReg;
  
  wire [5:0][`lsaddr_width-1:0] lsr_wr_data;
  reg [`lsaddr_width-1:0] lsr_ck_data[3:0];

//  wire [3:0][47:0] wxdata;

  wire [8:0][3:0] instr_ret;
  reg  [3:0] instr_ret_reg[8:0];
    
  wire [5:0] retire0_rT;
  wire [8:0] retire0_rF;
  wire retire0_enG;
  wire retire0_enV;
  wire retire0_enF;
  wire [5:0] retire1_rT;
  wire [8:0] retire1_rF;
  wire retire1_enG;
  wire retire1_enV;
  wire retire1_enF;
  wire [5:0] retire2_rT;
  wire [8:0] retire2_rF;
  wire retire2_enG;
  wire retire2_enV;
  wire retire2_enF;
  wire [5:0] retire3_rT;
  wire [8:0] retire3_rF;
  wire retire3_enG;
  wire retire3_enV;
  wire retire3_enF;
  wire [5:0] retire4_rT;
  wire [8:0] retire4_rF;
  wire retire4_enG;
  wire retire4_enV;
  wire retire4_enF;
  wire [5:0] retire5_rT;
  wire [8:0] retire5_rF;
  wire retire5_enG;
  wire retire5_enV;
  wire retire5_enF;
  wire [5:0] retire6_rT;
  wire [8:0] retire6_rF;
  wire retire6_enG;
  wire retire6_enV;
  wire retire6_enF;
  wire [5:0] retire7_rT;
  wire [8:0] retire7_rF;
  wire retire7_enG;
  wire retire7_enV;
  wire retire7_enF;
  wire [5:0] retire8_rT;
  wire [8:0] retire8_rF;
  wire retire8_enG;
  wire retire8_enV;
  wire retire8_enF;

  reg [5:0] retire0_rT_reg;
  reg [8:0] retire0_rF_reg;
  reg retire0_enV_reg;
  reg retire0_enF_reg;
  reg [5:0] retire1_rT_reg;
  reg [8:0] retire1_rF_reg;
  reg retire1_enV_reg;
  reg retire1_enF_reg;
  reg [5:0] retire2_rT_reg;
  reg [8:0] retire2_rF_reg;
  reg retire2_enV_reg;
  reg retire2_enF_reg;
  reg [5:0] retire3_rT_reg;
  reg [8:0] retire3_rF_reg;
  reg retire3_enV_reg;
  reg retire3_enF_reg;
  reg [5:0] retire4_rT_reg;
  reg [8:0] retire4_rF_reg;
  reg retire4_enV_reg;
  reg retire4_enF_reg;
  reg [5:0] retire5_rT_reg;
  reg [8:0] retire5_rF_reg;
  reg retire5_enV_reg;
  reg retire5_enF_reg;
  reg [5:0] retire6_rT_reg;
  reg [8:0] retire6_rF_reg;
  reg retire6_enV_reg;
  reg retire6_enF_reg;
  reg [5:0] retire7_rT_reg;
  reg [8:0] retire7_rF_reg;
  reg retire7_enV_reg;
  reg retire7_enF_reg;
  reg [5:0] retire8_rT_reg;
  reg [8:0] retire8_rF_reg;
  reg retire8_enV_reg;
  reg retire8_enF_reg;

  reg [5:0] retire0_rT_reg2;
  reg [8:0] retire0_rF_reg2;
  reg retire0_enF_reg2;
  reg [5:0] retire1_rT_reg2;
  reg [8:0] retire1_rF_reg2;
  reg retire1_enF_reg2;
  reg [5:0] retire2_rT_reg2;
  reg [8:0] retire2_rF_reg2;
  reg retire2_enF_reg2;
  reg [5:0] retire3_rT_reg2;
  reg [8:0] retire3_rF_reg2;
  reg retire3_enF_reg2;
  reg [5:0] retire4_rT_reg2;
  reg [8:0] retire4_rF_reg2;
  reg retire4_enF_reg2;
  reg [5:0] retire5_rT_reg2;
  reg [8:0] retire5_rF_reg2;
  reg retire5_enF_reg2;
  reg [5:0] retire6_rT_reg2;
  reg [8:0] retire6_rF_reg2;
  reg retire6_enF_reg2;
  reg [5:0] retire7_rT_reg2;
  reg [8:0] retire7_rF_reg2;
  reg retire7_enF_reg2;
  reg [5:0] retire8_rT_reg2;
  reg [8:0] retire8_rF_reg2;
  reg retire8_enF_reg2;
  
  wire [5:0][`lsqxcept_width-1:0] ret_xdata;
  wire [5:0] ret_xenab;
  reg  [`lsqxcept_width-1:0] ret_xdata_reg[5:0];
  reg  [5:0] ret_xenab_reg;
  reg  [`except_width-1:0] ret_xdata2[5:0];
  wire [5:0] ret_xldconfl;
  wire [5:0] ret_xwrconfl;

  reg agu_flip;
   
  wire [63:0] rec_addr;
  wire [4:0] rec_size;
  wire rec_st;
  wire rec_split;
  wire rec_en;
  wire [4:0] rec_beginA;
  wire [4:0] rec_beginB;
  wire rec_stall;
  wire rec_tlb_miss;
  wire [REG_WIDTH-1:0] rec_register;
  wire [9:0] rec_II;
  wire [7:0] rec_WQ;
  wire [8:0] rec_LSQ;
  wire rec_thread;
  wire rec_lsflag;
  reg [REG_WIDTH-1:0] rec_register_reg;
  reg [63:0] rec_addr_reg;
  reg rec_tlb_miss_reg;
  wire [35:0] rec_addrE;
  wire [35:0] rec_addrO;
  wire rec_lsfwd;
  wire rec_odd;
  wire [1:0] rec_addr_low; 
  wire [3:0] rec_brdbnk;
  wire [127:0] rec_data;
  wire [1:0] rec_type; //

  wire miss_next;
  wire miss_en;
  wire miss_st;
  wire miss_odd;
  wire miss_split;
  wire [1:0] miss_clHit;
  wire [1:0] miss_clDo;
  wire [1:0] miss_clDupl;
  wire miss_unlock;
  wire [PADDR_WIDTH-9:0] miss_addrE;
  wire [PADDR_WIDTH-9:0] miss_addrO;
  wire [4:0] miss_sz;
  wire miss_io;
  wire [4:0] miss_bank0;
  wire [1:0] miss_low;
  
  reg miss_doneEven,miss_doneOdd;
  reg miss_en_reg;
//  reg miss_en_reg2;
  reg miss_st_reg;
  reg miss_unlock_reg;
  
  wire [PADDR_WIDTH-8:0] mcam_addr;
  reg [PADDR_WIDTH-8:0] mcam_addr_reg;
  wire [3:0] mcam_req;
  wire mcam_hasfree;
  wire mcam_dupl;
  wire mcam_locked;
  wire mcam_replay;
  wire mcam_do_req;
  wire mcam_st;
  wire mcam_cldupl;
  wire [4:0] mcam_sz;
  wire [4:0] mcam_bank0;
  wire [1:0] mcam_low;
  wire mcam_io;
  reg mcam_st_reg;
  reg mcam_cldupl_reg;
  reg [4:0] mcam_sz_reg;
  reg [4:0] mcam_bank0_reg;
  reg [1:0] mcam_low_reg;
  reg mcam_io_reg;
  
  
  wire [63-13:0] tlb_addr;
  wire tlb_wen;
  wire tlb_2M;
  wire [`dtlbData_width-1:0] tlb_data0;
  wire [`dtlbData_width-1:0] tlb_data1;
  wire [`dtlbData_width-1:0] tlb_data2;
  
  wire insert_isCode;
  wire insert_isData;
  reg insert_isData_reg;
  reg insert_isData_reg2;
  reg insert_isData_reg3;
  reg insert_isData_reg4;
  reg insert_isData_reg5;
  reg insert_isData_reg6;
  reg insert_isData_reg7;
  reg insert_isData_reg8;

  reg insBus_exclusive_reg;
  reg insBus_exclusive_reg2;
  reg insBus_exclusive_reg3;

  reg insBus_dirty_reg;
  reg insBus_dirty_reg2;
  reg insBus_dirty_reg3;
  
  reg [REQ_WIDTH-1:0] insBus_req_reg;
  
  wire [36:0] insert_addr;
  reg [36:0] insert_addr_reg;
  reg [36:0] insert_addr_reg2;
  reg [36:0] insert_addr_reg3;

  reg [BUS_WIDTH-1:0] insBus_data_reg;
  reg [BUS_WIDTH-1:0] insBus_data_reg2;
 // wire [8*BANK_WIDTH-1:0] insBus_data_ECC;

  wire [5:0] LSQ_upper;
  wire [2:0] LSQ_lsqA;
  wire [2:0] LSQ_lsqB;
  wire [3:0] LSQ_indA;
  wire [3:0] LSQ_indB;
  wire [7:0] LSQ_wqA;
  wire [7:0] LSQ_wqB;
  wire [2:0] Wswp;
  wire [OPERATION_WIDTH-1:0] WopA;
  wire [OPERATION_WIDTH-1:0] WopB;
  reg [2:0] LSQ_lsqA_reg;
  reg [2:0] LSQ_lsqB_reg;
  reg [3:0] LSQ_indA_reg;
  reg [3:0] LSQ_indB_reg;
  reg [7:0] LSQ_wqA_reg;
  reg [7:0] LSQ_wqB_reg;
  reg [2:0] Wswp_reg;
  reg [OPERATION_WIDTH-1:0] WopA_reg;
  reg [OPERATION_WIDTH-1:0] WopB_reg;
  wire LSQ_rdy_A;
  wire [`lsaddr_width-1:0] LSQ_dataA0;
  wire [`lsaddr_width-1:0] LSQ_dataA1;
  wire [`lsaddr_width-1:0] LSQ_dataA2;
  wire [`lsaddr_width-1:0] LSQ_dataA3;
  wire [`lsaddr_width-1:0] LSQ_dataA4;
  wire [`lsaddr_width-1:0] LSQ_dataA5;
  wire [5:0] LSQ_enA;
  
  wire [`lsqshare_width-1:0] LSQ_shr_data;
  wire [`lsqshare_width-1:0] LSQ_shr_dataA;

  wire [5:0] LDQ_ldconfl;
  wire retB_en,retB_clkEn;
  wire [5:0] ldq_new_mask;
  reg  [5:0] ldq_new_mask_reg;

  wire STQ_confl_finish=1'b0;
  wire [5:0] STQ_confl;
  wire [1:0][3*32-1:0] STQ_confls;

  wire [1:0][`lsaddr_width-1:0] wreq_data;
  reg  [`lsaddr_width-1:0] wreq_data_reg[1:0];
 // wire [1:0][47:0] wreq_xdata;
 // reg  [47:0] wreq_xdata_reg[1:0];
  wire [1:0] wreq_has;
  reg  [1:0] wreq_en_reg;
  wire [1:0] wreq_en;
  wire [1:0][4:0] wreq_dcEnd;
  wire [1:0][3:0] wreq_bben;
  wire [1:0][3:0] wreq_endben;
  wire wreq_stall,wreq_hold;
 // reg wreq_stall_reg;

  wire [2:0][`lsaddr_width-1:0] PSTQ_data;
  wire [5:0] PSTQ_data_shr;
  wire PSTQ_has_store=PSTQ_data_shr!=6'b111111;
  wire [2:0] PSTQ_en;

  wire [3:0] PSTQ_match;
  wire bDoStall_rqSpit;
  
  wire [2:0][7:0] WQR;
  wire [2:0][7:0] WQS;
  reg [7:0] WQS_reg[2:0];
  reg [7:0] WQR_reg[2:0];
  
  wire [1:0] sdata_rdy;
  
  wire aStall_STQ;
  wire aDoStall_STQ;
  wire aStall_LSQ;
  
  wire lStall_lsfw;
  wire lDoStall_lsfw;
  wire lStall_STQ;
  wire lDoStall_STQ;
  wire lStall;

  wire [`lsaddr_width-1:0] stqd_mOpA;
  wire [`lsaddr_width-1:0] stqd_mOpB;
  wire [`lsfxdata_width-1:0] stqd_xdataA0;
  wire [`lsfxdata_width-1:0] stqd_xdataA1;
  wire [`lsfxdata_width-1:0] stqd_xdataB0;
  wire [`lsfxdata_width-1:0] stqd_xdataB1;
  wire [7:0] stqd_addrA0;
  wire [7:0] stqd_addrA1;
  wire [7:0] stqd_addrB0;
  wire [7:0] stqd_addrB1;
  wire [127:0] stqd_dataA0;
  wire [127:0] stqd_dataB0;
  wire [127:0] stqd_dataA1;
  wire [127:0] stqd_dataB1;
  wire stqd_rdyA0;
  wire stqd_rdyA1;
  wire stqd_rdyB0;
  wire stqd_rdyB1;
  
  wire [5:0] retM_II;
  wire [5:0] retM_II0;
  wire [9:0] retM_ret;
  wire [9:0] retM_fine;
  wire [9:0] retM_ldconfl;
  wire [9:0] retM_excpt;
  wire retM_do_retire;
  wire [`lsqshare_width-1:0] retM_data_shr;
  wire [`lsqshare_width-1:0] retM_data_shr_reg;
  //reg retM_ret_ret;
  wire [9:0] retM_xbreak;
  wire retM_stall;
  wire retM_xbreak_has; 

  
  wire [1:0][63:0] Em_addr;  
  wire [1:0]Em_en;
  wire [50:0] Em_tlb_addr;
  wire Em_tlb_req_en;
  wire Em_tlb_req_ack;

  wire [135:0] fpE_one={2'd`ptype_ext,50'b0,1'b0,15'h4000,2'd`ptype_ext,1'b0,65'h1_0000_0000_0000_0000};
  wire [67:0] fpD_one={2'd`ptype_dbl,1'b0,1'b0,11'h400,53'b0};
  wire [15:0] csrss_no;
  wire csrss_en,csrss_thread;
  wire [63:0] csrss_data;
 
  wire [5:0][15:0] dummyFH;
  wire [63:0] fpcsr;

  reg wrStall_reg;

  integer k,v,t,p,f,qq,k1;
 
  function [1:0] get_dom_C;
    input V;
    input F;
    case({V,F})
        2'b01: get_dom_C=2'b00;
        2'b11: get_dom_C=2'b10;
        2'b10: get_dom_C=2'b01;
        default: get_dom_C=2'b00;
    endcase

  endfunction

  function [3:0] get_byte_mod4;
      input [1:0] addr_low;
      input [4:0] sz;
      begin
          get_byte_mod4=4'b0;
          if (sz!=5'd16 && sz!=5'd17) get_byte_mod4=4'hf;
          else begin
              get_byte_mod4[addr_low]=1'b1;
              if (sz==5'd17) get_byte_mod4=get_byte_mod4|{get_byte_mod4[2:0],get_byte_mod4[3]};
          end
      end
  endfunction

  function [2:0] get_lsi;
      input [5:0] in_lsi;
      case(in_lsi)
      6'b000001: get_lsi=0;
      6'b000010: get_lsi=1;
      6'b000100: get_lsi=2;
      6'b001000: get_lsi=3;
      6'b010000: get_lsi=4;
      6'b100000: get_lsi=5;
      6'h3f: get_lsi=6;
      default: get_lsi=7;
      endcase
  endfunction
  function [1:0] get_ptype; //from ptype
      input [4:0] msz;  
      input [1:0] orig;
      case(msz)
         5'h3,5'h4,5'h6:  get_ptype=`ptype_ext; 
	 5'h5,5'h7: get_ptype=`ptype_dbl; 
	 5'h8,5'hd: get_ptype=`ptype_sngl; 
	 //0 1 2, a b c = 128 bits,a/u 
	 //9=int 64 bit
	 //0xf=fill/spill
	 default: get_ptype=orig;
     endcase
  endfunction

  function [1:0] get_ptype2; //to ptype
      input [4:0] msz;  
      input [1:0] orig;
      case(msz)
         5'h3:  get_ptype2=`ptype_ext; //long double
	 5'h4,5'h5: get_ptype2=`ptype_dbl; //E2d d
	 5'h6,5'h7,5'h8,5'hd: get_ptype2=`ptype_sngl; //e2s d2s s2s spair/s 
	 //0 1 2, a b c = 128 bits,a/u 
	 default: get_ptype2=orig;
     endcase
  endfunction

  function [0:0] is_rndE;
      input [12:0] op;
      is_rndE=(op[7:0]==`fop_rndES || op[7:0]==`fop_rndED) & ~op[11];
  endfunction
  csrss_watch #(`csr_FPU,64'h20000) fpcsr_mod(clk,rst,csrss_no,csrss_data,csrss_en,fpcsr);

  rat ratA_mod(
    .clk(clk),
    .rst(rst),
    .read_clkEn(~doStall),
    .newR0(newR[0]),.newR1(newR[1]),.newR2(newR[2]),.newR3(newR[3]),
    .newR4(newR[4]),.newR5(newR[5]),.newR6(newR[6]),.newR7(newR[7]),.newR8(newR[8]),
    .newU0(newU[0]),.newU1(newU[1]),.newU2(newU[2]),.newU3(newU[3]),
    .newU4(newU[4]),.newU5(newU[5]),.newU6(newU[6]),.newU7(newU[7]),.newU8(newU[8]),
    //from here addr is retirement register
    .read0_addr(rs0i0_rA),.read0_data(regA[0]),.read0_retired(retA[0]),
      .read0_isDep(depA[0]),.read0_fun(funA[0]),
    .read1_addr(rs0i1_rA),.read1_data(regA[1]),.read1_retired(retA[1]),
      .read1_isDep(depA[1]),.read1_fun(funA[1]),
    .read2_addr(rs0i2_rA),.read2_data(regA[2]),.read2_retired(retA[2]),
      .read2_isDep(depA[2]),.read2_fun(funA[2]),
    .read3_addr(rs1i0_rA),.read3_data(regA[3]),.read3_retired(retA[3]),
      .read3_isDep(depA[3]),.read3_fun(funA[3]),
    .read4_addr(rs1i1_rA),.read4_data(regA[4]),.read4_retired(retA[4]),
      .read4_isDep(depA[4]),.read4_fun(funA[4]),
    .read5_addr(rs1i2_rA),.read5_data(regA[5]),.read5_retired(retA[5]),
      .read5_isDep(depA[5]),.read5_fun(funA[5]),
    .read6_addr(rs2i0_rA),.read6_data(regA[6]),.read6_retired(retA[6]),
      .read6_isDep(depA[6]),.read6_fun(funA[6]),
    .read7_addr(rs2i1_rA),.read7_data(regA[7]),.read7_retired(retA[7]),
      .read7_isDep(depA[7]),.read7_fun(funA[7]),
    .read8_addr(rs2i2_rA),.read8_data(regA[8]),.read8_retired(retA[8]),
      .read8_isDep(depA[8]),.read8_fun(funA[8]),
  
    .writeNew0_addr(rs0i0_rT_reg),.writeNew0_wen(rs0i0_alloc_reg),
    .writeNew1_addr(rs0i1_rT_reg),.writeNew1_wen(rs0i1_alloc_reg),
    .writeNew2_addr(rs0i2_rT_reg),.writeNew2_wen(rs0i2_alloc_reg),
    .writeNew3_addr(rs1i0_rT_reg),.writeNew3_wen(rs1i0_alloc_reg),
    .writeNew4_addr(rs1i1_rT_reg),.writeNew4_wen(rs1i1_alloc_reg),
    .writeNew5_addr(rs1i2_rT_reg),.writeNew5_wen(rs1i2_alloc_reg),
    .writeNew6_addr(rs2i0_rT_reg),.writeNew6_wen(rs2i0_alloc_reg),
    .writeNew7_addr(rs2i1_rT_reg),.writeNew7_wen(rs2i1_alloc_reg),
    .writeNew8_addr(rs2i2_rT_reg),.writeNew8_wen(rs2i2_alloc_reg),
  //from here addr is free register
    .writeRet0_addr(retire0_rF_reg),.writeRet0_wen(retire0_enG),
    .writeRet1_addr(retire1_rF_reg),.writeRet1_wen(retire1_enG),
    .writeRet2_addr(retire2_rF_reg),.writeRet2_wen(retire2_enG),
    .writeRet3_addr(retire3_rF_reg),.writeRet3_wen(retire3_enG),
    .writeRet4_addr(retire4_rF_reg),.writeRet4_wen(retire4_enG),
    .writeRet5_addr(retire5_rF_reg),.writeRet5_wen(retire5_enG),
    .writeRet6_addr(retire6_rF_reg),.writeRet6_wen(retire6_enG),
    .writeRet7_addr(retire7_rF_reg),.writeRet7_wen(retire7_enG),
    .writeRet8_addr(retire8_rF_reg),.writeRet8_wen(retire8_enG),
    .retireAll(except),.retireAll_thread(excpt_thread),
    
  
    .rs0i0_index(rs0i0_index_reg),.rs0i1_index(rs0i1_index_reg),.rs0i2_index(rs0i2_index_reg),
    .rs1i0_index(rs1i0_index_reg),.rs1i1_index(rs1i1_index_reg),.rs1i2_index(rs1i2_index_reg),
    .rs2i0_index(rs2i0_index_reg),.rs2i1_index(rs2i1_index_reg),.rs2i2_index(rs2i2_index_reg),
    .read_thread(thread),.ret_thread(1'b0)
    );

  rat ratB_mod(
    .clk(clk),
    .rst(rst),
    .read_clkEn(~doStall),
    .newR0(newR[0]),.newR1(newR[1]),.newR2(newR[2]),.newR3(newR[3]),
    .newR4(newR[4]),.newR5(newR[5]),.newR6(newR[6]),.newR7(newR[7]),.newR8(newR[8]),
    .newU0(newU[0]),.newU1(newU[1]),.newU2(newU[2]),.newU3(newU[3]),
    .newU4(newU[4]),.newU5(newU[5]),.newU6(newU[6]),.newU7(newU[7]),.newU8(newU[8]),
    //from here addr is retirement register
    .read0_addr(rs0i0_rB),.read0_data(regB[0]),.read0_retired(retB[0]),
      .read0_isDep(depB[0]),.read0_fun(funB[0]),
    .read1_addr(rs0i1_rB),.read1_data(regB[1]),.read1_retired(retB[1]),
      .read1_isDep(depB[1]),.read1_fun(funB[1]),
    .read2_addr(rs0i2_rB),.read2_data(regB[2]),.read2_retired(retB[2]),
      .read2_isDep(depB[2]),.read2_fun(funB[2]),
    .read3_addr(rs1i0_rB),.read3_data(regB[3]),.read3_retired(retB[3]),
      .read3_isDep(depB[3]),.read3_fun(funB[3]),
    .read4_addr(rs1i1_rB),.read4_data(regB[4]),.read4_retired(retB[4]),
      .read4_isDep(depB[4]),.read4_fun(funB[4]),
    .read5_addr(rs1i2_rB),.read5_data(regB[5]),.read5_retired(retB[5]),
      .read5_isDep(depB[5]),.read5_fun(funB[5]),
    .read6_addr(rs2i0_rB),.read6_data(regB[6]),.read6_retired(retB[6]),
      .read6_isDep(depB[6]),.read6_fun(funB[6]),
    .read7_addr(rs2i1_rB),.read7_data(regB[7]),.read7_retired(retB[7]),
      .read7_isDep(depB[7]),.read7_fun(funB[7]),
    .read8_addr(rs2i2_rB),.read8_data(regB[8]),.read8_retired(retB[8]),
      .read8_isDep(depB[8]),.read8_fun(funB[8]),
  
    .writeNew0_addr(rs0i0_rT_reg),.writeNew0_wen(rs0i0_alloc_reg),
    .writeNew1_addr(rs0i1_rT_reg),.writeNew1_wen(rs0i1_alloc_reg),
    .writeNew2_addr(rs0i2_rT_reg),.writeNew2_wen(rs0i2_alloc_reg),
    .writeNew3_addr(rs1i0_rT_reg),.writeNew3_wen(rs1i0_alloc_reg),
    .writeNew4_addr(rs1i1_rT_reg),.writeNew4_wen(rs1i1_alloc_reg),
    .writeNew5_addr(rs1i2_rT_reg),.writeNew5_wen(rs1i2_alloc_reg),
    .writeNew6_addr(rs2i0_rT_reg),.writeNew6_wen(rs2i0_alloc_reg),
    .writeNew7_addr(rs2i1_rT_reg),.writeNew7_wen(rs2i1_alloc_reg),
    .writeNew8_addr(rs2i2_rT_reg),.writeNew8_wen(rs2i2_alloc_reg),
  //from here addr is free register
    .writeRet0_addr(retire0_rF_reg),.writeRet0_wen(retire0_enG),
    .writeRet1_addr(retire1_rF_reg),.writeRet1_wen(retire1_enG),
    .writeRet2_addr(retire2_rF_reg),.writeRet2_wen(retire2_enG),
    .writeRet3_addr(retire3_rF_reg),.writeRet3_wen(retire3_enG),
    .writeRet4_addr(retire4_rF_reg),.writeRet4_wen(retire4_enG),
    .writeRet5_addr(retire5_rF_reg),.writeRet5_wen(retire5_enG),
    .writeRet6_addr(retire6_rF_reg),.writeRet6_wen(retire6_enG),
    .writeRet7_addr(retire7_rF_reg),.writeRet7_wen(retire7_enG),
    .writeRet8_addr(retire8_rF_reg),.writeRet8_wen(retire8_enG),
    .retireAll(except),.retireAll_thread(excpt_thread),
  
    .rs0i0_index(rs0i0_index_reg),.rs0i1_index(rs0i1_index_reg),.rs0i2_index(rs0i2_index_reg),
    .rs1i0_index(rs1i0_index_reg),.rs1i1_index(rs1i1_index_reg),.rs1i2_index(rs1i2_index_reg),
    .rs2i0_index(rs2i0_index_reg),.rs2i1_index(rs2i1_index_reg),.rs2i2_index(rs2i2_index_reg),
    .read_thread(thread),.ret_thread(1'b0)
    );
    
  rat_flags rat_flags_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .newR0(newR[0]),.newR1(newR[1]),.newR2(newR[2]),.newR3(newR[3]),
  .newR4(newR[4]),.newR5(newR[5]),.newR6(newR[6]),.newR7(newR[7]),.newR8(newR[8]),
  .newU0(newU[0]),.newU1(newU[1]),.newU2(newU[2]),.newU3(newU[3]),
  .newU4(newU[4]),.newU5(newU[5]),.newU6(newU[6]),.newU7(newU[7]),.newU8(newU[8]),
  //from here addr is retirement register
  .read1_addr(rs0i1_flagDep),.read1_data(regS[1]),.read1_retired(retS[1]),.read1_fun(funS[1]),
  .read2_addr(rs0i2_flagDep),.read2_data(regS[2]),.read2_retired(retS[2]),.read2_fun(funS[2]),
  .read4_addr(rs1i1_flagDep),.read4_data(regS[4]),.read4_retired(retS[4]),.read4_fun(funS[4]),
  .read5_addr(rs1i2_flagDep),.read5_data(regS[5]),.read5_retired(retS[5]),.read5_fun(funS[5]),
  .read7_addr(rs2i1_flagDep),.read7_data(regS[7]),.read7_retired(retS[7]),.read7_fun(funS[7]),
  .read8_addr(rs2i2_flagDep),.read8_data(regS[8]),.read8_retired(retS[8]),.read8_fun(funS[8]),
  
  .r_data(regFl), .r_retired(retFl), .r_fun(),
  
  .writeNew0_wen(1'b0),
  .writeNew1_wen(rs0i1_lastFl_reg),
  .writeNew2_wen(rs0i2_lastFl_reg),
  .writeNew3_wen(1'b0),
  .writeNew4_wen(rs1i1_lastFl_reg),
  .writeNew5_wen(rs1i2_lastFl_reg),
  .writeNew6_wen(1'b0),
  .writeNew7_wen(rs2i1_lastFl_reg),
  .writeNew8_wen(rs2i2_lastFl_reg),
//from here addr is free register
  .writeRet0_addr(retire0_rF_reg),.writeRet0_wen(retire0_enG),
  .writeRet1_addr(retire1_rF_reg),.writeRet1_wen(retire1_enG),
  .writeRet2_addr(retire2_rF_reg),.writeRet2_wen(retire2_enG),
  .writeRet3_addr(retire3_rF_reg),.writeRet3_wen(retire3_enG),
  .writeRet4_addr(retire4_rF_reg),.writeRet4_wen(retire4_enG),
  .writeRet5_addr(retire5_rF_reg),.writeRet5_wen(retire5_enG),
  .writeRet6_addr(retire6_rF_reg),.writeRet6_wen(retire6_enG),
  .writeRet7_addr(retire7_rF_reg),.writeRet7_wen(retire7_enG),
  .writeRet8_addr(retire8_rF_reg),.writeRet8_wen(retire8_enG),
  .retireAll(except),

  .rs0i0_index(rs0i0_index_reg),.rs0i1_index(rs0i1_index_reg),.rs0i2_index(rs0i2_index_reg),
  .rs1i0_index(rs1i0_index_reg),.rs1i1_index(rs1i1_index_reg),.rs1i2_index(rs1i2_index_reg),
  .rs2i0_index(rs2i0_index_reg),.rs2i1_index(rs2i1_index_reg),.rs2i2_index(rs2i2_index_reg),
  .read_thread(thread),.ret_thread(1'b0)
  );  
  
  ratV ratAV_mod(
    .clk(clk),
    .rst(rst),
    .read_clkEn(~doStall),
    .newR0(newR[0]),.newR1(newR[1]),.newR2(newR[2]),.newR3(newR[3]),
    .newR4(newR[4]),.newR5(newR[5]),.newR6(newR[6]),.newR7(newR[7]),.newR8(newR[8]),
    .newU0(newU[0]),.newU1(newU[1]),.newU2(newU[2]),.newU3(newU[3]),
    .newU4(newU[4]),.newU5(newU[5]),.newU6(newU[6]),.newU7(newU[7]),.newU8(newU[8]),
    .newD0(newD[0]),.newD1(newD[1]),.newD2(newD[2]),.newD3(newD[3]),
    .newD4(newD[4]),.newD5(newD[5]),.newD6(newD[6]),.newD7(newD[7]),.newD8(newD[8]),
  //from here addr is retirement register
    .read0_addr(rs0i0_rA),.read0_data(regAF[0]),.read0_retired(retAF[0]),
      .read0_isDep(depAF[0]),.read0_fun(funAF[0]),.read0_dom(domA[0]),
    .read1_addr(rs0i1_rA),.read1_data(regAF[1]),.read1_retired(retAF[1]),
      .read1_isDep(depAF[1]),.read1_fun(funAF[1]),.read1_dom(domA[1]),
    .read2_addr(rs0i2_rA),.read2_data(regAF[2]),.read2_retired(retAF[2]),
      .read2_isDep(depAF[2]),.read2_fun(funAF[2]),.read2_dom(domA[2]),
    .read3_addr(rs1i0_rA),.read3_data(regAF[3]),.read3_retired(retAF[3]),
      .read3_isDep(depAF[3]),.read3_fun(funAF[3]),.read3_dom(domA[3]),
    .read4_addr(rs1i1_rA),.read4_data(regAF[4]),.read4_retired(retAF[4]),
      .read4_isDep(depAF[4]),.read4_fun(funAF[4]),.read4_dom(domA[4]),
    .read5_addr(rs1i2_rA),.read5_data(regAF[5]),.read5_retired(retAF[5]),
      .read5_isDep(depAF[5]),.read5_fun(funAF[5]),.read5_dom(domA[5]),
    .read6_addr(rs2i0_rA),.read6_data(regAF[6]),.read6_retired(retAF[6]),
      .read6_isDep(depAF[6]),.read6_fun(funAF[6]),.read6_dom(domA[6]),
    .read7_addr(rs2i1_rA),.read7_data(regAF[7]),.read7_retired(retAF[7]),
      .read7_isDep(depAF[7]),.read7_fun(funAF[7]),.read7_dom(domA[7]),
    .read8_addr(rs2i2_rA),.read8_data(regAF[8]),.read8_retired(retAF[8]),
      .read8_isDep(depAF[8]),.read8_fun(funAF[8]),.read8_dom(domA[8]),

    .writeNew0_addr(rs0i0_rT_reg),.writeNew0_wen(rs0i0_allocF_reg),
    .writeNew1_addr(rs0i1_rT_reg),.writeNew1_wen(rs0i1_allocF_reg),
    .writeNew2_addr(rs0i2_rT_reg),.writeNew2_wen(rs0i2_allocF_reg),
    .writeNew3_addr(rs1i0_rT_reg),.writeNew3_wen(rs1i0_allocF_reg),
    .writeNew4_addr(rs1i1_rT_reg),.writeNew4_wen(rs1i1_allocF_reg),
    .writeNew5_addr(rs1i2_rT_reg),.writeNew5_wen(rs1i2_allocF_reg),
    .writeNew6_addr(rs2i0_rT_reg),.writeNew6_wen(rs2i0_allocF_reg),
    .writeNew7_addr(rs2i1_rT_reg),.writeNew7_wen(rs2i1_allocF_reg),
    .writeNew8_addr(rs2i2_rT_reg),.writeNew8_wen(rs2i2_allocF_reg),
//from here addr is free register
    .writeRet0_addr(retire0_rF_reg),.writeRet0_paddr(retire0_rT),
       .writeRet0_dom(get_dom_C(retire0_enV,retire0_enF)),.writeRet0_wen(retire0_enV|retire0_enF),
    .writeRet1_addr(retire1_rF_reg),.writeRet1_paddr(retire1_rT),
       .writeRet1_dom(get_dom_C(retire1_enV,retire1_enF)),.writeRet1_wen(retire1_enV|retire1_enF),
    .writeRet2_addr(retire2_rF_reg),.writeRet2_paddr(retire2_rT),
       .writeRet2_dom(get_dom_C(retire2_enV,retire2_enF)),.writeRet2_wen(retire2_enV|retire2_enF),
    .writeRet3_addr(retire3_rF_reg),.writeRet3_paddr(retire3_rT),
       .writeRet3_dom(get_dom_C(retire3_enV,retire3_enF)),.writeRet3_wen(retire3_enV|retire3_enF),
    .writeRet4_addr(retire4_rF_reg),.writeRet4_paddr(retire4_rT),
       .writeRet4_dom(get_dom_C(retire4_enV,retire4_enF)),.writeRet4_wen(retire4_enV|retire4_enF),
    .writeRet5_addr(retire5_rF_reg),.writeRet5_paddr(retire5_rT),
       .writeRet5_dom(get_dom_C(retire5_enV,retire5_enF)),.writeRet5_wen(retire5_enV|retire5_enF),
    .writeRet6_addr(retire6_rF_reg),.writeRet6_paddr(retire6_rT),
       .writeRet6_dom(get_dom_C(retire6_enV,retire6_enF)),.writeRet6_wen(retire6_enV|retire6_enF),
    .writeRet7_addr(retire7_rF_reg),.writeRet7_paddr(retire7_rT),
       .writeRet7_dom(get_dom_C(retire7_enV,retire7_enF)),.writeRet7_wen(retire7_enV|retire7_enF),
    .writeRet8_addr(retire8_rF_reg),.writeRet8_paddr(retire8_rT),
       .writeRet8_dom(get_dom_C(retire8_enV,retire8_enF)),.writeRet8_wen(retire8_enV|retire8_enF),
    .retireAll(except),.retireAll_thread(excpt_thread),

    .rs0i0_index(rs0i0_index_reg),.rs0i1_index(rs0i1_index_reg),.rs0i2_index(rs0i2_index_reg),
    .rs1i0_index(rs1i0_index_reg),.rs1i1_index(rs1i1_index_reg),.rs1i2_index(rs1i2_index_reg),
    .rs2i0_index(rs2i0_index_reg),.rs2i1_index(rs2i1_index_reg),.rs2i2_index(rs2i2_index_reg),
    .read_thread(thread),.ret_thread(1'b0)
  );

  ratV ratBV_mod(
    .clk(clk),
    .rst(rst),
    .read_clkEn(~doStall),
    .newR0(newR[0]),.newR1(newR[1]),.newR2(newR[2]),.newR3(newR[3]),
    .newR4(newR[4]),.newR5(newR[5]),.newR6(newR[6]),.newR7(newR[7]),.newR8(newR[8]),
    .newU0(newU[0]),.newU1(newU[1]),.newU2(newU[2]),.newU3(newU[3]),
    .newU4(newU[4]),.newU5(newU[5]),.newU6(newU[6]),.newU7(newU[7]),.newU8(newU[8]),
    .newD0(newD[0]),.newD1(newD[1]),.newD2(newD[2]),.newD3(newD[3]),
    .newD4(newD[4]),.newD5(newD[5]),.newD6(newD[6]),.newD7(newD[7]),.newD8(newD[8]),
  //from here addr is retirement register
    .read0_addr(rs0i0_rB),.read0_data(regBF[0]),.read0_retired(retBF[0]),
      .read0_isDep(depBF[0]),.read0_fun(funBF[0]),.read0_dom(domB[0]),
    .read1_addr(rs0i1_rB),.read1_data(regBF[1]),.read1_retired(retBF[1]),
      .read1_isDep(depBF[1]),.read1_fun(funBF[1]),.read1_dom(domB[1]),
    .read2_addr(rs0i2_rB),.read2_data(regBF[2]),.read2_retired(retBF[2]),
      .read2_isDep(depBF[2]),.read2_fun(funBF[2]),.read2_dom(domB[2]),
    .read3_addr(rs1i0_rB),.read3_data(regBF[3]),.read3_retired(retBF[3]),
      .read3_isDep(depBF[3]),.read3_fun(funBF[3]),.read3_dom(domB[3]),
    .read4_addr(rs1i1_rB),.read4_data(regBF[4]),.read4_retired(retBF[4]),
      .read4_isDep(depBF[4]),.read4_fun(funBF[4]),.read4_dom(domB[4]),
    .read5_addr(rs1i2_rB),.read5_data(regBF[5]),.read5_retired(retBF[5]),
      .read5_isDep(depBF[5]),.read5_fun(funBF[5]),.read5_dom(domB[5]),
    .read6_addr(rs2i0_rB),.read6_data(regBF[6]),.read6_retired(retBF[6]),
      .read6_isDep(depBF[6]),.read6_fun(funBF[6]),.read6_dom(domB[6]),
    .read7_addr(rs2i1_rB),.read7_data(regBF[7]),.read7_retired(retBF[7]),
      .read7_isDep(depBF[7]),.read7_fun(funBF[7]),.read7_dom(domB[7]),
    .read8_addr(rs2i2_rB),.read8_data(regBF[8]),.read8_retired(retBF[8]),
      .read8_isDep(depBF[8]),.read8_fun(funBF[8]),.read8_dom(domB[8]),

    .writeNew0_addr(rs0i0_rT_reg),.writeNew0_wen(rs0i0_allocF_reg),
    .writeNew1_addr(rs0i1_rT_reg),.writeNew1_wen(rs0i1_allocF_reg),
    .writeNew2_addr(rs0i2_rT_reg),.writeNew2_wen(rs0i2_allocF_reg),
    .writeNew3_addr(rs1i0_rT_reg),.writeNew3_wen(rs1i0_allocF_reg),
    .writeNew4_addr(rs1i1_rT_reg),.writeNew4_wen(rs1i1_allocF_reg),
    .writeNew5_addr(rs1i2_rT_reg),.writeNew5_wen(rs1i2_allocF_reg),
    .writeNew6_addr(rs2i0_rT_reg),.writeNew6_wen(rs2i0_allocF_reg),
    .writeNew7_addr(rs2i1_rT_reg),.writeNew7_wen(rs2i1_allocF_reg),
    .writeNew8_addr(rs2i2_rT_reg),.writeNew8_wen(rs2i2_allocF_reg),
//from here addr is free register
    .writeRet0_addr(retire0_rF_reg),.writeRet0_paddr(retire0_rT),
       .writeRet0_dom(get_dom_C(retire0_enV,retire0_enF)),.writeRet0_wen(retire0_enV|retire0_enF),
    .writeRet1_addr(retire1_rF_reg),.writeRet1_paddr(retire1_rT),
       .writeRet1_dom(get_dom_C(retire1_enV,retire1_enF)),.writeRet1_wen(retire1_enV|retire1_enF),
    .writeRet2_addr(retire2_rF_reg),.writeRet2_paddr(retire2_rT),
       .writeRet2_dom(get_dom_C(retire2_enV,retire2_enF)),.writeRet2_wen(retire2_enV|retire2_enF),
    .writeRet3_addr(retire3_rF_reg),.writeRet3_paddr(retire3_rT),
       .writeRet3_dom(get_dom_C(retire3_enV,retire3_enF)),.writeRet3_wen(retire3_enV|retire3_enF),
    .writeRet4_addr(retire4_rF_reg),.writeRet4_paddr(retire4_rT),
       .writeRet4_dom(get_dom_C(retire4_enV,retire4_enF)),.writeRet4_wen(retire4_enV|retire4_enF),
    .writeRet5_addr(retire5_rF_reg),.writeRet5_paddr(retire5_rT),
       .writeRet5_dom(get_dom_C(retire5_enV,retire5_enF)),.writeRet5_wen(retire5_enV|retire5_enF),
    .writeRet6_addr(retire6_rF_reg),.writeRet6_paddr(retire6_rT),
       .writeRet6_dom(get_dom_C(retire6_enV,retire6_enF)),.writeRet6_wen(retire6_enV|retire6_enF),
    .writeRet7_addr(retire7_rF_reg),.writeRet7_paddr(retire7_rT),
       .writeRet7_dom(get_dom_C(retire7_enV,retire7_enF)),.writeRet7_wen(retire7_enV|retire7_enF),
    .writeRet8_addr(retire8_rF_reg),.writeRet8_paddr(retire8_rT),
       .writeRet8_dom(get_dom_C(retire8_enV,retire8_enF)),.writeRet8_wen(retire8_enV|retire8_enF),
    .retireAll(except),.retireAll_thread(excpt_thread),

    .rs0i0_index(rs0i0_index_reg),.rs0i1_index(rs0i1_index_reg),.rs0i2_index(rs0i2_index_reg),
    .rs1i0_index(rs1i0_index_reg),.rs1i1_index(rs1i1_index_reg),.rs1i2_index(rs1i2_index_reg),
    .rs2i0_index(rs2i0_index_reg),.rs2i1_index(rs2i1_index_reg),.rs2i2_index(rs2i2_index_reg),
    .read_thread(thread),.ret_thread(1'b0)
  );
  
  reg_alloc allock_mod(
  .clk(clk),
  .rst(rst),
  .stall(stall_alloc),
  .doStall(doStall_alloc),
  .except(except),.ethread(excpt_thread),.eboth(excpt_both),
  .thread(thread_reg),
  .ret_en(retclr),
  .ret_thread(1'b0),
  .ret_rno0(retire0_rF_reg[8:4]),.ret_rno1(retire1_rF_reg[8:4]),.ret_rno2(retire2_rF_reg[8:4]),
  .ret_rno3(retire3_rF_reg[8:4]),.ret_rno4(retire4_rF_reg[8:4]),.ret_rno5(retire5_rF_reg[8:4]),
  .ret_rno6(retire6_rF_reg[8:4]),.ret_rno7(retire7_rF_reg[8:4]),.ret_rno8(retire8_rF_reg[8:4]),
  .newR0(newR[0]),.newR1(newR[1]),.newR2(newR[2]),
  .newR3(newR[3]),.newR4(newR[4]),.newR5(newR[5]),
  .newR6(newR[6]),.newR7(newR[7]),.newR8(newR[8]),
  .rs0i0_en(rs0i0_allocR_reg),.rs1i0_en(rs1i0_allocR_reg),.rs2i0_en(rs2i0_allocR_reg),
  .rs0i1_en(rs0i1_allocR_reg),.rs1i1_en(rs1i1_allocR_reg),.rs2i1_en(rs2i1_allocR_reg),
  .rs0i2_en(rs0i2_allocR_reg),.rs1i2_en(rs1i2_allocR_reg),.rs2i2_en(rs2i2_allocR_reg)
  );
  
  
  get_funit funit_mod(
  .rs0i0_index(rs0i0_index_reg),.rs0i0_port(rs_port[0]),
  .rs0i1_index(rs0i1_index_reg),.rs0i1_port(rs_port[1]),
  .rs0i2_index(rs0i2_index_reg),.rs0i2_port(rs_port[2]),
  .rs1i0_index(rs1i0_index_reg),.rs1i0_port(rs_port[3]),
  .rs1i1_index(rs1i1_index_reg),.rs1i1_port(rs_port[4]),
  .rs1i2_index(rs1i2_index_reg),.rs1i2_port(rs_port[5]),
  .rs2i0_index(rs2i0_index_reg),.rs2i0_port(rs_port[6]),
  .rs2i1_index(rs2i1_index_reg),.rs2i1_port(rs_port[7]),
  .rs2i2_index(rs2i2_index_reg),.rs2i2_port(rs_port[8]),.mul(rs2i2_mul_reg),
  .funit0(newU[0]),.funit1(newU[1]),.funit2(newU[2]),
  .funit3(newU[3]),.funit4(newU[4]),.funit5(newU[5]),
  .funit6(newU[6]),.funit7(newU[7]),.funit8(newU[8])
  );
  
  regfile regA_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_addr(regAW[0]),.read0_data(dataA[0]),
    .read0_oe(~retAW[0]|~rs_rAW_use[0]|useAConstW[0]),.read0_match(gazumpAG[0]),
  .read1_addr(regA[1]),.read1_data(dataA[1]),
    .read1_oe(~retA[1]|~rs_rA_use[1]),.read1_match(gazumpAG[1]),
  .read2_addr(regA[2]),.read2_data(dataA[2]),
    .read2_oe(~retA[2]|~rs_rA_use[2]),.read2_match(gazumpAG[2]),
  .read3_addr(regAW[1]),.read3_data(dataA[3]),
    .read3_oe(~retAW[1]|~rs_rAW_use[1]|useAConstW[1]),.read3_match(gazumpAG[3]),
  .read4_addr(regA[4]),.read4_data(dataA[4]),
    .read4_oe(~retA[4]|~rs_rA_use[4]),.read4_match(gazumpAG[4]),
  .read5_addr(regA[5]),.read5_data(dataA[5]),
    .read5_oe(~retA[5]|~rs_rA_use[5]),.read5_match(gazumpAG[5]),
  .read6_addr(regAW[2]),.read6_data(dataA[6]),
    .read6_oe(~retAW[2]|~rs_rAW_use[2]|useAConstW[2]),.read6_match(gazumpAG[6]),
  .read7_addr(regA[7]),.read7_data(dataA[7]),
    .read7_oe(~retA[7]|~rs_rA_use[7]),.read7_match(gazumpAG[7]),
  .read8_addr(regA[8]),.read8_data(dataA[8]),
    .read8_oe(~retA[8]|~rs_rA_use[8]),.read8_match(gazumpAG[8]),

  .read0_constEn(~rs_rAW_use[0]|useAConstW[0]),
  .read1_constEn(~rs_rA_use[1]),
  .read2_constEn(~rs_rA_use[2]),
  .read3_constEn(~rs_rAW_use[1]|useAConstW[1]),
  .read4_constEn(~rs_rA_use[4]),
  .read5_constEn(~rs_rA_use[5]),
  .read6_constEn(~rs_rAW_use[2]|useAConstW[1]),
  .read7_constEn(~rs_rA_use[7]),
  .read8_constEn(~rs_rA_use[8]),

  .read0_const(rs_const_new[0]&{64{useAConstW[0]}}),
  .read1_const(rs_const[1]&{64{rs_useAConst[1]}}),
  .read2_const(rs_const[2]&{64{rs_useAConst[2]}}),
  .read3_const(rs_const_new[3]&{64{useAConstW[1]}}),
  .read4_const(rs_const[4]&{64{rs_useAConst[4]}}),
  .read5_const(rs_const[5]&{64{rs_useAConst[5]}}),
  .read6_const(rs_const_new[6]&{64{useAConstW[2]}}),
  .read7_const(rs_const[7]&{64{rs_useAConst[7]}}),
  .read8_const(rs_const[8]&{64{rs_useAConst[8]}}),

  .retireRead0_addr(retire0_rF),.retireRead0_data(ret_dataA[0]),
  .retireRead1_addr(retire1_rF),.retireRead1_data(ret_dataA[1]),
  .retireRead2_addr(retire2_rF),.retireRead2_data(ret_dataA[2]),
  .retireRead3_addr(retire3_rF),.retireRead3_data(ret_dataA[3]),
  .retireRead4_addr(retire4_rF),.retireRead4_data(ret_dataA[4]),
  .retireRead5_addr(retire5_rF),.retireRead5_data(ret_dataA[5]),
  .retireRead6_addr(retire6_rF),.retireRead6_data(ret_dataA[6]),
  .retireRead7_addr(retire7_rF),.retireRead7_data(ret_dataA[7]),
  .retireRead8_addr(retire8_rF),.retireRead8_data(ret_dataA[8]),

  .write0_addr_reg(FUreg_reg[0]),.write0_data_reg(FU_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_data_reg(FU_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_data_reg(FU_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_data_reg(FU_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg[4]),.write4_data_reg(FU_reg[4]),.write4_wen_reg(FUwen_reg[4]),
  .write5_addr_reg(FUreg_reg[5]),.write5_data_reg(FU_reg[5]),.write5_wen_reg(FUwen_reg[5]),
  .write6_addr_reg(FUreg_reg[6]),.write6_data_reg(FU_reg[6]),.write6_wen_reg(FUwen_reg[6]),
  .write7_addr_reg(FUreg_reg[7]),.write7_data_reg(FU_reg[7]),.write7_wen_reg(FUwen_reg[7]),
  .write8_addr_reg(FUreg_reg[8]),.write8_data_reg(FU_reg[8]),.write8_wen_reg(FUwen_reg[8]),
  .write9_addr_reg(FUreg_reg[9]),.write9_data_reg(FU_reg[9]),.write9_wen_reg(FUwen_reg[9])
  );

  regfile #(SIMD_WIDTH) regAVH_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_match(),.read1_match(),.read2_match(),
  .read3_match(),.read4_match(),.read5_match(),
  .read6_match(),.read7_match(),.read8_match(),
  .read0_addr(regAWF_reg[0]),.read0_data(dataAVH[0]),
    .read0_oe(~retAWF_reg[0]|~rs_rAW_useF_reg[0]),
  .read1_addr(regAF_reg[1]),.read1_data(dataAVH[1]),
    .read1_oe(~retAF_reg[1]|~rs_rA_useF_reg[1]),
  .read2_addr(regAF_reg[2]),.read2_data(dataAVH[2]),
    .read2_oe(~retAF_reg[2]|~rs_rA_useF_reg[2]),
  .read3_addr(regAWF_reg[1]),.read3_data(dataAVH[3]),
    .read3_oe(~retAWF_reg[1]|~rs_rAW_useF_reg[1]),
  .read4_addr(regAF_reg[4]),.read4_data(dataAVH[4]),
    .read4_oe(~retAF_reg[4]|~rs_rA_useF_reg[4]),
  .read5_addr(regAF_reg[5]),.read5_data(dataAVH[5]),
    .read5_oe(~retAF_reg[5]|~rs_rA_useF_reg[5]),
  .read6_addr(regAWF_reg[2]),.read6_data(dataAVH[6]),
    .read6_oe(~retAWF_reg[2]|~rs_rAW_useF_reg[2]),
  .read7_addr(regAF_reg[7]),.read7_data(dataAVH[7]),
    .read7_oe(~retAF_reg[7]|~rs_rA_useF_reg[7]),
  .read8_addr(regAF_reg[8]),.read8_data(dataAVH[8]),
    .read8_oe(~retAF_reg[8]|~rs_rA_useF_reg[8]),

  .read0_constEn(~rs_rAW_useF_reg[0]),
  .read1_constEn(~rs_rA_useF_reg[1]),
  .read2_constEn(~rs_rA_useF_reg[2]),
  .read3_constEn(~rs_rAW_useF_reg[1]),
  .read4_constEn(~rs_rA_useF_reg[4]),
  .read5_constEn(~rs_rA_useF_reg[5]),
  .read6_constEn(~rs_rAW_useF_reg[2]),
  .read7_constEn(~rs_rA_useF_reg[7]),
  .read8_constEn(~rs_rA_useF_reg[8]),

  .read0_const({SIMD_WIDTH{1'B0}}),
  .read1_const({SIMD_WIDTH{1'B0}}),
  .read2_const({SIMD_WIDTH{1'B0}}),
  .read3_const({SIMD_WIDTH{1'B0}}),
  .read4_const({SIMD_WIDTH{1'B0}}),
  .read5_const({SIMD_WIDTH{1'B0}}),
  .read6_const({SIMD_WIDTH{1'B0}}),
  .read7_const({SIMD_WIDTH{1'B0}}),
  .read8_const({SIMD_WIDTH{1'B0}}),

  .retireRead0_addr(retire0_rF_reg),.retireRead0_data(ret_dataAVH[0]),
  .retireRead1_addr(retire1_rF_reg),.retireRead1_data(ret_dataAVH[1]),
  .retireRead2_addr(retire2_rF_reg),.retireRead2_data(ret_dataAVH[2]),
  .retireRead3_addr(retire3_rF_reg),.retireRead3_data(ret_dataAVH[3]),
  .retireRead4_addr(retire4_rF_reg),.retireRead4_data(ret_dataAVH[4]),
  .retireRead5_addr(retire5_rF_reg),.retireRead5_data(ret_dataAVH[5]),
  .retireRead6_addr(retire6_rF_reg),.retireRead6_data(ret_dataAVH[6]),
  .retireRead7_addr(retire7_rF_reg),.retireRead7_data(ret_dataAVH[7]),
  .retireRead8_addr(retire8_rF_reg),.retireRead8_data(ret_dataAVH[8]),

  .write0_addr_reg(FUreg_reg2[0]),.write0_data_reg(FUVH_reg[0]),.write0_wen_reg(FUwen_reg2[0] & FU0Hit_reg),
  .write1_addr_reg(FUreg_reg2[1]),.write1_data_reg(FUVH_reg[1]),.write1_wen_reg(FUwen_reg2[1] & FU1Hit_reg),
  .write2_addr_reg(FUreg_reg2[2]),.write2_data_reg(FUVH_reg[2]),.write2_wen_reg(FUwen_reg2[2] & FU2Hit_reg),
  .write3_addr_reg(FUreg_reg2[3]),.write3_data_reg(FUVH_reg[3]),.write3_wen_reg(FUwen_reg2[3] & FU3Hit_reg),
  .write4_addr_reg(FUreg_reg2[4]),.write4_data_reg(FUVH_reg[4]),.write4_wen_reg(FUwen_reg2[4]),
  .write5_addr_reg(FUreg_reg2[5]),.write5_data_reg(FUVH_reg[5]),.write5_wen_reg(FUwen_reg2[5]),
  .write6_addr_reg(FUreg_reg2[6]),.write6_data_reg(FUVH_reg[6]),.write6_wen_reg(FUwen_reg2[6]),
  .write7_addr_reg(FUreg_reg3[7]),.write7_data_reg(FUVH_reg[7]),.write7_wen_reg(FUwen_reg3[7]),
  .write8_addr_reg(FUreg_reg3[8]),.write8_data_reg(FUVH_reg[8]),.write8_wen_reg(FUwen_reg3[8]),
  .write9_addr_reg(FUreg_reg3[9]),.write9_data_reg(FUVH_reg[9]),.write9_wen_reg(FUwen_reg3[9])
  );

  regfile #(SIMD_WIDTH) regAVL_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_match(),.read1_match(),.read2_match(),
  .read3_match(),.read4_match(),.read5_match(),
  .read6_match(),.read7_match(),.read8_match(),
  .read0_addr(regAWF_reg[0]),.read0_data(dataAVL[0]),
    .read0_oe(~retAWF_reg[0]|~rs_rAW_useF_reg[0]),
  .read1_addr(regAF_reg[1]),.read1_data(dataAVL[1]),
    .read1_oe(~retAF_reg[1]|~rs_rA_useF_reg[1]),
  .read2_addr(regAF_reg[2]),.read2_data(dataAVL[2]),
    .read2_oe(~retAF_reg[2]|~rs_rA_useF_reg[2]),
  .read3_addr(regAWF_reg[1]),.read3_data(dataAVL[3]),
    .read3_oe(~retAWF_reg[1]|~rs_rAW_useF_reg[1]),
  .read4_addr(regAF_reg[4]),.read4_data(dataAVL[4]),
    .read4_oe(~retAF_reg[4]|~rs_rA_useF_reg[4]),
  .read5_addr(regAF_reg[5]),.read5_data(dataAVL[5]),
    .read5_oe(~retAF_reg[5]|~rs_rA_useF_reg[5]),
  .read6_addr(regAWF_reg[2]),.read6_data(dataAVL[6]),
    .read6_oe(~retAWF_reg[2]|~rs_rAW_useF_reg[2]),
  .read7_addr(regAF_reg[7]),.read7_data(dataAVL[7]),
    .read7_oe(~retAF_reg[7]|~rs_rA_useF_reg[7]),
  .read8_addr(regAF_reg[8]),.read8_data(dataAVL[8]),
    .read8_oe(~retAF_reg[8]|~rs_rA_useF_reg[8]),

  .read0_constEn(~rs_rAW_useF_reg[0]),
  .read1_constEn(~rs_rA_useF_reg[1]),
  .read2_constEn(~rs_rA_useF_reg[2]),
  .read3_constEn(~rs_rAW_useF_reg[1]),
  .read4_constEn(~rs_rA_useF_reg[4]),
  .read5_constEn(~rs_rA_useF_reg[5]),
  .read6_constEn(~rs_rAW_useF_reg[2]),
  .read7_constEn(~rs_rA_useF_reg[7]),
  .read8_constEn(~rs_rA_useF_reg[8]),

  .read0_const({SIMD_WIDTH{1'B0}}),
  .read1_const({SIMD_WIDTH{1'B0}}),
  .read2_const({SIMD_WIDTH{1'B0}}),
  .read3_const({SIMD_WIDTH{1'B0}}),
  .read4_const({SIMD_WIDTH{1'B0}}),
  .read5_const({SIMD_WIDTH{1'B0}}),
  .read6_const({SIMD_WIDTH{1'B0}}),
  .read7_const({SIMD_WIDTH{1'B0}}),
  .read8_const({SIMD_WIDTH{1'B0}}),

  .retireRead0_addr(retire0_rF_reg),.retireRead0_data(ret_dataAVL[0]),
  .retireRead1_addr(retire1_rF_reg),.retireRead1_data(ret_dataAVL[1]),
  .retireRead2_addr(retire2_rF_reg),.retireRead2_data(ret_dataAVL[2]),
  .retireRead3_addr(retire3_rF_reg),.retireRead3_data(ret_dataAVL[3]),
  .retireRead4_addr(retire4_rF_reg),.retireRead4_data(ret_dataAVL[4]),
  .retireRead5_addr(retire5_rF_reg),.retireRead5_data(ret_dataAVL[5]),
  .retireRead6_addr(retire6_rF_reg),.retireRead6_data(ret_dataAVL[6]),
  .retireRead7_addr(retire7_rF_reg),.retireRead7_data(ret_dataAVL[7]),
  .retireRead8_addr(retire8_rF_reg),.retireRead8_data(ret_dataAVL[8]),

  .write0_addr_reg(FUreg_reg2[0]),.write0_data_reg(FUVL_reg[0]),.write0_wen_reg(FUwen_reg2[0] & FU0Hit_reg),
  .write1_addr_reg(FUreg_reg2[1]),.write1_data_reg(FUVL_reg[1]),.write1_wen_reg(FUwen_reg2[1] & FU1Hit_reg),
  .write2_addr_reg(FUreg_reg2[2]),.write2_data_reg(FUVL_reg[2]),.write2_wen_reg(FUwen_reg2[2] & FU2Hit_reg),
  .write3_addr_reg(FUreg_reg2[3]),.write3_data_reg(FUVL_reg[3]),.write3_wen_reg(FUwen_reg2[3] & FU3Hit_reg),
  .write4_addr_reg(FUreg_reg2[4]),.write4_data_reg(FUVL_reg[4]),.write4_wen_reg(FUwen_reg2[4]),
  .write5_addr_reg(FUreg_reg2[5]),.write5_data_reg(FUVL_reg[5]),.write5_wen_reg(FUwen_reg2[5]),
  .write6_addr_reg(FUreg_reg2[6]),.write6_data_reg(FUVL_reg[6]),.write6_wen_reg(FUwen_reg2[6]),
  .write7_addr_reg(FUreg_reg3[7]),.write7_data_reg(FUVL_reg[7]),.write7_wen_reg(FUwen_reg3[7]),
  .write8_addr_reg(FUreg_reg3[8]),.write8_data_reg(FUVL_reg[8]),.write8_wen_reg(FUwen_reg3[8]),
  .write9_addr_reg(FUreg_reg3[9]),.write9_data_reg(FUVL_reg[9]),.write9_wen_reg(FUwen_reg3[9])
  );

  regfile_get_gazump GzSimdA(
  .clk(clk),.rst(rst),
  .read_clkEn(~doStall),
  
  .read0_addr(regAWF[0]),.read0_constEn(~rs_rAW_useF[0]),.read0_oe(~retAWF[0]|~rs_rAW_useF[0]),.read0_match(gazumpAV[0]),
  .read1_addr(regAF[1]),.read1_constEn(~rs_rA_useF[1]),.read1_oe(~retAF[1]|~rs_rA_useF[1]),.read1_match(gazumpAV[1]),
  .read2_addr(regAF[2]),.read2_constEn(~rs_rA_useF[2]),.read2_oe(~retAF[2]|~rs_rA_useF[2]),.read2_match(gazumpAV[2]),
  .read3_addr(regAWF[1]),.read3_constEn(~rs_rAW_useF[1]),.read3_oe(~retAWF[1]|~rs_rAW_useF[1]),.read3_match(gazumpAV[3]),
  .read4_addr(regAF[4]),.read4_constEn(~rs_rA_useF[4]),.read4_oe(~retAF[4]|~rs_rA_useF[4]),.read4_match(gazumpAV[4]),
  .read5_addr(regAF[5]),.read5_constEn(~rs_rA_useF[5]),.read5_oe(~retAF[5]|~rs_rA_useF[5]),.read5_match(gazumpAV[5]),
  .read6_addr(regAWF[2]),.read6_constEn(~rs_rAW_useF[2]),.read6_oe(~retAWF[2]|~rs_rAW_useF[2]),.read6_match(gazumpAV[6]),
  .read7_addr(regAF[7]),.read7_constEn(~rs_rA_useF[7]),.read7_oe(~retAF[7]|~rs_rA_useF[7]),.read7_match(gazumpAV[7]),
  .read8_addr(regAF[8]),.read8_constEn(~rs_rA_useF[8]),.read8_oe(~retAF[8]|~rs_rA_useF[8]),.read8_match(gazumpAV[8]),

  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg[4]),.write4_wen_reg(FUwen_reg[4]),
  .write5_addr_reg(FUreg_reg[5]),.write5_wen_reg(FUwen_reg[5]),
  .write6_addr_reg(FUreg_reg[6]),.write6_wen_reg(FUwen_reg[6]),
  .write7_addr_reg(FUreg_reg2[7]),.write7_wen_reg(FUwen_reg2[7]),
  .write8_addr_reg(FUreg_reg2[8]),.write8_wen_reg(FUwen_reg2[8]),
  .write9_addr_reg(FUreg_reg2[9]),.write9_wen_reg(FUwen_reg2[9])
  );
  
  regfile_get_gazump GzFA(
  .clk(clk),.rst(rst),
  .read_clkEn(~doStall),
  
  .read0_addr(regAWF[0]),.read0_constEn(~rs_rAW_useF[0]),.read0_oe(~retAWF[0]|~rs_rAW_useF[0]),.read0_match(gazumpFA[0]),
  .read1_addr(regAF[1]),.read1_constEn(~rs_rA_useF[1]),.read1_oe(~retAF[1]|~rs_rA_useF[1]),.read1_match(gazumpFA[1]),
  .read2_addr(regAF[2]),.read2_constEn(~rs_rA_useF[2]),.read2_oe(~retAF[2]|~rs_rA_useF[2]),.read2_match(gazumpFA[2]),
  .read3_addr(regAWF[1]),.read3_constEn(~rs_rAW_useF[1]),.read3_oe(~retAWF[1]|~rs_rAW_useF[1]),.read3_match(gazumpFA[3]),
  .read4_addr(regAF[4]),.read4_constEn(~rs_rA_useF[4]),.read4_oe(~retAF[4]|~rs_rA_useF[4]),.read4_match(gazumpFA[4]),
  .read5_addr(regAF[5]),.read5_constEn(~rs_rA_useF[5]),.read5_oe(~retAF[5]|~rs_rA_useF[5]),.read5_match(gazumpFA[5]),
  .read6_addr(regAWF[2]),.read6_constEn(~rs_rAW_useF[2]),.read6_oe(~retAWF[2]|~rs_rAW_useF[2]),.read6_match(gazumpFA[6]),
  .read7_addr(regAF[7]),.read7_constEn(~rs_rA_useF[7]),.read7_oe(~retAF[7]|~rs_rA_useF[7]),.read7_match(gazumpFA[7]),
  .read8_addr(regAF[8]),.read8_constEn(~rs_rA_useF[8]),.read8_oe(~retAF[8]|~rs_rA_useF[8]),.read8_match(gazumpFA[8]),

  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg3[4]),.write4_wen_reg(FUwen_reg3[4]),
  .write5_addr_reg(FUreg_reg3[5]),.write5_wen_reg(FUwen_reg3[5]),
  .write6_addr_reg(FUreg_reg3[6]),.write6_wen_reg(FUwen_reg3[6]),
  .write7_addr_reg(FUreg_reg5[7]),.write7_wen_reg(FUwen_reg5[7]),
  .write8_addr_reg(FUreg_reg5[8]),.write8_wen_reg(FUwen_reg5[8]),
  .write9_addr_reg(FUreg_reg5[9]),.write9_wen_reg(FUwen_reg5[9])
  );
  
  regfile #(SIMD_WIDTH) regAFH_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_match(),.read1_match(),.read2_match(),
  .read3_match(),.read4_match(),.read5_match(),
  .read6_match(),.read7_match(),.read8_match(),
  .read0_addr(regAWF_reg2[0]),.read0_data(dataAFH[0]),
    .read0_oe(~retAWF_reg2[0]|~rs_rAW_useF_reg2[0]),
  .read1_addr(regAF_reg2[1]),.read1_data(dataAFH[1]),
    .read1_oe(~retAF_reg2[1]|~rs_rA_useF_reg2[1]),
  .read2_addr(regAF_reg2[2]),.read2_data(dataAFH[2]),
    .read2_oe(~retAF_reg2[2]|~rs_rA_useF_reg2[2]),
  .read3_addr(regAWF_reg2[1]),.read3_data(dataAFH[3]),
    .read3_oe(~retAWF_reg2[1]|~rs_rAW_useF_reg2[1]),
  .read4_addr(regAF_reg2[4]),.read4_data(dataAFH[4]),
    .read4_oe(~retAF_reg2[4]|~rs_rA_useF_reg2[4]),
  .read5_addr(regAF_reg2[5]),.read5_data(dataAFH[5]),
    .read5_oe(~retAF_reg2[5]|~rs_rA_useF_reg2[5]),
  .read6_addr(regAWF_reg2[2]),.read6_data(dataAFH[6]),
    .read6_oe(~retAWF_reg2[2]|~rs_rAW_useF_reg2[2]),
  .read7_addr(regAF_reg2[7]),.read7_data(dataAFH[7]),
    .read7_oe(~retAF_reg2[7]|~rs_rA_useF_reg2[7]),
  .read8_addr(regAF_reg2[8]),.read8_data(dataAFH[8]),
    .read8_oe(~retAF_reg2[8]|~rs_rA_useF_reg2[8]),

  .read0_constEn(~rs_rAW_useF_reg2[0]),
  .read1_constEn(~rs_rA_useF_reg2[1]),
  .read2_constEn(~rs_rA_useF_reg2[2]),
  .read3_constEn(~rs_rAW_useF_reg2[1]),
  .read4_constEn(~rs_rA_useF_reg2[4]),
  .read5_constEn(~rs_rA_useF_reg2[5]),
  .read6_constEn(~rs_rAW_useF_reg2[2]),
  .read7_constEn(~rs_rA_useF_reg2[7]),
  .read8_constEn(~rs_rA_useF_reg2[8]),

  .read0_const(is_rndE(rs_operation_reg2[0]) ? fpE_one[135:68] : fpD_one),
  .read1_const(is_rndE(rs_operation_reg2[1]) ? fpE_one[135:68] : fpD_one),
  .read2_const(is_rndE(rs_operation_reg2[2]) ? fpE_one[135:68] : fpD_one),
  .read3_const(is_rndE(rs_operation_reg2[3]) ? fpE_one[135:68] : fpD_one),
  .read4_const(is_rndE(rs_operation_reg2[4]) ? fpE_one[135:68] : fpD_one),
  .read5_const(is_rndE(rs_operation_reg2[5]) ? fpE_one[135:68] : fpD_one),
  .read6_const(is_rndE(rs_operation_reg2[6]) ? fpE_one[135:68] : fpD_one),
  .read7_const(is_rndE(rs_operation_reg2[7]) ? fpE_one[135:68] : fpD_one),
  .read8_const(is_rndE(rs_operation_reg2[8]) ? fpE_one[135:68] : fpD_one),

  .retireRead0_addr(retire0_rF_reg2),.retireRead0_data(ret_dataAFH[0]),
  .retireRead1_addr(retire1_rF_reg2),.retireRead1_data(ret_dataAFH[1]),
  .retireRead2_addr(retire2_rF_reg2),.retireRead2_data(ret_dataAFH[2]),
  .retireRead3_addr(retire3_rF_reg2),.retireRead3_data(ret_dataAFH[3]),
  .retireRead4_addr(retire4_rF_reg2),.retireRead4_data(ret_dataAFH[4]),
  .retireRead5_addr(retire5_rF_reg2),.retireRead5_data(ret_dataAFH[5]),
  .retireRead6_addr(retire6_rF_reg2),.retireRead6_data(ret_dataAFH[6]),
  .retireRead7_addr(retire7_rF_reg2),.retireRead7_data(ret_dataAFH[7]),
  .retireRead8_addr(retire8_rF_reg2),.retireRead8_data(ret_dataAFH[8]),

  .write0_addr_reg(FUreg_reg3[0]),.write0_data_reg(FUFH_reg[0]),.write0_wen_reg(FUwen_reg3[0] & FU0Hit_reg2),
  .write1_addr_reg(FUreg_reg3[1]),.write1_data_reg(FUFH_reg[1]),.write1_wen_reg(FUwen_reg3[1] & FU1Hit_reg2),
  .write2_addr_reg(FUreg_reg3[2]),.write2_data_reg(FUFH_reg[2]),.write2_wen_reg(FUwen_reg3[2] & FU2Hit_reg2),
  .write3_addr_reg(FUreg_reg3[3]),.write3_data_reg(FUFH_reg[3]),.write3_wen_reg(FUwen_reg3[3] & FU3Hit_reg2),
  .write4_addr_reg(FUreg_reg5[4]),.write4_data_reg(FUFH_reg[4]),.write4_wen_reg(FUwen_reg5[4]),
  .write5_addr_reg(FUreg_reg5[5]),.write5_data_reg(FUFH_reg[5]),.write5_wen_reg(FUwen_reg5[5]),
  .write6_addr_reg(FUreg_reg5[6]),.write6_data_reg(FUFH_reg[6]),.write6_wen_reg(FUwen_reg5[6]),
  .write7_addr_reg(FUreg_reg7[7]),.write7_data_reg(FUFH_reg[7]),.write7_wen_reg(FUwen_reg7[7]),
  .write8_addr_reg(FUreg_reg7[8]),.write8_data_reg(FUFH_reg[8]),.write8_wen_reg(FUwen_reg7[8]),
  .write9_addr_reg(FUreg_reg7[9]),.write9_data_reg(FUFH_reg[9]),.write9_wen_reg(FUwen_reg7[9])
  );


  regfile #(16+SIMD_WIDTH) regAFL_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_match(),.read1_match(),.read2_match(),
  .read3_match(),.read4_match(),.read5_match(),
  .read6_match(),.read7_match(),.read8_match(),
  .read0_addr(regAWF_reg2[0]),.read0_data(dataAFL[0]),
    .read0_oe(~retAWF_reg2[0]|~rs_rAW_useF_reg2[0]),
  .read1_addr(regAF_reg2[1]),.read1_data(dataAFL[1]),
    .read1_oe(~retAF_reg2[1]|~rs_rA_useF_reg2[1]),
  .read2_addr(regAF_reg2[2]),.read2_data(dataAFL[2]),
    .read2_oe(~retAF_reg2[2]|~rs_rA_useF_reg2[2]),
  .read3_addr(regAWF_reg2[1]),.read3_data(dataAFL[3]),
    .read3_oe(~retAWF_reg2[1]|~rs_rAW_useF_reg2[1]),
  .read4_addr(regAF_reg2[4]),.read4_data(dataAFL[4]),
    .read4_oe(~retAF_reg2[4]|~rs_rA_useF_reg2[4]),
  .read5_addr(regAF_reg2[5]),.read5_data(dataAFL[5]),
    .read5_oe(~retAF_reg2[5]|~rs_rA_useF_reg2[5]),
  .read6_addr(regAWF_reg2[2]),.read6_data(dataAFL[6]),
    .read6_oe(~retAWF_reg2[2]|~rs_rAW_useF_reg2[2]),
  .read7_addr(regAF_reg2[7]),.read7_data(dataAFL[7]),
    .read7_oe(~retAF_reg2[7]|~rs_rA_useF_reg2[7]),
  .read8_addr(regAF_reg2[8]),.read8_data(dataAFL[8]),
    .read8_oe(~retAF_reg2[8]|~rs_rA_useF_reg2[8]),

  .read0_constEn(~rs_rAW_useF_reg2[0]),
  .read1_constEn(~rs_rA_useF_reg2[1]),
  .read2_constEn(~rs_rA_useF_reg2[2]),
  .read3_constEn(~rs_rAW_useF_reg2[1]),
  .read4_constEn(~rs_rA_useF_reg2[4]),
  .read5_constEn(~rs_rA_useF_reg2[5]),
  .read6_constEn(~rs_rAW_useF_reg2[2]),
  .read7_constEn(~rs_rA_useF_reg2[7]),
  .read8_constEn(~rs_rA_useF_reg2[8]),

  .read0_const(is_rndE(rs_operation_reg2[0]) ? fpE_one : {16'b0,fpD_one}),
  .read1_const(is_rndE(rs_operation_reg2[1]) ? fpE_one : {16'b0,fpD_one}),
  .read2_const(is_rndE(rs_operation_reg2[2]) ? fpE_one : {16'b0,fpD_one}),
  .read3_const(is_rndE(rs_operation_reg2[3]) ? fpE_one : {16'b0,fpD_one}),
  .read4_const(is_rndE(rs_operation_reg2[4]) ? fpE_one : {16'b0,fpD_one}),
  .read5_const(is_rndE(rs_operation_reg2[5]) ? fpE_one : {16'b0,fpD_one}),
  .read6_const(is_rndE(rs_operation_reg2[6]) ? fpE_one : {16'b0,fpD_one}),
  .read7_const(is_rndE(rs_operation_reg2[7]) ? fpE_one : {16'b0,fpD_one}),
  .read8_const(is_rndE(rs_operation_reg2[8]) ? fpE_one : {16'b0,fpD_one}),


  .retireRead0_addr(retire0_rF_reg2),.retireRead0_data(ret_dataAFL[0]),
  .retireRead1_addr(retire1_rF_reg2),.retireRead1_data(ret_dataAFL[1]),
  .retireRead2_addr(retire2_rF_reg2),.retireRead2_data(ret_dataAFL[2]),
  .retireRead3_addr(retire3_rF_reg2),.retireRead3_data(ret_dataAFL[3]),
  .retireRead4_addr(retire4_rF_reg2),.retireRead4_data(ret_dataAFL[4]),
  .retireRead5_addr(retire5_rF_reg2),.retireRead5_data(ret_dataAFL[5]),
  .retireRead6_addr(retire6_rF_reg2),.retireRead6_data(ret_dataAFL[6]),
  .retireRead7_addr(retire7_rF_reg2),.retireRead7_data(ret_dataAFL[7]),
  .retireRead8_addr(retire8_rF_reg2),.retireRead8_data(ret_dataAFL[8]),

  .write0_addr_reg(FUreg_reg3[0]),.write0_data_reg(FUFL_reg[0]),.write0_wen_reg(FUwen_reg3[0] & FU0Hit_reg2),
  .write1_addr_reg(FUreg_reg3[1]),.write1_data_reg(FUFL_reg[1]),.write1_wen_reg(FUwen_reg3[1] & FU1Hit_reg2),
  .write2_addr_reg(FUreg_reg3[2]),.write2_data_reg(FUFL_reg[2]),.write2_wen_reg(FUwen_reg3[2] & FU2Hit_reg2),
  .write3_addr_reg(FUreg_reg3[3]),.write3_data_reg(FUFL_reg[3]),.write3_wen_reg(FUwen_reg3[3] & FU3Hit_reg2),
  .write4_addr_reg(FUreg_reg5[4]),.write4_data_reg(FUFL_reg[4]),.write4_wen_reg(FUwen_reg5[4]),
  .write5_addr_reg(FUreg_reg5[5]),.write5_data_reg(FUFL_reg[5]),.write5_wen_reg(FUwen_reg5[5]),
  .write6_addr_reg(FUreg_reg5[6]),.write6_data_reg(FUFL_reg[6]),.write6_wen_reg(FUwen_reg5[6]),
  .write7_addr_reg(FUreg_reg7[7]),.write7_data_reg(FUFL_reg[7]),.write7_wen_reg(FUwen_reg7[7]),
  .write8_addr_reg(FUreg_reg7[8]),.write8_data_reg(FUFL_reg[8]),.write8_wen_reg(FUwen_reg7[8]),
  .write9_addr_reg(FUreg_reg7[9]),.write9_data_reg(FUFL_reg[9]),.write9_wen_reg(FUwen_reg7[9])
  );

  reginfl #(1'b1) inflGVA_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),

  .read0_addr(regAW[0]),.read0_data(inflA[0]),
    .read0_oe(~isAWF[0] & ~isAWV[0]),
  .read1_addr(regA[1]),.read1_data(inflA[1]),
    .read1_oe(~isAF[1] & ~isAV[1]),
  .read2_addr(regA[2]),.read2_data(inflA[2]),
    .read2_oe(~isAF[2] & ~isAV[2]),
  .read3_addr(regAW[1]),.read3_data(inflA[3]),
    .read3_oe(~isAWF[1] & ~isAWV[1]),
  .read4_addr(regA[4]),.read4_data(inflA[4]),
    .read4_oe(~isAF[4] & ~isAV[4]),
  .read5_addr(regA[5]),.read5_data(inflA[5]),
    .read5_oe(~isAF[5] & ~isAV[5]),
  .read6_addr(regAW[2]),.read6_data(inflA[6]),
    .read6_oe(~isAWF[2] & ~isAWV[2]),
  .read7_addr(regA[7]),.read7_data(inflA[7]),
    .read7_oe(~isAF[7] & ~isAV[7]),
  .read8_addr(regA[8]),.read8_data(inflA[8]),
    .read8_oe(~isAF[8] & ~isAV[8]),

  .read0_constEn(useAConstW[0]||~rs_rAW_use[0]&~rs_rAW_useF[0]||rs_rAW_use[0]&retAW[0]||rs_rAW_useF[0]&retAWF[0]),
  .read1_constEn(~rs_rA_use[1]&~rs_rA_useF[1]||rs_rA_use[1]&retA[1]||rs_rA_useF[1]&retAF[1]),
  .read2_constEn(~rs_rA_use[2]&~rs_rA_useF[2]||rs_rA_use[2]&retA[2]||rs_rA_useF[2]&retAF[2]),
  .read3_constEn(useAConstW[1]||~rs_rAW_use[1]&~rs_rAW_useF[1]||rs_rAW_use[1]&retAW[1]||rs_rAW_useF[1]&retAWF[1]),
  .read4_constEn(~rs_rA_use[4]&~rs_rA_useF[4]||rs_rA_use[4]&retA[4]||rs_rA_useF[4]&retAF[4]),
  .read5_constEn(~rs_rA_use[5]&~rs_rA_useF[5]||rs_rA_use[5]&retA[5]||rs_rA_useF[5]&retAF[5]),
  .read6_constEn(useAConstW[2]||~rs_rAW_use[2]&~rs_rAW_useF[2]||rs_rAW_use[2]&retAW[2]||rs_rAW_useF[2]&retAWF[2]),
  .read7_constEn(~rs_rA_use[7]&~rs_rA_useF[7]||rs_rA_use[7]&retA[7]||rs_rA_useF[7]&retAF[7]),
  .read8_constEn(~rs_rA_use[8]&~rs_rA_useF[8]||rs_rA_use[8]&retA[8]||rs_rA_useF[8]&retAF[8]),


  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg[4]),.write4_wen_reg(FUwen_reg[4]),
  .write5_addr_reg(FUreg_reg[5]),.write5_wen_reg(FUwen_reg[5]),
  .write6_addr_reg(FUreg_reg[6]),.write6_wen_reg(FUwen_reg[6]),
  .write7_addr_reg(FUreg_reg[7]),.write7_wen_reg(FUwen_reg[7]),
  .write8_addr_reg(FUreg_reg[8]),.write8_wen_reg(FUwen_reg[8]),
  .write9_addr_reg(FUreg_reg[9]),.write9_wen_reg(FUwen_reg[9]),
  .newAddr0(clrR_reg[0][8:4]),.newEn0(clr_reg[0]),
  .newAddr1(clrR_reg[1][8:4]),.newEn1(clr_reg[1]),
  .newAddr2(clrR_reg[2][8:4]),.newEn2(clr_reg[2]),
  .newAddr3(clrR_reg[3][8:4]),.newEn3(clr_reg[3]),
  .newAddr4(clrR_reg[4][8:4]),.newEn4(clr_reg[4]),
  .newAddr5(clrR_reg[5][8:4]),.newEn5(clr_reg[5]),
  .newAddr6(clrR_reg[6][8:4]),.newEn6(clr_reg[6]),
  .newAddr7(clrR_reg[7][8:4]),.newEn7(clr_reg[7]),
  .newAddr8(clrR_reg[8][8:4]),.newEn8(clr_reg[8])
  );

  reginfl inflVA_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),

  .read0_addr(regAWF[0]),.read0_data(inflA[0]),
    .read0_oe(isAWV[0]),
  .read1_addr(regAF[1]),.read1_data(inflA[1]),
    .read1_oe(isAV[1]),
  .read2_addr(regAF[2]),.read2_data(inflA[2]),
    .read2_oe(isAV[2]),
  .read3_addr(regAWF[1]),.read3_data(inflA[3]),
    .read3_oe(isAWV[1]),
  .read4_addr(regAF[4]),.read4_data(inflA[4]),
    .read4_oe(isAV[4]),
  .read5_addr(regAF[5]),.read5_data(inflA[5]),
    .read5_oe(isAV[5]),
  .read6_addr(regAWF[2]),.read6_data(inflA[6]),
    .read6_oe(isAWV[2]),
  .read7_addr(regAF[7]),.read7_data(inflA[7]),
    .read7_oe(isAV[7]),
  .read8_addr(regAF[8]),.read8_data(inflA[8]),
    .read8_oe(isAV[8]),

  .read0_constEn(~rs_rAW_useF[0]||retAWF[0]),
  .read1_constEn(~rs_rA_useF[1]||retAF[1]),
  .read2_constEn(~rs_rA_useF[2]||retAF[2]),
  .read3_constEn(~rs_rAW_useF[1]||retAWF[1]),
  .read4_constEn(~rs_rA_useF[4]||retAF[4]),
  .read5_constEn(~rs_rA_useF[5]||retAF[5]),
  .read6_constEn(~rs_rAW_useF[2]||retAWF[2]),
  .read7_constEn(~rs_rA_useF[7]||retAF[7]),
  .read8_constEn(~rs_rA_useF[8]||retAF[8]),


  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg[4]),.write4_wen_reg(FUwen_reg[4]),
  .write5_addr_reg(FUreg_reg[5]),.write5_wen_reg(FUwen_reg[5]),
  .write6_addr_reg(FUreg_reg[6]),.write6_wen_reg(FUwen_reg[6]),
  .write7_addr_reg(FUreg_reg2[7]),.write7_wen_reg(FUwen_reg2[7]),
  .write8_addr_reg(FUreg_reg2[8]),.write8_wen_reg(FUwen_reg2[8]),
  .write9_addr_reg(FUreg_reg2[9]),.write9_wen_reg(FUwen_reg2[9]),
  .newAddr0(clrR_reg[0][8:4]),.newEn0(clr_reg[0]),
  .newAddr1(clrR_reg[1][8:4]),.newEn1(clr_reg[1]),
  .newAddr2(clrR_reg[2][8:4]),.newEn2(clr_reg[2]),
  .newAddr3(clrR_reg[3][8:4]),.newEn3(clr_reg[3]),
  .newAddr4(clrR_reg[4][8:4]),.newEn4(clr_reg[4]),
  .newAddr5(clrR_reg[5][8:4]),.newEn5(clr_reg[5]),
  .newAddr6(clrR_reg[6][8:4]),.newEn6(clr_reg[6]),
  .newAddr7(clrR_reg[7][8:4]),.newEn7(clr_reg[7]),
  .newAddr8(clrR_reg[8][8:4]),.newEn8(clr_reg[8])
  );

  reginfl inflFA_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),

  .read0_addr(regAWF[0]),.read0_data(inflA[0]),
    .read0_oe(isAWF[0]),
  .read1_addr(regAF[1]),.read1_data(inflA[1]),
    .read1_oe(isAF[1]),
  .read2_addr(regAF[2]),.read2_data(inflA[2]),
    .read2_oe(isAF[2]),
  .read3_addr(regAWF[1]),.read3_data(inflA[3]),
    .read3_oe(isAWF[1]),
  .read4_addr(regAF[4]),.read4_data(inflA[4]),
    .read4_oe(isAF[4]),
  .read5_addr(regAF[5]),.read5_data(inflA[5]),
    .read5_oe(isAF[5]),
  .read6_addr(regAWF[2]),.read6_data(inflA[6]),
    .read6_oe(isAWF[2]),
  .read7_addr(regAF[7]),.read7_data(inflA[7]),
    .read7_oe(isAF[7]),
  .read8_addr(regAF[8]),.read8_data(inflA[8]),
    .read8_oe(isAF[8]),

  .read0_constEn(~rs_rAW_useF[0]||retAWF[0]),
  .read1_constEn(~rs_rA_useF[1]||retAF[1]),
  .read2_constEn(~rs_rA_useF[2]||retAF[2]),
  .read3_constEn(~rs_rAW_useF[1]||retAWF[1]),
  .read4_constEn(~rs_rA_useF[4]||retAF[4]),
  .read5_constEn(~rs_rA_useF[5]||retAF[5]),
  .read6_constEn(~rs_rAW_useF[2]||retAWF[2]),
  .read7_constEn(~rs_rA_useF[7]||retAF[7]),
  .read8_constEn(~rs_rA_useF[8]||retAF[8]),


  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg3[4]),.write4_wen_reg(FUwen_reg3[4]),
  .write5_addr_reg(FUreg_reg3[5]),.write5_wen_reg(FUwen_reg3[5]),
  .write6_addr_reg(FUreg_reg3[6]),.write6_wen_reg(FUwen_reg3[6]),
  .write7_addr_reg(FUreg_reg5[7]),.write7_wen_reg(FUwen_reg5[7]),
  .write8_addr_reg(FUreg_reg5[8]),.write8_wen_reg(FUwen_reg5[8]),
  .write9_addr_reg(FUreg_reg5[9]),.write9_wen_reg(FUwen_reg5[9]),
  .newAddr0(clrR_reg[0][8:4]),.newEn0(clr_reg[0]),
  .newAddr1(clrR_reg[1][8:4]),.newEn1(clr_reg[1]),
  .newAddr2(clrR_reg[2][8:4]),.newEn2(clr_reg[2]),
  .newAddr3(clrR_reg[3][8:4]),.newEn3(clr_reg[3]),
  .newAddr4(clrR_reg[4][8:4]),.newEn4(clr_reg[4]),
  .newAddr5(clrR_reg[5][8:4]),.newEn5(clr_reg[5]),
  .newAddr6(clrR_reg[6][8:4]),.newEn6(clr_reg[6]),
  .newAddr7(clrR_reg[7][8:4]),.newEn7(clr_reg[7]),
  .newAddr8(clrR_reg[8][8:4]),.newEn8(clr_reg[8])
  );

  regfile regB_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_addr(regBW[0]),.read0_data(dataB[0]),
    .read0_oe(~retBW[0]|useBConstW[0]|~rs_rBW_use[0]),.read0_match(gazumpBG[0]),
  .read1_addr(regB[1]),.read1_data(dataB[1]),
    .read1_oe(~retB[1]|rs0i1_useBConst_reg|~rs_rB_use[1]),.read1_match(gazumpBG[1]),
  .read2_addr(regB[2]),.read2_data(dataB[2]),
    .read2_oe(~retB[2]|rs0i2_useBConst_reg|~rs_rB_use[2]),.read2_match(gazumpBG[2]),
  .read3_addr(regBW[1]),.read3_data(dataB[3]),
    .read3_oe(~retBW[1]|useBConstW[1]|~rs_rBW_use[1]),.read3_match(gazumpBG[3]),
  .read4_addr(regB[4]),.read4_data(dataB[4]),
    .read4_oe(~retB[4]|rs1i1_useBConst_reg|~rs_rB_use[4]),.read4_match(gazumpBG[4]),
  .read5_addr(regB[5]),.read5_data(dataB[5]),
    .read5_oe(~retB[5]|rs1i2_useBConst_reg|~rs_rB_use[5]),.read5_match(gazumpBG[5]),
  .read6_addr(regBW[2]),.read6_data(dataB[6]),
    .read6_oe(~retBW[2]|useBConstW[2]|~rs_rBW_use[2]),.read6_match(gazumpBG[6]),
  .read7_addr(regB[7]),.read7_data(dataB[7]),
    .read7_oe(~retB[7]|rs2i1_useBConst_reg|~rs_rB_use[7]),.read7_match(gazumpBG[7]),
  .read8_addr(regB[8]),.read8_data(dataB[8]),
    .read8_oe(~retB[8]|rs2i2_useBConst_reg|~rs_rB_use[8]),.read8_match(gazumpBG[8]),

  .read0_constEn(useBConstW[0]|~rs_rBW_use[0]),
  .read1_constEn(rs0i1_useBConst_reg|~rs_rB_use[1]),
  .read2_constEn(rs0i2_useBConst_reg|~rs_rB_use[2]),
  .read3_constEn(useBConstW[1]|~rs_rBW_use[1]),
  .read4_constEn(rs1i1_useBConst_reg|~rs_rB_use[4]),
  .read5_constEn(rs1i2_useBConst_reg|~rs_rB_use[5]),
  .read6_constEn(useBConstW[2]|~rs_rBW_use[2]),
  .read7_constEn(rs2i1_useBConst_reg|~rs_rB_use[7]),
  .read8_constEn(rs2i2_useBConst_reg|~rs_rB_use[8]),

  .read0_const(rs_const_new[0]&{64{useBConstW[0]}}),
  .read1_const(rs_const_new[1]&{64{rs0i1_useBConst_reg}}),
  .read2_const(rs_const_new[2]),
  .read3_const(rs_const_new[3]&{64{useBConstW[1]}}),
  .read4_const(rs_const_new[4]&{64{rs1i1_useBConst_reg}}),
  .read5_const(rs_const_new[5]),
  .read6_const(rs_const_new[6]&{64{useBConstW[2]}}),
  .read7_const(rs_const_new[7]&{64{rs2i1_useBConst_reg}}),
  .read8_const(rs_const_new[8]),

  .retireRead0_addr(retire0_rF),.retireRead0_data(ret_dataB[0]),
  .retireRead1_addr(retire1_rF),.retireRead1_data(ret_dataB[1]),
  .retireRead2_addr(retire2_rF),.retireRead2_data(ret_dataB[2]),
  .retireRead3_addr(retire3_rF),.retireRead3_data(ret_dataB[3]),
  .retireRead4_addr(retire4_rF),.retireRead4_data(ret_dataB[4]),
  .retireRead5_addr(retire5_rF),.retireRead5_data(ret_dataB[5]),
  .retireRead6_addr(retire6_rF),.retireRead6_data(ret_dataB[6]),
  .retireRead7_addr(retire7_rF),.retireRead7_data(ret_dataB[7]),
  .retireRead8_addr(retire8_rF),.retireRead8_data(ret_dataB[8]),

  .write0_addr_reg(FUreg_reg[0]),.write0_data_reg(FU_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_data_reg(FU_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_data_reg(FU_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_data_reg(FU_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg[4]),.write4_data_reg(FU_reg[4]),.write4_wen_reg(FUwen_reg[4]),
  .write5_addr_reg(FUreg_reg[5]),.write5_data_reg(FU_reg[5]),.write5_wen_reg(FUwen_reg[5]),
  .write6_addr_reg(FUreg_reg[6]),.write6_data_reg(FU_reg[6]),.write6_wen_reg(FUwen_reg[6]),
  .write7_addr_reg(FUreg_reg[7]),.write7_data_reg(FU_reg[7]),.write7_wen_reg(FUwen_reg[7]),
  .write8_addr_reg(FUreg_reg[8]),.write8_data_reg(FU_reg[8]),.write8_wen_reg(FUwen_reg[8]),
  .write9_addr_reg(FUreg_reg[9]),.write9_data_reg(FU_reg[9]),.write9_wen_reg(FUwen_reg[9])
  );

  regfile #(SIMD_WIDTH) regBVH_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_match(),.read1_match(),.read2_match(),
  .read3_match(),.read4_match(),.read5_match(),
  .read6_match(),.read7_match(),.read8_match(),
  .read0_addr(regBFW_reg[0]),.read0_data(dataBVH[0]),
    .read0_oe(~retBFW_reg[0]|~rs_rBW_useF_reg[0]),
  .read1_addr(regBF_reg[1]),.read1_data(dataBVH[1]),
    .read1_oe(~retBF_reg[1]|~rs_rB_useF_reg[1]),
  .read2_addr(regBF_reg[2]),.read2_data(dataBVH[2]),
    .read2_oe(~retBF_reg[2]|~rs_rB_useF_reg[2]),
  .read3_addr(regBFW_reg[1]),.read3_data(dataBVH[3]),
    .read3_oe(~retBFW_reg[1]|~rs_rBW_useF_reg[1]),
  .read4_addr(regBF_reg[4]),.read4_data(dataBVH[4]),
    .read4_oe(~retBF_reg[4]|~rs_rB_useF_reg[4]),
  .read5_addr(regBF_reg[5]),.read5_data(dataBVH[5]),
    .read5_oe(~retBF_reg[5]|~rs_rB_useF_reg[5]),
  .read6_addr(regBFW_reg[2]),.read6_data(dataBVH[6]),
    .read6_oe(~retBFW_reg[2]|~rs_rBW_useF_reg[2]),
  .read7_addr(regBF_reg[7]),.read7_data(dataBVH[7]),
    .read7_oe(~retBF_reg[7]|~rs_rB_useF_reg[7]),
  .read8_addr(regBF_reg[8]),.read8_data(dataBVH[8]),
    .read8_oe(~retBF_reg[8]|~rs_rB_useF_reg[8]),

  .read0_constEn(~rs_rBW_useF_reg[0]),
  .read1_constEn(~rs_rB_useF_reg[1]),
  .read2_constEn(~rs_rB_useF_reg[2]),
  .read3_constEn(~rs_rBW_useF_reg[1]),
  .read4_constEn(~rs_rB_useF_reg[4]),
  .read5_constEn(~rs_rB_useF_reg[5]),
  .read6_constEn(~rs_rBW_useF_reg[2]),
  .read7_constEn(~rs_rB_useF_reg[7]),
  .read8_constEn(~rs_rB_useF_reg[8]),

  .read0_const({SIMD_WIDTH{1'B0}}),
  .read1_const({SIMD_WIDTH{1'B0}}),
  .read2_const({SIMD_WIDTH{1'B0}}),
  .read3_const({SIMD_WIDTH{1'B0}}),
  .read4_const({SIMD_WIDTH{1'B0}}),
  .read5_const({SIMD_WIDTH{1'B0}}),
  .read6_const({SIMD_WIDTH{1'B0}}),
  .read7_const({SIMD_WIDTH{1'B0}}),
  .read8_const({SIMD_WIDTH{1'B0}}),

  .retireRead0_addr(retire0_rF_reg),.retireRead0_data(ret_dataBVH[0]),
  .retireRead1_addr(retire1_rF_reg),.retireRead1_data(ret_dataBVH[1]),
  .retireRead2_addr(retire2_rF_reg),.retireRead2_data(ret_dataBVH[2]),
  .retireRead3_addr(retire3_rF_reg),.retireRead3_data(ret_dataBVH[3]),
  .retireRead4_addr(retire4_rF_reg),.retireRead4_data(ret_dataBVH[4]),
  .retireRead5_addr(retire5_rF_reg),.retireRead5_data(ret_dataBVH[5]),
  .retireRead6_addr(retire6_rF_reg),.retireRead6_data(ret_dataBVH[6]),
  .retireRead7_addr(retire7_rF_reg),.retireRead7_data(ret_dataBVH[7]),
  .retireRead8_addr(retire8_rF_reg),.retireRead8_data(ret_dataBVH[8]),

  .write0_addr_reg(FUreg_reg2[0]),.write0_data_reg(FUVH_reg[0]),.write0_wen_reg(FUwen_reg2[0] & FU0Hit_reg),
  .write1_addr_reg(FUreg_reg2[1]),.write1_data_reg(FUVH_reg[1]),.write1_wen_reg(FUwen_reg2[1] & FU1Hit_reg),
  .write2_addr_reg(FUreg_reg2[2]),.write2_data_reg(FUVH_reg[2]),.write2_wen_reg(FUwen_reg2[2] & FU2Hit_reg),
  .write3_addr_reg(FUreg_reg2[3]),.write3_data_reg(FUVH_reg[3]),.write3_wen_reg(FUwen_reg2[3] & FU3Hit_reg),
  .write4_addr_reg(FUreg_reg2[4]),.write4_data_reg(FUVH_reg[4]),.write4_wen_reg(FUwen_reg2[4]),
  .write5_addr_reg(FUreg_reg2[5]),.write5_data_reg(FUVH_reg[5]),.write5_wen_reg(FUwen_reg2[5]),
  .write6_addr_reg(FUreg_reg2[6]),.write6_data_reg(FUVH_reg[6]),.write6_wen_reg(FUwen_reg2[6]),
  .write7_addr_reg(FUreg_reg3[7]),.write7_data_reg(FUVH_reg[7]),.write7_wen_reg(FUwen_reg3[7]),
  .write8_addr_reg(FUreg_reg3[8]),.write8_data_reg(FUVH_reg[8]),.write8_wen_reg(FUwen_reg3[8]),
  .write9_addr_reg(FUreg_reg3[9]),.write9_data_reg(FUVH_reg[9]),.write9_wen_reg(FUwen_reg3[9])
  );

  regfile #(16+SIMD_WIDTH) regBVL_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_match(),.read1_match(),.read2_match(),
  .read3_match(),.read4_match(),.read5_match(),
  .read6_match(),.read7_match(),.read8_match(),
  .read0_addr(regBFW_reg[0]),.read0_data(dataBVL[0]),
    .read0_oe(~retBFW_reg[0]|~rs_rBW_useF_reg[0]),
  .read1_addr(regBF_reg[1]),.read1_data(dataBVL[1]),
    .read1_oe(~retBF_reg[1]|~rs_rB_useF_reg[1]),
  .read2_addr(regBF_reg[2]),.read2_data(dataBVL[2]),
    .read2_oe(~retBF_reg[2]|~rs_rB_useF_reg[2]),
  .read3_addr(regBFW_reg[1]),.read3_data(dataBVL[3]),
    .read3_oe(~retBFW_reg[1]|~rs_rBW_useF_reg[1]),
  .read4_addr(regBF_reg[4]),.read4_data(dataBVL[4]),
    .read4_oe(~retBF_reg[4]|~rs_rB_useF_reg[4]),
  .read5_addr(regBF_reg[5]),.read5_data(dataBVL[5]),
    .read5_oe(~retBF_reg[5]|~rs_rB_useF_reg[5]),
  .read6_addr(regBFW_reg[2]),.read6_data(dataBVL[6]),
    .read6_oe(~retBFW_reg[2]|~rs_rBW_useF_reg[2]),
  .read7_addr(regBF_reg[7]),.read7_data(dataBVL[7]),
    .read7_oe(~retBF_reg[7]|~rs_rB_useF_reg[7]),
  .read8_addr(regBF_reg[8]),.read8_data(dataBVL[8]),
    .read8_oe(~retBF_reg[8]|~rs_rB_useF_reg[8]),

  .read0_constEn(~rs_rBW_useF_reg[0]),
  .read1_constEn(~rs_rB_useF_reg[1]),
  .read2_constEn(~rs_rB_useF_reg[2]),
  .read3_constEn(~rs_rBW_useF_reg[1]),
  .read4_constEn(~rs_rB_useF_reg[4]),
  .read5_constEn(~rs_rB_useF_reg[5]),
  .read6_constEn(~rs_rBW_useF_reg[2]),
  .read7_constEn(~rs_rB_useF_reg[7]),
  .read8_constEn(~rs_rB_useF_reg[8]),

  .read0_const({16+SIMD_WIDTH{1'B0}}),
  .read1_const({16+SIMD_WIDTH{1'B0}}),
  .read2_const({16+SIMD_WIDTH{1'B0}}),
  .read3_const({16+SIMD_WIDTH{1'B0}}),
  .read4_const({16+SIMD_WIDTH{1'B0}}),
  .read5_const({16+SIMD_WIDTH{1'B0}}),
  .read6_const({16+SIMD_WIDTH{1'B0}}),
  .read7_const({16+SIMD_WIDTH{1'B0}}),
  .read8_const({16+SIMD_WIDTH{1'B0}}),

  .retireRead0_addr(retire0_rF_reg),.retireRead0_data(ret_dataBVL[0]),
  .retireRead1_addr(retire1_rF_reg),.retireRead1_data(ret_dataBVL[1]),
  .retireRead2_addr(retire2_rF_reg),.retireRead2_data(ret_dataBVL[2]),
  .retireRead3_addr(retire3_rF_reg),.retireRead3_data(ret_dataBVL[3]),
  .retireRead4_addr(retire4_rF_reg),.retireRead4_data(ret_dataBVL[4]),
  .retireRead5_addr(retire5_rF_reg),.retireRead5_data(ret_dataBVL[5]),
  .retireRead6_addr(retire6_rF_reg),.retireRead6_data(ret_dataBVL[6]),
  .retireRead7_addr(retire7_rF_reg),.retireRead7_data(ret_dataBVL[7]),
  .retireRead8_addr(retire8_rF_reg),.retireRead8_data(ret_dataBVL[8]),

  .write0_addr_reg(FUreg_reg2[0]),.write0_data_reg(FUVL_reg[0]),.write0_wen_reg(FUwen_reg2[0] & FU0Hit_reg),
  .write1_addr_reg(FUreg_reg2[1]),.write1_data_reg(FUVL_reg[1]),.write1_wen_reg(FUwen_reg2[1] & FU1Hit_reg),
  .write2_addr_reg(FUreg_reg2[2]),.write2_data_reg(FUVL_reg[2]),.write2_wen_reg(FUwen_reg2[2] & FU2Hit_reg),
  .write3_addr_reg(FUreg_reg2[3]),.write3_data_reg(FUVL_reg[3]),.write3_wen_reg(FUwen_reg2[3] & FU3Hit_reg),
  .write4_addr_reg(FUreg_reg2[4]),.write4_data_reg(FUVL_reg[4]),.write4_wen_reg(FUwen_reg2[4]),
  .write5_addr_reg(FUreg_reg2[5]),.write5_data_reg(FUVL_reg[5]),.write5_wen_reg(FUwen_reg2[5]),
  .write6_addr_reg(FUreg_reg2[6]),.write6_data_reg(FUVL_reg[6]),.write6_wen_reg(FUwen_reg2[6]),
  .write7_addr_reg(FUreg_reg3[7]),.write7_data_reg(FUVL_reg[7]),.write7_wen_reg(FUwen_reg3[7]),
  .write8_addr_reg(FUreg_reg3[8]),.write8_data_reg(FUVL_reg[8]),.write8_wen_reg(FUwen_reg3[8]),
  .write9_addr_reg(FUreg_reg3[9]),.write9_data_reg(FUVL_reg[9]),.write9_wen_reg(FUwen_reg3[9])
  );

  regfile_get_gazump GzVB(
  .clk(clk),.rst(rst),
  .read_clkEn(~doStall),
  
  .read0_addr(regBFW[0]),.read0_constEn(~rs_rBW_useF[0]),.read0_oe(~retBFW[0]|~rs_rBW_useF[0]),.read0_match(gazumpBV[0]),
  .read1_addr(regBF[1]),.read1_constEn(~rs_rB_useF[1]),.read1_oe(~retBF[1]|~rs_rB_useF[1]),.read1_match(gazumpBV[1]),
  .read2_addr(regBF[2]),.read2_constEn(~rs_rB_useF[2]),.read2_oe(~retBF[2]|~rs_rB_useF[2]),.read2_match(gazumpBV[2]),
  .read3_addr(regBFW[1]),.read3_constEn(~rs_rBW_useF[1]),.read3_oe(~retBFW[1]|~rs_rBW_useF[1]),.read3_match(gazumpBV[3]),
  .read4_addr(regBF[4]),.read4_constEn(~rs_rB_useF[4]),.read4_oe(~retBF[4]|~rs_rB_useF[4]),.read4_match(gazumpBV[4]),
  .read5_addr(regBF[5]),.read5_constEn(~rs_rB_useF[5]),.read5_oe(~retBF[5]|~rs_rB_useF[5]),.read5_match(gazumpBV[5]),
  .read6_addr(regBFW[2]),.read6_constEn(~rs_rBW_useF[2]),.read6_oe(~retBFW[2]|~rs_rBW_useF[2]),.read6_match(gazumpBV[6]),
  .read7_addr(regBF[7]),.read7_constEn(~rs_rB_useF[7]),.read7_oe(~retBF[7]|~rs_rB_useF[7]),.read7_match(gazumpBV[7]),
  .read8_addr(regBF[8]),.read8_constEn(~rs_rB_useF[8]),.read8_oe(~retBF[8]|~rs_rB_useF[8]),.read8_match(gazumpBV[8]),

  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg[4]),.write4_wen_reg(FUwen_reg[4]),
  .write5_addr_reg(FUreg_reg[5]),.write5_wen_reg(FUwen_reg[5]),
  .write6_addr_reg(FUreg_reg[6]),.write6_wen_reg(FUwen_reg[6]),
  .write7_addr_reg(FUreg_reg2[7]),.write7_wen_reg(FUwen_reg2[7]),
  .write8_addr_reg(FUreg_reg2[8]),.write8_wen_reg(FUwen_reg2[8]),
  .write9_addr_reg(FUreg_reg2[9]),.write9_wen_reg(FUwen_reg2[9])
  );

  regfile_get_gazump GzFB(
  .clk(clk),.rst(rst),
  .read_clkEn(~doStall),
  
  .read0_addr(regBFW[0]),.read0_constEn(~rs_rBW_useF[0]),.read0_oe(~retBFW[0]|~rs_rBW_useF[0]),.read0_match(gazumpFB[0]),
  .read1_addr(regBF[1]),.read1_constEn(~rs_rB_useF[1]),.read1_oe(~retBF[1]|~rs_rB_useF[1]),.read1_match(gazumpFB[1]),
  .read2_addr(regBF[2]),.read2_constEn(~rs_rB_useF[2]),.read2_oe(~retBF[2]|~rs_rB_useF[2]),.read2_match(gazumpFB[2]),
  .read3_addr(regBFW[1]),.read3_constEn(~rs_rBW_useF[1]),.read3_oe(~retBFW[1]|~rs_rBW_useF[1]),.read3_match(gazumpFB[3]),
  .read4_addr(regBF[4]),.read4_constEn(~rs_rB_useF[4]),.read4_oe(~retBF[4]|~rs_rB_useF[4]),.read4_match(gazumpFB[4]),
  .read5_addr(regBF[5]),.read5_constEn(~rs_rB_useF[5]),.read5_oe(~retBF[5]|~rs_rB_useF[5]),.read5_match(gazumpFB[5]),
  .read6_addr(regBFW[2]),.read6_constEn(~rs_rBW_useF[2]),.read6_oe(~retBFW[2]|~rs_rBW_useF[2]),.read6_match(gazumpFB[6]),
  .read7_addr(regBF[7]),.read7_constEn(~rs_rB_useF[7]),.read7_oe(~retBF[7]|~rs_rB_useF[7]),.read7_match(gazumpFB[7]),
  .read8_addr(regBF[8]),.read8_constEn(~rs_rB_useF[8]),.read8_oe(~retBF[8]|~rs_rB_useF[8]),.read8_match(gazumpFB[8]),

  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg3[4]),.write4_wen_reg(FUwen_reg3[4]),
  .write5_addr_reg(FUreg_reg3[5]),.write5_wen_reg(FUwen_reg3[5]),
  .write6_addr_reg(FUreg_reg3[6]),.write6_wen_reg(FUwen_reg3[6]),
  .write7_addr_reg(FUreg_reg5[7]),.write7_wen_reg(FUwen_reg5[7]),
  .write8_addr_reg(FUreg_reg5[8]),.write8_wen_reg(FUwen_reg5[8]),
  .write9_addr_reg(FUreg_reg5[9]),.write9_wen_reg(FUwen_reg5[9])
  );

  regfile #(SIMD_WIDTH) regBFH_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_match(),.read1_match(),.read2_match(),
  .read3_match(),.read4_match(),.read5_match(),
  .read6_match(),.read7_match(),.read8_match(),
  .read0_addr(regBFW_reg2[0]),.read0_data(dataBFH[0]),
    .read0_oe(~retBFW_reg2[0]|~rs_rBW_useF_reg2[0]),
  .read1_addr(regBF_reg2[1]),.read1_data(dataBFH[1]),
    .read1_oe(~retBF_reg2[1]|~rs_rB_useF_reg2[1]),
  .read2_addr(regBF_reg2[2]),.read2_data(dataBFH[2]),
    .read2_oe(~retBF_reg2[2]|~rs_rB_useF_reg2[2]),
  .read3_addr(regBFW_reg2[1]),.read3_data(dataBFH[3]),
    .read3_oe(~retBFW_reg2[1]|~rs_rBW_useF_reg2[1]),
  .read4_addr(regBF_reg2[4]),.read4_data(dataBFH[4]),
    .read4_oe(~retBF_reg2[4]|~rs_rB_useF_reg2[4]),
  .read5_addr(regBF_reg2[5]),.read5_data(dataBFH[5]),
    .read5_oe(~retBF_reg2[5]|~rs_rB_useF_reg2[5]),
  .read6_addr(regBFW_reg2[2]),.read6_data(dataBFH[6]),
    .read6_oe(~retBFW_reg2[2]|~rs_rBW_useF_reg2[2]),
  .read7_addr(regBF_reg2[7]),.read7_data(dataBFH[7]),
    .read7_oe(~retBF_reg2[7]|~rs_rB_useF_reg2[7]),
  .read8_addr(regBF_reg2[8]),.read8_data(dataBFH[8]),
    .read8_oe(~retBF_reg2[8]|~rs_rB_useF_reg2[8]),

  .read0_constEn(~rs_rBW_useF_reg2[0]),
  .read1_constEn(~rs_rB_useF_reg2[1]),
  .read2_constEn(~rs_rB_useF_reg2[2]),
  .read3_constEn(~rs_rBW_useF_reg2[1]),
  .read4_constEn(~rs_rB_useF_reg2[4]),
  .read5_constEn(~rs_rB_useF_reg2[5]),
  .read6_constEn(~rs_rBW_useF_reg2[2]),
  .read7_constEn(~rs_rB_useF_reg2[7]),
  .read8_constEn(~rs_rB_useF_reg2[8]),

  .read0_const({SIMD_WIDTH{1'B0}}),
  .read1_const({SIMD_WIDTH{1'B0}}),
  .read2_const({SIMD_WIDTH{1'B0}}),
  .read3_const({SIMD_WIDTH{1'B0}}),
  .read4_const({SIMD_WIDTH{1'B0}}),
  .read5_const({SIMD_WIDTH{1'B0}}),
  .read6_const({SIMD_WIDTH{1'B0}}),
  .read7_const({SIMD_WIDTH{1'B0}}),
  .read8_const({SIMD_WIDTH{1'B0}}),

  .retireRead0_addr(retire0_rF_reg2),.retireRead0_data(ret_dataBFH[0]),
  .retireRead1_addr(retire1_rF_reg2),.retireRead1_data(ret_dataBFH[1]),
  .retireRead2_addr(retire2_rF_reg2),.retireRead2_data(ret_dataBFH[2]),
  .retireRead3_addr(retire3_rF_reg2),.retireRead3_data(ret_dataBFH[3]),
  .retireRead4_addr(retire4_rF_reg2),.retireRead4_data(ret_dataBFH[4]),
  .retireRead5_addr(retire5_rF_reg2),.retireRead5_data(ret_dataBFH[5]),
  .retireRead6_addr(retire6_rF_reg2),.retireRead6_data(ret_dataBFH[6]),
  .retireRead7_addr(retire7_rF_reg2),.retireRead7_data(ret_dataBFH[7]),
  .retireRead8_addr(retire8_rF_reg2),.retireRead8_data(ret_dataBFH[8]),

  .write0_addr_reg(FUreg_reg3[0]),.write0_data_reg(FUFH_reg[0]),.write0_wen_reg(FUwen_reg3[0] & FU0Hit_reg2),
  .write1_addr_reg(FUreg_reg3[1]),.write1_data_reg(FUFH_reg[1]),.write1_wen_reg(FUwen_reg3[1] & FU1Hit_reg2),
  .write2_addr_reg(FUreg_reg3[2]),.write2_data_reg(FUFH_reg[2]),.write2_wen_reg(FUwen_reg3[2] & FU2Hit_reg2),
  .write3_addr_reg(FUreg_reg3[3]),.write3_data_reg(FUFH_reg[3]),.write3_wen_reg(FUwen_reg3[3] & FU3Hit_reg2),
  .write4_addr_reg(FUreg_reg5[4]),.write4_data_reg(FUFH_reg[4]),.write4_wen_reg(FUwen_reg5[4]),
  .write5_addr_reg(FUreg_reg5[5]),.write5_data_reg(FUFH_reg[5]),.write5_wen_reg(FUwen_reg5[5]),
  .write6_addr_reg(FUreg_reg5[6]),.write6_data_reg(FUFH_reg[6]),.write6_wen_reg(FUwen_reg5[6]),
  .write7_addr_reg(FUreg_reg7[7]),.write7_data_reg(FUFH_reg[7]),.write7_wen_reg(FUwen_reg7[7]),
  .write8_addr_reg(FUreg_reg7[8]),.write8_data_reg(FUFH_reg[8]),.write8_wen_reg(FUwen_reg7[8]),
  .write9_addr_reg(FUreg_reg7[9]),.write9_data_reg(FUFH_reg[9]),.write9_wen_reg(FUwen_reg7[9])
  );

  regfile #(SIMD_WIDTH) regBFL_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b1),

  .read0_match(),.read1_match(),.read2_match(),
  .read3_match(),.read4_match(),.read5_match(),
  .read6_match(),.read7_match(),.read8_match(),
  .read0_addr(regBFW_reg2[0]),.read0_data(dataBFL[0]),
    .read0_oe(~retBFW_reg2[0]|~rs_rBW_useF_reg2[0]),
  .read1_addr(regBF_reg2[1]),.read1_data(dataBFL[1]),
    .read1_oe(~retBF_reg2[1]|~rs_rB_useF_reg2[1]),
  .read2_addr(regBF_reg2[2]),.read2_data(dataBFL[2]),
    .read2_oe(~retBF_reg2[2]|~rs_rB_useF_reg2[2]),
  .read3_addr(regBFW_reg2[1]),.read3_data(dataBFL[3]),
    .read3_oe(~retBFW_reg2[1]|~rs_rBW_useF_reg2[1]),
  .read4_addr(regBF_reg2[4]),.read4_data(dataBFL[4]),
    .read4_oe(~retBF_reg2[4]|~rs_rB_useF_reg2[4]),
  .read5_addr(regBF_reg2[5]),.read5_data(dataBFL[5]),
    .read5_oe(~retBF_reg2[5]|~rs_rB_useF_reg2[5]),
  .read6_addr(regBFW_reg2[2]),.read6_data(dataBFL[6]),
    .read6_oe(~retBFW_reg2[2]|~rs_rBW_useF_reg2[2]),
  .read7_addr(regBF_reg2[7]),.read7_data(dataBFL[7]),
    .read7_oe(~retBF_reg2[7]|~rs_rB_useF_reg2[7]),
  .read8_addr(regBF_reg2[8]),.read8_data(dataBFL[8]),
    .read8_oe(~retBF_reg2[8]|~rs_rB_useF_reg2[8]),

  .read0_constEn(~rs_rBW_useF_reg2[0]),
  .read1_constEn(~rs_rB_useF_reg2[1]),
  .read2_constEn(~rs_rB_useF_reg2[2]),
  .read3_constEn(~rs_rBW_useF_reg2[1]),
  .read4_constEn(~rs_rB_useF_reg2[4]),
  .read5_constEn(~rs_rB_useF_reg2[5]),
  .read6_constEn(~rs_rBW_useF_reg2[2]),
  .read7_constEn(~rs_rB_useF_reg2[7]),
  .read8_constEn(~rs_rB_useF_reg2[8]),

  .read0_const({SIMD_WIDTH{1'B0}}),
  .read1_const({SIMD_WIDTH{1'B0}}),
  .read2_const({SIMD_WIDTH{1'B0}}),
  .read3_const({SIMD_WIDTH{1'B0}}),
  .read4_const({SIMD_WIDTH{1'B0}}),
  .read5_const({SIMD_WIDTH{1'B0}}),
  .read6_const({SIMD_WIDTH{1'B0}}),
  .read7_const({SIMD_WIDTH{1'B0}}),
  .read8_const({SIMD_WIDTH{1'B0}}),

  .retireRead0_addr(retire0_rF_reg2),.retireRead0_data(ret_dataBFL[0]),
  .retireRead1_addr(retire1_rF_reg2),.retireRead1_data(ret_dataBFL[1]),
  .retireRead2_addr(retire2_rF_reg2),.retireRead2_data(ret_dataBFL[2]),
  .retireRead3_addr(retire3_rF_reg2),.retireRead3_data(ret_dataBFL[3]),
  .retireRead4_addr(retire4_rF_reg2),.retireRead4_data(ret_dataBFL[4]),
  .retireRead5_addr(retire5_rF_reg2),.retireRead5_data(ret_dataBFL[5]),
  .retireRead6_addr(retire6_rF_reg2),.retireRead6_data(ret_dataBFL[6]),
  .retireRead7_addr(retire7_rF_reg2),.retireRead7_data(ret_dataBFL[7]),
  .retireRead8_addr(retire8_rF_reg2),.retireRead8_data(ret_dataBFL[8]),

  .write0_addr_reg(FUreg_reg3[0]),.write0_data_reg(FUFL_reg[0]),.write0_wen_reg(FUwen_reg3[0] & FU0Hit_reg2),
  .write1_addr_reg(FUreg_reg3[1]),.write1_data_reg(FUFL_reg[1]),.write1_wen_reg(FUwen_reg3[1] & FU1Hit_reg2),
  .write2_addr_reg(FUreg_reg3[2]),.write2_data_reg(FUFL_reg[2]),.write2_wen_reg(FUwen_reg3[2] & FU2Hit_reg2),
  .write3_addr_reg(FUreg_reg3[3]),.write3_data_reg(FUFL_reg[3]),.write3_wen_reg(FUwen_reg3[3] & FU3Hit_reg2),
  .write4_addr_reg(FUreg_reg5[4]),.write4_data_reg(FUFL_reg[4]),.write4_wen_reg(FUwen_reg5[4]),
  .write5_addr_reg(FUreg_reg5[5]),.write5_data_reg(FUFL_reg[5]),.write5_wen_reg(FUwen_reg5[5]),
  .write6_addr_reg(FUreg_reg5[6]),.write6_data_reg(FUFL_reg[6]),.write6_wen_reg(FUwen_reg5[6]),
  .write7_addr_reg(FUreg_reg7[7]),.write7_data_reg(FUFL_reg[7]),.write7_wen_reg(FUwen_reg7[7]),
  .write8_addr_reg(FUreg_reg7[8]),.write8_data_reg(FUFL_reg[8]),.write8_wen_reg(FUwen_reg7[8]),
  .write9_addr_reg(FUreg_reg7[9]),.write9_data_reg(FUFL_reg[9]),.write9_wen_reg(FUwen_reg7[9])
  );

  reginfl #(1'b1) reginflGVB_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),

  .read0_addr(regBW[0]),.read0_data(inflB[0]),
    .read0_oe(~isBFW[0] & ~isBVW[0]),
  .read1_addr(regB[1]),.read1_data(inflB[1]),
    .read1_oe(~isBF[1] & ~isBV[1]),
  .read2_addr(regB[2]),.read2_data(inflB[2]),
    .read2_oe(~isBF[2] & ~isBV[2]),
  .read3_addr(regBW[1]),.read3_data(inflB[3]),
    .read3_oe(~isBFW[1] & ~isBVW[1]),
  .read4_addr(regB[4]),.read4_data(inflB[4]),
    .read4_oe(~isBF[4] & ~isBV[4]),
  .read5_addr(regB[5]),.read5_data(inflB[5]),
    .read5_oe(~isBF[5] & ~isBV[5]),
  .read6_addr(regBW[2]),.read6_data(inflB[6]),
    .read6_oe(~isBFW[2] & ~isBVW[2]),
  .read7_addr(regB[7]),.read7_data(inflB[7]),
    .read7_oe(~isBF[7] & ~isBV[7]),
  .read8_addr(regB[8]),.read8_data(inflB[8]),
    .read8_oe(~isBF[8] & ~isBV[8]),

  .read0_constEn(useBConstW[0]||~rs_rBW_use[0]&~rs_rBW_useF[0]||rs_rBW_use[0]&retBW[0]||rs_rBW_useF[0]&retBFW[0]),
  .read1_constEn(rs0i1_useBConst_reg||~rs_rB_use[1]&~rs_rB_useF[1]||rs_rB_use[1]&retB[1]||rs_rB_useF[1]&retBF[1]),
  .read2_constEn(rs0i2_useBConst_reg||~rs_rB_use[2]&~rs_rB_useF[2]||rs_rB_use[2]&retB[2]||rs_rB_useF[2]&retBF[2]),
  .read3_constEn(useBConstW[1]||~rs_rBW_use[1]&~rs_rBW_useF[1]||rs_rBW_use[1]&retBW[1]||rs_rBW_useF[1]&retBFW[1]),
  .read4_constEn(rs1i1_useBConst_reg||~rs_rB_use[4]&~rs_rB_useF[4]||rs_rB_use[4]&retB[4]||rs_rB_useF[4]&retBF[4]),
  .read5_constEn(rs1i2_useBConst_reg||~rs_rB_use[5]&~rs_rB_useF[5]||rs_rB_use[5]&retB[5]||rs_rB_useF[5]&retBF[5]),
  .read6_constEn(useBConstW[2]||~rs_rBW_use[2]&~rs_rBW_useF[2]||rs_rBW_use[2]&retBW[2]||rs_rBW_useF[2]&retBFW[2]),
  .read7_constEn(rs2i1_useBConst_reg||~rs_rB_use[7]&~rs_rB_useF[7]||rs_rB_use[7]&retB[7]||rs_rB_useF[7]&retBF[7]),
  .read8_constEn(rs2i2_useBConst_reg||~rs_rB_use[8]&~rs_rB_useF[8]||rs_rB_use[8]&retB[8]||rs_rB_useF[8]&retBF[8]),

  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg[4]),.write4_wen_reg(FUwen_reg[4]),
  .write5_addr_reg(FUreg_reg[5]),.write5_wen_reg(FUwen_reg[5]),
  .write6_addr_reg(FUreg_reg[6]),.write6_wen_reg(FUwen_reg[6]),
  .write7_addr_reg(FUreg_reg[7]),.write7_wen_reg(FUwen_reg[7]),
  .write8_addr_reg(FUreg_reg[8]),.write8_wen_reg(FUwen_reg[8]),
  .write9_addr_reg(FUreg_reg[9]),.write9_wen_reg(FUwen_reg[9]),
  .newAddr0(clrR_reg[0][8:4]),.newEn0(clr_reg[0]),
  .newAddr1(clrR_reg[1][8:4]),.newEn1(clr_reg[1]),
  .newAddr2(clrR_reg[2][8:4]),.newEn2(clr_reg[2]),
  .newAddr3(clrR_reg[3][8:4]),.newEn3(clr_reg[3]),
  .newAddr4(clrR_reg[4][8:4]),.newEn4(clr_reg[4]),
  .newAddr5(clrR_reg[5][8:4]),.newEn5(clr_reg[5]),
  .newAddr6(clrR_reg[6][8:4]),.newEn6(clr_reg[6]),
  .newAddr7(clrR_reg[7][8:4]),.newEn7(clr_reg[7]),
  .newAddr8(clrR_reg[8][8:4]),.newEn8(clr_reg[8])
  );

  reginfl reginflVB_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),

  .read0_addr(regBFW[0]),.read0_data(inflB[0]),
    .read0_oe(isBVW[0]),
  .read1_addr(regBF[1]),.read1_data(inflB[1]),
    .read1_oe(isBV[1]),
  .read2_addr(regBF[2]),.read2_data(inflB[2]),
    .read2_oe(isBV[2]),
  .read3_addr(regBFW[1]),.read3_data(inflB[3]),
    .read3_oe(isBVW[1]),
  .read4_addr(regBF[4]),.read4_data(inflB[4]),
    .read4_oe(isBV[4]),
  .read5_addr(regBF[5]),.read5_data(inflB[5]),
    .read5_oe(isBV[5]),
  .read6_addr(regBFW[2]),.read6_data(inflB[6]),
    .read6_oe(isBVW[2]),
  .read7_addr(regBF[7]),.read7_data(inflB[7]),
    .read7_oe(isBV[7]),
  .read8_addr(regBF[8]),.read8_data(inflB[8]),
    .read8_oe(isBV[8]),

  .read0_constEn(~rs_rBW_useF[0]||retBFW[0]),
  .read1_constEn(~rs_rB_useF[1]||retBF[1]),
  .read2_constEn(~rs_rB_useF[2]||retBF[2]),
  .read3_constEn(~rs_rBW_useF[1]||retBFW[1]),
  .read4_constEn(~rs_rB_useF[4]||retBF[4]),
  .read5_constEn(~rs_rB_useF[5]||retBF[5]),
  .read6_constEn(~rs_rBW_useF[2]||retBFW[2]),
  .read7_constEn(~rs_rB_useF[7]||retBF[7]),
  .read8_constEn(~rs_rB_useF[8]||retBF[8]),

  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg[4]),.write4_wen_reg(FUwen_reg[4]),
  .write5_addr_reg(FUreg_reg[5]),.write5_wen_reg(FUwen_reg[5]),
  .write6_addr_reg(FUreg_reg[6]),.write6_wen_reg(FUwen_reg[6]),
  .write7_addr_reg(FUreg_reg2[7]),.write7_wen_reg(FUwen_reg2[7]),
  .write8_addr_reg(FUreg_reg2[8]),.write8_wen_reg(FUwen_reg2[8]),
  .write9_addr_reg(FUreg_reg2[9]),.write9_wen_reg(FUwen_reg2[9]),
  .newAddr0(clrR_reg[0][8:4]),.newEn0(clr_reg[0]),
  .newAddr1(clrR_reg[1][8:4]),.newEn1(clr_reg[1]),
  .newAddr2(clrR_reg[2][8:4]),.newEn2(clr_reg[2]),
  .newAddr3(clrR_reg[3][8:4]),.newEn3(clr_reg[3]),
  .newAddr4(clrR_reg[4][8:4]),.newEn4(clr_reg[4]),
  .newAddr5(clrR_reg[5][8:4]),.newEn5(clr_reg[5]),
  .newAddr6(clrR_reg[6][8:4]),.newEn6(clr_reg[6]),
  .newAddr7(clrR_reg[7][8:4]),.newEn7(clr_reg[7]),
  .newAddr8(clrR_reg[8][8:4]),.newEn8(clr_reg[8])
  );

  
  
  reginfl reginflFB_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),

  .read0_addr(regBFW[0]),.read0_data(inflB[0]),
    .read0_oe(isBFW[0]),
  .read1_addr(regBF[1]),.read1_data(inflB[1]),
    .read1_oe(isBF[1]),
  .read2_addr(regBF[2]),.read2_data(inflB[2]),
    .read2_oe(isBF[2]),
  .read3_addr(regBFW[1]),.read3_data(inflB[3]),
    .read3_oe(isBFW[1]),
  .read4_addr(regBF[4]),.read4_data(inflB[4]),
    .read4_oe(isBF[4]),
  .read5_addr(regBF[5]),.read5_data(inflB[5]),
    .read5_oe(isBF[5]),
  .read6_addr(regBFW[2]),.read6_data(inflB[6]),
    .read6_oe(isBFW[2]),
  .read7_addr(regBF[7]),.read7_data(inflB[7]),
    .read7_oe(isBF[7]),
  .read8_addr(regBF[8]),.read8_data(inflB[8]),
    .read8_oe(isBF[8]),

  .read0_constEn(~rs_rBW_useF[0]||retBFW[0]),
  .read1_constEn(~rs_rB_useF[1]||retBF[1]),
  .read2_constEn(~rs_rB_useF[2]||retBF[2]),
  .read3_constEn(~rs_rBW_useF[1]||retBFW[1]),
  .read4_constEn(~rs_rB_useF[4]||retBF[4]),
  .read5_constEn(~rs_rB_useF[5]||retBF[5]),
  .read6_constEn(~rs_rBW_useF[2]||retBFW[2]),
  .read7_constEn(~rs_rB_useF[7]||retBF[7]),
  .read8_constEn(~rs_rB_useF[8]||retBF[8]),

  .write0_addr_reg(FUreg_reg[0]),.write0_wen_reg(FUwen_reg[0] & FU0Hit),
  .write1_addr_reg(FUreg_reg[1]),.write1_wen_reg(FUwen_reg[1] & FU1Hit),
  .write2_addr_reg(FUreg_reg[2]),.write2_wen_reg(FUwen_reg[2] & FU2Hit),
  .write3_addr_reg(FUreg_reg[3]),.write3_wen_reg(FUwen_reg[3] & FU3Hit),
  .write4_addr_reg(FUreg_reg3[4]),.write4_wen_reg(FUwen_reg3[4]),
  .write5_addr_reg(FUreg_reg3[5]),.write5_wen_reg(FUwen_reg3[5]),
  .write6_addr_reg(FUreg_reg3[6]),.write6_wen_reg(FUwen_reg3[6]),
  .write7_addr_reg(FUreg_reg5[7]),.write7_wen_reg(FUwen_reg5[7]),
  .write8_addr_reg(FUreg_reg5[8]),.write8_wen_reg(FUwen_reg5[8]),
  .write9_addr_reg(FUreg_reg5[9]),.write9_wen_reg(FUwen_reg5[9]),
  .newAddr0(clrR_reg[0][8:4]),.newEn0(clr_reg[0]),
  .newAddr1(clrR_reg[1][8:4]),.newEn1(clr_reg[1]),
  .newAddr2(clrR_reg[2][8:4]),.newEn2(clr_reg[2]),
  .newAddr3(clrR_reg[3][8:4]),.newEn3(clr_reg[3]),
  .newAddr4(clrR_reg[4][8:4]),.newEn4(clr_reg[4]),
  .newAddr5(clrR_reg[5][8:4]),.newEn5(clr_reg[5]),
  .newAddr6(clrR_reg[6][8:4]),.newEn6(clr_reg[6]),
  .newAddr7(clrR_reg[7][8:4]),.newEn7(clr_reg[7]),
  .newAddr8(clrR_reg[8][8:4]),.newEn8(clr_reg[8])
  );

  
  get_clear_reg clr_mod(
  .newR0(newR[0]),.newR1(newR[1]),.newR2(newR[2]),
  .newR3(newR[3]),.newR4(newR[4]),.newR5(newR[5]),
  .newR6(newR[6]),.newR7(newR[7]),.newR8(newR[8]),
  .alloc({
    rs2i2_allocR_reg,rs2i1_allocR_reg,rs2i0_allocR_reg,
    rs1i2_allocR_reg,rs1i1_allocR_reg,rs1i0_allocR_reg,
    rs0i2_allocR_reg,rs0i1_allocR_reg,rs0i0_allocR_reg}),
  .clr(clr),
  .allocS({
    rs2i2_lastFl_reg,rs2i1_lastFl_reg,1'b0,
    rs1i2_lastFl_reg,rs1i1_lastFl_reg,1'b0,
    rs0i2_lastFl_reg,rs0i1_lastFl_reg,1'b0}),
  .clrS(clrS),
  .clrR0(clrR[0]),.clrR1(clrR[1]),.clrR2(clrR[2]),
  .clrR3(clrR[3]),.clrR4(clrR[4]),.clrR5(clrR[5]),
  .clrR6(clrR[6]),.clrR7(clrR[7]),.clrR8(clrR[8])
  );
  
  
  
  rrf rrfA_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfAW[0]),.read0_data(dataA[0]),.read0_oe(retAW[0]&rs_rAW_use[0]&~useAConstW[0]),
  .read1_addr(rs0i1_rA_reg),.read1_data(dataA[1]),.read1_oe(retA[1]&rs_rA_use[1]),
  .read2_addr(rs0i2_rA_reg),.read2_data(dataA[2]),.read2_oe(retA[2]&rs_rA_use[2]),
  .read3_addr(rrfAW[1]),.read3_data(dataA[3]),.read3_oe(retAW[1]&rs_rAW_use[1]&~useAConstW[1]),
  .read4_addr(rs1i1_rA_reg),.read4_data(dataA[4]),.read4_oe(retA[4]&rs_rA_use[4]),
  .read5_addr(rs1i2_rA_reg),.read5_data(dataA[5]),.read5_oe(retA[5]&rs_rA_use[5]),
  .read6_addr(rrfAW[2]),.read6_data(dataA[6]),.read6_oe(retAW[2]&rs_rAW_use[2]&~useAConstW[2]),
  .read7_addr(rs2i1_rA_reg),.read7_data(dataA[7]),.read7_oe(retA[7]&rs_rA_use[7]),
  .read8_addr(rs2i2_rA_reg),.read8_data(dataA[8]),.read8_oe(retA[8]&rs_rA_use[8]),
  .write0_addr(retire0_rT),.write0_data(ret_dataA[0]),.write0_wen(retire0_enG),
  .write1_addr(retire1_rT),.write1_data(ret_dataA[1]),.write1_wen(retire1_enG),
  .write2_addr(retire2_rT),.write2_data(ret_dataA[2]),.write2_wen(retire2_enG),
  .write3_addr(retire3_rT),.write3_data(ret_dataA[3]),.write3_wen(retire3_enG),
  .write4_addr(retire4_rT),.write4_data(ret_dataA[4]),.write4_wen(retire4_enG),
  .write5_addr(retire5_rT),.write5_data(ret_dataA[5]),.write5_wen(retire5_enG),
  .write6_addr(retire6_rT),.write6_data(ret_dataA[6]),.write6_wen(retire6_enG),
  .write7_addr(retire7_rT),.write7_data(ret_dataA[7]),.write7_wen(retire7_enG),
  .write8_addr(retire8_rT),.write8_data(ret_dataA[8]),.write8_wen(retire8_enG),
  .read_thread(thread_reg),
  .write_thread(1'b0)
  );

  rrf #(SIMD_WIDTH,1) rrfAVH_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfAW_reg[0]),.read0_data(dataAVH[0]),.read0_oe(retAWF_reg[0]&rs_rAW_useF_reg[0]),
  .read1_addr(rs0i1_rA_reg2),.read1_data(dataAVH[1]),.read1_oe(retAF_reg[1]&rs_rA_useF_reg[1]),
  .read2_addr(rs0i2_rA_reg2),.read2_data(dataAVH[2]),.read2_oe(retAF_reg[2]&rs_rA_useF_reg[2]),
  .read3_addr(rrfAW_reg[1]),.read3_data(dataAVH[3]),.read3_oe(retAWF_reg[1]&rs_rAW_useF_reg[1]),
  .read4_addr(rs1i1_rA_reg2),.read4_data(dataAVH[4]),.read4_oe(retAF_reg[4]&rs_rA_useF_reg[4]),
  .read5_addr(rs1i2_rA_reg2),.read5_data(dataAVH[5]),.read5_oe(retAF_reg[5]&rs_rA_useF_reg[5]),
  .read6_addr(rrfAW_reg[2]),.read6_data(dataAVH[6]),.read6_oe(retAWF_reg[2]&rs_rAW_useF_reg[2]),
  .read7_addr(rs2i1_rA_reg2),.read7_data(dataAVH[7]),.read7_oe(retAF_reg[7]&rs_rA_useF_reg[7]),
  .read8_addr(rs2i2_rA_reg2),.read8_data(dataAVH[8]),.read8_oe(retAF_reg[8]&rs_rA_useF_reg[8]),
  .write0_addr(retire0_rT_reg),.write0_data(ret_dataAVH[0]),.write0_wen(retire0_enV_reg),
  .write1_addr(retire1_rT_reg),.write1_data(ret_dataAVH[1]),.write1_wen(retire1_enV_reg),
  .write2_addr(retire2_rT_reg),.write2_data(ret_dataAVH[2]),.write2_wen(retire2_enV_reg),
  .write3_addr(retire3_rT_reg),.write3_data(ret_dataAVH[3]),.write3_wen(retire3_enV_reg),
  .write4_addr(retire4_rT_reg),.write4_data(ret_dataAVH[4]),.write4_wen(retire4_enV_reg),
  .write5_addr(retire5_rT_reg),.write5_data(ret_dataAVH[5]),.write5_wen(retire5_enV_reg),
  .write6_addr(retire6_rT_reg),.write6_data(ret_dataAVH[6]),.write6_wen(retire6_enV_reg),
  .write7_addr(retire7_rT_reg),.write7_data(ret_dataAVH[7]),.write7_wen(retire7_enV_reg),
  .write8_addr(retire8_rT_reg),.write8_data(ret_dataAVH[8]),.write8_wen(retire8_enV_reg),
  .read_thread(thread_reg2),
  .write_thread(1'b0)
  );

  rrf #(SIMD_WIDTH,1) rrfAVL_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfAW_reg[0]),.read0_data(dataAVL[0]),.read0_oe(retAWF_reg[0]&rs_rAW_useF_reg[0]),
  .read1_addr(rs0i1_rA_reg2),.read1_data(dataAVL[1]),.read1_oe(retAF_reg[1]&rs_rA_useF_reg[1]),
  .read2_addr(rs0i2_rA_reg2),.read2_data(dataAVL[2]),.read2_oe(retAF_reg[2]&rs_rA_useF_reg[2]),
  .read3_addr(rrfAW_reg[1]),.read3_data(dataAVL[3]),.read3_oe(retAWF_reg[1]&rs_rAW_useF_reg[1]),
  .read4_addr(rs1i1_rA_reg2),.read4_data(dataAVL[4]),.read4_oe(retAF_reg[4]&rs_rA_useF_reg[4]),
  .read5_addr(rs1i2_rA_reg2),.read5_data(dataAVL[5]),.read5_oe(retAF_reg[5]&rs_rA_useF_reg[5]),
  .read6_addr(rrfAW_reg[2]),.read6_data(dataAVL[6]),.read6_oe(retAWF_reg[2]&rs_rAW_useF_reg[2]),
  .read7_addr(rs2i1_rA_reg2),.read7_data(dataAVL[7]),.read7_oe(retAF_reg[7]&rs_rA_useF_reg[7]),
  .read8_addr(rs2i2_rA_reg2),.read8_data(dataAVL[8]),.read8_oe(retAF_reg[8]&rs_rA_useF_reg[8]),
  .write0_addr(retire0_rT_reg),.write0_data(ret_dataAVL[0]),.write0_wen(retire0_enV_reg),
  .write1_addr(retire1_rT_reg),.write1_data(ret_dataAVL[1]),.write1_wen(retire1_enV_reg),
  .write2_addr(retire2_rT_reg),.write2_data(ret_dataAVL[2]),.write2_wen(retire2_enV_reg),
  .write3_addr(retire3_rT_reg),.write3_data(ret_dataAVL[3]),.write3_wen(retire3_enV_reg),
  .write4_addr(retire4_rT_reg),.write4_data(ret_dataAVL[4]),.write4_wen(retire4_enV_reg),
  .write5_addr(retire5_rT_reg),.write5_data(ret_dataAVL[5]),.write5_wen(retire5_enV_reg),
  .write6_addr(retire6_rT_reg),.write6_data(ret_dataAVL[6]),.write6_wen(retire6_enV_reg),
  .write7_addr(retire7_rT_reg),.write7_data(ret_dataAVL[7]),.write7_wen(retire7_enV_reg),
  .write8_addr(retire8_rT_reg),.write8_data(ret_dataAVL[8]),.write8_wen(retire8_enV_reg),
  .read_thread(thread_reg2),
  .write_thread(1'b0)
  );


  rrf #(SIMD_WIDTH,1) rrfAFH_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfAW_reg2[0]),.read0_data(dataAFH[0]),.read0_oe(retAWF_reg2[0]&rs_rAW_useF_reg2[0]),
  .read1_addr(rs0i1_rA_reg3),.read1_data(dataAFH[1]),.read1_oe(retAF_reg2[1]&rs_rA_useF_reg2[1]),
  .read2_addr(rs0i2_rA_reg3),.read2_data(dataAFH[2]),.read2_oe(retAF_reg2[2]&rs_rA_useF_reg2[2]),
  .read3_addr(rrfAW_reg2[1]),.read3_data(dataAFH[3]),.read3_oe(retAWF_reg2[1]&rs_rAW_useF_reg2[1]),
  .read4_addr(rs1i1_rA_reg3),.read4_data(dataAFH[4]),.read4_oe(retAF_reg2[4]&rs_rA_useF_reg2[4]),
  .read5_addr(rs1i2_rA_reg3),.read5_data(dataAFH[5]),.read5_oe(retAF_reg2[5]&rs_rA_useF_reg2[5]),
  .read6_addr(rrfAW_reg2[2]),.read6_data(dataAFH[6]),.read6_oe(retAWF_reg2[2]&rs_rAW_useF_reg2[2]),
  .read7_addr(rs2i1_rA_reg3),.read7_data(dataAFH[7]),.read7_oe(retAF_reg2[7]&rs_rA_useF_reg2[7]),
  .read8_addr(rs2i2_rA_reg3),.read8_data(dataAFH[8]),.read8_oe(retAF_reg2[8]&rs_rA_useF_reg2[8]),
  .write0_addr(retire0_rT_reg2),.write0_data(ret_dataAFH[0]),.write0_wen(retire0_enF_reg2),
  .write1_addr(retire1_rT_reg2),.write1_data(ret_dataAFH[1]),.write1_wen(retire1_enF_reg2),
  .write2_addr(retire2_rT_reg2),.write2_data(ret_dataAFH[2]),.write2_wen(retire2_enF_reg2),
  .write3_addr(retire3_rT_reg2),.write3_data(ret_dataAFH[3]),.write3_wen(retire3_enF_reg2),
  .write4_addr(retire4_rT_reg2),.write4_data(ret_dataAFH[4]),.write4_wen(retire4_enF_reg2),
  .write5_addr(retire5_rT_reg2),.write5_data(ret_dataAFH[5]),.write5_wen(retire5_enF_reg2),
  .write6_addr(retire6_rT_reg2),.write6_data(ret_dataAFH[6]),.write6_wen(retire6_enF_reg2),
  .write7_addr(retire7_rT_reg2),.write7_data(ret_dataAFH[7]),.write7_wen(retire7_enF_reg2),
  .write8_addr(retire8_rT_reg2),.write8_data(ret_dataAFH[8]),.write8_wen(retire8_enF_reg2),
  .read_thread(thread_reg3),
  .write_thread(1'b0)
  );

  rrf #(16+SIMD_WIDTH,1) rrfAFL_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfAW_reg2[0]),.read0_data(dataAFL[0]),.read0_oe(retAWF_reg2[0]&rs_rAW_useF_reg2[0]),
  .read1_addr(rs0i1_rA_reg3),.read1_data(dataAFL[1]),.read1_oe(retAF_reg2[1]&rs_rA_useF_reg2[1]),
  .read2_addr(rs0i2_rA_reg3),.read2_data(dataAFL[2]),.read2_oe(retAF_reg2[2]&rs_rA_useF_reg2[2]),
  .read3_addr(rrfAW_reg2[1]),.read3_data(dataAFL[3]),.read3_oe(retAWF_reg2[1]&rs_rAW_useF_reg2[1]),
  .read4_addr(rs1i1_rA_reg3),.read4_data(dataAFL[4]),.read4_oe(retAF_reg2[4]&rs_rA_useF_reg2[4]),
  .read5_addr(rs1i2_rA_reg3),.read5_data(dataAFL[5]),.read5_oe(retAF_reg2[5]&rs_rA_useF_reg2[5]),
  .read6_addr(rrfAW_reg2[2]),.read6_data(dataAFL[6]),.read6_oe(retAWF_reg2[2]&rs_rAW_useF_reg2[2]),
  .read7_addr(rs2i1_rA_reg3),.read7_data(dataAFL[7]),.read7_oe(retAF_reg2[7]&rs_rA_useF_reg2[7]),
  .read8_addr(rs2i2_rA_reg3),.read8_data(dataAFL[8]),.read8_oe(retAF_reg2[8]&rs_rA_useF_reg2[8]),
  .write0_addr(retire0_rT_reg2),.write0_data(ret_dataAFL[0]),.write0_wen(retire0_enF_reg2),
  .write1_addr(retire1_rT_reg2),.write1_data(ret_dataAFL[1]),.write1_wen(retire1_enF_reg2),
  .write2_addr(retire2_rT_reg2),.write2_data(ret_dataAFL[2]),.write2_wen(retire2_enF_reg2),
  .write3_addr(retire3_rT_reg2),.write3_data(ret_dataAFL[3]),.write3_wen(retire3_enF_reg2),
  .write4_addr(retire4_rT_reg2),.write4_data(ret_dataAFL[4]),.write4_wen(retire4_enF_reg2),
  .write5_addr(retire5_rT_reg2),.write5_data(ret_dataAFL[5]),.write5_wen(retire5_enF_reg2),
  .write6_addr(retire6_rT_reg2),.write6_data(ret_dataAFL[6]),.write6_wen(retire6_enF_reg2),
  .write7_addr(retire7_rT_reg2),.write7_data(ret_dataAFL[7]),.write7_wen(retire7_enF_reg2),
  .write8_addr(retire8_rT_reg2),.write8_data(ret_dataAFL[8]),.write8_wen(retire8_enF_reg2),
  .read_thread(thread_reg3),
  .write_thread(1'b0)
  );

  rrf rrfB_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfBW[0]),.read0_data(dataB[0]),
    .read0_oe(retBW[0]&~useBConstW[0]&rs_rBW_use[0]),
  .read1_addr(rs0i1_rB_reg),.read1_data(dataB[1]),
    .read1_oe(retB[1]&~rs0i1_useBConst_reg&rs_rB_use[1]),
  .read2_addr(rs0i2_rB_reg),.read2_data(dataB[2]),
    .read2_oe(retB[2]&~rs0i2_useBConst_reg&rs_rB_use[2]),
  .read3_addr(rrfBW[1]),.read3_data(dataB[3]),
    .read3_oe(retBW[1]&~useBConstW[1]&rs_rBW_use[1]),
  .read4_addr(rs1i1_rB_reg),.read4_data(dataB[4]),
    .read4_oe(retB[4]&~rs1i1_useBConst_reg&rs_rB_use[4]),
  .read5_addr(rs1i2_rB_reg),.read5_data(dataB[5]),
    .read5_oe(retB[5]&~rs1i2_useBConst_reg&rs_rB_use[5]),
  .read6_addr(rrfBW[2]),.read6_data(dataB[6]),
    .read6_oe(retBW[2]&~useBConstW[2]&rs_rBW_use[2]),
  .read7_addr(rs2i1_rB_reg),.read7_data(dataB[7]),
    .read7_oe(retB[7]&~rs2i1_useBConst_reg&rs_rB_use[7]),
  .read8_addr(rs2i2_rB_reg),.read8_data(dataB[8]),
    .read8_oe(retB[8]&~rs2i2_useBConst_reg&rs_rB_use[8]),
  .write0_addr(retire0_rT),.write0_data(ret_dataB[0]),.write0_wen(retire0_enG),
  .write1_addr(retire1_rT),.write1_data(ret_dataB[1]),.write1_wen(retire1_enG),
  .write2_addr(retire2_rT),.write2_data(ret_dataB[2]),.write2_wen(retire2_enG),
  .write3_addr(retire3_rT),.write3_data(ret_dataB[3]),.write3_wen(retire3_enG),
  .write4_addr(retire4_rT),.write4_data(ret_dataB[4]),.write4_wen(retire4_enG),
  .write5_addr(retire5_rT),.write5_data(ret_dataB[5]),.write5_wen(retire5_enG),
  .write6_addr(retire6_rT),.write6_data(ret_dataB[6]),.write6_wen(retire6_enG),
  .write7_addr(retire7_rT),.write7_data(ret_dataB[7]),.write7_wen(retire7_enG),
  .write8_addr(retire8_rT),.write8_data(ret_dataB[8]),.write8_wen(retire8_enG),
  .read_thread(thread_reg),
  .write_thread(1'b0)
  );


  rrf #(SIMD_WIDTH,1) rrfBVH_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfBW_reg[0]),.read0_data(dataBVH[0]),.read0_oe(retBFW_reg[0]&rs_rBW_useF_reg[0]),
  .read1_addr(rs0i1_rB_reg2),.read1_data(dataBVH[1]),.read1_oe(retBF_reg[1]&rs_rB_useF_reg[1]),
  .read2_addr(rs0i2_rB_reg2),.read2_data(dataBVH[2]),.read2_oe(retBF_reg[2]&rs_rB_useF_reg[2]),
  .read3_addr(rrfBW_reg[1]),.read3_data(dataBVH[3]),.read3_oe(retBFW_reg[1]&rs_rBW_useF_reg[1]),
  .read4_addr(rs1i1_rB_reg2),.read4_data(dataBVH[4]),.read4_oe(retBF_reg[4]&rs_rB_useF_reg[4]),
  .read5_addr(rs1i2_rB_reg2),.read5_data(dataBVH[5]),.read5_oe(retBF_reg[5]&rs_rB_useF_reg[5]),
  .read6_addr(rrfBW_reg[2]),.read6_data(dataBVH[6]),.read6_oe(retBFW_reg[2]&rs_rBW_useF_reg[2]),
  .read7_addr(rs2i1_rB_reg2),.read7_data(dataBVH[7]),.read7_oe(retBF_reg[7]&rs_rB_useF_reg[7]),
  .read8_addr(rs2i2_rB_reg2),.read8_data(dataBVH[8]),.read8_oe(retBF_reg[8]&rs_rB_useF_reg[8]),
  .write0_addr(retire0_rT_reg),.write0_data(ret_dataBVH[0]),.write0_wen(retire0_enV_reg),
  .write1_addr(retire1_rT_reg),.write1_data(ret_dataBVH[1]),.write1_wen(retire1_enV_reg),
  .write2_addr(retire2_rT_reg),.write2_data(ret_dataBVH[2]),.write2_wen(retire2_enV_reg),
  .write3_addr(retire3_rT_reg),.write3_data(ret_dataBVH[3]),.write3_wen(retire3_enV_reg),
  .write4_addr(retire4_rT_reg),.write4_data(ret_dataBVH[4]),.write4_wen(retire4_enV_reg),
  .write5_addr(retire5_rT_reg),.write5_data(ret_dataBVH[5]),.write5_wen(retire5_enV_reg),
  .write6_addr(retire6_rT_reg),.write6_data(ret_dataBVH[6]),.write6_wen(retire6_enV_reg),
  .write7_addr(retire7_rT_reg),.write7_data(ret_dataBVH[7]),.write7_wen(retire7_enV_reg),
  .write8_addr(retire8_rT_reg),.write8_data(ret_dataBVH[8]),.write8_wen(retire8_enV_reg),
  .read_thread(thread_reg2),
  .write_thread(1'b0)
  );

  rrf #(SIMD_WIDTH,1) rrfBVL_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfBW_reg[0]),.read0_data(dataBVL[0]),.read0_oe(retBFW_reg[0]&rs_rBW_useF_reg[0]),
  .read1_addr(rs0i1_rB_reg2),.read1_data(dataBVL[1]),.read1_oe(retBF_reg[1]&rs_rB_useF_reg[1]),
  .read2_addr(rs0i2_rB_reg2),.read2_data(dataBVL[2]),.read2_oe(retBF_reg[2]&rs_rB_useF_reg[2]),
  .read3_addr(rrfBW_reg[1]),.read3_data(dataBVL[3]),.read3_oe(retBFW_reg[1]&rs_rBW_useF_reg[1]),
  .read4_addr(rs1i1_rB_reg2),.read4_data(dataBVL[4]),.read4_oe(retBF_reg[4]&rs_rB_useF_reg[4]),
  .read5_addr(rs1i2_rB_reg2),.read5_data(dataBVL[5]),.read5_oe(retBF_reg[5]&rs_rB_useF_reg[5]),
  .read6_addr(rrfBW_reg[2]),.read6_data(dataBVL[6]),.read6_oe(retBFW_reg[2]&rs_rBW_useF_reg[2]),
  .read7_addr(rs2i1_rB_reg2),.read7_data(dataBVL[7]),.read7_oe(retBF_reg[7]&rs_rB_useF_reg[7]),
  .read8_addr(rs2i2_rB_reg2),.read8_data(dataBVL[8]),.read8_oe(retBF_reg[8]&rs_rB_useF_reg[8]),
  .write0_addr(retire0_rT_reg),.write0_data(ret_dataBVL[0]),.write0_wen(retire0_enV_reg),
  .write1_addr(retire1_rT_reg),.write1_data(ret_dataBVL[1]),.write1_wen(retire1_enV_reg),
  .write2_addr(retire2_rT_reg),.write2_data(ret_dataBVL[2]),.write2_wen(retire2_enV_reg),
  .write3_addr(retire3_rT_reg),.write3_data(ret_dataBVL[3]),.write3_wen(retire3_enV_reg),
  .write4_addr(retire4_rT_reg),.write4_data(ret_dataBVL[4]),.write4_wen(retire4_enV_reg),
  .write5_addr(retire5_rT_reg),.write5_data(ret_dataBVL[5]),.write5_wen(retire5_enV_reg),
  .write6_addr(retire6_rT_reg),.write6_data(ret_dataBVL[6]),.write6_wen(retire6_enV_reg),
  .write7_addr(retire7_rT_reg),.write7_data(ret_dataBVL[7]),.write7_wen(retire7_enV_reg),
  .write8_addr(retire8_rT_reg),.write8_data(ret_dataBVL[8]),.write8_wen(retire8_enV_reg),
  .read_thread(thread_reg2),
  .write_thread(1'b0)
  );


  rrf #(SIMD_WIDTH,1) rrfBFH_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfBW_reg2[0]),.read0_data(dataBFH[0]),.read0_oe(retBFW_reg2[0]&rs_rBW_useF_reg2[0]),
  .read1_addr(rs0i1_rB_reg3),.read1_data(dataBFH[1]),.read1_oe(retBF_reg2[1]&rs_rB_useF_reg2[1]),
  .read2_addr(rs0i2_rB_reg3),.read2_data(dataBFH[2]),.read2_oe(retBF_reg2[2]&rs_rB_useF_reg2[2]),
  .read3_addr(rrfBW_reg2[1]),.read3_data(dataBFH[3]),.read3_oe(retBFW_reg2[1]&rs_rBW_useF_reg2[1]),
  .read4_addr(rs1i1_rB_reg3),.read4_data(dataBFH[4]),.read4_oe(retBF_reg2[4]&rs_rB_useF_reg2[4]),
  .read5_addr(rs1i2_rB_reg3),.read5_data(dataBFH[5]),.read5_oe(retBF_reg2[5]&rs_rB_useF_reg2[5]),
  .read6_addr(rrfBW_reg2[2]),.read6_data(dataBFH[6]),.read6_oe(retBFW_reg2[2]&rs_rBW_useF_reg2[2]),
  .read7_addr(rs2i1_rB_reg3),.read7_data(dataBFH[7]),.read7_oe(retBF_reg2[7]&rs_rB_useF_reg2[7]),
  .read8_addr(rs2i2_rB_reg3),.read8_data(dataBFH[8]),.read8_oe(retBF_reg2[8]&rs_rB_useF_reg2[8]),
  .write0_addr(retire0_rT_reg2),.write0_data(ret_dataBFH[0]),.write0_wen(retire0_enF_reg2),
  .write1_addr(retire1_rT_reg2),.write1_data(ret_dataBFH[1]),.write1_wen(retire1_enF_reg2),
  .write2_addr(retire2_rT_reg2),.write2_data(ret_dataBFH[2]),.write2_wen(retire2_enF_reg2),
  .write3_addr(retire3_rT_reg2),.write3_data(ret_dataBFH[3]),.write3_wen(retire3_enF_reg2),
  .write4_addr(retire4_rT_reg2),.write4_data(ret_dataBFH[4]),.write4_wen(retire4_enF_reg2),
  .write5_addr(retire5_rT_reg2),.write5_data(ret_dataBFH[5]),.write5_wen(retire5_enF_reg2),
  .write6_addr(retire6_rT_reg2),.write6_data(ret_dataBFH[6]),.write6_wen(retire6_enF_reg2),
  .write7_addr(retire7_rT_reg2),.write7_data(ret_dataBFH[7]),.write7_wen(retire7_enF_reg2),
  .write8_addr(retire8_rT_reg2),.write8_data(ret_dataBFH[8]),.write8_wen(retire8_enF_reg2),
  .read_thread(thread_reg3),
  .write_thread(1'b0)
  );

  rrf #(16+SIMD_WIDTH,1) rrfBFL_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_addr(rrfBW_reg2[0]),.read0_data(dataBFL[0]),.read0_oe(retBFW_reg2[0]&rs_rBW_useF_reg2[0]),
  .read1_addr(rs0i1_rB_reg3),.read1_data(dataBFL[1]),.read1_oe(retBF_reg2[1]&rs_rB_useF_reg2[1]),
  .read2_addr(rs0i2_rB_reg3),.read2_data(dataBFL[2]),.read2_oe(retBF_reg2[2]&rs_rB_useF_reg2[2]),
  .read3_addr(rrfBW_reg2[1]),.read3_data(dataBFL[3]),.read3_oe(retBFW_reg2[1]&rs_rBW_useF_reg2[1]),
  .read4_addr(rs1i1_rB_reg3),.read4_data(dataBFL[4]),.read4_oe(retBF_reg2[4]&rs_rB_useF_reg2[4]),
  .read5_addr(rs1i2_rB_reg3),.read5_data(dataBFL[5]),.read5_oe(retBF_reg2[5]&rs_rB_useF_reg2[5]),
  .read6_addr(rrfBW_reg2[2]),.read6_data(dataBFL[6]),.read6_oe(retBFW_reg2[2]&rs_rBW_useF_reg2[2]),
  .read7_addr(rs2i1_rB_reg3),.read7_data(dataBFL[7]),.read7_oe(retBF_reg2[7]&rs_rB_useF_reg2[7]),
  .read8_addr(rs2i2_rB_reg3),.read8_data(dataBFL[8]),.read8_oe(retBF_reg2[8]&rs_rB_useF_reg2[8]),
  .write0_addr(retire0_rT_reg2),.write0_data(ret_dataBFL[0]),.write0_wen(retire0_enF_reg2),
  .write1_addr(retire1_rT_reg2),.write1_data(ret_dataBFL[1]),.write1_wen(retire1_enF_reg2),
  .write2_addr(retire2_rT_reg2),.write2_data(ret_dataBFL[2]),.write2_wen(retire2_enF_reg2),
  .write3_addr(retire3_rT_reg2),.write3_data(ret_dataBFL[3]),.write3_wen(retire3_enF_reg2),
  .write4_addr(retire4_rT_reg2),.write4_data(ret_dataBFL[4]),.write4_wen(retire4_enF_reg2),
  .write5_addr(retire5_rT_reg2),.write5_data(ret_dataBFL[5]),.write5_wen(retire5_enF_reg2),
  .write6_addr(retire6_rT_reg2),.write6_data(ret_dataBFL[6]),.write6_wen(retire6_enF_reg2),
  .write7_addr(retire7_rT_reg2),.write7_data(ret_dataBFL[7]),.write7_wen(retire7_enF_reg2),
  .write8_addr(retire8_rT_reg2),.write8_data(ret_dataBFL[8]),.write8_wen(retire8_enF_reg2),
  .read_thread(thread_reg3),
  .write_thread(1'b0)
  );


  regfileFl regS_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .retire_clkEn(1'b0),

  .read0_addr(regFl),.read0_data({inflS,dataS}),.read0_oe(~retFl),.read0_gazump(gazumpS),

  .retireRead0_addr(retfl_rF),.retireRead0_data(retfl_data),

  .write0_addr_reg(FUreg_reg2[4]),.write0_data_reg(FUS4_reg),.write0_wen_reg(FUwen_reg2[4] && ex_alu[0][2] ),
  .write1_addr_reg(FUreg_reg2[5]),.write1_data_reg(FUS5_reg),.write1_wen_reg(FUwen_reg2[5] && ex_alu[1][2] ),
  .write2_addr_reg(FUreg_reg2[6]),.write2_data_reg(FUS6_reg),.write2_wen_reg(FUwen_reg2[6] && ex_alu[2][2] ),
  .write3_addr_reg(FUreg_reg2[7]),.write3_data_reg(FUS7_reg),.write3_wen_reg(FUwen_reg2[7] && ex_alu[3][2]),
  .write4_addr_reg(FUreg_reg2[8]),.write4_data_reg(FUS8_reg),.write4_wen_reg(FUwen_reg2[8] && ex_alu[4][2]),
  .write5_addr_reg(FUreg_reg2[9]),.write5_data_reg(FUS9_reg),.write5_wen_reg(FUwen_reg2[9] && ex_alu[5][2] ),
  .write6_addr_reg(FUreg_reg5[4]),.write6_data_reg(FOOS_reg2[0]),.write6_wen_reg(FUwen_reg5[4] && gxFADD_en_reg2[0]),
  .write7_addr_reg(FUreg_reg5[5]),.write7_data_reg(FOOS_reg2[1]),.write7_wen_reg(FUwen_reg5[5] && gxFADD_en_reg2[1]),
  .write8_addr_reg(FUreg_reg5[6]),.write8_data_reg(FOOS_reg2[2]),.write8_wen_reg(FUwen_reg5[6] && gxFADD_en_reg2[2]),
  .newAddr0(clrR_reg[0][8:4]),.newEn0(clrS_reg[0]),
  .newAddr1(clrR_reg[1][8:4]),.newEn1(clrS_reg[1]),
  .newAddr2(clrR_reg[2][8:4]),.newEn2(clrS_reg[2]),
  .newAddr3(clrR_reg[3][8:4]),.newEn3(clrS_reg[3]),
  .newAddr4(clrR_reg[4][8:4]),.newEn4(clrS_reg[4]),
  .newAddr5(clrR_reg[5][8:4]),.newEn5(clrS_reg[5]),
  .newAddr6(clrR_reg[6][8:4]),.newEn6(clrS_reg[6]),
  .newAddr7(clrR_reg[7][8:4]),.newEn7(clrS_reg[7]),
  .newAddr8(clrR_reg[8][8:4]),.newEn8(clrS_reg[8])
  );
  
  rrf_flag ffrS_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(~doStall),
  .read0_data({inflS,dataS}),.read0_oe(retFl),
  .write0_data(retfl_data),.write0_wen(retfl_enG),
  .read_thread(thread_reg),
  .write_thread(1'b0)
  );
  
  get_flag_infl flag_in_flight_mod(
  .rs0i1_flagDep(rs0i1_flagDep_reg2),
  .rs0i2_flagDep(rs0i2_flagDep_reg2),
  .rs1i1_flagDep(rs1i1_flagDep_reg2),
  .rs1i2_flagDep(rs1i2_flagDep_reg2),
  .rs2i1_flagDep(rs2i1_flagDep_reg2),
  .rs2i2_flagDep(rs2i2_flagDep_reg2),
  .srcFlight(inflS),
  .infl(Sinfl)
  );
  
  
  generate
  
  genvar m,n,u;//,o
  for (m=0;m<3;m=m+1) begin : main_rs_gen
  rs rs0_mod(
  .clk(clk),
  .dataRst(rst),.nonDataRst(except|rst),.rst_thread(excpt_thread),
  .stall(stall_rs[m]),
  .doStall(doStall_rs[m]),
  .FU0Hit(FU0Hit),.FU1Hit(FU1Hit),.FU2Hit(FU2Hit),.FU3Hit(FU3Hit),
  .new_thread(thread_reg2),
// wires to store new values in a buffer
  .newDataA0(dataA[3*m+0]),.newDataB0(dataB[3*m+0]),.newDataC0(rs_const_reg[3*m+0][32:0]&{33{~rs_useBConst_reg[3*m+0]}}),
    .newRegA0(regA_reg[3*m+0]|{9{~inflA[3*m+0]&~depA_reg[3*m+0]}}),
    .newRegB0(regB_reg[3*m+0]|{9{~inflB[3*m+0]&~depB_reg[3*m+0]}}),
    .newANeeded0(inflA[3*m+0]|depA_reg[3*m+0]),.newBNeeded0(inflB[3*m+0]|depB_reg[3*m+0]),.newReg0(newR_reg[3*m+0]),
    .newOp0(rs_operation_reg[3*m+0]),.newPort0(rs_port_sch[3*m+0]),.newInstrIndex0({II_upper,rs_index_reg[3*m+0]}),.newLSQ0({LSQ_upper,rs_lsi_reg[m+0]}),
    .rsAlloc0(rs_en_reg[3*m+0]&~rs_alt_reg[m]),.newGazumpA0(gazumpA[3*m+0]),.newGazumpB0(gazumpB[3*m+0]),
    .newFunitA0(funA_reg[3*m+0]),.newFunitB0(funB_reg[3*m+0]),.newWQ0(WQR_reg[m]),.newLSFlag0(rs_ldst_flg_reg[2*m]),
    .newAttr0(newAttr_reg2),
  .newDataA1(dataA[3*m+1]),.newDataB1(dataB[3*m+1]),.newDataC1(rs_const_reg[3*m+1][32:0]&{33{~rs_useBConst_reg[3*m+1]}}),.newDataS1(dataS),
    .newRegA1(regA_reg[3*m+1]|{9{~inflA[3*m+1]&~depA_reg[3*m+1]}}),
    .newRegB1(regB_reg[3*m+1]|{9{~inflB[3*m+1]&~depB_reg[3*m+1]}}),
    .newRegS1(regS_reg[3*m+1]|{REG_WIDTH{~Sinfl[3*m+1]}}),
    .newANeeded1(inflA[3*m+1]|depA_reg[3*m+1]),.newBNeeded1(inflB[3*m+1]|depB_reg[3*m+1]),.newSNeeded1(Sinfl[3*m+1]),
    .newReg1(newR_reg[3*m+1]),.newRegSimd1(9'b0),
    .newOp1(rs_operation_reg[3*m+1]),.newPort1(rs_port_sch[3*m+1]),.newInstrIndex1({II_upper,rs_index_reg[3*m+1]}),.newLSQ1({LSQ_upper,rs_lsi_reg[m+3]}),
    .rsAlloc1(rs_en_reg[3*m+1]),.newGazumpA1(gazumpA[3*m+1]),.newGazumpB1(gazumpB[3*m+1]),.newGazumpS1(gazumpS),
    .newFunitA1(funA_reg[3*m+1]),.newFunitB1(funB_reg[3*m+1]),.newFunitS1(funS_reg[3*m+1]),.newLSFlag1(rs_ldst_flg_reg[2*m+1]),
    .newAttr1(newAttr_reg2),
  .newDataA2(dataA[3*m+2]),.newDataB2(dataB[3*m+2]),.newDataS2(dataS),
    .newRegA2(regA_reg[3*m+2]|{9{~inflA[3*m+2]&~depA_reg[3*m+2]}}),
    .newRegB2(regB_reg[3*m+2]|{9{~inflB[3*m+2]&~depB_reg[3*m+2]}}),
    .newRegS2(regS_reg[3*m+2]|{REG_WIDTH{~Sinfl[3*m+2]}}),
    .newANeeded2(inflA[3*m+2]|depA_reg[3*m+2]),.newBNeeded2(inflB[3*m+2]|depB_reg[3*m+2]),.newSNeeded2(Sinfl[3*m+2]),.newReg2(newR_reg[3*m+2]),.newRegSimd2(9'b0),
    .newOp2(rs_operation_reg[3*m+2]),.newPort2(rs_port_sch[3*m+2]),.newInstrIndex2({II_upper,rs_index_reg[3*m+2]}),
    .rsAlloc2(rs_en_reg[3*m+2]),.newGazumpA2(gazumpA[3*m+2]),.newGazumpB2(gazumpB[3*m+2]),.newGazumpS2(gazumpS),
    .newFunitA2(funA_reg[3*m+2]),.newFunitB2(funB_reg[3*m+2]),.newFunitS2(funS_reg[3*m+2]),
    .newAttr2(newAttr_reg2),
// wires to get values out of buffer
  .outDataA0(outDataA[3*m+0]),.outDataB0(outDataB[3*m+0]),.outDataC0(outDataC[m]),.outReg0(outReg[3*m+0]),
    .outOp0(outOp[3*m+0]),.outInstrIndex0(outII[3*m+0]), .outFuFwdA0(fuFwdA[3*m+0]),.outFuFwdB0(fuFwdB[3*m+0]),
    .outFuuFwdA0(fuuFwdA[3*m+0]),.outFuuFwdB0(fuuFwdB[3*m+0]),.outLSQ0(outLSQ[m]),.outDataEn0(outEn[3*m+0]),
    .outThread0(outThr[3*m+0]),.outWQ0(outWQ[m]),.outLSFlag0(outLSflag[m]),
    .outAttr0(outAttr[3*m+0]),//agu
  .outDataA1(outDataA[3*m+1]),.outDataB1(outDataB[3*m+1]),.outDataS1(outDataS[3*m+1]),.outReg1(outReg[3*m+1]),
    .outRegSimd1(),.outOp1(outOp[3*m+1]),.outInstrIndex1(outII[3*m+1]),
    .outFuFwdA1(fuFwdA[3*m+1]),.outFuFwdB1(fuFwdB[3*m+1]),.outFuFwdS1(fuFwdS[3*m+1]),
    .outFuuFwdA1(fuuFwdA[3*m+1]),.outFuuFwdB1(fuuFwdB[3*m+1]),.outFuuFwdS1(fuuFwdS[3*m+1]),
    .outDataEn1(outEn[3*m+1]),
    .outThread1(outThr[3*m+1]),
    .outAttr1(outAttr[3*m+1]),//alu 1
  .outDataA2(outDataA[3*m+2]),.outDataB2(outDataB[3*m+2]),.outDataS2(outDataS[3*m+2]),.outReg2(outReg[3*m+2]),
    .outRegSimd2(),.outOp2(outOp[3*m+2]),.outInstrIndex2(outII[3*m+2]),.outFuFwdA2(fuFwdA[3*m+2]),
    .outFuFwdB2(fuFwdB[3*m+2]),.outFuFwdS2(fuFwdS[3*m+2]),.outFuuFwdA2(fuuFwdA[3*m+2]),
    .outFuuFwdB2(fuuFwdB[3*m+2]),.outFuuFwdS2(fuuFwdS[3*m+2]),.outDataEn2(outEn[3*m+2]),
    .outThread2(outThr[3*m+2]),
    .outAttr2(outAttr[3*m+2]),//alu 2
// wires from functional units  
  .FU0(FU_reg[0]),.FUreg0(FUreg[0]),.FUwen0(FUwen[0]),
  .FU1(FU_reg[1]),.FUreg1(FUreg[1]),.FUwen1(FUwen[1]),
  .FU2(FU_reg[2]),.FUreg2(FUreg[2]),.FUwen2(FUwen[2]),
  .FU3(FU_reg[3]),.FUreg3(FUreg[3]),.FUwen3(FUwen[3]),
  .FU4(FU_reg[4]),.FUreg4(FUreg[4]),.FUwen4(FUwen[4]),
  .FU5(FU_reg[5]),.FUreg5(FUreg[5]),.FUwen5(FUwen[5]),
  .FU6(FU_reg[6]),.FUreg6(FUreg[6]),.FUwen6(FUwen[6]),
  .FU7(FU_reg[7]),.FUreg7(FUreg[7]),.FUwen7(FUwen[7]),
  .FU8(FU_reg[8]),.FUreg8(FUreg[8]),.FUwen8(FUwen[8]),
  .FU9(FU_reg[9]),.FUreg9(FUreg[9]),.FUwen9(FUwen[9]),
  
  .newDataVA1H(dataAVH[3*m+1]),.newDataVB1H(dataBVH[3*m+1]),.newDataVA1L(dataAVL[3*m+1]),.newDataVB1L(dataBVL[3*m+1]),
  .newDataFA1H(dataAFH[3*m+1]),.newDataFB1H(dataBFH[3*m+1]),.newDataFA1L(dataAFL[3*m+1]),.newDataFB1L(dataBFL[3*m+1]),
  .newDataVA2H(dataAVH[3*m+2]),.newDataVB2H(dataBVH[3*m+2]),.newDataVA2L(dataAVL[3*m+2]),.newDataVB2L(dataBVL[3*m+2]),
  .newDataFA2H(dataAFH[3*m+2]),.newDataFB2H(dataBFH[3*m+2]),.newDataFA2L(dataAFL[3*m+2]),.newDataFB2L(dataBFL[3*m+2]),

  .outDataVA1H(outDataAVH[2*m+0]),.outDataVB1H(outDataBVH[2*m+0]),.outDataVA1L(outDataAVL[2*m+0]),.outDataVB1L(outDataBVL[2*m+0]),
  .outDataFA1H(outDataAFH[2*m+0]),.outDataFB1H(outDataBFH[2*m+0]),.outDataFA1L(outDataAFL[2*m+0]),.outDataFB1L(outDataBFL[2*m+0]),
  .outDataVA2H(outDataAVH[2*m+1]),.outDataVB2H(outDataBVH[2*m+1]),.outDataVA2L(outDataAVL[2*m+1]),.outDataVB2L(outDataBVL[2*m+1]),
  .outDataFA2H(outDataAFH[2*m+1]),.outDataFB2H(outDataBFH[2*m+1]),.outDataFA2L(outDataAFL[2*m+1]),.outDataFB2L(outDataBFL[2*m+1]),

  .FUV0H(FUVH_reg[0]),.FUV0L(FUVL_reg[0]),.FUF0H(FUFH_reg[0]),.FUF0L(FUFL_reg[0]),
  .FUV1H(FUVH_reg[1]),.FUV1L(FUVL_reg[1]),.FUF1H(FUFH_reg[1]),.FUF1L(FUFL_reg[1]),
  .FUV2H(FUVH_reg[2]),.FUV2L(FUVL_reg[2]),.FUF2H(FUFH_reg[2]),.FUF2L(FUFL_reg[2]),
  .FUV3H(FUVH_reg[3]),.FUV3L(FUVL_reg[3]),.FUF3H(FUFH_reg[3]),.FUF3L(FUFL_reg[3]),
  .FUV4H(FUVH_reg[4]),.FUV4L(FUVL_reg[4]),.FUF4H(FUFH_reg[4]),.FUF4L(FUFL_reg[4]),
  .FUV5H(FUVH_reg[5]),.FUV5L(FUVL_reg[5]),.FUF5H(FUFH_reg[5]),.FUF5L(FUFL_reg[5]),
  .FUV6H(FUVH_reg[6]),.FUV6L(FUVL_reg[6]),.FUF6H(FUFH_reg[6]),.FUF6L(FUFL_reg[6]),
  .FUV7H(FUVH_reg[7]),.FUV7L(FUVL_reg[7]),.FUF7H(FUFH_reg[7]),.FUF7L(FUFL_reg[7]),
  .FUV8H(FUVH_reg[8]),.FUV8L(FUVL_reg[8]),.FUF8H(FUFH_reg[8]),.FUF8L(FUFL_reg[8]),
  .FUV9H(FUVH_reg[9]),.FUV9L(FUVL_reg[9]),.FUF9H(FUFH_reg[9]),.FUF9L(FUFL_reg[9]),

  .FUS0(FUS1_reg),
  .FUS1(FUS2_reg),
  .FUS2(FUS3_reg),
  .FUS3(FUS4_reg),
  .FUS4(FUS5_reg),
  .FUS5(FUS6_reg),
  .FUS6(FUS7_reg),
  .FUS7(FUS8_reg),
  .FUS8(FUS9_reg),
// 1 if buffer is free  
  .pause0(pause_agu|miss_pause_agu|bus_holds_agu),
  .foundAlt1(~(&nDataAlt[m])|(|fxFRT_alten[m])),.foundAlt2(fxFRT_pause[m]|(|fxFRT_alten_reg3[m]))
  );
  
  



  
//  rs_save #(1) saveAlt1_mod(
//  .clk(clk),.rst(rst),
//  .oldData(outOp[8][11]&&outOp[8][7:3]==4'hf),.newData(fxAlt1),
//  .save(1'b0),.en(outEn[8][0])
//  );

  
 

//  assign FOOS[m]=gxFADD_hi[m] ? FOOSH[m] : FOOSL[m];


  assign WfunA[m]=Wswp_reg[m] ? funB_reg[3*m] : funA_reg[3*m];
  assign WfunB[m]=Wswp_reg[m] ? funA_reg[3*m] : funB_reg[3*m];
  
  
  assign WinflA[m]=inflA[3*m]|depA_reg[3*m];
  assign WinflB[m]=inflB[3*m]|depB_reg[3*m];
  
  assign WregA[m]=regAW_reg[m]|{9{~inflA[3*m]&~depA_reg[3*m]}};
  assign WregB[m]=regBW_reg[m]|{9{~inflB[3*m]&~depB_reg[3*m]}};

  assign regAW[m]=Wswp[m] ? regB[3*m] : regA[3*m];
  assign regBW[m]=Wswp[m] ? regA[3*m] : regB[3*m];
  assign regAWF[m]=Wswp[m] ? regBF[3*m] : regAF[3*m];
  assign regBFW[m]=Wswp[m] ? regAF[3*m] : regBF[3*m];
  assign retAW[m]=Wswp[m] ? retB[3*m] : retA[3*m];
  assign retBW[m]=Wswp[m] ? retA[3*m] : retB[3*m];
  assign retAWF[m]=Wswp[m] ? retBF[3*m] : retAF[3*m];
  assign retBFW[m]=Wswp[m] ? retAF[3*m] : retBF[3*m];
  assign isBFW[m]=Wswp[m] ? isAF[3*m] : isBF[3*m];
  assign isAWF[m]=(~Wswp[m]) ? isAF[3*m] : isBF[3*m];
  assign isBVW[m]=Wswp[m] ? isAV[3*m] : isBV[3*m];
  assign isAWV[m]=(~Wswp[m]) ? isAV[3*m] : isBV[3*m];
  assign rs_rAW_use[m]=(~Wswp[m]) ? rs_rA_use[3*m] : rs_rB_use[3*m];
  assign rs_rBW_use[m]=Wswp[m] ? rs_rA_use[3*m] : rs_rB_use[3*m];
  assign rs_rAW_useF[m]=(~Wswp[m]) ? rs_rA_useF[3*m] : rs_rB_useF[3*m];
  assign rs_rBW_useF[m]=Wswp[m] ? rs_rA_useF[3*m] : rs_rB_useF[3*m];
  assign useBConstW[m]=~Wswp[m] & rs_useBConst[3*m];
  assign useAConstW[m]=Wswp[m] & rs_useBConst[3*m];
  assign rs_enAW[m]=(~Wswp[m]) ? rs_enA[m] : rs_enB[m];
  assign rs_enBW[m]=Wswp[m] ? rs_enA[m] : rs_enB[m];

  assign rs_const_new[3*m]=~rs_IPRel[3*m] ? rs_const[3*m] : 64'bz;
  assign rs_const_new[3*m]=rs_IPRel[3*m] & ~ rs_afterTK[3*m] ? baseIP_reg : 64'bz;
  assign rs_const_new[3*m]=rs_IPRel[3*m] & rs_afterTK[3*m] & jump0Pred_reg ? jump0IP_reg : 64'bz;
  assign rs_const_new[3*m]=rs_IPRel[3*m] & rs_afterTK[3*m] & ~jump0Pred_reg ? jump1IP_reg : 64'bz;
  assign rs_const_new[3*m+1]=~rs_IPRel[3*m+1] ? rs_const[3*m+1] : 64'bz;
  assign rs_const_new[3*m+1]=rs_IPRel[3*m+1] & ~ rs_afterTK[3*m+1] ? baseIP_reg : 64'bz;
  assign rs_const_new[3*m+1]=rs_IPRel[3*m+1] & rs_afterTK[3*m+1] & jump0Pred_reg ? jump0IP_reg : 64'bz;
  assign rs_const_new[3*m+1]=rs_IPRel[3*m+1] & rs_afterTK[3*m+1] & ~jump0Pred_reg ? jump1IP_reg : 64'bz;
  assign rs_const_new[3*m+2]=rs_const[3*m+2];

  end
  
  for(n=0;n<4;n=n+1) begin

 //   assign wxdata[n]={get_last_bank(dc_size_reg3[n],dc_rdataA[n]),dc_rdataA[n][23:0]};

      ldD2nativeD lddbl_hi_mod(FUVH_reg[n][63:0],fxLD_dbl[n],fxLD_dbl_t[n],1'b0,{FUFH[n][65:33],FUFH[n][31:0]});
      LDE2NativeE ldedbl_mod({FUVH_reg[n][15:0],FUVL_reg[n][63:0]},fxLD_ext[n],{FUFH[n][15:0],FUFL[n][65:33],FUFL[n][31:0]});
      assign FUFH[n][32]=fxLD_dblext[n] ? 1'b0 : 1'bz;
      ldD2nativeD lddbl_lo_mod(FUVL_reg[n][63:0],fxLD_dbl[n],fxLD_dbl_t[n],fxLD_ext_t[n],{FUFH[n][15:0],FUFL[n][65:33],FUFL[n][31:0]});
      assign FUFL[n][32]=fxLD_dblext[n] ? 1'b0 : 1'bz;
      ldS2nativeS ldsngl_ll(FUVL_reg[n][31:0],fxLD_sin[n],fxLD_sngl_t[n],fxLD_dbl_t[n],fxLD_ext_t[n],{FUFH[n][15:0],FUFL[n][65:0]});
      ldS2nativeS ldsngl_lh(FUVL_reg[n][63:32],fxLD_sin[n],fxLD_sngl_t[n],1'b0,1'b0,FUFL[n][65:33]);
      ldS2nativeS ldsngl_hl(FUVH_reg[n][31:0],fxLD_sin[n],fxLD_sngl_t[n],fxLD_dbl_t[n] && ~fxLD_spair_t[n],1'b0,FUFH[n][65:0]);
      ldS2nativeS ldsngl_hh(FUVL_reg[n][63:32],fxLD_sin[n],fxLD_sngl_t[n],1'b0,1'b0,FUFH[n][65:33]);
      ldS2nativeS ldsngl_hl2(FUVL_reg[n][63:32],fxLD_sin[n],1'b0,fxLD_dbl_t[n] && fxLD_spair_t[n],1'b0,FUFH[n][65:0]);
      assign FUFH[n][65:16]=(fxLD_ext_t[n]) ? 50'b0 : 50'bz; 
      assign FUFH[n][67:66]=fxLD_ext_t[n] ? `ptype_ext : 2'bz;
      assign FUFH[n][67:66]=fxLD_dbl_t[n] ? `ptype_dbl : 2'bz;
      assign FUFH[n][67:66]=fxLD_sngl_t[n] ? `ptype_sngl : 2'bz;

      assign FUFL[n][67:66]=FUFH[n][67:66];

	  rt2_fp rt2_mod(
          .clk(clk),
          .rst(rst),
	  .except(except), //warning: not SMT-ed
          .rdy(fxFRT_can[n]),
          .start_process(fxFRT_don_reg3[n]),
          .step_cnt(fxFRT_steps),
          .type_(fxFRT_type),
          .is_root(fxFRT_isRoot),
          .rmode(fpcsr[`csrfpu_rmode]),
	  .reg_in(frtReg_reg),
	  .outII_in(frtII_reg),
	  .oper_in(frtOp_reg),
          .normA(fxFRT_normA0),
          .expA({1'b0,fxFRT_expA}),
          .nsignA({1'b0,~fxFRT_sgnA}),
          .normB(fxFRT_normB0),
          .expB({1'b0,fxFRT_expB}),
          .nsignB({1'b0,~fxFRT_sgnB}),
          .result(rtRes[n]),
	  .reg_out(rtReg[n]),
	  .outII_out(rtII[n]),
	  .oper_out(rtOp[n]),
          .out_en(fxFRT_alten[2][n]),
          .out_can(!(({fxFRT_alten[2],4'b0}>>n)&4'hf))
          );
	  assign fxFRT_alten[1]=4'b0;
	  assign fxFRT_alten[0]=4'b0;

	  assign outEn[7]=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst)?
	    4'b1001 : 4'bz;
	  assign outII[7]=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst) ?
	    rtII[n] : {10{1'bz}};
	  assign outOp[7]=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst) ?
	    rtOp[n] : {13{1'bz}};
	  assign FUreg[6]=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst) ?
	    rtReg[n] : {REG_WIDTH{1'bz}};
	  assign FUwen[6]=(fxFRT_alten[2][n] && (!(({fxFRT_alten[2],4'b0}>>n)&4'hf)) & ~rst) ?
	    1'b1 : {REG_WIDTH{1'bz}};

          assign FUreg[6]=~nDataAlt[2] ? FUreg_reg3[9] : {REG_WIDTH{1'bz}};
	  assign FUwen[6]=~nDataAlt[2] ? FUwen_reg3[9] : {REG_WIDTH{1'bz}};

	  assign outEn[7]=~nDataAlt[2] ? outEn_reg3[8] : 4'bz;
	  assign outII[7]=~nDataAlt[2] ? outII_reg3[8] : {10{1'bz}};
	  assign outOp[7]=~nDataAlt[2] ? outOp_reg3[8] : {13{1'bz}};

	  assign {FUFH[6],FUFL[6]}=(fxFRT_alten_reg5[2][n]  && (!(({fxFRT_alten_reg5[2],4'b0}>>n)&4'hf)) && ~rst) ? 
	    rtRes[n] : {2*SIMD_WIDTH{1'bz}};//tri state close to target

      if (n<2) begin : Wfwd
     /*     assign dc_wrAddrE[n]=wreq_hold ? insert_addr_reg3[36:1] : 36'bz;//5
          assign dc_wrAddrO[n]=wreq_hold ? insert_addr_reg3[36:1] : 36'bz;//5
          assign dc_wrBanks[n]=wreq_hold ? {32{n==0}} : 32'bz;
          assign dc_wrEn[n]=wreq_hold ? 1'b0 : 1'bz;
          assign dc_odd_wr[n]=wreq_hold ? insert_addr_reg3[0] : 1'bz;//5
          assign dc_split_wr[n]=wreq_hold ? 1'b0 : 1'bz;
          assign dc_wrBegin[n]=wreq_hold ? 5'b0 : 5'bz;
          assign dc_size_wr[n]=wreq_hold ? 5'b0 : 5'bz;
          assign dc_II_wr[n]=wreq_hold ? 10'b0 : 10'bz;
          assign dc_wdata[n]=wreq_hold ? 160'b0 : 160'bz;
          assign dc_wrEnd[n]=wreq_hold ? 5'b0 : 5'bz; 
          assign dc_wrBGN_BNK[n]=wreq_hold ? 4'hf : 4'bz; 
          assign dc_wrEND_BNK[n]=wreq_hold ? 4'hf : 4'bz; 
          assign dc_wr_low[n]=wreq_hold ? 2'b0 : 4'bz; 
*/
          assign dci_wrAddrE[n]=wreq_data_reg[n][`lsaddr_addrE];
          assign dci_wrAddrO[n]=wreq_data_reg[n][`lsaddr_addrO];
          assign dci_wrBanks[n]=wreq_data_reg[n][`lsaddr_banks];
          assign dci_wrEn[n]=wreq_en_reg[n]&&~wreq_stall;
          assign dci_odd_wr[n]=wreq_data_reg[n][`lsaddr_odd];
          assign dci_split_wr[n]=wreq_data_reg[n][`lsaddr_split];
          assign dci_wrBegin[n]=wreq_data_reg[n][`lsaddr_bank0];
          assign dci_size_wr[n]=wreq_data_reg[n][`lsaddr_sz];
          assign dci_II_wr[n]=wreq_data_reg[n][`lsaddr_II];
          assign dci_wrEnd[n]=wreq_dcEnd[n]; 
          assign dci_wrBGN_BNK[n]=wreq_bben[n]; 
          assign dci_wrEND_BNK[n]=wreq_endben[n]; 
          assign dci_wr_low[n]=wreq_data_reg[n][`lsaddr_low];
          assign dci_wrTyp[n]=wreq_data_reg[n][`lsaddr_mtype]; 
          
          assign lsr_wr_data[n+4][`lsaddr_addrE]=Wq_wrAddrE_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_addrO]=Wq_wrAddrO_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_banks]=Wq_wrBanks_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_bank0]=Wq_wrBeginA_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_low]=Wq_low_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_split]=Wq_split_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_odd]=Wq_odd_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_st]=1'b1;
          assign lsr_wr_data[n+4][`lsaddr_sz]=Wq_size_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_odd_round]=Wq_LSQ_reg[n][8];
          assign lsr_wr_data[n+4][`lsaddr_II]=Wq_II_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_WQ]=Wq_WQ_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_mtype]=Wq_type_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_reg_hi]=5'd0; //should be unused
          assign lsr_wr_data[n+4][`lsaddr_reg_low]=4'd0; //should be unused
          assign lsr_wr_data[n+4][`lsaddr_flag]=1'b0;
          assign lsr_wr_data[n+4][`lsaddr_pconfl]=1'b0;
          assign lsr_wr_data[n+4][`lsaddr_except]=1'b0;
          assign lsr_wr_data[n+4][`lsaddr_blow]=get_byte_mod4(Wq_low_reg[n],Wq_size_reg[n]);
          
          assign lsr_wr_data[n+4][`lsaddr_OH]=Wq_odd_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_EH]=~Wq_odd_reg[n];
          assign lsr_wr_data[n+4][`lsaddr_OL]=(Wq_odd_reg[n] && ~Wq_split_reg[n]|~Wq_wrBeginA_reg[n][4]) 
              || (~Wq_odd_reg[n] && Wq_split_reg[n] && Wq_wrBeginA_reg[n][4]);
          assign lsr_wr_data[n+4][`lsaddr_EL]=(~Wq_odd_reg[n] && ~Wq_split_reg[n]|~Wq_wrBeginA_reg[n][4])
              || (Wq_odd_reg[n] && Wq_split_reg[n] && Wq_wrBeginA_reg[n][4]);

          assign lsw_wdata[n]=WDfxDataEn_reg3[n][3:2] ? lsw_wdataF_reg[n] : WDfxData_reg3[n];
          assign lsw_wdataF[n]=WDfxDataEn_reg2[n][2] ? lsw_wdataV_reg[n] : lsw_wdataF0[n];
	  assign lsw_wdataV[n]={WDfxDataVH[n][63:0],WDfxDataVL[n][63:0]};

	  stNativeD2D stconvHD_mod(.A({16'b0,WDfxDataFH[n][65:33],WDfxDataFH[n][31:0]}),
                  .en(get_ptype2(WDoutOp_reg3[n][5:1],WDfxDataFH[n][67:66])==`ptype_dbl), 
                  .from_ext(1'b0),
                  .from_dbl(1'b1),
		  .res(lsw_wdataF0[n][127:64]));
          stNativeE2E stconvED(.A({WDfxDataFH[n][15:0],WDfxDataFL[n][65:33],WDfxDataFL[n][31:0]}),
                  .en(get_ptype2(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])==`ptype_ext),
		  .res(lsw_wdataF0[n]));
	  stNativeD2D stconvLD_mod(.A({WDfxDataFH[n][15:0],WDfxDataFL[n][65:33],WDfxDataFL[n][31:0]}),
                  .en(get_ptype2(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])==`ptype_dbl),
                  .from_ext(get_ptype(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])==`ptype_ext),
                  .from_dbl(get_ptype(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])!=`ptype_ext),
		  .res(lsw_wdataF0[n][63:0]));
	  stNativeS2S stconvLLD_mod(.A({16'b0,WDfxDataFH[n][65:33],WDfxDataFH[n][32:0]}),
                  .en(get_ptype2(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])==`ptype_sngl),
                  .from_ext(get_ptype(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])==`ptype_ext),
                  .from_dbl(get_ptype(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])==`ptype_dbl),
                  .from_sngl(get_ptype(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])!=`ptype_ext && 
		    get_ptype(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])!=`ptype_dbl),
		  .res(lsw_wdataF0[n][31:0]));
	  stNativeS2S stconvLHD_mod(.A({49'b0,WDfxDataFL[n][65:33]}),
                  .en(get_ptype2(WDoutOp_reg3[n][5:1],WDfxDataFL[n][67:66])==`ptype_sngl),
                  .from_ext(1'b0),
                  .from_dbl(1'b0),
                  .from_sngl(1'b1),
		  .res(lsw_wdataF0[n][63:32]));
	  stNativeS2S stconvHLD_mod(.A({49'b0,WDfxDataFH[n][32:0]}),
                  .en(get_ptype2(WDoutOp_reg3[n][5:1],WDfxDataFH[n][67:66])==`ptype_sngl),
                  .from_ext(1'b0),
                  .from_dbl(1'b0),
                  .from_sngl(1'b1),
		  .res(lsw_wdataF0[n][95:64]));
	  stNativeS2S stconvHHD_mod(.A({49'b0,WDfxDataFH[n][65:33]}),
                  .en(get_ptype2(WDoutOp_reg3[n][5:1],WDfxDataFH[n][67:66])==`ptype_sngl),
                  .from_ext(1'b0),
                  .from_dbl(1'b0),
                  .from_sngl(1'b1),
		  .res(lsw_wdataF0[n][127:96]));

       
          rs_write_forward fwdDA_mod(
          .clk(clk),
          .rst(rst),
          .oldData(WDoutData[n]),
          .newData(WDfxData[n]),
          .fuFwd(WDoutFuFwd[n]),.fuuFwd(WDoutFuuFwd[n]),
          .stall(~WDoutDataEn[n][1]),
          .FU0(FU[0]),.FU0_reg(FU_reg[0]),
          .FU1(FU[1]),.FU1_reg(FU_reg[1]),
          .FU2(FU[2]),.FU2_reg(FU_reg[2]),
          .FU3(FU[3]),.FU3_reg(FU_reg[3]),
          .FU4(FU[4]),.FU4_reg(FU_reg[4]),
          .FU5(FU[5]),.FU5_reg(FU_reg[5]),
          .FU6(FU[6]),.FU6_reg(FU_reg[6]),
          .FU7(FU[7]),.FU7_reg(FU_reg[7]),
          .FU8(FU[8]),.FU8_reg(FU_reg[8]),
          .FU9(FU[9]),.FU9_reg(FU_reg[9])
          );

          rs_write_forward #(SIMD_WIDTH) fwdDAVH_mod(
          .clk(clk),
          .rst(rst),
          .oldData(WDoutDataVH[n]),
          .newData(WDfxDataVH[n]),
          .fuFwd(WDoutFuFwd_reg[n]),.fuuFwd(WDoutFuuFwd_reg[n]),
          .stall(~WDoutDataEn_reg[n][2]),
          .FU0(FUVH[0]),.FU0_reg(FUVH_reg[0]),
          .FU1(FUVH[1]),.FU1_reg(FUVH_reg[1]),
          .FU2(FUVH[2]),.FU2_reg(FUVH_reg[2]),
          .FU3(FUVH[3]),.FU3_reg(FUVH_reg[3]),
          .FU4(FUVH[4]),.FU4_reg(FUVH_reg[4]),
          .FU5(FUVH[5]),.FU5_reg(FUVH_reg[5]),
          .FU6(FUVH[6]),.FU6_reg(FUVH_reg[6]),
          .FU7(FUVH[7]),.FU7_reg(FUVH_reg[7]),
          .FU8(FUVH[8]),.FU8_reg(FUVH_reg[8]),
          .FU9(FUVH[9]),.FU9_reg(FUVH_reg[9])
          );
        
          rs_write_forward #(SIMD_WIDTH) fwdDBVL_mod(
          .clk(clk),
          .rst(rst),
          .oldData(WDoutDataVL[n]),
          .newData(WDfxDataVL[n]),
          .fuFwd(WDoutFuFwd_reg[n]),.fuuFwd(WDoutFuuFwd_reg[n]),
          .stall(~WDoutDataEn_reg[n][2]),
          .FU0(FUVL[0]),.FU0_reg(FUVL_reg[0]),
          .FU1(FUVL[1]),.FU1_reg(FUVL_reg[1]),
          .FU2(FUVL[2]),.FU2_reg(FUVL_reg[2]),
          .FU3(FUVL[3]),.FU3_reg(FUVL_reg[3]),
          .FU4(FUVL[4]),.FU4_reg(FUVL_reg[4]),
          .FU5(FUVL[5]),.FU5_reg(FUVL_reg[5]),
          .FU6(FUVL[6]),.FU6_reg(FUVL_reg[6]),
          .FU7(FUVL[7]),.FU7_reg(FUVL_reg[7]),
          .FU8(FUVL[8]),.FU8_reg(FUVL_reg[8]),
          .FU9(FUVL[9]),.FU9_reg(FUVL_reg[9])
          );
        
          rs_write_forward #(SIMD_WIDTH) fwdDAFH_mod(
          .clk(clk),
          .rst(rst),
          .oldData(WDoutDataFH[n]),
          .newData(WDfxDataFH[n]),
          .fuFwd(WDoutFuFwd_reg2[n]),.fuuFwd(WDoutFuuFwd_reg2[n]),
          .stall(~WDoutDataEn_reg2[n][3]),
          .FU0(FUFH[0]),.FU0_reg(FUFH_reg[0]),
          .FU1(FUFH[1]),.FU1_reg(FUFH_reg[1]),
          .FU2(FUFH[2]),.FU2_reg(FUFH_reg[2]),
          .FU3(FUFH[3]),.FU3_reg(FUFH_reg[3]),
          .FU4(FUFH[4]),.FU4_reg(FUFH_reg[4]),
          .FU5(FUFH[5]),.FU5_reg(FUFH_reg[5]),
          .FU6(FUFH[6]),.FU6_reg(FUFH_reg[6]),
          .FU7(FUFH[7]),.FU7_reg(FUFH_reg[7]),
          .FU8(FUFH[8]),.FU8_reg(FUFH_reg[8]),
          .FU9(FUFH[9]),.FU9_reg(FUFH_reg[9])
          );
        
          rs_write_forward #(16+SIMD_WIDTH) fwdDBFL_mod(
          .clk(clk),
          .rst(rst),
          .oldData(WDoutDataFL[n]),
          .newData(WDfxDataFL[n]),
          .fuFwd(WDoutFuFwd_reg2[n]),.fuuFwd(WDoutFuuFwd_reg2[n]),
          .stall(~WDoutDataEn_reg2[n][3]),
          .FU0(FUFL[0]),.FU0_reg(FUFL_reg[0]),
          .FU1(FUFL[1]),.FU1_reg(FUFL_reg[1]),
          .FU2(FUFL[2]),.FU2_reg(FUFL_reg[2]),
          .FU3(FUFL[3]),.FU3_reg(FUFL_reg[3]),
          .FU4(FUFL[4]),.FU4_reg(FUFL_reg[4]),
          .FU5(FUFL[5]),.FU5_reg(FUFL_reg[5]),
          .FU6(FUFL[6]),.FU6_reg(FUFL_reg[6]),
          .FU7(FUFL[7]),.FU7_reg(FUFL_reg[7]),
          .FU8(FUFL[8]),.FU8_reg(FUFL_reg[8]),
          .FU9(FUFL[9]),.FU9_reg(FUFL_reg[9])
          );
          

          rs_save #(4) DdataEn_mod(
          .clk(clk),.rst(rst),
          .oldData(WDoutDataEn[n]),.newData(WDfxDataEn[n]),
          .save(1'b0),.en(WDoutDataEn[n][0])
          );

      end

  end
  
//  for(o=0;o<8;o=o+1) begin : busECC_mod
//      EccGet32 #(32) busECC_mod(insBus_data_reg2[o*32+:32],insBus_data_ECC[o*BANK_WIDTH+:BANK_WIDTH]);
//  end
  
  for(u=0;u<9;u=u+1) begin : infl_gen
     // assign inflA[u]=(retA[u]&rs_rA_use[u]) ? 1'b0 : 1'bz;
     // assign inflB[u]=(retB[u]&rs_rB_use[u]) ? 1'b0 : 1'bz;
     // assign inflA[u]=(retAF[u]&rs_rA_useF[u]) ? 1'b0 : 1'bz;
     // assign inflB[u]=(retBF[u]&rs_rB_useF[u]) ? 1'b0 : 1'bz;

      assign newD[u]={rs_port[u]==PORT_LOAD,rs_rT_isV[u]};
      assign domErrA[u]=~((rs_rA_isV[u]~^domA[u][0]) || rs_rA_isAnyV[u] || domA[u][1]) && rs_rA_useF[u];
      assign domErrB[u]=~((rs_rB_isV[u]~^domB[u][0]) || rs_rB_isAnyV[u] || domB[u][1]) && rs_rB_useF[u];
      
      if (u%3) begin
          assign gazumpA[u]=isAF_reg[u] ? gazumpFA[u] : 11'bz;
          assign gazumpA[u]=isAV_reg[u] ? gazumpAV[u] : 11'bz;
          assign gazumpA[u]=(~isAV_reg[u] & ~isAF_reg[u]) ? gazumpAG[u] : 11'bz;
          assign gazumpB[u]=isBF_reg[u] ? gazumpFB[u] : 11'bz;
          assign gazumpB[u]=isBV_reg[u] ? gazumpBV[u] : 11'bz;
          assign gazumpB[u]=(~isBV_reg[u] & ~isBF_reg[u]) ? gazumpBG[u] : 11'bz;
     end else begin
          assign gazumpA[u]=isAWF_reg[u/3] ? gazumpFA[u] : 11'bz;
          assign gazumpA[u]=isAWV_reg[u/3] ? gazumpAV[u] : 11'bz;
          assign gazumpA[u]=(~isAWV_reg[u/3] & ~isAWF_reg[u/3]) ? gazumpAG[u] : 11'bz;
          assign gazumpB[u]=isBFW_reg[u/3] ? gazumpFB[u] : 11'bz;
          assign gazumpB[u]=isBVW_reg[u/3] ? gazumpBV[u] : 11'bz;
          assign gazumpB[u]=(~isBVW_reg[u/3] & ~isBFW_reg[u/3]) ? gazumpBG[u] : 11'bz;
     end
      assign isAF[u]=rs_rA_useF[u] && (~rs_rA_isV[u] || (rs_rA_isAnyV[u] && domA[u]==2'b00));
      assign isBF[u]=rs_rB_useF[u] && (~rs_rB_isV[u] || (rs_rB_isAnyV[u] && domB[u]==2'b00));
      //warning: error might occur in "any" dom{A|B}.
      assign isAV[u]=rs_rA_useF[u] && (rs_rA_isV[u] || (rs_rA_isAnyV[u] && domA[u]==2'b01));
      assign isBV[u]=rs_rB_useF[u] && (rs_rB_isV[u] || (rs_rB_isAnyV[u] && domB[u]==2'b01));
  end
  
  endgenerate
  
  rs_s storeRs(
  .clk(clk),
  .dataRst(rst),.nonDataRst(except|rst),.rst_thread(excpt_thread),
  .stall(stall_rs[3]),
  .doStall(doStall_rs[3]),
  .FU0Hit(FU0Hit),.FU1Hit(FU1Hit),.FU2Hit(FU2Hit),.FU3Hit(FU3Hit),
  .rsEnab(~{1'b0,wt_pause_agu|Wagu_blockRS[1],1'b0,wt_pause_agu|Wagu_blockRS[0]}),
  .new_thread(thread_reg2),
// wires to store new values in a buffer
  .newDataA0(dataA[0]),.newDataB0(dataB[0]),.newDataC0(rs_const_reg[0][32:0]&{33{~rs_useBConst_reg[0]}}),
    .newRegA0(WregA[0]),.newRegB0(WregB[0]),
    .newANeeded0(WinflA[0]),.newBNeeded0(WinflB[0]),
    .newOpA0((rs_lsi_reg[0]!=3'd7) ? rs_operation_reg[0] : WopA_reg),
    .newOpB0((rs_lsi_reg[0]!=3'd7) ? rs_operation_reg[0] : WopB_reg),
    .newPort0(Wport_reg[0]),
    .newEnA0(rs_enAW_reg[0]),.newEnB0(rs_enBW_reg[0]),
    .newInstrIndexA0((rs_lsi_reg[0]!=3'd7) ? {II_upper,rs_index_reg[0]} : {II_upper,LSQ_indA_reg}),
    .newInstrIndexB0((rs_lsi_reg[0]!=3'd7) ? {II_upper,rs_index_reg[0]} : {II_upper,LSQ_indB_reg}),
    .newLSQA0((rs_lsi_reg[0]!=3'd7) ? {LSQ_upper,rs_lsi_reg[0]} : {LSQ_upper,LSQ_lsqA_reg}),
    .newLSQB0((rs_lsi_reg[0]!=3'd7) ? {LSQ_upper,rs_lsi_reg[0]} : {LSQ_upper,LSQ_lsqB_reg}),
    .newWQA0((rs_lsi_reg[0]!=3'd7) ? WQR_reg[0] : LSQ_wqA_reg),
    .newWQB0((rs_lsi_reg[0]!=3'd7) ? WQR_reg[0] : LSQ_wqB_reg),
    .rsAlloc0(rs_en_reg[0]&rs_alt_reg[0]),.newGazumpA0(gazumpA[0]),.newGazumpB0(gazumpB[0]),
    .newFunitA0(WfunA[0]),.newFunitB0(WfunB[0]),
    .newLSFlag0(rs_ldst_flg[0]),
    .newAttr0(newAttr_reg2),
  .newDataA1(dataA[3]),.newDataB1(dataB[3]),.newDataC1(rs_const_reg[3][32:0]&{33{~rs_useBConst_reg[3]}}),
    .newRegA1(WregA[1]),.newRegB1(WregB[1]),
    .newANeeded1(WinflA[1]),.newBNeeded1(WinflB[1]),
    .newOpA1((rs_lsi_reg[1]!=3'd7) ? rs_operation_reg[3] : WopA_reg),
    .newOpB1((rs_lsi_reg[1]!=3'd7) ? rs_operation_reg[3] : WopB_reg),
    .newPort1(Wport_reg[1]),
    .newEnA1(rs_enAW_reg[1]),.newEnB1(rs_enBW_reg[1]),
    .newInstrIndexA1((rs_lsi_reg[1]!=3'd7) ? {II_upper,rs_index_reg[3]} : {II_upper,LSQ_indA_reg}),
    .newInstrIndexB1((rs_lsi_reg[1]!=3'd7) ? {II_upper,rs_index_reg[3]} : {II_upper,LSQ_indB_reg}),
    .newLSQA1((rs_lsi_reg[1]!=3'd7) ? {LSQ_upper,rs_lsi_reg[1]} : {LSQ_upper,LSQ_lsqA_reg}),
    .newLSQB1((rs_lsi_reg[1]!=3'd7) ? {LSQ_upper,rs_lsi_reg[1]} : {LSQ_upper,LSQ_lsqB_reg}),
    .newWQA1((rs_lsi_reg[1]!=3'd7) ? WQR_reg[1] : LSQ_wqA_reg),
    .newWQB1((rs_lsi_reg[1]!=3'd7) ? WQR_reg[1] : LSQ_wqB_reg),
    .rsAlloc1(rs_en_reg[3]&rs_alt_reg[1]),.newGazumpA1(gazumpA[3]),.newGazumpB1(gazumpB[3]),
    .newFunitA1(WfunA[1]),.newFunitB1(WfunB[1]),
    .newLSFlag1(rs_ldst_flg[2]),
    .newAttr1(newAttr_reg2),
  .newDataA2(dataA[6]),.newDataB2(dataB[6]),.newDataC2(rs_const_reg[6][32:0]&{33{~rs_useBConst_reg[6]}}),
    .newRegA2(WregA[2]),.newRegB2(WregB[2]),
    .newANeeded2(WinflA[2]),.newBNeeded2(WinflB[2]),
    .newOpA2((rs_lsi_reg[2]!=3'd7) ? rs_operation_reg[6] : WopA_reg),
    .newOpB2((rs_lsi_reg[2]!=3'd7) ? rs_operation_reg[6] : WopB_reg),
    .newPort2(Wport_reg[2]),
    .newEnA2(rs_enAW_reg[2]),.newEnB2(rs_enBW_reg[2]),
    .newInstrIndexA2((rs_lsi_reg[2]!=3'd7) ? {II_upper,rs_index_reg[6]} : {II_upper,LSQ_indA_reg}),
    .newInstrIndexB2((rs_lsi_reg[2]!=3'd7) ? {II_upper,rs_index_reg[6]} : {II_upper,LSQ_indB_reg}),
    .newLSQA2((rs_lsi_reg[2]!=3'd7) ? {LSQ_upper,rs_lsi_reg[2]} : {LSQ_upper,LSQ_lsqA_reg}),
    .newLSQB2((rs_lsi_reg[2]!=3'd7) ? {LSQ_upper,rs_lsi_reg[2]} : {LSQ_upper,LSQ_lsqB_reg}),
    .newWQA2((rs_lsi_reg[2]!=3'd7) ? WQR_reg[2] : LSQ_wqA_reg),
    .newWQB2((rs_lsi_reg[2]!=3'd7) ? WQR_reg[2] : LSQ_wqB_reg),
    .rsAlloc2(rs_en_reg[6]&rs_alt_reg[2]),.newGazumpA2(gazumpA[6]),.newGazumpB2(gazumpB[6]),
    .newFunitA2(WfunA[2]),.newFunitB2(WfunB[2]),
    .newLSFlag2(rs_ldst_flg[4]),
    .newAttr2(newAttr_reg2),
// wires to get values out of buffer
  .outDataA0(WoutDataB[0]),.outDataB0(WoutDataA[0]),.outDataC0(WoutDataC[0]),
    .outOp0(WoutOp[0]),.outInstrIndex0(WoutII[0]),
    .outFuFwdA0(WfuFwdB[0]),.outFuFwdB0(WfuFwdA[0]),.outFuuFwdA0(WfuuFwdB[0]),.outFuuFwdB0(WfuuFwdA[0]),
    .outLSQ0(WoutLSQ[0]),.outDataEn0(WoutDataEn[0]),.outThread0(WoutThread[0]),.outWQ0(WoutWQ[0]),
    .outLSFlag0(WoutLSflag[0]),//agu
    .outAttr0(WoutAttr[0]),
  .outDataB1(WDoutData[0]),.outOp1(WDoutOp[0]),.outInstrIndex1(WDoutII[0]),
    .outFuFwdB1(WDoutFuFwd[0]),.outFuuFwdB1(WDoutFuuFwd[0]),.outLSQ1(WDoutLSQ[0]),
    .outDataEn1(WDoutDataEn[0]),.outThread1(WDoutThread[0]),.outWQ1(WDoutWQ[0]),//data
    .outAttr1(),
  .outDataA2(WoutDataA[1]),.outDataB2(WoutDataB[1]),.outDataC2(WoutDataC[1]),
    .outOp2(WoutOp[1]),.outInstrIndex2(WoutII[1]),
    .outFuFwdA2(WfuFwdA[1]),.outFuFwdB2(WfuFwdB[1]),.outFuuFwdA2(WfuuFwdA[1]),.outFuuFwdB2(WfuuFwdB[1]),
    .outLSQ2(WoutLSQ[1]),.outDataEn2(WoutDataEn[1]),.outThread2(WoutThread[1]),.outWQ2(WoutWQ[1]),
    .outLSFlag2(WoutLSflag[1]),//agu
    .outAttr2(WoutAttr[1]),
  .outDataA3(WDoutData[1]),.outOp3(WDoutOp[1]),.outInstrIndex3(WDoutII[1]),
    .outFuFwdA3(WDoutFuFwd[1]),.outFuuFwdA3(WDoutFuuFwd[1]),.outLSQ3(WDoutLSQ[1]),
    .outDataEn3(WDoutDataEn[1]),.outThread3(WDoutThread[1]),.outWQ3(WDoutWQ[1]),//data
    .outAttr3(),
// wires from functional units  
  .FU0(FU_reg[0]),.FUreg0(FUreg[0]),.FUwen0(FUwen[0]),
  .FU1(FU_reg[1]),.FUreg1(FUreg[1]),.FUwen1(FUwen[1]),
  .FU2(FU_reg[2]),.FUreg2(FUreg[2]),.FUwen2(FUwen[2]),
  .FU3(FU_reg[3]),.FUreg3(FUreg[3]),.FUwen3(FUwen[3]),
  .FU4(FU_reg[4]),.FUreg4(FUreg[4]),.FUwen4(FUwen[4]),
  .FU5(FU_reg[5]),.FUreg5(FUreg[5]),.FUwen5(FUwen[5]),
  .FU6(FU_reg[6]),.FUreg6(FUreg[6]),.FUwen6(FUwen[6]),
  .FU7(FU_reg[7]),.FUreg7(FUreg[7]),.FUwen7(FUwen[7]),
  .FU8(FU_reg[8]),.FUreg8(FUreg[8]),.FUwen8(FUwen[8]),
  .FU9(FU_reg[9]),.FUreg9(FUreg[9]),.FUwen9(FUwen[9]),
  
  .newDataVA0H(dataAVH[0]),.newDataVB0H(dataBVH[0]),.newDataVA0L(dataAVL[0]),.newDataVB0L(dataBVL[0]),
  .newDataFA0H(dataAFH[0]),.newDataFB0H(dataBFH[0]),.newDataFA0L(dataAFL[0]),.newDataFB0L(dataBFL[0]),
  .newDataVA1H(dataAVH[1]),.newDataVB1H(dataBVH[1]),.newDataVA1L(dataAVL[1]),.newDataVB1L(dataBVL[1]),
  .newDataFA1H(dataAFH[1]),.newDataFB1H(dataBFH[1]),.newDataFA1L(dataAFL[1]),.newDataFB1L(dataBFL[1]),
  .newDataVA2H(dataAVH[2]),.newDataVB2H(dataBVH[2]),.newDataVA2L(dataAVL[2]),.newDataVB2L(dataBVL[2]),
  .newDataFA2H(dataAFH[2]),.newDataFB2H(dataBFH[2]),.newDataFA2L(dataAFL[2]),.newDataFB2L(dataBFL[2]),

  .outDataVB1H(WDoutDataVH[0]),.outDataVB1L(WDoutDataVL[0]),
  .outDataFB1H(WDoutDataFH[0]),.outDataFB1L(WDoutDataFL[0]),
  .outDataVA3H(WDoutDataVH[1]),.outDataVA3L(WDoutDataVL[1]),
  .outDataFA3H(WDoutDataFH[1]),.outDataFA3L(WDoutDataFL[1]),

  .FUV0H(FUVH[0]),.FUV0L(FUVL[0]),.FUF0H(FUFH[0]),.FUF0L(FUFL[0]),
  .FUV1H(FUVH[1]),.FUV1L(FUVL[1]),.FUF1H(FUFH[1]),.FUF1L(FUFL[1]),
  .FUV2H(FUVH[2]),.FUV2L(FUVL[2]),.FUF2H(FUFH[2]),.FUF2L(FUFL[2]),
  .FUV3H(FUVH[3]),.FUV3L(FUVL[3]),.FUF3H(FUFH[3]),.FUF3L(FUFL[3]),
  .FUV4H(FUVH[4]),.FUV4L(FUVL[4]),.FUF4H(FUFH[4]),.FUF4L(FUFL[4]),
  .FUV5H(FUVH[5]),.FUV5L(FUVL[5]),.FUF5H(FUFH[5]),.FUF5L(FUFL[5]),
  .FUV6H(FUVH[6]),.FUV6L(FUVL[6]),.FUF6H(FUFH[6]),.FUF6L(FUFL[6]),
  .FUV7H(FUVH[7]),.FUV7L(FUVL[7]),.FUF7H(FUFH[7]),.FUF7L(FUFL[7]),
  .FUV8H(FUVH[8]),.FUV8L(FUVL[8]),.FUF8H(FUFH[8]),.FUF8L(FUFL[8]),
  .FUV9H(FUVH[9]),.FUV9L(FUVL[9]),.FUF9H(FUFH[9]),.FUF9L(FUFL[9])
  );
  /*in_flip_rt #(2*SIMD_WIDTH+9+10) rtDatA_mod(
    .clk(clk),.rst(rst),.in_en(fxFRT_en),.pause(fxFRT_pause[2]),
    .d_in({outII_reg3[8],outReg_reg3[8],fxDataAFH[5],fxDataAFL[5]}),
    .d_out({frtII,frtReg,rtDataA}),
    .dout_en((fxFRT_can[0] & ~fxFRT_don_reg[0] & ~fxFRT_don_reg2[0] & ~fxFRT_don_reg2[0] & ~fxFRT_don_reg3[0]) |
     (fxFRT_can[1] & ~fxFRT_don_reg[1] & ~fxFRT_don_reg2[1] & ~fxFRT_don_reg2[1] & ~fxFRT_don_reg3[1]) |
     (fxFRT_can[2] & ~fxFRT_don_reg[2] & ~fxFRT_don_reg2[2] & ~fxFRT_don_reg2[2] & ~fxFRT_don_reg3[2]) |
     (fxFRT_can[3] & ~fxFRT_don_reg[3] & ~fxFRT_don_reg2[3] & ~fxFRT_don_reg2[3] & ~fxFRT_don_reg3[3])),.do_(fxFRT_do));
  in_flip_rt #(13+2*SIMD_WIDTH) rtDatB_mod(
    .clk(clk),.rst(rst),.in_en(fxFRT_en),.pause(),
    .d_in({outOp_reg3[8],gxDataBFH[4],gxDataBFL[4]}),
    .d_out({frtOp,rtDataB}),
    .dout_en((fxFRT_can[0] & ~fxFRT_don_reg[0] & ~fxFRT_don_reg2[0] & ~fxFRT_don_reg2[0] & ~fxFRT_don_reg3[0]) |
     (fxFRT_can[1] & ~fxFRT_don_reg[1] & ~fxFRT_don_reg2[1] & ~fxFRT_don_reg2[1] & ~fxFRT_don_reg3[1]) |
     (fxFRT_can[2] & ~fxFRT_don_reg[2] & ~fxFRT_don_reg2[2] & ~fxFRT_don_reg2[2] & ~fxFRT_don_reg3[2]) |
     (fxFRT_can[3] & ~fxFRT_don_reg[3] & ~fxFRT_don_reg2[3] & ~fxFRT_don_reg2[3] & ~fxFRT_don_reg3[3])),.do_());
  imul imul_mod(
  .clk(clk),
  .rst(rst),
  .clkEn(~(|fxFRT_alten_reg3[2])),
  .op_prev(outOp[3*2+2]),
  .en(outEn_reg[3*2+2][1:0]==2'b11 && outOp_reg[3*2+2][11]), //needs adjsutment if idiv implemented 
  .R(fxDataA[3*2+2]),.C(fxDataB[3*2+2]),
  .alt(nDataAlt[2][0]),
  .Res(FUMUL)
 );
 cvt_FP_I_mod fp2i_mod(
  .clk(clk),
  .rst(rst),
  .en(outEn_reg3[3*2+2][3] && outEn_reg3[3*2+2][0] && outOp_reg3[3*2+2][11] 
  && (outOp_reg3[3*2+2][7:0]==`fop_cvtD ||
    outOp_reg3[3*2+2][7:0]==`fop_cvtE || outOp_reg3[3*2+2][7:0]==`fop_cvtS ||
    outOp_reg3[3*2+2][7:0]==`fop_cvt32S ||outOp_reg3[3*2+2][7:0]==`fop_cvt32D ||
    outOp_reg3[3*2+2][7:0]==`fop_tblD)),
  .clkEn(~(|fxFRT_alten_reg3[2])),
  .A({gxDataBFH[2*2+0][15:0],gxDataBFL[2*2+0][65:0]}),
  .isDBL(outOp_reg3[3*2+2][7:0]==`fop_cvtD || outOp_reg3[3*2+2][7:0]==`fop_cvt32D),
  .isEXT(outOp_reg3[3*2+2][7:0]==`fop_cvtE),
  .isSNG(outOp_reg3[3*2+2][7:0]!=`fop_cvtD && outOp_reg3[3*2+2][7:0]!=`fop_cvt32D &&
    outOp_reg3[3*2+2][7:0]!=`fop_cvtE),
  .verbatim(outOp_reg3[3*2+2][7:0]==`fop_tblD),
  .is32b(outOp_reg3[3*2+2][7:0]==`fop_cvt32S || outOp_reg3[3*2+2][7:0]==`fop_cvt32D),
  .res(FUCVT1),
  .alt(nDataAlt[2][1])
);*/
/*
  assign nDataAlt[0]=3'b111;
  assign nDataAlt[1]=3'b111;
//  assign nDataAlt[2][1]=2'b1;
  
  assign FUFL[6]=~nDataAlt_reg5[2][2] ? {FUTYPE_reg6,FUCVT2_reg6[65:0]} : 68'bz;
  assign FUFH[6]=~nDataAlt_reg5[2][2] ? {FUTYPE_reg6,50'b0,FUCVT2_reg6[81:66]} : 68'bz;

  assign FUX_alu[2]=(|fxFRT_alten_reg6[2]) ? 6'b0 : 6'bz;
  assign FUX_alu[2]=gxFADD_en_reg2[2] ? FOOS_reg2[2] : 6'bz;
  assign FUX_alu[2]=(~(|fxFRT_alten_reg6[2]) && ~gxFADD_en_reg2[2]) ? FUS_alu_reg4[4] : 64'bz;
  assign exx_alu[2]=(|fxFRT_alten_reg6[2]) ? 3'd2 : 3'bz;
  assign exx_alu[2]=gxFADD_en_reg2[2] ? 3'd6 : 3'bz;
  assign exx_alu[2]=(~(|fxFRT_alten_reg6[2]) && ~gxFADD_en_reg2[2]) ? ex_alu_reg4[4] : 3'bz;;
  assign FUX_alu[1]=gxFADD_en_reg2[1] ? FOOS_reg2[1] : FUS_alu_reg4[2];
  assign exx_alu[1]=gxFADD_en_reg2[1] ? 3'd6 : ex_alu_reg4[2];
  assign FUX_alu[0]=gxFADD_en_reg2[0] ? FOOS_reg2[0] : FUS_alu_reg4[0];
  assign exx_alu[0]=gxFADD_en_reg2[0] ? 3'd6 : ex_alu_reg4[0];

  assign fxFRT_pause[0]=1'b0;
  assign fxFRT_pause[1]=1'b0;*/

  assign rrfAW[0]=Wswp[0] ? rs0i0_rB_reg : rs0i0_rA_reg;
  assign rrfAW[1]=Wswp[1] ? rs1i0_rB_reg : rs1i0_rA_reg;
  assign rrfAW[2]=Wswp[2] ? rs2i0_rB_reg : rs2i0_rA_reg;
  assign rrfBW[0]=(~Wswp[0]) ? rs0i0_rB_reg : rs0i0_rA_reg;
  assign rrfBW[1]=(~Wswp[1]) ? rs1i0_rB_reg : rs1i0_rA_reg;
  assign rrfBW[2]=(~Wswp[2]) ? rs2i0_rB_reg : rs2i0_rA_reg;
      

/*  assign fxFRT_don[0]=fxFRT_do&fxFRT_can[0]&~fxFRT_don_reg[0]&~fxFRT_don_reg2[0]&~fxFRT_don_reg3[0];
  assign fxFRT_don[1]=fxFRT_do&&~fxFRT_can[0]|fxFRT_don_reg[0]|fxFRT_don_reg2[0]|fxFRT_don_reg3[0]
   && fxFRT_can[1] && ~fxFRT_don_reg[1]&&~fxFRT_don_reg2[1]&&~fxFRT_don_reg3[1];
  assign fxFRT_don[2]=fxFRT_do&&~fxFRT_can[0]|fxFRT_don_reg[0]|fxFRT_don_reg2[0]|fxFRT_don_reg3[0]
   && ~fxFRT_can[1]|fxFRT_don_reg[1]|fxFRT_don_reg2[1]|fxFRT_don_reg3[1] 
   && fxFRT_can[2] && ~fxFRT_don_reg[2]&&~fxFRT_don_reg2[2]&&~fxFRT_don_reg3[2];
  assign fxFRT_don[3]=fxFRT_do&&~fxFRT_can[0]|fxFRT_don_reg[0]|fxFRT_don_reg2[0]|fxFRT_don_reg3[0]
   && ~fxFRT_can[1]|fxFRT_don_reg[1]|fxFRT_don_reg2[1]|fxFRT_don_reg3[1] 
   && ~fxFRT_can[2]|fxFRT_don_reg[2]|fxFRT_don_reg2[2]|fxFRT_don_reg3[2] 
   && fxFRT_can[3] && ~fxFRT_don_reg[3]&&~fxFRT_don_reg2[3]&&~fxFRT_don_reg3[3];
 
  assign fxFRT_expA=fxFRT_dblL ? {rtDataA_reg[65],{4{~rtDataA_reg[65]&&{rtDataA_reg[65],rtDataA_reg[63:53]}}},
    rtDataA_reg[63:53]} : 16'bz;
  assign fxFRT_expA=fxFRT_dblH ? {rtDataA_reg[SIMD_WIDTH+65],
    {4{~rtDataA_reg[SIMD_WIDTH+65]&&{rtDataA_reg[SIMD_WIDTH+65],rtDataA_reg[SIMD_WIDTH+63:SIMD_WIDTH+53]}}},
    rtDataA_reg[SIMD_WIDTH+63:SIMD_WIDTH+53]} : 16'bz;
  assign fxFRT_expA=fxFRT_sngl ? {rtDataA_reg[65],{7{~rtDataA_reg[65]&&{rtDataA_reg[65],rtDataA_reg[30:23]}}},
    rtDataA_reg[30:23]} : 16'bz;
  assign fxFRT_expA=fxFRT_ext ? {rtDataA_reg[65],rtDataA_reg[SIMD_WIDTH+14:SIMD_WIDTH]} : 16'bz;
  assign fxFRT_expB=fxFRT_dblL? {rtDataB_reg[65],{4{~rtDataB_reg[65]&&{rtDataB_reg[65],rtDataB_reg[63:53]}}},
    rtDataB_reg[63:53]} : 16'bz;
  assign fxFRT_expB=fxFRT_dblH ? {rtDataB_reg[SIMD_WIDTH+65],
    {4{~rtDataB_reg[SIMD_WIDTH+65]&&{rtDataB_reg[SIMD_WIDTH+65],rtDataB_reg[SIMD_WIDTH+63:SIMD_WIDTH+53]}}},
    rtDataB_reg[SIMD_WIDTH+63:SIMD_WIDTH+53]} : 16'bz;
  assign fxFRT_expB=fxFRT_sngl ? {rtDataB_reg[65],{7{~rtDataB_reg[65]&&{rtDataB_reg[65],rtDataB_reg[30:23]}}},
    rtDataB_reg[30:23]} : 16'bz;
  assign fxFRT_expB=fxFRT_ext ? {rtDataB_reg[65],rtDataB_reg[SIMD_WIDTH+14:SIMD_WIDTH]} : 16'bz;

  assign fxFRT_normA0=fxFRT_dblL_ns ? {1'b1,rtDataA_reg[52:33],rtDataA_reg[31:0],12'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_dblH_ns ? {1'b1,rtDataA_reg[SIMD_WIDTH+52:SIMD_WIDTH+33],
    rtDataA_reg[SIMD_WIDTH+31:SIMD_WIDTH],12'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_sngl_ns ?{1'b1,rtDataA_reg[22:0],21'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_ext_ns ? {rtDataA_reg[64:33],rtDataA_reg[31:0],1'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_dblL_s ? {2'b1,rtDataA_reg[52:33],rtDataA_reg[31:0],11'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_dblH_s ? {2'b1,rtDataA_reg[SIMD_WIDTH+52:SIMD_WIDTH+33],
    rtDataA_reg[SIMD_WIDTH+31:SIMD_WIDTH],11'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_sngl_s ?{2'b1,rtDataA_reg[22:0],20'b0} : 65'bz;
  assign fxFRT_normA0=fxFRT_ext_s ? {1'b0,rtDataA_reg[64:33],rtDataA_reg[31:0]} : 65'bz;
  assign fxFRT_normB0=fxFRT_dblL ? {1'b1,rtDataB_reg[52:33],rtDataB_reg[31:0],12'b0} : 65'bz;
  assign fxFRT_normB0=fxFRT_dblH ? {1'b1,rtDataB_reg[SIMD_WIDTH+52:SIMD_WIDTH+33],
    rtDataB_reg[SIMD_WIDTH+31:SIMD_WIDTH],12'b0} : 65'bz;
  assign fxFRT_normB0=fxFRT_sngl ?{1'b1,rtDataB_reg[22:0],21'b0} : 65'bz;
  assign fxFRT_normB0=fxFRT_ext ? {rtDataB_reg[64:33],rtDataB_reg[31:0],1'b0} : 65'bz;

  assign fxFRT_sgnA=fxFRT_dblL ? rtDataA_reg[64] : 1'bz;
  assign fxFRT_sgnA=fxFRT_dblH ? rtDataA_reg[SIMD_WIDTH+64] : 1'bz;
  assign fxFRT_sgnA=fxFRT_sngl ? rtDataA_reg[31] : 1'bz;
  assign fxFRT_sgnA=fxFRT_ext ? rtDataA_reg[31] : 1'bz;
  assign fxFRT_sgnB=fxFRT_dblL ? rtDataB_reg[64] : 1'bz;
  assign fxFRT_sgnB=fxFRT_dblH ? rtDataB_reg[SIMD_WIDTH+64] : 1'bz;
  assign fxFRT_sgnB=fxFRT_sngl ? rtDataB_reg[31] : 1'bz;
  assign fxFRT_sgnB=fxFRT_ext ? rtDataB_reg[31] : 1'bz;
*/
  fu_alu alu_ALIGNED(
  .clk(clk),
  .rst(rst),
  .except(except),
  .u1_A(outDataA[0+1]),.u1_B(outDataB[0+1]),.u1_S(outDataS[0+1]),.u1_op(outOp[0+1]),
  .u1_ret(FUS_alu[0]),.u1_rten(enS_alu[0]),.u1_clkEn(outEn[0+1][0]&outEn[0+1][1]),
    .u1_A_fufwd(fuFwdA[0+1]),.u1_A_fuufwd(fuuFwdA[0+1]),
    .u1_B_fufwd(fuFwdB[0+1]),.u1_B_fuufwd(fuuFwdB[0+1]),
    .u1_S_fufwd(fuFwdS[0+1]),.u1_S_fuufwd(fuuFwdS[0+1]),
  .u2_A(outDataA[0+2]),.u2_B(outDataB[0+2]),.u2_S(outDataS[0+2]),.u2_op(outOp[0+2]),
  .u2_ret(FUS_alu[1]),.u2_rten(enS_alu[1]),.u2_clkEn(outEn[0+2][0]&outEn[0+2][1]),
    .u2_A_fufwd(fuFwdA[0+2]),.u2_A_fuufwd(fuuFwdA[0+2]),
    .u2_B_fufwd(fuFwdB[0+2]),.u2_B_fuufwd(fuuFwdB[0+2]),
    .u2_S_fufwd(fuFwdS[0+2]),.u2_S_fuufwd(fuuFwdS[0+2]),
  .u3_A(outDataA[3+1]),.u3_B(outDataB[3+1]),.u3_S(outDataS[3+1]),.u3_op(outOp[3+1]),
  .u3_ret(FUS_alu[2]),.u3_rten(enS_alu[2]),.u3_clkEn(outEn[3+1][0]&outEn[3+1][1]),
    .u3_A_fufwd(fuFwdA[3+1]),.u3_A_fuufwd(fuuFwdA[3+1]),
    .u3_B_fufwd(fuFwdB[3+1]),.u3_B_fuufwd(fuuFwdB[3+1]),
    .u3_S_fufwd(fuFwdS[3+1]),.u3_S_fuufwd(fuuFwdS[3+1]),
  .u4_A(outDataA[3+2]),.u4_B(outDataB[3+2]),.u4_S(outDataS[3+2]),.u4_op(outOp[3+2]),
  .u4_ret(FUS_alu[3]),.u4_rten(enS_alu[3]),.u4_clkEn(outEn[3+2][0]&outEn[3+2][1]),
    .u4_A_fufwd(fuFwdA[3+2]),.u4_A_fuufwd(fuuFwdA[3+2]),
    .u4_B_fufwd(fuFwdB[3+2]),.u4_B_fuufwd(fuuFwdB[3+2]),
    .u4_S_fufwd(fuFwdS[3+2]),.u4_S_fuufwd(fuuFwdS[3+2]),
  .u5_A(outDataA[6+1]),.u5_B(outDataB[6+1]),.u5_S(outDataS[6+1]),.u5_nDataAlt(nDataAlt_reg[2][1]),.u5_op(outOp[6+1]),
  .u5_ret(FUS_alu[4]),.u5_rten(enS_alu[4]),.u5_clkEn(outEn[6+1][0]&outEn[6+1][1]),
    .u5_A_fufwd(fuFwdA[6+1]),.u5_A_fuufwd(fuuFwdA[6+1]),
    .u5_B_fufwd(fuFwdB[6+1]),.u5_B_fuufwd(fuuFwdB[6+1]),
    .u5_S_fufwd(fuFwdS[6+1]),.u5_S_fuufwd(fuuFwdS[6+1]),
  .u6_A(outDataA[6+2]),.u6_B(outDataB[6+2]),.u6_S(outDataS[6+2]),.u6_op(outOp[6+2]),
  .u6_ret(FUS_alu[4]),.u6_rten(enS_alu[4]),.u6_clkEn(outEn[6+2][0]&outEn[6+2][1]),
    .u6_A_fufwd(fuFwdA[6+2]),.u6_A_fuufwd(fuuFwdA[6+2]),
    .u6_B_fufwd(fuFwdB[6+2]),.u6_B_fuufwd(fuuFwdB[6+2]),
    .u6_S_fufwd(fuFwdS[6+2]),.u6_S_fuufwd(fuuFwdS[6+2]),
  .FU0(FU[0]), .FU1(FU[1]),  .FU2(FU[2]),  .FU3(FU[3]),
  .FU4(FU[4]), .FU5(FU[5]),  .FU6(FU[6]),  .FU7(FU[7]),
  .FU8(FU[8]), .FU9(FU[9]),
  .FUS1(FUS1),  .FUS2(FUS2),  .FUS3(FUS3),
  .FUS4(FUS4), .FUS5(FUS5),  .FUS6(FUS6),  .FUS7(FUS7),
  .FUS8(FUS8),.FUS9(FUS9),
  .fxFRT_alten_reg(fxFRT_alten_reg[2]),
  .fcvtout({FUTYPE,FUCVT2}), //might need less than 6 regs due to internal regs
  .DataAlt(dalt),
  .FUCVTIN(FUCVT1[63:0])
  ); 

  assign nDataAlt[2][2]=~dalt[1];
  assign nDataAlt[2][0]=~dalt[0];
 
  agu_block #(BUS_ID) agu_aligned(
  .clk(clk), .rst(rst),
  .except(except),
  .excpt_gate(),
  .excpt_in_vm(),
  .excpt_in_km(),
  .pause_agu(pause_agu),
  .miss_holds_agu(miss_holds_agu),
  .miss_pause_agu(miss_pause_agu),
  .wt_pause_agu(wt_pause_agu),
  .mOp_write_clear(mOp_write_clear),
  .u1_base(outDataB[0]),.u1_index(outDataA[0]),.u1_const(outDataC[0]),
  .u1_base_fufwd(fuFwdB[0]),.u1_base_fuufwd(fuuFwdB[0]),
  .u1_index_fufwd(fuFwdA[0]),.u1_index_fuufwd(fuuFwdA[0]),
  .u1_op(outOp[0]),.u1_reg(outReg[0]),
  .u1_LSQ_no(outLSQ[0]),.u1_II_no(outII[0]),.u1_WQ_no(outWQ[0]),
  .u1_lsflag(outLSflag[0]),.u1_clkEn(outEn[0][0]),
  .u1_attr(outAttr[0]),
  .u2_base(outDataB[3]),.u2_index(outDataA[3]),.u2_const(outDataC[1]),
  .u2_base_fufwd(fuFwdB[3]),.u2_base_fuufwd(fuuFwdB[3]),
  .u2_index_fufwd(fuFwdA[3]),.u2_index_fuufwd(fuuFwdA[3]),
  .u2_op(outOp[3]),.u2_reg(outReg[3]),
  .u2_LSQ_no(outLSQ[1]),.u2_II_no(outII[3]),.u2_WQ_no(outWQ[1]),
  .u2_lsflag(outLSflag[1]),.u2_clkEn(outEn[3][0]),
  .u2_attr(outAttr[3]),
  .u3_base(outDataB[6]),.u3_index(outDataA[6]),.u3_const(outDataC[6]),
  .u3_base_fufwd(fuFwdB[6]),.u3_base_fuufwd(fuuFwdB[6]),
  .u3_index_fufwd(fuFwdA[6]),.u3_index_fuufwd(fuuFwdA[6]),
  .u3_op(outOp[6]),.u3_reg(outReg[6]),
  .u3_LSQ_no(outLSQ[2]),.u3_II_no(outII[6]),.u3_WQ_no(outWQ[2]),
  .u3_lsflag(outLSflag[2]),.u3_clkEn(outEn[6][0]),
  .u3_attr(outAttr[6]),
  .u4_base(WoutDataB[0]),.u4_index(WoutDataA[0]),.u4_const(WoutDataC[0]),
  .u4_base_fufwd(WfuFwdB[0]),.u4_base_fuufwd(WfuuFwdB[0]),
  .u4_index_fufwd(WfuFwdA[0]),.u4_index_fuufwd(WfuuFwdA[0]),
  .u4_op(WoutOp[0]),.u4_reg(9'b0),
  .u4_LSQ_no(WoutLSQ[0]),.u4_II_no(WoutII[0]),.u4_WQ_no(WoutWQ[0]),
  .u4_lsflag(WoutLSflag[0]),.u4_clkEn(WoutDataEn[0][0]),
  .u4_attr(WoutAttr[0]),
  .u5_base(WoutDataB[1]),.u5_index(WoutDataA[1]),.u5_const(WoutDataC[1]),
  .u5_base_fufwd(WfuFwdB[1]),.u5_base_fuufwd(WfuuFwdB[1]),
  .u5_index_fufwd(WfuFwdA[1]),.u5_index_fuufwd(WfuuFwdA[1]),
  .u5_op(WoutOp[1]),.u5_reg(9'b0),
  .u5_LSQ_no(WoutLSQ[1]),.u5_II_no(WoutII[1]),.u5_WQ_no(WoutWQ[1]),
  .u5_lsflag(WoutLSflag[1]),.u5_clkEn(WoutDataEn[1][0]),
  .u5_attr(WoutAttr[1]),
  .mOp0_clHit(dc_rdHitCl[0]),.mOp1_clHit(dc_rdHitCl[1]),.mOp2_clHit(dc_rdHitCl[2]),.mOp3_clHit(dc_rdHitCl[3]),
  miss4,
  .mOpY4_en(st0_en),
  .mOpY4_hit(dc_wrHit[0]),
  .mOpY4_dupl(dc_wrDuplCl[0]),//write to a non-exclusive cl
  //mOp4_thread,
  .mOpY4_addrEven(st0_adata[`lsaddr_addrE]),
  .mOpY4_addrOdd(st0_adata[`lsaddr_addrO]),
  .mOpY4_sz(st0_adata[`lsaddr_sz]),
  .mOpY4_first(1'b0),
  .mOpY4_banks(st0_adata[`lsaddr_banks]),//?? st0_banks?
  .mOpY4_bank0(st0_adata[`lsaddr_bank0]),
  .mOpY4_bank1(st0_bank1),
  .mOpY4_bgn_b(st0_bgn_ben),
  .mOpY4_end_b(st0_end_ben),
  .mOpY4_odd(st0_adata[`lsaddr_odd]),
  .mOpY4_addr_low(st0_adata[`lsaddr_low]),
  .mOpY4_split(st0_adata[`lsaddr_split]),
  .mOpY4_clHit(dc_wrHitCl[0]),
  .mOpY4_data(st0_data),
  .mOpY4_type(st0_adata[`lsaddr_mtype]),
  .mOpY4_II(st0_adata[`lsaddr_II]),
  .mOpY4_en_o(dc_wrEn[0]),
  .mOpY4_addrEven_o(dc_wrAddrE[0]),
  .mOpY4_addrOdd_o(dc_wrAddrO[0]),
  .mOpY4_sz_o(),
  .mOpY4_first_o(write_clear),
  .mOpY4_banks_o(dc_wrBanks[0]),
  .mOpY4_bank0_o(dc_wrBegin[0]),
  .mOpY4_bank1_o(dc_wrEnd[0]),
  .mOpY4_bgn_b_o(dc_wrBGN_BNK[0]),
  .mOpY4_end_b_o(dc_wrEND_BNK[0]),
  .mOpY4_odd_o(dc_odd_wr[0]),
  .mOpY4_addr_low_o(),
  .mOpY4_split_o(dc_split_wr[0]),
//  mOpY4_clHit_o,
  .mOpY4_data_o(dc_wdata[0]),
  .mOpY4_type_o(),
  .mOpY4_II_o(),
  miss5,
  .mOpY5_en(st1_en),
  .mOpY5_hit(dc_wrHit[1]),
  .mOpY5_dupl(dc_wrDuplCl[1]),//write to a non-exclusive cl
  //mOp4_thread,
  .mOpY5_addrEven(st0_adata[`lsaddr_addrE]),
  .mOpY5_addrOdd(st0_adata[`lsaddr_addrO]),
  .mOpY5_sz(st0_adata[`lsaddr_sz]),
  .mOpY5_first(1'b0),
  .mOpY5_banks(st1_adata[`lsaddr_banks]),//?? st1_banks?
  .mOpY5_bank0(st1_adata[`lsaddr_bank0]),
  .mOpY5_bank1(st1_bank1),
  .mOpY5_bgn_b(st1_bgn_ben),
  .mOpY5_end_b(st1_end_ben),
  .mOpY5_odd(st1_adata[`lsaddr_odd]),
  .mOpY5_addr_low(st1_adata[`lsaddr_low]),
  .mOpY5_split(st1_adata[`lsaddr_split]),
  .mOpY5_clHit(dc_wrHitCl[1]),
  .mOpY5_data(st1_data),
  .mOpY5_type(st1_adata[`lsaddr_mtype]),
  .mOpY5_II(st1_adata[`lsaddr_II]),
  .mOpY5_en_o(dc_wrEn[1]),
  .mOpY5_addrEven_o(dc_wrAddrE[1]),
  .mOpY5_addrOdd_o(dc_wrAddrO[1]),
  .mOpY5_sz_o(),
  .mOpY5_first_o(),
  .mOpY5_banks_o(dc_wrBanks[1]),
  .mOpY5_bank0_o(dc_wrBegin[1]),
  .mOpY5_bank1_o(dc_wrEnd[1]),
  .mOpY5_bgn_b_o(dc_wrBGN_BNK[1]),
  .mOpY5_end_b_o(dc_wrEND_BNK[1]),
  .mOpY5_odd_o(dc_odd_wr[1]),
  .mOpY5_addr_low_o(),
  .mOpY5_split_o(dc_split_wr[1]),
//  mOpY5_clHit_o,
  .mOpY5_data_o(dc_wdata[1]),
  .mOpY5_type_o(),
  .mOpY5_II_o(),
  .lso_adata(lso_adata),.lso_xdataA(lso_en<<11),.lso_data(lso_data),.lso_bnkread(lso_bnkread),
  .lso2_adata(lso2_adata),.lso2_xdataA(lso2_en<<11),.lso2_data(lso2_data),.lso2_bnkread(lso2_bnkread),
  .lso2_wb_en({lso2_en && (lso2_adata[`lsaddr_reg_low]==2 || lso2_adata[`lsaddr_reg_low]==5 || lso2_adata[`lsaddr_reg_low]==8 ),
    lso2_en && (lso2_adata[`lsaddr_reg_low]==1 || lso2_adata[`lsaddr_reg_low]==4 || lso2_adata[`lsaddr_reg_low]==7 ),
    lso2_en && (lso2_adata[`lsaddr_reg_low]==0 || lso2_adata[`lsaddr_reg_low]==3 || lso2_adata[`lsaddr_reg_low]==6 )}),
  .p0_adata(lsr_wr_data[0]),.p0_banks(dc_rdBanks[0]),.p0_LSQ(dc_LSQ[0]),
    .p0_en(dc_rdEn[0]),.p0_rsEn(dc_rsEn[0]),p0_secq,p0_ret,p0_repl,p0_lsfwd,
  .p1_adata(lsr_wr_data[1]),.p1_banks(dc_rdBanks[1]),.p1_LSQ(dc_LSQ[1]),
    .p1_en(dc_rdEn[1]),.p1_rsEn(dc_rsEn[1]),p1_secq,p1_ret,p1_repl,p1_lsfwd,
  .p2_adata(lsr_wr_data[2]),.p2_banks(dc_rdBanks[2]),.p2_LSQ(dc_LSQ[2]),
    .p2_en(dc_rdEn[2]),.p2_rsEn(dc_rsEn[2]),p2_secq,p2_ret,p2_repl,p2_lsfwd,p2_data,p2_brdbanks,
  .p3_adata(lsr_wr_data[3]),.p3_banks(dc_rdBanks[3]),.p3_LSQ(dc_LSQ[3]),
    .p3_en(dc_rdEn[3]),.p3_rsEn(dc_rsEn[3]),p3_ioEn,p3_io_ack,p3_ret,p3_data,p3_brdbanks,p3_repl,p3_lsfwd,
  .p4_adata(lsr_wr_data[4]),.p4_LSQ(),p4_en,p4_secq,p4_ret,
  .p5_adata(lsr_wr_data[5]),.p5_LSQ(),p5_en,p5_secq,p5_ret,
  .FU0Hit(FU0Hit),.FU1Hit(FU1Hit),.FU2Hit(FU2Hit),.FU3Hit(FU3Hit),
  .FU0(FU[0]),.FU1(FU[1]),.FU2(FU[2]),.FU3(FU[3]),.FU4(FU[4]),.FU5(FU[5]),.FU6(FU[6]),.FU7(FU[7]),.FU8(FU[8]),.FU9(FU[9]),
  .FUreg3_reg(FUreg_reg5[3]),.dc_rdataA(dc_rdataA[3]),//is it really reg5?
  msi_exp_addr,msi_en,msi_out_clear,//msi_out_clear=can do msi en
  .csrss_en(csrss_en),.csrss_addr(csrss_addr),.csrss_data(csrss_data),
  alt_bus_hold,
  alt_bus_addr,
  .req_addr(req_addr),.req_tlbAttr(req_tlbAttr),.req_tlbEn(req_tlbEn),
  .bus_tlb_data(bus_tlb_data),.bus_tlb_en(bus_tlb_en),
  .reqBus_en(reqBus_en),
  .reqBus_addr(reqBus_addr),
  .reqBus_req(reqBus_req),
  .reqBus_want_excl(reqBus_want_excl),
  .reqBus_dupl(reqBus_dupl),
  .reqBus_io(reqBus_io),
  .reqBus_sz(reqBus_sz),
  .reqBus_low(reqBus_low),
  .reqBus_bank0(reqBus_bank0),
  .insert_isData(insert_isData),
  .insBus_req(insBus_req),
  .wr0_hit(wr0_hit),
  .wr0_addrE(wr0_addrE),.wr0_addrO(wr0_addrO),
  .wr0_banks(wr0_banks),
  .wr0_begin(wr0_begin),.wr0_end(wr0_end),
  .wr0_bgn_ben(wr0_bgn_ben),.wr0_end_ben(wr0_end_ben),
  .wr0_odd(wr0_odd),.wr0_split(wr0_split),
  .wr0_data(wr0_data),
  .wr1_hit(wr1_hit),
  .wr1_addrE(wr1_addrE),.wr1_addrO(wr1_addrO),
  .wr1_banks(wr1_banks),
  .wr1_begin(wr1_begin),.wr1_end(wr1_end),
  .wr1_bgn_ben(wr1_bgn_ben),.wr1_end_ben(wr1_end_ben),
  .wr1_odd(wr1_odd),.wr1_split(wr1_split),
  .wr1_data(wr1_data),
  .wrStall(wrStall)
  );
 
  fun_lsq LSQ_grouped(
  .clk(clk),
  .rst(rst),
  .except(except),
  .bus_holds_agu_reg2(bus_holds_agu_reg2),
  .miss_holds_agu_reg2(miss_holds_agu_reg2),
  .miss_pause_agu_reg2(miss_pause_agu_reg2),
  .insert_isData_reg2(insert_isData_reg2),
  .pause_agu(pause_agu),.WDoRsPause(WDoRsPause),
  .p0_adata(lsr_wr_data[0]),.p0_LSQ(dc_LSQ[0]),.p0_en(dc_rdEn[0]),.p0_rsEn(dc_rsEn[0]),p0_smpc,p0_lsfwd,
  .p1_adata(lsr_wr_data[1]),.p1_LSQ(dc_LSQ[1]),.p1_en(dc_rdEn[1]),.p1_rsEn(dc_rsEn[1]),p1_smpc,p1_lsfwd,
  .p2_adata(lsr_wr_data[2]),.p2_LSQ(dc_LSQ[2]),.p2_en(dc_rdEn[2]),.p2_rsEn(dc_rsEn[2]),p2_smpc,p2_lsfwd,
  .p3_adata(lsr_wr_data[3]),.p3_LSQ(dc_LSQ[3]),.p3_en(dc_rdEn[3]),.p3_rsEn(dc_rsEn[3]),p3_smpc,p3_lsfwd,
  .p4_adata(lsr_wr_data[4]),.p4_LSQ,p4_en,
  .p5_adata(lsr_wr_data[5]),.p5_LSQ,p5_en,
  .FU0Hit(FU0Hit),
  .FU1Hit(FU1Hit),
  .FU2Hit(FU2Hit),
  .FU3Hit(FU3Hit),
  st_stall,
  .st0_adata(st0_adata),.st0_en(st0_en),.st0_bank1(st0_bank1),.st0_bgn_ben(st0_bgn_ben),.st0_end_ben(st0_end_ben),.st0_data(st0_data),
  .st1_adata(st1_adata),.st1_en(st1_en),.st1_bank1(st1_bank1),.st1_bgn_ben(st1_bgn_ben),.st1_end_ben(st1_end_ben),.st1_data(st1_data),
  .wb0_adata(lso_adata),.wb0_LSQ(lso_LSQ),.wb0_en(lso_en),.wb0_ret(),.wb0_data(lso_data),.wb0_brdbanks(lso_brdbanks),
  .wb1_adata(lso2_adata),.wb1_LSQ(lso2_LSQ),.wb1_en(lso2_en),.wb1_ret(),.wb1_data(lso2_data),.wb1_brdbanks(lso2_brdbanks),
  .mem_II_upper(retM_II0),
  .mem_II_upper_in(retM_II),
  .mem_II_bits_fine(retM_fine),
  .mem_II_bits_ldconfl(retM_ldconfl),
  .mem_II_bits_waitconfl(retM_waitconfl),
  .mem_II_bits_except(retM_excpt),
  .mem_II_bits_ret(retM_ret),
  .mem_II_exbitsx6(retM_exbits),
  .mem_II_stall(bDoStall_rqSpit),
  .mem_II_stall2(bDoStall_rqSpit0),
  .doStall_rs(doStall_rs),.stall_cntrl(stall_cntrl), 
  .doStall_alloc(doStall_alloc),.doStall_cntrl(doStall_cntrl),
  .doStall_WQ(doStall_WQ),.stall_WQ(stall_WQ),
  .doRetire_d(doRetire_d),
  .xbreak(xbreak),
  .has_xbreak(has_xbreak),
  .ldq_new_mask_reg(ldq_new_mask_reg),.bundle_in_reg2(bundle_in_reg2),.II_upper(II_upper),.LSQ_shr_data(LSQ_shr_data),
  .WQS0_reg(WQS0_reg),.WQR0_reg(WQR0_reg),
  .WQS1_reg(WQS1_reg),.WQR1_reg(WQR1_reg),
  .WQS2_reg(WQS2_reg),.WQR2_reg(WQR2_reg),
  .lsw_wq0(WDfxWQ_reg3[0]),.lsw_wdata0(lsw_wdata[0]),.lsw_rs_en0(WDfxDataEn_reg3[0]),
  .lsw_wq1(WDfxWQ_reg3[1]),.lsw_wdata1(lsw_wdata[1]),.lsw_rs_en1(WDfxDataEn_reg3[1]),
  .mOpY4_II(dc_II_wr_reg3[0]),.mOpY4_hit(dc_wrHit[0]),
  .mOpY5_II(dc_II_wr_reg3[1]),.mOpY5_hit(dc_wrHit[1]),
  .lsi0_reg(lsi0_reg),.lsi1_reg(lsi1_reg),.lsi2_reg(lsi2_reg),
  MSI_exp_addr,MSI_en,
  .doStall_STQ(doStall_STQ),
  .doStall_LDQ(doStall_LDQ),
  .doStall_LSQ(doStall_LSQ) 
  );

  
  dmisscam mcam_mod(
  .clk(clk),
  .rst(rst),
  .fill_en(miss_en_reg),
  .fill_addr(mcam_addr_reg),
  .fill_st(miss_st_reg),
  .fill_req(mcam_req),
  .ins_en(insert_isData),
  .ins_req(insBus_req[3:0]),
  .has_free(mcam_hasfree),
  .fill_match(mcam_dupl),
  .locked(mcam_locked),
  .begin_replay(mcam_replay),
  .unlock(miss_unlock)
  );
  
  
  mreq #(BUS_ID) mreq_addr_mod(
  .clk(clk),
  .rst(rst),
  .nextReq(mcam_req),
  .reqSend(mcam_do_req),
  .reqAddr(mcam_addr_reg),
  .insReq(insBus_req),
  .insAddr(insert_addr),
  .insEn(insBus_en),
  .insEn_data(insert_isData),
  .insEn_code(insert_isCode)
  );


  get_LDQ_new_en ldq_new_mod(
  rs_port[0],rs_ldst_flg[0], 
  rs_port[3],rs_ldst_flg[3], 
  rs_port[6],rs_ldst_flg[6], 
  rs_port[1],rs_ldst_flg[1], 
  rs_port[4],rs_ldst_flg[4], 
  rs_port[7],rs_ldst_flg[7],
  ldq_new_mask);

  
  get_wSwp wSwp_mod(
  .clk(clk),.rst(rst),
  .lsi0(get_lsi(rs_lsi[0])),.st0(rs_port[0]==PORT_STORE),
  .lsi1(get_lsi(rs_lsi[1])),.st1(rs_port[3]==PORT_STORE),
  .lsi2(get_lsi(rs_lsi[2])),.st2(rs_port[6]==PORT_STORE),
  .Wswp(Wswp),
  .lsiA(LSQ_lsqA[2:0]),
  .lsiB(LSQ_lsqB[2:0]),
  .port0(Wport[0]),.port1(Wport[1]),.port2(Wport[2]),
  .domA0(rs_rA_isAnyV[0] ? ~domA[0][0] : ~rs_rA_isV[0]),.domB0(rs_rB_isAnyV[0] ? ~domB[0][0] : ~rs_rB_isV[0]),
  .domA1(rs_rA_isAnyV[3] ? ~domA[3][0] : ~rs_rA_isV[3]),.domB1(rs_rB_isAnyV[3] ? ~domB[3][0] : ~rs_rB_isV[3]),
  .domA2(rs_rA_isAnyV[6] ? ~domA[6][0] : ~rs_rA_isV[6]),.domB2(rs_rB_isAnyV[6] ? ~domB[6][0] : ~rs_rB_isV[6]),
  .rA_useF0(rs_rA_useF[0]),.rB_useF0(rs_rB_useF[0]),
  .rA_useF1(rs_rA_useF[3]),.rB_useF1(rs_rB_useF[3]),
  .rA_useF2(rs_rA_useF[6]),.rB_useF2(rs_rB_useF[6]),
  .op0(rs_operation[0]),.op1(rs_operation[3]),.op2(rs_operation[6]),
  .opA(WopA),.opB(WopB),
  .ind0(rs_index[0]),.ind1(rs_index[3]),.ind2(rs_index[6]),
  .indA(LSQ_indA),.indB(LSQ_indB),
  .wq0(WQR[0]),.wq1(WQR[1]),.wq2(WQR[2]),
  .wqA(LSQ_wqA),.wqB(LSQ_wqB)
  );

  get_wrtII wrtII_mod(
  .wrt0(wrt0_reg),.wrt1(wrt1_reg),.wrt2(wrt2_reg),
  .lsi0(rs_lsi[0]),.lsi1(rs_lsi[1]),.lsi2(rs_lsi[2]),
  .II0(rs0i0_index_reg),.II1(rs1i0_index_reg),.II2(rs2i0_index_reg),
  .wrtII0(wrtII0),.wrtII1(wrtII1),.wrtII2(wrtII2),
  .wrtO0(wrtO0),.wrtO1(wrtO1),.wrtO2(wrtO2)
  );
  
  backend_get_ret ret_mod(
  .newR0(newR[0]),.newR1(newR[1]),.newR2(newR[2]),
  .newR3(newR[3]),.newR4(newR[4]),.newR5(newR[5]),
  .newR6(newR[6]),.newR7(newR[7]),.newR8(newR[8]),
  .en0(rs_rT_use[0]|rs_rT_useF[0]),.en1(rs_rT_use[1]|rs_rT_useF[1]),
  .en2(rs_rT_use[2]|rs_rT_useF[2]),.en3(rs_rT_use[3]|rs_rT_useF[3]),
  .en4(rs_rT_use[4]|rs_rT_useF[4]),.en5(rs_rT_use[5]|rs_rT_useF[5]),
  .en6(rs_rT_use[6]|rs_rT_useF[6]),.en7(rs_rT_use[7]|rs_rT_useF[7]),.en8(rs_rT_use[8]|rs_rT_useF[8]), 
  .rs_index0(rs_index[0]),.rs_index1(rs_index[1]),.rs_index2(rs_index[2]),.rs_index3(rs_index[3]),
  .rs_index4(rs_index[4]),.rs_index5(rs_index[5]),.rs_index6(rs_index[6]),.rs_index7(rs_index[7]),
  .rs_index8(rs_index[8]),
  .ret0(instr_ret[0]),.ret1(instr_ret[1]),.ret2(instr_ret[2]),
  .ret3(instr_ret[3]),.ret4(instr_ret[4]),.ret5(instr_ret[5]),
  .ret6(instr_ret[6]),.ret7(instr_ret[7]),.ret8(instr_ret[8])
  );
 

  get_lsi_en sliMask_mod(
    rs_lsi_reg[0],rs_ldst_flg_reg[0]&~rs_operation_reg[0][0],
    rs_lsi_reg[3],rs_ldst_flg_reg[1]&~rs_operation_reg[1][0],
    rs_lsi_reg[1],rs_ldst_flg_reg[2]&~rs_operation_reg[3][0],
    rs_lsi_reg[4],rs_ldst_flg_reg[3]&~rs_operation_reg[4][0],
    rs_lsi_reg[2],rs_ldst_flg_reg[4]&~rs_operation_reg[6][0],
    rs_lsi_reg[5],rs_ldst_flg_reg[5]&~rs_operation_reg[7][0],
    lsi_bits);

  alloc_WQ WQget_mod(
  .clk(clk),
  .rst(rst),
  .stall(stall_WQ),
  .doStall(doStall_WQ),
  .newEn(bundle_in_reg),
  .newThr(thread_reg),
  .except(except),
  .except_thread(excpt_thread),
  .except_both(excpt_both),
  .wrt0(wrt0_reg),.wrt1(wrt1_reg),.wrt2(wrt2_reg),
  .lsi0(rs_lsi[0]),.lsi1(rs_lsi[1]),.lsi2(rs_lsi[2]),
  .WQr0(WQR[0]),.WQr1(WQR[1]),.WQr2(WQR[2]),
  .WQs0(WQS[0]),.WQs1(WQS[1]),.WQs2(WQS[2]),
  .free0(wreq_en[0]),.freeWQ0(wreq_data[0][`lsaddr_WQ]),
  .free1(wreq_en[1]),.freeWQ1(wreq_data[1][`lsaddr_WQ])
  );

dcache1 L1D_mod(
  .clk(clk),
  .rst(rst),
  .read_addrE0(dc_rdAddrE[0]), .read_addrO0(dc_rdAddrO[0]), .read_bank0(dc_rdBanks[0]), .read_clkEn0(dc_rdEn[0]), .read_hit0(FU0HitP),
     .read_hitCl0(dc_rdHitCl[0]),.read_odd0(dc_odd[0]), .read_split0(dc_split[0]), .read_dataA0(dc_rdataA[0]), 
    .read_beginA0(dc_rdBeginA[0]), .read_low0(dc_low[0]), .read_sz0(dc_size[0]),
  .read_addrE1(dc_rdAddrE[1]), .read_addrO1(dc_rdAddrO[1]), .read_bank1(dc_rdBanks[1]), .read_clkEn1(dc_rdEn[1]), .read_hit1(FU1HitP),   
    .read_hitCl1(dc_rdHitCl[1]),.read_odd1(dc_odd[1]), .read_split1(dc_split[1]), .read_dataA1(dc_rdataA[1]), 
    .read_beginA1(dc_rdBeginA[1]), .read_low1(dc_low[1]), .read_sz1(dc_size[1]),
  .read_addrE2(dc_rdAddrE[2]), .read_addrO2(dc_rdAddrO[2]), .read_bank2(dc_rdBanks[2]), .read_clkEn2(dc_rdEn[2]), .read_hit2(FU2HitP),   
    .read_hitCl2(dc_rdHitCl[2]),.read_odd2(dc_odd[2]), .read_split2(dc_split[2]), .read_dataA2(dc_rdataA[2]),
    .read_beginA2(dc_rdBeginA[2]), .read_low2(dc_low[2]), .read_sz2(dc_size[2]),
  .read_addrE3(dc_rdAddrE[3]), .read_addrO3(dc_rdAddrO[3]), .read_bank3(dc_rdBanks[3]), .read_clkEn3(dc_rdEn[3]), .read_hit3(FU3HitP),   
    .read_hitCl3(dc_rdHitCl[3]),.read_odd3(dc_odd[3]), .read_split3(dc_split[3]), .read_dataA3(dc_rdataA[3]),
    .read_beginA3(dc_rdBeginA[3]), .read_low3(dc_low[3]), .read_sz3(dc_size[3]),
  .read_bankNoRead(dc_bankNone),
  .read_invalidate(1'b0),
  .expun_addr(),
  .expun_en(),
  .insert_from_ram(),//no need to implement. was going to be spectre protection
  .write_addrE0(dc_wrAddrE[0]),
  .write_addrO0(dc_wrAddrO[0]),
  .write_bank0(dc_wrBanks[0]),
  .write_clkEn0(dc_wrEn[0]),
  .write_hit0(dc_wrHit[0]),
  .write_hitCl0(dc_wrHitCl[0]),
  .write_dupl0(dc_wrDuplCl[0]),
  .write_split0(dc_split_wr[0]),
  .write_odd0(dc_odd_wr[0]),
  .write_begin0(dc_wrBegin[0]),
  .write_end0(dc_wrEnd[0]),
  .write_bgnBen0(dc_wrBGN_BNK[0]),
  .write_endBen0(dc_wrEND_BNK[0]),
  .write_data0(dc_wdata[0]),
  .write_addrE1(dc_wrAddrE[1]),
  .write_addrO1(dc_wrAddrO[1]),
  .write_bank1(dc_wrBanks[1]),
  .write_clkEn1(dc_wrEn[1]),
  .write_hit1(dc_wrHit[1]),
  .write_hitCl1(dc_wrHitCl[1]),
  .write_dupl1(dc_wrDuplCl[1]),
  .write_split1(dc_split_wr[1]),
  .write_odd1(dc_odd_wr[1]),
  .write_begin1(dc_wrBegin[1]),
  .write_end1(dc_wrEnd[1]),
  .write_bgnBen1(dc_wrBGN_BNK[1]),
  .write_endBen1(dc_wrEND_BNK[1]),
  .write_data1(dc_wdata[1]),
  .write_clear(write_clear),
  .insert_en(insert_isData_reg3),
  .insert_exclusive(insBus_exclusive_reg3),
  .insert_dirty(insBus_dirty_reg3),
  //.wb_en,
  //.busWb_data
  .busIns_data(insBus_data_reg2),
  .insbus_A(insert_isData_reg2),
  .insbus_B(insert_isData_reg3)
  );
  
 
  
  cntrl_find_outcome cntrl_unit_mod(
  .clk(clk),.rst(rst),
  .stall(stall_cntrl),.doStall(doStall_cntrl),
  .new_en(bundle_in_reg2),
  .new_thread(thread_reg2),
  .new_addr(II_upper),
  .except(except),
  .exceptIP(exceptIP),
  .except_thread(excpt_thread),
  .except_both(excpt_both),
  .except_due_jump(excpt_due_jump),
  .except_jump_ght(excpt_ght),
  .except_set_instr_flag(except_set_flag),
  .except_jmp_mask_en(except_jmp_mask_en),
  .except_jmp_mask(except_jmp_mask),
  .csrss_no(csrss_no),.csrss_thread(csrss_thread),.csrss_en(csrss_en),.csrss_data(csrss_data),
  .instr0_en(instr_en_reg[0]),.instr0_wren(instr_wren_reg[0]),.instr0_IPOff(instr_IPOff_reg[0]),
    .instr0_magic(instr_magicOff[0]),.instr0_last(instr_last_reg[0]),
  .instr1_en(instr_en_reg[1]),.instr1_wren(instr_wren_reg[1]),.instr1_IPOff(instr_IPOff_reg[1]),
    .instr1_magic(instr_magicOff[1]),.instr1_last(instr_last_reg[1]),
  .instr2_en(instr_en_reg[2]),.instr2_wren(instr_wren_reg[2]),.instr2_IPOff(instr_IPOff_reg[2]),
    .instr2_magic(instr_magicOff[2]),.instr2_last(instr_last_reg[2]),
  .instr3_en(instr_en_reg[3]),.instr3_wren(instr_wren_reg[3]),.instr3_IPOff(instr_IPOff_reg[3]),
    .instr3_magic(instr_magicOff[3]),.instr3_last(instr_last_reg[3]),
  .instr4_en(instr_en_reg[4]),.instr4_wren(instr_wren_reg[4]),.instr4_IPOff(instr_IPOff_reg[4]),
    .instr4_magic(instr_magicOff[4]),.instr4_last(instr_last_reg[4]),
  .instr5_en(instr_en_reg[5]),.instr5_wren(instr_wren_reg[5]),.instr5_IPOff(instr_IPOff_reg[5]),
    .instr5_magic(instr_magicOff[5]),.instr5_last(instr_last_reg[5]),
  .instr6_en(instr_en_reg[6]),.instr6_wren(instr_wren_reg[6]),.instr6_IPOff(instr_IPOff_reg[6]),
    .instr6_magic(instr_magicOff[6]),.instr6_last(instr_last_reg[6]),
  .instr7_en(instr_en_reg[7]),.instr7_wren(instr_wren_reg[7]),.instr7_IPOff(instr_IPOff_reg[7]),
    .instr7_magic(instr_magicOff[7]),.instr7_last(instr_last_reg[7]),
  .instr8_en(instr_en_reg[8]),.instr8_wren(instr_wren_reg[8]),.instr8_IPOff(instr_IPOff_reg[8]),
    .instr8_magic(instr_magicOff[8]),.instr8_last(instr_last_reg[8]),
  .instr9_en(instr_en_reg[9]),.instr9_wren(instr_wren_reg[9]),.instr9_IPOff(instr_IPOff_reg[9]),
    .instr9_magic(instr_magicOff[9]),.instr9_last(instr_last_reg[9]),
  .instr0_rT(instr_rT_reg[0]),.instr0_gen(instr_gen[0]),.instr0_vec(instr_vec[0]),
  .instr1_rT(instr_rT_reg[1]),.instr1_gen(instr_gen[1]),.instr1_vec(instr_vec[1]),
  .instr2_rT(instr_rT_reg[2]),.instr2_gen(instr_gen[2]),.instr2_vec(instr_vec[2]),
  .instr3_rT(instr_rT_reg[3]),.instr3_gen(instr_gen[3]),.instr3_vec(instr_vec[3]),
  .instr4_rT(instr_rT_reg[4]),.instr4_gen(instr_gen[4]),.instr4_vec(instr_vec[4]),
  .instr5_rT(instr_rT_reg[5]),.instr5_gen(instr_gen[5]),.instr5_vec(instr_vec[5]),
  .instr6_rT(instr_rT_reg[6]),.instr6_gen(instr_gen[6]),.instr6_vec(instr_vec[6]),
  .instr7_rT(instr_rT_reg[7]),.instr7_gen(instr_gen[7]),.instr7_vec(instr_vec[7]),
  .instr8_rT(instr_rT_reg[8]),.instr8_gen(instr_gen[8]),.instr8_vec(instr_vec[8]),
  .instr9_rT(instr_rT_reg[9]),.instr9_gen(instr_gen[9]),.instr9_vec(instr_vec[9]),
  .instr0_after_spec(instr_aft_spc_reg[0]),  .instr1_after_spec(instr_aft_spc_reg[1]),
  .instr2_after_spec(instr_aft_spc_reg[2]),  .instr3_after_spec(instr_aft_spc_reg[3]),
  .instr4_after_spec(instr_aft_spc_reg[4]),  .instr5_after_spec(instr_aft_spc_reg[5]),
  .instr6_after_spec(instr_aft_spc_reg[6]),  .instr7_after_spec(instr_aft_spc_reg[7]),
  .instr8_after_spec(instr_aft_spc_reg[8]),  .instr9_after_spec(instr_aft_spc_reg[9]),
  .instr_attr(newAttr_reg2),
  .iret0(instr_ret_reg[0]),.iret1(instr_ret_reg[1]),.iret2(instr_ret_reg[2]),.iret3(instr_ret_reg[3]),.iret4(instr_ret_reg[4]),
  .iret5(instr_ret_reg[5]),.iret6(instr_ret_reg[6]),.iret7(instr_ret_reg[7]),.iret8(instr_ret_reg[8]),
  .iret0_rF(clrR_reg[0][8:4]),.iret1_rF(clrR_reg[1][8:4]),.iret2_rF(clrR_reg[2][8:4]),
  .iret3_rF(clrR_reg[3][8:4]),.iret4_rF(clrR_reg[4][8:4]),.iret5_rF(clrR_reg[5][8:4]),
  .iret6_rF(clrR_reg[6][8:4]),.iret7_rF(clrR_reg[7][8:4]),.iret8_rF(clrR_reg[8][8:4]),
  .iret_clr(clr_reg),
  .ijump0Type(jump0Type_reg2),.ijump0Off(jump0Pos_reg2),
  .ijump0IP(jump0IP_reg2[43:0]),.ijump0Mask(jump0Mask_reg2),.ijump0BND(jump0IP_reg2[63:44]),
  .ijump1Type(jump1Type_reg2),.ijump1Off(jump1Pos_reg2),
  .ijump1IP(jump1IP_reg2[43:0]),.ijump1Mask(jump1Mask_reg2),.ijump1BND(jump1IP_reg2[63:44]),
  .ijump0BtbWay(jump0TbufWay_reg2),.ijump0JmpInd(jump0JmpInd_reg2),.ijump0GHT(jump0GHT_reg2),
  .ijump1BtbWay(jump1TbufWay_reg2),.ijump1JmpInd(jump1JmpInd_reg2),.ijump1GHT(jump1GHT_reg2),
  .ijump0SC(jump0SC_reg2),.ijump0Miss(jump0Miss_reg2),.ijump0BtbOnly(jump0TbufOnly_reg2),
  .ijump1SC(jump1SC_reg2),.ijump1Miss(jump1Miss_reg2),.ijump1BtbOnly(jump1TbufOnly_reg2),
  .itk_after(instr_afterTaken_reg),.ifsimd(instr_fsimd_reg2),
  .iJump0Taken(jump0Pred_reg2),.iJump1Taken(jump1Pred_reg2),
  .flTE(retfl_rF),.retire_enFl(retfl_enG),
  .retire0_rT(retire0_rT),.retire0_rF(retire0_rF),.retire0_enG(retire0_enG),.retire0_enV(retire0_enV),.retire0_enF(retire0_enF),
  .retire1_rT(retire1_rT),.retire1_rF(retire1_rF),.retire1_enG(retire1_enG),.retire1_enV(retire1_enV),.retire1_enF(retire1_enF),
  .retire2_rT(retire2_rT),.retire2_rF(retire2_rF),.retire2_enG(retire2_enG),.retire2_enV(retire2_enV),.retire2_enF(retire2_enF),
  .retire3_rT(retire3_rT),.retire3_rF(retire3_rF),.retire3_enG(retire3_enG),.retire3_enV(retire3_enV),.retire3_enF(retire3_enF),
  .retire4_rT(retire4_rT),.retire4_rF(retire4_rF),.retire4_enG(retire4_enG),.retire4_enV(retire4_enV),.retire4_enF(retire4_enF),
  .retire5_rT(retire5_rT),.retire5_rF(retire5_rF),.retire5_enG(retire5_enG),.retire5_enV(retire5_enV),.retire5_enF(retire5_enF),
  .retire6_rT(retire6_rT),.retire6_rF(retire6_rF),.retire6_enG(retire6_enG),.retire6_enV(retire6_enV),.retire6_enF(retire6_enF),
  .retire7_rT(retire7_rT),.retire7_rF(retire7_rF),.retire7_enG(retire7_enG),.retire7_enV(retire7_enV),.retire7_enF(retire7_enF),
  .retire8_rT(retire8_rT),.retire8_rF(retire8_rF),.retire8_enG(retire8_enG),.retire8_enV(retire8_enV),.retire8_enF(retire8_enF),
  .doRetire(),
  .retcnt(retcnt),
  .retclr(retclr),
  .jupd0_en(jupd0_en),.jupdt0_en(jupdt0_en),.jupd0_ght_en(jupd0_ght_en),
  .jupd0_addr(jupd0_addr),.jupd0_baddr(jupd0_baddr),
  .jupd0_sc(jupd0_sc),.jupd0_tk(jupd0_tk),
  .jupd1_en(jupd1_en),.jupdt1_en(jupdt1_en),.jupd1_ght_en(jupd1_ght_en),
  .jupd1_addr(jupd1_addr),.jupd1_baddr(jupd1_baddr),
  .jupd1_sc(jupd1_sc),.jupd1_tk(jupd1_tk),
  .ret0_addr(outII_reg6[1]),.ret0_data({4'b0,FUX_alu[0],     exx_alu[0]    }),.ret0_wen(enS_alu_reg4[0]||outEn_reg6[1][3:2]),
  .ret1_addr(outII_reg8[2]),.ret1_data({fexcpt2_no[0]}),.ret1_wen(enS_alu_reg6[1]||outEn_reg8[2][3:2]),
  .ret2_addr(outII_reg6[4]),.ret2_data({4'b0,FUX_alu[1],     exx_alu[1]}),.ret2_wen(enS_alu_reg4[2]||outEn_reg6[4][3:2]),
  .ret3_addr(outII_reg8[5]),.ret3_data({fexcpt2_no[1]}),.ret3_wen(enS_alu_reg6[3]||outEn_reg8[5][3:2]),
  .ret4_addr(outII_reg6[7]),.ret4_data({4'b0,FUX_alu[2],     exx_alu[2]    }),.ret4_wen(enS_alu_reg4[4]||outEn_reg6[7][3:2]),
  .ret5_addr(outII_reg8[8]),.ret5_data({fexcpt2_no[2]}),.ret5_wen((enS_alu_reg6[5]||outEn_reg8[8][3:2])&~outOp_reg8[8][11]),
    .ret5_IP(FU_reg[9]),.ret5_IP_en(alu_jupdate),
  .ret6_addr(dc_II_reg3[3]),.ret6_data({4'b0,6'b0,3'd2}),.ret6_wen(FU3Hit & dc_lsfwd3_reg3),
  .ret7_addr(dc_II_reg3[3]),.ret7_data({4'b0,6'b0,3'd2}),.ret7_wen(FUXHit & dc_lsfwd3_reg3),
  .mem_II_upper(retM_II0),
  .mem_II_upper_out(retM_II),
  .mem_II_bits_fine(retM_fine),
  .mem_II_bits_ldconfl(retM_ldconfl),
  .mem_II_bits_except(retM_excpt),
  .mem_II_bits_ret(retM_ret),
  .mem_II_stall(bDoStall_rqSpit|bDoStall_rqSpit0), 
  .doRetire_d(retM_do_retire),
  .xbreak(retM_xbreak),
  .has_xbreak(retM_xbreak_has)
  );
 
  assign stall_alloc=|{doStall_rs[3:0],doStall_LSQ,doStall_LDQ,doStall_STQ,doStall_cntrl,doStall_WQ};
  assign doStall=doStall_alloc | (|{doStall_rs[3:0]}) | doStall_LSQ | doStall_LDQ | doStall_STQ | doStall_cntrl | doStall_WQ;
  assign stall_rs[0]=doStall_alloc | doStall_rs[1] | doStall_rs[2] | 
    doStall_rs[3] | doStall_LSQ | doStall_LDQ | doStall_STQ | doStall_cntrl | doStall_WQ;
  assign stall_rs[1]=doStall_alloc | doStall_rs[0] | doStall_rs[2] |
    doStall_rs[3] | doStall_LSQ | doStall_LDQ | doStall_STQ | doStall_cntrl | doStall_WQ;
  assign stall_rs[2]=doStall_alloc | doStall_rs[1] | doStall_rs[0] | 
    doStall_rs[3] | doStall_LSQ | doStall_LDQ | doStall_STQ | doStall_cntrl | doStall_WQ;
  assign stall_rs[3]=doStall_alloc | doStall_rs[1] | doStall_rs[0] |
    doStall_rs[2] | doStall_LSQ | doStall_LDQ | doStall_STQ | doStall_cntrl | doStall_WQ;
  assign stall_LSQ=|{doStall_rs[3:0],doStall_alloc,doStall_cntrl,doStall_LDQ,doStall_STQ | doStall_WQ};
  assign stall_cntrl=|{doStall_rs[3:0],doStall_alloc,doStall_LSQ,doStall_LDQ,doStall_STQ | doStall_WQ};
  assign stall_LDQ=|{doStall_rs[3:0],doStall_alloc,doStall_cntrl,doStall_LSQ,doStall_STQ | doStall_WQ};
  assign stall_STQ=|{doStall_rs[3:0],doStall_alloc,doStall_cntrl,doStall_LSQ,doStall_LDQ | doStall_WQ};
  assign stall_WQ=|{doStall_rs[3:0],doStall_alloc,doStall_cntrl,doStall_LSQ,doStall_LDQ,doStall_STQ};

  assign aStall_STQ=1'b0;
  assign aStall_LSQ=aDoStall_STQ;
  assign lStall_STQ=lDoStall_lsfw;
  assign lStall_lsfw=lDoStall_STQ;
  assign lStall=lDoStall_lsfw|lDoStall_STQ;
  
  assign wreq_en[0]=~wreq_stall & wreq_has[0] & sdata_rdy[0];
  assign wreq_en[1]=~wreq_stall & wreq_has[1] & sdata_rdy[0] & sdata_rdy[1] & 
    !(wreq_data[0][`lsaddr_banks]&wreq_data[1][`lsaddr_banks]);


  assign wreq_stall=bus_holds_agu_reg2|miss_holds_agu_reg2|miss_pause_agu_reg2|insert_isData_reg2|wrStall_reg;
  assign wreq_hold=bus_holds_agu_reg2||miss_pause_agu_reg2&~miss_holds_agu_reg2||insert_isData_reg2;
  
  assign dc_rdRsBanks[3]=dc_rdBanks[3];
  

  assign wr0_hit={dc_wrHit[0] && dc_odd_wr_reg3[0] | dc_split_wr_reg3[0],dc_wrHit[0] && ~dc_odd_wr_reg3[0] | dc_split_wr_reg3[0]};
  assign wr0_addrE=dc_wrAddrE_reg3[0];
  assign wr0_addrO=dc_wrAddrO_reg3[0];
  assign wr0_banks=dc_wrBanks_reg3[0];
  assign wr0_begin=dc_wrBegin_reg3[0];
  assign wr0_end=dc_wrEnd_reg3[0];
  assign wr0_bgn_ben=dc_wrBGN_BNK_reg3[0];
  assign wr0_end_ben=dc_wrEND_BNK_reg3[0];
  assign wr0_odd=dc_odd_wr_reg3[0];
  assign wr0_split=dc_split_wr_reg3[0];
  assign wr0_data=dc_wdata_reg3[0];
  
  assign wr1_hit={dc_wrHit[1] && dc_odd_wr_reg3[1] | dc_split_wr_reg3[1],dc_wrHit[1] && ~dc_odd_wr_reg3[1] | dc_split_wr_reg3[1]};
  assign wr1_addrE=dc_wrAddrE_reg3[1];
  assign wr1_addrO=dc_wrAddrO_reg3[1];
  assign wr1_banks=dc_wrBanks_reg3[1];
  assign wr1_begin=dc_wrBegin_reg3[1];
  assign wr1_end=dc_wrEnd_reg3[1];
  assign wr1_bgn_ben=dc_wrBGN_BNK_reg3[1];
  assign wr1_end_ben=dc_wrEND_BNK_reg3[1];
  assign wr1_odd=dc_odd_wr_reg3[1];
  assign wr1_split=dc_split_wr_reg3[1];
  assign wr1_data=dc_wdata_reg3[1];

  assign regS[0]=9'b0;
  assign regS[3]=9'b0;
  assign regS[6]=9'b0;
  assign retS[0]=1'b1;
  assign retS[3]=1'b1;
  assign retS[6]=1'b1;
  assign funS[0]=10'b0;
  assign funS[3]=10'b0;
  assign funS[6]=10'b0;


  assign FUreg[4]=outReg[3*0+1];
  assign FUreg[5]=outReg[3*1+1];
  assign FUreg[6]=outReg[3*2+1];
  assign FUreg[7]=outReg[3*0+2];
  assign FUreg[8]=outReg[3*1+2];
  assign FUreg[9]=outReg[3*2+2];

  assign FUwen[4]=outEn[3*0+1][0];
  assign FUwen[5]=outEn[3*1+1][0];
  assign FUwen[6]=outEn[3*2+1][0];
  assign FUwen[7]=outEn[3*0+2][0];
  assign FUwen[8]=outEn[3*1+2][0];
  assign FUwen[9]=outEn[3*2+2][0] & ~outOp[3*2+2][11];

  assign FUwen[0]=FUwen0;
  assign FUwen[1]=FUwen1;
  assign FUwen[2]=FUwen2;
  assign FUwen[3]=FUwen3;
  

  assign FU[0]=dc_rdataA[0][63:0];
  assign FU[1]=dc_rdataA[1][63:0];
  assign FU[2]=dc_rdataA[2][63:0];
  //assign FU[3]=dc_rdataA[3];

  assign FU[3][63:32]=(~dc_lsfwd3_reg3 | dc_bread3_reg3[1]) ? dc_rdataA[3][63:32]:
        dc_data3_reg3[63:32];  
  assign FU[3][31:0]=(~dc_lsfwd3_reg3 | dc_bread3_reg3[0]) ? dc_rdataA[3][31:0]:
          dc_data3_reg3[31:0];  
  
  assign FUVH[0]=dc_rdataA_reg[0][127:64]; 
  assign FUVL[0]=dc_rdataA_reg[0][63:0]; 
  assign FUVH[1]=dc_rdataA_reg[1][127:64]; 
  assign FUVL[1]=dc_rdataA_reg[1][63:0]; 
  assign FUVH[2]=dc_rdataA_reg[2][127:64]; 
  assign FUVL[2]=dc_rdataA_reg[2][63:0]; 
  
  assign FUVH[3][63:32]=(~dc_lsfwd3_reg4 | dc_bread3_reg4[3]) ? dc_rdataA_reg[3][127:96]:
        dc_data3_reg4[127:96];  
  assign FUVH[3][31:0]=(~dc_lsfwd3_reg4 | dc_bread3_reg4[2]) ? dc_rdataA_reg[3][95:64]:
        dc_data3_reg4[95:64];  
  assign FUVL[3][63:32]=(~dc_lsfwd3_reg4 | dc_bread3_reg4[1]) ? dc_rdataA_reg[3][63:32]:
        dc_data3_reg4[63:32];  
  assign FUVL[3][31:0]=(~dc_lsfwd3_reg4 | dc_bread3_reg4[0]) ? dc_rdataA_reg[3][31:0]:
        dc_data3_reg4[31:0];  
  
  
  
    

//  assign FU0=dc_rdataA[0][63:0];
//  assign FU1=dc_rdataA[1][63:0];
//  assign FU2=dc_rdataA[2][63:0];
//  assign FU3=dc_rdataA[3][63:0];
 
 // assign dc_rdReg[3]=rec_register_reg;
  
  assign FUreg[0]=dc_rdReg_reg2[0];
  assign FUreg[1]=dc_rdReg_reg2[1];
  assign FUreg[2]=dc_rdReg_reg2[2];
  assign FUreg[3]=dc_rdReg_reg2[3];

  assign FU0Hit=FU0HitP & ~dc_confl_reg2[0];
  assign FU1Hit=FU1HitP & ~dc_confl_reg2[1];
  assign FU2Hit=FU2HitP & ~dc_confl_reg2[2];
  assign FU3Hit=FU3HitP & ~dc_confl_reg2[3];
  
  popcnt10_or_more cnt_lsi_mod({4'b0,rs_lsi[5][2:1]!=2'd3,rs_lsi[4][2:1]!=2'd3,rs_lsi[3][2:1]!=2'd3,
    rs_lsi[2][2:1]!=2'd3,rs_lsi[1][2:1]!=2'd3,rs_lsi[0][2:1]!=2'd3},lsi_cnt);
  assign LSQ_shr_data[`lsqshare_used]=lsi_cnt_reg;
  assign LSQ_shr_data[`lsqshare_usedB]=lsi_cnt_reg&lsi_bits;
  assign LSQ_shr_data[`lsqshare_II]=II_upper;
  assign LSQ_shr_data[`lsqshare_wrt0]=wrtO0_reg;
  assign LSQ_shr_data[`lsqshare_wrt1]=wrtO1_reg;
  assign LSQ_shr_data[`lsqshare_wrt2]=wrtO2_reg;
  assign LSQ_shr_data[`lsqshare_wrtII0]=wrtII0_reg;
  assign LSQ_shr_data[`lsqshare_wrtII1]=wrtII1_reg;
  assign LSQ_shr_data[`lsqshare_wrtII2]=wrtII2_reg;
//  assign LSQ_shr_data[`lsqshare_flagged]=6'b0; //kludge
  
  assign dc_confl[3]=1'b0;
  
  assign FUS4=FUS_alu[0];
  assign FUS5=FUS_alu[1];
  assign FUS6=FUS_alu[2];
  assign FUS7=FUS_alu[3];
  assign FUS8=FUS_alu[4];
  assign FUS9=FUS_alu[5];

  assign FUS1=6'b0;//come from fpu
  assign FUS2=6'b0;
  assign FUS3=6'b0;
 
   
//  assign LSQ_lsqA[8:3]=LSQ_upper;
//  assign LSQ_lsqB[8:3]=LSQ_upper;
  
  assign miss_clDo[0]=~miss_clHit[0] && ~miss_odd | miss_split && ~miss_doneEven;
  assign miss_clDo[1]=~miss_clHit[1] && miss_odd | miss_split && ~miss_doneOdd;
  
  assign mcam_addr=miss_clDo[0] ? {miss_addrE,1'b0} : {miss_addrO,1'b1};
  assign mcam_cldupl=miss_clDo[0] ? miss_clDupl[0] : miss_clDupl[1];
  assign mcam_st=miss_st;
  assign mcam_sz=miss_sz;
  assign mcam_low=miss_low;
  assign mcam_bank0=miss_bank0;
  assign mcam_io=miss_io;
  assign miss_next=miss_en && !(&miss_clDo);
  
  assign mcam_do_req=miss_en_reg&&~mcam_locked&&~mcam_dupl&&~mcam_replay;
 
  always @* begin
    for(qq=0;qq<4;qq=qq+1) begin
        lsr_ck_data[qq]=lsr_wr_data[qq];
	lsr_ck_data[qq][`lsaddr_addrE]=dc_rdAddrE_chk[qq];
	lsr_ck_data[qq][`lsaddr_addrO]=dc_rdAddrO_chk[qq];
	lsr_ck_data[qq][`lsaddr_pconfl]=1'b0;
    end
  end

  always @(posedge clk) begin
      if (rst) begin
	  newAttr_reg<=4'b0;
	  newAttr_reg2<=4'b0;
          rs0i0_alloc_reg<=1'b0;
          rs0i1_alloc_reg<=1'b0;
          rs0i2_alloc_reg<=1'b0;
          rs1i0_alloc_reg<=1'b0;
          rs1i1_alloc_reg<=1'b0;
          rs1i2_alloc_reg<=1'b0;
          rs2i0_alloc_reg<=1'b0;
          rs2i1_alloc_reg<=1'b0;
          rs2i2_alloc_reg<=1'b0;

          rs0i0_allocF_reg<=1'b0;
          rs0i1_allocF_reg<=1'b0;
          rs0i2_allocF_reg<=1'b0;
          rs1i0_allocF_reg<=1'b0;
          rs1i1_allocF_reg<=1'b0;
          rs1i2_allocF_reg<=1'b0;
          rs2i0_allocF_reg<=1'b0;
          rs2i1_allocF_reg<=1'b0;
          rs2i2_allocF_reg<=1'b0;

          rs0i0_allocR_reg<=1'b0;
          rs0i1_allocR_reg<=1'b0;
          rs0i2_allocR_reg<=1'b0;
          rs1i0_allocR_reg<=1'b0;
          rs1i1_allocR_reg<=1'b0;
          rs1i2_allocR_reg<=1'b0;
          rs2i0_allocR_reg<=1'b0;
          rs2i1_allocR_reg<=1'b0;
          rs2i2_allocR_reg<=1'b0;

          rs0i0_en_reg<=1'b0;
          rs0i1_en_reg<=1'b0;
          rs0i2_en_reg<=1'b0;
          rs1i0_en_reg<=1'b0;
          rs1i1_en_reg<=1'b0;
          rs1i2_en_reg<=1'b0;
          rs2i0_en_reg<=1'b0;
          rs2i1_en_reg<=1'b0;
          rs2i2_en_reg<=1'b0;

          rs0i0_useBConst_reg<=1'b0;
          rs0i1_useBConst_reg<=1'b0;
          rs0i2_useBConst_reg<=1'b0;
          rs1i0_useBConst_reg<=1'b0;
          rs1i1_useBConst_reg<=1'b0;
          rs1i2_useBConst_reg<=1'b0;
          rs2i0_useBConst_reg<=1'b0;
          rs2i1_useBConst_reg<=1'b0;
          rs2i2_useBConst_reg<=1'b0;
          
          rs0i0_rT_reg<={IN_REG_WIDTH{1'B0}};
          rs0i1_rT_reg<={IN_REG_WIDTH{1'B0}};
          rs0i2_rT_reg<={IN_REG_WIDTH{1'B0}};
          rs1i0_rT_reg<={IN_REG_WIDTH{1'B0}};
          rs1i1_rT_reg<={IN_REG_WIDTH{1'B0}};
          rs1i2_rT_reg<={IN_REG_WIDTH{1'B0}};
          rs2i0_rT_reg<={IN_REG_WIDTH{1'B0}};
          rs2i1_rT_reg<={IN_REG_WIDTH{1'B0}};
          rs2i2_rT_reg<={IN_REG_WIDTH{1'B0}};

          rs0i0_rA_reg<={IN_REG_WIDTH{1'B0}};
          rs0i1_rA_reg<={IN_REG_WIDTH{1'B0}};
          rs0i2_rA_reg<={IN_REG_WIDTH{1'B0}};
          rs1i0_rA_reg<={IN_REG_WIDTH{1'B0}};
          rs1i1_rA_reg<={IN_REG_WIDTH{1'B0}};
          rs1i2_rA_reg<={IN_REG_WIDTH{1'B0}};
          rs2i0_rA_reg<={IN_REG_WIDTH{1'B0}};
          rs2i1_rA_reg<={IN_REG_WIDTH{1'B0}};
          rs2i2_rA_reg<={IN_REG_WIDTH{1'B0}};

          rs0i0_rB_reg<={IN_REG_WIDTH{1'B0}};
          rs0i1_rB_reg<={IN_REG_WIDTH{1'B0}};
          rs0i2_rB_reg<={IN_REG_WIDTH{1'B0}};
          rs1i0_rB_reg<={IN_REG_WIDTH{1'B0}};
          rs1i1_rB_reg<={IN_REG_WIDTH{1'B0}};
          rs1i2_rB_reg<={IN_REG_WIDTH{1'B0}};
          rs2i0_rB_reg<={IN_REG_WIDTH{1'B0}};
          rs2i1_rB_reg<={IN_REG_WIDTH{1'B0}};
          rs2i2_rB_reg<={IN_REG_WIDTH{1'B0}};

          rs0i0_rA_reg2<={IN_REG_WIDTH{1'B0}};
          rs0i1_rA_reg2<={IN_REG_WIDTH{1'B0}};
          rs0i2_rA_reg2<={IN_REG_WIDTH{1'B0}};
          rs1i0_rA_reg2<={IN_REG_WIDTH{1'B0}};
          rs1i1_rA_reg2<={IN_REG_WIDTH{1'B0}};
          rs1i2_rA_reg2<={IN_REG_WIDTH{1'B0}};
          rs2i0_rA_reg2<={IN_REG_WIDTH{1'B0}};
          rs2i1_rA_reg2<={IN_REG_WIDTH{1'B0}};
          rs2i2_rA_reg2<={IN_REG_WIDTH{1'B0}};

          rs0i0_rB_reg2<={IN_REG_WIDTH{1'B0}};
          rs0i1_rB_reg2<={IN_REG_WIDTH{1'B0}};
          rs0i2_rB_reg2<={IN_REG_WIDTH{1'B0}};
          rs1i0_rB_reg2<={IN_REG_WIDTH{1'B0}};
          rs1i1_rB_reg2<={IN_REG_WIDTH{1'B0}};
          rs1i2_rB_reg2<={IN_REG_WIDTH{1'B0}};
          rs2i0_rB_reg2<={IN_REG_WIDTH{1'B0}};
          rs2i1_rB_reg2<={IN_REG_WIDTH{1'B0}};
          rs2i2_rB_reg2<={IN_REG_WIDTH{1'B0}};

          rs0i0_rA_reg3<={IN_REG_WIDTH{1'B0}};
          rs0i1_rA_reg3<={IN_REG_WIDTH{1'B0}};
          rs0i2_rA_reg3<={IN_REG_WIDTH{1'B0}};
          rs1i0_rA_reg3<={IN_REG_WIDTH{1'B0}};
          rs1i1_rA_reg3<={IN_REG_WIDTH{1'B0}};
          rs1i2_rA_reg3<={IN_REG_WIDTH{1'B0}};
          rs2i0_rA_reg3<={IN_REG_WIDTH{1'B0}};
          rs2i1_rA_reg3<={IN_REG_WIDTH{1'B0}};
          rs2i2_rA_reg3<={IN_REG_WIDTH{1'B0}};

          rs0i0_rB_reg3<={IN_REG_WIDTH{1'B0}};
          rs0i1_rB_reg3<={IN_REG_WIDTH{1'B0}};
          rs0i2_rB_reg3<={IN_REG_WIDTH{1'B0}};
          rs1i0_rB_reg3<={IN_REG_WIDTH{1'B0}};
          rs1i1_rB_reg3<={IN_REG_WIDTH{1'B0}};
          rs1i2_rB_reg3<={IN_REG_WIDTH{1'B0}};
          rs2i0_rB_reg3<={IN_REG_WIDTH{1'B0}};
          rs2i1_rB_reg3<={IN_REG_WIDTH{1'B0}};
          rs2i2_rB_reg3<={IN_REG_WIDTH{1'B0}};

          rs0i0_index_reg<=1'b0;
          rs0i1_index_reg<=1'b0;
          rs0i2_index_reg<=1'b0;
          rs1i0_index_reg<=1'b0;
          rs1i1_index_reg<=1'b0;
          rs1i2_index_reg<=1'b0;
          rs2i0_index_reg<=1'b0;
          rs2i1_index_reg<=1'b0;
          rs2i2_index_reg<=1'b0;
	  rs2i2_mul_reg<=1'b0;

          rs_rA_isV<=9'b0;
          rs_rA_isAnyV<=9'b0;
          rs_rB_isV<=9'b0;
          rs_rB_isAnyV<=9'b0;
          rs_rT_isV<=9'b0;
          rs_rT_use<=9'b0;
          rs_rT_useF<=9'b0;
	  isAV_reg<=1'b0;
	  isBV_reg<=1'b0;
	  isAF_reg<=1'b0;
	  isBF_reg<=1'b0;
          rs_enA<=3'b0;
          rs_enB<=3'b0;
          rs_enA_reg<=3'b0;
          rs_enB_reg<=3'b0;
          rs_enAW_reg<=3'b0;
          rs_enBW_reg<=3'b0;

          rs0i1_lastFl_reg<=1'b0;
          rs0i2_lastFl_reg<=1'b0;
          rs1i1_lastFl_reg<=1'b0;
          rs1i2_lastFl_reg<=1'b0;
          rs2i1_lastFl_reg<=1'b0;
          rs2i2_lastFl_reg<=1'b0;

          rs_ldst_flg<=8'b0;
          rs_ldst_flg_reg<=8'b0;

          rs0i1_flagDep_reg<=4'hd;
          rs0i2_flagDep_reg<=4'hd;
          rs1i1_flagDep_reg<=4'hd;
          rs1i2_flagDep_reg<=4'hd;
          rs2i1_flagDep_reg<=4'hd;
          rs2i2_flagDep_reg<=4'hd;

          rs0i1_flagDep_reg2<=4'hd;
          rs0i2_flagDep_reg2<=4'hd;
          rs1i1_flagDep_reg2<=4'hd;
          rs1i2_flagDep_reg2<=4'hd;
          rs2i1_flagDep_reg2<=4'hd;
          rs2i2_flagDep_reg2<=4'hd;
          
          thread_reg<=1'b0;
          thread_reg2<=1'b0;
          thread_reg3<=1'b0;
          bundle_in_reg<=1'b0;
          bundle_in_reg2<=1'b0;
          clr_reg<=9'b0;
          clrS_reg<=9'b0;
          
          rs_useAConst<=9'b0;
          rs_useBConst<=9'b0;
          rs_useBConst_reg<=9'b0;
          
          depA_reg<=9'b0;
          depB_reg<=9'b0;
     
          rs_rA_use<=9'b0;
          rs_rB_use<=9'b0;
          rs_rA_useF<=9'b0;
          rs_rB_useF<=9'b0;
          rs_rA_useF_reg<=9'b0;
          rs_rB_useF_reg<=9'b0;
          rs_rA_useF_reg2<=9'b0;
          rs_rB_useF_reg2<=9'b0;

	  rs_alt<=3'b0;
	  rs_alt_reg<=3'b0;
          
	  jump0TbufWay_reg<=3'd0;
          jump0JmpInd_reg<=2'd0;
          jump0GHT_reg<=8'd0;
          jump1TbufWay_reg<=3'd0;
          jump1JmpInd_reg<=2'd0;
          jump1GHT_reg<=8'd0;
          jump0SC_reg<=2'd0;
          jump0Miss_reg<=1'b0;
          jump0TbufOnly_reg<=1'b0;
          jump1SC_reg<=2'd0;
          jump1Miss_reg<=1'd0;
          jump1TbufOnly_reg<=1'd0;
	  jump0Type_reg<=5'd0;
	  jump0Pos_reg<=4'hf;
	  jump0Pred_reg<=1'b0;
	  jump0IP_reg<=64'b0;
	  jump0Mask_reg<=4'b0;
          jump1Type_reg<=5'd0;
	  jump1Pos_reg<=4'hf;
	  jump1Pred_reg<=1'b0;
	  jump1IP_reg<=64'b0;
	  jump1Mask_reg<=4'b0;
	  instr_fsimd_reg<=10'b0;
	  baseIP_reg<=47'b0;
          
              
	  jump0TbufWay_reg2<=3'd0;
          jump0JmpInd_reg2<=2'd0;
          jump0GHT_reg2<=8'd0;
          jump1TbufWay_reg2<=3'd0;
          jump1JmpInd_reg2<=2'd0;
          jump1GHT_reg2<=8'd0;
          jump0SC_reg2<=2'd0;
          jump0Miss_reg2<=1'b0;
          jump0TbufOnly_reg2<=1'b0;
          jump1SC_reg2<=2'd0;
          jump1Miss_reg2<=1'd0;
          jump1TbufOnly_reg2<=1'd0;
	  jump0Type_reg2<=5'd0;
	  jump0Pos_reg2<=4'hf;
	  jump0Pred_reg2<=1'b0;
	  jump0IP_reg2<=64'b0;
	  jump0Mask_reg2<=4'b0;
	  jump1Type_reg2<=5'd0;
	  jump1Pos_reg2<=4'hf;
	  jump1Pred_reg2<=1'b0;
	  jump1IP_reg2<=64'b0;
	  jump1Mask_reg2<=4'b0;
          instr_fsimd_reg2<=10'b0;
      
          wrtO0_reg<=4'b0;
          wrtO1_reg<=4'b0;
          wrtO2_reg<=4'b0;
          wrtII0_reg<=3'b0;
          wrtII1_reg<=3'b0;
          wrtII2_reg<=3'b0;
          WQR_reg[0]<=8'd0;
          WQR_reg[1]<=8'd0;
          WQR_reg[2]<=8'd0;
          WQS_reg[0]<=8'd0;
          WQS_reg[1]<=8'd0;
          WQS_reg[2]<=8'd0;
          lsi_cnt_reg<=6'b0;
          ldq_new_mask_reg<=6'b0; 
          wrt0_reg<=6'h3f;
          wrt1_reg<=6'h3f;
          wrt2_reg<=6'h3f;
          LSQ_lsqA_reg<=3'h7;
          LSQ_lsqB_reg<=3'h7;
          LSQ_indA_reg<=4'hf;
          LSQ_indB_reg<=4'hf;
          LSQ_wqA_reg<=8'b0;
          LSQ_wqB_reg<=8'b0;
          Wswp_reg<=3'b0;
          WopA_reg<=13'b0;
          WopB_reg<=13'b0;
          for(k=0;k<9;k=k+1) begin
              clrR_reg[k]<=9'b0;
              rs_const[k]<={DATA_WIDTH{1'B0}};
              rs_const_reg[k]<={DATA_WIDTH{1'B0}};
	      rs_IPRel[k]<=1'b0;
	      rs_afterTK[k]<=1'b0;
              rs_index[k]<=4'b0;
              rs_index_reg[k]<=4'b0;
              rs_operation[k]<={OPERATION_WIDTH{1'B0}};
              rs_operation_reg[k]<={OPERATION_WIDTH{1'B0}};
              rs_operation_reg2[k]<={OPERATION_WIDTH{1'B0}};
              rs_port[k]<=3'b0;
              rs_port_reg[k]<=3'b0;
              rs_port_sch[k]<=3'b0;
              regA_reg[k]<={REG_WIDTH{1'B0}};
              regB_reg[k]<={REG_WIDTH{1'B0}};
              regS_reg[k]<={REG_WIDTH{1'B0}};
              regAF_reg[k]<={REG_WIDTH{1'B0}};
              regBF_reg[k]<={REG_WIDTH{1'B0}};
              regAF_reg2[k]<={REG_WIDTH{1'B0}};
              regBF_reg2[k]<={REG_WIDTH{1'B0}};
	      retAF_reg[k]<=1'b0;
	      retBF_reg[k]<=1'b0;
	      retAF_reg2[k]<=1'b0;
	      retBF_reg2[k]<=1'b0;
              newR_reg[k]<={REG_WIDTH{1'B0}};
              rs_en[k]<=1'b0;
              rs_en_reg[k]<=1'b0;
              funA_reg[k]<=10'b0;
              funB_reg[k]<=10'b0;
              funS_reg[k]<=10'b0;
              rs_lsi[k]<=3'b0;
              rs_lsi_reg[k]<=3'b0;
              domA_reg[k]<=2'b0;
              domB_reg[k]<=2'b0;
              instr_ret_reg[k]<=4'hf;
          end
	  for(t=0;t<3;t=t+1) begin
              rrfAW_reg[t]<={IN_REG_WIDTH{1'B0}};
              rrfBW_reg[t]<={IN_REG_WIDTH{1'B0}};
              rrfAW_reg2[t]<={IN_REG_WIDTH{1'B0}};
              rrfBW_reg2[t]<={IN_REG_WIDTH{1'B0}};
              regAW_reg[t]<={REG_WIDTH{1'B0}};
              regBW_reg[t]<={REG_WIDTH{1'B0}};
              regAWF_reg[t]<={REG_WIDTH{1'B0}};
              regBFW_reg[t]<={REG_WIDTH{1'B0}};
              regAWF_reg2[t]<={REG_WIDTH{1'B0}};
              regBFW_reg2[t]<={REG_WIDTH{1'B0}};
	      retAWF_reg[t]<=1'b0;
	      retBFW_reg[t]<=1'b0;
	      retAWF_reg2[t]<=1'b0;
	      retBFW_reg2[t]<=1'b0;
	      isAWF_reg[t]<=1'b0;
	      isBFW_reg[t]<=1'b0;
	      isAWV_reg[t]<=1'b0;
          isBVW_reg[t]<=1'b0;
	      rs_rAW_useF_reg[t]<=1'b0;
	      rs_rBW_useF_reg[t]<=1'b0;
	      rs_rAW_useF_reg2[t]<=1'b0;
	      rs_rBW_useF_reg2[t]<=1'b0;
	      Wport_reg[t]<=0;
	  end
	  for(t=0;t<10;t=t+1) begin
              instr_rT[t]<={IN_REG_WIDTH{1'B0}};
              instr_en[t]<=1'b0;
              instr_wren[t]<=1'b0;
              instr_IPOff[t]<=13'b0;
              instr_afterTaken[t]<=1'b0;
              instr_rT_useF[t]<=1'b0;
              instr_rT_isV[t]<=1'b0;
              instr_port[t]<={PORT_WIDTH{1'B0}};
              instr_magic[t]<=4'b0;
              instr_last[t]<=1'b0;
	      instr_aft_spc[t]<=1'b0;
              
	      instr_rT_reg[t]<={IN_REG_WIDTH{1'B0}};
              instr_en_reg[t]<=1'b0;
              instr_wren_reg[t]<=1'b0;
              instr_IPOff_reg[t]<=13'b0;
              instr_afterTaken_reg[t]<=1'b0;
              instr_rT_useF_reg[t]<=1'b0;
              instr_rT_isV_reg[t]<=1'b0;
              instr_port_reg[t]<={PORT_WIDTH{1'B0}};
              //instr_magic_reg[t]<=4'b0;
              instr_last_reg[t]<=1'b0;
	      instr_magicOff[t]<=3'b0;
	      instr_gen[t]<=1'b0;
	      instr_vec[t]<=1'b0;
	      instr_aft_spc_reg[t]<=1'b0;
	  end
      end else if (~doStall) begin
	  newAttr_reg<=newAttr;
	  newAttr_reg2<=newAttr_reg;
          rs0i0_alloc_reg<=rs0i0_alloc;
          rs0i1_alloc_reg<=rs0i1_alloc;
          rs0i2_alloc_reg<=rs0i2_alloc;
          rs1i0_alloc_reg<=rs1i0_alloc;
          rs1i1_alloc_reg<=rs1i1_alloc;
          rs1i2_alloc_reg<=rs1i2_alloc;
          rs2i0_alloc_reg<=rs2i0_alloc;
          rs2i1_alloc_reg<=rs2i1_alloc;
          rs2i2_alloc_reg<=rs2i2_alloc;

          rs0i0_allocF_reg<=rs0i0_allocF;
          rs0i1_allocF_reg<=rs0i1_allocF;
          rs0i2_allocF_reg<=rs0i2_allocF;
          rs1i0_allocF_reg<=rs1i0_allocF;
          rs1i1_allocF_reg<=rs1i1_allocF;
          rs1i2_allocF_reg<=rs1i2_allocF;
          rs2i0_allocF_reg<=rs2i0_allocF;
          rs2i1_allocF_reg<=rs2i1_allocF;
          rs2i2_allocF_reg<=rs2i2_allocF;

          rs0i0_allocR_reg<=rs0i0_allocR;
          rs0i1_allocR_reg<=rs0i1_allocR;
          rs0i2_allocR_reg<=rs0i2_allocR;
          rs1i0_allocR_reg<=rs1i0_allocR;
          rs1i1_allocR_reg<=rs1i1_allocR;
          rs1i2_allocR_reg<=rs1i2_allocR;
          rs2i0_allocR_reg<=rs2i0_allocR;
          rs2i1_allocR_reg<=rs2i1_allocR;
          rs2i2_allocR_reg<=rs2i2_allocR;

          rs0i0_en_reg<=rs0i0_en;
          rs0i1_en_reg<=rs0i1_en;
          rs0i2_en_reg<=rs0i2_en;
          rs1i0_en_reg<=rs1i0_en;
          rs1i1_en_reg<=rs1i1_en;
          rs1i2_en_reg<=rs1i2_en;
          rs2i0_en_reg<=rs2i0_en;
          rs2i1_en_reg<=rs2i1_en;
          rs2i2_en_reg<=rs2i2_en;

          rs0i0_useBConst_reg<=rs0i0_useBConst;
          rs0i1_useBConst_reg<=rs0i1_useBConst;
          rs0i2_useBConst_reg<=rs0i2_useBConst;
          rs1i0_useBConst_reg<=rs1i0_useBConst;
          rs1i1_useBConst_reg<=rs1i1_useBConst;
          rs1i2_useBConst_reg<=rs1i2_useBConst;
          rs2i0_useBConst_reg<=rs2i0_useBConst;
          rs2i1_useBConst_reg<=rs2i1_useBConst;
          rs2i2_useBConst_reg<=rs2i2_useBConst;
          
          rs0i0_rT_reg<=rs0i0_rT;
          rs0i1_rT_reg<=rs0i1_rT;
          rs0i2_rT_reg<=rs0i2_rT;
          rs1i0_rT_reg<=rs1i0_rT;
          rs1i1_rT_reg<=rs1i1_rT;
          rs1i2_rT_reg<=rs1i2_rT;
          rs2i0_rT_reg<=rs2i0_rT;
          rs2i1_rT_reg<=rs2i1_rT;
          rs2i2_rT_reg<=rs2i2_rT;

          rs0i0_rA_reg<=rs0i0_rA;
          rs0i1_rA_reg<=rs0i1_rA;
          rs0i2_rA_reg<=rs0i2_rA;
          rs1i0_rA_reg<=rs1i0_rA;
          rs1i1_rA_reg<=rs1i1_rA;
          rs1i2_rA_reg<=rs1i2_rA;
          rs2i0_rA_reg<=rs2i0_rA;
          rs2i1_rA_reg<=rs2i1_rA;
          rs2i2_rA_reg<=rs2i2_rA;

          rs0i0_rB_reg<=rs0i0_rB;
          rs0i1_rB_reg<=rs0i1_rB;
          rs0i2_rB_reg<=rs0i2_rB;
          rs1i0_rB_reg<=rs1i0_rB;
          rs1i1_rB_reg<=rs1i1_rB;
          rs1i2_rB_reg<=rs1i2_rB;
          rs2i0_rB_reg<=rs2i0_rB;
          rs2i1_rB_reg<=rs2i1_rB;
          rs2i2_rB_reg<=rs2i2_rB;

          rs0i0_rA_reg2<=rs0i0_rA_reg;
          rs0i1_rA_reg2<=rs0i1_rA_reg;
          rs0i2_rA_reg2<=rs0i2_rA_reg;
          rs1i0_rA_reg2<=rs1i0_rA_reg;
          rs1i1_rA_reg2<=rs1i1_rA_reg;
          rs1i2_rA_reg2<=rs1i2_rA_reg;
          rs2i0_rA_reg2<=rs2i0_rA_reg;
          rs2i1_rA_reg2<=rs2i1_rA_reg;
          rs2i2_rA_reg2<=rs2i2_rA_reg;

          rs0i0_rB_reg2<=rs0i0_rB_reg;
          rs0i1_rB_reg2<=rs0i1_rB_reg;
          rs0i2_rB_reg2<=rs0i2_rB_reg;
          rs1i0_rB_reg2<=rs1i0_rB_reg;
          rs1i1_rB_reg2<=rs1i1_rB_reg;
          rs1i2_rB_reg2<=rs1i2_rB_reg;
          rs2i0_rB_reg2<=rs2i0_rB_reg;
          rs2i1_rB_reg2<=rs2i1_rB_reg;
          rs2i2_rB_reg2<=rs2i2_rB_reg;

          rs0i0_rA_reg3<=rs0i0_rA_reg2;
          rs0i1_rA_reg3<=rs0i1_rA_reg2;
          rs0i2_rA_reg3<=rs0i2_rA_reg2;
          rs1i0_rA_reg3<=rs1i0_rA_reg2;
          rs1i1_rA_reg3<=rs1i1_rA_reg2;
          rs1i2_rA_reg3<=rs1i2_rA_reg2;
          rs2i0_rA_reg3<=rs2i0_rA_reg2;
          rs2i1_rA_reg3<=rs2i1_rA_reg2;
          rs2i2_rA_reg3<=rs2i2_rA_reg2;

          rs0i0_rB_reg3<=rs0i0_rB_reg2;
          rs0i1_rB_reg3<=rs0i1_rB_reg2;
          rs0i2_rB_reg3<=rs0i2_rB_reg2;
          rs1i0_rB_reg3<=rs1i0_rB_reg2;
          rs1i1_rB_reg3<=rs1i1_rB_reg2;
          rs1i2_rB_reg3<=rs1i2_rB_reg2;
          rs2i0_rB_reg3<=rs2i0_rB_reg2;
          rs2i1_rB_reg3<=rs2i1_rB_reg2;
          rs2i2_rB_reg3<=rs2i2_rB_reg2;

          rs0i0_index_reg<=rs0i0_index;
          rs0i1_index_reg<=rs0i1_index;
          rs0i2_index_reg<=rs0i2_index;
          rs1i0_index_reg<=rs1i0_index;
          rs1i1_index_reg<=rs1i1_index;
          rs1i2_index_reg<=rs1i2_index;
          rs2i0_index_reg<=rs2i0_index;
          rs2i1_index_reg<=rs2i1_index;
          rs2i2_index_reg<=rs2i2_index;

	  rs2i2_mul_reg<=rs2i2_mul;

          rs0i1_lastFl_reg<=rs0i1_lastFl;
          rs0i2_lastFl_reg<=rs0i2_lastFl;
          rs1i1_lastFl_reg<=rs1i1_lastFl;
          rs1i2_lastFl_reg<=rs1i2_lastFl;
          rs2i1_lastFl_reg<=rs2i1_lastFl;
          rs2i2_lastFl_reg<=rs2i2_lastFl;

          rs_ldst_flg[0]<=rs0i0_ldst_flg;
          rs_ldst_flg[1]<=rs0i1_ldst_flg;
          rs_ldst_flg[2]<=rs1i0_ldst_flg;
          rs_ldst_flg[3]<=rs1i1_ldst_flg;
          rs_ldst_flg[4]<=rs2i0_ldst_flg;
          rs_ldst_flg[5]<=rs2i1_ldst_flg;

          rs_ldst_flg_reg<=rs_ldst_flg;

          rs0i1_flagDep_reg<=rs0i1_flagDep;
          rs0i2_flagDep_reg<=rs0i2_flagDep;
          rs1i1_flagDep_reg<=rs1i1_flagDep;
          rs1i2_flagDep_reg<=rs1i2_flagDep;
          rs2i1_flagDep_reg<=rs2i1_flagDep;
          rs2i2_flagDep_reg<=rs2i2_flagDep;

          rs0i1_flagDep_reg2<=rs0i1_flagDep_reg;
          rs0i2_flagDep_reg2<=rs0i2_flagDep_reg;
          rs1i1_flagDep_reg2<=rs1i1_flagDep_reg;
          rs1i2_flagDep_reg2<=rs1i2_flagDep_reg;
          rs2i1_flagDep_reg2<=rs2i1_flagDep_reg;
          rs2i2_flagDep_reg2<=rs2i2_flagDep_reg;
          
          rs_const[0]<=rs0i0_const;
          rs_const[1]<=rs0i1_const;
          rs_const[2]<=rs0i2_const;
          rs_const[3]<=rs1i0_const;
          rs_const[4]<=rs1i1_const;
          rs_const[5]<=rs1i2_const;
          rs_const[6]<=rs2i0_const;
          rs_const[7]<=rs2i1_const;
          rs_const[8]<=rs2i2_const;
          
	  rs_IPRel[0]<=rs0i0_IPRel;
          rs_IPRel[1]<=rs0i1_IPRel;
          rs_IPRel[2]<=rs0i2_IPRel;
          rs_IPRel[3]<=rs1i0_IPRel;
          rs_IPRel[4]<=rs1i1_IPRel;
          rs_IPRel[5]<=rs1i2_IPRel;
          rs_IPRel[6]<=rs2i0_IPRel;
          rs_IPRel[7]<=rs2i1_IPRel;
          rs_IPRel[8]<=rs2i2_IPRel;

	  rs_afterTK[0]<=rs0i0_afterTaken;
          rs_afterTK[1]<=rs0i1_afterTaken;
          rs_afterTK[2]<=rs0i2_afterTaken;
          rs_afterTK[3]<=rs1i0_afterTaken;
          rs_afterTK[4]<=rs1i1_afterTaken;
          rs_afterTK[5]<=rs1i2_afterTaken;
          rs_afterTK[6]<=rs2i0_afterTaken;
          rs_afterTK[7]<=rs2i1_afterTaken;
          rs_afterTK[8]<=rs2i2_afterTaken;

          rs_index[0]<=rs0i0_index;
          rs_index[1]<=rs0i1_index;
          rs_index[2]<=rs0i2_index;
          rs_index[3]<=rs1i0_index;
          rs_index[4]<=rs1i1_index;
          rs_index[5]<=rs1i2_index;
          rs_index[6]<=rs2i0_index;
          rs_index[7]<=rs2i1_index;
          rs_index[8]<=rs2i2_index;

          rs_rA_isV[0]<=rs0i0_rA_isV;
          rs_rA_isV[1]<=rs0i1_rA_isV;
          rs_rA_isV[2]<=rs0i2_rA_isV;
          rs_rA_isV[3]<=rs1i0_rA_isV;
          rs_rA_isV[4]<=rs1i1_rA_isV;
          rs_rA_isV[5]<=rs1i2_rA_isV;
          rs_rA_isV[6]<=rs2i0_rA_isV;
          rs_rA_isV[7]<=rs2i1_rA_isV;
          rs_rA_isV[8]<=rs2i2_rA_isV;
          
          rs_rA_isAnyV[0]<=rs0i0_rA_isAnyV;
          rs_rA_isAnyV[1]<=rs0i1_rA_isAnyV;
          rs_rA_isAnyV[2]<=rs0i2_rA_isAnyV;
          rs_rA_isAnyV[3]<=rs1i0_rA_isAnyV;
          rs_rA_isAnyV[4]<=rs1i1_rA_isAnyV;
          rs_rA_isAnyV[5]<=rs1i2_rA_isAnyV;
          rs_rA_isAnyV[6]<=rs2i0_rA_isAnyV;
          rs_rA_isAnyV[7]<=rs2i1_rA_isAnyV;
          rs_rA_isAnyV[8]<=rs2i2_rA_isAnyV;

          rs_rB_isV[0]<=rs0i0_rB_isV;
          rs_rB_isV[1]<=rs0i1_rB_isV;
          rs_rB_isV[2]<=rs0i2_rB_isV;
          rs_rB_isV[3]<=rs1i0_rB_isV;
          rs_rB_isV[4]<=rs1i1_rB_isV;
          rs_rB_isV[5]<=rs1i2_rB_isV;
          rs_rB_isV[6]<=rs2i0_rB_isV;
          rs_rB_isV[7]<=rs2i1_rB_isV;
          rs_rB_isV[8]<=rs2i2_rB_isV;

          rs_rB_isAnyV[0]<=rs0i0_rB_isAnyV;
          rs_rB_isAnyV[1]<=rs0i1_rB_isAnyV;
          rs_rB_isAnyV[2]<=rs0i2_rB_isAnyV;
          rs_rB_isAnyV[3]<=rs1i0_rB_isAnyV;
          rs_rB_isAnyV[4]<=rs1i1_rB_isAnyV;
          rs_rB_isAnyV[5]<=rs1i2_rB_isAnyV;
          rs_rB_isAnyV[6]<=rs2i0_rB_isAnyV;
          rs_rB_isAnyV[7]<=rs2i1_rB_isAnyV;
          rs_rB_isAnyV[8]<=rs2i2_rB_isAnyV;

          rs_rT_isV[0]<=rs0i0_rT_isV;
          rs_rT_isV[1]<=rs0i1_rT_isV;
          rs_rT_isV[2]<=rs0i2_rT_isV;
          rs_rT_isV[3]<=rs1i0_rT_isV;
          rs_rT_isV[4]<=rs1i1_rT_isV;
          rs_rT_isV[5]<=rs1i2_rT_isV;
          rs_rT_isV[6]<=rs2i0_rT_isV;
          rs_rT_isV[7]<=rs2i1_rT_isV;
          rs_rT_isV[8]<=rs2i2_rT_isV;

          rs_rT_use[0]<=rs0i0_rT_use;
          rs_rT_use[1]<=rs0i1_rT_use;
          rs_rT_use[2]<=rs0i2_rT_use;
          rs_rT_use[3]<=rs1i0_rT_use;
          rs_rT_use[4]<=rs1i1_rT_use;
          rs_rT_use[5]<=rs1i2_rT_use;
          rs_rT_use[6]<=rs2i0_rT_use;
          rs_rT_use[7]<=rs2i1_rT_use;
          rs_rT_use[8]<=rs2i2_rT_use;

          rs_rT_useF[0]<=rs0i0_rT_useF;
          rs_rT_useF[1]<=rs0i1_rT_useF;
          rs_rT_useF[2]<=rs0i2_rT_useF;
          rs_rT_useF[3]<=rs1i0_rT_useF;
          rs_rT_useF[4]<=rs1i1_rT_useF;
          rs_rT_useF[5]<=rs1i2_rT_useF;
          rs_rT_useF[6]<=rs2i0_rT_useF;
          rs_rT_useF[7]<=rs2i1_rT_useF;
          rs_rT_useF[8]<=rs2i2_rT_useF;

	  isAV_reg<=isAV;
	  isBV_reg<=isBV;
	  isAF_reg<=isAF;
	  isBF_reg<=isBF;

	  rs_operation[0]<=rs0i0_operation;
          rs_operation[1]<=rs0i1_operation;
          rs_operation[2]<=rs0i2_operation;
          rs_operation[3]<=rs1i0_operation;
          rs_operation[4]<=rs1i1_operation;
          rs_operation[5]<=rs1i2_operation;
          rs_operation[6]<=rs2i0_operation;
          rs_operation[7]<=rs2i1_operation;
          rs_operation[8]<=rs2i2_operation;

          rs_port[0]<=rs0i0_port;
          rs_port[1]<=rs0i1_port;
          rs_port[2]<=rs0i2_port;
          rs_port[3]<=rs1i0_port;
          rs_port[4]<=rs1i1_port;
          rs_port[5]<=rs1i2_port;
          rs_port[6]<=rs2i0_port;
          rs_port[7]<=rs2i1_port;
          rs_port[8]<=rs2i2_port;

          rs_enA<={rs2i0_enA,rs1i0_enA,rs0i0_enA};
          rs_enB<={rs2i0_enB,rs1i0_enB,rs0i0_enB};
          rs_enA_reg<=rs_enA;
          rs_enB_reg<=rs_enB;
          rs_enAW_reg<=rs_enAW;
          rs_enBW_reg<=rs_enBW;

          rs_en[0]<=rs0i0_en;
          rs_en[1]<=rs0i1_en;
          rs_en[2]<=rs0i2_en;
          rs_en[3]<=rs1i0_en;
          rs_en[4]<=rs1i1_en;
          rs_en[5]<=rs1i2_en;
          rs_en[6]<=rs2i0_en;
          rs_en[7]<=rs2i1_en;
          rs_en[8]<=rs2i2_en;
          
          rs_lsi[0]<=rs0i0_lsi;
          rs_lsi[1]<=rs1i0_lsi;
          rs_lsi[2]<=rs2i0_lsi;
          rs_lsi[3]<=rs0i1_lsi;
          rs_lsi[4]<=rs1i1_lsi;
          rs_lsi[5]<=rs2i1_lsi;
          
          thread_reg<=thread;
          thread_reg2<=thread_reg;
	  thread_reg3<=thread_reg2;
          bundle_in_reg<=bundle_in;
          bundle_in_reg2<=bundle_in_reg;
          clr_reg<=clr;
          clrS_reg<=clrS;
          
          rs_useBConst<={rs2i2_useBConst,rs2i1_useBConst,rs2i0_useBConst,
            rs1i2_useBConst,rs1i1_useBConst,rs1i0_useBConst,
            rs0i2_useBConst,rs0i1_useBConst,rs0i0_useBConst};
          rs_useBConst_reg<=rs_useBConst;
          rs_useAConst<={rs2i2_useAConst,rs2i1_useAConst,1'b0,
            rs1i2_useAConst,rs1i1_useAConst,1'b0,
            rs0i2_useAConst,rs0i1_useAConst,1'b0};
          depA_reg[2:1]<=(depA[2:1]& rs_rA_use[2:1]) | (depAF[2:1] & rs_rA_useF[2:1]) ;
          depB_reg[2:1]<=(depB[2:1]& rs_rB_use[2:1] & ~rs_useBConst[2:1]) | 
	     (depBF[2:1]& rs_rB_useF[2:1] & ~rs_useBConst[2:1]);
          depA_reg[5:4]<=(depA[5:4]& rs_rA_use[5:4]) | (depAF[5:4] & rs_rA_useF[5:4]) ;
          depB_reg[5:4]<=(depB[5:4]& rs_rB_use[5:4] & ~rs_useBConst[5:4]) | 
	     (depBF[5:4]& rs_rB_useF[5:4] & ~rs_useBConst[5:4]);
          depA_reg[8:7]<=(depA[8:7]& rs_rA_use[8:7]) | (depAF[8:7] & rs_rA_useF[8:7]) ;
          depB_reg[8:7]<=(depB[8:7]& rs_rB_use[8:7] & ~rs_useBConst[8:7]) | 
	     (depBF[8:7]& rs_rB_useF[8:7] & ~rs_useBConst[8:7]);
          depA_reg[0]<=(~Wswp[0]) ? (depA[0]& rs_rA_use[0]) | (depAF[0] & rs_rA_useF[0]) :
             (depB[0]& rs_rB_use[0] & ~rs_useBConst[0]) |(depBF[0]& rs_rB_useF[0] & ~rs_useBConst[0]);
          depB_reg[0]<=Wswp[0] ? (depA[0]& rs_rA_use[0]) | (depAF[0] & rs_rA_useF[0]) :
             (depB[0]& rs_rB_use[0] & ~rs_useBConst[0]) |(depBF[0]& rs_rB_useF[0] & ~rs_useBConst[0]);
          depA_reg[3]<=(~Wswp[1]) ? (depA[3]& rs_rA_use[3]) | (depAF[3] & rs_rA_useF[3]) :
             (depB[3]& rs_rB_use[3] & ~rs_useBConst[3]) |(depBF[3]& rs_rB_useF[3] & ~rs_useBConst[3]);
          depB_reg[3]<=Wswp[1] ? (depA[3]& rs_rA_use[3]) | (depAF[3] & rs_rA_useF[3]) :
             (depB[3]& rs_rB_use[3] & ~rs_useBConst[3]) |(depBF[3]& rs_rB_useF[3] & ~rs_useBConst[3]);
          depA_reg[6]<=(~Wswp[2]) ? (depA[6]& rs_rA_use[6]) | (depAF[6] & rs_rA_useF[6]) :
             (depB[6]& rs_rB_use[6] & ~rs_useBConst[6]) |(depBF[6]& rs_rB_useF[6] & ~rs_useBConst[6]);
          depB_reg[6]<=Wswp[2] ? (depA[6]& rs_rA_use[6]) | (depAF[6] & rs_rA_useF[6]) :
             (depB[6]& rs_rB_use[6] & ~rs_useBConst[6]) |(depBF[6]& rs_rB_useF[6] & ~rs_useBConst[6]);
              
          rs_rA_use<=
             {rs2i2_rA_use,rs2i1_rA_use,rs2i0_rA_use,
              rs1i2_rA_use,rs1i1_rA_use,rs1i0_rA_use,
              rs0i2_rA_use,rs0i1_rA_use,rs0i0_rA_use};
          rs_rB_use<=
             {rs2i2_rB_use,rs2i1_rB_use,rs2i0_rB_use,
              rs1i2_rB_use,rs1i1_rB_use,rs1i0_rB_use,
              rs0i2_rB_use,rs0i1_rB_use,rs0i0_rB_use};
              
          rs_rA_useF<=
             {rs2i2_rA_useF,rs2i1_rA_useF,rs2i0_rA_useF,
              rs1i2_rA_useF,rs1i1_rA_useF,rs1i0_rA_useF,
              rs0i2_rA_useF,rs0i1_rA_useF,rs0i0_rA_useF};
          rs_rB_useF<=
             {rs2i2_rB_useF,rs2i1_rB_useF,rs2i0_rB_useF,
              rs1i2_rB_useF,rs1i1_rB_useF,rs1i0_rB_useF,
              rs0i2_rB_useF,rs0i1_rB_useF,rs0i0_rB_useF};
          
          rs_rA_useF_reg<=rs_rA_useF;
          rs_rB_useF_reg<=rs_rB_useF;
          rs_rA_useF_reg2<=rs_rA_useF_reg;
          rs_rB_useF_reg2<=rs_rB_useF_reg;

	  rs_alt<={rs2i0_alt,rs1i0_alt,rs0i0_alt};
	  rs_alt_reg<=rs_alt;
          
	  instr_rT[0]<=instr0_rT;
	  instr_rT[1]<=instr1_rT;
	  instr_rT[2]<=instr2_rT;
	  instr_rT[3]<=instr3_rT;
	  instr_rT[4]<=instr4_rT;
	  instr_rT[5]<=instr5_rT;
	  instr_rT[6]<=instr6_rT;
	  instr_rT[7]<=instr7_rT;
	  instr_rT[8]<=instr8_rT;
	  instr_rT[9]<=instr9_rT;

          instr_en[0]<=instr0_en;
          instr_en[1]<=instr1_en;
          instr_en[2]<=instr2_en;
          instr_en[3]<=instr3_en;
          instr_en[4]<=instr4_en;
          instr_en[5]<=instr5_en;
          instr_en[6]<=instr6_en;
          instr_en[7]<=instr7_en;
          instr_en[8]<=instr8_en;
          instr_en[9]<=instr9_en;

          instr_wren[0]<=instr0_wren;
          instr_wren[1]<=instr1_wren;
          instr_wren[2]<=instr2_wren;
          instr_wren[3]<=instr3_wren;
          instr_wren[4]<=instr4_wren;
          instr_wren[5]<=instr5_wren;
          instr_wren[6]<=instr6_wren;
          instr_wren[7]<=instr7_wren;
          instr_wren[8]<=instr8_wren;
          instr_wren[9]<=instr9_wren;

          instr_IPOff[0]<=instr0_IPOff;
          instr_IPOff[1]<=instr1_IPOff;
          instr_IPOff[2]<=instr2_IPOff;
          instr_IPOff[3]<=instr3_IPOff;
          instr_IPOff[4]<=instr4_IPOff;
          instr_IPOff[5]<=instr5_IPOff;
          instr_IPOff[6]<=instr6_IPOff;
          instr_IPOff[7]<=instr7_IPOff;
          instr_IPOff[8]<=instr8_IPOff;
          instr_IPOff[9]<=instr9_IPOff;

          instr_afterTaken[0]<=instr0_afterTaken;
          instr_afterTaken[1]<=instr1_afterTaken;
          instr_afterTaken[2]<=instr2_afterTaken;
          instr_afterTaken[3]<=instr3_afterTaken;
          instr_afterTaken[4]<=instr4_afterTaken;
          instr_afterTaken[5]<=instr5_afterTaken;
          instr_afterTaken[6]<=instr6_afterTaken;
          instr_afterTaken[7]<=instr7_afterTaken;
          instr_afterTaken[8]<=instr8_afterTaken;
          instr_afterTaken[9]<=instr9_afterTaken;

          instr_rT_useF[0]<=instr0_rT_useF;
          instr_rT_useF[1]<=instr1_rT_useF;
          instr_rT_useF[2]<=instr2_rT_useF;
          instr_rT_useF[3]<=instr3_rT_useF;
          instr_rT_useF[4]<=instr4_rT_useF;
          instr_rT_useF[5]<=instr5_rT_useF;
          instr_rT_useF[6]<=instr6_rT_useF;
          instr_rT_useF[7]<=instr7_rT_useF;
          instr_rT_useF[8]<=instr8_rT_useF;
          instr_rT_useF[9]<=instr9_rT_useF;

          instr_rT_isV[0]<=instr0_rT_isV;
          instr_rT_isV[1]<=instr1_rT_isV;
          instr_rT_isV[2]<=instr2_rT_isV;
          instr_rT_isV[3]<=instr3_rT_isV;
          instr_rT_isV[4]<=instr4_rT_isV;
          instr_rT_isV[5]<=instr5_rT_isV;
          instr_rT_isV[6]<=instr6_rT_isV;
          instr_rT_isV[7]<=instr7_rT_isV;
          instr_rT_isV[8]<=instr8_rT_isV;
          instr_rT_isV[9]<=instr9_rT_isV;

          instr_port[0]<=instr0_port;
          instr_port[1]<=instr1_port;
          instr_port[2]<=instr2_port;
          instr_port[3]<=instr3_port;
          instr_port[4]<=instr4_port;
          instr_port[5]<=instr5_port;
          instr_port[6]<=instr6_port;
          instr_port[7]<=instr7_port;
          instr_port[8]<=instr8_port;
          instr_port[9]<=instr9_port;

          instr_magic[0]<=instr0_magic;
          instr_magic[1]<=instr1_magic;
          instr_magic[2]<=instr2_magic;
          instr_magic[3]<=instr3_magic;
          instr_magic[4]<=instr4_magic;
          instr_magic[5]<=instr5_magic;
          instr_magic[6]<=instr6_magic;
          instr_magic[7]<=instr7_magic;
          instr_magic[8]<=instr8_magic;
          instr_magic[9]<=instr9_magic;
          
	  instr_last[0]<=instr0_last;
          instr_last[1]<=instr1_last;
          instr_last[2]<=instr2_last;
          instr_last[3]<=instr3_last;
          instr_last[4]<=instr4_last;
          instr_last[5]<=instr5_last;
          instr_last[6]<=instr6_last;
          instr_last[7]<=instr7_last;
          instr_last[8]<=instr8_last;
          instr_last[9]<=instr9_last;
          
	  instr_aft_spc[0]<=instr0_aft_spc;
	  instr_aft_spc[1]<=instr1_aft_spc;
	  instr_aft_spc[2]<=instr2_aft_spc;
	  instr_aft_spc[3]<=instr3_aft_spc;
	  instr_aft_spc[4]<=instr4_aft_spc;
	  instr_aft_spc[5]<=instr5_aft_spc;
	  instr_aft_spc[6]<=instr6_aft_spc;
	  instr_aft_spc[7]<=instr7_aft_spc;
	  instr_aft_spc[8]<=instr8_aft_spc;
	  instr_aft_spc[9]<=instr9_aft_spc;

	  jump0TbufWay_reg<=jump0TbufWay;
          jump0JmpInd_reg<=jump0JmpInd;
          jump0GHT_reg<=jump0GHT;
          jump1TbufWay_reg<=jump1TbufWay;
          jump1JmpInd_reg<=jump1JmpInd;
          jump1GHT_reg<=jump1GHT;
          jump0SC_reg<=jump0SC;
          jump0Miss_reg<=jump0Miss;
          jump0TbufOnly_reg<=jump0TbufOnly;
          jump1SC_reg<=jump1SC;
          jump1Miss_reg<=jump1Miss;
          jump1TbufOnly_reg<=jump1TbufOnly;
	  jump0Type_reg<=jump0Type;
	  jump0Pos_reg<=jump0Pos;
	  jump0Pred_reg<=jump0Pred;
	  jump0IP_reg<=jump0IP;
          jump0Mask_reg<=jump0Mask;
	  jump1Type_reg<=jump1Type;
	  jump1Pos_reg<=jump1Pos;
	  jump1Pred_reg<=jump1Pred;
	  jump1IP_reg<=jump1IP;
          jump1Mask_reg<=jump1Mask;
          instr_fsimd_reg<=instr_fsimd;
	  baseIP_reg<=baseIP;
          
	  jump0TbufWay_reg2<=jump0TbufWay_reg;
          jump0JmpInd_reg2<=jump0JmpInd_reg;
          jump0GHT_reg2<=jump0GHT_reg;
          jump1TbufWay_reg2<=jump1TbufWay_reg;
          jump1JmpInd_reg2<=jump1JmpInd_reg;
          jump1GHT_reg2<=jump1GHT_reg;
          jump0SC_reg2<=jump0SC_reg;
          jump0Miss_reg2<=jump0Miss_reg;
          jump0TbufOnly_reg2<=jump0TbufOnly_reg;
          jump1SC_reg2<=jump1SC_reg;
          jump1Miss_reg2<=jump1Miss_reg;
          jump1TbufOnly_reg2<=jump1TbufOnly_reg;
	  jump0Type_reg2<=jump0Type_reg;
	  jump0Pos_reg2<=jump0Pos_reg;
	  jump0Pred_reg2<=jump0Pred_reg;
	  jump0IP_reg2<=jump0IP_reg;
          jump0Mask_reg2<=jump0Mask_reg;
	  jump1Type_reg2<=jump1Type_reg;
	  jump1Pos_reg2<=jump1Pos_reg;
	  jump1Pred_reg2<=jump1Pred_reg;
	  jump1IP_reg2<=jump1IP_reg;
          jump1Mask_reg2<=jump1Mask_reg;
          instr_fsimd_reg2<=instr_fsimd_reg;
     
          wrt0_reg<=wrt0;
          wrt1_reg<=wrt1;
          wrt2_reg<=wrt2;
          
          wrtO0_reg<=wrtO0;
          wrtO1_reg<=wrtO1;
          wrtO2_reg<=wrtO2;
          wrtII0_reg<=wrtII0;
          wrtII1_reg<=wrtII1;
          wrtII2_reg<=wrtII2;
          WQR_reg[0]<=WQR[0];
          WQR_reg[1]<=WQR[1];
          WQR_reg[2]<=WQR[2];
          WQS_reg[0]<=WQS[0];
          WQS_reg[1]<=WQS[1];
          WQS_reg[2]<=WQS[2];
 
          lsi_cnt_reg<=lsi_cnt[5:0];
 
          ldq_new_mask_reg<=ldq_new_mask;
          LSQ_lsqA_reg<=LSQ_lsqA;
          LSQ_lsqB_reg<=LSQ_lsqB;
          LSQ_indA_reg<=LSQ_indA;
          LSQ_indB_reg<=LSQ_indB;
          LSQ_wqA_reg<=LSQ_wqA;
          LSQ_wqB_reg<=LSQ_wqB;
          Wswp_reg<=Wswp;
          WopA_reg<=WopA;
          WopB_reg<=WopB;
          for(k=0;k<9;k=k+1) begin
              clrR_reg[k]<=clrR[k];
              rs_const_reg[k]<=rs_const[k];
              rs_index_reg[k]<=rs_index[k];
              rs_operation_reg[k]<=rs_operation[k];
              rs_operation_reg2[k]<=rs_operation_reg[k];
              if (rs_port[k]==PORT_LOAD || rs_port[k]==PORT_STORE) rs_port_sch[k]<=4'd0;
              else if (k%3==1) rs_port_sch[k]<=4'd1;
              else rs_port_sch[k]<=4'd2;
              if (rs_port[k]==PORT_SHIFT || rs_port[k]==PORT_MUL) rs_port_sch[k]<=4'd2;
              if (rs_port[k]==PORT_FADD) rs_port_sch[k]<=4'b1001;
              if (rs_port[k]==PORT_FMUL) rs_port_sch[k]<=4'b1010;
              if (rs_port[k]==PORT_FANY) rs_port_sch[k][3]<=1'b1;
              if (rs_port[k]==PORT_VADD) rs_port_sch[k]<=4'b101;
              if (rs_port[k]==PORT_VCMP) rs_port_sch[k]<=4'b110;
              if (rs_port[k]==PORT_VANY) rs_port_sch[k][2]<=1'b1;
              if (rs_port[k]==PORT_ALU && (rs_port[(k/3)*3+2]==PORT_VADD || rs_port[(k/3)*3+2]==PORT_FADD))
                 rs_port_sch[k]<=4'd2;             
              
              rs_port_reg[k]<=rs_port[k];
              
              regA_reg[k]<=(rs_rA_use[k] ? regA[k] : regAF[k])|{REG_WIDTH{~rs_rA_use[k]&~rs_rA_useF[k]}};
              regB_reg[k]<=(rs_rB_use[k] ? regB[k] : regBF[k])|{REG_WIDTH{~rs_rB_use[k]&~rs_rB_useF[k]||rs_useBConst[k]}};
	      if (rs_rA_useF[k]) regAF_reg[k]<=regAF[k];
	      if (rs_rB_useF[k]) regBF_reg[k]<=regBF[k];
	      regAF_reg2[k]<=regAF_reg[k];
	      regBF_reg2[k]<=regBF_reg[k];
	      retAF_reg[k]<=retAF[k];
	      retBF_reg[k]<=retBF[k];
	      retAF_reg2[k]<=retAF_reg[k];
	      retBF_reg2[k]<=retBF_reg[k];
              regS_reg[k]<=regS[k];
              newR_reg[k]<=newR[k];
              rs_en_reg[k]<=rs_en[k];
              funA_reg[k]<=rs_rA_useF[k] ? funAF[k] : funA[k];
              funB_reg[k]<=rs_rB_useF[k] ? funBF[k] : funB[k];
              funS_reg[k]<=funS[k];
              rs_lsi_reg[k]<=get_lsi(rs_lsi[k]);
              domA_reg[k]<=domA[k];
              domB_reg[k]<=domB[k];
              instr_ret_reg[k]<=instr_ret[k];
          end
	  for(t=0;t<3;t=t+1) begin
              rrfAW_reg[t]<=rrfAW[t];
              rrfBW_reg[t]<=rrfBW[t];
              rrfAW_reg2[t]<=rrfAW_reg[t];
              rrfBW_reg2[t]<=rrfBW_reg[t];
              regAW_reg[t]<=(rs_rAW_use[t] ? regAW[t] : regAWF[t])|{REG_WIDTH{~rs_rAW_use[t]&~rs_rAW_useF[t]||useAConstW[t]}};
              regBW_reg[t]<=(rs_rBW_use[t] ? regBW[t] : regBFW[t])|{REG_WIDTH{~rs_rBW_use[t]&~rs_rBW_useF[t]||useBConstW[t]}};
              regAW_reg[t]<=regAW[t];
              regBW_reg[t]<=regBW[t];
              regAWF_reg[t]<=regAWF[t];
              regBFW_reg[t]<=regBFW[t];
              regAWF_reg2[t]<=regAWF_reg[t];
              regBFW_reg2[t]<=regBFW_reg[t];
	      retAWF_reg[t]<=retAWF[t];
	      retBFW_reg[t]<=retBFW[t];
	      retAWF_reg2[t]<=retAWF_reg[t];
	      retBFW_reg2[t]<=retBFW_reg[t];
	      isAWF_reg[t]<=isAWF[t];
	      isBFW_reg[t]<=isBFW[t];
	      isAWV_reg[t]<=isAWV[t];
          isBVW_reg[t]<=isBVW[t];
	      rs_rAW_useF_reg[t]<=rs_rAW_useF[t];
	      rs_rBW_useF_reg[t]<=rs_rBW_useF[t];
	      rs_rAW_useF_reg2[t]<=rs_rAW_useF_reg[t];
	      rs_rBW_useF_reg2[t]<=rs_rBW_useF_reg[t];
	      Wport_reg[t]<=Wport[t];
	  end
	  for(t=0;t<10;t=t+1) begin
	      instr_rT_reg[t]<=instr_rT[t];
              instr_en_reg[t]<=instr_en[t];
              instr_wren_reg[t]<=instr_wren[t];
              instr_IPOff_reg[t]<=instr_IPOff[t];
              instr_afterTaken_reg[t]<=instr_afterTaken[t];
              instr_rT_useF_reg[t]<=instr_rT_useF[t];
              instr_rT_isV_reg[t]<=instr_rT_isV[t];
              instr_port_reg[t]<=instr_port[t];
              //instr_magic_reg[t]<=instr_magic[t];
              instr_last_reg[t]<=instr_last[t];
	      instr_aft_spc_reg[t]<=instr_aft_spc[t];
	      casex(instr_magic[t])
		  4'bxxx0: instr_magicOff[t]<=3'd1;
		  4'bxx01: instr_magicOff[t]<=3'd2;
		  4'bx011: instr_magicOff[t]<=3'd3;
		  4'b0111: instr_magicOff[t]<=3'd4;
		  4'b1111: instr_magicOff[t]<=4'd5;
	      endcase
	      casex({instr_rT_useF[t],instr_rT_isV[t],instr_port[t]==PORT_LOAD})
		  3'b0xx: begin instr_gen[t]<=1'b1; instr_vec[t]<=1'b0; end
		  3'b100: begin instr_gen[t]<=1'b0; instr_vec[t]<=1'b0; end
		  3'b110: begin instr_gen[t]<=1'b0; instr_vec[t]<=1'b1; end
		  3'b1x1: begin instr_gen[t]<=1'b1; instr_vec[t]<=1'b1; end
	      endcase
	  end
	  
      end
      if (except) begin
          if ((excpt_thread==thread && ~doStall)||(excpt_thread==thread_reg && doStall)) begin
              bundle_in_reg<=1'b0;
              rs_en[0]<=1'b0;            
              rs_en[1]<=1'b0;            
              rs_en[2]<=1'b0;            
              rs_en[3]<=1'b0;            
              rs_en[4]<=1'b0;            
              rs_en[5]<=1'b0;            
              rs_en[6]<=1'b0;            
              rs_en[7]<=1'b0;            
              rs_en[8]<=1'b0;            
              
              rs0i0_alloc_reg<=1'b0;
              rs0i1_alloc_reg<=1'b0;
              rs0i2_alloc_reg<=1'b0;
              rs1i0_alloc_reg<=1'b0;
              rs1i1_alloc_reg<=1'b0;
              rs1i2_alloc_reg<=1'b0;
              rs2i0_alloc_reg<=1'b0;
              rs2i1_alloc_reg<=1'b0;
              rs2i2_alloc_reg<=1'b0;
    
              rs0i0_allocF_reg<=1'b0;
              rs0i1_allocF_reg<=1'b0;
              rs0i2_allocF_reg<=1'b0;
              rs1i0_allocF_reg<=1'b0;
              rs1i1_allocF_reg<=1'b0;
              rs1i2_allocF_reg<=1'b0;
              rs2i0_allocF_reg<=1'b0;
              rs2i1_allocF_reg<=1'b0;
              rs2i2_allocF_reg<=1'b0;
    
              rs0i0_allocR_reg<=1'b0;
              rs0i1_allocR_reg<=1'b0;
              rs0i2_allocR_reg<=1'b0;
              rs1i0_allocR_reg<=1'b0;
              rs1i1_allocR_reg<=1'b0;
              rs1i2_allocR_reg<=1'b0;
              rs2i0_allocR_reg<=1'b0;
              rs2i1_allocR_reg<=1'b0;
              rs2i2_allocR_reg<=1'b0;
              
              rs_rT_use<=9'b0;
              rs_rT_useF<=9'b0;
          end
          if ((excpt_thread==thread_reg && ~doStall) || (excpt_thread==thread_reg2 && doStall)) begin
              bundle_in_reg2<=1'b0;
              rs_en_reg[0]<=1'b0;
              rs_en_reg[1]<=1'b0;
              rs_en_reg[2]<=1'b0;
              rs_en_reg[3]<=1'b0;
              rs_en_reg[4]<=1'b0;
              rs_en_reg[5]<=1'b0;
              rs_en_reg[6]<=1'b0;
              rs_en_reg[7]<=1'b0;
              rs_en_reg[8]<=1'b0;
              ldq_new_mask_reg<=6'b0;
          end
      end

     /* if (rst) begin
          retM_ret_ret<=1'b1;
          //retM_on_next<=1'b0;
          retM_data_shr_reg<={`lsqshare_width{1'b0}};
      end else begin
          if (retB_clkEn & ~retM_do_retire) retM_ret_ret<=1'b0;
          else if (retM_do_retire & ~retB_clkEn) retM_ret_ret<=1'b1;
          if (retM_ret_ret|retM_do_retire) retM_data_shr_reg<=retM_data_shr;
      end*/
      if (rst) begin
	  for(k=0;k<4;k=k+1) begin
	      fxLD_dbl[k]=1'b1;
	      fxLD_ext[k]=1'b0;
	      fxLD_dblext[k]=1'b1;
	      fxLD_sin[k]=1'b0;
	      fxLD_dbl_t[k]=1'b1;
	      fxLD_ext_t[k]=1'b0;
	      fxLD_sngl_t[k]=1'b0;
	      fxLD_spair_t[k]=1'b0;
	  end
      end else begin
	  for(k=0;k<4;k=k+1) begin
	      fxLD_dbl[k]=1'b0;
	      fxLD_ext[k]=1'b0;
	      fxLD_sin[k]=1'b0;
	      fxLD_dbl_t[k]=1'b0;
	      fxLD_ext_t[k]=1'b0;
	      fxLD_sngl_t[k]=1'b0;
	      fxLD_spair_t[k]=1'b0;
	      case(outOp_reg2[k][5:1])
		  4,5,6,2,5'he,5'hb: fxLD_sin[k]=1'b1;
		  3: fxLD_ext[k]=1'b1;
		  default: fxLD_dbl[k]=1'b1;
	      endcase
	      case(outOp_reg2[k][5:1])
                  2,5'he,5: fxLD_sngl_t[k]=1'b1;
		  3,4,8: fxLD_ext_t[k]=1'b1;
		  default: fxLD_dbl_t[k]=1'b1; 
	      endcase
	      fxLD_spair_t[k]=outOp_reg2[5:1]==5'ha;
	      fxLD_dblext[k]=fxLD_dbl[k]|fxLD_ext[k];
	  end
      end
      if (rst) begin
          for (k=0;k<9;k=k+1) begin
              outReg_reg[k]<={REG_WIDTH{1'B0}};
              outReg_reg2[k]<={REG_WIDTH{1'B0}};
              outReg_reg3[k]<={REG_WIDTH{1'B0}};
              outOp_reg[k]<={REG_WIDTH{1'B0}};
              outOp_reg2[k]<={REG_WIDTH{1'B0}};
              outOp_reg3[k]<={REG_WIDTH{1'B0}};
              outOp_reg4[k]<={REG_WIDTH{1'B0}};
              outOp_reg5[k]<={REG_WIDTH{1'B0}};
              outOp_reg6[k]<={REG_WIDTH{1'B0}};
              outOp_reg7[k]<={REG_WIDTH{1'B0}};
              outOp_reg8[k]<={REG_WIDTH{1'B0}};
              outII_reg[k]<=10'b0;
              outII_reg2[k]<=10'b0;
              outII_reg3[k]<=10'b0;
              outII_reg4[k]<=10'b0;
              outII_reg5[k]<=10'b0;
              outII_reg6[k]<=10'b0;
              outII_reg7[k]<=10'b0;
              outII_reg8[k]<=10'b0;
              outEn_reg[k]<=4'b0;
              outEn_reg2[k]<=4'b0;
              outEn_reg3[k]<=4'b0;
              outEn_reg4[k]<=4'b0;
              outEn_reg5[k]<=4'b0;
              outEn_reg6[k]<=4'b0;
              outEn_reg7[k]<=4'b0;
              outEn_reg8[k]<=4'b0;
              outThr_reg[k]<=1'b0;
          end
          for (k=0;k<6;k=k+1) begin
	      FUS_alu_reg[k]<=6'b0;
	      ex_alu_reg[k]<=3'b0;
	      enS_alu_reg[k]<=1'b0;
	      FUS_alu_reg2[k]<=6'b0;
	      ex_alu_reg2[k]<=3'b0;
	      enS_alu_reg2[k]<=1'b0;
	      FUS_alu_reg3[k]<=6'b0;
	      ex_alu_reg3[k]<=3'b0;
	      enS_alu_reg3[k]<=1'b0;
	      FUS_alu_reg4[k]<=6'b0;
	      ex_alu_reg4[k]<=3'b0;
	      enS_alu_reg4[k]<=1'b0;
	      FUS_alu_reg5[k]<=6'b0;
	      ex_alu_reg5[k]<=3'b0;
	      enS_alu_reg5[k]<=1'b0;
	      FUS_alu_reg6[k]<=6'b0;
	      ex_alu_reg6[k]<=3'b0;
	      enS_alu_reg6[k]<=1'b0;
          end
         /* fxAlt1_reg<=1'b0;
          fxAlt2_reg<=1'b0;
          fxAlt1_reg2<=1'b0;
          fxAlt2_reg2<=1'b0;
          fxAlt1_reg3<=1'b0;
          fxAlt2_reg3<=1'b0;*/
	  fxFRT_dblL=1'b0;
	  fxFRT_dblH=1'b0;
	  fxFRT_ext=1'b0;
	  fxFRT_sngl=1'b0;
/*	  fxFRT_dblL_reg<=1'b0;
          fxFRT_dblH_reg<=1'b0;
          fxFRT_ext_reg<=1'b0;
          fxFRT_sngl_reg<=1'b0;*/
          fxFRT_isRoot=1'b0;
//	  fxFRT_isRoot_reg<=1'b0;
	  fxFRT_dblL_s<=1'b0;
          fxFRT_dblH_s<=1'b0;
          fxFRT_ext_s<=1'b0;
          fxFRT_sngl_s<=1'b0;
	  fxFRT_dblL_ns<=1'b0;
          fxFRT_dblH_ns<=1'b0;
          fxFRT_ext_ns<=1'b0;
          fxFRT_sngl_ns<=1'b0;
	  fxFRT_steps<=5'd0;
	  fxFRT_type<=3'b0;
	  fxFRT_steps_reg<=5'd0;
	  fxFRT_type_reg<=3'b0;
	  fxFRT_don_reg<=4'b0;
	  fxFRT_en<=1'b0;
	  rtDataA_reg<={2*SIMD_WIDTH{1'b0}};
	  rtDataB_reg<={2*SIMD_WIDTH{1'b0}};
	  fxFRT_alten_reg[0]<=4'b0;
	  fxFRT_alten_reg2[0]<=4'b0;
	  fxFRT_alten_reg3[0]<=4'b0;
	  fxFRT_alten_reg[1]<=4'b0;
	  fxFRT_alten_reg2[1]<=4'b0;
	  fxFRT_alten_reg3[1]<=4'b0;
	  fxFRT_alten_reg[2]<=4'b0;
	  fxFRT_alten_reg2[2]<=4'b0;
	  fxFRT_alten_reg3[2]<=4'b0;
	  fxFRT_alten_reg4[2]<=4'b0;
	  fxFRT_alten_reg5[2]<=4'b0;
	  fxFRT_alten_reg6[2]<=4'b0;
	  fxFRT_can_reg<=4'd0;
	  fxFRT_don_reg<=4'd0;
	  fxFRT_don_reg2<=4'd0;
	  fxFRT_don_reg3<=4'd0;
	  fxFRT_don_reg4<=4'd0;
	  frtReg_reg<=9'b0;
	  frtII_reg<=10'b0;
	  frtOp_reg<=13'b0;
	  FUCVT2_reg<=82'b0;
	  FUCVT2_reg2<=82'b0;
	  FUCVT2_reg3<=82'b0;
	  FUCVT2_reg4<=82'b0;
	  FUCVT2_reg5<=82'b0;
	  FUCVT2_reg6<=82'b0;
	  FUTYPE_reg<=`ptype_dbl;
	  FUTYPE_reg2<=`ptype_dbl;
	  FUTYPE_reg3<=`ptype_dbl;
	  FUTYPE_reg4<=`ptype_dbl;
	  FUTYPE_reg5<=`ptype_dbl;
	  FUTYPE_reg6<=`ptype_dbl;
      end else begin
          for (k=0;k<9;k=k+1) begin
              outReg_reg[k]<=outReg[k];
              outReg_reg2[k]<=outReg_reg[k];
              outReg_reg3[k]<=outReg_reg2[k];
              outOp_reg[k]<=outOp[k];
              outOp_reg2[k]<=outOp_reg[k];
              outOp_reg3[k]<=outOp_reg2[k];
              outOp_reg4[k]<=outOp_reg3[k];
              outOp_reg5[k]<=outOp_reg4[k];
              outOp_reg6[k]<=outOp_reg5[k];
              outOp_reg7[k]<=outOp_reg6[k];
              outOp_reg8[k]<=outOp_reg7[k];
              outII_reg[k]<=outII[k];
              outII_reg2[k]<=outII_reg[k];
              outII_reg3[k]<=outII_reg2[k];
              outII_reg4[k]<=outII_reg3[k];
              outII_reg5[k]<=outII_reg4[k];
              outII_reg6[k]<=outII_reg5[k];
              outII_reg7[k]<=outII_reg6[k];
              outII_reg8[k]<=outII_reg7[k];
              outEn_reg[k]<=outEn[k];
              outEn_reg2[k]<=outEn_reg[k];
              outEn_reg3[k]<=outEn_reg2[k];
              outEn_reg4[k]<=outEn_reg3[k];
              outEn_reg5[k]<=outEn_reg4[k];
              outEn_reg6[k]<=outEn_reg5[k];
              outEn_reg7[k]<=outEn_reg6[k];
              outEn_reg8[k]<=outEn_reg7[k];
              outThr_reg[k]<=outThr[k];
          end
          for (k=0;k<6;k=k+1) begin
	      FUS_alu_reg[k]<=FUS_alu[k];
	      ex_alu_reg[k]<=ex_alu[k];
	      enS_alu_reg[k]<=enS_alu[k];
	      FUS_alu_reg2[k]<=FUS_alu_reg[k];
	      ex_alu_reg2[k]<=ex_alu_reg[k];
	      enS_alu_reg2[k]<=enS_alu_reg[k];
	      FUS_alu_reg3[k]<=FUS_alu_reg2[k];
	      ex_alu_reg3[k]<=ex_alu_reg2[k];
	      enS_alu_reg3[k]<=enS_alu_reg2[k];
	      FUS_alu_reg4[k]<=FUS_alu_reg3[k];
	      ex_alu_reg4[k]<=ex_alu_reg3[k];
	      enS_alu_reg4[k]<=enS_alu_reg3[k];
	      FUS_alu_reg5[k]<=FUS_alu_reg4[k];
	      ex_alu_reg5[k]<=ex_alu_reg4[k];
	      enS_alu_reg5[k]<=enS_alu_reg4[k];
	      FUS_alu_reg6[k]<=FUS_alu_reg5[k];
	      ex_alu_reg6[k]<=ex_alu_reg5[k];
	      enS_alu_reg6[k]<=enS_alu_reg5[k];
          end
          /*fxAlt1_reg<=fxAlt1;
          fxAlt2_reg<=fxAlt2;
          fxAlt1_reg2<=fxAlt1_reg;
          fxAlt2_reg2<=fxAlt2_reg;
          fxAlt1_reg3<={fxAlt1_reg2,2'b0};
          fxAlt2_reg3<=fxAlt2_reg2;*/
    
    	  fxFRT_dblL=frtOp[7:0]==`fop_sqrtDL || frtOp[7:0]==`fop_divDL;
          fxFRT_dblH=frtOp[7:0]==`fop_sqrtDH || frtOp[7:0]==`fop_divDH;
          fxFRT_ext=frtOp[7:0]==`fop_sqrtE || frtOp[7:0]==`fop_divE;
          fxFRT_sngl=frtOp[7:0]==`fop_sqrtS || frtOp[7:0]==`fop_divS;
	  fxFRT_isRoot=frtOp[7:0]==`fop_sqrtDL || frtOp[7:0]==`fop_sqrtDH ||
                frtOp[7:0]==`fop_sqrtE || frtOp[7:0]==`fop_sqrtS; 
	  fxFRT_dblL_ns<=fxFRT_dblL && ~rtDataA[53]|~fxFRT_isRoot;
	  fxFRT_dblH_ns<=fxFRT_dblH && ~rtDataA[SIMD_WIDTH+53]|~fxFRT_isRoot;
	  fxFRT_ext_ns<=fxFRT_ext && ~rtDataA[SIMD_WIDTH]|~fxFRT_isRoot;
	  fxFRT_sngl_ns<=fxFRT_sngl && ~rtDataA[23]|~fxFRT_isRoot;
	  fxFRT_dblL_s<=fxFRT_dblL && rtDataA[53]&fxFRT_isRoot;
	  fxFRT_dblH_s<=fxFRT_dblH && rtDataA[SIMD_WIDTH+53]&fxFRT_isRoot;
	  fxFRT_ext_s<=fxFRT_ext && rtDataA[SIMD_WIDTH]&fxFRT_isRoot;
	  fxFRT_sngl_s<=fxFRT_sngl && rtDataA[23]&fxFRT_isRoot;
    /* 	  fxFRT_dblL_reg<=fxFRT_dblL;
          fxFRT_dblH_reg<=fxFRT_dblH;
          fxFRT_ext_reg<=fxFRT_ext;
          fxFRT_sngl_reg<=fxFRT_sngl;*/
     //     fxFRT_isRoot_reg<=fxFRT_isRoot;
	  fxFRT_en<=outOp[3*2+2][11] && outEn[3*2+2][3]; 
	  if (frtOp[7:0]==`fop_sqrtDL || frtOp[7:0]==`fop_divDL ||
	    frtOp[7:0]==`fop_sqrtDH || frtOp[7:0]==`fop_divDH) begin
	      fxFRT_steps<=5'd13;
	      fxFRT_type<=3'b0;
	  end else if (frtOp[7:0]==`fop_sqrtE || frtOp[7:0]==`fop_divE) begin
	      fxFRT_steps<=5'd16;
	      fxFRT_type<=3'd1;
	  end else if (frtOp[7:0]==`fop_sqrtS || frtOp[7:0]==`fop_divS) begin
	      fxFRT_steps<=5'd6;
	      fxFRT_type<=3'd2;
	  end
	 /* fxFRT_steps_reg<=fxFRT_steps;
	  fxFRT_type_reg<=fxFRT_type;*/
	  fxFRT_don_reg<=fxFRT_don;
	  fxFRT_alten_reg[2]<=fxFRT_alten[2];
	  fxFRT_alten_reg2[2]<=fxFRT_alten_reg[2];
	  fxFRT_alten_reg3[2]<=fxFRT_alten_reg2[2];
	  fxFRT_alten_reg4[2]<=fxFRT_alten_reg3[2];
	  fxFRT_alten_reg5[2]<=fxFRT_alten_reg4[2];
	  fxFRT_alten_reg6[2]<=fxFRT_alten_reg5[2];
	  fxFRT_can_reg<=fxFRT_can;
	  fxFRT_don_reg<=fxFRT_don;
	  fxFRT_don_reg2<=fxFRT_don_reg;
	  fxFRT_don_reg3<=fxFRT_don_reg2;
	  fxFRT_don_reg4<=fxFRT_don_reg3;
	  frtReg_reg<=frtReg;
      frtII_reg<=frtII;
      frtOp_reg<=frtOp;
	  if (fxFRT_don_reg2) begin
              rtDataA_reg<=rtDataA;
	      rtDataB_reg<=rtDataB;
	  end
	  FUCVT2_reg<=FUCVT2;
	  FUCVT2_reg2<=FUCVT2_reg;
	  FUCVT2_reg3<=FUCVT2_reg2;
	  FUCVT2_reg4<=FUCVT2_reg3;
	  FUCVT2_reg5<=FUCVT2_reg4;
	  FUCVT2_reg6<=FUCVT2_reg5;
	  FUTYPE_reg<=FUTYPE;
	  FUTYPE_reg2<=FUTYPE_reg;
	  FUTYPE_reg3<=FUTYPE_reg2;
	  FUTYPE_reg4<=FUTYPE_reg3;
	  FUTYPE_reg5<=FUTYPE_reg4;
	  FUTYPE_reg6<=FUTYPE_reg5;
      end
      
      if (rst) agu_flip<=1'b0;
      else agu_flip<=~agu_flip;
      
      if (rst) begin
          bus_holds_agu<=1'b0;
          bus_holds_agu_reg<=1'b0;
          bus_holds_agu_reg2<=1'b0;
          bus_holds_agu_reg3<=1'b0;
          bus_holds_agu_reg4<=1'b0;
          bus_holds_agu_reg5<=1'b0;
          miss_holds_agu_reg<=1'b0;
          miss_holds_agu_reg2<=1'b0;
          miss_pause_agu_reg<=1'b0;
          miss_pause_agu_reg2<=1'b0;
          insert_isData_reg<=1'b0;
          insert_isData_reg2<=1'b0;
          insert_isData_reg3<=1'b0;
          insert_isData_reg4<=1'b0;
          insert_isData_reg5<=1'b0;
          insert_isData_reg6<=1'b0;
          insert_isData_reg7<=1'b0;
          insert_isData_reg8<=1'b0;
          insBus_exclusive_reg<=1'b0;
          insBus_exclusive_reg2<=1'b0;
          insBus_exclusive_reg3<=1'b0;
          insBus_dirty_reg<=1'b0;
          insBus_dirty_reg2<=1'b0;
          insBus_dirty_reg3<=1'b0;
          insBus_data_reg<={BUS_WIDTH{1'B0}};
          insBus_data_reg2<={BUS_WIDTH{1'B0}};
          insert_addr_reg<=37'b0;
          insert_addr_reg2<=37'b0;
          insert_addr_reg3<=37'b0;
          insBus_req_reg<={REQ_WIDTH{1'B0}};
          dc_rdEn_reg<=4'b0;
          dc_rdEn_reg2<=4'b0;
          dc_rdEn_reg3<=4'b0;
          dc_tlb_miss_reg<=3'b0;
          reqBus_en<=1'b0;
          reqBus_req<=10'b0;
          reqBus_addr<=37'b0;
          reqBus_want_excl<=1'b0;
          reqBus_dupl<=1'b0;
	  reqBus_sz<=5'b0;
	  reqBus_low<=2'b0;
	  reqBus_bank0<=5'd0;
	  reqBus_io<=1'b0;
  //        insBus_en<=1'b0;
  //        insBus_req<=10'b0;
  //        insBus_data<={BUS_WIDTH{1'b0}};
          dc_confl_reg<=4'b0;
          dc_confl_reg2<=4'b0;
          miss_unlock_reg<=1'b0;
          dc_wrEn_reg<=2'b0;
          dc_wrEn_reg2<=2'b0;
          dc_wrEn_reg3<=2'b0;
          wrStall_reg<=1'b0;
          for(k=0;k<4;k=k+1) begin
              dc_rdReg_reg[k]<={REG_WIDTH{1'B0}};
              dc_rdReg_reg2[k]<={REG_WIDTH{1'B0}};
              dc_rdReg_reg3[k]<={REG_WIDTH{1'B0}};
              if (k<2) begin
                  dc_II_wr_reg[k]<=10'b0;
                  dc_II_wr_reg2[k]<=10'b0;
                  dc_II_wr_reg3[k]<=10'b0;
                  dc_wrAddrE_reg[k]<={PADDR_WIDTH-8{1'b0}};
                  dc_wrAddrO_reg[k]<={PADDR_WIDTH-8{1'b0}};
                  dc_wrBanks_reg[k]<=32'b0;
                  dc_odd_wr_reg[k]<=1'b0;
                  dc_split_wr_reg[k]<=1'b0;
                  dc_wrBegin_reg[k]<=5'd0;
                  dc_wrEnd_reg[k]<=5'd0;
                  dc_wrBGN_BNK_reg[k]<=4'hf;
                  dc_wrEND_BNK_reg[k]<=4'hf;
                  dc_wdata_reg[k]<=dc_wdata[k];
                  dc_wrAddrE_reg2[k]<={PADDR_WIDTH-8{1'b0}};
                  dc_wrAddrO_reg2[k]<={PADDR_WIDTH-8{1'b0}};
                  dc_wrBanks_reg2[k]<=32'b0;
                  dc_odd_wr_reg2[k]<=1'b0;
                  dc_split_wr_reg2[k]<=1'b0;
                  dc_wrBegin_reg2[k]<=5'd0;
                  dc_wrEnd_reg2[k]<=5'd0;
                  dc_wrBGN_BNK_reg2[k]<=4'hf;
                  dc_wrEND_BNK_reg2[k]<=4'hf;
                  dc_wdata_reg2[k]<=dc_wdata_reg[k];
                  dc_wrAddrE_reg3[k]<={PADDR_WIDTH-8{1'b0}};
                  dc_wrAddrO_reg3[k]<={PADDR_WIDTH-8{1'b0}};
                  dc_wrBanks_reg3[k]<=32'b0;
                  dc_odd_wr_reg3[k]<=1'b0;
                  dc_split_wr_reg3[k]<=1'b0;
                  dc_wrBegin_reg3[k]<=5'd0;
                  dc_wrEnd_reg3[k]<=5'd0;
                  dc_wrBGN_BNK_reg3[k]<=4'hf;
                  dc_wrEND_BNK_reg3[k]<=4'hf;
                  dc_wdata_reg3[k]<=dc_wdata_reg2[k];
              end
          end
      end else begin
          bus_holds_agu<=insert_isData;
          bus_holds_agu_reg<=bus_holds_agu;
          bus_holds_agu_reg2<=bus_holds_agu_reg;
          bus_holds_agu_reg3<=bus_holds_agu_reg2;
          bus_holds_agu_reg4<=bus_holds_agu_reg3;
          bus_holds_agu_reg5<=bus_holds_agu_reg4;
          miss_holds_agu_reg<=miss_holds_agu;
          miss_holds_agu_reg2<=miss_holds_agu_reg;
          miss_pause_agu_reg<=miss_pause_agu;
          miss_pause_agu_reg2<=miss_pause_agu_reg;
          insert_isData_reg<=insert_isData;
          insert_isData_reg2<=insert_isData_reg;
          insert_isData_reg3<=insert_isData_reg2;
          insert_isData_reg4<=insert_isData_reg3;
          insert_isData_reg5<=insert_isData_reg4;
          insert_isData_reg6<=insert_isData_reg5;
          insert_isData_reg7<=insert_isData_reg6;
          insert_isData_reg8<=insert_isData_reg7;
          insBus_exclusive_reg<=insBus_exclusive;
          insBus_exclusive_reg2<=insBus_exclusive_reg;
          insBus_exclusive_reg3<=insBus_exclusive_reg2;
          insBus_dirty_reg<=insBus_dirty;
          insBus_dirty_reg2<=insBus_dirty_reg;
          insBus_dirty_reg3<=insBus_dirty_reg2;
          insBus_data_reg<=insBus_data;
          insBus_data_reg2<=insBus_data_reg;
          insert_addr_reg<=insert_addr;
          insert_addr_reg2<=insert_addr_reg;
          insert_addr_reg3<=insert_addr_reg2;
          insBus_req_reg<=insBus_req;
          if (except&&excpt_thread==dc_thr[0]) dc_rdEn_reg[0]<=1'b0;
          else dc_rdEn_reg[0]<=dc_rdEn[0];
          if (except&&excpt_thread==dc_thr[1]) dc_rdEn_reg[1]<=1'b0;
          else dc_rdEn_reg[1]<=dc_rdEn[1];
          if (except&&excpt_thread==dc_thr[2]) dc_rdEn_reg[2]<=1'b0;
          else dc_rdEn_reg[2]<=dc_rdEn[2];
          if (except&&excpt_thread==dc_thr[3]) dc_rdEn_reg[3]<=1'b0;
          else dc_rdEn_reg[3]<=dc_rdEn[3];

          if (except&&excpt_thread==dc_thr_reg[0]) dc_rdEn_reg2[0]<=1'b0;
          else dc_rdEn_reg2[0]<=dc_rdEn_reg[0];
          if (except&&excpt_thread==dc_thr_reg[1]) dc_rdEn_reg2[1]<=1'b0;
          else dc_rdEn_reg2[1]<=dc_rdEn_reg[1];
          if (except&&excpt_thread==dc_thr_reg[2]) dc_rdEn_reg2[2]<=1'b0;
          else dc_rdEn_reg2[2]<=dc_rdEn_reg[2];
          if (except&&excpt_thread==dc_thr_reg[3]) dc_rdEn_reg2[3]<=1'b0;
          else dc_rdEn_reg2[3]<=dc_rdEn_reg[3];
          
          if (except&&excpt_thread==dc_thr_reg2[0]) dc_rdEn_reg3[0]<=1'b0;
          else dc_rdEn_reg3[0]<=dc_rdEn_reg2[0];
          if (except&&excpt_thread==dc_thr_reg2[1]) dc_rdEn_reg3[1]<=1'b0;
          else dc_rdEn_reg3[1]<=dc_rdEn_reg2[1];
          if (except&&excpt_thread==dc_thr_reg2[2]) dc_rdEn_reg3[2]<=1'b0;
          else dc_rdEn_reg3[2]<=dc_rdEn_reg2[2];
          if (except&&excpt_thread==dc_thr_reg2[3]) dc_rdEn_reg3[3]<=1'b0;
          else dc_rdEn_reg3[3]<=dc_rdEn_reg2[3];
        
          dc_tlb_miss_reg<=dc_tlb_miss;
          reqBus_en<=mcam_do_req;
          reqBus_req<={BUS_ID,mcam_req};
          reqBus_addr<=mcam_addr_reg;
          reqBus_want_excl<=mcam_st_reg;
          reqBus_dupl<=mcam_cldupl_reg;
	  reqBus_sz<=mcam_sz_reg;
	  reqBus_low<=mcam_low_reg;
	  reqBus_bank0<=mcam_bank0_reg;
	  reqBus_io<=mcam_io_reg;
//          insBus_en<=dc2_rhitA0 | dc2_rhitB0 | dc2_rhitB1;
//          insBus_req<=dc2_req_rd_reg4;
//          insBus_data<=dc2_rdata;
          dc_confl_reg<=dc_confl;
          dc_confl_reg2<=dc_confl_reg;
          miss_unlock_reg<=miss_unlock;
          dc_wrEn_reg<=dc_wrEn;
          dc_wrEn_reg2<=dc_wrEn_reg;
          dc_wrEn_reg3<=dc_wrEn_reg2;
          wrStall_reg<=wrStall;
          for(k=0;k<4;k=k+1) begin
              dc_rdReg_reg[k]<=dc_rdReg[k];
              dc_rdReg_reg2[k]<=dc_rdReg_reg[k];
              dc_rdReg_reg3[k]<=dc_rdReg_reg2[k];
              if (k<2) begin
                  dc_II_wr_reg[k]<=dc_II_wr[k];
                  dc_II_wr_reg2[k]<=dc_II_wr_reg[k];
                  dc_II_wr_reg3[k]<=dc_II_wr_reg2[k];
                  dc_wrAddrE_reg[k]<=dc_wrAddrE[k];
                  dc_wrAddrO_reg[k]<=dc_wrAddrO[k];
                  dc_wrBanks_reg[k]<=dc_wrBanks[k];
                  dc_odd_wr_reg[k]<=dc_odd_wr[k];
                  dc_split_wr_reg[k]<=dc_split_wr[k];
                  dc_wrBegin_reg[k]<=dc_wrBegin[k];
                  dc_wrEnd_reg[k]<=dc_wrEnd[k];
                  dc_wrBGN_BNK_reg[k]<=dc_wrBGN_BNK[k];
                  dc_wrEND_BNK_reg[k]<=dc_wrEND_BNK[k];
                  dc_wrAddrE_reg2[k]<=dc_wrAddrE_reg[k];
                  dc_wrAddrO_reg2[k]<=dc_wrAddrO_reg[k];
                  dc_wrBanks_reg2[k]<=dc_wrBanks_reg[k];
                  dc_odd_wr_reg2[k]<=dc_odd_wr_reg[k];
                  dc_split_wr_reg2[k]<=dc_split_wr_reg[k];
                  dc_wrBegin_reg2[k]<=dc_wrBegin_reg[k];
                  dc_wrEnd_reg2[k]<=dc_wrEnd_reg[k];
                  dc_wrBGN_BNK_reg2[k]<=dc_wrBGN_BNK_reg[k];
                  dc_wrEND_BNK_reg2[k]<=dc_wrEND_BNK_reg[k];
                  dc_wrAddrE_reg3[k]<=dc_wrAddrE_reg2[k];
                  dc_wrAddrO_reg3[k]<=dc_wrAddrO_reg2[k];
                  dc_wrBanks_reg3[k]<=dc_wrBanks_reg2[k];
                  dc_odd_wr_reg3[k]<=dc_odd_wr_reg2[k];
                  dc_split_wr_reg3[k]<=dc_split_wr_reg2[k];
                  dc_wrBegin_reg3[k]<=dc_wrBegin_reg2[k];
                  dc_wrEnd_reg3[k]<=dc_wrEnd_reg2[k];
                  dc_wrBGN_BNK_reg3[k]<=dc_wrBGN_BNK_reg2[k];
                  dc_wrEND_BNK_reg3[k]<=dc_wrEND_BNK_reg2[k];
              end
          end
      end
      if (rst) begin
          rec_addr_reg<=64'b0;
          rec_register_reg<={REG_WIDTH{1'B0}};
          rec_tlb_miss_reg<=1'b0;
      end else if (~rec_stall) begin
          rec_addr_reg<=rec_addr;
          rec_register_reg<=rec_register;
          rec_tlb_miss_reg<=rec_tlb_miss;
      end
      
      if (rst) begin
	  for (f=0;f<10;f=f+1) begin
              FU_reg[f]<={DATA_WIDTH{1'B0}};
              FU_reg2[f]<={DATA_WIDTH{1'B0}};
              FUreg_reg[f]<={REG_WIDTH{1'B0}};
              FUwen_reg[f]<=1'b0;
              FUreg_reg2[f]<={REG_WIDTH{1'B0}};
              FUwen_reg2[f]<=1'b0;
              FUreg_reg3[f]<={REG_WIDTH{1'B0}};
              FUwen_reg3[f]<=1'b0;
              FUreg_reg4[f]<={REG_WIDTH{1'B0}};
              FUwen_reg4[f]<=1'b0;
              FUreg_reg5[f]<={REG_WIDTH{1'B0}};
              FUwen_reg5[f]<=1'b0;
              FUreg_reg6[f]<={REG_WIDTH{1'B0}};
              FUwen_reg6[f]<=1'b0;
              FUreg_reg7[f]<={REG_WIDTH{1'B0}};
              FUwen_reg7[f]<=1'b0;
	      FUVH_reg[f]<={SIMD_WIDTH{1'B0}};
	      FUVL_reg[f]<={SIMD_WIDTH{1'B0}};
	      FUFH_reg[f]<={SIMD_WIDTH{1'B0}};
	      FUFL_reg[f]<={16+SIMD_WIDTH{1'B0}};
	//      FUFUH_reg[f]<={SIMD_WIDTH{1'B0}};
	//      FUFUL_reg[f]<={SIMD_WIDTH{1'B0}};
	      FUVH_reg2[f]<={SIMD_WIDTH{1'B0}};
	      FUVL_reg2[f]<={SIMD_WIDTH{1'B0}};
	      FUFH_reg2[f]<={SIMD_WIDTH{1'B0}};
	      FUFL_reg2[f]<={16+SIMD_WIDTH{1'B0}};
	//      FUFUH_reg2[f]<={SIMD_WIDTH{1'B0}};
	//      FUFUL_reg2[f]<={SIMD_WIDTH{1'B0}};
	      if (f<=8) begin
		  fuFwdA_reg[f]<=4'hf;
		  fuFwdB_reg[f]<=4'hf;
		  fuuFwdA_reg[f]<=4'hf;
		  fuuFwdB_reg[f]<=4'hf;
		  fuFwdA_reg2[f]<=4'hf;
		  fuFwdB_reg2[f]<=4'hf;
		  fuuFwdA_reg2[f]<=4'hf;
		  fuuFwdB_reg2[f]<=4'hf;
	      end
              if (f<=2) begin
		  fuFwdAH_reg[f]<=4'hf;
		  fuFwdBH_reg[f]<=4'hf;
		  fuuFwdAH_reg[f]<=4'hf;
		  fuuFwdBH_reg[f]<=4'hf;
              end
          end
          FUS1_reg<=6'B0;
          FUS2_reg<=6'B0;
          FUS3_reg<=6'B0;
          FUS4_reg<=6'B0;
          FUS5_reg<=6'B0;
          FUS6_reg<=6'B0;
          FUS7_reg<=6'B0;
          FUS8_reg<=6'B0;
          FUS9_reg<=6'B0;
          FUwen0<=1'b0;
          FUwen1<=1'b0;
          FUwen2<=1'b0;
          FUwen3<=1'b0;
          FU0Hit_reg<=1'b0;
          FU1Hit_reg<=1'b0;
          FU2Hit_reg<=1'b0;
          FU3Hit_reg<=1'b0;
          FU0Hit_reg2<=1'b0;
          FU1Hit_reg2<=1'b0;
          FU2Hit_reg2<=1'b0;
          FU3Hit_reg2<=1'b0;
      end else begin
	  for (f=0;f<10;f=f+1) begin
              FU_reg[f]<=FU[f];
              FU_reg2[f]<=FU_reg[f];
              if (FUwen[f]) FUreg_reg[f]<=FUreg[f];
              FUwen_reg[f]<=FUwen[f];
              FUreg_reg2[f]<=FUreg_reg[f];
              FUwen_reg2[f]<=FUwen_reg[f];
              FUreg_reg3[f]<=FUreg_reg2[f];
              FUwen_reg3[f]<=FUwen_reg2[f];
              FUreg_reg4[f]<=FUreg_reg3[f];
              FUwen_reg4[f]<=FUwen_reg3[f];
              FUreg_reg5[f]<=FUreg_reg4[f];
              FUwen_reg5[f]<=FUwen_reg4[f];
              FUreg_reg6[f]<=FUreg_reg5[f];
              FUwen_reg6[f]<=FUwen_reg5[f];
              FUreg_reg7[f]<=FUreg_reg6[f];
              FUwen_reg7[f]<=FUwen_reg6[f];
	      FUVH_reg[f]<=FUVH[f];
	      FUVL_reg[f]<=FUVL[f];
	      FUFH_reg[f]<=FUFH[f];
	      FUFL_reg[f]<=FUFL[f];
	  //    FUFUH_reg[f]<=FUFUH[f];
	  //    FUFUL_reg[f]<=FUFUL[f];
	      FUVH_reg2[f]<=FUVH_reg[f];
	      FUVL_reg2[f]<=FUVL_reg[f];
	      FUFH_reg2[f]<=FUFH_reg[f];
	      FUFL_reg2[f]<=FUFL_reg[f];
	 //     FUFUH_reg2[f]<=FUFUH_reg[f];
	 //     FUFUL_reg2[f]<=FUFUL_reg[f];
	      if (f<=8) begin
		  fuFwdA_reg[f]<=fuFwdA[f];
		  fuFwdB_reg[f]<=fuFwdB[f];
		  fuuFwdA_reg[f]<=fuuFwdA[f];
		  fuuFwdB_reg[f]<=fuuFwdB[f];
		  fuFwdA_reg2[f]<=fuFwdA_reg[f];
		  fuFwdB_reg2[f]<=fuFwdB_reg[f];
		  fuuFwdA_reg2[f]<=fuuFwdA_reg[f];
		  fuuFwdB_reg2[f]<=fuuFwdB_reg[f];
	      end
              if (f<=2) begin
		  fuFwdAH_reg[f]<=fuFwdAH[f];
		  fuFwdBH_reg[f]<=fuFwdBH[f];
		  fuuFwdAH_reg[f]<=fuuFwdAH[f];
		  fuuFwdBH_reg[f]<=fuuFwdBH[f];
              end
          end
          FUS1_reg<=FUS1;
          FUS2_reg<=FUS2;
          FUS3_reg<=FUS3;
          FUS4_reg<=FUS4;
          FUS5_reg<=FUS5;
          FUS6_reg<=FUS6;
          FUS7_reg<=FUS7;
          FUS8_reg<=FUS8;
          FUS9_reg<=FUS9;
          if (except&&excpt_thread==dc_thr_reg[0]) FUwen0<=1'b0;
          else FUwen0<=dc_rdEn_reg[0] & ~dc_confl[0] & ~dc_lsflags_reg[0];
          if (except&&excpt_thread==dc_thr_reg[1]) FUwen1<=1'b0;
          else FUwen1<=dc_rdEn_reg[1] & ~dc_confl[1] & ~dc_lsflags_reg[1];
          if (except&&excpt_thread==dc_thr_reg[2]) FUwen2<=1'b0;
          else FUwen2<=dc_rdEn_reg[2] & ~dc_confl[2] & ~dc_lsflags_reg[2];
          if (except&&excpt_thread==dc_thr_reg[3]) FUwen3<=1'b0;
          else FUwen3<=dc_rdEn_reg[3] & ~dc_lsflags_reg[3];
          FU0Hit_reg<=FU0Hit;
          FU1Hit_reg<=FU1Hit;
          FU2Hit_reg<=FU2Hit;
          FU3Hit_reg<=FU3Hit;
          FU0Hit_reg2<=FU0Hit_reg;
          FU1Hit_reg2<=FU1Hit_reg;
          FU2Hit_reg2<=FU2Hit_reg;
          FU3Hit_reg2<=FU3Hit_reg;
      end
      if (rst|miss_next) begin
          miss_doneEven<=1'b0;
          miss_doneOdd<=1'b0;
      end else begin
          if (miss_clDo[0] && miss_en) miss_doneEven<=1'b1;
          if (miss_clDo==2'b10 && miss_en) miss_doneOdd<=1'b1;
      end
      if (rst) begin
          miss_en_reg<=1'b0;
        //  miss_en_reg2<=1'b0;
          miss_st_reg<=1'b0;
          mcam_addr_reg<={PADDR_WIDTH-7{1'B0}};
          mcam_cldupl_reg<=2'b0;
          mcam_st_reg<=1'b0;
	  mcam_sz_reg<=5'b0;
	  mcam_low_reg<=2'b0;
	  mcam_bank0_reg<=5'd0;
	  mcam_io_reg<=1'b0;
//          miss_next_reg<=1'b0;
      end else begin
          miss_en_reg<=miss_en;
        //  miss_en_reg2<=miss_en_reg;
          miss_st_reg<=miss_st;
          mcam_addr_reg<=mcam_addr;
          mcam_cldupl_reg<=mcam_cldupl;
          mcam_st_reg<=mcam_st;
	  mcam_sz_reg<=mcam_sz;
	  mcam_low_reg<=mcam_low;
	  mcam_bank0_reg<=mcam_bank0;
	  mcam_io_reg<=mcam_io;
//          miss_next_reg<=miss_next;
      end
      if (rst) begin
          proc0<=16'b0;
          proc1<=16'b0;
      end

      if (rst) begin
	  gxFADD_en=3'b0;
	  gxFADD_hi=3'b0;
	  gxFADD_ord=3'b0;
	  gxFADD_dbl=3'b111;
	  gxFADD_ext=3'b0;
	  gxFADD_sn=3'b0;
	  gxFADD_sin=3'b0;
	  gxFADD_pkdS<=3'b0;
	  gxFADD_pkdD<=3'b0;
	  gxFADD_en_reg<=3'b0;
	  gxFADD_en_reg2<=3'b0;
	  FOOS_reg[0]<=6'b0;
	  FOOS_reg[1]<=6'b0;
	  FOOS_reg[2]<=6'b0;
	  FOOS_reg2[0]<=6'b0;
	  FOOS_reg2[1]<=6'b0;
	  FOOS_reg2[2]<=6'b0;
	  nDataAlt_reg[0]<=3'b111;
	  nDataAlt_reg[1]<=3'b111;
	  nDataAlt_reg[2]<=3'b111;
	  nDataAlt_reg2[0]<=3'b111;
	  nDataAlt_reg2[1]<=3'b111;
	  nDataAlt_reg2[2]<=3'b111;
	  nDataAlt_reg3[0]<=3'b111;
	  nDataAlt_reg3[1]<=3'b111;
	  nDataAlt_reg3[2]<=3'b111;
	  nDataAlt_reg4[0]<=3'b111;
	  nDataAlt_reg4[1]<=3'b111;
	  nDataAlt_reg4[2]<=3'b111;
	  nDataAlt_reg5[0]<=3'b111;
	  nDataAlt_reg5[1]<=3'b111;
	  nDataAlt_reg5[2]<=3'b111;
      end else for(k=0;k<3;k=k+1) begin

	  gxFADD_en[k]=outEn_reg2[3*k+1][0] && outEn_reg2[3*k+1][3] && outOp_reg2[3*k+1][7:0]==`fop_cmpDH || outOp_reg2[3*k+1][7:0]==`fop_cmpDL || outOp_reg2[3*k+1][7:0]==`fop_cmpE || outOp_reg2[3*k+1][7:0]==`fop_cmpS;
	  gxFADD_ord[k]=outOp_reg2[3*k+1][10];
	  gxFADD_hi[k]=outOp_reg2[3*k+1][7:0]==`fop_cmpDH;
	  gxFADD_ext[k]=outOp_reg2[3*k+1][7:0]==`fop_cmpE;
	  gxFADD_dbl[k]=outOp_reg2[3*k+1][7:0]==`fop_cmpDH || outOp_reg2[3*k+1][7:0]==`fop_cmpDL;
	  gxFADD_sn[k]=~gxFADD_ext[k] & ~gxFADD_dbl[k];
	  gxFADD_sin[k]=~gxFADD_dbl[k]; 
	  gxFADD_pkdS[k]<={outOp_reg2[3*k+1][7:2],2'b0}==`fop_pcmplt && outOp_reg2[3*k+1][10];
	  gxFADD_pkdD[k]<={outOp_reg2[3*k+1][7:2],2'b0}==`fop_pcmplt && ~outOp_reg2[3*k+1][10];
	  gxFADD_en_reg[k]<=gxFADD_en[k];
	  gxFADD_en_reg2[k]<=gxFADD_en_reg[k];
	  FOOS_reg[k]<=FOOS[k];
	  FOOS_reg2[k]<=FOOS_reg[k];
	  nDataAlt_reg[k]<=nDataAlt[k];
	  nDataAlt_reg2[k]<=nDataAlt_reg[k];
	  nDataAlt_reg3[k]<=nDataAlt_reg2[k];
	  nDataAlt_reg4[k]<=nDataAlt_reg3[k];
	  nDataAlt_reg5[k]<=nDataAlt_reg4[k];
      end
      if (rst) begin
          wt_pause_agu_reg<=1'b0;
          wt_pause_agu_reg2<=1'b0;
	  dc_lsfwd3_reg<=1'b0;
	  dc_lsfwd3_reg2<=1'b0;
	  dc_lsfwd3_reg3<=1'b0;
	  dc_lsfwd3_reg4<=1'b0;
	  dc_bread3_reg<=4'b0;
	  dc_bread3_reg2<=4'b0;
	  dc_bread3_reg3<=4'b0;
	  dc_bread3_reg4<=4'b0;
	  dc_data3_reg<=128'b0;
	  dc_data3_reg2<=128'b0;
	  dc_data3_reg3<=128'b0;
	  dc_data3_reg4<=128'b0;
          for(v=0;v<=3;v=v+1) begin
              dc_rdAddrE_reg[v]<={PADDR_WIDTH-8{1'B0}};
              dc_rdAddrO_reg[v]<={PADDR_WIDTH-8{1'b0}};
              dc_rdAddrE_chk[v]<={PADDR_WIDTH-8{1'B0}};
              dc_rdAddrO_chk[v]<={PADDR_WIDTH-8{1'b0}};
              dc_rdBanks_reg[v]<=32'b0;
              dc_rdRsBanks_reg[v]<=32'b0;
              dc_rsEn_reg[v]<=1'b0;
              dc_odd_reg[v]<=1'b0;
              dc_split_reg[v]<=1'b0;
              dc_rdBeginA_reg[v]<=5'b0;
              dc_low_reg[v]<=2'b0;
              dc_size_reg[v]<=5'b0;
              dc_size_reg2[v]<=5'b0;
              dc_size_reg3[v]<=5'b0;
              dc_st_reg[v]<=1'b0;
	      dc_LSQ_reg[v]<=9'b0;
	      dc_II_reg[v]<=10'b0;
	      dc_II_reg2[v]<=10'b0;
	      dc_II_reg3[v]<=10'b0;
	      dc_WQ_reg[v]<=8'b0;
	      dc_lsflags_reg[v]<=1'b0;
	      dc_lsflags_reg2[v]<=1'b0;
	      dc_lsflags_reg3[v]<=1'b0;
	      dc_type_reg[v]<=2'b0;
	      dc_type_reg2[v]<=2'b0;
	      dc_type_reg3[v]<=2'b0;
	      dc_thr_reg[v]<=1'b0;
	      dc_thr_reg2[v]<=1'b0;
	      dc_rdataA_reg[v]<=128'b0;
          end
          for(v=0;v<=1;v=v+1) begin
              Wq_wrAddrE_reg[v]<={PADDR_WIDTH-8{1'B0}};
              Wq_wrAddrO_reg[v]<={PADDR_WIDTH-8{1'b0}};
              Wq_wrBanks_reg[v]<=32'b0;
              Wq_wrEn_reg[v]<=1'b0;
              Wq_odd_reg[v]<=1'b0;
              Wq_split_reg[v]<=1'b0;
              Wq_wrBeginA_reg[v]<=5'b0;
//              Wq_wrBeginB_reg[v]<=5'b0;
              Wq_low_reg[v]<=2'b0;
              Wq_size_reg[v]<=5'b0;
	      Wq_LSQ_reg[v]<=9'b0;
	      Wq_type_reg[v]<=2'b0;
	      Wq_II_reg[v]<=10'b0;
	      Wq_WQ_reg[v]<=8'b0;
              Wq_thr_reg[v]<=1'b0;
//              Wq_st_reg[v]<=1'b0;
             WfxDataA_reg[v]<={DATA_WIDTH{1'B0}};
             WfxDataB_reg[v]<={DATA_WIDTH{1'B0}};
             WfxDataC_reg[v]<={CONST_WIDTH{1'B0}};
             WfxOp_reg[v]<={OPERATION_WIDTH{1'B0}};
             WfxII_reg[v]<=10'b0;
             WfxWQ_reg[v]<=8'b0;
             WfxLSQ_reg[v]<=9'b0;
             WfxDataEn_reg[v]<=4'b0;
             WfxThread_reg[v]<=1'b0;
             WfxShiftSize_reg[v]<=4'b0;
             WDfxWQ_reg[v]<=8'b0;
             WDfxWQ_reg2[v]<=8'b0;
             WDfxWQ_reg3[v]<=8'b0;
             WDfxWQ_reg4[v]<=8'b0;
             WDfxII_reg[v]<=10'b0;
             WDfxII_reg2[v]<=10'b0;
             WDfxII_reg3[v]<=10'b0;
             WDfxDataEn_reg[v]<=4'b0;
             WDfxDataEn_reg2[v]<=4'b0;
             WDfxDataEn_reg3[v]<=4'b0;
             WDfxDataEn_reg4[v]<=4'b0;
             WDfxData_reg[v]<={DATA_WIDTH{1'B0}};
             WDfxData_reg2[v]<={DATA_WIDTH{1'B0}};
             WDfxData_reg3[v]<={DATA_WIDTH{1'B0}};
             WDoutFuFwd_reg[v]<=4'hf;
             WDoutFuFwd_reg2[v]<=4'hf;
             WDoutFuuFwd_reg[v]<=4'hf;
             WDoutFuuFwd_reg2[v]<=4'hf;
             WDoutDataEn_reg[v]<=4'b0;
             WDoutDataEn_reg2[v]<=4'b0;
	     WDoutOp_reg[v]<=13'b0;
	     WDoutOp_reg2[v]<=13'b0;
	     WDoutOp_reg3[v]<=13'b0;
             wreq_data_reg[v]<={`lsaddr_width{1'b0}};
       //      wreq_xdata_reg[v]<=48'b0;
             wreq_en_reg[v]<=1'b0;
             dc_wdataP_reg[v]<=128'b0;
     //        wreq_stall_reg<=1'b0;
             lsw_wdataF_reg[v]<=128'b0;
             lsw_wdataV_reg[v]<=128'b0;
             Wagu_blockRS_reg[v]<=1'b0;
          end
      end else begin
          wt_pause_agu_reg<=wt_pause_agu;
          wt_pause_agu_reg2<=wt_pause_agu_reg;
	  dc_lsfwd3_reg<=dc_lsfwd3;
	  dc_lsfwd3_reg2<=dc_lsfwd3_reg;
	  dc_lsfwd3_reg3<=dc_lsfwd3_reg2;
	  dc_lsfwd3_reg4<=dc_lsfwd3_reg3;
	      dc_bread3_reg<=dc_bread3;
	      dc_bread3_reg2<=dc_bread3_reg;
	      dc_bread3_reg3<=dc_bread3_reg2;
	      dc_bread3_reg4<=dc_bread3_reg3;
	      dc_data3_reg<=dc_data3;
	      dc_data3_reg2<=dc_data3_reg;
	      dc_data3_reg3<=dc_data3_reg2;
	      dc_data3_reg4<=dc_data3_reg3;
          for(v=0;v<=3;v=v+1) begin
              dc_rdAddrE_reg[v]<=dc_rdAddrE[v];
              dc_rdAddrO_reg[v]<=dc_rdAddrO[v];
              if (~dc_split[v] || ~dc_odd[v] || dc_st[v]) dc_rdAddrE_chk[v]<=dc_rdAddrE[v];
              if (~dc_split[v] || dc_odd[v] || dc_st[v])  dc_rdAddrO_chk[v]<=dc_rdAddrO[v];
              dc_rdBanks_reg[v]<=dc_rdBanks[v];
              dc_rdRsBanks_reg[v]<=dc_rdRsBanks[v];
              dc_rsEn_reg[v]<=dc_rsEn[v];
              dc_odd_reg[v]<=dc_odd[v];
              dc_split_reg[v]<=dc_split[v];
              dc_rdBeginA_reg[v]<=dc_rdBeginA[v];
              dc_low_reg[v]<=dc_low[v];
              dc_size_reg[v]<=dc_size[v];
              dc_size_reg2[v]<=dc_size_reg[v];
              dc_size_reg3[v]<=dc_size_reg2[v];
              dc_st_reg[v]<=dc_st[v];
	      dc_LSQ_reg[v]<=dc_LSQ[v];
	      dc_II_reg[v]<=dc_II[v];
	      dc_II_reg2[v]<=dc_II_reg[v];
	      dc_II_reg3[v]<=dc_II_reg2[v];
	      dc_WQ_reg[v]<=dc_WQ[v];
	      dc_lsflags_reg[v]<=dc_lsflags[v];
	      dc_lsflags_reg2[v]<=dc_lsflags_reg[v];
	      dc_lsflags_reg3[v]<=dc_lsflags_reg2[v];
	      dc_type_reg[v]<=dc_type[v];
	      dc_type_reg2[v]<=dc_type_reg[v];
	      dc_type_reg3[v]<=dc_type_reg2[v];
	      dc_thr_reg[v]<=dc_thr[v];
	      dc_thr_reg2[v]<=dc_thr_reg[v];
	      dc_rdataA_reg[v]<=dc_rdataA[v];
          end
          for(v=0;v<=1;v=v+1) begin
              Wq_wrAddrE_reg[v]<=Wq_wrAddrE[v];
              Wq_wrAddrO_reg[v]<=Wq_wrAddrO[v];
              Wq_wrBanks_reg[v]<=Wq_wrBanks[v];
              Wq_wrEn_reg[v]<=Wq_wrEn[v];
              Wq_odd_reg[v]<=Wq_odd[v];
              Wq_split_reg[v]<=Wq_split[v];
              Wq_wrBeginA_reg[v]<=Wq_wrBeginA[v];
//              Wq_wrBeginB_reg[v]<=Wq_wrBeginB[v];
              Wq_low_reg[v]<=Wq_low[v];
              Wq_size_reg[v]<=Wq_size[v];
	      Wq_LSQ_reg[v]<=Wq_LSQ[v];
	      Wq_type_reg[v]<=Wq_type[v];
	      Wq_II_reg[v]<=Wq_II[v];
	      Wq_WQ_reg[v]<=Wq_WQ[v];
              Wq_thr_reg[v]<=Wq_thr[v];
//              Wq_st_reg[v]<=Wq_st[v];
             WfxDataA_reg[v]<=WfxDataA[v];
             WfxDataB_reg[v]<=WfxDataB[v];
             WfxDataC_reg[v]<=WfxDataC[v];
             WfxOp_reg[v]<=WfxOp[v];
             WfxII_reg[v]<=WfxII[v];
             WfxWQ_reg[v]<=WfxWQ[v];
             WfxLSQ_reg[v]<=WfxLSQ[v];
             WfxDataEn_reg[v]<=WfxDataEn[v];
             WfxThread_reg[v]<=WfxThread[v];
             WfxShiftSize_reg[v]<=WfxShiftSize[v];
             WDfxWQ_reg[v]<=WDfxWQ[v];
             WDfxWQ_reg2[v]<=WDfxWQ_reg[v];
             WDfxWQ_reg3[v]<=WDfxWQ_reg2[v];
             WDfxWQ_reg4[v]<=WDfxWQ_reg3[v];
             WDfxII_reg[v]<=WDfxII[v];
             WDfxII_reg2[v]<=WDfxII_reg[v];
             WDfxII_reg3[v]<=WDfxII_reg2[v];
             WDfxDataEn_reg[v]<=WDfxDataEn[v];
             WDfxDataEn_reg2[v]<=WDfxDataEn_reg[v];
             WDfxDataEn_reg3[v]<=WDfxDataEn_reg2[v];
             WDfxDataEn_reg4[v]<=WDfxDataEn_reg3[v];
             WDfxData_reg[v]<=WDfxData[v];
             WDfxData_reg2[v]<=WDfxData_reg[v];
             WDfxData_reg3[v]<=WDfxData_reg2[v];
             WDoutFuFwd_reg[v]<=WDoutFuFwd[v];
             WDoutFuFwd_reg2[v]<=WDoutFuFwd_reg[v];
             WDoutFuuFwd_reg[v]<=WDoutFuuFwd[v];
             WDoutFuuFwd_reg2[v]<=WDoutFuuFwd_reg[v];
             WDoutDataEn_reg[v]<=WDoutDataEn[v];
             WDoutDataEn_reg2[v]<=WDoutDataEn_reg[v];
	     WDoutOp_reg[v]<=WDoutOp[v];
	     WDoutOp_reg2[v]<=WDoutOp_reg[v];
	     WDoutOp_reg3[v]<=WDoutOp_reg2[v];
             lsw_wdataF_reg[v]<=lsw_wdataF[v];
             lsw_wdataV_reg[v]<=lsw_wdataV[v];
             Wagu_blockRS_reg[v]<=Wagu_blockRS[v];
             if (!wreq_stall) begin
                 wreq_data_reg[v]<=wreq_data[v];
                 wreq_en_reg[v]<=wreq_en[v];
                 dc_wdataP_reg[v]<=dc_wdataP[v];
             end
          end
      end
      if (rst) begin
	  for(p=0;p<6;p=p+1) begin
	      ret_xdata_reg[p]<=0;
	      ret_xenab_reg[p]<=1'b0;
	      ret_xdata2[p]<=0;
	  end
      end else begin
	  for(p=0;p<6;p=p+1) begin
	      ret_xdata_reg[p]<=ret_xdata[p];
	      ret_xenab_reg[p]<=ret_xenab[p];
	      ret_xdata2[p][0]<=1'b0;
	      ret_xdata2[p][2:1]<=ret_xdata[p][`lsqxcept_xcept] ? 2'd1 : 2'd2;
	      ret_xdata2[p][8:3]<=ret_xdata[p][`lsqxcept_code];
	  end

      end
      if (rst) begin
	  retire0_rT_reg<=6'b0;
	  retire0_rF_reg<=9'b0;
	  retire0_enV_reg<=1'b0;
	  retire0_enF_reg<=1'b0;
	  retire1_rT_reg<=6'b0;
	  retire1_rF_reg<=9'b0;
	  retire1_enV_reg<=1'b0;
	  retire1_enF_reg<=1'b0;
	  retire2_rT_reg<=6'b0;
	  retire2_rF_reg<=9'b0;
	  retire2_enV_reg<=1'b0;
	  retire2_enF_reg<=1'b0;
	  retire3_rT_reg<=6'b0;
	  retire3_rF_reg<=9'b0;
	  retire3_enV_reg<=1'b0;
	  retire3_enF_reg<=1'b0;
	  retire4_rT_reg<=6'b0;
	  retire4_rF_reg<=9'b0;
	  retire4_enV_reg<=1'b0;
	  retire4_enF_reg<=1'b0;
	  retire5_rT_reg<=6'b0;
	  retire5_rF_reg<=9'b0;
	  retire5_enV_reg<=1'b0;
	  retire5_enF_reg<=1'b0;
	  retire6_rT_reg<=6'b0;
	  retire6_rF_reg<=9'b0;
	  retire6_enV_reg<=1'b0;
	  retire6_enF_reg<=1'b0;
	  retire7_rT_reg<=6'b0;
	  retire7_rF_reg<=9'b0;
	  retire7_enV_reg<=1'b0;
	  retire7_enF_reg<=1'b0;
	  retire8_rT_reg<=6'b0;
	  retire8_rF_reg<=9'b0;
	  retire8_enV_reg<=1'b0;
	  retire8_enF_reg<=1'b0;
	  
	  retire0_rT_reg2<=6'b0;
	  retire0_rF_reg2<=9'b0;
	  retire0_enF_reg2<=1'b0;
	  retire1_rT_reg2<=6'b0;
	  retire1_rF_reg2<=9'b0;
	  retire1_enF_reg2<=1'b0;
	  retire2_rT_reg2<=6'b0;
	  retire2_rF_reg2<=9'b0;
	  retire2_enF_reg2<=1'b0;
	  retire3_rT_reg2<=6'b0;
	  retire3_rF_reg2<=9'b0;
	  retire3_enF_reg2<=1'b0;
	  retire4_rT_reg2<=6'b0;
	  retire4_rF_reg2<=9'b0;
	  retire4_enF_reg2<=1'b0;
	  retire5_rT_reg2<=6'b0;
	  retire5_rF_reg2<=9'b0;
	  retire5_enF_reg2<=1'b0;
	  retire6_rT_reg2<=6'b0;
	  retire6_rF_reg2<=9'b0;
	  retire6_enF_reg2<=1'b0;
	  retire7_rT_reg2<=6'b0;
	  retire7_rF_reg2<=9'b0;
	  retire7_enF_reg2<=1'b0;
	  retire8_rT_reg2<=6'b0;
	  retire8_rF_reg2<=9'b0;
	  retire8_enF_reg2<=1'b0;
      end else begin
	  retire0_rT_reg<=retire0_rT;
	  retire0_rF_reg<=retire0_rF;
	  retire0_enV_reg<=retire0_enV;
	  retire0_enF_reg<=retire0_enF;
	  retire1_rT_reg<=retire1_rT;
	  retire1_rF_reg<=retire1_rF;
	  retire1_enV_reg<=retire1_enV;
	  retire1_enF_reg<=retire1_enF;
	  retire2_rT_reg<=retire2_rT;
	  retire2_rF_reg<=retire2_rF;
	  retire2_enV_reg<=retire2_enV;
	  retire2_enF_reg<=retire2_enF;
	  retire3_rT_reg<=retire3_rT;
	  retire3_rF_reg<=retire3_rF;
	  retire3_enV_reg<=retire3_enV;
	  retire3_enF_reg<=retire3_enF;
	  retire4_rT_reg<=retire4_rT;
	  retire4_rF_reg<=retire4_rF;
	  retire4_enV_reg<=retire4_enV;
	  retire4_enF_reg<=retire4_enF;
	  retire5_rT_reg<=retire5_rT;
	  retire5_rF_reg<=retire5_rF;
	  retire5_enV_reg<=retire5_enV;
	  retire5_enF_reg<=retire5_enF;
	  retire6_rT_reg<=retire6_rT;
	  retire6_rF_reg<=retire6_rF;
	  retire6_enV_reg<=retire6_enV;
	  retire6_enF_reg<=retire6_enF;
	  retire7_rT_reg<=retire7_rT;
	  retire7_rF_reg<=retire7_rF;
	  retire7_enV_reg<=retire7_enV;
	  retire7_enF_reg<=retire7_enF;
	  retire8_rT_reg<=retire8_rT;
	  retire8_rF_reg<=retire8_rF;
	  retire8_enV_reg<=retire8_enV;
	  retire8_enF_reg<=retire8_enF;
	  
	  retire0_rT_reg2<=retire0_rT_reg;
	  retire0_rF_reg2<=retire0_rF_reg;
	  retire0_enF_reg2<=retire0_enF_reg;
	  retire1_rT_reg2<=retire1_rT_reg;
	  retire1_rF_reg2<=retire1_rF_reg;
	  retire1_enF_reg2<=retire1_enF_reg;
	  retire2_rT_reg2<=retire2_rT_reg;
	  retire2_rF_reg2<=retire2_rF_reg;
	  retire2_enF_reg2<=retire2_enF_reg;
	  retire3_rT_reg2<=retire3_rT_reg;
	  retire3_rF_reg2<=retire3_rF_reg;
	  retire3_enF_reg2<=retire3_enF_reg;
	  retire4_rT_reg2<=retire4_rT_reg;
	  retire4_rF_reg2<=retire4_rF_reg;
	  retire4_enF_reg2<=retire4_enF_reg;
	  retire5_rT_reg2<=retire5_rT_reg;
	  retire5_rF_reg2<=retire5_rF_reg;
	  retire5_enF_reg2<=retire5_enF_reg;
	  retire6_rT_reg2<=retire6_rT_reg;
	  retire6_rF_reg2<=retire6_rF_reg;
	  retire6_enF_reg2<=retire6_enF_reg;
	  retire7_rT_reg2<=retire7_rT_reg;
	  retire7_rF_reg2<=retire7_rF_reg;
	  retire7_enF_reg2<=retire7_enF_reg;
	  retire8_rT_reg2<=retire8_rT_reg;
	  retire8_rF_reg2<=retire8_rF_reg;
	  retire8_enF_reg2<=retire8_enF_reg;
      end
      if (rst) begin
          lso_xdataA_reg<=0;
          lso_xdataB_reg<=0;
      end else begin
          lso_xdataA_reg<=lso_xdataA;
          lso_xdataB_reg<=lso_xdataB;
      end
  end
 
  always @(negedge clk) begin
    if (rst) begin
	  fxFADD_dbl=3'b111;
	  fxFADD_dblext=3'b111;
	  fxFADD_ext=3'b000;
	  fxFADD_sub=6'b000000;
	  fxFADD_rsub=3'b0;
	  fxFADD_copyA=6'b0;
	  fxFADD_com[0]<=2'b0;
	  fxFADD_com[1]<=2'b0;
	  fxFADD_com[2]<=2'b0;
	  fxFADD_dupl<=3'b0;
	  fxFCADD_dupl<=3'b0;
	  fxFADD_pswp<=3'b0;
	  fxFADD_pcmp<=3'b0;
	  fxFCADD_dbl=3'b111;
	  fxFCADD_dblext=3'b111;
	  fxFCADD_ext=3'b000;
	  fxFCADD_copyA=6'b0;
	  fxFCADD_com[0]<=2'b0;
	  fxFCADD_com[1]<=2'b0;
	  fxFCADD_com[2]<=2'b0;
	  fxFCADD_pswp<=3'b0;
	  fxFADD_sin=3'b0;
          fxFADD_copySA[0]=4'b0;
          fxFADD_copySA[1]=4'b0;
          fxFADD_copySA[2]=4'b0;
	  fxFCADD_sn=3'b0;
	  fxFCADD_copyASN[0]=4'b0;
	  fxFCADD_copyASN[1]=4'b0;
	  fxFCADD_copyASN[2]=4'b0;
	  fxFADD_lo=3'b0;
	  fxFADD_loSel[0]=4'b0;
	  fxFADD_loSel[1]=4'b0;
	  fxFADD_loSel[2]=4'b0;
	  fxFCADD_rndD<=3'b0;
	  fxFCADD_rndS<=3'b0;
          for (k=0;k<6;k=k+1) begin
	      fxDataAFH_reg[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAFL_reg[k]<={16+SIMD_WIDTH{1'B0}};
	      gxDataBFH_reg[k]<={SIMD_WIDTH{1'B0}};
	      gxDataBFL_reg[k]<={16+SIMD_WIDTH{1'B0}};
	      fxDataAFH_REG[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAFL_REG[k]<={16+SIMD_WIDTH{1'B0}};
	      fxDataAXH_reg[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAXL_reg[k]<={16+SIMD_WIDTH{1'B0}};
	      gxDataBXH_reg[k]<={SIMD_WIDTH{1'B0}};
	      gxDataBXL_reg[k]<={16+SIMD_WIDTH{1'B0}};
	  end
    end else begin
          for (k=0;k<3;k=k+1) begin
	      fxFADD_dbl[k]=outOp_reg3[3*k+1][7:0]==`fop_addDL ||
	        outOp_reg3[3*k+1][7:0]==`fop_addDH ||
	        outOp_reg3[3*k+1][7:0]==`fop_addDP ||
                outOp_reg3[3*k+1][7:0]==`fop_subDL ||
	        outOp_reg3[3*k+1][7:0]==`fop_subDH ||
                outOp_reg3[3*k+1][7:0]==`fop_subDP ||
                outOp_reg3[3*k+1][7:0]==`fop_addsubDP;
              fxFADD_ext[k]=outOp_reg3[3*k+1][7:0]==`fop_addEE ||
                outOp_reg3[3*k+1][7:0]==`fop_subEE;
              fxFADD_dblext[k]=fxFADD_dbl[k]||fxFADD_ext[k];
	      fxFADD_sub[2*k]=outOp_reg3[3*k+1][7:0]==`fop_subDL ||
	        outOp_reg3[3*k+1][7:0]==`fop_subDH ||
                outOp_reg3[3*k+1][7:0]==`fop_subDP ||
	        outOp_reg3[3*k+1][7:0]==`fop_subEE ||
		outOp_reg3[3*k+1][7:0]==`fop_subS ||
		outOp_reg3[3*k+1][7:0]==`fop_subSP;
	      fxFADD_sub[2*k+1]=fxFADD_sub[2*k] || 
		outOp_reg3[3*k+1][7:0]==`fop_addsubDP;
	      fxFADD_rsub[k]=fxFADD_sub[2*k+1] && outOp_reg3[3*k+1][12];
	      fxFADD_copyA[2*k+1]=outOp_reg3[3*k+1][7:0]==`fop_addDL ||
                outOp_reg3[3*k+1][7:0]==`fop_subDL;
	      fxFADD_copyA[2*k+0]=outOp_reg3[3*k+1][7:0]==`fop_addDH ||
                outOp_reg3[3*k+1][7:0]==`fop_subDH;
	      fxFADD_lo[k]={outOp_reg3[3*k+1][7:2],2'b0}==`fop_logic;
	      fxFADD_loSel[k]=outOp_reg3[3*k+1][1:0];
              fxFADD_pcmp[k]<=gxFADD_pkdS[k] | gxFADD_pkdD[k];
	      {fxFADD_pswp[k],fxFADD_com[k]}<=outOp_reg3[3*k+1][10:8];
	      {fxFCADD_pswp[k],fxFCADD_com[k]}<=outOp_reg3[3*k+2][10:8];
              fxFADD_dupl[k]<=outOp_reg3[3*k+1][12];
              fxFCADD_dupl[k]<=outOp_reg3[3*k+2][12];
	      
	      fxFCADD_dbl[k]=outOp_reg3[3*k+2][7:0]==`fop_mulDL ||
	        outOp_reg3[3*k+2][7:0]==`fop_mulDH ||
	        outOp_reg3[3*k+2][7:0]==`fop_mulDP || outOp_reg3[3*k+2][7:0]==`fop_rndDSP;
              fxFCADD_ext[k]=outOp_reg3[3*k+2][7:0]==`fop_mulEE || outOp_reg3[3*k+2][7:0]==`fop_rndES ||
	        outOp_reg3[3*k+2][7:0]==`fop_rndED;
              fxFCADD_dblext[k]=fxFCADD_dbl[k]||fxFCADD_ext[k];
	      fxFCADD_copyA[2*k+1]=outOp_reg3[3*k+2][7:0]==`fop_mulDL;
	      fxFCADD_copyA[2*k+0]=outOp_reg3[3*k+2][7:0]==`fop_mulDH;
	     
	      fxFCADD_rndD[k]=outOp_reg3[3*k+2][7:0]==`fop_rndED;
	      fxFCADD_rndS[k]=outOp_reg3[3*k+2][7:0]==`fop_rndES ||
	        outOp_reg3[3*k+2][7:0]==`fop_rndDSP;

	      fxFADD_sin[k]=outOp_reg3[3*k+1][7:0]==`fop_addS || outOp_reg3[3*k+1][7:0]==`fop_addSP ||
                  outOp_reg3[3*k+1][7:0]==`fop_subS || outOp_reg3[3*k+1][7:0]==`fop_subSP ||
		  {outOp_reg3[3*k+1][7:2],2'b0}==`fop_logic;
              fxFADD_copySA[k]=(outOp_reg3[3*k+1]==`fop_addSP || outOp_reg3[3*k+1][7:0]==`fop_subSP ||
	          {outOp_reg3[3*k+1][7:2],2'b0}==`fop_logic) ?
		  {outOp_reg3[3*k+1][10],3'b0}:{2'b11,outOp_reg3[3*k+1][10],1'b0}; 
	      fxFCADD_sn[k]=outOp_reg3[3*k+1][7:0]==`fop_mulS || outOp_reg3[3*k+1][7:0]==`fop_mulSP;
              fxFCADD_copyASN[k]=(outOp_reg3[3*k+1]==`fop_mulSP) ?
		  {outOp_reg3[3*k+2][10],3'b0}:{2'b11,outOp_reg3[3*k+2][10],1'b0}; 
	      if (fxFADD_dblext[k]) begin
		  if (~fxFADD_copyA[2*k+1]) fxDataAFH_reg[2*k+0]<=fxDataAFH[2*k+0];
	          if (~fxFADD_copyA[2*k+0]) fxDataAFL_reg[2*k+0]<=fxDataAFL[2*k+0];
	          if (~fxFADD_copyA[2*k+1]) gxDataBFH_reg[2*k+1]<=gxDataBFH[2*k+1];
	          if (~fxFADD_copyA[2*k+0]) gxDataBFL_reg[2*k+1]<=gxDataBFL[2*k+1];
		  fxDataAFH_REG[2*k+0]<=fxDataAFH[2*k+0];
	          fxDataAFL_REG[2*k+0]<=fxDataAFL[2*k+0];
	      end
	      if (fxFCADD_dblext[k]) begin
		  if (~fxFCADD_copyA[2*k+1]) fxDataAFH_reg[2*k+1]<=fxDataAFH[2*k+1];
	          if (~fxFCADD_copyA[2*k+0]) fxDataAFL_reg[2*k+1]<=fxDataAFL[2*k+1];
	          if (~fxFCADD_copyA[2*k+1]) gxDataBFH_reg[2*k+0]<=gxDataBFH[2*k+0];
	          if (~fxFCADD_copyA[2*k+0]) gxDataBFL_reg[2*k+0]<=gxDataBFL[2*k+0];
		  fxDataAFH_REG[2*k+1]<=fxDataAFH[2*k+1];
	          fxDataAFL_REG[2*k+1]<=fxDataAFL[2*k+1];
	      end
	      if (~fxFADD_dblext[k]) begin
		  fxDataAXH_reg[2*k+0]<=fxDataAFH[2*k+0];
	          fxDataAXL_reg[2*k+0]<=fxDataAFL[2*k+0];
	          gxDataBXH_reg[2*k+1]<=gxDataBFH[2*k+1];
	          gxDataBXL_reg[2*k+1]<=gxDataBFL[2*k+1];
	      end
	      if (~fxFCADD_dblext[k]) begin
		  fxDataAXH_reg[2*k+1]<=fxDataAFH[2*k+1];
	          fxDataAXL_reg[2*k+1]<=fxDataAFL[2*k+1];
	          gxDataBXH_reg[2*k+0]<=gxDataBFH[2*k+0];
	          gxDataBXL_reg[2*k+0]<=gxDataBFL[2*k+0];
	      end
          end
    end
    for(k1=0;k1<6;k1=k1+1) begin
        FOOFL_reg[k1]<=FOOFL[k1];
        FOOFH_reg[k1]<=FOOFH[k1];
        fxFCADD_raise_reg[k1]<=fxFCADD_raise[k1];
    end
  end 
endmodule


