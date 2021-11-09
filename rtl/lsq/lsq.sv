`include "../struct.sv"

module lsq_chk_confl(
  data0,
  data1,
  confl
  );
  localparam WIDTH=`lsaddr_width;
  localparam PADDR_WIDTH=44;
  
  input [WIDTH-1:0] data0;
  input [WIDTH-1:0] data1;
  output confl;
  
  wire chkMatchE;
  wire chkMatchO;
  wire [31:0] banks0;
  wire [31:0] banks1;
  wire addrOL0,addrOH0,addrEL0,addrEH0;
  wire addrOL1,addrOH1,addrEL1,addrEH1;
  wire chkBankL;
  wire chkBankH;
  wire [PADDR_WIDTH-9:0] addrE0;
  wire [PADDR_WIDTH-9:0] addrO0;
  wire [PADDR_WIDTH-9:0] addrE1;
  wire [PADDR_WIDTH-9:0] addrO1;
  
  assign addrE0=data0[`lsaddr_addrE];
  assign addrE1=data1[`lsaddr_addrE];
  assign addrO0=data0[`lsaddr_addrO];
  assign addrO1=data1[`lsaddr_addrO];

  assign addrOL0=data0[`lsaddr_OL];
  assign addrOH0=data0[`lsaddr_OH];
  assign addrEL0=data0[`lsaddr_EL];
  assign addrEH0=data0[`lsaddr_EH];

  assign addrOL1=data1[`lsaddr_OL];
  assign addrOH1=data1[`lsaddr_OH];
  assign addrEL1=data1[`lsaddr_EL];
  assign addrEH1=data1[`lsaddr_EH];

  assign banks0=data0[`lsaddr_banks];
  assign banks1=data1[`lsaddr_banks];

  assign chkBankL=1 && banks0[15:0]&banks1[15:0];
  assign chkBankH=1 && banks0[31:16]&banks1[31:16];
  assign chkMatchE=addrE0[13:0]==addrE1[13:0];   
  assign chkMatchO=addrO0[13:0]==addrO1[13:0];   
/*  assign chkWhole0=(bank0_0==bank0_1 || bank0_0==bank1_1) & fit_whole ||
    (bank0_0==bank0_1_inc || bank0_0==bank1_1_inc) & fit_simdS;
  assign chkWhole1=(bank1_0==bank0_1 || bank1_0==bank1_1) & fit_whole ||
    (bank1_0==bank0_1_inc || bank1_0==bank1_1_inc) & fit_simdS;  
  assign chkPart[0]=(bank0_0==bank0_1 || bank0_0==bank1_1) && sz0==5 && sz1==2 && aligned;
  assign chkPart[1]=(bank0_0_inc==bank0_1 || bank0_0_inc==bank1_1) && sz0==5 && sz1==2 && aligned;
  assign chkPart[2]=(bank1_0==bank0_1 || bank1_0==bank1_1) && sz0==5 && sz1==2 && aligned;
  assign chkPart[3]=(bank1_0_inc==bank0_1 || bank1_0_inc==bank1_1) && sz0==5 && sz1==2 && aligned;
  assign chkWholeU=bank0_0==bank0_1 && sz0==sz1 && addrLow0==addrLow1 && ~dual0 && ~dual1; */
//  assign addrOH0=(odd0 && ~split0|startH0) || (~odd0 & split & ~startH0);
//  assign addrEH0=(~odd0 && ~split0|startH0) || (odd0 & split & ~startH0);
// assign addrOL0=(odd0 && ~split|~startH0) || (~odd0 & split & startH0);
//  assign addrEL0=(~odd0 && ~split|~startH0) || (odd0 & split & startH0);

//  assign addrOH1=(odd1 && ~split1|startH1) || (~odd1 & split1 & ~startH1);
//  assign addrEH1=(~odd1 && ~split1|startH1) || (odd1 & split1 & ~startH1);
//  assign addrOL1=(odd1 && ~split1|~startH1) || (~odd1 & split1 & startH1);
//  assign addrEL1=(~odd1 && ~split1|~startH1) || (odd1 & split1 & startH1);

  assign confl=addrOH0 & addrOH1 & chkMatchO & chkBankH ||
    addrOL0 & addrOL1 & chkMatchO & chkBankL ||
    addrEH0 & addrEH1 & chkMatchE & chkBankH ||
    addrEL0 & addrEL1 & chkMatchE & chkBankL;    
  

endmodule

module lsq_chk_bundle(
  data0,data1,data2,
  data3,data4,data5,
  has_confl,
  ld1_confl,
  ld2_confl,
  ld3_confl,
  ld4_confl,
  ld5_confl  
  );
  localparam WIDTH=`lsaddr_width;
  input [WIDTH-1:0] data0;
  input [WIDTH-1:0] data1;
  input [WIDTH-1:0] data2;
  input [WIDTH-1:0] data3;
  input [WIDTH-1:0] data4;
  input [WIDTH-1:0] data5;
  output [5:0] has_confl;
  output [0:0] ld1_confl;
  output [1:0] ld2_confl;
  output [2:0] ld3_confl;
  output [3:0] ld4_confl;
  output [4:0] ld5_confl;
  wire [5:0] confl0 [5:1]; //array index=load
  
  wire [WIDTH-1:0] data[5:0];

  assign data[0]=data0;
  assign data[1]=data1;
  assign data[2]=data2;
  assign data[3]=data3;
  assign data[4]=data4;
  assign data[5]=data5;
  
  generate
      genvar h,k;
      for(h=1;h<=5;h=h+1) begin : start_point_gen
          for(k=0;k<=5;k=k+1) begin : store_point_gen
		  if (k<h) begin : chk_gen_if
			  lsq_chk_confl confl_mod(data[h],data[k],confl0[h][k]);
                  end else begin
			  assign confl0[h][k]=1'b0;
		  end
          end
          assign has_confl[h]=|confl0[h];
      end
  endgenerate
  
  
  assign ld1_confl=confl0[1][0];
  assign ld2_confl=confl0[2][1:0];
  assign ld3_confl=confl0[3][2:0];
  assign ld4_confl=confl0[4][3:0];
  assign ld5_confl=confl0[5][4:0];

  assign has_confl[0]=1'b0;

endmodule

module storq_mux(
  wrInd0,wrInd1,wrInd2,pos,
  data0,data1,data2,
  data3,data4,data5,
  dataOut0,dataOut1,dataOut2
  );
  parameter DATA_WIDTH=1;
  
  input [2:0] wrInd0;
  input [2:0] wrInd1;
  input [2:0] wrInd2;
  input [2:0] pos;
  input [DATA_WIDTH-1:0] data0;
  input [DATA_WIDTH-1:0] data1;
  input [DATA_WIDTH-1:0] data2;
  input [DATA_WIDTH-1:0] data3;
  input [DATA_WIDTH-1:0] data4;
  input [DATA_WIDTH-1:0] data5;
  output [DATA_WIDTH-1:0] dataOut0;
  output [DATA_WIDTH-1:0] dataOut1;
  output [DATA_WIDTH-1:0] dataOut2;

  wire [DATA_WIDTH-1:0] dataM0;
  wire [DATA_WIDTH-1:0] dataM1;
  wire [DATA_WIDTH-1:0] dataM2;

  wire [DATA_WIDTH-1:0] data[5:0];

  assign data[0]=data0;
  assign data[1]=data1;
  assign data[2]=data2;
  assign data[3]=data3;
  assign data[4]=data4;
  assign data[5]=data5;

  assign dataM0=(wrInd0==3'd7) ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'BZ}};
  assign dataM1=(wrInd1==3'd7) ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'BZ}};
  assign dataM2=(wrInd2==3'd7) ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'BZ}};
      
  assign dataOut0=pos[0] ? dataM0 : {DATA_WIDTH{1'BZ}};
  assign dataOut1=pos[0] ? dataM1 : {DATA_WIDTH{1'BZ}};
  assign dataOut2=pos[0] ? dataM2 : {DATA_WIDTH{1'BZ}};

  assign dataOut0=pos[1] ? dataM2 : {DATA_WIDTH{1'BZ}};
  assign dataOut1=pos[1] ? dataM0 : {DATA_WIDTH{1'BZ}};
  assign dataOut2=pos[1] ? dataM1 : {DATA_WIDTH{1'BZ}};

  assign dataOut0=pos[2] ? dataM1 : {DATA_WIDTH{1'BZ}};
  assign dataOut1=pos[2] ? dataM2 : {DATA_WIDTH{1'BZ}};
  assign dataOut2=pos[2] ? dataM0 : {DATA_WIDTH{1'BZ}};

  generate
      genvar t;
      for(t=0;t<6;t=t+1) begin
          assign dataM0=(wrInd0==t) ? data[t] : {DATA_WIDTH{1'BZ}};
          assign dataM1=(wrInd1==t) ? data[t] : {DATA_WIDTH{1'BZ}};
          assign dataM2=(wrInd2==t) ? data[t] : {DATA_WIDTH{1'BZ}};
      end

  endgenerate


endmodule

module lsq_decide_ret(
  clk,
  rst,
  bStall,
//  storq_II_upper,
//  storq_en,
  dataB_ret_mask,
//  dataB_en_mask,
//  dataB_pre_confl,
  dataB_ld_confl,
  dataB_wait_confl,
  dataB_excpt,
  dataB_exbits,
  dataB_thread,
  dataB_II,
  dataB_data_shr,
  dataB_II0,dataB_II1,dataB_II2,
  dataB_II3,dataB_II4,dataB_II5,
  dataB_ready,
  dataB_enOut,
  cntrl_II,out_II,
  retire_enOut,  retire_fine, retire_ldconfl,retire_except,
  retire_exbitsx6, retire_waitconfl, 
  dataB_shr_out,
  doRetire,
  except,
  except_thread
  );
  input clk,rst;
  input bStall;
  input [5:0] dataB_ret_mask;
//  input [5:0] dataB_pre_confl;
  input [5:0] dataB_ld_confl;
  input [5:0] dataB_wait_confl;
  input [5:0] dataB_excpt;
  input [23:0] dataB_exbits;
  input dataB_thread;
  input [5:0] dataB_II;
  input [`lsqshare_width-1:0] dataB_data_shr;
  input [3:0] dataB_II0;
  input [3:0] dataB_II1;
  input [3:0] dataB_II2;
  input [3:0] dataB_II3;
  input [3:0] dataB_II4;
  input [3:0] dataB_II5;
  input dataB_ready;
  output dataB_enOut;
  input [5:0] cntrl_II;
  output [5:0] out_II;
  output [9:0] retire_enOut;  
  output reg [9:0] retire_fine; 
  output reg [9:0] retire_ldconfl; 
  output reg [9:0] retire_except;
  output reg [39:0] retire_exbitsx6;
  output reg [9:0] retire_waitconfl; 
  output reg [`lsqshare_width-1:0] dataB_shr_out;
  input doRetire;
  input except;
  input except_thread;

//  reg non_ret;
  wire [9:0] dataB_ret_mask2;
  wire [9:0] dataB_err_mask2;
  wire [9:0] dataB_err_mask3;
  wire [9:0] dataB_err_mask4;
  wire [3:0] dataB_ebits_item[9:0];
  reg ret_ret;
  reg [5:0] dataB_II_reg;
  reg [9:0] retire_enOutP;  
  integer t;

  generate
    genvar k;
    for(k=0;k<10;k=k+1) begin
        assign dataB_ret_mask2[k]=(dataB_ret_mask[0] && dataB_II0[3:0]==k) ||
	  (dataB_ret_mask[1] && dataB_II1[3:0]==k) ||
	  (dataB_ret_mask[2] && dataB_II2[3:0]==k) ||
	  (dataB_ret_mask[3] && dataB_II3[3:0]==k) ||
	  (dataB_ret_mask[4] && dataB_II4[3:0]==k) ||
	  (dataB_ret_mask[5] && dataB_II5[3:0]==k);
        assign dataB_err_mask2[k]=(dataB_excpt[0] && dataB_ret_mask[0] && dataB_II0[3:0]==k) ||
	  (dataB_excpt[1] && dataB_ret_mask[1] && dataB_II1[3:0]==k) ||
	  (dataB_excpt[2] && dataB_ret_mask[2] && dataB_II2[3:0]==k) ||
	  (dataB_excpt[3] && dataB_ret_mask[3] && dataB_II3[3:0]==k) ||
	  (dataB_excpt[4] && dataB_ret_mask[4] && dataB_II4[3:0]==k) ||
	  (dataB_excpt[5] && dataB_ret_mask[5] && dataB_II5[3:0]==k);
        assign dataB_err_mask3[k]=(dataB_ld_confl[0] && dataB_ret_mask[0] && dataB_II0[3:0]==k) ||
	  (dataB_ld_confl[1] && dataB_ret_mask[1] && dataB_II1[3:0]==k) ||
	  (dataB_ld_confl[2] && dataB_ret_mask[2] && dataB_II2[3:0]==k) ||
	  (dataB_ld_confl[3] && dataB_ret_mask[3] && dataB_II3[3:0]==k) ||
	  (dataB_ld_confl[4] && dataB_ret_mask[4] && dataB_II4[3:0]==k) ||
	  (dataB_ld_confl[5] && dataB_ret_mask[5] && dataB_II5[3:0]==k);
        assign dataB_err_mask4[k]=(dataB_wait_confl[0] && dataB_ret_mask[0] && dataB_II0[3:0]==k) ||
	  (dataB_wait_confl[1] && dataB_ret_mask[1] && dataB_II1[3:0]==k) ||
	  (dataB_wait_confl[2] && dataB_ret_mask[2] && dataB_II2[3:0]==k) ||
	  (dataB_wait_confl[3] && dataB_ret_mask[3] && dataB_II3[3:0]==k) ||
	  (dataB_wait_confl[4] && dataB_ret_mask[4] && dataB_II4[3:0]==k) ||
	  (dataB_wait_confl[5] && dataB_ret_mask[5] && dataB_II5[3:0]==k);
        assign dataB_ebits_item[k]=(dataB_exbits[3:0] & {4{dataB_ret_mask[0] && dataB_II0[3:0]==k}})|
        (dataB_exbits[7:4] & {4{dataB_ret_mask[1] && dataB_II1[3:0]==k}})|
        (dataB_exbits[11:8] & {4{dataB_ret_mask[2] && dataB_II2[3:0]==k}})|
        (dataB_exbits[15:12] & {4{dataB_ret_mask[3] && dataB_II3[3:0]==k}})|
        (dataB_exbits[19:16] & {4{dataB_ret_mask[4] && dataB_II4[3:0]==k}})|
        (dataB_exbits[23:20] & {4{dataB_ret_mask[5] && dataB_II5[3:0]==k}});
    end
  endgenerate

//  assign dataB_enOut0=dataB_ready && (doRetire && cntrl_II==dataB_II0_reg[9:4]) | 
//    (ret_ret && cntrl_II==dataB_II0[9:4]);
  assign dataB_enOut=dataB_ready && (doRetire && cntrl_II==dataB_II_reg && ~bStall) | 
      (ret_ret && cntrl_II==dataB_II);
  assign retire_enOut=retire_enOutP & {10{ cntrl_II==dataB_II_reg}};
  assign out_II=dataB_II_reg;
  //assign out_II=ret_ret ? dataB_II : dataB_II_reg;
  always @(posedge clk) begin
    if (rst) begin
        retire_enOutP<=10'b0;
	retire_fine<=10'b0;
	retire_ldconfl<=10'b0;
	retire_waitconfl<=10'b0;
        retire_exbitsx6<=40'b0;
	retire_except<=10'b0;
	dataB_II_reg<=6'h3f;
	//non_ret<=1'b0;
        ret_ret<=1'b1;
       // doRetire_reg<=1'b0;
       dataB_shr_out<={`lsqshare_width{1'b0}};
    end else begin
	//$display("dd ",dataB_II," ",dataB_II_reg," ",cntrl_II);
        for(t=0;t<10;t=t+1) if ((ret_ret && cntrl_II==dataB_II)|
           (~ret_ret && cntrl_II==dataB_II_reg && doRetire|(cntrl_II==dataB_II)) &&
           ~bStall) begin
            retire_enOutP[t]<=  dataB_ret_mask2[t];
	    retire_fine[t]<=  ~dataB_err_mask2[t] && ~dataB_err_mask3[t]
            && ~dataB_err_mask4[t];
	    retire_ldconfl[t]<=dataB_err_mask3[t];
	    retire_waitconfl[t]<=dataB_err_mask4[t];
	    retire_except[t]<= dataB_err_mask2[t];
            retire_exbitsx6[4*t+:4]<=dataB_ebits_item[t];
	    if (doRetire | ret_ret) dataB_II_reg<=dataB_II;
	    if (doRetire | ret_ret) dataB_shr_out<=dataB_data_shr;
	    /*if (doRetire && ret_ret|(dataB_II==dataB_II_reg)) /-*$$*-/begin
                retire_enOutP[t]<=1'b0;
	        retire_fine[t]<=1'b0;
	        retire_ldconfl[t]<=1'b0;
	        retire_waitconfl[t]<=1'b0;
	        retire_except[t]<= 1'b0;
                retire_exbitsx6[4*t+:4]<=4'b0;
	    end*/
	    ret_ret<=1'b0;
	end 
	if (~bStall) begin
            if (dataB_enOut && ~doRetire) ret_ret<=1'b0;
	    else if (doRetire && dataB_II==~~~~dataB_II_reg) begin
		ret_ret<=1'b1;
		dataB_II_reg<=6'h3f;
	    end else if (doRetire && dataB_ready) ret_ret<=1'b0;
	end
        if (except && except_thread==dataB_thread) begin
            ret_ret<=1'b1;
            dataB_II_reg<=6'h3f;
            retire_enOutP<=10'b0;
        end  
      //  if (dataB_enOut) non_ret<=1'b1;
      //  if (except) non_ret<=1'b0;
       // doRetire_reg<=doRetire;
    end
  end
endmodule
  
