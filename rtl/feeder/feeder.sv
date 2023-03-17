`include "../struct.sv"

module ww(
  clk,
  rst,
  except,
  exceptIP,
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
  bus_data,
  bus_slot,
  bus_en,
  req_addr,
  req_slot,
  req_en,
  req_tlbEn,
  req_tlbAttr,
  bus_tlb_data,
  bus_tlb_slot,
  bus_tlb_en,
  csrss_en,csrss_no,csrss_data,
  MSI_expAddr_reg,
  MSI_expAddr_en_reg,
  MSI_expAddr_hitCC,
  //dec_attr
  expun_fr_addr,
  expun_fr_en
  halt,
  
  all_retired,
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
  wrt0,wrt1,wrt2
  );
/*verilator hier_block*/
  localparam OPERATION_WIDTH=`operation_width+5;
  localparam RRF_WIDTH=6;
  localparam IN_REG_WIDTH=6;
  localparam PORT_WIDTH=4;
  localparam PORT_DEC_WIDTH=3;
  localparam INSTR_WIDTH=80;
  localparam INSTRQ_WIDTH=`instrQ_width;
  localparam REG_WIDTH=6;
  localparam PHYS_WIDTH=44;
  localparam VIRT_WIDTH=64;
  localparam IP_WIDTH=64;
  localparam [63:0] INIT_IP=64'hf80ff00000000000;
  localparam [3:0] INIT_ATTR=4'b0;
  localparam BUS_BANK=32;
  localparam BUS_WIDTH=BUS_BANK*16;
  localparam CLS_WIDTH=13;
  parameter [4:0] BUS_ID=0;
  input clk;
  input rst;
  input except;
  input [VIRT_WIDTH-1:0] exceptIP;
  input exceptThread;
  input [3:0] exceptAttr;
  input except_due_jump;
  input [7:0] except_ght;
  input except_flag;
  input [3:0] except_jmask;
  input except_jmask_en;
  input jupd0_en;
  input jupdt0_en;
  input jupd0_ght_en;
  input [15:0] jupd0_addr;
  input [12:0] jupd0_baddr;
  input [1:0] jupd0_sc;
  input jupd0_tk;
  input jupd1_en;
  input jupdt1_en;
  input jupd1_ght_en;
  input [15:0] jupd1_addr;
  input [12:0] jupd1_baddr;
  input [1:0] jupd1_sc;
  input jupd1_tk;



  input [BUS_WIDTH-1:0] bus_data;
  input [9:0] bus_slot;
  input bus_en;
  
  output [37:0] req_addr;
  output [9:0] req_slot;
  output req_en;
  output req_tlbEn;
  output [3:0] req_tlbAttr;

  input [`ctlbData_width-1:0] bus_tlb_data;
  input [9:0] bus_tlb_slot;
  input bus_tlb_en;
  output halt;

  input all_retired;
  input fp_excpt_en;
  input [10:0] fp_excpt_set;

  output bundleFeed;
  

  output [IN_REG_WIDTH-1:0] rs0i0_rA;
  output rs0i0_rA_use;
  output rs0i0_rA_useF;
  output rs0i0_rA_isV;
  output rs0i0_rA_isAnyV;
  output [IN_REG_WIDTH-1:0] rs0i0_rB;
  output rs0i0_rB_use;
  output rs0i0_rB_useF;
  output rs0i0_rB_isV;
  output rs0i0_rB_isAnyV;
  output rs0i0_useBConst;
  output [IN_REG_WIDTH-1:0] rs0i0_rT;
  output rs0i0_rT_use;
  output rs0i0_rT_useF;
  output rs0i0_rT_isV;
  output [PORT_WIDTH-1:0] rs0i0_port;
  output [OPERATION_WIDTH-1:0] rs0i0_operation;
  output rs0i0_en;
  output [DATA_WIDTH-1:0] rs0i0_const;
  output [3:0] rs0i0_index;
  output rs0i0_IPRel;
  output rs0i0_afterTaken;
  output rs0i0_alt;
  output rs0i0_alloc;
  output rs0i0_allocF;
  output rs0i0_allocR;
  output [5:0]  rs0i0_lsi;
  output rs0i0_ldst_flag;
  output rs0i0_enA;
  output rs0i0_enB;

  output [IN_REG_WIDTH-1:0] rs0i1_rA;
  output rs0i1_rA_use;
  output rs0i1_rA_useF;
  output rs0i1_rA_isV;
  output rs0i1_rA_isAnyV;
  output rs0i1_useAConst;
  output [IN_REG_WIDTH-1:0] rs0i1_rB;
  output rs0i1_rB_use;
  output rs0i1_rB_useF;
  output rs0i1_rB_isV;
  output rs0i1_rB_isAnyV;
  output rs0i1_useBConst;
  output [IN_REG_WIDTH-1:0] rs0i1_rT;
  output rs0i1_rT_use;
  output rs0i1_rT_useF;
  output rs0i1_rT_isV;
  output [PORT_WIDTH-1:0] rs0i1_port;
  output [OPERATION_WIDTH-1:0] rs0i1_operation;
  output rs0i1_en;
  output [DATA_WIDTH-1:0] rs0i1_const;
  output [3:0] rs0i1_index;
  output rs0i1_IPRel;
  output rs0i1_afterTaken;
  output rs0i1_alloc;
  output rs0i1_allocF;
  output rs0i1_allocR;
  output [3:0] rs0i1_flagDep;
  output rs0i1_lastFl;
  output [5:0]  rs0i1_lsi;
  output rs0i1_ldst_flag;
  output rs0i1_flag_wr;
  
  output [IN_REG_WIDTH-1:0] rs0i2_rA;
  output rs0i2_rA_use;
  output rs0i2_rA_useF;
  output rs0i2_rA_isV;
  output rs0i2_rA_isAnyV;
  output rs0i2_useAConst;
  output [IN_REG_WIDTH-1:0] rs0i2_rB;
  output rs0i2_rB_use;
  output rs0i2_rB_useF;
  output rs0i2_rB_isV;
  output rs0i2_rB_isAnyV;
  output rs0i2_useBConst;
  output [IN_REG_WIDTH-1:0] rs0i2_rT;
  output rs0i2_rT_use;
  output rs0i2_rT_useF;
  output rs0i2_rT_isV;
  output [PORT_WIDTH-1:0] rs0i2_port;
  output [OPERATION_WIDTH-1:0] rs0i2_operation;
  output rs0i2_en;
  output [DATA_WIDTH-1:0] rs0i2_const;
  output [3:0] rs0i2_index;
  output rs0i2_IPRel;
  output rs0i2_afterTaken;
  output rs0i2_alloc;
  output rs0i2_allocF;
  output rs0i2_allocR;
  output [3:0] rs0i2_flagDep;
  output rs0i2_lastFl;
  output rs0i2_flag_wr;
  
  output [IN_REG_WIDTH-1:0] rs1i0_rA;
  output rs1i0_rA_use;
  output rs1i0_rA_useF;
  output rs1i0_rA_isV;
  output rs1i0_rA_isAnyV;
  output [IN_REG_WIDTH-1:0] rs1i0_rB;
  output rs1i0_rB_use;
  output rs1i0_rB_useF;
  output rs1i0_rB_isV;
  output rs1i0_rB_isAnyV;
  output rs1i0_useBConst;
  output [IN_REG_WIDTH-1:0] rs1i0_rT;
  output rs1i0_rT_use;
  output rs1i0_rT_useF;
  output rs1i0_rT_isV;
  output [PORT_WIDTH-1:0] rs1i0_port;
  output [OPERATION_WIDTH-1:0] rs1i0_operation;
  output rs1i0_en;
  output [DATA_WIDTH-1:0] rs1i0_const;
  output [3:0] rs1i0_index;
  output rs1i0_IPRel;
  output rs1i0_afterTaken;
  output rs1i0_alt;
  output rs1i0_alloc;
  output rs1i0_allocF;
  output rs1i0_allocR;
  output [5:0]  rs1i0_lsi;
  output rs1i0_ldst_flag;
  output rs1i0_enA;
  output rs1i0_enB;
  
  output [IN_REG_WIDTH-1:0] rs1i1_rA;
  output rs1i1_rA_use;
  output rs1i1_rA_useF;
  output rs1i1_rA_isV;
  output rs1i1_rA_isAnyV;
  output rs1i1_useAConst;
  output [IN_REG_WIDTH-1:0] rs1i1_rB;
  output rs1i1_rB_use;
  output rs1i1_rB_useF;
  output rs1i1_rB_isV;
  output rs1i1_rB_isAnyV;
  output rs1i1_useBConst;
  output [IN_REG_WIDTH-1:0] rs1i1_rT;
  output rs1i1_rT_use;
  output rs1i1_rT_useF;
  output rs1i1_rT_isV;
  output [PORT_WIDTH-1:0] rs1i1_port;
  output [OPERATION_WIDTH-1:0] rs1i1_operation;
  output rs1i1_en;
  output [DATA_WIDTH-1:0] rs1i1_const;
  output [3:0] rs1i1_index;
  output rs1i1_IPRel;
  output rs1i1_afterTaken;
  output rs1i1_alloc;
  output rs1i1_allocF;
  output rs1i1_allocR;
  output [3:0] rs1i1_flagDep;
  output rs1i1_lastFl;
  output [5:0]  rs1i1_lsi;
  output rs1i1_ldst_flag;
  output rs1i1_flag_wr;

  output [IN_REG_WIDTH-1:0] rs1i2_rA;
  output rs1i2_rA_use;
  output rs1i2_rA_useF;
  output rs1i2_rA_isV;
  output rs1i2_rA_isAnyV;
  output rs1i2_useAConst;
  output [IN_REG_WIDTH-1:0] rs1i2_rB;
  output rs1i2_rB_use;
  output rs1i2_rB_useF;
  output rs1i2_rB_isV;
  output rs1i2_rB_isAnyV;
  output rs1i2_useBConst;
  output [IN_REG_WIDTH-1:0] rs1i2_rT;
  output rs1i2_rT_use;
  output rs1i2_rT_useF;
  output rs1i2_rT_isV;
  output [PORT_WIDTH-1:0] rs1i2_port;
  output [OPERATION_WIDTH-1:0] rs1i2_operation;
  output rs1i2_en;
  output [DATA_WIDTH-1:0] rs1i2_const;
  output [3:0] rs1i2_index;
  output rs1i2_IPRel;
  output rs1i2_afterTaken;
  output rs1i2_alloc;
  output rs1i2_allocF;
  output rs1i2_allocR;
  output [3:0] rs1i2_flagDep;
  output rs1i2_lastFl;
  output rs1i2_flag_wr;

  output [IN_REG_WIDTH-1:0] rs2i0_rA;
  output rs2i0_rA_use;
  output rs2i0_rA_useF;
  output rs2i0_rA_isV;
  output rs2i0_rA_isAnyV;
  output [IN_REG_WIDTH-1:0] rs2i0_rB;
  output rs2i0_rB_use;
  output rs2i0_rB_useF;
  output rs2i0_rB_isV;
  output rs2i0_rB_isAnyV;
  output rs2i0_useBConst;
  output [IN_REG_WIDTH-1:0] rs2i0_rT;
  output rs2i0_rT_use;
  output rs2i0_rT_useF;
  output rs2i0_rT_isV;
  output [PORT_WIDTH-1:0] rs2i0_port;
  output [OPERATION_WIDTH-1:0] rs2i0_operation;
  output rs2i0_en;
  output [DATA_WIDTH-1:0] rs2i0_const;
  output [3:0] rs2i0_index;
  output rs2i0_IPRel;
  output rs2i0_afterTaken;
  output rs2i0_alt;
  output rs2i0_alloc;
  output rs2i0_allocF;
  output rs2i0_allocR;
  output [5:0]  rs2i0_lsi;
  output rs2i0_ldst_flag;
  output rs2i0_enA;
  output rs2i0_enB;
  
  output [IN_REG_WIDTH-1:0] rs2i1_rA;
  output rs2i1_rA_use;
  output rs2i1_rA_useF;
  output rs2i1_rA_isV;
  output rs2i1_rA_isAnyV;
  output rs2i1_useAConst;
  output [IN_REG_WIDTH-1:0] rs2i1_rB;
  output rs2i1_rB_use;
  output rs2i1_rB_useF;
  output rs2i1_rB_isV;
  output rs2i1_rB_isAnyV;
  output rs2i1_useBConst;
  output [IN_REG_WIDTH-1:0] rs2i1_rT;
  output rs2i1_rT_use;
  output rs2i1_rT_useF;
  output rs2i1_rT_isV;
  output [PORT_WIDTH-1:0] rs2i1_port;
  output [OPERATION_WIDTH-1:0] rs2i1_operation;
  output rs2i1_en;
  output [DATA_WIDTH-1:0] rs2i1_const;
  output [3:0] rs2i1_index;
  output rs2i1_IPRel;
  output rs2i1_afterTaken;
  output rs2i1_alloc;
  output rs2i1_allocF;
  output rs2i1_allocR;
  output [3:0] rs2i1_flagDep;
  output rs2i1_lastFl;
  output [5:0]  rs2i1_lsi;
  output rs2i1_ldst_flag;
  output rs2i1_flag_wr;

  output [IN_REG_WIDTH-1:0] rs2i2_rA;
  output rs2i2_rA_use;
  output rs2i2_rA_useF;
  output rs2i2_rA_isV;
  output rs2i2_rA_isAnyV;
  output rs2i2_useAConst;
  output [IN_REG_WIDTH-1:0] rs2i2_rB;
  output rs2i2_rB_use;
  output rs2i2_rB_useF;
  output rs2i2_rB_isV;
  output rs2i2_rB_isAnyV;
  output rs2i2_useBConst;
  output [IN_REG_WIDTH-1:0] rs2i2_rT;
  output rs2i2_rT_use;
  output rs2i2_rT_useF;
  output rs2i2_rT_isV;
  output [PORT_WIDTH-1:0] rs2i2_port;
  output [OPERATION_WIDTH-1:0] rs2i2_operation;
  output rs2i2_en;
  output [DATA_WIDTH-1:0] rs2i2_const;
  output [3:0] rs2i2_index;
  output rs2i2_IPRel;
  output rs2i2_afterTaken;
  output rs2i2_alloc;
  output rs2i2_allocF;
  output rs2i2_allocR;
  output [3:0] rs2i2_flagDep;
  output rs2i2_lastFl;
  output rs2i2_mul;
  output rs2i2_flag_wr;

  
  output [IN_REG_WIDTH-1:0] instr0_rT;
  output instr0_en;
  output instr0_wren;
  output [8:0] instr0_IPOff;
  output instr0_afterTaken;
  output instr0_rT_useF;
  output instr0_rT_isV;
  output [PORT_WIDTH-1:0] instr0_port;
  output [3:0] instr0_magic;
  output instr0_last;
  output instr0_aft_spc;
  
  output [IN_REG_WIDTH-1:0] instr1_rT;
  output instr1_en;
  output instr1_wren;
  output [8:0] instr1_IPOff;
  output instr1_afterTaken;
  output instr1_rT_useF;
  output instr1_rT_isV;
  output [PORT_WIDTH-1:0] instr1_port;
  output [3:0] instr1_magic;
  output instr1_last;
  output instr1_aft_spc;
  
  output [IN_REG_WIDTH-1:0] instr2_rT;
  output instr2_en;
  output instr2_wren;
  output [8:0] instr2_IPOff;
  output instr2_afterTaken;
  output instr2_rT_useF;
  output instr2_rT_isV;
  output [PORT_WIDTH-1:0] instr2_port;
  output [3:0] instr2_magic;
  output instr2_last;
  output instr2_aft_spc;
  
  output [IN_REG_WIDTH-1:0] instr3_rT;
  output instr3_en;
  output instr3_wren;
  output [8:0] instr3_IPOff;
  output instr3_afterTaken;
  output instr3_rT_useF;
  output instr3_rT_isV;
  output [PORT_WIDTH-1:0] instr3_port;
  output [3:0] instr3_magic;
  output instr3_last;
  output instr3_aft_spc;
  
  output [IN_REG_WIDTH-1:0] instr4_rT;
  output instr4_en;
  output instr4_wren;
  output [8:0] instr4_IPOff;
  output instr4_afterTaken;
  output instr4_rT_useF;
  output instr4_rT_isV;
  output [PORT_WIDTH-1:0] instr4_port;
  output [3:0] instr4_magic;
  output instr4_last;
  output instr4_aft_spc;
  
  output [IN_REG_WIDTH-1:0] instr5_rT;
  output instr5_en;
  output instr5_wren;
  output [8:0] instr5_IPOff;
  output instr5_afterTaken;
  output instr5_rT_useF;
  output instr5_rT_isV;
  output [PORT_WIDTH-1:0] instr5_port;
  output [3:0] instr5_magic;
  output instr5_last;
  output instr5_aft_spc;

  output [IN_REG_WIDTH-1:0] instr6_rT;
  output instr6_en;
  output instr6_wren;
  output [8:0] instr6_IPOff;
  output instr6_afterTaken;
  output instr6_rT_useF;
  output instr6_rT_isV;
  output [PORT_WIDTH-1:0] instr6_port;
  output [3:0] instr6_magic;
  output instr6_last;
  output instr6_aft_spc;

  output [IN_REG_WIDTH-1:0] instr7_rT;
  output instr7_en;
  output instr7_wren;
  output [8:0] instr7_IPOff;
  output instr7_afterTaken;
  output instr7_rT_useF;
  output instr7_rT_isV;
  output [PORT_WIDTH-1:0] instr7_port;
  output [3:0] instr7_magic;
  output instr7_last;
  output instr7_aft_spc;

  output [IN_REG_WIDTH-1:0] instr8_rT;
  output instr8_en;
  output instr8_wren;
  output [8:0] instr8_IPOff;
  output instr8_afterTaken;
  output instr8_rT_useF;
  output instr8_rT_isV;
  output [PORT_WIDTH-1:0] instr8_port;
  output [3:0] instr8_magic;
  output instr8_last;
  output instr8_aft_spc;

  output [IN_REG_WIDTH-1:0] instr9_rT;
  output instr9_en;
  output instr9_wren;
  output [8:0] instr9_IPOff;
  output instr9_afterTaken;
  output instr9_rT_useF;
  output instr9_rT_isV;
  output [PORT_WIDTH-1:0] instr9_port;
  output [3:0] instr9_magic;
  output instr9_last;
  output instr9_aft_spc;

  output [4:0] jump0Type;
  output [3:0] jump0Pos;
  output jump0Taken;
  output [4:0] jump1Type;
  output [3:0] jump1Pos;
  output jump1Taken;
  output jump0BtbWay;
  output [1:0] jump0JmpInd;
  output [7:0] jump0GHT;
  output jump1BtbWay;
  output [1:0] jump1JmpInd;
  output [7:0] jump1GHT;
  output [1:0] jump0SC;
  output jump0Miss;
  output jump0TbufOnly;
  output [1:0] jump1SC;
  output jump1Miss;
  output jump1TbufOnly;
  output [9:0] instr_fsimd;
  output [62:0] baseIP;
  output [3:0] baseAttr;
  
  output [5:0] wrt0;
  output [5:0] wrt1;
  output [5:0] wrt2;
  
  input [15:0] csrss_no;
  input csrss_en;
  input [64:0] csrss_data;
  input [36:0] MSI_expAddr_reg;
  input MSI_expAddr_en_reg;
  output MSI_expAddr_hitCC;
  output [36:0] expun_fr_addr;
  output expun_fr_wen;

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
  bus_data,
  bus_slot,
  bus_en,
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
endmodule
