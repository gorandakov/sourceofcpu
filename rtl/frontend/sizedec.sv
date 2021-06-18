`include "../struct.sv"
`include "../csrss_no.sv"


module predecoder_get(
    clk,
    rst,
    bundle,btail,
    flag_bits,
    startOff,
    instr0,instr1,instr2,instr3,
    instr4,instr5,instr6,instr7,
    instr8,instr9,instr10,instr11,
    magic0,magic1,magic2,magic3,
    magic4,magic5,magic6,magic7,
    magic8,magic9,magic10,magic11,
    off0,off1,off2,off3,
    off4,off5,off6,off7,
    off8,off9,off10,off11,
    class0,class1,class2,class3,
    class4,class5,class6,class7,
    class8,class9,class10,class11,
    instrEn,
    isAvx,
    hasJumps,
    error,
    jerror,
    Jinstr0,Jinstr1,Jinstr2,Jinstr3,
    Jmagic0,Jmagic1,Jmagic2,Jmagic3,
    Joff0,Joff1,Joff2,Joff3,
    Jclass0,Jclass1,Jclass2,Jclass3,
    Jen,
    lnkLink0,lnkOff0,lnkMagic0,lnkRet0,lnkJumps0,
    lnkLink1,lnkOff1,lnkMagic1,lnkRet1,lnkJumps1,
    lnkLink2,lnkOff2,lnkMagic2,lnkRet2,lnkJumps2,
    lnkLink3,lnkOff3,lnkMagic3,lnkRet3,lnkJumps3
    );
    localparam CLSWIDTH=12;
    
    input clk;
    input rst;
    input [255:0] bundle;
    input [16:0] btail;
    input [14:0] flag_bits;
    input [3:0] startOff;
    output [79:0] instr0;
    output [79:0] instr1;
    output [79:0] instr2;
    output [79:0] instr3;
    output [79:0] instr4;
    output [79:0] instr5;
    output [79:0] instr6;
    output [79:0] instr7;
    output [79:0] instr8;
    output [79:0] instr9;
    output [79:0] instr10;
    output [79:0] instr11;

    output [3:0] magic0;
    output [3:0] magic1;
    output [3:0] magic2;
    output [3:0] magic3;
    output [3:0] magic4;
    output [3:0] magic5;
    output [3:0] magic6;
    output [3:0] magic7;
    output [3:0] magic8;
    output [3:0] magic9;
    output [3:0] magic10;
    output [3:0] magic11;

    output [3:0] off0;
    output [3:0] off1;
    output [3:0] off2;
    output [3:0] off3;
    output [3:0] off4;
    output [3:0] off5;
    output [3:0] off6;
    output [3:0] off7;
    output [3:0] off8;
    output [3:0] off9;
    output [3:0] off10;
    output [3:0] off11;
    
    output [12:0] class0;
    output [12:0] class1;
    output [12:0] class2;
    output [12:0] class3;
    output [12:0] class4;
    output [12:0] class5;
    output [12:0] class6;
    output [12:0] class7;
    output [12:0] class8;
    output [12:0] class9;
    output [12:0] class10;
    output [12:0] class11;
    
    output [11:0] instrEn;
    output reg isAvx;
    output hasJumps;
    output reg error;
    output reg jerror;
    
    output [79:0] Jinstr0;
    output [79:0] Jinstr1;
    output [79:0] Jinstr2;
    output [79:0] Jinstr3;

    output [3:0] Jmagic0;
    output [3:0] Jmagic1;
    output [3:0] Jmagic2;
    output [3:0] Jmagic3;

    output [3:0] Joff0;
    output [3:0] Joff1;
    output [3:0] Joff2;
    output [3:0] Joff3;
    
    output [12:0] Jclass0;
    output [12:0] Jclass1;
    output [12:0] Jclass2;
    output [12:0] Jclass3;
    
    output [3:0] Jen;
    output [4:0] lnkLink0;
    output [4:0] lnkOff0;
    output [3:0] lnkMagic0;
    output       lnkRet0;
    output [4:0] lnkJumps0;
    output [4:0] lnkLink1;
    output [4:0] lnkOff1;
    output [3:0] lnkMagic1;
    output       lnkRet1;
    output [4:0] lnkJumps1;
    output [4:0] lnkLink2;
    output [4:0] lnkOff2;
    output [3:0] lnkMagic2;
    output       lnkRet2;
    output [4:0] lnkJumps2;
    output [4:0] lnkLink3;
    output [4:0] lnkOff3;
    output [3:0] lnkMagic3;
    output       lnkRet3;
    output [4:0] lnkJumps3;

    reg [19:-1] instrEnd;
    
    wire [15:-2][15:0] cntEnd;
    wire [15:-1] mask;
 
    wire [15:0] cntEnd2;
    wire [16:1] cntEnd3;
    
    wire [15:0][12:0] class_ ;
    wire [255+16+48:0] bundle0;

    wire [14:0] is_jmp;
    reg [14:0] is_jmp_reg;
    wire [15:-1][15:0] cntJEnd;
    wire [14:0] jcnt_or_less;
    wire [15:1] jcnt_or_more;
    
    wire [14:0] is_lnk0;
    wire [14:0] is_lnk;
    reg [14:0] is_lnk_reg;
    wire [14:0] first_lnk;
    wire has_lnk;
    wire [15:0][4:0] LNK;
    wire [14:0] lcnt_or_less;
    wire [14:-1][15:0] lcnt;
    wire [14:0] is_ret0;
    wire [14:0] is_ret;
    reg [14:0] is_ret_reg;
    reg [15:0] flag_bits0;
        
    generate
        genvar k;
        for(k=0;k<15;k=k+1) begin : popcnt_gen
            popcnt15 cnt_mod(instrEnd[14:0] & ((15'b10<<k)-15'b1) & mask[14:0],cntEnd[k]);
            get_carry #(4) carry_mod(k[3:0],~startOff,1'b1,mask[k]);
 
            predecoder_class cls_mod(bundle0[k*16+:32],~instrEnd[k+:2],flag_bits0[k],class_[k],
              is_lnk0[k],is_ret0[k],LNK[k]);
            popcnt15 cntJ_mod(is_jmp[14:0] & ((15'b10<<k)-15'b1),cntJEnd[k]);
            popcnt15 cntL_mod(is_lnk[14:0] & ((15'b10<<k)-15'b1),lcnt[k]);
            assign {lnkLink0,lnkOff0,lnkMagic0,lnkRet0}=lcnt[k][1] & lcnt[k-1][0] ? {LNK[k],1'b0,k[3:0],instrEnd[k+:4],is_ret[k]} :
	       	15'bz;
            assign {lnkLink1,lnkOff1,lnkMagic1,lnkRet1}=lcnt[k][2] & lcnt[k-1][1] ? {LNK[k],1'b0,k[3:0],instrEnd[k+:4],is_ret[k]} :
	       	15'bz;
            assign {lnkLink2,lnkOff2,lnkMagic2,lnkRet2}=lcnt[k][3] & lcnt[k-1][2] ? {LNK[k],1'b0,k[3:0],instrEnd[k+:4],is_ret[k]} :
	       	15'bz;
            assign {lnkLink3,lnkOff3,lnkMagic3,lnkRet3}=lcnt[k][4] & lcnt[k-1][3] ? {LNK[k],1'b0,k[3:0],instrEnd[k+:4],is_ret[k]} :
	       	15'bz;
            assign lnkJumps0=lcnt[k][1] & lcnt[k-1][0] ? cntJEnd[k][4:0] : 5'bz;
            assign lnkJumps1=lcnt[k][2] & lcnt[k-1][1] ? cntJEnd[k][4:0] : 5'bz;
            assign lnkJumps2=lcnt[k][3] & lcnt[k-1][2] ? cntJEnd[k][4:0] : 5'bz;
            assign lnkJumps3=lcnt[k][4] & lcnt[k-1][3] ? cntJEnd[k][4:0] : 5'bz;
            
            assign {Jclass0,Jmagic0,Jinstr0,Joff0}= 
              cntJEnd[k][1] & cntJEnd[k-1][0] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {Jclass1,Jmagic1,Jinstr1,Joff1}= 
              cntJEnd[k][2] & cntJEnd[k-1][1] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {Jclass2,Jmagic2,Jinstr2,Joff2}= 
              cntJEnd[k][3] & cntJEnd[k-1][2] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {Jclass3,Jmagic3,Jinstr3,Joff3}= 
              cntJEnd[k][4] & cntJEnd[k-1][3] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            
            assign {class0,magic0,instr0,off0}=(mask[k] & ~mask[k-1]) ?
              {class_[k],instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class1,magic1,instr1,off1}=mask[k] & 
              cntEnd[k-1][1] & cntEnd[k-2][0] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class2,magic2,instr2,off2}=mask[k] & 
              cntEnd[k-1][2] & cntEnd[k-2][1] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class3,magic3,instr3,off3}=mask[k] &
              cntEnd[k-1][3] & cntEnd[k-2][2] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class4,magic4,instr4,off4}=mask[k] &
              cntEnd[k-1][4] & cntEnd[k-2][3] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class5,magic5,instr5,off5}=mask[k] &
              cntEnd[k-1][5] & cntEnd[k-2][4] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class6,magic6,instr6,off6}=mask[k] &
              cntEnd[k-1][6] & cntEnd[k-2][5] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class7,magic7,instr7,off7}=mask[k] &
              cntEnd[k-1][7] & cntEnd[k-2][6] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class8,magic8,instr8,off8}=mask[k] &
              cntEnd[k-1][8] & cntEnd[k-2][7] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class9,magic9,instr9,off9}=mask[k] &
              cntEnd[k-1][9] & cntEnd[k-2][8] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class10,magic10,instr10,off10}=mask[k] &
              cntEnd[k-1][10] & cntEnd[k-2][9] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class11,magic11,instr11,off11}=mask[k] &
              cntEnd[k-1][11] & cntEnd[k-2][10] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;

        end
    endgenerate

    popcnt16_or_less ce2_mod(instrEnd[15:0]&mask[15:0],cntEnd2);
    popcnt16_or_more ce3_mod(instrEnd[15:0]&mask[15:0],cntEnd3);
    popcnt15_or_less jce_mod(is_jmp,jcnt_or_less);
    popcnt15_or_more jcen_mod(is_jmp,jcnt_or_more);
    bit_find_first_bit #(15) getLNK_mod(is_lnk,first_lnk,has_lnk);    
    popcnt15_or_less lce_mod(is_lnk,lcnt_or_less);
    assign mask[-1]=1'b0;
//    assign mask[15]=1'b0;

    assign cntEnd[-1]=16'd1;
    assign cntEnd[-2]=16'd1;
    assign cntJEnd[-1]=16'd1;
    assign lcnt[-1]=16'd1;
    
    assign bundle0={64'b0,btail[15:0],bundle[239:0]};
    
    assign {class11,magic11, instr11, off11}=cntEnd2[10] ? 101'b0 : 101'bz;
    assign {class10,magic10, instr10, off10}=cntEnd2[9] ? 101'b0 : 101'bz;
    assign {class9,magic9, instr9, off9}=cntEnd2[8] ? 101'b0 : 101'bz;
    assign {class8,magic8, instr8, off8}=cntEnd2[7] ? 101'b0 : 101'bz;
    assign {class7,magic7, instr7, off7}=cntEnd2[6] ? 101'b0 : 101'bz;
    assign {class6,magic6, instr6, off6}=cntEnd2[5] ? 101'b0 : 101'bz;
    assign {class5,magic5, instr5, off5}=cntEnd2[4] ? 101'b0 : 101'bz;
    assign {class4,magic4, instr4, off4}=cntEnd2[3] ? 101'b0 : 101'bz;
    assign {class3,magic3, instr3, off3}=cntEnd2[2] ? 101'b0 : 101'bz;
    assign {class2,magic2, instr2, off2}=cntEnd2[1] ? 101'b0 : 101'bz;
    assign {class1,magic1, instr1, off1}=cntEnd2[0] ? 101'b0 : 101'bz;
    assign {class0,magic0, instr0, off0}=(0==mask) ? 101'b0 : 101'bz;

    assign {lnkLink0,lnkOff0,lnkMagic0,lnkRet0}=lcnt_or_less[0] ? 15'b1110_10000_0001_0 : 15'bz;
    assign {lnkLink1,lnkOff1,lnkMagic1,lnkRet1}=lcnt_or_less[1] ? 15'b1110_10000_0001_0 : 15'bz;
    assign {lnkLink2,lnkOff2,lnkMagic2,lnkRet2}=lcnt_or_less[2] ? 15'b1110_10000_0001_0 : 15'bz;
    assign {lnkLink3,lnkOff3,lnkMagic3,lnkRet3}=lcnt_or_less[3] ? 15'b1110_10000_0001_0 : 15'bz;
    assign lnkJumps0=lcnt_or_less[0] ?  5'd1 : 5'bz;
    assign lnkJumps1=lcnt_or_less[1] ?  5'd1 : 5'bz;
    assign lnkJumps2=lcnt_or_less[2] ?  5'd1 : 5'bz;
    assign lnkJumps3=lcnt_or_less[3] ?  5'd1 : 5'bz;

    assign instrEn=cntEnd3[12:1];
    assign Jen=jcnt_or_more[4:1];
    
    assign is_jmp={class_[14][`iclass_jump],
        class_[13][`iclass_jump],
        class_[12][`iclass_jump],
        class_[11][`iclass_jump],
        class_[10][`iclass_jump],
        class_[9][`iclass_jump],
        class_[8][`iclass_jump],
        class_[7][`iclass_jump],
        class_[6][`iclass_jump],
        class_[5][`iclass_jump],
        class_[4][`iclass_jump],
        class_[3][`iclass_jump],
        class_[2][`iclass_jump],
        class_[1][`iclass_jump],
        class_[0][`iclass_jump]
        } & instrEnd[13:-1] & (instrEnd[14:0] | instrEnd[15:1] | {1'b0,instrEnd[15:2]} |
          {2'b0,instrEnd[15:3]});

    assign is_lnk=is_lnk0[14:0] & instrEnd[13:-1];
    assign is_ret=is_lnk0[14:0] & instrEnd[13:-1] & is_ret0[14:0];
    
    assign {Jclass3,Jmagic3, Jinstr3, Joff3}=jcnt_or_less[3] ? 101'b0 : 101'bz;
    assign {Jclass2,Jmagic2, Jinstr2, Joff2}=jcnt_or_less[2] ? 101'b0 : 101'bz;
    assign {Jclass1,Jmagic1, Jinstr1, Joff1}=jcnt_or_less[1] ? 101'b0 : 101'bz;
    assign {Jclass0,Jmagic0, Jinstr0, Joff0}=jcnt_or_less[0] ? 101'b0 : 101'bz;
      
    assign hasJumps=(is_jmp & mask[14:0])!=15'b0;
    
    always @*
      begin
        instrEnd={4'b0,btail[16],bundle[254:240],1'b1};
        error=cntEnd3[13] || startOff==15;
        isAvx=bundle[255];
        jerror=~lcnt_or_less[1] || ~jcnt_or_less[4];
        flag_bits0={btail[16],flag_bits};
      end
/*
    always @(posedge clk) begin
        if (rst) is_jmp_reg<=15'b0;
        else is_jmp_reg<=is_jmp;
        if (rst) is_lnk_reg<=15'b0;
        else is_lnk_reg<=is_lnk;
        if (rst) is_ret_reg<=15'b0;
        else is_ret_reg<=is_lnk;
    end
 */
endmodule

