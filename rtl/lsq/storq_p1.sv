`include "../struct.sv"




module storq_p1(
  clk,
  rst,
  lStall,
  lDoStall,
 // bStall,
 // rDoStall,
//  aStall,
  except,
  excpt_thread,
  new_conflictx,
  new_conflicty,
//  new_conflictAp,
//  new_conflictBp,
  new_conflictA,new_conflictA_b,new_conflictA_has,
  new_conflictB,new_conflictB_b,new_conflictB_has,
  m_mask,n_mask,
  lstep1_owndataA,
  lstep1_owndataB,
  new_conflict1_acc,
  nChNextA0,nChNextA1,nChNextA2,
  ins_addr0,pos_dataA0,pos_en0,
  ins_addr1,pos_dataA1,pos_en1,
  ins_addr2,pos_dataA2,pos_en2,
//  wret_II0,wret_en0,
//  wret_II1,wret_en1,
  new_en_reg2,new_enP_reg2,peek_aStall,
  confl_first,confl_last,confl_cnt,chmo_bolotnoe2,
  std_addrA0,std_addrA1,  
  std_addrB0,std_addrB1,  
  
  std_byBankA0,std_MexactA0,std_MshiftA0,std_banksA0,std_hasA0,
  std_byBankA1,std_MexactA1,std_MshiftA1,std_banksA1,std_hasA1,

  std_byBankB0,std_MexactB0,std_MshiftB0,std_banksB0,std_hasB0,
  std_byBankB1,std_MexactB1,std_MshiftB1,std_banksB1,std_hasB1,


  std_mOpA,std_mOpB//,

//  ret_has_ldst,
//  ret_data_shr,
//  ret_mask,
//  ret_retire
  ); 
  localparam DATA_WIDTH=`lsaddr_width;
  localparam SDATA_WIDTH=`lsqshare_width;
  localparam BUF_COUNT=32; 
  input clk;
  input rst;
  input lStall;
  output lDoStall;
 // input bStall;
 // input rDoStall;
  //input aStall;
  input except;
  input excpt_thread;
  input [3*BUF_COUNT-1:0] new_conflictx;
  input [3*BUF_COUNT-1:0] new_conflicty;
//  input [3*BUF_COUNT-1:0] new_conflictAp;
//  input [3*BUF_COUNT-1:0] new_conflictBp;
  input [3*BUF_COUNT-1:0] new_conflictA;
  input [11:0] new_conflictA_b;
  input [2:0] new_conflictA_has;
  input [3*BUF_COUNT-1:0] new_conflictB;
  input [11:0] new_conflictB_b;
  input [2:0] new_conflictB_has;
  input [3*BUF_COUNT-1:0] m_mask;
  input [3*BUF_COUNT-1:0] n_mask;
  input [DATA_WIDTH-1:0] lstep1_owndataA;
  input [DATA_WIDTH-1:0] lstep1_owndataB;
  input [3*BUF_COUNT-1:0] new_conflict1_acc;
  input [BUF_COUNT-1:0] nChNextA0;
  input [BUF_COUNT-1:0] nChNextA1;
  input [BUF_COUNT-1:0] nChNextA2;
  input [4:0] ins_addr0;
  input [DATA_WIDTH-1:0] pos_dataA0;
  input pos_en0;
  input [4:0] ins_addr1;
  input [DATA_WIDTH-1:0] pos_dataA1;
  input pos_en1;
  input [4:0] ins_addr2;
  input [DATA_WIDTH-1:0] pos_dataA2;
  input pos_en2;

/*  input [9:0] wret_II0;
  input wret_en0;
  input [9:0] wret_II1;
  input wret_en1;
  */
  input new_en_reg2;
  input new_enP_reg2;
  output reg peek_aStall;
  input [5:0] confl_first;
  input [5:0] confl_last;
  input [6:0] confl_cnt;
  input chmo_bolotnoe2;

  output [7:0] std_addrA0;
  output [7:0] std_addrA1;
  output [7:0] std_addrB0;
  output [7:0] std_addrB1;

  output std_byBankA0;
  output std_MexactA0;
  output [4:0] std_MshiftA0;
  output [3:0] std_banksA0;
  output std_hasA0;
  output std_byBankA1;
  output std_MexactA1;
  output [4:0] std_MshiftA1;
  output [3:0] std_banksA1;
  output std_hasA1;

  output std_byBankB0;
  output std_MexactB0;
  output [4:0] std_MshiftB0;
  output [3:0] std_banksB0;
  output std_hasB0;
  output std_byBankB1;
  output std_MexactB1;
  output [4:0] std_MshiftB1;
  output [3:0] std_banksB1;
  output std_hasB1;

  output [DATA_WIDTH-1:0] std_mOpA;
  output [DATA_WIDTH-1:0] std_mOpB;

 /* input ret_has_ldst;
  input [SDATA_WIDTH-1:0] ret_data_shr;
  input [9:0] ret_mask;
  input ret_retire;*/

 // reg [2:0] wrt_en;
  reg new_en_reg3;
  reg new_enP_reg3;
  wire new_thr_reg3=1'b0;

  reg [5:0] new_II_reg;
  reg [5:0] new_II_reg2;
  reg [5:0] new_II_reg3;
  reg [5:0] new_II_reg4;

  wire aDoStall=1'b0;

  reg [BUF_COUNT-1:0] free_maskM_reg2[2:0];
  reg [BUF_COUNT-1:0] free_maskN_reg2[2:0];
 // wire [5:0] new_dataA_unal;
 // wire [9:0] free_need_instrB[2:0];

  
  wire [2:0] stallone;

  reg [5:0] new_confl_reg;
  wire [5:0] new_confl_ex;
  reg [5:0] new_en_mask;
  reg [5:0] new_en_mask0;
  reg [9:0] ret_wait;

  wire [3:0][3*BUF_COUNT-1:0] pch_conflict;
  wire [3*BUF_COUNT-1:0] new_conflict_exx;
  wire new_thr_reg2=1'b0;
   
//  wire [3*BUF_COUNT-1:0] new_conflictA;
//  wire [3*BUF_COUNT-1:0] new_conflictB;
//  wire [3*BUF_COUNT-1:0] new_conflictAp;
//  wire [3*BUF_COUNT-1:0] new_conflictBp;
  wire [3*BUF_COUNT-1:0] new_conflictAq;
  wire [3*BUF_COUNT-1:0] new_conflictBq;
//  wire [3*BUF_COUNT-1:0] new_conflictx;
//  wire [3*BUF_COUNT-1:0] new_conflicty;
//  wire [2:0][3:0] new_conflictA_b;
//  wire [2:0][3:0] new_conflictB_b;
//  reg [3*BUF_COUNT-1:0] new_conflict1_reg[5:0];
//  reg [3*BUF_COUNT-1:0] new_conflict2_reg[5:0];
//  reg [3*BUF_COUNT-1:0] new_conflict1_acc;
//  reg [3*BUF_COUNT-1:0] new_conflict2_acc;
  wire [6:0] confl_cnt;
  wire [5:0] confl_first;
  wire [5:0] confl_last;
  //wire [5:0] new_conflict_has1r;
  //wire [5:0] new_conflict_has2r;
  //wire [2:0] new_conflict_has1p[5:0];
  //wire [2:0] new_conflict_has2p[5:0];
  //wire [2:0] new_conflictA_has;
  //wire [2:0] new_conflictB_has;
  wire [2:0] newAQEn;
  wire [2:0] newBQEn;
  reg [2:0] on_M;
  reg [2:0] on_M_reg;
  reg [6:0] confl_cnt_reg;
  reg [6:0] confl_cnt_reg2;
  reg [5:0] confl_first_reg;
  reg [5:0] confl_last_reg;
  reg [5:0] confl_first_reg2;
  reg [5:0] confl_last_reg2;
 // reg [3*BUF_COUNT-1:0] new_conflictAp_reg;
 // reg [3*BUF_COUNT-1:0] new_conflictBp_reg;
  reg [3*BUF_COUNT-1:0] new_conflictAq_reg;
  reg [3*BUF_COUNT-1:0] new_conflictBq_reg;
  reg [3*BUF_COUNT-1:0] new_conflictAq_reg2;
  reg [3*BUF_COUNT-1:0] new_conflictBq_reg2;
  reg [3*BUF_COUNT-1:0] new_conflictx_reg;
  reg [3*BUF_COUNT-1:0] new_conflicty_reg;
  reg [3*BUF_COUNT-1:0] new_conflictx_reg2;
  reg [3*BUF_COUNT-1:0] new_conflicty_reg2;
  reg [3*BUF_COUNT-1:0] new_conflictx_acc;
  reg [3*BUF_COUNT-1:0] new_conflicty_acc;
  reg [3*BUF_COUNT-1:0] new_conflictx_acc2;
  reg [3*BUF_COUNT-1:0] new_conflicty_acc2;
  //wire [1:0] lstep1_multi;
  //wire lstep1_allow;
  wire [DATA_WIDTH-1:0] lstep1_dataA;
  wire [DATA_WIDTH-1:0] lstep1_dataB;
  wire [DATA_WIDTH-1:0] lstep1_owndataA;
  wire [DATA_WIDTH-1:0] lstep1_owndataB;
  reg [DATA_WIDTH-1:0] lstep1_dataA_reg;
  reg [DATA_WIDTH-1:0] lstep1_dataB_reg;
  reg [DATA_WIDTH-1:0] lstep1_owndataA_reg;
  reg [DATA_WIDTH-1:0] lstep1_owndataB_reg;
  reg [DATA_WIDTH-1:0] lstep1_dataA_reg2;
  reg [DATA_WIDTH-1:0] lstep1_dataB_reg2;
  reg [DATA_WIDTH-1:0] lstep1_owndataA_reg2;
  reg [DATA_WIDTH-1:0] lstep1_owndataB_reg2;
  wire [2:0][DATA_WIDTH-1:0] lstep1_ldataA;
  wire [2:0][DATA_WIDTH-1:0] lstep1_ldataB;
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
  wire [DATA_WIDTH-1:0] lstep2_dataA;
  wire [DATA_WIDTH-1:0] lstep2_dataB;
  reg [DATA_WIDTH-1:0] lstep2_dataA_reg;
  reg [DATA_WIDTH-1:0] lstep2_dataB_reg;
  wire [2:0][DATA_WIDTH-1:0] lstep2_ldataA;
  wire [2:0][DATA_WIDTH-1:0] lstep2_ldataB;

  wire [2:0][BUF_COUNT-1:0] lstep2_cnBitA;
  wire [2:0][3:0]           lstep2_cnBankA;
  wire [2:0]           lstep2_cnHasA;
  wire [2:0][BUF_COUNT-1:0] lstep2_cnBitB;
  wire [2:0][3:0]           lstep2_cnBankB;
  wire [2:0]           lstep2_cnHasB;
  wire lstep2_multiA,lstep2_multiB;
  //reg lstep2_multiA_reg,lstep2_multiB_reg;
  wire [3:0] lstep2_banks0;
  wire [3:0] lstep2_banksO0;
  wire lstep2_Mexact0;
  wire lstep2_byBank0;
  wire [4:0] lstep2_Mshift0;
  wire [3:0] lstep2_banks1;
  wire [3:0] lstep2_banksO1;
  wire lstep2_Mexact1;
  wire lstep2_byBank1;
  wire [4:0] lstep2_Mshift1;
  wire [3*BUF_COUNT-1:0] lstep2_conflictA;
  wire [3*BUF_COUNT-1:0] lstep2_conflictB;

  reg [2:0]             lstep2_cnHasA_reg;
  reg [2:0]             lstep2_cnHasB_reg;
  reg [BUF_COUNT-1:0] lstep2_cnBitA_reg[2:0];
  reg [BUF_COUNT-1:0] lstep2_cnBitB_reg[2:0];
  reg [3:0] lstep2_banks0_reg;
  reg [3:0] lstep2_banksO0_reg;
  reg [3:0] lstep2_banksX0_reg;
  reg lstep2_Mexact0_reg;
  reg lstep2_byBank0_reg;
  reg [4:0] lstep2_Mshift0_reg;
  reg [3:0] lstep2_banks1_reg;
  reg [3:0] lstep2_banksO1_reg;
  reg [3:0] lstep2_banksX1_reg;
  reg lstep2_Mexact1_reg;
  reg lstep2_byBank1_reg;
  reg [4:0] lstep2_Mshift1_reg;
  reg lstep2_validA_reg;
  reg lstep2_validB_reg;
  wire lstep2_validA;
  wire lstep2_validB;
  wire [3:0] lstep2_bnmask0;
  wire [3:0] lstep2_bnmask1;
  reg [3:0] lstep2_bnmask0_reg;
  reg [3:0] lstep2_bnmask1_reg;
  
  wire [3:0] lstep3_banks0;
  wire [3:0] lstep3_banksO0;
  wire lstep3_Mexact0;
  wire lstep3_byBank0;
  wire [4:0] lstep3_Mshift0;
  wire [3:0] lstep3_banks1;
  wire [3:0] lstep3_banksO1;
  wire lstep3_Mexact1;
  wire lstep3_byBank1;
  wire [4:0] lstep3_Mshift1;
  
  reg lstep1_validA,lstep1_validB;
  reg confl_waited;
  
  reg chmo_balotnoe; //inhibits double fire of write-back

  wire [3*BUF_COUNT-1:0] lstep2A_conflictA;
  wire [3*BUF_COUNT-1:0] lstep2A_conflictB;
  wire [2:0][BUF_COUNT-1:0] lstep2A_cnBitA;
  wire [2:0][3:0]           lstep2A_cnBankA;
  wire [2:0]           lstep2A_cnHasA;
  wire [2:0][BUF_COUNT-1:0] lstep2A_cnBitB;
  wire [2:0][3:0]           lstep2A_cnBankB;
  wire [2:0]           lstep2A_cnHasB;
  wire lstep2A_multiA,lstep2A_multiB;
  wire [2:0][DATA_WIDTH-1:0] lstep2A_ldataA;
  wire [2:0][DATA_WIDTH-1:0] lstep2A_ldataB;
  wire [DATA_WIDTH-1:0] S_lstep1_dataA;
  wire [DATA_WIDTH-1:0] S_lstep1_dataB;
  wire [2:0] S_newAQEn;
  wire [2:0] S_newBQEn;
  wire [DATA_WIDTH-1:0] s_lstep2_dataA;
  wire [DATA_WIDTH-1:0] s_lstep2_dataB;
  
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
  wire [2:0][BUF_COUNT-1:0] nChNextA ;
  wire [3*BUF_COUNT-1:0] nChNextB ;
 // wire [2:0] nChNextAx;
 // wire [2:0] nChNextBx;
  

  wire [4:0] std_bankA0;
  wire [4:0] std_bankB0;

  wire [4:0] ins_addr[2:0];
  wire [DATA_WIDTH-1:0] pos_dataA[2:0];
  wire [2:0] pos_en;

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
    for(c=0;c<3;c=c+1) begin : store_mod
      


        lsw_array lsw_mod(
        clk,
        rst,
        lstep2A_ldataA[c],lstep2A_cnBitA[c],lstep2A_cnBankA[c],lstep2A_cnHasA[c],
        lstep2A_ldataB[c],lstep2A_cnBitB[c],lstep2A_cnBankB[c],lstep2A_cnHasB[c],
        lstep2_ldataA[c],lstep2_cnBitA[c],lstep2_cnBankA[c],lstep2_cnHasA[c],
        lstep2_ldataB[c],lstep2_cnBitB[c],lstep2_cnBankB[c],lstep2_cnHasB[c],
        lstep1_ldataA[c],new_conflictA[c*BUF_COUNT+:BUF_COUNT],new_conflictA_b[c*4+:4],new_conflictA_has[c],
        lstep1_ldataB[c],new_conflictB[c*BUF_COUNT+:BUF_COUNT],new_conflictB_b[c*4+:4],new_conflictB_has[c],

        ins_addr[c],pos_dataA[c],pos_en[c]
        );
            
        assign lstep2_conflictA[BUF_COUNT*c+:BUF_COUNT]=
            new_conflictx_reg[c*BUF_COUNT+:BUF_COUNT]&~new_conflictAq_reg[c*BUF_COUNT+:BUF_COUNT];
        assign lstep2_conflictB[BUF_COUNT*c+:BUF_COUNT]=
            new_conflicty_reg[c*BUF_COUNT+:BUF_COUNT]&~new_conflictBq_reg[c*BUF_COUNT+:BUF_COUNT];
        assign lstep2A_conflictA[BUF_COUNT*c+:BUF_COUNT]=
            new_conflictx_reg2[c*BUF_COUNT+:BUF_COUNT]&~new_conflictAq_reg2[c*BUF_COUNT+:BUF_COUNT]
            &~lstep2_cnBitA_reg[c]&~new_conflictx_acc2[c*BUF_COUNT+:BUF_COUNT];
        assign lstep2A_conflictB[BUF_COUNT*c+:BUF_COUNT]=
            new_conflicty_reg2[c*BUF_COUNT+:BUF_COUNT]&~new_conflictBq_reg2[c*BUF_COUNT+:BUF_COUNT]
            &~lstep2_cnBitB_reg[c]&~new_conflicty_acc2[c*BUF_COUNT+:BUF_COUNT];

        assign newAQEn[c]=|new_conflictAq[c*BUF_COUNT+:BUF_COUNT];
        assign newBQEn[c]=|new_conflictBq[c*BUF_COUNT+:BUF_COUNT];

        assign lstep1_dataA=newAQEn[c] ? lstep1_ldataA[c] : {DATA_WIDTH{1'BZ}};
        assign lstep1_dataB=newBQEn[c] ? lstep1_ldataB[c] : {DATA_WIDTH{1'BZ}};

        assign S_newAQEn[c]=lstep2_cnHasA[c];
        assign S_newBQEn[c]=lstep2_cnHasB[c];

        assign S_lstep1_dataA=S_newAQEn[c] ? lstep2_ldataA[c] : {DATA_WIDTH{1'BZ}};
        assign S_lstep1_dataB=S_newBQEn[c] ? lstep2_ldataB[c] : {DATA_WIDTH{1'BZ}};
        
        assign lstep2_dataA=lstep2_cnHasA[c] ? lstep2_ldataA[c] : {DATA_WIDTH{1'BZ}};
        assign lstep2_dataB=lstep2_cnHasB[c] ? lstep2_ldataB[c] : {DATA_WIDTH{1'BZ}};
        
 //       assign s_lstep2_dataA=lstep2A_cnHasA[c] ? lstep2A_ldataA[c] : {DATA_WIDTH{1'BZ}};
 //       assign s_lstep2_dataB=lstep2A_cnHasB[c] ? lstep2A_ldataB[c] : {DATA_WIDTH{1'BZ}};
	
       
      
        for(n1=0;n1<BUF_COUNT;n1=n1+1) begin
            assign nChNextB[n1*3+c]=nChNextA[c][n1];
            assign new_conflictAq[BUF_COUNT*c+n1]=new_conflictA[BUF_COUNT*c+n1];
            assign new_conflictBq[BUF_COUNT*c+n1]=new_conflictB[BUF_COUNT*c+n1];
        end

    end

  endgenerate
  

  assign lstep1_dataA=new_conflictA_has!=0 ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign lstep1_dataB=new_conflictB_has!=0 ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};

  assign S_lstep1_dataA=S_newAQEn!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign S_lstep1_dataB=S_newAQEn!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
 
  assign lstep2_dataA=lstep2_cnHasA!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign lstep2_dataB=lstep2_cnHasB!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};

//  assign s_lstep2_dataA=lstep2A_cnHasA!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
//  assign s_lstep2_dataB=lstep2A_cnHasB!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  
//  assign lstep1_owndataA=(!confl_cnt[0]) ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
//  assign lstep1_owndataB=(confl_cnt[1:0]==0) ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  

  assign lstep2_bnmask0=bnmask(lstep1_owndataA_reg[`lsaddr_low],lstep1_owndataA_reg[`lsaddr_sz],
    lstep1_owndataA_reg[`lsaddr_bank0]);
  assign lstep2_bnmask1=bnmask(lstep1_owndataB_reg[`lsaddr_low],lstep1_owndataB_reg[`lsaddr_sz],
      lstep1_owndataB_reg[`lsaddr_bank0]);
        
//  assign lDoStall_Aq=new_conflictAq_reg&{nChNextA[2],nChNextA[1],nChNextA[0]}&&~lstep1_invd_reg[0];
//  assign lDoStall_Bq=new_conflictBq_reg&{nChNextA[2],nChNextA[1],nChNextA[0]}&&~lstep1_invd_reg[1];
//  assign lDoStall_Aq0=new_conflictAq&{nChNextA[2],nChNextA[1],nChNextA[0]}&&~lstep1_invd[0];
//  assign lDoStall_Bq0=new_conflictBq&{nChNextA[2],nChNextA[1],nChNextA[0]}&&~lstep1_invd[1];
/*  assign lDoStall_cnA0={lstep2_cnBitA[2],lstep2_cnBitA[1],lstep2_cnBitA[0]}&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0;
  assign lDoStall_cnB0={lstep2_cnBitB[2],lstep2_cnBitB[1],lstep2_cnBitB[0]}&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0;
  assign ilDoStall_cnA1={lstep2_cnBitA_reg[2],lstep2_cnBitA_reg[1],lstep2_cnBitA_reg[0]}&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0;
  assign ilDoStall_cnB1={lstep2_cnBitB_reg[2],lstep2_cnBitB_reg[1],lstep2_cnBitB_reg[0]}&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0; */
  assign lDoNext_Aq1[0]=(({lstep2_cnBitA_reg[2],lstep2_cnBitA_reg[1],lstep2_cnBitA_reg[0]}&
	  ({nChNextA[2],nChNextA[1],nChNextA[0]}))!=96'b0 && lstep2_validA_reg); 
  assign lDoNext_Aq1[1]=((new_conflictAq_reg2                   &
	  ({nChNextA[2],nChNextA[1],nChNextA[0]}))!=96'b0 && lstep2_validA_reg); 
  assign lDoNext_Aq1[2]=((new_conflictAq_reg2                   &
	  ({nChNextA[2],nChNextA[1],nChNextA[0]}))!=96'b0 && ~lstep2_validA_reg); 
  assign lDoNext_Aq1[3]=(new_conflictx_reg2         &
	  ~({nChNextA[2],nChNextA[1],nChNextA[0]}))==96'b0;
  
  assign lDoNext_Bq1[0]=(({lstep2_cnBitB_reg[2],lstep2_cnBitB_reg[1],lstep2_cnBitB_reg[0]}&
	  ({nChNextA[2],nChNextA[1],nChNextA[0]}))!=96'b0 && lstep2_validB_reg); 
  assign lDoNext_Bq1[1]=((new_conflictBq_reg2                   &
	  ({nChNextA[2],nChNextA[1],nChNextA[0]}))!=96'b0 && lstep2_validB_reg); 
  assign lDoNext_Bq1[2]=((new_conflictBq_reg2                   &
	  ({nChNextA[2],nChNextA[1],nChNextA[0]}))!=96'b0 && ~lstep2_validB_reg); 
  assign lDoNext_Bq1[3]=(new_conflicty_reg2         &
	  ~({nChNextA[2],nChNextA[1],nChNextA[0]}))==96'b0;
  
  
  assign lDoNext_Aq0=((new_conflictAq_reg&{nChNextA[2],nChNextA[1],nChNextA[0]})!=96'b0 && ~lstep2_validA);
  assign lDoNext_Bq0=((new_conflictBq_reg&{nChNextA[2],nChNextA[1],nChNextA[0]})!=96'b0 && ~lstep2_validB);
  
//  assign lDoStall_A1=new_conflictAq_req2&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0

  assign lDoStall=
    ((~(lstep2_banks0_reg|lstep3_banks0)&lstep2_bnmask0_reg)!=0 
    && lstep2_byBank0_reg && lstep3_byBank0 && lstep2A_validA)&~out_invd[0] ||

      !(lstep2_Mexact0_reg||lstep2_byBank0_reg & ~lstep2_validA_reg || ~lstep1_validA || out_invd[0])
    || (lstep1_owndataA_reg2[`lsaddr_mtype]==2'b10 && lstep1_validA && ~out_invd[0])
    || ((~(lstep2_banks1_reg|lstep3_banks1)&lstep2_bnmask1_reg)!=0 
    && lstep2_byBank1_reg && lstep3_byBank1 && lstep2A_validB)&~out_invd[1] ||

      !(lstep2_Mexact1_reg||lstep2_byBank1_reg & ~lstep2_validB_reg || ~lstep1_validB || out_invd[1])
    || (lstep1_owndataB_reg2[`lsaddr_mtype]==2'b10 && lstep1_validB && ~out_invd[1]);

  assign lStFirst=
    ((~(lstep2_banks0_reg|lstep3_banks0)&lstep2_bnmask0_reg)!=0 
    && lstep2_byBank0_reg && lstep3_byBank0 && lstep2A_validA)&~out_invd[0] ||

      !(lstep2_Mexact0_reg||lstep2_byBank0_reg & ~lstep2_validA_reg || ~lstep1_validA || out_invd[0])
    || (lstep1_owndataA_reg2[`lsaddr_mtype]==2'b10 && lstep1_validA && ~out_invd[0]);


  
 
/*  assign lstep1_undoA=(lstep1_dataA[`lsaddr_II]==wret_II0 && wret_en0) ||
    (lstep1_dataA[`lsaddr_II]==wret_II1 && wret_en1);
  assign lstep1_undoB=(lstep1_dataB[`lsaddr_II]==wret_II0 && wret_en0) ||
    (lstep1_dataB[`lsaddr_II]==wret_II1 && wret_en1);

  assign lstep2_undoA=(lstep2_dataA[`lsaddr_II]==wret_II0_reg && wret_en0_reg) ||
    (lstep2_dataA[`lsaddr_II]==wret_II1_reg && wret_en1_reg) ||
    (lstep2_dataA[`lsaddr_II]==wret_II0 && wret_en0) ||
    (lstep2_dataA[`lsaddr_II]==wret_II1 && wret_en1);
  assign lstep2_undoB=(lstep2_dataB[`lsaddr_II]==wret_II0_reg && wret_en0_reg) ||
    (lstep2_dataB[`lsaddr_II]==wret_II1_reg && wret_en1_reg) ||
    (lstep2_dataB[`lsaddr_II]==wret_II0 && wret_en0) ||
    (lstep2_dataB[`lsaddr_II]==wret_II1 && wret_en1);*/
/*
  assign free_lastNG=(free_lastN[0][31]|free_lastN[1][31]|free_lastN[2][31]) && 
    (free_lastN[0][0]|free_lastN[1][0]|free_lastN[2][0]) ?
    32'h8000_0000 : free_lastNG0;
*/
  assign ins_addr[0]=ins_addr0;
  assign pos_dataA[0]=pos_dataA0;
  assign ins_addr[1]=ins_addr1;
  assign pos_dataA[1]=pos_dataA1;
  assign ins_addr[2]=ins_addr2;
  assign pos_dataA[2]=pos_dataA2;
  assign pos_en={pos_en2,pos_en1,pos_en0};
  assign nChNextA[0]=nChNextA0;
  assign nChNextA[1]=nChNextA1;
  assign nChNextA[2]=nChNextA2;

  assign std_addrA0=lstep1_dataA_reg2[`lsaddr_WQ];
  assign std_addrA1=lstep2_dataA_reg[`lsaddr_WQ];
  assign std_addrB0=lstep1_dataB_reg2[`lsaddr_WQ];
  assign std_addrB1=lstep2_dataB_reg[`lsaddr_WQ];
  //assign std_lowA0=lstep1_owndataA_reg2[`lsaddr_low];
  //assign std_lowB0=lstep1_owndataB_reg2[`lsaddr_low];
  //assign std_other_lowA0=lstep1_dataA_reg2[`lsaddr_low];
  //assign std_other_lowA1=lstep2_dataA_reg[`lsaddr_low];
 // assign std_other_lowB0=lstep1_dataB_reg2[`lsaddr_low];
 // assign std_other_lowB1=lstep2_dataB_reg[`lsaddr_low];
  assign std_bankA0=lstep1_owndataA_reg2[`lsaddr_bank0];
  assign std_bankB0=lstep1_owndataB_reg2[`lsaddr_bank0];
//  assign std_other_bankA0=lstep1_dataA_reg2[`lsaddr_bank0];
//  assign std_other_bankA1=lstep2_dataA_reg[`lsaddr_bank0];
//  assign std_other_bankB0=lstep1_dataB_reg2[`lsaddr_bank0];
//  assign std_other_bankB1=lstep2_dataB_reg[`lsaddr_bank0];
 
  assign std_byBankA0=lstep2_byBank0_reg & ~out_invd[0];
  assign std_MexactA0=lstep2_Mexact0_reg & ~out_invd[0];
  assign std_MshiftA0=lstep2_Mshift0_reg;
  assign std_banksA0=lstep2_banksO0_reg;
  assign std_byBankA1=lstep3_byBank0;
  assign std_MexactA1=lstep3_Mexact0;
  assign std_MshiftA1=lstep3_Mshift0;
  assign std_banksA1=lstep3_banksO0;

  assign std_byBankB0=lstep2_byBank1_reg & ~out_invd[1];
  assign std_MexactB0=lstep2_Mexact1_reg & ~out_invd[1];
  assign std_MshiftB0=lstep2_Mshift1_reg;
  assign std_banksB0=lstep2_banksO1_reg;
  assign std_byBankB1=lstep3_byBank1;
  assign std_MexactB1=lstep3_Mexact1;
  assign std_MshiftB1=lstep3_Mshift1;
  assign std_banksB1=lstep3_banksO1;

  assign std_hasA1=lstep2_cnHasA_reg!=0 && ~confl_cnt_reg2[0] && ~lStFirst && ~lStFirst_pause && ~lStall && ~out_invd[0];
  assign std_hasB1=lstep2_cnHasB_reg!=0 && (confl_cnt_reg2[1:0]==0) && ~lDoStall && ~lStall && ~out_invd[1];
  assign std_hasA0=~confl_cnt_reg2[0] && ~lStFirst && ~lStFirst_pause && ~lStall && ~chmo_balotnoe; 
  assign std_hasB0=(confl_cnt_reg2[1:0]==0) && ~lDoStall && ~lStall;

  assign std_mOpA=lstep1_owndataA_reg2;
  assign std_mOpB=lstep1_owndataB_reg2;

// sederas pedesar
  assign lstep2_validA=|lstep2_cnHasA; 
  assign lstep2_validB=|lstep2_cnHasB; 
  assign lstep2A_validA=|lstep2A_cnHasA; 
  assign lstep2A_validB=|lstep2A_cnHasB; 

  assign lstep1_invd[0]=new_conflictA_has==0;
  assign lstep1_invd[1]=new_conflictB_has==0;
  assign out_invd=lstep1_invd_reg2;

  lsf_compare1 lstep1_cmp1(
  .old_data(lstep1_owndataA_reg),
  .chk_data(lstep1_dataA_reg),
  .banks0(lstep2_banks0),.banksX0(lstep2_banksO0),.Mexact(lstep2_Mexact0),
     .byBank(lstep2_byBank0),.Mshift(lstep2_Mshift0)
  );
  lsf_compare1 lstep1_cmp2(
  .old_data(lstep1_owndataB_reg),
  .chk_data(lstep1_dataB_reg),
  .banks0(lstep2_banks1),.banksX0(lstep2_banksO1),.Mexact(lstep2_Mexact1),
     .byBank(lstep2_byBank1),.Mshift(lstep2_Mshift1)
  );
  lsf_compare1 lstep2_cmp1(
  .old_data(lstep1_owndataA_reg2),
  .chk_data(lstep2_dataA_reg),
  .banks0(lstep3_banks0),.banksX0(lstep3_banksO0),.Mexact(lstep3_Mexact0),
     .byBank(lstep3_byBank0),.Mshift(lstep3_Mshift0)
  );
  lsf_compare1 lstep2_cmp2(
  .old_data(lstep1_owndataB_reg2),
  .chk_data(lstep2_dataB_reg),
  .banks0(lstep3_banks1),.banksX0(lstep3_banksO1),.Mexact(lstep3_Mexact1),
     .byBank(lstep3_byBank1),.Mshift(lstep3_Mshift1)
  );

  storq_genaddr lstep2_stgenA_mod(
  .conflictM(lstep2_conflictA & {free_maskM_reg2[2],free_maskM_reg2[1],free_maskM_reg2[0]}),
  .conflictN(lstep2_conflictA & {free_maskN_reg2[2],free_maskN_reg2[1],free_maskN_reg2[0]}),
  .bit0(lstep2_cnBitA[0]),.bank0(lstep2_cnBankA[0]),.has0(lstep2_cnHasA[0]),
  .bit1(lstep2_cnBitA[1]),.bank1(lstep2_cnBankA[1]),.has1(lstep2_cnHasA[1]),
  .bit2(lstep2_cnBitA[2]),.bank2(lstep2_cnBankA[2]),.has2(lstep2_cnHasA[2]),
  .multi(lstep2_multiA)
  );
  
  storq_genaddr lstep2_stgenB_mod(
  .conflictM(lstep2_conflictB & {free_maskM_reg2[2],free_maskM_reg2[1],free_maskM_reg2[0]}),
  .conflictN(lstep2_conflictB & {free_maskN_reg2[2],free_maskN_reg2[1],free_maskN_reg2[0]}),
  .bit0(lstep2_cnBitB[0]),.bank0(lstep2_cnBankB[0]),.has0(lstep2_cnHasB[0]),
  .bit1(lstep2_cnBitB[1]),.bank1(lstep2_cnBankB[1]),.has1(lstep2_cnHasB[1]),
  .bit2(lstep2_cnBitB[2]),.bank2(lstep2_cnBankB[2]),.has2(lstep2_cnHasB[2]),
  .multi(lstep2_multiB)
  );

  storq_genaddr lstep2A_stgenA_mod(
  .conflictM(lstep2A_conflictA & {free_maskM_reg2[2],free_maskM_reg2[1],free_maskM_reg2[0]}),
  .conflictN(lstep2A_conflictA & {free_maskN_reg2[2],free_maskN_reg2[1],free_maskN_reg2[0]}),
  .bit0(lstep2A_cnBitA[0]),.bank0(lstep2A_cnBankA[0]),.has0(lstep2A_cnHasA[0]),
  .bit1(lstep2A_cnBitA[1]),.bank1(lstep2A_cnBankA[1]),.has1(lstep2A_cnHasA[1]),
  .bit2(lstep2A_cnBitA[2]),.bank2(lstep2A_cnBankA[2]),.has2(lstep2A_cnHasA[2]),
  .multi(lstep2A_multiA)
  );

  storq_genaddr lstep2A_stgenB_mod(
  .conflictM(lstep2A_conflictB & {free_maskM_reg2[2],free_maskM_reg2[1],free_maskM_reg2[0]}),
  .conflictN(lstep2A_conflictB & {free_maskN_reg2[2],free_maskN_reg2[1],free_maskN_reg2[0]}),
  .bit0(lstep2A_cnBitB[0]),.bank0(lstep2A_cnBankB[0]),.has0(lstep2A_cnHasB[0]),
  .bit1(lstep2A_cnBitB[1]),.bank1(lstep2A_cnBankB[1]),.has1(lstep2A_cnHasB[1]),
  .bit2(lstep2A_cnBitB[2]),.bank2(lstep2A_cnBankB[2]),.has2(lstep2A_cnHasB[2]),
  .multi(lstep2A_multiB)
  );


  always @(posedge clk) begin
    if (std_hasB0 && &std_mOpB) $display("XX");
    if (rst) lStFirst_pause<=1'b0;
    else if (~lDoStall) lStFirst_pause<=1'b0;
    else lStFirst_pause<=lStFirst_pause|~lStFirst;
    if (rst) peek_aStall<=1'b1;
    else if ((~lStall & ~lDoStall || peek_aStall) && new_enP_reg2) 
        peek_aStall<=1'b0;
    else if ((~lStall & ~lDoStall || peek_aStall) && ~new_enP_reg2)
        peek_aStall<=1'b1;

    if (rst) begin
        confl_first_reg<=6'b0;
        confl_last_reg<=6'b0;
        confl_cnt_reg<=7'b1;
        new_conflictAq_reg<=0;
        new_conflictBq_reg<=0;
        new_conflictx_acc<=96'b0;
        new_conflicty_acc<=96'b0;
        new_conflictx_reg<=96'b0;
        new_conflicty_reg<=96'b0;
        lstep1_dataA_reg<=0;
        lstep1_dataB_reg<=0;
        lstep1_owndataA_reg<=0;
        lstep1_owndataB_reg<=0;
        lstep1_dataA_reg2<=0;
        lstep1_dataB_reg2<=0;
        lstep1_invd_reg<=2'b0;
     //   lstep2_validA<=1'b0;
      //  lstep2_validB<=1'b0;
        free_maskN_reg2[0]<=32'b0;
        free_maskN_reg2[1]<=32'b0;
        free_maskN_reg2[2]<=32'b0;
        free_maskM_reg2[0]<=32'b0;
        free_maskM_reg2[1]<=32'b0;
        free_maskM_reg2[2]<=32'b0;
        new_II_reg3<=6'h3f;
	lstep1_invd_acc[0]<=1'b0;
	lstep1_invd_acc[1]<=1'b0;
    end else if ((except&&excpt_thread==new_thr_reg2)) begin
            confl_first_reg<=6'b0;
            confl_last_reg<=6'b0;
            confl_cnt_reg<=7'b1;
            new_conflictAq_reg<=96'b0;
            new_conflictBq_reg<=96'b0;
            new_conflictx_reg<=96'b0;
            new_conflicty_reg<=96'b0;
            lstep1_invd_reg<=2'b11;
            new_conflicty_acc<=96'b0;
            new_conflictx_acc<=96'b0;
            new_II_reg3<=6'h3f;
	lstep1_invd_acc[0]<=1'b0;
	lstep1_invd_acc[1]<=1'b0;
    end else if (~lStall && ~lDoStall ) begin
        confl_first_reg<=confl_first&{6{~chmo_bolotnoe2}};
        confl_last_reg<=confl_last&{6{~chmo_bolotnoe2}};
        confl_cnt_reg<=chmo_bolotnoe2 ? 7'd1 : confl_cnt;
        new_conflictx_reg<=new_conflictx&~{nChNextA[2],nChNextA[1],nChNextA[0]}&~new_conflictx_acc;
        new_conflicty_reg<=new_conflicty&~{nChNextA[2],nChNextA[1],nChNextA[0]}&~new_conflicty_acc;
        if (new_en_reg2) new_conflictx_acc<=new_conflict1_acc;
	    else if (new_enP_reg2) new_conflictx_acc<=new_conflictx_acc|{nChNextA[2],nChNextA[1],nChNextA[0]};
        if (new_en_reg2) new_conflicty_acc<=new_conflict1_acc;
	    else if (new_enP_reg2) new_conflicty_acc<=new_conflicty_acc|{nChNextA[2],nChNextA[1],nChNextA[0]};
        new_conflictAq_reg<=new_conflictAq;
        new_conflictBq_reg<=new_conflictBq;
        lstep1_dataA_reg<=lstep1_dataA;
        lstep1_dataB_reg<=lstep1_dataB;
        lstep1_owndataA_reg<=lstep1_owndataA;
        lstep1_owndataB_reg<=lstep1_owndataB;
        lstep1_dataA_reg2<=lstep1_dataA_reg;
        lstep1_dataB_reg2<=lstep1_dataB_reg;
        lstep1_invd_reg<=lstep1_invd|lstep1_invd_acc|{2{chmo_bolotnoe2}};
	lstep1_invd_acc[0]<=1'b0;
	lstep1_invd_acc[1]<=1'b0;
    //    lstep2_validA<=~lstep1_undoA;
    //    lstep2_validB<=~lstep1_undoB;
        free_maskN_reg2[0]<=n_mask[31:0];
        free_maskN_reg2[1]<=n_mask[63:32];
        free_maskN_reg2[2]<=n_mask[95:64];
        free_maskM_reg2[0]<=m_mask[31:0];
        free_maskM_reg2[1]<=m_mask[63:32];
        free_maskM_reg2[2]<=m_mask[95:64];
        new_II_reg3<=new_II_reg2;
	//lstep1_invd_reg[0]<=lstep1_invd_reg[0]|(~|lstep2_cnHasA);
	//lstep1_invd_reg[1]<=lstep1_invd_reg[1]|(~|lstep2_cnHasA);
    end else begin
        new_conflictx_acc<=new_conflictx_acc|{nChNextA[2],nChNextA[1],nChNextA[0]};
        new_conflicty_acc<=new_conflicty_acc|{nChNextA[2],nChNextA[1],nChNextA[0]};
	if (lDoNext_Aq0) lstep1_invd_reg[0]<=1'b1;
	if (lDoNext_Bq0) lstep1_invd_reg[1]<=1'b1;
    end
    
    if (rst) begin
        lstep2_dataA_reg<=0;
        lstep2_dataB_reg<=0;
        lstep2_validA_reg<=1'b0;
        lstep2_validB_reg<=1'b0;
        lstep1_validA<=1'b0;
        lstep1_validB<=1'b0;
        lstep2_banks0_reg<=4'b0;
        lstep2_banksO0_reg<=4'b0;
        lstep2_banksX0_reg<=4'b0;
        lstep2_Mexact0_reg<=1'b0;
        lstep2_byBank0_reg<=1'b0;
        lstep2_Mshift0_reg<=5'b0;
        lstep2_banks1_reg<=4'b0;
        lstep2_banksO1_reg<=4'b0;
        lstep2_banksX1_reg<=4'b0;
        lstep2_Mexact1_reg<=1'b0;
        lstep2_byBank1_reg<=1'b0;
        lstep2_Mshift1_reg<=5'b0;
        confl_cnt_reg2<=7'b1;
        lstep2_bnmask0_reg<=4'b0;
        lstep2_bnmask1_reg<=4'b0;
        lstep2_cnHasA_reg<=3'b0;
        lstep2_cnHasB_reg<=3'b0;
        lstep1_owndataA_reg2<=0;
        lstep1_owndataB_reg2<=0;
        confl_first_reg2<=6'b0;
        confl_last_reg2<=6'b0;
        new_conflictAq_reg2<={3*BUF_COUNT{1'B0}};
        new_conflictBq_reg2<={3*BUF_COUNT{1'B0}};
        new_conflictx_acc2<={3*BUF_COUNT{1'B0}};
        new_conflicty_acc2<={3*BUF_COUNT{1'B0}};
        new_conflictx_reg2<={3*BUF_COUNT{1'B0}};
        new_conflicty_reg2<={3*BUF_COUNT{1'B0}};
        lstep2_cnBitA_reg[0]<={BUF_COUNT{1'B0}};
        lstep2_cnBitA_reg[1]<={BUF_COUNT{1'B0}};
        lstep2_cnBitA_reg[2]<={BUF_COUNT{1'B0}};
        lstep2_cnBitB_reg[0]<={BUF_COUNT{1'B0}};
        lstep2_cnBitB_reg[1]<={BUF_COUNT{1'B0}};
        lstep2_cnBitB_reg[2]<={BUF_COUNT{1'B0}};
        lstep1_invd_reg2<=2'b0;
        new_II_reg4<=6'h3f;
	lDoNext_Aq1R<=2'b 0;
	lDoNext_Bq1R<=2'b 0;
        chmo_balotnoe<=1'b0;
    end else if ((except && excpt_thread==new_thr_reg3)) begin
	lstep2_validA_reg<=1'b0;
	lstep2_validB_reg<=1'b0;
	lstep1_validA<=1'b0;
	lstep1_validB<=1'b0;
        lstep2_cnHasA_reg<=3'b0;
        lstep2_cnHasB_reg<=3'b0;
        confl_first_reg2<=6'b0;
        confl_last_reg2<=6'b0;
        confl_cnt_reg2<=7'b1;
        lstep2_cnBitA_reg[0]<={BUF_COUNT{1'B0}};
        lstep2_cnBitA_reg[1]<={BUF_COUNT{1'B0}};
        lstep2_cnBitA_reg[2]<={BUF_COUNT{1'B0}};
        lstep2_cnBitB_reg[0]<={BUF_COUNT{1'B0}};
        lstep2_cnBitB_reg[1]<={BUF_COUNT{1'B0}};
        lstep2_cnBitB_reg[2]<={BUF_COUNT{1'B0}};
        new_II_reg4<=6'h3f;
	lDoNext_Aq1R<=2'b 0;
	lDoNext_Bq1R<=2'b 0;
        lstep2_Mexact0_reg<=1'b0;
        lstep2_byBank0_reg<=1'b0;
        lstep1_invd_reg2[0]<=1'b1;
        lstep2_Mexact1_reg<=1'b0;
        lstep2_byBank1_reg<=1'b0;
        lstep1_invd_reg2[1]<=1'b1;
        new_conflicty_acc2<=96'b0;
        new_conflictx_acc2<=96'b0;
        chmo_balotnoe<=1'b0;
    end else if (~lDoStall && ~lStall ) begin
        lstep2_dataA_reg<=lstep2_dataA;
        lstep2_dataB_reg<=lstep2_dataB;
        lstep2_validA_reg<=lstep2_validA;
        lstep2_validB_reg<=lstep2_validB;
        lstep1_validA<=confl_first_reg!=6'b0;
        lstep1_validB<=confl_last_reg!=6'b0;
        lstep2_banks0_reg<=lstep2_banks0;
        lstep2_banksO0_reg<=lstep2_banksO0;
        lstep2_banksX0_reg<=lstep2_banks0;
        lstep2_Mexact0_reg<=lstep2_Mexact0;
        lstep2_byBank0_reg<=lstep2_byBank0;
        lstep2_Mshift0_reg<=lstep2_Mshift0;
        lstep2_banks1_reg<=lstep2_banks1;
        lstep2_banksO1_reg<=lstep2_banksO1;
        lstep2_banksX1_reg<=lstep2_banks1;
        lstep2_Mexact1_reg<=lstep2_Mexact1;
        lstep2_byBank1_reg<=lstep2_byBank1;
        lstep2_Mshift1_reg<=lstep2_Mshift1;
        confl_cnt_reg2<=confl_cnt_reg;
        lstep2_bnmask0_reg<=lstep2_bnmask0;
        lstep2_bnmask1_reg<=lstep2_bnmask1;
        lstep2_cnHasA_reg<=lstep2_cnHasA;
        lstep2_cnHasB_reg<=lstep2_cnHasB;
        lstep1_owndataA_reg2<=lstep1_owndataA_reg;
        lstep1_owndataB_reg2<=lstep1_owndataB_reg;
        confl_first_reg2<=confl_first_reg;
        confl_last_reg2<=confl_last_reg;
        new_conflictAq_reg2<=new_conflictAq_reg; 
        new_conflictBq_reg2<=new_conflictBq_reg; 
        new_conflictx_reg2<=new_conflictx_reg&~{nChNextA[2],nChNextA[1],nChNextA[0]}&~new_conflictx_acc2;
        new_conflicty_reg2<=new_conflicty_reg&~{nChNextA[2],nChNextA[1],nChNextA[0]}&~new_conflicty_acc2;
        if (new_en_reg3) new_conflictx_acc2<=new_conflictx_acc;
	    else if (new_enP_reg3) new_conflictx_acc2<=new_conflictx_acc2|{nChNextA[2],nChNextA[1],nChNextA[0]};
        if (new_en_reg3) new_conflicty_acc2<=new_conflicty_acc;
	    else if (new_enP_reg3) new_conflicty_acc2<=new_conflicty_acc2|{nChNextA[2],nChNextA[1],nChNextA[0]};
        lstep2_cnBitA_reg[0]<=lstep2_cnBitA[0];
        lstep2_cnBitA_reg[1]<=lstep2_cnBitA[1];
        lstep2_cnBitA_reg[2]<=lstep2_cnBitA[2];
        lstep2_cnBitB_reg[0]<=lstep2_cnBitB[0];
        lstep2_cnBitB_reg[1]<=lstep2_cnBitB[1];
        lstep2_cnBitB_reg[2]<=lstep2_cnBitB[2];
        lstep1_invd_reg2<=lstep1_invd_reg;
        new_II_reg4<=new_II_reg3;
	lDoNext_Aq1R<=2'b 0;
	lDoNext_Bq1R<=2'b 0;
        chmo_balotnoe<=1'b0;
    end else if (~lStFirst && ~lStall && ~lStFirst_pause) begin
        lstep2_Mexact0_reg<=1'b0;
        lstep2_byBank0_reg<=1'b0;
        lstep1_invd_reg2[0]<=1'b1;
        lstep2_validA_reg<=1'b0;
        lstep2_cnHasA_reg<=3'b0;
	lstep2_cnBitA_reg[0]<=32'b0;
	lstep2_cnBitA_reg[1]<=32'b0;
	lstep2_cnBitA_reg[2]<=32'b0;

        new_conflictx_acc2<=new_conflictx_acc2|{nChNextA[2],nChNextA[1],nChNextA[0]};
        new_conflicty_acc2<=new_conflicty_acc2|{nChNextA[2],nChNextA[1],nChNextA[0]};
        new_conflictx_reg2<=new_conflictx_reg2&~{nChNextA[2],nChNextA[1],nChNextA[0]};
        new_conflicty_reg2<=new_conflicty_reg2&~{nChNextA[2],nChNextA[1],nChNextA[0]};
        chmo_balotnoe<=1'b1;
        if (lDoNext_Bq1[3:0]!=0) begin
	    if (confl_last_reg2!=0 && (lDoNext_Bq1[3:1]!=0)) begin
                lstep2_Mexact1_reg<=1'b0;
                lstep2_byBank1_reg<=1'b0;
		lstep1_invd_reg2[1]<=1'b1;
            end
            lstep2_validB_reg<=1'b0;
	    lstep2_cnHasB_reg<=3'b0;
	    lstep2_cnBitB_reg[0]<=32'b0;
	    lstep2_cnBitB_reg[1]<=32'b0;
	    lstep2_cnBitB_reg[2]<=32'b0;
        end
	
	lDoNext_Aq1R[0]<=lDoNext_Aq1R[1]||lDoNext_Aq1[1]||lDoNext_Aq1R[0]&lDoNext_Aq1[0];
        lDoNext_Aq1R[1]<=lDoNext_Aq1R[0]&lDoNext_Aq1[1]; 
	lDoNext_Bq1R[0]<=lDoNext_Bq1R[1]||lDoNext_Bq1[1]||lDoNext_Bq1R[0]&lDoNext_Bq1[0];
        lDoNext_Bq1R[1]<=lDoNext_Bq1R[0]&lDoNext_Bq1[1]; 
    end else begin
        new_conflictx_acc2<=new_conflictx_acc2|{nChNextA[2],nChNextA[1],nChNextA[0]};
        new_conflicty_acc2<=new_conflicty_acc2|{nChNextA[2],nChNextA[1],nChNextA[0]};
        new_conflictx_reg2<=new_conflictx_reg2&~{nChNextA[2],nChNextA[1],nChNextA[0]};
        new_conflicty_reg2<=new_conflicty_reg2&~{nChNextA[2],nChNextA[1],nChNextA[0]};
        if (lDoNext_Aq1[3:0]!=0) begin
	    if (confl_first_reg2!=0 && (lDoNext_Aq1[3:1]!=0)) begin
                lstep2_Mexact0_reg<=1'b0;
                lstep2_byBank0_reg<=1'b0;
		lstep1_invd_reg2[0]<=1'b1;
            end
            lstep2_validA_reg<=1'b0;
	    lstep2_cnHasA_reg<=3'b0;
	    lstep2_cnBitA_reg[0]<=32'b0;
	    lstep2_cnBitA_reg[1]<=32'b0;
	    lstep2_cnBitA_reg[2]<=32'b0;
        end
        if (lDoNext_Bq1[3:0]!=0) begin
	    if (confl_last_reg2!=0 && (lDoNext_Bq1[3:1]!=0)) begin
                lstep2_Mexact1_reg<=1'b0;
                lstep2_byBank1_reg<=1'b0;
		lstep1_invd_reg2[1]<=1'b1;
            end
            lstep2_validB_reg<=1'b0;
	    lstep2_cnHasB_reg<=3'b0;
	    lstep2_cnBitB_reg[0]<=32'b0;
	    lstep2_cnBitB_reg[1]<=32'b0;
	    lstep2_cnBitB_reg[2]<=32'b0;
        end
	
	lDoNext_Aq1R[0]<=lDoNext_Aq1R[1]||lDoNext_Aq1[1]||lDoNext_Aq1R[0]&lDoNext_Aq1[0];
        lDoNext_Aq1R[1]<=lDoNext_Aq1R[0]&lDoNext_Aq1[1]; 
	lDoNext_Bq1R[0]<=lDoNext_Bq1R[1]||lDoNext_Bq1[1]||lDoNext_Bq1R[0]&lDoNext_Bq1[0];
        lDoNext_Bq1R[1]<=lDoNext_Bq1R[0]&lDoNext_Bq1[1]; 
    end
 /*   if (rst) begin
       lstep2A_validA_reg<=1'b0;
       lstep2A_validB_reg<=1'b0;
    end else begin
       lstep2A_validA_reg<=lstep2A_validA;
       lstep2A_validB_reg<=lstep2A_validB;
    end*/

   //new except code up to here.
//[	for(b=0;b<10;b=b+1) begin
//	    ret_wait[b]<=ret_wait[b]|!(ret_data_shr[`lsqshare_wrtII0]==b[3:0] ||
//	        ret_data_shr[`lsqshare_wrtII1]==b[3:0] || 
//		ret_data_shr[`lsqshare_wrtII2]==b[3:0]);
//	end
//    end
    if (rst) begin
        new_en_reg3<=1'b0;
        new_enP_reg3<=1'b0;
    end else begin
	    if (except && excpt_thread==new_thr_reg2) begin
	        new_en_reg3<=1'b0;
	        new_enP_reg3<=1'b0;
	    end else begin
            if (~lStall & ~lDoStall) new_en_reg3<=new_en_reg2;
            if (~lStall & ~lDoStall) new_enP_reg3<=new_enP_reg2;
	    end
    end
    //if (rst) lDoStall_reg<=1'b0;
    //else if (~aStall&~aDoStall&~lStall || lDoStall) lDoStall_reg<=lDoStall;
  end
endmodule

