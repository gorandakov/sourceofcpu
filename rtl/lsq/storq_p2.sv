`include "../struct.sv"


module storq_p2(
  clk,
  rst,
  stall,
  doStall,
  aStall,
  aDoStall,
  lStall,
  lDoStall,
  bStall,
  rDoStall,
  newI_alloc,
  newII_upper,newII_req,
  except,
  excpt_thread,
  new_data_shr,
  new_dataA0,new_enA0,
  new_dataA1,new_enA1,
  new_dataA2,new_enA2,
  new_dataA3,new_enA3,
  new_dataA4,new_enA4,
  new_dataA5,new_enA5,
  new_en,new_enP,
  new_thr,
  new_confl,

  ret_has_ldst,
  ret_data_shr,
  ret_mask,
  ret_retire,

  new_conflictx,
  new_conflicty,
  new_conflictA,p1_new_conflictA_b,new_conflictA_has,
  new_conflictB,p1_new_conflictB_b,new_conflictB_has,
  lstep1_owndataA,
  lstep1_owndataB,
  new_conflict2_acc,
  p1_nChNextA0,p1_nChNextA1,p1_nChNextA2,
  p0_insh_addr0,p0_insh_addr1,p0_insh_addr2,
  new_en_reg,new_en_reg2,new_enP_reg,new_enP_reg2,p1_peek_aStall,
  confl_first,confl_last,confl_cnt,
  free_maskM012,free_maskN012,
  cur_pos,cur_posh,wrt_indexA0,wrt_indexA1,wrt_indexA2

  ); 
  localparam DATA_WIDTH=`lsaddr_width;
  localparam SDATA_WIDTH=`lsqshare_width;
  localparam BUF_COUNT=32; 
  input clk;
  input rst;
  input stall;
  output doStall;
  input aStall;
  output aDoStall;
  input lStall;
  input lDoStall;
  input bStall;
  output rDoStall;
  input [2:0] newI_alloc;
  input [5:0] newII_upper;
  input newII_req;
  input except;
  input excpt_thread;
  input [SDATA_WIDTH-1:0] new_data_shr;
  input [DATA_WIDTH-1:0] new_dataA0;
  input new_enA0;
  input [DATA_WIDTH-1:0] new_dataA1;
  input new_enA1;
  input [DATA_WIDTH-1:0] new_dataA2;
  input new_enA2;
  input [DATA_WIDTH-1:0] new_dataA3;
  input new_enA3;
  input [DATA_WIDTH-1:0] new_dataA4;
  input new_enA4;
  input [DATA_WIDTH-1:0] new_dataA5;
  input new_enA5;
  input new_en,new_enP;
  input new_thr;
  output [5:0] new_confl;
  

  input ret_has_ldst;
  input [SDATA_WIDTH-1:0] ret_data_shr;
  input [9:0] ret_mask;
  input ret_retire;
  
  output [3*BUF_COUNT-1:0] new_conflictx;
  output [3*BUF_COUNT-1:0] new_conflicty;
//  output [3*BUF_COUNT-1:0] p1_new_conflictAp;
//  output [3*BUF_COUNT-1:0] p1_new_conflictBp;
  output [3*BUF_COUNT-1:0] new_conflictA;
  output [11:0] p1_new_conflictA_b;
  output [2:0] new_conflictA_has;
  output [3*BUF_COUNT-1:0] new_conflictB;
  output [11:0] p1_new_conflictB_b;
  output [2:0] new_conflictB_has;
  output [DATA_WIDTH-1:0] lstep1_owndataA;
  output [DATA_WIDTH-1:0] lstep1_owndataB;
  output [3*BUF_COUNT-1:0] new_conflict2_acc;
  output [BUF_COUNT-1:0] p1_nChNextA0;
  output [BUF_COUNT-1:0] p1_nChNextA1;
  output [BUF_COUNT-1:0] p1_nChNextA2;
  input [4:0] p0_insh_addr0;
  input [4:0] p0_insh_addr1;
  input [4:0] p0_insh_addr2;

/*  output [9:0] wret_II0;
  output wret_en0;
  output [9:0] wret_II1;
  output wret_en1;
  */
  input new_en_reg,new_en_reg2;
  input new_enP_reg,new_enP_reg2;
  input p1_peek_aStall;
  output [5:0] confl_first;
  output [5:0] confl_last;
  output [6:0] confl_cnt;
  input [3*BUF_COUNT-1:0] free_maskM012;
  input [3*BUF_COUNT-1:0] free_maskN012;
  input [2:0] cur_pos;
  input [2:0] cur_posh;
  input [2:0] wrt_indexA0;
  input [2:0] wrt_indexA1;
  input [2:0] wrt_indexA2;

  wire [2:0] cur_posh;
  wire [3:0] wroet_cnt;
  wire [2:0] wroet_en;
  reg [2:0] wroet_en_reg;
  reg [2:0] cur_pos;


  wire [4:0] ins_addr[2:0];

  reg [4:0] insh_addr[2:0];
  wire [2:0] posh_en;


  wire [BUF_COUNT-1:0] free_maskM[2:0];
  wire [BUF_COUNT-1:0] free_maskN[2:0];
  reg [BUF_COUNT-1:0] free_maskM_reg[2:0];
  reg [BUF_COUNT-1:0] free_maskN_reg[2:0];
  reg [BUF_COUNT-1:0] free_maskM_reg2[2:0];
  reg [BUF_COUNT-1:0] free_maskN_reg2[2:0];
  wire [2:0] pos_en;
  wire [5:0][DATA_WIDTH-1:0] new_dataA;
  wire [5:0] new_enA={new_enA5,new_enA4,new_enA3,new_enA2,new_enA1,new_enA0};
  reg [5:0] new_enA_reg;
  reg  [DATA_WIDTH-1:0] new_dataA_chk[5:0];
  reg  [DATA_WIDTH-1:0] new_dataA_chk_reg[5:0];
 // wire [5:0] new_dataA_unal;
 // wire [9:0] free_need_instrB[2:0];
  wire [2:0][2:0] wrt_indexA;
  wire [2:0][2:0] pos_indexA;
  reg [2:0] wrt_indexA_reg[2:0];
  reg [2:0] pos_indexA_reg[2:0];
//  wire [2:0] wrt_en;
//  reg [2:0] wrt_en_reg;
//  wire [3:0] wrt_cnt;

  reg [5:0] new_confl_reg;
  wire [5:0] new_confl_ex;
  reg [5:0] new_en_mask;
  reg [5:0] new_en_mask0;
  reg [9:0] ret_wait;

  wire [3*BUF_COUNT-1:0] new_conflict_exx;
 
  wire [5:0][3*BUF_COUNT-1:0] new_conflict_ex;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict1;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict2;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict1p;
  //wire [5:0][3*BUF_COUNT-1:0] new_conflict2p;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict1q;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict2q;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict1r;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict2r;
  wire [5:0][3:0] new_conflict1p_b0;
//  wire [5:0][3:0] new_conflict2p_b0;
  wire [5:0][3:0] new_conflict1p_b1;
//  wire [5:0][3:0] new_conflict2p_b1;
  wire [5:0][3:0] new_conflict1p_b2;
//  wire [5:0][3:0] new_conflict2p_b2;
  wire [3*BUF_COUNT-1:0] new_conflictA;
  wire [3*BUF_COUNT-1:0] new_conflictB;
  wire [3*BUF_COUNT-1:0] new_conflictAp;
  wire [3*BUF_COUNT-1:0] new_conflictBp;
  wire [3*BUF_COUNT-1:0] new_conflictAq;
  wire [3*BUF_COUNT-1:0] new_conflictBq;
  wire [3*BUF_COUNT-1:0] new_conflictx;
  wire [3*BUF_COUNT-1:0] new_conflicty;
  wire [2:0][3:0] new_conflictA_b;
  wire [2:0][3:0] new_conflictB_b;
  reg [3*BUF_COUNT-1:0] new_conflict1_reg[5:0];
  reg [3*BUF_COUNT-1:0] new_conflict2_reg[5:0];
  reg [3*BUF_COUNT-1:0] new_conflict1_acc;
  reg [3*BUF_COUNT-1:0] new_conflict2_acc;
  wire [6:0] confl_cnt;
  wire [5:0] confl_first;
  wire [5:0] confl_last;
  wire [5:0] new_conflict_has1r;
  wire [5:0] new_conflict_has2r;
  wire [2:0] new_conflict_has1p[5:0];
//  wire [2:0] new_conflict_has2p[5:0];
  wire [2:0] new_conflictA_has;
  wire [2:0] new_conflictB_has;
  wire [2:0] newAQEn;
  wire [2:0] newBQEn;
  reg [2:0] on_M;
  reg [2:0] on_M_reg;
 // reg [3*BUF_COUNT-1:0] new_conflictAp_reg;
 // reg [3*BUF_COUNT-1:0] new_conflictBp_reg;
  //wire [1:0] lstep1_multi;
  //wire lstep1_allow;
  wire [DATA_WIDTH-1:0] lstep1_owndataA;
  wire [DATA_WIDTH-1:0] lstep1_owndataB;
//  wire lstep1_undoA;
//  wire lstep1_undoB;
 // reg lstep1_undoA_reg;
 // reg lstep1_undoB_reg;
  
//  wire lstep2_undoA;
//  wire lstep2_undoB;
//  reg lstep2_undoA_reg;
 // reg lstep2_undoB_reg;
  reg [1:0] lstep1_invd_acc;
  wire lDoNext_Aq0;
  wire lDoNext_Bq0; 
  //reg lstep2_multiA_reg,lstep2_multiB_reg;

  reg confl_waited;
  reg [5:0] new_c_mask;
 // wire lDoStall_Aq;
 // wire lDoStall_Bq;
 // wire lDoStall_Aq0;
 // wire lDoStall_Bq0;
  wire [2+1 :0] lDoNext_Aq1;
  wire [1+ 2:0] lDoNext_Bq1;
  reg  [1:0] lDoNext_Aq1R;
  reg  [1:0] lDoNext_Bq1R;
  wire lStFirst;
  reg lStFirst_pause; 
  wire free_on0,free_on1,free_on2; 
  wire free_on0A,free_on1A,free_on2A; 
  wire [2:0][BUF_COUNT-1:0] nChNextA ;
  wire [3*BUF_COUNT-1:0] nChNextB ;
 // wire [2:0] nChNextAx;
 // wire [2:0] nChNextBx;
  
  reg [9:0] wret_II0_reg;
  reg wret_en0_reg;
  reg [9:0] wret_II1_reg;
  reg wret_en1_reg;

  wire [4:0] std_bankA0;
  wire [4:0] std_bankB0;

  wire [2:0][BUF_COUNT-1:0] ins_addr_bit;
  reg [BUF_COUNT-1:0] ins_addr_bit_reg[2:0];
  
  wire [2:0][BUF_COUNT-1:0] ret_hit;
  wire [2:0][9:0] pos_iimask;

  wire [1:0] lstep1_invd;
  reg [1:0] lstep1_invd_reg;
  reg [1:0] lstep1_invd_reg2;
  wire [1:0] out_invd;
  wire [1:0] out_invd2;

  wire lstep2A_validA;
  wire lstep2A_validB;

  wire [2:0][BUF_COUNT-1:0] newII_chk;
  integer b;
  wire newII_stall;
 /// wire lDoStall_inv0;

  //reg lDoStall_reg;

/*  function [3:0] bank_reorder;
      input [3:0] banks;
      input [4:0] bank0;
      case(bank0[1:0])
      2'd0: bank_reorder=banks;
      2'd1: bank_reorder={banks[0],banks[3:1]};
      2'd2: bank_reorder={banks[1:0],banks[3:2]};
      2'd3: bank_reorder={banks[2:0],banks[3]};
      endcase
  endfunction*/
//  popcnt3_or_more retcnt_mod(ret_mask_store,retcnt_more);
  function [3:0] fsz;
    input [4:0] sz;
    case(sz)
         5'd16: fsz=0;
         5'd17: fsz=1;
         5'd18: fsz=2;
         5'd19: fsz=3;
         5'h3:  fsz=4; //long double
         5'h0,5'h1,5'h2: fsz=5;
         5'hc,5'hd,5'he:  fsz=5; //int, double, single 128 bit (a)
         5'h4,5'h5,5'h6: fsz=2; //singleE,single,singleD
         5'h8,5'h9,5'ha:  fsz=3; //doubleE, double, singlePairD
         5'hf:fsz=6;
         default: fsz=3;
    endcase

  endfunction

  function [3:0] bnmask;
      input [1:0] low;
      input [4:0] sz;
      input [4:0] bgn;
     // reg stepOver;
     // reg stepOver2;
      reg [3:0] ops=fsz(sz);
      begin
          bnmask=1;
          bnmask[1]=ops==3 || ops[2];
	  bnmask[2]=ops[2];
	  bnmask[3]=ops==5 || ops==6;
      end 
  endfunction
  generate
    genvar t,c,p,n1,n2;
    for(t=0;t<6;t=t+1) begin : aport_gen
     //   bit_find_last_bit #(3*BUF_COUNT) confl1Bit_mod(new_conflict1_reg[t],new_conflict1r[t],new_conflict_has1r[t]);
     //   bit_find_last_bit #(3*BUF_COUNT) confl2Bit_mod(new_conflict2_reg[t],new_conflict2r[t],new_conflict_has2r[t]);
     //   bit_find_last_bit #(3*BUF_COUNT) confl1rBit_mod(new_conflict1r[t],new_conflict1rr[t],new_conflict_has1rr[t]);
     //   bit_find_last_bit #(3*BUF_COUNT) confl2rBit_mod(new_conflict2r[t],new_conflict2rr[t],new_conflict_has2rr[t]);
        
        
        
       storq_genaddr gdr_mod(
       .conflictM(new_conflict2_reg[t]),
       .conflictN(new_conflict1_reg[t]),
       .bit0(new_conflict1p[t][0*BUF_COUNT+:BUF_COUNT]),.bank0(new_conflict1p_b0[t]),.has0(new_conflict_has1p[t][0]),
       .bit1(new_conflict1p[t][1*BUF_COUNT+:BUF_COUNT]),.bank1(new_conflict1p_b1[t]),.has1(new_conflict_has1p[t][1]),
       .bit2(new_conflict1p[t][2*BUF_COUNT+:BUF_COUNT]),.bank2(new_conflict1p_b2[t]),.has2(new_conflict_has1p[t][2]),
//  bit,
//  on_M,
       .multi()
       ); 
        //assign conflict_first=(confl_first[t]) ? new_conflict_reg[t] : {3*BUF_COUNT{1'BZ}};
        //assign conflict_last=(confl_last[t]) ? new_conflict_reg[t] : {3*BUF_COUNT{1'BZ}};
        assign new_confl[t]=(|new_conflict[t]) || (|new_conflict_ex[t]);
   //     assign lstep1_multi[0]=(confl_first[t] &  new_conflict_has1r[t]) ? 0!=(~new_conflict1r[t]&new_conflict1_reg[t]) : 1'bz;
   //     assign lstep1_multi[0]=(confl_first[t] & ~new_conflict_has1r[t]) ? 0!=(~new_conflict2r[t]&new_conflict2_reg[t]) : 1'bz;
   //     assign lstep1_multi[1]=(confl_last[t] &  new_conflict_has1r[t]) ? 0!=(~new_conflict1r[t]&new_conflict1_reg[t]) : 1'bz;
   //     assign lstep1_multi[1]=(confl_last[t] & ~new_conflict_has1r[t]) ? 0!=(~new_conflict2r[t]&new_conflict2_reg[t]) : 1'bz;
        
        assign new_conflictA[0*BUF_COUNT+:3*BUF_COUNT]=(confl_first[t]) ? new_conflict1p[t][0*BUF_COUNT+:3*BUF_COUNT] : {3*BUF_COUNT{1'bz}};
        assign new_conflictB[0*BUF_COUNT+:3*BUF_COUNT]=(confl_last[t])  ? new_conflict1p[t][0*BUF_COUNT+:3*BUF_COUNT] : {3*BUF_COUNT{1'bz}};
        
        
	assign new_conflictA_b[0]=(confl_first[t]) ? new_conflict1p_b0[t] : 4'bz;
        assign new_conflictB_b[0]=(confl_last[t]) ? new_conflict1p_b0[t] : 4'bz;
        
	assign new_conflictA_b[1]=(confl_first[t]) ? new_conflict1p_b1[t] : 4'bz;
        assign new_conflictB_b[1]=(confl_last[t]) ? new_conflict1p_b1[t] : 4'bz;
        
	assign new_conflictA_b[2]=(confl_first[t]) ? new_conflict1p_b2[t] : 4'bz;
        assign new_conflictB_b[2]=(confl_last[t]) ? new_conflict1p_b2[t] : 4'bz;
        
        assign new_conflictA_has=(confl_first[t]) ? new_conflict_has1p[t] : 3'bz;
        assign new_conflictB_has=(confl_last[t]) ? new_conflict_has1p[t] : 3'bz;
        

        assign lstep1_owndataA=(confl_first[t]) ? new_dataA_chk_reg[t] : {DATA_WIDTH{1'BZ}};
        assign lstep1_owndataB=(confl_last[t] ) ? new_dataA_chk_reg[t] : {DATA_WIDTH{1'BZ}};

        assign new_conflictx=(confl_first[t]) ? new_conflict1q[t]|new_conflict2q[t] : {3*BUF_COUNT{1'BZ}};
        assign new_conflicty=(confl_last[t]) ? new_conflict1q[t]|new_conflict2q[t] : {3*BUF_COUNT{1'BZ}};

        if (t!=0) storq_check_same_clk #(t) clk_chk_mod(
        .dataA0(new_dataA_chk[0]),.dataEnA0(new_enA_reg[0]&new_c_mask[0]),
        .dataA1(new_dataA_chk[1]),.dataEnA1(new_enA_reg[1]&new_c_mask[1]),
        .dataA2(new_dataA_chk[2]),.dataEnA2(new_enA_reg[2]&new_c_mask[2]),
        .dataA3(new_dataA_chk[3]),.dataEnA3(new_enA_reg[3]&new_c_mask[3]),
        .dataA4(new_dataA_chk[4]),.dataEnA4(new_enA_reg[4]&new_c_mask[4]),
        .dataA5(new_dataA_chk[5]),.dataEnA5(new_enA_reg[5]&new_c_mask[5]),
        .ind0(pos_indexA[0]),.bits0(ins_addr_bit[0]&~new_conflict2_acc[31:0]&~nChNextA[0]),
        .ind1(pos_indexA[1]),.bits1(ins_addr_bit[1]&~new_conflict2_acc[63:32]&~nChNextA[1]),
        .ind2(pos_indexA[2]),.bits2(ins_addr_bit[2]&~new_conflict2_acc[95:64]&~nChNextA[2]),
        .last_wrt(),
        .has_wrt(new_confl_ex[t]),
        .bits(new_conflict_ex[t])
        );
        else begin
            assign new_confl_ex[t]=new_dataA_chk[0][`lsaddr_flag] & ~new_dataA_chk[0][`lsaddr_st] & new_enA_reg[0]; 
            assign new_conflict_ex[t]=96'b0;
        end
    end
    for(p=0;p<10;p=p+1) begin
        assign pos_iimask[0][p]=pos_dataA[0][`lsaddr_II_low]==p;
        assign pos_iimask[1][p]=pos_dataA[1][`lsaddr_II_low]==p;
        assign pos_iimask[2][p]=pos_dataA[2][`lsaddr_II_low]==p;
    end
    for(c=0;c<3;c=c+1) begin : store_mod
      
        bit_find_first_bit #(32) lastM_mod(~free[c]&free_maskM[c],free_lastM[c],has_freeM[c]);
        bit_find_first_bit #(32) lastN_mod(~free[c]&free_maskN[c],free_lastN[c],has_freeN[c]);

        bit_find_first_bit #(4) lastMB_mod({|(~free[c][31:24]&free_maskM[c][31:24]),
          |(~free[c][23:16]&free_maskM[c][23:16]),|(~free[c][15:8]&free_maskM[c][15:8]),
          |(~free[c][7:0]&free_maskM[c][7:0])},free_lastM_bank[c],);
        bit_find_first_bit #(4) lastNB_mod({|(~free[c][31:24]&free_maskN[c][31:24]),
          |(~free[c][23:16]&free_maskN[c][23:16]),|(~free[c][15:8]&free_maskN[c][15:8]),
          |(~free[c][7:0]&free_maskN[c][7:0])},free_lastN_bank[c],);

        
	
        assign new_conflict_exx=new_conflict_ex[0]|new_conflict_ex[1]|new_conflict_ex[2]
            |new_conflict_ex[3]|new_conflict_ex[4]|new_conflict_ex[5];	
      
 	assign pos_indexA[c]=cur_posh[c] ? wrt_indexA_reg[0] : 3'BZ;
        assign pos_indexA[c]=cur_posh[(c+2)%3] ? wrt_indexA_reg[1] : 3'BZ;
        assign pos_indexA[c]=cur_posh[(c+1)%3] ? wrt_indexA_reg[2] : 3'BZ;

        assign free_maskM012[c*BUF_COUNT+:BUF_COUNT]=free_maskM[c];
        assign free_maskN012[c*BUF_COUNT+:BUF_COUNT]=free_maskN[c];

        
 
      
        for(n1=0;n1<BUF_COUNT;n1=n1+1) begin
            for(n2=0;n2<6;n2=n2+1) begin
                assign new_conflict1[n2][n1*3+c]=new_conflict[n2][BUF_COUNT*c+n1]& free_maskN[c][n1]
                  || new_conflict_ex[n2][BUF_COUNT*c+n1] &~on_M[c];
                assign new_conflict2[n2][n1*3+c]=new_conflict[n2][BUF_COUNT*c+n1]& free_maskM[c][n1]
                  || new_conflict_ex[n2][BUF_COUNT*c+n1] &on_M[c];
                assign new_conflict1q[n2][BUF_COUNT*c+n1]=new_conflict1_reg[n2][n1*3+c];
                assign new_conflict2q[n2][BUF_COUNT*c+n1]=new_conflict2_reg[n2][n1*3+c];
            end
            assign nChNextB[n1*3+c]=nChNextA[c][n1];
            assign new_conflictAq[BUF_COUNT*c+n1]=new_conflictAp[n1*3+c];
            assign new_conflictBq[BUF_COUNT*c+n1]=new_conflictBp[n1*3+c];
            assign ins_addr_bit[c][n1]=insh_addr[c]==n1 && posh_en[c];
        end

    end

  endgenerate
  
  assign newII_stall=(|newII_chk[0]) || (|newII_chk[1]) || (|newII_chk[2]);


//  assign s_lstep2_dataA=lstep2A_cnHasA!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
//  assign s_lstep2_dataB=lstep2A_cnHasB!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  
  assign lstep1_owndataA=(!confl_cnt[0]) ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign lstep1_owndataB=(confl_cnt[1:0]==0) ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  
  assign wrt_indexA[0]=wrt_indexA0;
  assign wrt_indexA[1]=wrt_indexA1;
  assign wrt_indexA[2]=wrt_indexA2;
  
  assign new_dataA[0]=new_dataA0;
  assign new_dataA[1]=new_dataA1;
  assign new_dataA[2]=new_dataA2;
  assign new_dataA[3]=new_dataA3;
  assign new_dataA[4]=new_dataA4;
  assign new_dataA[5]=new_dataA5;

  assign insh_addr[0]=p0_insh_addr0;
  assign insh_addr[1]=p0_insh_addr1;
  assign insh_addr[2]=p0_insh_addr2;
        

  assign new_conflictAp=confl_cnt[0] ? {3*BUF_COUNT{1'b0}} : {3*BUF_COUNT{1'bz}};
  assign new_conflictBp=confl_cnt[1:0]!=0 ? {3*BUF_COUNT{1'b0}} : {3*BUF_COUNT{1'bz}};
  
  assign new_conflictx[0*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflicty[0*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictx[1*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflicty[1*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictx[2*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflicty[2*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  
  assign new_conflictA[0*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictB[0*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictA[1*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictB[1*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictA[2*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictB[2*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictA_b[0]=confl_cnt[0] ? 4'b0 : 4'bz;
  assign new_conflictB_b[0]=confl_cnt[1:0]!=0 ? 4'b0 : 4'bz;
  assign new_conflictA_b[1]=confl_cnt[0] ? 4'b0 : 4'bz;
  assign new_conflictB_b[1]=confl_cnt[1:0]!=0 ? 4'b0 : 4'bz;
  assign new_conflictA_b[2]=confl_cnt[0] ? 4'b0 : 4'bz;
  assign new_conflictB_b[2]=confl_cnt[1:0]!=0  ? 4'b0 : 4'bz;
  assign new_conflictA_has[0]=confl_cnt[0] ? 1'b0 : 1'bz;
  assign new_conflictB_has[0]=confl_cnt[1:0]!=0  ? 1'b0 : 1'bz;
  assign new_conflictA_has[1]=confl_cnt[0] ? 1'b0 : 1'bz;
  assign new_conflictB_has[1]=confl_cnt[1:0]!=0  ? 1'b0 : 1'bz;
  assign new_conflictA_has[2]=confl_cnt[0] ? 1'b0 : 1'bz;
  assign new_conflictB_has[2]=confl_cnt[1:0]!=0  ? 1'b0 : 1'bz;
 

  assign lstep1_invd[0]=new_conflictA_has==0;
  assign lstep1_invd[1]=new_conflictB_has==0;
  assign out_invd=lstep1_invd_reg2;

  assign p1_new_conflictA_b[3:0]= new_conflictA_b[0];
  assign p1_new_conflictA_b[7:4]= new_conflictA_b[1];
  assign p1_new_conflictA_b[11:8]=new_conflictA_b[2];

  assign p1_new_conflictB_b[3:0]= new_conflictB_b[0];
  assign p1_new_conflictB_b[7:4]= new_conflictB_b[1];
  assign p1_new_conflictB_b[11:8]=new_conflictB_b[2];

  assign p1_nChNextA0=nChNextA[0];
  assign p1_nChNextA1=nChNextA[1];
  assign p1_nChNextA2=nChNextA[2];

  popcnt6 ccnt_mod(new_confl_reg,confl_cnt);

  bit_find_first_bit #(6) firstC_mod(new_confl_reg,confl_first,);
  bit_find_first_bit #(6) lastC_mod(new_confl_reg&~confl_first,confl_last,);
  
  always @(posedge clk) begin
 //   if (std_hasB0 && &std_mOpB) $display("XX");
    if (rst) begin
        for(b=0;b<6;b=b+1) begin
            new_dataA_chk_reg[b]<={DATA_WIDTH{1'B0}};
	    end
    end else if (new_enP_reg & ~aStall & ~aDoStall) begin
        for(b=0;b<6;b=b+1) begin
            new_dataA_chk_reg[b]<=new_dataA_chk[b];//move to other block??
        end
    end
    if (rst) begin
        new_c_mask=6'h3f;
    end else if (~aStall && ~aDoStall) begin
        if (new_en_reg) new_c_mask=6'h3f;
        else begin
            new_c_mask[0]=new_c_mask[0] && ~new_enA_reg[0]|~new_dataA_chk[0][`lsaddr_st];
            new_c_mask[1]=new_c_mask[1] && ~new_enA_reg[1]|~new_dataA_chk[1][`lsaddr_st];
            new_c_mask[2]=new_c_mask[2] && ~new_enA_reg[2]|~new_dataA_chk[2][`lsaddr_st];
            new_c_mask[3]=new_c_mask[3] && ~new_enA_reg[3]|~new_dataA_chk[3][`lsaddr_st];
            new_c_mask[4]=new_c_mask[4] && ~new_enA_reg[4]|~new_dataA_chk[4][`lsaddr_st];
            new_c_mask[5]=new_c_mask[5] && ~new_enA_reg[5]|~new_dataA_chk[5][`lsaddr_st];
        end
    end
    if (rst) lStFirst_pause<=1'b0;
    else if (~lDoStall) lStFirst_pause<=1'b0;
    else lStFirst_pause<=lStFirst_pause|~lStFirst;

    if (rst) begin
	new_en_mask0<=6'b0;
    end else begin
	if (new_en & ~aStall & ~aDoStall || except) new_en_mask0<=6'b0;
	else if (new_enP & ~aStall & ~aDoStall) new_en_mask0<=new_enA;
    end
    if (rst) begin
        for(b=0;b<6;b=b+1) begin
            new_dataA_chk[b]<={DATA_WIDTH{1'B0}};
        if (b<3) wrt_dataA_reg[b]<={DATA_WIDTH{1'B0}};
        if (b<3) wrt_indexA_reg[b]<=3'B0;
        new_enA_reg<=6'b0;
        end
    end else if (except&&excpt_thread==new_thr) begin
	new_enA_reg<=6'b0;
    end else if (new_enP & ~aStall & ~aDoStall) begin
        for(b=0;b<6;b=b+1) begin
            new_dataA_chk[b]<=new_dataA[b];
            if (~new_dataA[b][`lsaddr_split] & ~new_dataA[b][`lsaddr_odd])
                new_dataA_chk[b][`lsaddr_addrO]<=new_dataA_chk[b][`lsaddr_addrO];
            if (~new_dataA[b][`lsaddr_split] & new_dataA[b][`lsaddr_odd])wrt_indexA
                new_dataA_chk[b][`lsaddr_addrE]<=new_dataA_chk[b][`lsaddr_addrE];
        if (b<3) wrt_dataA_reg[b]<=wrt_dataA[b];
        if (b<3) wrt_indexA_reg[b]<=wrt_indexA[b];
        new_enA_reg<=new_enA;
        end
    end else if (~aStall && ~aDoStall) begin
	new_enA_reg<=6'b0;
    end
    if (rst) begin
        cur_pos<=3'b1;
    if (rst) begin
        new_confl_reg<=6'b0;
        on_M_reg<=3'b0;
        new_en_mask<=6'b0;
        for(b=0;b<6;b=b+1) begin
            new_conflict1_reg[b]<={3*BUF_COUNT{1'B0}};
            new_conflict2_reg[b]<={3*BUF_COUNT{1'B0}};
          //  if (b<3) free_maskM_reg[b]<={BUF_COUNT{1'B0}};
           // if (b<3) free_maskN_reg[b]<={BUF_COUNT{1'B1}};
            //if (b<3) pos_indexA_reg[b]<=3'h0;
            //if (b<3) ins_addr_bit_reg[b]<={BUF_COUNT{1'B0}};
        end
        new_conflict1_acc<=96'b0;
        new_conflict2_acc<=96'b0;
        confl_waited<=1'b0;

    end else if ((except && excpt_thread==new_thr_reg)) begin
        for(b=0;b<6;b=b+1) begin
            new_conflict1_reg[b]<=96'b0;
            new_conflict2_reg[b]<=96'b0;
        end
        new_conflict1_acc<=96'b0;
        new_conflict2_acc<=96'b0;
	new_confl_reg<=6'b0;
	new_en_mask<=6'b0;
	confl_waited<=1'b0;
    end else if ((~lStall && ~lDoStall)) begin

            if (confl_cnt[6:3]!=0) begin
                 if (new_en_reg2) new_confl_reg<=new_confl_reg&~confl_first&~confl_last;
	         else  begin
                     new_confl_reg<=(new_confl_reg&~confl_first&~confl_last) | ((new_confl|new_confl_ex)&~new_en_mask);
                     new_en_mask<=new_enA_reg; 
	         end
                 confl_waited<=new_en_reg2;
	    end  else if (new_en_reg2 || new_enP_reg & (~new_enP_reg2|confl_waited) begin
                 new_confl_reg<=new_confl|new_confl_ex;
                 new_en_mask<=new_enA_reg;
                 confl_waited<=1'b0;
            end else if (new_enP_reg)  begin
                 new_confl_reg<=(new_confl_reg&~confl_first&~confl_last) | ((new_confl|new_confl_ex)&~new_en_mask);
                 new_en_mask<=new_enA_reg; 
            end else begin
                 new_confl_reg<=6'b0;
                 new_en_mask<=6'b0;
            end
            on_M_reg<=on_M;        
            if (new_en_reg && confl_cnt[6:3]==0) new_conflict1_acc<=96'b0;
	         else if (new_enP_reg) new_conflict1_acc<=new_conflict1_acc|nChNextB;
            if (new_en_reg && confl_cnt[6:3]==0) new_conflict2_acc<=96'b0;
	        else if (new_enP_reg) new_conflict2_acc<=new_conflict2_acc|{nChNextA[2],nChNextA[1],nChNextA[0]};//1 on p1
            for(b=0;b<6;b=b+1) begin
                new_conflict1_reg[b]<=new_conflict1[b]&~{nChNextB}&~new_conflict1_acc;
                new_conflict2_reg[b]<=new_conflict2[b]&~{nChNextB}&~new_conflict1_acc;
           //     if (b<3) free_maskM_reg[b]<=free_maskM[b]|({32{on_M[b]}}&new_conflict_exx[b*32+:32]);
           //     if (b<3) free_maskN_reg[b]<=free_maskN[b]|({32{~on_M[b]}}&new_conflict_exx[b*32+:32]);
            end
    end else begin
        new_conflict1_acc<=new_conflict1_acc|{nChNextB};
        new_conflict2_acc<=new_conflict2_acc|{nChNextA[2],nChNextA[1],nChNextA[0]};
    end

    
  end
endmodule

