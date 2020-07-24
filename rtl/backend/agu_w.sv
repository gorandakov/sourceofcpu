`include "../struct.sv"


module sagu(
  clk,
  rst,
  except,
  except_gate,
  except_in_vm,
  except_in_km,
  read_clkEn,
  doStall,
  bus_hold,
  mex_addr,
  mex_en,
  op,
  shiftSize,
  regno,
  LSQ_no,
  II_no,
  WQ_no,
  thread,
  lsflag,
  cmplxAddr,
  cin_secq,
  ptrdiff,
  tlbMiss,
  pageFault,
  faultCode,
  faultNo,
  mOp_register,
  mOp_type,
  mOp_LSQ,
  mOp_II,
  mOp_WQ,
  mOp_addrEven,
  mOp_addrOdd,
  mOp_addrMain,
  mOp_sz,
  mOp_st,
  mOp_en,
  mOp_secq,
  mOp_rsEn,
  mOp_thread,
  mOp_lsflag,
  mOp_banks,
  mOp_bank0,
  mOp_odd,
  mOp_addr_low,
  mOp_split,
//  mOp_noBanks,
  writeTlb_IP,
  writeTlb_wen,
  writeTlb_force_way,
  writeTlb_force_way_en,
  writeTlb_data0,
  writeTlb_data1,
  writeTlb_data2,
  csrss_no,
  csrss_en,
  csrss_thr,
  csrss_data
  );

  parameter INDEX=0; //0 1 2 
  localparam ADDR_WIDTH=64;
  localparam PADDR_WIDTH=44;
  localparam OPERATION_WIDTH=`operation_width;
  localparam BANK_COUNT=32;
  localparam TLB_DATA_WIDTH=`dtlbData_width;
  localparam TLB_IP_WIDTH=52;
  localparam REG_WIDTH=`reg_addr_width;

  input clk;
  input rst;
  input except;
  input except_gate;
  input except_in_vm;
  input except_in_km;
  input read_clkEn;
  output doStall;
  input bus_hold;
  input [43:0] mex_addr;
  input mex_en;
  input [OPERATION_WIDTH-1:0] op;
  input [3:0] shiftSize;
  input [REG_WIDTH-1:0] regno;
  input [8:0] LSQ_no;
  input [9:0] II_no;
  input [7:0] WQ_no;
  input thread;
  input lsflag;
  input [63:0] cmplxAddr;
  input cin_secq;
  input ptrdiff;
  output tlbMiss;
  output pageFault;
  output [7:0] faultCode;
  output [8:0] faultNo;
  output [REG_WIDTH-1:0] mOp_register;
  output [1:0] mOp_type;
  output [8:0] mOp_LSQ;
  output [9:0] mOp_II;
  output [7:0] mOp_WQ;
  output [PADDR_WIDTH-1:8] mOp_addrEven;
  output [PADDR_WIDTH-1:8] mOp_addrOdd;
  output [43:0] mOp_addrMain;
  output [4:0] mOp_sz;
  output mOp_st;
  output mOp_en;
  output mOp_secq;
  output mOp_rsEn;
  output mOp_thread;
  output mOp_lsflag;
  output [BANK_COUNT-1:0] mOp_banks;
  output [4:0] mOp_bank0;
  output mOp_odd;
  output [1:0] mOp_addr_low;
  output mOp_split;
//  output [BANK_COUNT-1:0] mOp_noBanks;
  input [TLB_IP_WIDTH-2:0] writeTlb_IP;
  input writeTlb_wen;
  input [2:0] writeTlb_force_way;
  input writeTlb_force_way_en;
  input [TLB_DATA_WIDTH-1:0] writeTlb_data0;
  input [TLB_DATA_WIDTH-1:0] writeTlb_data1;
  input [TLB_DATA_WIDTH-1:0] writeTlb_data2;
  input [15:0] csrss_no;
  input csrss_en;
  input csrss_thr;
  input [63:0] csrss_data;

  reg [2:0] opsize;
  wire hasIndex;
  reg aligned;//aligned for int subsys purpose not arch
  reg aligned2;//same for complex addressing
  reg tiny; //1 or 2 byte
  reg mex_en_reg,mex_en_reg2;

  reg mode64;
  reg modeCmplx;
  reg modeCmplx_reg;
  
//  wire isLongOffset;
  reg stepOver;//step over to next bank because of offset
  reg stepOver2;
  reg addrCarry;//offset by one bank
  wire stepOverCmplx;
  wire stepOverCmplx2;

  wire modeCmplx_d;
  //complex mode when index register used, or offset not fit in unsigned 12-bit range

  reg [31:0] banks0;
  
  wire [4:0] bank0;
  wire [4:0] bankL1;
  wire [1:0] pageFault_t;
  reg  [1:0] pageFault_t_reg;

  wire [12:0] addrMain;
  wire [13:0] addrNext;
  wire [12:0] dummy0;
 // wire [12:0] CSAarg1;
 // wire [12:0] CSAarg2;
 // wire pageCarry;
 // wire pageCarry1;
  
//  wire [5:0] CSAbn0;
//  wire [5:0] CSAbn1;
  
  wire [TLB_IP_WIDTH-1:0] addrTlb;
  wire [TLB_DATA_WIDTH-1:0] tlb_data0;
  wire [TLB_DATA_WIDTH-1:0] tlb_data1;
  wire [TLB_DATA_WIDTH-1:0] tlb_data;
  wire [TLB_DATA_WIDTH-1:0] tlb_data_next;
  reg [TLB_DATA_WIDTH-1:0] tlb_data_reg;
  
  wire tlb_clkEn;
  wire tlb_hit;

  

  reg read_clkEn_reg;
  reg read_clkEn_reg2;
  reg [OPERATION_WIDTH-1:0] op_reg;


  wire [BANK_COUNT-1:0] all_banks;
  wire otherness;

  wire [BANK_COUNT-1:0] bit_confl;
  reg  [BANK_COUNT-1:0] bit_confl_reg;
  
  
  wire carryNext;
//  wire non_overlap;

//  reg [23:0] proc_reg;
//  reg [23:0] proc_reg2;
  
  integer i;
  
//  wire [4:0] bankNextOff;
//  wire hasBankNext;
  
  reg bus_hold_reg;
  reg bus_hold_reg2;
  
  reg [REG_WIDTH-1:0] regno_reg;
  reg [8:0] LSQ_no_reg;
  reg [9:0] II_no_reg;
  reg [7:0] WQ_no_reg;
  reg thread_reg;
  reg lsflag_reg;

  wire [1:0] rcn_mask;

  reg except_reg;
  reg except_reg2;
  reg except_thread_reg;
  reg except_thread_reg2;
  wire cout_secq;
  wire fault_cann;
  reg fault_cann_reg;

  wire [4:0] lastSz;

  reg [63:0] mflags;
  wire [63:0] mflags0;
  reg [23:0] pproc;  
  reg [23:0] sproc;  
  reg [23:0] proc;
  reg [23:0] vproc;
  wire split;
  wire [1:0] fault_tlb;
  wire [1:0] fault_tlb_next;
  generate
      genvar p,q;
      for(p=0;p<32;p=p+1) begin
          assign mOp_banks[p]=(~bus_hold_reg) ? all_banks[p] &  read_clkEn_reg
          : 1'b0;
      end

  endgenerate
 
//  assign bankNextOff=5'd2; //##
//  assign hasBankNext=1'b0;//##
  assign hasIndex=op[7:6]==2'b01;
  assign stepOverCmplx=|cmplxAddr[1:0];
  assign stepOverCmplx2=&cmplxAddr[1:0];
  assign bank0=cmplxAddr[6:2];
  assign mOp_bank0=bank0;
 
  assign lastSz[1]=(opsize==1 && stepOver2) || (opsize==2 && stepOver) || (opsize==3 && ~stepOver);
  assign lastSz[2]=opsize==3 && stepOver;
  assign lastSz[4:3]=2'b0;
  assign lastSz[0]=(opsize==0) || (opsize==1 & ~stepOver2) || (opsize==2 & ~stepOver);  
  assign mOp_split=(opsize==1) ?
    bank0==5'h1f && stepOver2 : 1'bz;
  assign mOp_split=(opsize==2) ?
    bank0==5'h1f && stepOver : 1'bz;
  assign mOp_split=(opsize==3) ?
    bank0==5'h1f || (bank0==5'h1e && stepOver) : 1'bz;
  assign mOp_split=(opsize==4) ?
    bank0[4:1]==4'hf || (bank0==5'h1d && stepOver2) : 1'bz;
  assign mOp_split=(opsize==5 || opsize==6) ?
    bank0[4:2]==3'h7 && (bank0[1:0]!=0 || stepOver || opsize==6) : 1'bz;
  assign mOp_split=(opsize==0) ? 1'b0 : 1'bz;
  
  assign all_banks=banks0;


  
  
  assign mOp_addrEven[12:8]=addrMain[7] ? addrNext[12:8] : addrMain[12:8];
  assign mOp_addrOdd[12:8]=addrMain[7] ? addrMain[12:8] : addrNext[12:8];
  
  assign mOp_odd=addrMain[7];
  assign mOp_addr_low=addrMain[1:0];
  
  assign addrTlb={proc[20:0],cmplxAddr[43:13]};

  assign tlb_data=tlb_data0;
  assign tlb_data_next=tlb_data1;

  assign mOp_type=tlb_data[`dtlbData_type];
  
  assign mOp_addrEven[43:13]=(addrMain[7] & addrNext[13]) ? tlb_data_next[`dtlbData_phys] : tlb_data[`dtlbData_phys];
  assign mOp_addrOdd[43:13]=(~(~addrMain[7] & addrNext[13])) ? tlb_data[`dtlbData_phys] : tlb_data_next[`dtlbData_phys];
  
  assign pageFault_t=(addrNext[13]) ? (fault_tlb | ({2{mOp_split}} & fault_tlb_next)) & {2{tlb_hit}} : fault_tlb & {2{tlb_hit}};
  assign pageFault=(pageFault_t_reg!=0) | fault_cann_reg && read_clkEn_reg2|mex_en_reg2 && ~bus_hold_reg2;
  assign fault_cann=~cout_secq;
  assign faultNo=fault_cann_reg | (pageFault_t_reg!=0) && ~bus_hold_reg2 ? {6'd11,1'b0,2'd1} : {6'd0,1'b0,2'd2};
  assign faultCode={3'b0,fault_cann_reg,pageFault_t_reg[1],1'b0,pageFault_t_reg[0],1'b0};

  assign mOp_addrMain={addrTlb[30:0],addrMain[12:0]};
  
  assign tlbMiss=(read_clkEn_reg)&~tlb_hit&~fault_cann&~except;
  
  assign addrMain=cmplxAddr[11+1:0];
  
  assign mOp_en=read_clkEn_reg &tlb_hit
   & rcn_mask[1] & ~bus_hold_reg;
  
  assign mOp_thread=thread_reg;
  
  assign mOp_lsflag=lsflag_reg;
  
  assign mOp_sz=op_reg[5:1];
  
  assign mOp_st=op_reg[0];
  
  assign mOp_register=regno_reg;

  assign mOp_LSQ=LSQ_no_reg;

  assign mOp_II=II_no_reg;
  
  assign mOp_WQ=WQ_no_reg;
  
  assign tlb_clkEn=read_clkEn_reg|mex_en_reg;
  
  assign doStall=1'b0;

//mOp_rsEn used as enable to wtmiss
  assign mOp_rsEn= read_clkEn_reg & rcn_mask[1] & ~bus_hold_reg;
    
  assign rcn_mask={~(except),~(except)};
  
  assign mflags0=mflags;
  
  assign fault_tlb={mflags0[`mflags_cpl]==2'd3 && tlb_data[`dtlbData_sys] , ~tlb_data[`dtlbData_na]|tlb_data[`dtlbData_wp]}; 
  assign fault_tlb_next={mflags0[`mflags_cpl]==2'd3 && tlb_data_next[`dtlbData_sys] , ~tlb_data_next[`dtlbData_na]|tlb_data_next[`dtlbData_wp]}; 

  adder #(14) nextCAddr_mod({1'b0,cmplxAddr[12:0]},14'b10000000,addrNext,1'b0,1'b1,,,,);

  agusec_range rng_mod(
  cmplxAddr,
  cin_secq,
  ptrdiff,
  cout_secq);
 
  
  dtlb tlb_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(tlb_clkEn),
  .sec_wren(cout_secq),
  .addr(addrTlb),
  .sproc(sproc[20:0]),
  .read_data(tlb_data0),
  .read_data_next(tlb_data1),
  .read_way(),
  .read_hit(tlb_hit),
  .write_addr(writeTlb_IP),
  .write_data0(writeTlb_data0),
  .write_data1(writeTlb_data1),
  .write_data2(writeTlb_data2),
  .force_way(writeTlb_force_way),
  .force_way_en(writeTlb_force_way_en),
  .write_xstant(writeTlb_force_way_en),
  .write_invl(writeTlb_force_way_en),
  .write_wen(writeTlb_wen)
  );  

  always @*
    begin
      case(opsize)
        0: begin aligned2=1'b1; tiny=1'b1; end //byte
        1: begin aligned2=~cmplxAddr[0]; tiny=1'b1; end //2 byte
        2,3,4: 
          begin 
            aligned2=cmplxAddr[1:0]==0;
            tiny=1'b0;
          end //4,8,16 byte
      endcase
    end
  
  always @*
    begin
//addrCarry=starting at +1 offset
//stepOver=step to next 4 byte for 4 byte op
              stepOver=stepOverCmplx;
              addrCarry=1'b0;
              stepOver2=stepOverCmplx2;
    end
	
  always @*
    begin
      for (i=0;i<32;i=i+1)
        begin
  /* verilator lint_off WIDTH */
          banks0[i]=bank0==i || 
          ((opsize==3 || opsize[2] || (stepOver && opsize==2) || 
            (stepOver2 && opsize==1)) && bank0==((i-1)&5'h1f)) ||
          (((opsize==3 && stepOver) | opsize[2]) && bank0==((i-2)&5'h1f)) || 
          (((opsize==4 && stepOver2) || opsize==5 || opsize==6) && bank0==((i-3)&5'h1f)) ||
          (((opsize==5 && stepOver) || opsize==6) && bank0==((i-4)&5'h1f)) ;
        end
  /* verilator lint_on WIDTH */
    end
    
  always @* begin
      case(op_reg[5:1])
         5'd16: opsize=0;
         5'd17: opsize=1;
         5'd18: opsize=2;
         5'd19: opsize=3;
         5'h3:  opsize=4; //long double
         5'h4,5'h5,5'h9,5'hd:  opsize=3; //double
         5'h6,5'he,5'h7,5'h8:  opsize=2; //single
	 5'hf: opsize=6; //fill/spill
	 default: opsize=5; //128 bit
      endcase
  end
	
  always @(posedge clk)
    begin
//	  if (rst) cmplxAddr<={ADDR_WIDTH{1'B0}};
//	  else cmplxAddr<=mex_en ? mex_addr : cmplxAddr_d;
          if (rst) mex_en_reg<=1'b0;
          else mex_en_reg<=mex_en;
          if (rst) mex_en_reg2<=1'b0;
          else mex_en_reg2<=mex_en_reg;
	  if (rst) tlb_data_reg<={TLB_DATA_WIDTH{1'B0}};
	  else tlb_data_reg<=tlb_data;

	  if (mex_en_reg && ~tlb_hit) $display("sch ",addrTlb>>1," ",tlb_clkEn); 
          if (rst) begin
             // cmplxAddr_reg<=16'b0;
              pageFault_t_reg<=2'b0;
              fault_cann_reg<=1'b0;
          end else begin
             // cmplxAddr_reg<=cmplxAddr;
              pageFault_t_reg<=pageFault_t;
              fault_cann_reg<=fault_cann;
          end


	  if (rst)
	    begin
	      //proc_reg<=15'b0;
	      //proc_reg2<=15'b0;
              op_reg<=13'b0;
              regno_reg<={REG_WIDTH{1'B0}};
              LSQ_no_reg<=9'b0;
              II_no_reg<=10'b0;
              WQ_no_reg<=8'b0;
              thread_reg<=1'b0;
              lsflag_reg<=1'b0;
	    end
	  else
	    begin
	      //proc_reg<=proc;
	      //proc_reg2<=proc_reg;
              op_reg<=op;
              regno_reg<=regno;
              LSQ_no_reg<=LSQ_no;
              II_no_reg<=II_no;
              WQ_no_reg<=WQ_no;
              thread_reg<=thread;
              lsflag_reg<=lsflag;
	    end
	  if (rst) begin
	      bus_hold_reg<=1'b0;
	      bus_hold_reg2<=1'b0;
	  end else begin
	      bus_hold_reg<=bus_hold;
	      bus_hold_reg2<=bus_hold_reg;
	  end
	  if (rst) bit_confl_reg<=32'b0;
	  else bit_confl_reg<=bit_confl;
	  
	  if (rst) begin
	      modeCmplx_reg<=1'b0;
	      read_clkEn_reg<=1'b0;
	      read_clkEn_reg2<=1'b0;
              except_reg<=1'b0;
              except_reg2<=1'b0;
              //except_thread_reg<=1'b0;
              //except_thread_reg2<=1'b0;
	  end else begin 
	      modeCmplx_reg<=modeCmplx;
              read_clkEn_reg<=read_clkEn && rcn_mask[0] & ~except_reg;
              read_clkEn_reg2<=read_clkEn_reg && rcn_mask[1];
              except_reg<=except;
              except_reg2<=except_reg;
              //except_thread_reg<=except_thread;
              //except_thread_reg2<=except_thread_reg;
	  end
          if (rst) begin
              pproc<=24'b0;
              proc<=24'b0;
              vproc<=24'b0;
              sproc<=24'b0;
              mflags<=64'b0;
          end else if (csrss_en) begin
              case(csrss_no)
           `csr_page: begin pproc<=csrss_data[63:40]; proc<=csrss_data[63:40]; sproc<=0; end
           `csr_vmpage: vproc<=csrss_data[63:40];
           `csr_mflags: mflags<=csrss_data;
              endcase
	      if (except && except_gate && ~except_in_vm) begin
		  proc<=pproc;
		  sproc<=0;
	      end
	      if (except && except_gate && except_in_vm) begin
		  proc<=vproc;
		  sproc<=pproc^1;
	      end
	      if (except && except_gate) begin
		  mflags[`mflags_cpl]<=except_in_km ? 2'b0 : 2'b11;
	      end
          end else begin
	      if (except && except_gate && ~except_in_vm) begin
		  proc<=pproc;
		  sproc<=0;
	      end
	      if (except && except_gate && except_in_vm) begin
		  proc<=vproc;
		  sproc<=pproc^1;
	      end
	      if (except && except_gate) begin
		  mflags[`mflags_cpl]<=except_in_km ? 2'b0 : 2'b11;
	      end
	  end
    end
   
endmodule
