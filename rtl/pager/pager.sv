`include "../struct.sv"
`include "../csrss_no.sv"

`define permreq_code 0
`define permreq_width 1

module pager(
  clk,
  rst,
  except,
  bus_hold,
  req_bus,
  new_en,
  new_can,
  new_addr,
  new_attr,
  new_indir,
  new_inv,
  new_permReq,
  csrss_no,
  csrss_thread,
  csrss_en,
  csrss_data,
  mOp_register,
  mOp_LSQ,
  mOp_II,
  mOp_WQ,
  mOp_addrEven,
  mOp_addrOdd,
  mOp_sz,
  mOp_st,
  mOp_en,
//  mOp_thread,
  mOp_lsflag,
  mOp_banks,
  mOp_bank0,
  mOp_odd,
  mOp_addr_low,
  mOp_split,
  FUHit,FUreg,data_in,
  writeTlb_IP,
  writeTlb_low,
  writeTlb_wen,
  writeTlb_wen_c,
  writeTlb_wenH_c,
  writeTlb_data0,
  writeTlb_data1,
  writeTlb_data2
  );

  parameter INDEX=0; //0 1 2 
  localparam ADDR_WIDTH=64;
  localparam PADDR_WIDTH=44;
  localparam OPERATION_WIDTH=`operation_width;
  localparam BANK_COUNT=32;
  localparam TLB_DATA_WIDTH=`dtlbData_width;
  localparam TLB_IP_WIDTH=52;
  localparam REG_WIDTH=`reg_addr_width;
  localparam PERM_WIDTH=`permreq_width;

  input clk;
  input rst;
  input except;
  input bus_hold;
  output req_bus;
  input new_en;
  output reg new_can;
  input [47:0] new_addr;
  input [3:0] new_attr;
  input new_indir;
  input new_inv;
  input [PERM_WIDTH-1:0] new_permReq;
  input [15:0] csrss_no;
  input csrss_thread;
  input csrss_en;
  input [63:0] csrss_data;
  output [REG_WIDTH-1:0] mOp_register;
  output [8:0] mOp_LSQ;
  output [9:0] mOp_II;
  output [7:0] mOp_WQ;
  output [PADDR_WIDTH-1:8] mOp_addrEven;
  output [PADDR_WIDTH-1:8] mOp_addrOdd;
  output [4:0] mOp_sz;
  output mOp_st;
  output mOp_en;
 // output mOp_thread;
  output mOp_lsflag;
  output [BANK_COUNT-1:0] mOp_banks;
  output [4:0] mOp_bank0;
  output mOp_odd;
  output [1:0] mOp_addr_low;
  output mOp_split;
  input FUHit;
  input [REG_WIDTH-1:0] FUreg;
  input [127:0] data_in;
  output [TLB_IP_WIDTH-2:0] writeTlb_IP;
  output writeTlb_low;
  output writeTlb_wen;
  output writeTlb_wen_c;
  output writeTlb_wenH_c;
  output [TLB_DATA_WIDTH-1:0] writeTlb_data0;
  output [TLB_DATA_WIDTH-1:0] writeTlb_data1;
  output [TLB_DATA_WIDTH-1:0] writeTlb_data2;

  //reg [1:0] pg;
  //reg [1:0] vm;
  //reg [1:0] codeInVm;
  reg [63:0] mflags;
  reg [63:0] PTR[1:0];
  reg [63:0] VPTR[1:0];
  reg [63:0] CPTR;
  reg [63:0] CMSK;
  reg [63:0] IPTR;
  reg [63:0] IMSK;
  reg [63:0] ptr;
  reg [63:0] ptr2;
  reg [63:0] ptrB;
  reg do_ptr2;
  reg [63:0] SPTR;
  reg [20:0] sptr;
  reg [11:0] stageA;
  reg [7:0] stageB;
  reg [7:0] stageB_pre;
  reg stageA_running;
  reg [47:0] addr;
  reg [47:0] addrB;
  reg thread;
  integer p,q;
  reg [31:0] banks;
  
  reg [30:0] finalAddr0; 
  reg [30:0] finalAddr1; 
  reg [30:0] finalAddr2;
  reg [12:0] finalXtra0; 
  reg [12:0] finalXtra1; 
  reg [12:0] finalXtra2;
  reg finalSub0,finalSub1,finalSub2;
  reg finalHug0;
  
  wire [47:0] addr_inc_d;
  reg [47:0] addr_inc; 
  wire [47:0] addr_inc2_d;
  reg [47:0] addr_inc2; 
  wire [4:0] addrE; 
  wire [4:0] addrO; 
  reg [47:0] addr_orig; 
  reg [47:0] addr_orig_inc; 
  reg [REG_WIDTH-1:0] mOp_register_reg;
  reg [REG_WIDTH-1:0] mOp_register_reg2;
  reg [REG_WIDTH-1:0] mOp_register_reg3;
  reg new_en_reg;
  reg ready;
  reg [PERM_WIDTH-1:0] permReq;
  wire all_shr=finalXtra0[`page_global] && finalHug0|finalXtra1[`page_global]
  &&  permReq[`permreq_code]|finalXtra2[`page_global];
  reg [63:0] data_in_reg;
  reg new_inv_reg;

  assign writeTlb_data0[`dtlbData_sys]=finalXtra0[`page_sys];  
  assign writeTlb_data0[`dtlbData_wp]=finalXtra0[`page_wr];  
  assign writeTlb_data0[`dtlbData_na]=finalXtra0[`page_na] && ~new_inv_reg;  
  assign writeTlb_data0[`dtlbData_ne]=finalXtra0[12];  
  assign writeTlb_data0[`dtlbData_acc]=finalXtra0[`page_accessed];  
  assign writeTlb_data0[`dtlbData_wrt]=finalXtra0[`page_dirty];  
  assign writeTlb_data0[`dtlbData_glo]=finalXtra0[`page_global];  
  assign writeTlb_data0[`dtlbData_type]={finalXtra0[`page_nc],finalXtra0[`page_wt]};  
  assign writeTlb_data0[`dtlbData_subpage]=finalSub0;  
  assign writeTlb_data0[`dtlbData_phys]=finalAddr0;  
  
  assign writeTlb_data1[`dtlbData_sys]=finalXtra1[`page_sys];  
  assign writeTlb_data1[`dtlbData_wp]=finalXtra1[`page_wr];  
  assign writeTlb_data1[`dtlbData_na]=finalXtra1[`page_na] && ~new_inv_reg;  
  assign writeTlb_data1[`dtlbData_ne]=finalXtra1[12];  
  assign writeTlb_data1[`dtlbData_acc]=finalXtra1[`page_accessed];  
  assign writeTlb_data1[`dtlbData_wrt]=finalXtra1[`page_dirty];  
  assign writeTlb_data1[`dtlbData_glo]=finalXtra1[`page_global];  
  assign writeTlb_data1[`dtlbData_type]={finalXtra1[`page_nc],finalXtra1[`page_wt]};  
  assign writeTlb_data1[`dtlbData_subpage]=finalSub1;  
  assign writeTlb_data1[`dtlbData_phys]=finalAddr1;  
 
  assign writeTlb_data2[`dtlbData_sys]=finalXtra2[`page_sys];  
  assign writeTlb_data2[`dtlbData_wp]=finalXtra2[`page_wr];  
  assign writeTlb_data2[`dtlbData_na]=finalXtra2[`page_na] && ~new_inv_reg;  
  assign writeTlb_data2[`dtlbData_ne]=finalXtra2[12];  
  assign writeTlb_data2[`dtlbData_acc]=finalXtra2[`page_accessed];  
  assign writeTlb_data2[`dtlbData_wrt]=finalXtra2[`page_dirty];  
  assign writeTlb_data2[`dtlbData_glo]=finalXtra2[`page_global];  
  assign writeTlb_data2[`dtlbData_type]={finalXtra2[`page_nc],finalXtra2[`page_wt]};  
  assign writeTlb_data2[`dtlbData_subpage]=finalSub2;  
  assign writeTlb_data2[`dtlbData_phys]=finalAddr2;  

  assign writeTlb_wen=ready & (permReq==0);
 // assign writeTlb_wenW=ready & permReq[`permreq_store] & ~new_inv_reg;
 // assign writeTlb_invW=ready & new_inv_reg;
  assign writeTlb_wen_c=ready & ~finalHug0 & permReq[`permreq_code];
  assign writeTlb_wenH_c=ready & finalHug0 & permReq[`permreq_code];
 
  assign writeTlb_IP[TLB_IP_WIDTH-2:TLB_IP_WIDTH-22]=all_shr ? SPTR[60:40] :
    PTR[1][60:40];
  assign writeTlb_IP[TLB_IP_WIDTH-23:0]=addr_orig[43:14];
  assign writeTlb_low=addr_orig[13];
  assign req_bus=(stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold;
  
  assign mOp_register=((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 9'h1fc : 9'bz;
  assign mOp_LSQ=((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 9'h07 : 9'bz; 
  assign mOp_II=((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 10'h0 : 10'bz; 
  assign mOp_WQ=((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 8'h0 : 8'bz; 
  assign mOp_addrEven=((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
    {ptr[43:13],addrE} : 36'bz;
  assign mOp_addrOdd= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
    {ptr[43:13],addrO} : 36'bz;
//  assign mOp_addrMain= stageA|{4'b0,stageB} && ~stageA_running && ~bus_hold ? 
//    64'b0 : 64'bz;
  assign mOp_sz= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
    (stageA[3] ? 5'h0 : 5'h13) : 5'bz;
//  assign mOp_en= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
//    1'b0 : 1'bz;
  assign mOp_en= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
    1'b1 : 1'bz;
//  assign mOp_thread= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
//    thread : 1'bz;
  assign mOp_lsflag= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
    1'b1 : 1'bz;
  assign mOp_banks= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
      banks : 32'bz;
  assign mOp_bank0= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
    {addr[36:33],1'b0} : 5'bz;
  assign mOp_odd= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
    addr[37] : 1'bz;
  assign mOp_addr_low= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
    2'b0 : 2'bz;
  assign mOp_split= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
    1'b0 : 1'bz;

  adder_inc #(34) addrB_mod(new_addr[47:14],addr_inc_d[47:14],1'b1,);
  adder_inc #(25) addrBH_mod(new_addr[47:23],addr_inc2_d[47:23],1'b1,);

  assign addr_inc_d[13:0]=addr[13:0];
  assign addr_inc2_d[22:0]=addr[22:0];

  assign addrE=addr[42:38];
  assign addrO=addr[42:38];

  always @(banks,addr,stageA) begin
      for(p=0;p<32;p=p+1) begin
          q=p-2;
          banks[p]=addr[36:33]==p[4:1] ||
          stageA[2] & (addr[36:34]==q[4:2]);
      end
  end
  always @(posedge clk) begin
      if (writeTlb_wen) begin
          $display("tlb ip ",writeTlb_IP," ",new_inv_reg);
          $display("data 0: ",writeTlb_data0);
          $display("data 1: ",writeTlb_data1);
          $display("data 2: ",writeTlb_data2);
      end
      if (rst) begin
       //   new_can<=1'b1;
          ptr<=64'b0;
          ptr2<=64'b0;
          ptrB<=64'b0;
          addr<=48'b0;
          addr_inc<=48'b0;
//          addr_inc2<=48'b0;
          addr_orig<=48'b0;
          addrB<=48'b0;
          do_ptr2<=1'b0;
          stageA<=12'b0;
          stageB<=8'b0;
          stageA_running<=1'b0;
          stageB_pre<=8'b0;
          //thread<=1'b0;
          sptr<=21'b0;
          finalAddr0<=31'b0;
          finalXtra0<=13'b0;
          finalAddr1<=31'b0;
          finalXtra1<=13'b0;
          finalAddr2<=31'b0;
          finalXtra2<=13'b0;
          finalHug0<=1'b0;
          finalSub0<=1'b0;
          finalSub1<=1'b0;
          finalSub2<=1'b0;
          permReq<=1'b0;
          data_in_reg<=64'b0;
          new_inv_reg<=1'b0;
      end else if (new_en&new_can) begin
         // new_can<=1'b0;
	  $display("<new>");
          if (new_permReq[`permreq_code]) begin
              if (new_attr[`attr_vm]) ptr<={12'b0,VPTR[new_addr[43]][38:0],13'b0};
              else ptr<={12'b0,PTR[new_addr[43]][38:0],13'b0};
          end else begin
              ptr<= new_attr[`attr_vm]? {12'b0,VPTR[new_addr[43]][38:0],13'b0} : 
		      {12'b0,PTR[new_addr[43]][38:0],13'b0};
          end
	  //up to horo
          new_inv_reg<=new_inv;
          if (mflags[`mflags_pg] && ~new_inv) begin
              stageA<=12'b1;
          end else begin
              finalAddr0<={new_addr[43:14],1'b0};
              finalAddr1<={new_addr[43:14],1'b1};
              finalAddr2<={addr_inc_d[43:14],1'b0};
              finalHug0<=1'b0;
              finalSub0<=1'b0;
              finalSub1<=1'b0;
              finalSub2<=1'b0;
	      if (&new_addr[43:40]) begin
                  finalXtra0<=13'b0000101110101;
                  finalXtra1<=13'b0000101110101;
                  finalXtra2<=13'b0000101110101;
	      end else begin
                  finalXtra0<=13'b0000101100101;
                  finalXtra1<=13'b0000101100101;
                  finalXtra2<=13'b0000101100101;
              end
          end
          stageA_running<=1'b0;
          sptr<=SPTR[60:40];
          //thread<=new_thread;
          addr<=new_addr;
          addr_inc<=addr_inc_d;
          addr_orig<=new_addr;
          permReq<=new_permReq;
          ptrB<=ptr;
      end else if ((stageA!=0||stageB!=0) && ~stageA_running && ~bus_hold) begin
          stageA_running<=1'b1;
         // $display("bump");
      end else begin
          //if (FUHit)  $display("bmup ",FUreg," ",data_in);
          if (FUreg==9'h1fc && stageA_running && FUHit) begin
              if ((stageA[1:0]!=0) && ~data_in[`page_huge] && data_in[`page_na]) begin
                  addr<={addr[37:0],10'b0};
                  addr_inc<={addr_inc[37:0],10'b0};
                  ptr[47:0]<={data_in[47:13],13'b0};
                  stageA_running<=1'b0;
                  stageA<={stageA[10:0],1'b0};
                  if (addr[42:33]==addr_inc[42:33]) begin 
                      stageB_pre<=stageA[7:0];
                      ptrB[47:0]<={data_in[47:13],13'b0};
                      addrB<=addr_inc;
                  end
                  $display("burp");
              end else if (stageA[2] | data_in[`page_huge] && data_in[`page_na] && stageA[2:1]!=0) begin
                 // ready<=1'b1;
                  finalAddr0<=data_in[43:13];
                  finalXtra0<={data_in[10],data_in[11:0]};
                  //finalHug0<=~stageA[2];
                  finalSub0<=stageA[1];
                  finalAddr1<=data_in[43+64:13+64];
                  finalXtra1<={data_in[10+64],data_in[11+64:64]};
                  stageB<={stageB_pre[6:0],1'b0};
                  addr<={addrB[37:0],10'b0};
                  stageA_running<=1'b0;
                  stageA<=12'b0;
                  ptr[47:0]<=ptrB[47:0];
	          if (stageA[1]) begin
	              addr[32:23]<=addr_orig[32:23];
		      finalAddr0[19:10]<=addr_orig[32:23];
		      finalAddr1[19:10]<=addr_orig[32:23];
	          end
                    //  new_can<=1'b1;
              end else if (stageB[1:0]!=0 && ~data_in[`page_huge] && data_in[`page_na]) begin
                  addr<={addr[37:0],10'b0};
                  addr_inc<={addr_inc[37:0],10'b0};
                  ptr[47:0]<={4'b0,data_in[43:13],13'b0};
                  stageA_running<=1'b0;
                  stageB<={stageB[6:0],1'b0};
              end else if (stageB[2] | data_in[`page_huge] && data_in[`page_na] && stageB[2:1]!=0) begin
                  stageB<=8'b0;
                  finalAddr2<=data_in[43:13];
                  finalXtra2<={data_in[10],data_in[11:0]};
                  finalSub2<=stageB[1];
	          if (stageB[1]) begin
	              addr[32:23]<=addr_orig[32:23];
		      finalAddr2[19:10]<=addr_orig_inc[32:23];
	          end
                     // new_can<=1'b1;
	      end else if (stageB!=0 && ~data_in[`page_na]) begin
                  stageB<=8'b0;
                  finalAddr2<=31'b0;
                  finalXtra2<=13'b0;
                  finalSub2<=stageB[1];
              end else begin
                  finalXtra2<=13'b0;
                  finalXtra1<=13'b0;
                  finalXtra0<=13'0;
                  stageA<=12'b0;
                  stageB<=8'b0;
              end
          end
      end
      if (rst) new_can<=1'b1;
      else if (new_en&new_can) new_can<=1'b0;
      else if (stageA==0 && stageB==0) new_can<=1'b1;
      if (rst) ready<=1'b0;
      else if (stageA==0 && stageB==0 && ~new_can) ready<=1'b1;
      else ready<=1'b0;
      if (rst) begin
        //  new_en_reg<=1'b0;
          addr_inc<=48'b0;
          addr_inc2<=48'b0;
	  addr_orig_inc<=48'b0;
      end else begin
        //  new_en_reg<=new_en;
          if (new_en & new_can) addr_inc<=addr_inc_d;
          if (new_en & new_can) addr_orig_inc<=addr_inc_d;
          if (new_en & new_can) addr_inc2<=addr_inc2_d;
      end
      if (rst) begin
          PTR[0]<=0;
          VPTR[0]<=0;
          PTR[1]<=0;
          VPTR[1]<=0;
          //CPTR<=0;
          SPTR<=0;
          //CMSK<=0;
          //IPTR<=0;
          //IMSK<=0;
      end else if (csrss_en) begin
          if (csrss_no==`csr_page) begin PTR[1]<=csrss_data; mflags[`mflags_pg]<=1'b1; 
              $display("pg ",csrss_data); end
          if (csrss_no==`csr_vmpage) begin 
              VPTR[1]<=csrss_data;
          end
          if (csrss_no==`csr_page0) begin PTR[0]<=csrss_data; mflags[`mflags_pg]<=1'b1; 
              $display("pg1 ",csrss_data); end
          if (csrss_no==`csr_vmpage0) begin 
              VPTR[0]<=csrss_data;
          end
      end 
      
  end
endmodule
