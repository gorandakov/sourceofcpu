/*
Copyright 2022 Goran Dakov

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/


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
  output [2:0] req_bus;
  input [2:0]new_en;
  output reg[2:0] new_can;
  input[2:0] [47:0] new_addr;
  input[2:0] [3:0] new_attr;
  input[2:0] new_indir;
  input[2:0] new_inv;
  input[2:0] [PERM_WIDTH-1:0] new_permReq;
  input [15:0] csrss_no;
  input csrss_thread;
  input csrss_en;
  input [63:0] csrss_data;
  output [REG_WIDTH-1:0] mOp_register;
  output [8:0] mOp_LSQ;
  output [9:0] mOp_II;
  output [5:0] mOp_WQ;
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
  output[2:0] [TLB_IP_WIDTH-2:0] writeTlb_IP;
  output[2:0] writeTlb_low;
  output[2:0] writeTlb_wen;
  output[2:0] writeTlb_wen_c;
  output[2:0] writeTlb_wenH_c;
  output[2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data0;
  output[2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data1;
  output[2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data2;

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
  reg[2:0] [63:0] ptr;
  reg[2:0] [63:0] ptr2;
  reg[2:0] [63:0] ptrB;
  reg[2:0] do_ptr2;
  reg [63:0] SPTR;
  reg [20:0] sptr;
  reg[2:0] [11:0] stageA;
  reg[2:0] [7:0] stageB;
  reg[2:0] [7:0] stageB_pre;
  reg[2:0] stageA_running;
  reg[2:0] [47:0] addr;
  reg[2:0] [47:0] addrB;
  reg thread;
  integer p,q;
  reg [31:0] banks;
  
  reg[2:0] [30:0] finalAddr0; 
  reg[2:0] [30:0] finalAddr1; 
  reg[2:0] [30:0] finalAddr2;
  reg[2:0] [12:0] finalXtra0; 
  reg[2:0] [12:0] finalXtra1; 
  reg[2:0] [12:0] finalXtra2;
  reg[2:0] finalSub0;
  reg[2:0] finalSub1;
  reg[2:0] finalSub2;
  reg[2:0] finalHug0;
  
  wire[2:0] [47:0] addr_inc_d;
  reg[2:0] [47:0] addr_inc; 
  wire[2:0] [47:0] addr_inc2_d;
  reg[2:0] [47:0] addr_inc2; 
  wire[2:0] [4:0] addrE; 
  wire[2:0] [4:0] addrO; 
  reg[2:0] [47:0] addr_orig; 
  reg[2:0] [47:0] addr_orig_inc; 
  reg [REG_WIDTH-1:0] mOp_register_reg;
  reg [REG_WIDTH-1:0] mOp_register_reg2;
  reg [REG_WIDTH-1:0] mOp_register_reg3;
  reg[2:0] new_en_reg;
  reg[2:0] ready;
  reg[2:0] [PERM_WIDTH-1:0] permReq;
  wire[2:0] all_shr;
  reg [63:0] data_in_reg;
  reg[2:0] new_inv_reg;

  integer k;
  always @* begin
      all_shr[k]=finalXtra0[k][`page_global] && finalHug0[k]|finalXtra1[k][`page_global]
    &&  permReq[k][`permreq_code]|finalXtra2[k][`page_global];
      writeTlb_data0[k][`dtlbData_sys]=finalXtra0[k][`page_sys];  
      writeTlb_data0[k][`dtlbData_wp]=finalXtra0[k][`page_wr];  
      writeTlb_data0[k][`dtlbData_na]=finalXtra0[k][`page_na] && ~new_inv_reg;  
      writeTlb_data0[k][`dtlbData_ne]=finalXtra0[k][12];  
      writeTlb_data0[k][`dtlbData_acc]=finalXtra0[k][`page_accessed];  
      writeTlb_data0[k][`dtlbData_wrt]=finalXtra0[k][`page_dirty];  
      writeTlb_data0[k][`dtlbData_glo]=finalXtra0[k][`page_global];  
      writeTlb_data0[k][`dtlbData_type]={finalXtra0[k][`page_nc],finalXtra0[k][`page_wt]};  
      writeTlb_data0[k][`dtlbData_subpage]=finalSub0;  
      writeTlb_data0[k][`dtlbData_phys]=finalAddr0;  
  
      writeTlb_data1[k][`dtlbData_sys]=finalXtra1[k][`page_sys];  
      writeTlb_data1[k][`dtlbData_wp]=finalXtra1[k][`page_wr];  
      writeTlb_data1[k][`dtlbData_na]=finalXtra1[k][`page_na] && ~new_inv_reg;  
      writeTlb_data1[k][`dtlbData_ne]=finalXtra1[k][12];  
      writeTlb_data1[k][`dtlbData_acc]=finalXtra1[k][`page_accessed];  
      writeTlb_data1[k][`dtlbData_wrt]=finalXtra1[k][`page_dirty];  
      writeTlb_data1[k][`dtlbData_glo]=finalXtra1[k][`page_global];  
      writeTlb_data1[k][`dtlbData_type]={finalXtra1[k][`page_nc],finalXtra1[k][`page_wt]};  
      writeTlb_data1[k][`dtlbData_subpage]=finalSub1;  
      writeTlb_data1[k][`dtlbData_phys]=finalAddr1;  
 
      writeTlb_data2[k][`dtlbData_sys]=finalXtra2[k][`page_sys];  
      writeTlb_data2[k][`dtlbData_wp]=finalXtra2[k][`page_wr];  
      writeTlb_data2[k][`dtlbData_na]=finalXtra2[k][`page_na] && ~new_inv_reg;  
      writeTlb_data2[k][`dtlbData_ne]=finalXtra2[k][12];  
      writeTlb_data2[k][`dtlbData_acc]=finalXtra2[k][`page_accessed];  
      writeTlb_data2[k][`dtlbData_wrt]=finalXtra2[k][`page_dirty];  
      writeTlb_data2[k][`dtlbData_glo]=finalXtra2[k][`page_global];  
      writeTlb_data2[k][`dtlbData_type]={finalXtra2[k][`page_nc],finalXtra2[k][`page_wt]};  
      writeTlb_data2[k][`dtlbData_subpage]=finalSub2;  
      writeTlb_data2[k][`dtlbData_phys]=finalAddr2;  

      writeTlb_wen[k]=ready[k] & (permReq[k]==0);
 //     writeTlb_wenW=ready & permReq[k][`permreq_store] & ~new_inv_reg;
 //     writeTlb_invW=ready & new_inv_reg;
      writeTlb_wen_c[k]=ready[k] & ~finalHug0[k] & permReq[k][`permreq_code];
      writeTlb_wenH_c[k]=ready[k] & finalHug0[k] & permReq[k][`permreq_code];
 
      writeTlb_IP[k][TLB_IP_WIDTH-2:TLB_IP_WIDTH-22]=all_shr[k] ? SPTR[60:40] :
    PTR[1][60:40];
      writeTlb_IP[k][TLB_IP_WIDTH-23:0]=addr_orig[k][43:14];
      writeTlb_low[k]=addr_orig[k][13];
  end
  assign req_bus[0]=(stageA[0]|{4'b0,stageB[0]})!=0 && ~stageA_running[0] && ~bus_hold;
  assign req_bus[1]=(stageA[1]|{4'b0,stageB[1]})!=0 && ~stageA_running[1] && ~bus_hold && ~req_bus[0];
  assign req_bus[2]=(stageA[2]|{4'b0,stageB[2]})!=0 && ~stageA_running[2] && ~bus_hold && ~|req_bus[1:0];
  
  assign mOp_register=|req_bus ? 9'h1fc+{7'b0,req_bus[2],req_bus[1]} : 9'bz;
  assign mOp_LSQ=|req_bus ? 9'h07 : 9'bz; 
  assign mOp_II=|req_bus ? 10'h0 : 10'bz; 
  assign mOp_WQ=|req_bus ? 6'h0 : 6'bz; 
  assign mOp_addrEven=|req_bus ? 
    {ptr[{req_bus[2],req_bus[1]}][43:13],addrE[{req_bus[2],req_bus[1]}]} : 36'bz;
  assign mOp_addrOdd= |req_bus ? 
    {ptr[{req_bus[2],req_bus[1]}][43:13],addrO[{req_bus[2],req_bus[1]}]} : 36'bz;

//  assign mOp_addrMain= stageA|{4'b0,stageB} && ~stageA_running && ~bus_hold ? 
//    64'b0 : 64'bz;
  assign mOp_sz= |req_bus ? 
    (stageA[{req_bus[2],req_bus[1]}][3] ? 5'h0 : 5'h13) : 5'bz;
//  assign mOp_en= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
//    1'b0 : 1'bz;
  assign mOp_en= |req_bus ? 
    1'b1 : 1'bz;
//  assign mOp_thread= ((stageA|{4'b0,stageB})!=0 && ~stageA_running && ~bus_hold) ? 
//    thread : 1'bz;
  assign mOp_lsflag= |req_bus ? 
    1'b1 : 1'bz;
  assign mOp_banks= |req_bus ? 
      banks[{req_bus[2],req_bus[1]}] : 32'bz;
  assign mOp_bank0= |req_bus ? 
    {addr[{req_bus[2],req_bus[1]}][36:33],1'b0} : 5'bz;
  assign mOp_odd= |req_bus ? 
    addr[{req_bus[2],req_bus[1]}][37] : 1'bz;
  assign mOp_addr_low= |req_bus ? 
    2'b0 : 2'bz;
  assign mOp_split= |req_bus ? 
    1'b0 : 1'bz;

  generate
    genvar t;
    for(t=0;t<3;t=t+1) begin : adders_gen
        adder_inc #(34) addrB_mod(new_addr[t][47:14],addr_inc_d[t][47:14],1'b1,);
        adder_inc #(25) addrBH_mod(new_addr[t][47:23],addr_inc2_d[t][47:23],1'b1,);

        assign addr_inc_d[t][13:0]=addr[t][13:0];
        assign addr_inc2_d[t][22:0]=addr[t][22:0];

        assign addrE=addr[t][42:38];
        assign addrO=addr[t][42:38];
    end
  endgenerate

  integer l,y;
  always @(banks,addr,stageA) begin
    for(l=0;l<3;l=l+1) begin
        for(p=0;p<32;p=p+1) begin
            q=p-2;
            banks[l][p]=addr[l][36:33]==p[4:1] ||
            stageA[l][2] & (addr[l][36:34]==q[4:2]);
        end
    end
  end
  always @(posedge clk) begin
    for(y=0;y<3;y=y+1) begin
      if (writeTlb_wen[y]) begin
          $display("tlb ip 0x%x",writeTlb_IP," ",new_inv_reg[y],y);
          $display("data 0: 0x%x",writeTlb_data0[y],y);
          $display("data 1: 0x%x",writeTlb_data1[y],y);
          $display("data 2: 0x%x",writeTlb_data2[y],y);
      end
      if (rst) begin
       //   new_can[y]<=1'b1;
          ptr[y]<=64'b0;
          ptr2[y]<=64'b0;
          ptrB[y]<=64'b0;
          addr[y]<=48'b0;
          addr_inc[y]<=48'b0;
//          addr_inc2[y]<=48'b0;
          addr_orig[y]<=48'b0;
          addrB[y]<=48'b0;
          do_ptr2[y]<=1'b0;
          stageA[y]<=12'b0;
          stageB[y]<=8'b0;
          stageA_running[y]<=1'b0;
          stageB_pre[y]<=8'b0;
          //thread[y]<=1'b0;
          sptr[y]<=21'b0;
          finalAddr0[y]<=31'b0;
          finalXtra0[y]<=13'b0;
          finalAddr1[y]<=31'b0;
          finalXtra1[y]<=13'b0;
          finalAddr2[y]<=31'b0;
          finalXtra2[y]<=13'b0;
          finalHug0[y]<=1'b0;
          finalSub0[y]<=1'b0;
          finalSub1[y]<=1'b0;
          finalSub2[y]<=1'b0;
          permReq[y]<=1'b0;
          data_in_reg[y]<=64'b0;
          new_inv_reg[y]<=1'b0;
      end else if (new_en&new_can) begin
         // new_can[y]<=1'b0;
	  $display("<new>");
          if (new_permReq[y][`permreq_code]) begin
              if (new_attr[y][`attr_vm]) ptr[y]<={12'b0,VPTR[new_addr[43]][38:0],13'b0};
              else ptr[y]<={12'b0,PTR[new_addr[43]][38:0],13'b0};
          end else begin
              ptr[y]<= new_attr[y][`attr_vm]? {12'b0,VPTR[new_addr[43]][38:0],13'b0} : 
		      {12'b0,PTR[new_addr[43]][38:0],13'b0};
          end
	  //up to horo
          new_inv_reg[y]<=new_inv;
          if (mflags[`mflags_pg] && ~new_inv) begin
              stageA[y]<=12'b1;
          end else begin
              finalAddr0[y]<={new_addr[y][43:14],1'b0};
              finalAddr1[y]<={new_addr[y][43:14],1'b1};
              finalAddr2[y]<={addr_inc_d[y][43:14],1'b0};
              finalHug0[y]<=1'b0;
              finalSub0[y]<=1'b0;
              finalSub1[y]<=1'b0;
              finalSub2[y]<=1'b0;
	      if (&new_addr[y][43:40]) begin
                  finalXtra0[y]<=13'b0000101110101;
                  finalXtra1[y]<=13'b0000101110101;
                  finalXtra2[y]<=13'b0000101110101;
	      end else begin
                  finalXtra0[y]<=13'b0000101100101;
                  finalXtra1[y]<=13'b0000101100101;
                  finalXtra2[y]<=13'b0000101100101;
              end
          end
          stageA_running[y]<=1'b0;
          sptr[y]<=SPTR[60:40];
          //thread[y]<=new_thread;
          addr[y]<=new_addr[y];
          addr_inc[y]<=addr_inc_d[y];
          addr_orig[y]<=new_addr[y];
          permReq[y]<=new_permReq[y];
          ptrB[y]<=ptr[y];
      end else if (req_bus[y]) begin
          stageA_running[y]<=1'b1;
         // $display("bump");
      end else begin
          //if (FUHit)  $display("bmup ",FUreg," ",data_in);
          if (FUreg==(9'h1fc+y) && stageA_running[y] && FUHit) begin
              if ((stageA[y][1:0]!=0) && ~data_in[`page_huge] && data_in[`page_na]) begin
                  addr[y]<={addr[y][37:0],10'b0};
                  addr_inc[y]<={addr_inc[y][37:0],10'b0};
                  ptr[y][47:0]<={data_in[y][47:13],13'b0};
                  stageA_running[y]<=1'b0;
                  stageA[y]<={stageA[y][10:0],1'b0};
                  if (addr[y][42:33]==addr_inc[y][42:33]) begin 
                      stageB_pre[y]<=stageA[y][7:0];
                      ptrB[y][47:0]<={data_in[47:13],13'b0};
                      addrB[y]<=addr_inc[y];
                  end
                  $display("burp");
              end else if (stageA[2] | data_in[`page_huge] && data_in[`page_na] && stageA[2:1]!=0) begin
                 // ready[y]<=1'b1;
                  finalAddr0[y]<=data_in[43:13];
                  finalXtra0[y]<={data_in[10],data_in[11:0]};
                  //finalHug0[y]<=~stageA[2];
                  finalSub0[y]<=stageA[y][1];
                  finalAddr1[y]<=data_in[43+64:13+64];
                  finalXtra1[y]<={data_in[10+64],data_in[11+64:64]};
                  stageB[y]<={stageB_pre[y][6:0],1'b0};
                  addr[y]<={addrB[y][37:0],10'b0};
                  stageA_running[y]<=1'b0;
                  stageA[y]<=12'b0;
                  ptr[47:0][y]<=ptrB[y][47:0];
	          if (stageA[y][1]) begin
	              addr[y][32:23]<=addr_orig[y][32:23];
		      finalAddr0[y][19:10][y]<=addr_orig[y][32:23];
		      finalAddr1[y][19:10]<=addr_orig[y][32:23];
	          end
                    //  new_can[y]<=1'b1;
              end else if (stageB[y][1:0]!=0 && ~data_in[`page_huge] && data_in[`page_na]) begin
                  addr[y]<={addr[y][37:0],10'b0};
                  addr_inc[y]<={addr_inc[y][37:0],10'b0};
                  ptr[47:0][y]<={4'b0,data_in[43:13],13'b0};
                  stageA_running[y]<=1'b0;
                  stageB[y]<={stageB[y][6:0],1'b0};
              end else if (stageB[y][2] | data_in[`page_huge] && data_in[`page_na] && stageB[y][2:1]!=0) begin
                  stageB[y]<=8'b0;
                  finalAddr2[y]<=data_in[43:13];
                  finalXtra2[y]<={data_in[10],data_in[11:0]};
                  finalSub2[y]<=stageB[y][1];
	          if (stageB[y][1]) begin
	              addr[y][32:23]<=addr_orig[y][32:23];
		      finalAddr2[y][19:10]<=addr_orig_inc[y][32:23];
	          end
                     // new_can[y]<=1'b1;
	      end else if (stageB[y]!=0 && ~data_in[`page_na]) begin
                  stageB[y]<=8'b0;
                  finalAddr2[y]<=31'b0;
                  finalXtra2[y]<=13'b0;
                  finalSub2[y]<=stageB[1];
              end else begin
                  finalXtra2[y]<=13'b0;
                  finalXtra1[y]<=13'b0;
                  finalXtra0[y]<=13'b0;
                  stageA[y]<=12'b0;
                  stageB[y]<=8'b0;
              end
          end
      end
      if (rst) new_can[y]<=1'b1;
      else if (new_en[y]&new_can[y]) new_can[y]<=1'b0;
      else if ((stageA[y]==0 && stageB[y]==0)||~mflags[`mflags_pg]) new_can[y]<=1'b1;
      if (rst) ready[y]<=1'b0;
      else if (stageA[y]==0 && stageB[y]==0 && ~new_can[y]) ready[y]<=1'b1;
      else ready[y]<=1'b0;
      if (rst) begin
        //  new_en_reg[y]<=1'b0;
          addr_inc[y]<=48'b0;
          addr_inc2[y]<=48'b0;
	  addr_orig_inc[y]<=48'b0;
      end else begin
        //  new_en_reg[y]<=new_en;
          if (new_en[y] & new_can[y]) addr_inc[y]<=addr_inc_d[y];
          if (new_en[y] & new_can[y]) addr_orig_inc[y]<=addr_inc_d[y];
          if (new_en[y] & new_can[y]) addr_inc2[y]<=addr_inc2_d[y];
      end
  end
      if (rst) begin
          PTR[0]<=0;
          VPTR[0]<=0;
          PTR[1]<=0;
          VPTR[1]<=0;
          //CPTR<=0;
          SPTR<=0;
	  mflags<=64'b0;
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
