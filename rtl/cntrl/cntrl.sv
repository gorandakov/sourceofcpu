`include "../../rtl/struct.sv"
`include "../csrss_no.sv"

module cntrl_jump_upto(
  flagSet,
  prevFlags,
  jumpType,
  jumpIndex,
  jumpPredTk,
  jumpTbufMiss,
  indirMismatch,
  jumpMisPred,
  jumpTaken,
  flagOut,
  flagOutN,
  flags0,
  flags1,  
  flags2,
  flags3,
  flags4,
  flags5,
  flags6,
  flags7,
  flags8,
  flags9
  );

  parameter INDEX=0;
  localparam WIDTH=6;
  
  input [9:0] flagSet;
  input [WIDTH-1:0] prevFlags;
  input [4:0] jumpType;
  input [3:0] jumpIndex;
  input jumpPredTk;
  input jumpTbufMiss;
  input indirMismatch;
  output jumpMisPred;
  output jumpTaken;
  output [WIDTH-1:0] flagOut;
  output [WIDTH-1:0] flagOutN;
  input [WIDTH-1:0] flags0;
  input [WIDTH-1:0] flags1;
  input [WIDTH-1:0] flags2;
  input [WIDTH-1:0] flags3;
  input [WIDTH-1:0] flags4;
  input [WIDTH-1:0] flags5;
  input [WIDTH-1:0] flags6;
  input [WIDTH-1:0] flags7;
  input [WIDTH-1:0] flags8;
  input [WIDTH-1:0] flags9;
  
  wire [WIDTH-1:0] flags[9:0];
  wire [9:0] jumpTaken_x;
  wire [9:0] mispred_x;

  wire [9:0] flagLast;
  wire nFlagIsPrev;
  
  wire jumpTaken_0;
  wire mispred_0;

  assign flags[0]=flags0;
  assign flags[1]=flags1;
  assign flags[2]=flags2;
  assign flags[3]=flags3;
  assign flags[4]=flags4;
  assign flags[5]=flags5;
  assign flags[6]=flags6;
  assign flags[7]=flags7;
  assign flags[8]=flags8;
  assign flags[9]=flags9;
  
  bit_find_last_bit #(10) flg_mod(flagSet,flagLast,nFlagIsPrev);
  
  generate
    genvar k;
    for(k=0;k<10;k=k+1) begin : jcmp_gen
        except_jump_cmp cmp_mod(flags[k],jumpType,jumpTaken_x[k]);
        assign mispred_x[k]=(jumpTaken_x[k] ^ jumpPredTk) | (indirMismatch && jumpType==5'h11) | jumpTbufMiss && INDEX==jumpIndex;
        assign jumpTaken=(flagLast[k] && INDEX==jumpIndex) ? jumpTaken_x[k]&~jumpTbufMiss : 1'bz;
        assign jumpMisPred=flagLast[k] ? mispred_x[k] : 1'bz; 
        assign flagOut=(flagLast[k] && INDEX==jumpIndex) ? flags[k] : {WIDTH{1'BZ}};
        assign flagOutN=flagLast[k] ? flags[k] : {WIDTH{1'BZ}};
    end
  endgenerate

  except_jump_cmp cmp_mod(prevFlags,jumpType,jumpTaken_0);
  assign mispred_0=(jumpTaken_0 ^ jumpPredTk) | (indirMismatch && jumpType==5'h11) && INDEX==jumpIndex;
  assign jumpTaken=(~nFlagIsPrev  && INDEX==jumpIndex) ? jumpTaken_0 : 1'bz;
  assign jumpMisPred=(~nFlagIsPrev) ? mispred_0 : 1'bz; 
  assign flagOut=(~nFlagIsPrev && INDEX==jumpIndex) ? prevFlags : {WIDTH{1'BZ}};
  assign flagOutN=(~nFlagIsPrev) ? prevFlags : {WIDTH{1'BZ}};

endmodule

module cntrl_get_IP(
  baseIP,
  srcIPOff,
  magicO,
  last,
  excpt,
  nextIP
  );
  input [42:0] baseIP;
  input [8:0] srcIPOff;
  input [2:0] magicO;
  input last;
  input excpt;
  output [42:0] nextIP;
  
  wire [4:0] par0;
  wire [4:0] par1;
  
  adder #(43-4) last_add(baseIP[42:4],{34'b0,srcIPOff[8:4]},nextIP[42:4],last&~excpt,1'b1,,,,);
  adder_CSA #(4) csa_mod(baseIP[3:0],srcIPOff[3:0],~{1'b0,magicO},par0,par1);
  adder #(4) nlast_add_small(par0[3:0],par1[3:0],nextIP[3:0],1'b1,excpt,,,,);

  assign nextIP[3:0]=(last&~excpt) ? 4'd0 : 4'bz;
  assign nextIP[3:0]=(~last&~excpt) ? srcIPOff[3:0] : 4'bz;

endmodule

module cntrl_get_shortIP(
  baseIP,
  srcIPOff,
  jupd0_IP, jupd0_en,
  jupd1_IP, jupd1_en
  );
  input [19:0] baseIP;
  input [8:0] srcIPOff;
  output [19:0] jupd0_IP;
  input jupd0_en;
  output [19:0] jupd1_IP;
  input jupd1_en;

  adder2o #(20-4) last_add(baseIP[19:4],{11'b0,srcIPOff[8:4]},jupd0_IP[19:4],jupd1_IP[19:4],1'b0,jupd0_en,jupd1_en,,,,);

  assign jupd0_IP[3:0]=jupd0_en ? srcIPOff[3:0] : 4'bz;
  assign jupd1_IP[3:0]=jupd1_en ? srcIPOff[3:0] : 4'bz;

endmodule

module cntrl_get_retcnt(
  reten,
  retcnt);
  input [8:0] reten;
  output [3:0] retcnt;
  
  wire [3:0] cpop0;
  wire [3:0] cpop1;
  wire [3:0] cpop2;
  
  popcnt3 cpop0_mod({reten[6],reten[3],reten[0]},cpop0);
  popcnt3 cpop1_mod({reten[7],reten[4],reten[1]},cpop1);
  popcnt3 cpop2_mod({reten[8],reten[5],reten[2]},cpop2);
  
  assign retcnt[0]=cpop0[0] & cpop1[0] & cpop2[0];
  assign retcnt[1]=cpop0[1] | cpop1[1] | cpop2[1] && cpop0[3:2]==0 && cpop1[3:2]==0 && cpop2[3:2]==0;
  assign retcnt[2]=cpop0[2] | cpop1[2] | cpop2[2] && !cpop0[3] && !cpop1[3] && !cpop2[3];
  assign retcnt[3]=cpop0[3] | cpop1[3] | cpop2[3];
  
endmodule

module cntrl_find_outcome(
  clk,rst,
  stall,doStall,
  except,
  exceptIP,
  except_attr,
  except_thread,
  except_both,
  except_due_jump,
  except_jump_ght,
  except_set_instr_flag,
  except_jmp_mask_en,
  except_jmp_mask,
  csrss_no,csrss_thread,csrss_en,csrss_data,
  new_en,new_thread,new_addr,
  instr0_en,instr0_wren,instr0_IPOff,instr0_magic,instr0_last,instr0_after_spec,
  instr1_en,instr1_wren,instr1_IPOff,instr1_magic,instr1_last,instr1_after_spec,
  instr2_en,instr2_wren,instr2_IPOff,instr2_magic,instr2_last,instr2_after_spec,
  instr3_en,instr3_wren,instr3_IPOff,instr3_magic,instr3_last,instr3_after_spec,
  instr4_en,instr4_wren,instr4_IPOff,instr4_magic,instr4_last,instr4_after_spec,
  instr5_en,instr5_wren,instr5_IPOff,instr5_magic,instr5_last,instr5_after_spec,
  instr6_en,instr6_wren,instr6_IPOff,instr6_magic,instr6_last,instr6_after_spec,
  instr7_en,instr7_wren,instr7_IPOff,instr7_magic,instr7_last,instr7_after_spec,
  instr8_en,instr8_wren,instr8_IPOff,instr8_magic,instr8_last,instr8_after_spec,
  instr9_en,instr9_wren,instr9_IPOff,instr9_magic,instr9_last,instr9_after_spec,
  instr_attr,
  instr0_rT,instr0_gen,instr0_vec,
  instr1_rT,instr1_gen,instr1_vec,
  instr2_rT,instr2_gen,instr2_vec,
  instr3_rT,instr3_gen,instr3_vec,
  instr4_rT,instr4_gen,instr4_vec,
  instr5_rT,instr5_gen,instr5_vec,
  instr6_rT,instr6_gen,instr6_vec,
  instr7_rT,instr7_gen,instr7_vec,
  instr8_rT,instr8_gen,instr8_vec,
  instr9_rT,instr9_gen,instr9_vec,
  iret0,iret1,iret2,iret3,iret4,
  iret5,iret6,iret7,iret8,
  iret0_rF,iret1_rF,iret2_rF,iret3_rF,iret4_rF,
  iret5_rF,iret6_rF,iret7_rF,iret8_rF,
  iret_clr,
  ijump0Type,ijump0Off,ijump0IP,ijump0BND,ijump0Mask,
  ijump1Type,ijump1Off,ijump1IP,ijump1BND,ijump1Mask,
  ijump0BtbWay,ijump0JmpInd,ijump0GHT,
  ijump1BtbWay,ijump1JmpInd,ijump1GHT,
  ijump0SC,ijump0Miss,ijump0BtbOnly,
  ijump1SC,ijump1Miss,ijump1BtbOnly,
  itk_after,ifsimd,
  iJump0Taken,iJump1Taken,
  iJump0Attr,iJump1Attr,
  flTE,retire_enFl,
  retire0_rT,retire0_rF,retire0_enG,retire0_enV,retire0_enF,
  retire1_rT,retire1_rF,retire1_enG,retire1_enV,retire1_enF,
  retire2_rT,retire2_rF,retire2_enG,retire2_enV,retire2_enF,
  retire3_rT,retire3_rF,retire3_enG,retire3_enV,retire3_enF,
  retire4_rT,retire4_rF,retire4_enG,retire4_enV,retire4_enF,
  retire5_rT,retire5_rF,retire5_enG,retire5_enV,retire5_enF,
  retire6_rT,retire6_rF,retire6_enG,retire6_enV,retire6_enF,
  retire7_rT,retire7_rF,retire7_enG,retire7_enV,retire7_enF,
  retire8_rT,retire8_rF,retire8_enG,retire8_enV,retire8_enF,
  doRetire,retcnt,retclr,
  jupd0_en,jupdt0_en,jupd0_ght_en,
  jupd0_addr,jupd0_baddr,
  jupd0_sc,jupd0_tk,
  jupd1_en,jupdt1_en,jupd1_ght_en,
  jupd1_addr,jupd1_baddr,
  jupd1_sc,jupd1_tk,
  ret0_addr,ret0_data,ret0_wen,
  ret1_addr,ret1_data,ret1_wen,
  ret2_addr,ret2_data,ret2_wen,
  ret3_addr,ret3_data,ret3_wen,
  ret4_addr,ret4_data,ret4_wen,
  ret5_addr,ret5_data,ret5_wen,ret5_IP,ret5_IP_en,
  ret6_addr,ret6_data,ret6_wen,
  ret7_addr,ret7_data,ret7_wen,
  mem_II_upper,
  mem_II_upper_out,
  mem_II_bits_fine,
  mem_II_bits_ldconfl,
  mem_II_bits_waitconfl,
  mem_II_bits_except,
  mem_II_bits_ret,
  mem_II_stall,
  
  doRetire_d,
  xbreak,
  has_xbreak
  );
  localparam RET_WIDTH=`except_width;
  localparam BOB_WIDTH=`bob_width;

  input clk;
  input rst;
  input stall;
  output doStall;
  
  output reg except;
  output reg [62:0] exceptIP;
  output reg [3:0] except_attr;
  output reg except_thread;
  output reg except_both;
  output reg except_due_jump;
  output reg [7:0] except_jump_ght;
  output reg except_set_instr_flag;
  output reg except_jmp_mask_en;
  output reg [3:0] except_jmp_mask;
  output reg [15:0] csrss_no;
  output reg csrss_thread;
  output reg csrss_en;
  output reg [6_4:0] csrss_data;
  input new_en;
  input new_thread;
  output wire [5:0] new_addr;
  input instr0_en;
  input instr0_wren;  
  input [8:0] instr0_IPOff;
  input [2:0] instr0_magic;
  input instr0_last;
  input instr0_after_spec;
  input instr1_en;
  input instr1_wren;  
  input [8:0] instr1_IPOff;
  input [2:0] instr1_magic;
  input instr1_last;
  input instr1_after_spec;
  input instr2_en;
  input instr2_wren;  
  input [8:0] instr2_IPOff;
  input [2:0] instr2_magic;
  input instr2_last;
  input instr2_after_spec;
  input instr3_en;
  input instr3_wren;  
  input [8:0] instr3_IPOff;
  input [2:0] instr3_magic;
  input instr3_last;
  input instr3_after_spec;
  input instr4_en;
  input instr4_wren;  
  input [8:0] instr4_IPOff;
  input [2:0] instr4_magic;
  input instr4_last;
  input instr4_after_spec;
  input instr5_en;
  input instr5_wren;  
  input [8:0] instr5_IPOff;
  input [2:0] instr5_magic;
  input instr5_last;
  input instr5_after_spec;
  input instr6_en;
  input instr6_wren;  
  input [8:0] instr6_IPOff;
  input [2:0] instr6_magic;
  input instr6_last;
  input instr6_after_spec;
  input instr7_en;
  input instr7_wren;  
  input [8:0] instr7_IPOff;
  input [2:0] instr7_magic;
  input instr7_last;
  input instr7_after_spec;
  input instr8_en;
  input instr8_wren;  
  input [8:0] instr8_IPOff;
  input [2:0] instr8_magic;
  input instr8_last;
  input instr8_after_spec;
  input instr9_en;
  input instr9_wren;  
  input [8:0] instr9_IPOff;
  input [2:0] instr9_magic;
  input instr9_last;
  input instr9_after_spec;
  input [3:0] instr_attr;

  input [5:0] instr0_rT;
  input instr0_gen;
  input instr0_vec;
  input [5:0] instr1_rT;
  input instr1_gen;
  input instr1_vec;
  input [5:0] instr2_rT;
  input instr2_gen;
  input instr2_vec;
  input [5:0] instr3_rT;
  input instr3_gen;
  input instr3_vec;
  input [5:0] instr4_rT;
  input instr4_gen;
  input instr4_vec;
  input [5:0] instr5_rT;
  input instr5_gen;
  input instr5_vec;
  input [5:0] instr6_rT;
  input instr6_gen;
  input instr6_vec;
  input [5:0] instr7_rT;
  input instr7_gen;
  input instr7_vec;
  input [5:0] instr8_rT;
  input instr8_gen;
  input instr8_vec;
  input [5:0] instr9_rT;
  input instr9_gen;
  input instr9_vec;

  input [3:0] iret0;
  input [3:0] iret1;
  input [3:0] iret2;
  input [3:0] iret3;
  input [3:0] iret4;
  input [3:0] iret5;
  input [3:0] iret6;
  input [3:0] iret7;
  input [3:0] iret8;
  
  input [4:0] iret0_rF;
  input [4:0] iret1_rF;
  input [4:0] iret2_rF;
  input [4:0] iret3_rF;
  input [4:0] iret4_rF;
  input [4:0] iret5_rF;
  input [4:0] iret6_rF;
  input [4:0] iret7_rF;
  input [4:0] iret8_rF;

  input [8:0] iret_clr;
  
  input [4:0] ijump0Type;
  input [3:0] ijump0Off;
  input [42:0] ijump0IP;
  input [19:0] ijump0BND;
  input [3:0] ijump0Mask;
  input [4:0] ijump1Type;
  input [3:0] ijump1Off;
  input [42:0] ijump1IP;
  input [19:0] ijump1BND;
  input [3:0] ijump1Mask;
  input       ijump0BtbWay;
  input [1:0] ijump0JmpInd;
  input [7:0] ijump0GHT;
  input       ijump1BtbWay;
  input [1:0] ijump1JmpInd;
  input [7:0] ijump1GHT;
  input [1:0] ijump0SC;
  input ijump0Miss;
  input ijump0BtbOnly;
  input [1:0] ijump1SC;
  input ijump1Miss;
  input ijump1BtbOnly;
  input [9:0] itk_after;
  input [9:0] ifsimd;
  input iJump0Taken;
  input iJump1Taken;
  input [3:0] iJump0Attr;
  input [3:0] iJump1Attr;
  output [8:0] flTE;
  output reg retire_enFl;
  output reg [5:0] retire0_rT;
  output [8:0] retire0_rF;
  output reg retire0_enG;
  output reg retire0_enV;
  output reg retire0_enF;
  output reg [5:0] retire1_rT;
  output [8:0] retire1_rF;
  output reg retire1_enG;
  output reg retire1_enV;
  output reg retire1_enF;
  output reg [5:0] retire2_rT;
  output [8:0] retire2_rF;
  output reg retire2_enG;
  output reg retire2_enV;
  output reg retire2_enF;
  output reg [5:0] retire3_rT;
  output [8:0] retire3_rF;
  output reg retire3_enG;
  output reg retire3_enV;
  output reg retire3_enF;
  output reg [5:0] retire4_rT;
  output [8:0] retire4_rF;
  output reg retire4_enG;
  output reg retire4_enV;
  output reg retire4_enF;
  output reg [5:0] retire5_rT;
  output [8:0] retire5_rF;
  output reg retire5_enG;
  output reg retire5_enV;
  output reg retire5_enF;
  output reg [5:0] retire6_rT;
  output [8:0] retire6_rF;
  output reg retire6_enG;
  output reg retire6_enV;
  output reg retire6_enF;
  output reg [5:0] retire7_rT;
  output [8:0] retire7_rF;
  output reg retire7_enG;
  output reg retire7_enV;
  output reg retire7_enF;
  output reg [5:0] retire8_rT;
  output [8:0] retire8_rF;
  output reg retire8_enG;
  output reg retire8_enV;
  output reg retire8_enF;

  output reg doRetire;
  output reg [3:0] retcnt;
  output reg [8:0] retclr;

  output reg jupd0_en;
  output reg jupdt0_en;
  output reg jupd0_ght_en;
  output reg [15:0] jupd0_addr;
  output reg [12:0] jupd0_baddr;
  output reg [1:0] jupd0_sc;
  output reg jupd0_tk;
  output reg jupd1_en;
  output reg jupdt1_en;
  output reg jupd1_ght_en;
  output reg [15:0] jupd1_addr;
  output reg [12:0] jupd1_baddr;
  output reg [1:0] jupd1_sc;
  output reg jupd1_tk;
  
  
  input [9:0] 			ret0_addr;
  input [RET_WIDTH-1:0] 	ret0_data;
  input 			ret0_wen;
  input [9:0] 			ret1_addr;
  input [RET_WIDTH-1:0] 	ret1_data;
  input 			ret1_wen;
  input [9:0] 			ret2_addr;
  input [RET_WIDTH-1:0] 	ret2_data;
  input 			ret2_wen;
  input [9:0] 			ret3_addr;
  input [RET_WIDTH-1:0] 	ret3_data;
  input 			ret3_wen;
  input [9:0] 			ret4_addr;
  input [RET_WIDTH-1:0] 	ret4_data;
  input 			ret4_wen;
  input [9:0] 			ret5_addr;
  input [RET_WIDTH-1:0] 	ret5_data;
  input 			ret5_wen;
  input [64:0]			ret5_IP;
  input				ret5_IP_en;
  input [9:0] 			ret6_addr;
  input [RET_WIDTH-1:0] 	ret6_data;
  input 			ret6_wen;
  input [9:0] 			ret7_addr;
  input [RET_WIDTH-1:0] 	ret7_data;
  input 			ret7_wen;

  input [5:0] mem_II_upper;
  output [5:0] mem_II_upper_out;
  input [9:0] mem_II_bits_fine;
  input [9:0] mem_II_bits_ldconfl;
  input [9:0] mem_II_bits_waitconfl;
  input [9:0] mem_II_bits_except;
  input [9:0] mem_II_bits_ret;
  input mem_II_stall;

  output doRetire_d;
  output [9:0] xbreak;
  output has_xbreak;

  wire mem_match;
  wire [9:0][RET_WIDTH-1:0] ret_data; 
  wire [3:0] ret[9:0];
  wire [9:0] flagSet;
  wire [9:0] pending;
  wire [9:0] exceptn;
  wire [9:0] replay;
  wire [9:0] replay_safe;
  wire [9:0] done;
  wire [9:0] fpudone;
  wire [9:0] btb_miss;
  wire break_pending,break_prejmp_tick,break_prejmp_ntick;
  wire break_exceptn;
  wire break_replay,break_replayS;
  wire break_jump0;
  wire break_jump1;
  wire [9:0][9:0] ret_prev;
  wire [9:0][9:0] ret_prevG;
  wire [9:0][9:0] ret_prevV;
  wire [9:0][9:0] ret_prevF;
  wire [9:0] xbreak0;
  wire [9:0] break_;
  wire [9:0][5:0] rT;
  wire [8:0][5:0] rTe;
  wire [9:0] jump0_misPred;
  wire [9:0] jump1_misPred;
  wire indirMismatch;
  wire has_break;
  wire has_xbreak0;

  wire [3:0] retcnt_d;
  
  wire [BOB_WIDTH-1:0] bob_wdata;
  wire [BOB_WIDTH-1:0] bob_rdata;
  
  wire [9:0][8:0] IPOff;
  wire [9:0][2:0] magicO;
  wire [8:0] retireG;
  wire [8:0] retireV;
  wire [8:0] retireF;
  wire [8:0] no_retire;

  wire [8:0][8:0] retire_rF;

  wire [4:0] jump0Type;
  wire [3:0] jump0Pos;
  wire [42:0] jump0IP;
  wire [4:0] jump1Type;
  wire [3:0] jump1Pos;
  wire [42:0] jump1IP;
  
  wire       jump0BtbWay;
  wire [1:0] jump0JmpInd;
  wire [7:0] jump0GHT;
  wire       jump1BtbWay;
  wire [1:0] jump1JmpInd;
  wire [7:0] jump1GHT;
  wire [1:0] jump0SC;
  wire jump0Miss;
  wire jump0BtbOnly;
  wire [1:0] jump1SC;
  wire jump1Miss;
  wire jump1BtbOnly;

  wire jump0_taken;
  wire [5:0] jump0_flags;
  wire jump1_taken;
  wire [5:0] jump1_flags;

  wire [9:0][5:0] nextFlags;
  
  wire [42:0] breakIP;
  wire [9:0][42:0] nextIP;
  wire [19:0] jupd0_IP;
  wire [19:0] jupd1_IP;
  wire lastIP;

  wire both_threads;
  wire thread0,thread1;

  wire retire_thread;
  reg retire_thread_reg;

  wire [62:0] exceptIP_d;
  wire except_thread_d=retire_thread_reg;
  wire except_both_d=both_threads;
  wire except_d;
  wire [15:0] proc_d;
  wire [3:0] except_attr_d;

  wire [5:0] flags_d;
  reg  [5:0] flags[1:0];

 // wire doRetire_d;
  wire has_some,has_some2;

  wire [5:0] retire_addr;
  reg  [5:0] retire_addr_reg;

  wire [64:0] indir_IP;
  wire indir_ready;
  wire has_indir;
  wire i_has_indir;
  wire [42:0] takenIP;

  wire [3:0] attr;
  wire [3:0] jump0Attr;
  wire [3:0] jump1Attr;

  reg [5:0] initcount;
  wire [5:0] initcount_d;
  reg init;

  wire [42:0] excpt_handlerIP;
  wire [7:0] excpt_code;
  wire jump0Pred;
  wire jump1Pred;

  wire [15:0] update_ght_addr_j0;
  wire [15:0] update_ght_addr_j1;
  wire [12:0] update_btb_addr_j0;
  wire [12:0] update_btb_addr_j1;
  wire [1:0]  update_sc_j0;
  wire [1:0]  update_sc_j1;

  wire [9:0] jump0_here;
  wire [9:0] jump1_here;
  wire jump0_in,jump1_in;

  wire [9:0] tk_after;
  wire [9:0] afterTick;

  wire [9:0] isGen;
  wire [9:0] isVec;
  wire [9:0] isFPU;
  
  wire [9:0] rgen;
  wire [9:0] rvec;
  wire [9:0] last_instr;

  wire is_after_spec;
  wire [9:0] rd_after_spec;
  reg [62:0] baseIP;
  wire [62:0] baseIP_d;
  
  wire [8:0] retclrP;

  wire [3:0] jump0JMask;
  wire [3:0] jump1JMask;
  wire [3:0] jump0Mask;
  wire [3:0] jump1Mask;
      
  wire [9:0] flag_last;
  wire flag_has;
  wire [9:0] lfl;
  wire lfl_has;
  wire has_someX;

  wire [19:0] jump0BND;
  wire [19:0] jump1BND;

  wire [15:0] csrss_no_d;
  wire csrss_thread_d;
  wire csrss_en_d;
  wire [64:0] csrss_data_d;

  reg [42:0] archReg_xcpt_retIP		[1:0];
  reg [42:0] archReg_xcpt_handlerIP	[1:0];
  reg [15:0] archReg_proc		[1:0];
 // reg [7:0]  archReg_xcpt_code		[1:0];
  
  generate
    genvar k,j;
    for(k=0;k<10;k=k+1) begin : jumps_gen
      assign flagSet[k]=ret_data[k][`except_setsFlags];
      assign pending[k]=ret_data[k][`except_status]==2'd0 && !(mem_match & mem_II_bits_ret[k]);
      assign exceptn[k]=(ret_data[k][`except_status]==2'd1 && ~ret_data[k][14]) || (mem_match & mem_II_bits_except[k]);
      assign replay[k]=(ret_data[k][`except_status]==2'd1 && ret_data[k][14]) || (mem_match & mem_II_bits_ldconfl[k]);
      assign replay_safe[k]=(ret_data[k][`except_status]==2'd1 && ret_data[k][14]) || (mem_match & mem_II_bits_waitconfl[k]);
      assign done[k]=ret_data[k][`except_status]==2'd2 || (mem_match & mem_II_bits_fine[k] & mem_II_bits_ret[k]);
      assign fpudone[k]=ret_data[k][`except_status]==2'd3;//with exception flags set
          
      assign btb_miss[k]=(jump0Pos==k && jump0Miss) || (jump1Pos==k && jump1Miss);
      assign jump0_here[k]=jump0Pos==k;
      assign jump1_here[k]=jump1Pos==k;
      wire [9:0] flag_last;
      wire flag_has;
      /* verilator lint_off WIDTH */
      if (k>0) bit_find_last_bit #(10) lastfl_mod({10'b0,flagSet[k-1:0]},flag_last,flag_has);
      /* verilator lint_on WIDTH */
      if (k>0) assign lfl=xbreak0[k] ? flag_last : 10'bz;
      else assign lfl=xbreak0[k] ? 10'b0 : 10'bz;
      if (k>0) assign lfl_has=xbreak0[k] ? flag_has : 1'bz;
      else assign lfl_has=xbreak0[k] ? 1'b0 : 1'bz;
      if (k>0) assign jump0_in=xbreak0[k] ? |jump0_here[k-1:0] : 1'bz;
      else assign jump0_in=xbreak0[k] ? 1'b0 : 1'bz;
      if (k>0) assign jump1_in=xbreak0[k] ? |jump1_here[k-1:0] : 1'bz;
      else assign jump1_in=xbreak0[k] ? 1'b0 : 1'bz;
      assign break_pending=break_[k] ? pending[k] : 1'bz;
      if (k>0) assign break_prejmp_tick=break_[k] ? afterTick[k-1] & ~tk_after[k-1] : 1'bz;
      else assign break_prejmp_tick=break_[0] ? 1'b0 : 1'bz;
      if (k>0) assign break_prejmp_ntick=break_[k] ? ~afterTick[k-1] &~tk_after[k-1] : 1'bz;
      else assign break_prejmp_ntick=break_[0] ? 1'b1 : 1'bz;
      assign break_exceptn=break_[k] ? exceptn[k] : 1'bz;
      assign break_replay=break_[k] ? replay[k] : 1'bz;
      assign break_replayS=break_[k] ? replay_safe[k] : 1'bz;
      assign break_jump0=break_[k] ? jump0_misPred[k] & done[k] : 1'bz;
      assign break_jump1=break_[k] ? jump1_misPred[k] & done[k] : 1'bz;
      if (k<9) assign flags_d=xbreak0[k+1] ? nextFlags[k] : 6'bz; 
      else assign flags_d=has_xbreak0 ? 6'bz : nextFlags[9];

      assign afterTick[k]=IPOff[k][8];
     
      wire [8:0] flE; 
      for(j=0;j<9;j=j+1) begin : ret_gen
	  wire reteq=ret[j]==k;
          assign ret_prev[j][k]=rT[j]==rT[k] && ~xbreak[k] && k>j;
          assign ret_prevG[j][k]=ret_prev[j][k] && isGen[j] && isGen[k];
          assign ret_prevV[j][k]=ret_prev[j][k] && isVec[j] && isVec[k];
          assign ret_prevF[j][k]=ret_prev[j][k] && isFPU[j] && isFPU[k];
          
	  assign retireG[j]=reteq ? ~xbreak[k]  && ret_prevG[k]==0 && isGen[k] && ~rT[k][5] : 1'bz; 
          assign retireV[j]=reteq ? ~xbreak[k]  && ret_prevV[k]==0 && isVec[k] && ~rT[k][5]  : 1'bz; 
          assign retireF[j]=reteq ? ~xbreak[k]  && ret_prevF[k]==0 && isFPU[k] && ~rT[k][5]  : 1'bz;

          assign rTe[j]=reteq ? rT[k] : 6'bz;

          assign flE=reteq && lfl[k] ? retire_rF[j] : 9'bz;	  
      end
      assign flE=~lfl[k] ? 9'b0 : 9'bz;
      assign flTE=lfl[k] ? flE : 9'bz;
  
      if (k<9) begin
          assign no_retire[k]=ret[k]==4'hf;
          assign retireG[k]=no_retire[k] ? 1'b0 : 1'bz;
          assign retireV[k]=no_retire[k] ? 1'b0 : 1'bz;
          assign retireF[k]=no_retire[k] ? 1'b0 : 1'bz;
          assign rTe[k]=no_retire[k] ? 6'd0 : 6'bz;
          //assign rFe[k]=no_retire[k] ? 9'd0 : 9'bz;
      end

      assign excpt_code=break_[k] ? ret_data[k][10:3] : 8'bz;
      
      cntrl_jump_upto #(k) j0_mod(
      .flagSet(flagSet&((10'b1<<(k+1))-10'b1)),
      .prevFlags(flags[retire_thread_reg]),
      .jumpType(jump0Type),
      .jumpIndex(jump0Pos),
      .jumpPredTk(jump0Pred),
      .jumpTbufMiss(jump0Miss),
      .indirMismatch(indirMismatch),
      .jumpMisPred(jump0_misPred[k]),
      .jumpTaken(jump0_taken),
      .flagOut(jump0_flags),
      .flagOutN(nextFlags[k]),
      .flags0(ret_data[0][`except_flags]),
      .flags1(ret_data[1][`except_flags]),   
      .flags2(ret_data[2][`except_flags]),
      .flags3(ret_data[3][`except_flags]),
      .flags4(ret_data[4][`except_flags]),
      .flags5(ret_data[5][`except_flags]),
      .flags6(ret_data[6][`except_flags]),
      .flags7(ret_data[7][`except_flags]),
      .flags8(ret_data[8][`except_flags]),
      .flags9(ret_data[9][`except_flags])
      );

      cntrl_jump_upto #(k) j1_mod(
      .flagSet(flagSet&((10'b1<<(k+1))-10'b1)),
      .prevFlags(flags[retire_thread_reg]),
      .jumpType(jump1Type),
      .jumpIndex(jump1Pos),
      .jumpPredTk(jump1Pred),
      .jumpTbufMiss(jump1Miss),
      .indirMismatch(indirMismatch),
      .jumpMisPred(jump1_misPred[k]),
      .jumpTaken(jump1_taken),
      .flagOut(jump1_flags),
      .flagOutN(),
      .flags0(ret_data[0][`except_flags]),
      .flags1(ret_data[1][`except_flags]),      
      .flags2(ret_data[2][`except_flags]),
      .flags3(ret_data[3][`except_flags]),
      .flags4(ret_data[4][`except_flags]),
      .flags5(ret_data[5][`except_flags]),
      .flags6(ret_data[6][`except_flags]),
      .flags7(ret_data[7][`except_flags]),
      .flags8(ret_data[8][`except_flags]),
      .flags9(ret_data[9][`except_flags])
      );

      wire [42:0] from_IP;
      assign from_IP=(~tk_after[k]) ? baseIP[42:0] : 43'bz;
      assign from_IP=(tk_after[k] & jump0Pred) ? jump0IP[42:0] : 43'bz;
      assign from_IP=(tk_after[k] & jump1Pred) ? jump1IP[42:0] : 43'bz;

      assign breakIP=break_[k] ? nextIP[k] : 43'bz;
      assign lastIP=break_[k] ? last_instr[k] : 1'bz;
      assign is_after_spec=break_[k] ? rd_after_spec[k] : 1'bz;

      cntrl_get_IP newIP_mod(
      .baseIP(from_IP),
      .srcIPOff(IPOff[k]),
      .magicO(magicO[k]),
      .last(last_instr[k]),
      .excpt(exceptn[k]|btb_miss[k]|replay[k]|replay_safe[k]),
      .nextIP(nextIP[k])
      );
  
      cntrl_get_shortIP shortIP_mod(
      .baseIP(from_IP[19:0]),
      .srcIPOff(IPOff[k]),
      .jupd0_IP(jupd0_IP), .jupd0_en(jump0Pos==k),
      .jupd1_IP(jupd1_IP), .jupd1_en(jump1Pos==k)
      );
    end
  endgenerate

  assign jupd0_IP=(jump0Pos==4'hf) ? 20'b0 : 20'bz;
  assign jupd1_IP=(jump1Pos==4'hf) ? 20'b0 : 20'bz;
  
  assign breakIP=has_break ? 43'bz : 43'b0;
  assign excpt_code=has_break ? 8'bz : 8'b0;
  assign lastIP=has_break ? 1'bz : 1'b0;
      
  bit_find_last_bit #(10) lastfl_mod(flagSet,flag_last,flag_has);
  
  assign lfl=has_xbreak0 ? 10'bz : flag_last;
  assign lfl_has=has_xbreak0 ? 1'bz : flag_has;

  assign flTE=lfl_has ? 9'bz : 9'b0;

  assign jump0_in=has_xbreak0 ? 1'bz : jump0Pos!=4'hf;
  assign jump1_in=has_xbreak0 ? 1'bz : jump1Pos!=4'hf;

  assign break_prejmp_ntick=(~has_break) ? afterTick==0 && tk_after==0 : 1'bz;
  assign break_prejmp_tick=(~has_break) ? afterTick!=0 && tk_after==0 : 1'bz;

  assign retire_rF[0]=retire0_rF;
  assign retire_rF[1]=retire1_rF;
  assign retire_rF[2]=retire2_rF;
  assign retire_rF[3]=retire3_rF;
  assign retire_rF[4]=retire4_rF;
  assign retire_rF[5]=retire5_rF;
  assign retire_rF[6]=retire6_rF;
  assign retire_rF[7]=retire7_rF;
  assign retire_rF[8]=retire8_rF;

  assign jump0JMask=(jump0JmpInd==2'd0 && ~jump0_taken) ? 4'he|{4{lastIP}} : 4'bz;
  assign jump0JMask=(jump0JmpInd==2'd1 && ~jump0_taken) ? 4'hc|{4{lastIP}} : 4'bz;
  assign jump0JMask=(jump0JmpInd==2'd2 && ~jump0_taken) ? 4'h8|{4{lastIP}} : 4'bz;
  assign jump0JMask=(jump0JmpInd==2'd3 && ~jump0_taken) ? 4'h0|{4{lastIP}} : 4'bz;
  assign jump0JMask=(jump0_taken) ? jump0Mask : 4'bz;
  
  assign jump1JMask=(jump1JmpInd==2'd0 && ~jump1_taken) ? 4'he|{4{lastIP}} : 4'bz;
  assign jump1JMask=(jump1JmpInd==2'd1 && ~jump1_taken) ? 4'hc|{4{lastIP}} : 4'bz;
  assign jump1JMask=(jump1JmpInd==2'd2 && ~jump1_taken) ? 4'h8|{4{lastIP}} : 4'bz;
  assign jump1JMask=(jump1JmpInd==2'd3 && ~jump1_taken) ? 4'h0|{4{lastIP}} : 4'bz;
  assign jump1JMask=(jump1_taken) ? jump1Mask : 4'bz;

  assign update_ght_addr_j0[15:8]=jupd0_IP[19:12]^jump0GHT;
  assign update_ght_addr_j0[7:6]=jupd0_IP[11:10]^jump0JmpInd;
  assign update_ght_addr_j0[5:0]=jupd0_IP[9:4];
  
  assign update_ght_addr_j1[15:8]=jupd1_IP[19:12]^jump1GHT;
  assign update_ght_addr_j1[7:6]=jupd1_IP[11:10]^jump1JmpInd;
  assign update_ght_addr_j1[5:0]=jupd1_IP[9:4];
  
  assign update_btb_addr_j1[12:11]=jump1JmpInd;
  assign update_btb_addr_j1[0]=jump1BtbWay;
  assign update_btb_addr_j1[10:1]=jupd1_IP[13:4];
  
  assign update_btb_addr_j0[12:11]=jump0JmpInd;
  assign update_btb_addr_j0[0]=  jump0BtbWay;
  assign update_btb_addr_j0[10:1]=jupd0_IP[13:4];
  
  assign excpt_handlerIP=archReg_xcpt_handlerIP[retire_thread_reg];
      
  assign isGen=rgen & ~rvec;
  assign isVec=rvec;
  assign isFPU=rgen~^rvec;
  
  assign ret_prev[9]=10'b0;
  assign ret_prevG[9]=10'b0;
  assign ret_prevV[9]=10'b0;
  assign ret_prevF[9]=10'b0;
//warning: trace not yet handled
  assign exceptIP_d=(break_jump0 & jump0_taken) ? {jump0BND,jump0IP} : 63'bz;
  assign exceptIP_d=(break_jump1 & jump1_taken) ? {jump1BND,jump1IP} : 63'bz;
  assign exceptIP_d=(break_jump0 && ~jump0_taken && !(jump0Type[4] && jump0Type[2:0]==3'd1)) ? {baseIP[62:43],breakIP} : 63'bz;
  assign exceptIP_d=(break_jump1 & ~jump1_taken && !(jump1Type[4] && jump1Type[2:0]==3'd1)) ? {baseIP[62:43],breakIP} : 63'bz;
  assign exceptIP_d=(break_jump0 && ~jump0_taken && (jump0Type==5'h11)) ? indir_IP[63:1] : 63'bz;
  assign exceptIP_d=(break_jump1 & ~jump1_taken && (jump1Type==5'h11)) ? indir_IP[63:1] : 63'bz;
  assign exceptIP_d=(break_jump0 && ~jump0_taken && (jump0Type==5'h19)) ? {baseIP[62:43],indir_IP[43:1]} : 63'bz;
  assign exceptIP_d=(break_jump1 & ~jump1_taken && (jump1Type==5'h19)) ? {baseIP[62:43],indir_IP[43:1]} : 63'bz;
  assign exceptIP_d=(break_exceptn) ? {baseIP[62:43],excpt_handlerIP[42:11],excpt_code[5:0],5'b0} : 63'bz;
  assign exceptIP_d=(break_replay|break_replayS) ? {baseIP[62:43],breakIP} : 63'bz;
  assign exceptIP_d=(break_pending | ~has_break) ? 63'b0 : 63'bz;

  assign except_attr_d=(break_jump0 & jump0_taken) ? jump0Attr : 4'bz;
  assign except_attr_d=(break_jump1 & jump1_taken) ? jump1Attr : 4'bz;
  assign except_attr_d=(break_jump0 && ~jump0_taken && !(jump0Type[4] && jump0Type[2:0]==3'd1)) ? attr : 4'bz;
  assign except_attr_d=(break_jump1 & ~jump1_taken && !(jump1Type[4] && jump1Type[2:0]==3'd1)) ? attr : 4'bz;
  assign except_attr_d=(break_jump0 && ~jump0_taken && (jump0Type==5'h11)) ? attr : 4'bz;
  assign except_attr_d=(break_jump1 & ~jump1_taken && (jump1Type==5'h11)) ? attr : 4'bz;
  assign except_attr_d=(break_jump0 && ~jump0_taken && (jump0Type==5'h19)) ? {indir_IP[60],1'b0,indir_IP[62],indir_IP[63]} : 4'bz;
  assign except_attr_d=(break_jump1 & ~jump1_taken && (jump1Type==5'h19)) ? {indir_IP[60],1'b0,indir_IP[62],indir_IP[63]} : 4'bz;
  assign except_attr_d=(break_exceptn) ? attr : 4'bz;
  assign except_attr_d=(break_replay|break_replayS) ? attr : 4'bz;
  assign except_attr_d=(break_pending | ~has_break) ? 4'b0 : 4'bz;

  assign csrss_no_d=(break_jump0) ? jump0IP[15:0] : 16'bz;
  assign csrss_no_d=(break_jump1) ? jump1IP[15:0] : 16'bz;
  assign csrss_no_d=(~break_jump0 & ~break_jump1) ? 16'd`csr_retIP : 16'bz;
  assign csrss_en_d=(break_jump0) ? jump0Type==5'b11001 && has_some && ~mem_II_stall : 1'bz;
  assign csrss_en_d=(break_jump1) ? jump1Type==5'b11001 && has_some && ~mem_II_stall : 1'bz;
  assign csrss_en_d=(break_exceptn) ? has_some & ~mem_II_stall : 1'bz;
  assign csrss_en_d=(~break_jump0 & ~break_jump1 & ~break_exceptn) ? 1'b0 : 1'bz;
  assign csrss_data_d=(break_exceptn) ? {1'b0,attr[0],attr[1],is_after_spec,attr[3],12'b0,4'b0,breakIP,1'b0} : indir_IP;
  assign baseIP_d=(jump0_in & jump0_taken &~break_exceptn &~break_replay &~break_replayS) ? {jump0BND,jump0IP} : 6_3'bz;
  assign baseIP_d=(jump1_in & jump1_taken &~break_exceptn &~break_replay &~break_replayS) ? {jump1BND,jump1IP} : 63'bz;
  assign baseIP_d=(break_exceptn) ? {baseIP[62:43],excpt_handlerIP} : 63'bz;
  assign baseIP_d=break_replay || ~(jump0_in&jump0_taken) & ~(jump1_in&jump1_taken) & (break_jump0||
      break_jump1) ? {baseIP[62:43],breakIP} : 63'bz;
  assign baseIP_d=break_prejmp_ntick & ~(jump0_in&jump0_taken) & ~(jump1_in&jump1_taken) 
      & ~break_jump0 & ~break_jump1 & ~break_exceptn & ~break_replay ? baseIP : 63'bz;
  assign baseIP_d[7:0]=break_prejmp_tick & ~(jump0_in&jump0_taken) & ~(jump1_in&jump1_taken)  
      & ~break_jump0 & ~break_jump1 & ~break_exceptn & ~break_replay & !break_replayS ? baseIP[7:0] : 8'bz;
  assign baseIP_d[62:43]=break_prejmp_tick & ~(jump0_in&jump0_taken) & ~(jump1_in&jump1_taken)  
      & ~break_jump0 & ~break_jump1 & ~break_exceptn & ~break_replay & !break_replayS ? baseIP[62:43] : 20'bz;

  assign jump0_taken=(jump0Pos==4'hf) ? 1'b0 : 1'bz;
  assign jump0_flags=(jump0Pos==4'hf) ? 6'b0 : 6'bz;
  assign jump1_taken=(jump1Pos==4'hf) ? 1'b0 : 1'bz;
  assign jump1_flags=(jump1Pos==4'hf) ? 6'b0 : 6'bz;

  assign break_pending=(has_break) ? 1'bz : 1'b0;
  assign break_exceptn=(has_break) ? 1'bz : 1'b0;
  assign break_replay=(has_break) ? 1'bz : 1'b0;
  assign break_replayS=(has_break) ? 1'bz : 1'b0;
  assign break_jump0=(has_break) ? 1'bz : 1'b0;
  assign break_jump1=(has_break) ? 1'bz : 1'b0;
  
  assign flags_d=xbreak0[0] ? flags[retire_thread_reg] : 6'bz;

  assign retireG[0]=(ret[0]==4'hf) ? 1'b0 : 1'bz;
  assign retireV[0]=(ret[0]==4'hf) ? 1'b0 : 1'bz;
  assign retireF[0]=(ret[0]==4'hf) ? 1'b0 : 1'bz;
  
  assign proc_d=(jump0Type==5'h1e || jump1Type==5'h1e) ? indir_IP[15:0] : archReg_proc[retire_thread_reg];
	 
  assign bob_wdata[`bob_ret0_8]={iret8,iret7,iret6,iret5,
	 iret4,iret3,iret2,iret1,iret0};
  assign {ret[8],ret[7],ret[6],ret[5],ret[4],ret[3],ret[2],ret[1],ret[0]}=
	  bob_rdata[`bob_ret0_8];  
  
  assign bob_wdata[`bob_frr]=iret_clr;
  assign retclrP=bob_rdata[`bob_frr];

  assign bob_wdata[`bob_aspl]={instr9_after_spec,instr8_after_spec,instr7_after_spec,
     instr6_after_spec,instr5_after_spec,instr4_after_spec,instr3_after_spec,
     instr2_after_spec,instr1_after_spec,instr0_after_spec};
  assign bob_wdata[`bob_regs]={instr9_rT|{6{~instr9_wren}},instr8_rT|{6{~instr8_wren}},
         instr7_rT|{6{~instr7_wren}},instr6_rT|{6{~instr6_wren}},instr5_rT|{6{~instr5_wren}},
	 instr4_rT|{6{~instr4_wren}},instr3_rT|{6{~instr3_wren}},instr2_rT|{6{~instr2_wren}},
         instr1_rT|{6{~instr1_wren}},instr0_rT|{6{~instr0_wren}}};
  assign {rT[9],rT[8],rT[7],rT[6],rT[5],rT[4],rT[3],rT[2],rT[1],rT[0]}=
	  bob_rdata[`bob_regs];
  
  assign bob_wdata[`bob_freeregs]={iret8_rF,iret7_rF,iret6_rF,iret5_rF,
	  iret4_rF,iret3_rF,iret2_rF,iret1_rF,iret0_rF};
  assign rd_after_spec=bob_rdata[`bob_aspl];
  assign bob_wdata[`bob_attr]=instr_attr;
  assign attr=bob_rdata[`bob_attr];

  assign {retire8_rF[8:4],retire7_rF[8:4],retire6_rF[8:4],retire5_rF[8:4],
	  retire4_rF[8:4],retire3_rF[8:4],retire2_rF[8:4],retire1_rF[8:4],retire0_rF[8:4]}=
	  bob_rdata[`bob_freeregs];

  assign bob_wdata[`bob_ipOff0_9]={instr9_IPOff,instr8_IPOff,instr7_IPOff,instr6_IPOff,
	  instr5_IPOff,instr4_IPOff,instr3_IPOff,instr2_IPOff,instr1_IPOff,instr0_IPOff};
  assign {IPOff[9],IPOff[8],IPOff[7],IPOff[6],IPOff[5],IPOff[4],IPOff[3],IPOff[2],IPOff[1],IPOff[0]}=
	  bob_rdata[`bob_ipOff0_9];

  assign bob_wdata[`bob_rgen]={instr9_gen,instr8_gen,instr7_gen,instr6_gen,instr5_gen,
	  instr4_gen,instr3_gen,instr2_gen,instr1_gen,instr0_gen};
  assign bob_wdata[`bob_rvec]={instr9_vec,instr8_vec,instr7_vec,instr6_vec,instr5_vec,
	  instr4_vec,instr3_vec,instr2_vec,instr1_vec,instr0_vec};
  assign rgen=bob_rdata[`bob_rgen];
  assign rvec=bob_rdata[`bob_rvec];
 
  assign bob_wdata[`bob_afterTk]=itk_after;
  assign tk_after=bob_rdata[`bob_afterTk];

  assign bob_wdata[`bob_pred]={iJump1Taken,iJump0Taken};
  assign {jump1Pred,jump0Pred}=bob_rdata[`bob_pred];

  assign bob_wdata[`bob_attrJ0]=iJump0Attr;
  assign jump0Attr=bob_rdata[`bob_attrJ0];
  assign bob_wdata[`bob_attrJ1]=iJump1Attr;
  assign jump1Attr=bob_rdata[`bob_attrJ1];
  
  assign bob_wdata[`bob_magicO]={instr9_magic,instr8_magic,instr7_magic,instr6_magic,instr5_magic,
	  instr4_magic,instr3_magic,instr2_magic,instr1_magic,instr0_magic};
  assign {magicO[9],magicO[8],magicO[7],magicO[6],magicO[5],magicO[4],magicO[3],magicO[2],magicO[1],magicO[0]}=
	  bob_rdata[`bob_magicO];

  assign bob_wdata[`bob_last]={instr9_last,instr8_last,instr7_last,instr6_last,instr5_last,
	  instr4_last,instr3_last,instr2_last,instr1_last,instr0_last};
  assign last_instr= bob_rdata[`bob_last];
  
  assign bob_wdata[`bob_jump0Type]=ijump0Type;
  assign jump0Type=bob_rdata[`bob_jump0Type];
  assign bob_wdata[`bob_jump1Type]=ijump1Type;
  assign jump1Type=bob_rdata[`bob_jump1Type];
  assign bob_wdata[`bob_jump0Pos]=~ijump0Off;
  assign bob_wdata[`bob_mpr0_bnd]=~ijump0BND;
  assign bob_wdata[`bob_mpr1_bnd]=~ijump1BND;
  assign jump0BND=~bob_rdata[`bob_mpr0_bnd];
  assign jump1BND=~bob_rdata[`bob_mpr1_bnd];
  assign jump0Pos=~bob_rdata[`bob_jump0Pos];
  assign bob_wdata[`bob_jump1Pos]=~ijump1Off;
  assign jump1Pos=~bob_rdata[`bob_jump1Pos];
  assign bob_wdata[`bob_jump0IP]=ijump0IP;
  assign jump0IP=bob_rdata[`bob_jump0IP];
  assign bob_wdata[`bob_jump1IP]=ijump1IP;
  assign jump1IP=bob_rdata[`bob_jump1IP];
  assign bob_wdata[`bob_jump0Mask]=ijump0Mask;
  assign jump0Mask=bob_rdata[`bob_jump0Mask];
  assign bob_wdata[`bob_jump1Mask]=ijump1Mask;
  assign jump1Mask=bob_rdata[`bob_jump1Mask];

  assign bob_wdata[`bob_j0Way]=ijump0BtbWay;
  assign jump0BtbWay=bob_rdata[`bob_j0Way];
  assign bob_wdata[`bob_j1Way]=ijump1BtbWay;
  assign jump1BtbWay=bob_rdata[`bob_j1Way];
  assign bob_wdata[`bob_j0Ind]=ijump0JmpInd;
  assign jump0JmpInd=bob_rdata[`bob_j0Ind];
  assign bob_wdata[`bob_j1Ind]=ijump1JmpInd;
  assign jump1JmpInd=bob_rdata[`bob_j1Ind];
  assign bob_wdata[`bob_j0GHT]=ijump0GHT;
  assign jump0GHT=bob_rdata[`bob_j0GHT];
  assign bob_wdata[`bob_j1GHT]=ijump1GHT;
  assign jump1GHT=bob_rdata[`bob_j1GHT];

  assign bob_wdata[`bob_j0sc]=ijump0SC;
  assign jump0SC=bob_rdata[`bob_j0sc];
  assign bob_wdata[`bob_j1sc]=ijump1SC;
  assign jump1SC=bob_rdata[`bob_j1sc];
  assign bob_wdata[`bob_j0Miss]=ijump0Miss;
  assign jump0Miss=bob_rdata[`bob_j0Miss];
  assign bob_wdata[`bob_j1Miss]=ijump1Miss;
  assign jump1Miss=bob_rdata[`bob_j1Miss];
  assign bob_wdata[`bob_j0BtbOnly]=ijump0BtbOnly;
  assign jump0BtbOnly=bob_rdata[`bob_j0BtbOnly];
  assign bob_wdata[`bob_j1BtbOnly]=ijump1BtbOnly;
  assign jump1BtbOnly=bob_rdata[`bob_j1BtbOnly];

  assign bob_wdata[`bob_Fsimd]=ifsimd;
  
  assign takenIP=(jump0Pred) ? jump0IP : jump1IP;

  assign doRetire_d=~break_pending && has_some && ~init && ~mem_II_stall && indir_ready|~has_indir;

  assign has_indir=(jump0Type[4] && jump0Type[2:0]==3'b001 && jump0Pos!=4'hf) || 
    (jump1Type[4] && jump1Type[2:0]==3'b001 && jump1Pos!=4'hf);
  assign i_has_indir=(ijump0Type[4] && ijump0Type[2:0]==3'b001 && ijump0Off!=4'hf) ||
    (ijump1Type[4] && ijump1Type[2:0]==3'b001 && ijump1Off!=4'hf);

  assign indirMismatch=(takenIP!=indir_IP[43:1] || ~indir_IP[64]) && has_indir && indir_ready;

  assign except_d=has_break && ~break_pending && has_some && ~init && indir_ready|~has_indir;
  
  assign retire8_rF[3:0]=4'd8;
  assign retire7_rF[3:0]=4'd7;
  assign retire6_rF[3:0]=4'd6;
  assign retire5_rF[3:0]=4'd5;
  assign retire4_rF[3:0]=4'd4;
  assign retire3_rF[3:0]=4'd3;
  assign retire2_rF[3:0]=4'd2;
  assign retire1_rF[3:0]=4'd1;
  assign retire0_rF[3:0]=4'd0;

  assign mem_match=mem_II_upper==retire_addr_reg;
  assign mem_II_upper_out=retire_addr_reg;

  bob_ram bob_mod(
  .clk(clk),
  .read_clkEn(doRetire_d||~has_some),
  .read_addr(retire_addr), .read_data(bob_rdata),
  .write_addr(init ? initcount : new_addr), .write_data(bob_wdata&{BOB_WIDTH{~init}}), .write_wen((new_en && ~stall && ~doStall)|init)
  );

  bob_addr addr_mod(
  .clk(clk),
  .rst(rst),
  .except(except_d),
  .new_en(new_en&~except),
  .new_addr(new_addr),
  .stall(stall),
  .doStall(doStall),
  .hasRetire(has_some),
  .doRetire(doRetire_d),
  .retire_addr(retire_addr)
  );

  bob_except xcpt_mod(
  .clk(clk),
  .rst(rst),
  .read_step(doRetire_d||~has_some),
  .read_addr(retire_addr),
  .read_data0(ret_data[0]),
  .read_data1(ret_data[1]),
  .read_data2(ret_data[2]),
  .read_data3(ret_data[3]),
  .read_data4(ret_data[4]),
  .read_data5(ret_data[5]),
  .read_data6(ret_data[6]),
  .read_data7(ret_data[7]),
  .read_data8(ret_data[8]),
  .read_data9(ret_data[9]),
  
  .write0_addr(ret0_addr),.write0_data(ret0_data),.write0_wen(ret0_wen),
  .write1_addr(ret1_addr),.write1_data(ret1_data),.write1_wen(ret1_wen),
  .write2_addr(ret2_addr),.write2_data(ret2_data),.write2_wen(ret2_wen),
  .write3_addr(ret3_addr),.write3_data(ret3_data),.write3_wen(ret3_wen),
  .write4_addr(ret4_addr),.write4_data(ret4_data),.write4_wen(ret4_wen),
  .write5_addr(ret5_addr),.write5_data(ret5_data),.write5_wen(ret5_wen),
  .write6_addr(ret6_addr),.write6_data(ret6_data),.write6_wen(ret6_wen),
  .write7_addr(ret7_addr),.write7_data(ret7_data),.write7_wen(ret7_wen),
  
  .writeInit_addr(init ? initcount : new_addr),.writeInit_wen((new_en && ~stall && ~doStall)|init),
  .writeInit_data0({13'b0,instr0_en|init ? 2'd0 : 2'd2}),
  .writeInit_data1({13'b0,instr1_en|init ? 2'd0 : 2'd2}),
  .writeInit_data2({13'b0,instr2_en|init ? 2'd0 : 2'd2}),
  .writeInit_data3({13'b0,instr3_en|init ? 2'd0 : 2'd2}),
  .writeInit_data4({13'b0,instr4_en|init ? 2'd0 : 2'd2}),
  .writeInit_data5({13'b0,instr5_en|init ? 2'd0 : 2'd2}),
  .writeInit_data6({13'b0,instr6_en|init ? 2'd0 : 2'd2}),
  .writeInit_data7({13'b0,instr7_en|init ? 2'd0 : 2'd2}),
  .writeInit_data8({13'b0,instr8_en|init ? 2'd0 : 2'd2}),
  .writeInit_data9({13'b0,instr9_en|init ? 2'd0 : 2'd2})
  );

  BOBind indir_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(doRetire_d||~has_some),
  .read_addr(retire_addr),
  .read_data(indir_IP),
  .read_ready(indir_ready),
  .write_addr(init ? initcount : ret5_addr[9:4]),
  .write_data(ret5_IP & {65{~init}}),
  .write_wen(ret5_wen & ret5_IP_en || init),
  .writeI_addr(init ? initcount : new_addr),
  .writeI_ready(~i_has_indir|init),
  .writeI_wen((new_en && ~stall && ~doStall)|init)
  );
  
  cntrl_get_retcnt cret_mod({ret[8]!=4'hf,ret[7]!=4'hf,ret[6]!=4'hf,ret[5]!=4'hf,ret[4]!=4'hf,
    ret[3]!=4'hf,ret[2]!=4'hf,ret[1]!=4'hf,ret[0]!=4'hf},retcnt_d);

  adder_inc #(6) initAdd_mod(initcount,initcount_d,1'b1,);
  
  adder_inc #(43-8) baseAdd_mod(baseIP[42:8],baseIP_d[42:8],break_prejmp_tick & ~(jump0_in&jump0_taken) & 
     ~(jump1_in&jump1_taken) & ~break_exceptn,);

  bit_find_first_bit #(10) break_mod(~(done|fpudone)|jump0_misPred|jump1_misPred,break_,has_break);
  bit_find_first_bit_tail #(10) xbreak_mod(~(done|fpudone)|{jump0_misPred[8:0]|jump1_misPred[8:0],1'b0},xbreak,has_xbreak);
  bit_find_first_bit #(10) xbreak0_mod(~(done|fpudone)|{jump0_misPred[8:0]|jump1_misPred[8:0],1'b0},xbreak0,has_xbreak0);

  sc_update sc0_mod(jump0SC,jump0_taken,update_sc_j0);
  sc_update sc1_mod(jump1SC,jump1_taken,update_sc_j1);

  always @(posedge clk) begin
      if (rst) begin
	  init<=1'b1;
	  initcount<=6'b0;
      end else if (init) begin
	  initcount<=initcount_d;
	  if (initcount==6'd47) init<=1'b0;
      end
      if (rst) begin
          retire0_rT<=6'd0;
          retire1_rT<=6'd0;
          retire2_rT<=6'd0;
          retire3_rT<=6'd0;
          retire4_rT<=6'd0;
          retire5_rT<=6'd0;
          retire6_rT<=6'd0;
          retire7_rT<=6'd0;
          retire8_rT<=6'd0;
	  
	  retire0_enG<=1'b0;
	  retire1_enG<=1'b0;
	  retire2_enG<=1'b0;
	  retire3_enG<=1'b0;
	  retire4_enG<=1'b0;
	  retire5_enG<=1'b0;
	  retire6_enG<=1'b0;
	  retire7_enG<=1'b0;
	  retire8_enG<=1'b0;
	  
	  retire0_enV<=1'b0;
	  retire1_enV<=1'b0;
	  retire2_enV<=1'b0;
	  retire3_enV<=1'b0;
	  retire4_enV<=1'b0;
	  retire5_enV<=1'b0;
	  retire6_enV<=1'b0;
	  retire7_enV<=1'b0;
	  retire8_enV<=1'b0;
	  
	  retire0_enF<=1'b0;
	  retire1_enF<=1'b0;
	  retire2_enF<=1'b0;
	  retire3_enF<=1'b0;
	  retire4_enF<=1'b0;
	  retire5_enF<=1'b0;
	  retire6_enF<=1'b0;
	  retire7_enF<=1'b0;
	  retire8_enF<=1'b0;

	  retire_enFl<=1'b0;

	  doRetire<=1'b0;

	  flags[0]<=6'b0;
	  flags[1]<=6'b0;

	  jupd0_addr<=16'b0;
	  jupd1_addr<=16'b0;
	  jupd0_baddr<=13'b0;
	  jupd1_baddr<=13'b0;
	  jupd0_sc<=2'b0;
	  jupd1_sc<=2'b0;
	  jupd0_tk<=1'b0;
	  jupd1_tk<=1'b0;
	  jupd0_en<=1'b0;
	  jupdt0_en<=1'b0;
	  jupd0_ght_en<=1'b0;
	  jupd1_en<=1'b0;
	  jupdt1_en<=1'b0;
	  jupd1_ght_en<=1'b0;

	  exceptIP<=63'b0;
	  except_thread<=1'b0;
	  except_attr<=4'b0;
	  except_both<=1'b0;
	  except<=1'b0;
          except_due_jump<=1'b0;
          except_jump_ght<=8'b0;
          except_set_instr_flag<=1'b0;
          except_jmp_mask_en<=1'b0;
          except_jmp_mask<=4'hf;
          
          csrss_no<=16'b0;
          csrss_thread<=1'b0;
          csrss_en<=1'b0;
          csrss_data<=65'b0;

	  baseIP<=63'b0;

          retire_addr_reg<=6'd0;
	  
//	  retire_thread<=1'b0;
	  retire_thread_reg<=1'b0;
	  
	  retcnt<=4'd1;
          retclr<=9'b0;
          
	  archReg_xcpt_retIP[0]<=43'b0;
          archReg_xcpt_retIP[1]<=43'b0;	
//	  archReg_xcpt_code[0]<=8'b0;
//        archReg_xcpt_code[1]<=8'b0;	
	  archReg_proc[0]<=16'b0;
	  archReg_proc[1]<=16'b0;
      end else begin
          retire0_rT<=rTe[0];
          retire1_rT<=rTe[1];
          retire2_rT<=rTe[2];
          retire3_rT<=rTe[3];
          retire4_rT<=rTe[4];
          retire5_rT<=rTe[5];
          retire6_rT<=rTe[6];
          retire7_rT<=rTe[7];
          retire8_rT<=rTe[8];
	  
	  
	  retire0_enG<=doRetire_d && retireG[0];
	  retire1_enG<=doRetire_d && retireG[1];
	  retire2_enG<=doRetire_d && retireG[2];
	  retire3_enG<=doRetire_d && retireG[3];
	  retire4_enG<=doRetire_d && retireG[4];
	  retire5_enG<=doRetire_d && retireG[5];
	  retire6_enG<=doRetire_d && retireG[6];
	  retire7_enG<=doRetire_d && retireG[7];
	  retire8_enG<=doRetire_d && retireG[8];
	  
	  retire0_enV<=doRetire_d && retireV[0];
	  retire1_enV<=doRetire_d && retireV[1];
	  retire2_enV<=doRetire_d && retireV[2];
	  retire3_enV<=doRetire_d && retireV[3];
	  retire4_enV<=doRetire_d && retireV[4];
	  retire5_enV<=doRetire_d && retireV[5];
	  retire6_enV<=doRetire_d && retireV[6];
	  retire7_enV<=doRetire_d && retireV[7];
	  retire8_enV<=doRetire_d && retireV[8];
	  
	  retire0_enF<=doRetire_d && retireF[0];
	  retire1_enF<=doRetire_d && retireF[1];
	  retire2_enF<=doRetire_d && retireF[2];
	  retire3_enF<=doRetire_d && retireF[3];
	  retire4_enF<=doRetire_d && retireF[4];
	  retire5_enF<=doRetire_d && retireF[5];
	  retire6_enF<=doRetire_d && retireF[6];
	  retire7_enF<=doRetire_d && retireF[7];
	  retire8_enF<=doRetire_d && retireF[8];

	  retire_enFl<=lfl_has && doRetire_d;

	  doRetire<=doRetire_d;

	  if (doRetire_d) flags[retire_thread_reg]<=flags_d;

	  jupd0_addr<=update_ght_addr_j0;
          jupd1_addr<=update_ght_addr_j1;
	  jupd0_baddr<=update_btb_addr_j0;
          jupd1_baddr<=update_btb_addr_j1;
	  jupd0_sc<=update_sc_j0;
	  jupd1_sc<=update_sc_j1;
	  jupd0_tk<=jump0_taken;
	  jupd1_tk<=jump1_taken;
	  jupd0_en<=jump0_in & ~jump0Miss & doRetire_d;
	  //jupdt0_en<=
	  jupd0_ght_en<=jump0_in & ~jump0Miss & ~jump0BtbOnly & doRetire_d;
	  jupd1_en<=jump1_in & ~jump1Miss & doRetire_d;
	  //jupdt1_en<=
	  jupd1_ght_en<=jump1_in & ~jump1Miss & ~jump1BtbOnly & doRetire_d;

	  exceptIP<={exceptIP_d};
          //except_thread<=except_thread_d;
	  except_attr<=except_attr_d;
	  //except_both<=except_both_d;
	  except<=except_d;
          except_due_jump<=break_jump0|break_jump1 && except_d;
          if (doRetire_d && jump0_in) except_jump_ght<=jump1_in ? {jump1GHT[6:0],jump1_taken} : {jump0GHT[6:0],jump0_taken};
          except_set_instr_flag<=break_replay&!break_replayS;
          except_jmp_mask_en<=(break_jump0 | break_jump1) && except_d;
          except_jmp_mask<=break_jump0 ? jump0JMask : jump1JMask;

          csrss_no<=csrss_no_d;
          //csrss_thread<=except_thread_d;
          csrss_en<=csrss_en_d;
          csrss_data<=csrss_data_d;

	  if (doRetire_d) baseIP<=baseIP_d;
	  if (doRetire_d||~has_some) retire_addr_reg<=retire_addr;

	  //if (both_threads) retire_thread<=~retire_thread;
	  //else retire_thread<=thread1;
	  //
	  //retire_thread_reg<=retire_thread;
	  retcnt<=(doRetire_d&~init) ? retcnt_d : 4'd1;
	  retclr<={9{doRetire_d&~init}} & retclrP;

          if (break_exceptn && has_some && indir_ready) begin
	      archReg_xcpt_retIP[retire_thread_reg]<=breakIP;	
//	      archReg_xcpt_code[retire_thread_reg]<=excpt_code;	
          end
      end
  end
  
endmodule

