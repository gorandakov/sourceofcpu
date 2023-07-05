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

module ctlb_ram(
  clk,
  rst,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=`ctlb_width;
  localparam ADDR_WIDTH=6;
  localparam ADDR_COUNT=64;
  
  input clk;
  input rst;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  
  assign read_data=ram[read_addr];

  always @(posedge clk)
    begin
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule


module ctlb_way(
  clk,
  rst,
  read_clkEn,
  fStall,
  addr,
  tr_jump,
  sproc,
  read_data,
  read_lru,
  read_hit,
  write_data,
  write_wen,
  write_tr,
  invalidate,
  init,
  newLRU
  );

  parameter WAYNO=0;
  localparam DATA_WIDTH=`ctlb_width;
  localparam OUTDATA_WIDTH=`ctlbData_width;
  localparam IP_WIDTH=65;
  localparam ADDR_WIDTH=5;

  
  input clk;
  input rst;
  input read_clkEn;
  input fStall;
  input [IP_WIDTH-1:0] addr;
  input tr_jump;
  input [20:0] sproc;
  output [OUTDATA_WIDTH-1:0] read_data;
  output [1:0] read_lru;
  output read_hit;
  input [OUTDATA_WIDTH-1:0] write_data;
  input write_wen;
  input write_tr;
  input invalidate;
  input init;
  input [1:0] newLRU;
  
  wire valid;
  wire [IP_WIDTH-1:0] ip;
  wire write_wen_ram;
  wire [DATA_WIDTH-1:0] read_data_ram;
  wire [DATA_WIDTH-1:0] write_data_ram;
  wire [DATA_WIDTH-1:0] write_data_new;
  wire [DATA_WIDTH-1:0] write_data_same;
  wire [DATA_WIDTH-1:0] write_data_init;

  wire [OUTDATA_WIDTH-1:0] tlb_data;

  wire validN;
  
  reg [IP_WIDTH-1:0] addr_reg;

  reg write_wen_reg;

  reg write_tr_reg;

  reg [OUTDATA_WIDTH-1:0] write_data_reg;
  
  reg invalidate_reg;
  
  reg read_clkEn_reg;
  
  reg [1:0] read_lru_reg;

  assign ip=read_data_ram[`ctlb_ip];
  assign valid=read_data_ram[`ctlb_valid];
  assign validN=read_data_ram[`ctlb_validN];
  assign read_lru=read_data_ram[`ctlb_lru];
 //verilator lint_off WIDTH 
  assign read_hit=(valid&~tr_jump||validN&tr_jump) && ((ip|{13{~tr_jump}})==(addr|{13{~tr_jump}}) ||
    ((ip|{13{~tr_jump}})=={sproc,addr[43:0]|{13{~tr_jump}}} && tlb_data[`ctlbData_global])) && ~invalidate;
 //verilator lint_on WIDTH
  
  assign write_wen_ram=(write_wen && read_lru==2'b11) || read_clkEn&~fStall&~write_wen;
  
  assign tlb_data=read_data_ram[`ctlb_data];
  assign read_data=read_hit ? read_data_ram[`ctlb_data] : 'z;
  assign write_data_new[`ctlb_ip]=addr;
  assign write_data_new[`ctlb_valid]=~write_tr;
  assign write_data_new[`ctlb_validN]=write_tr;
  assign write_data_new[`ctlb_data]=write_data;
  assign write_data_new[`ctlb_lru]=2'b11;
  
  assign write_data_init[`ctlb_ip]=0;
  assign write_data_init[`ctlb_valid]=0;
  assign write_data_init[`ctlb_validN]=0;
  assign write_data_init[`ctlb_data]=0;
  assign write_data_init[`ctlb_lru]=WAYNO[1:0];

  assign write_data_same[`ctlb_ip]=ip;
  assign write_data_same[`ctlb_valid]=valid && ~(invalidate&read_hit);
  assign write_data_same[`ctlb_validN]=validN && ~(invalidate&read_hit);
  assign write_data_same[`ctlb_data]=read_data_ram[`ctlb_data];

  assign write_data_same[`ctlb_lru]=newLRU;
  
  
  assign write_data_ram=write_wen & ~init ? write_data_new : 'z;
  assign write_data_ram=~write_wen & ~init ? write_data_same : 'z;
  assign write_data_ram=init ? write_data_init : 'z;
  
  ctlb_ram ram_mod(
  .clk(clk),
  .rst(rst),
  .read_addr(tr_jump ? addr[9:4] : addr[18:13]),
  .read_data(read_data_ram),
  .write_addr(tr_jump ? addr[9:4] : addr[18:13]),
  .write_data(write_data_ram),
  .write_wen(write_wen_ram|init)
  );

  always @(posedge clk)
    begin
	  if (write_wen_ram && write_wen_reg) $display("TL_B ",tr_jump ? addr[9:4] : addr[18:13]," ",write_data_ram," ",write_data_new);
	  if (rst)
	    begin
		  write_wen_reg<=1'b0;
	//	  addr_reg<={ADDR_WIDTH{1'B0}};
		  write_data_reg<={OUTDATA_WIDTH{1'B0}};
		  invalidate_reg<=1'b0;
		  read_clkEn_reg<=1'b0;
		  write_tr_reg<=1'b0;
		  addr_reg<=0;
		  read_lru_reg<=0;
		end
	  else if (~fStall)
	    begin 
	//	  addr_reg<=addr;
		  write_wen_reg<=write_wen;
		  write_data_reg<=write_data;
		  invalidate_reg<=invalidate;
		  read_clkEn_reg<=read_clkEn;
		  write_tr_reg<=write_tr;
		  addr_reg<=addr;
		  read_lru_reg<=read_lru;
		end
    end
  
endmodule


module ctlb(
  clk,
  rst,
  read_clkEn,
  read_thread,
  fStall,
  addr,
  read_data,
  nat_jump,
  read_hit,
  write_data,
  write_wen,
  csrss_en,
  csrss_addr,
  csrss_data
  );

  localparam DATA_WIDTH=`ctlb_width;
  localparam OUTDATA_WIDTH=`ctlbData_width;
  localparam IP_WIDTH=65;
  localparam ADDR_WIDTH=5;

  
  input clk;
  input rst;
  input read_clkEn;
  input read_thread;
  input fStall;
  input [IP_WIDTH-1:0] addr;
  output [OUTDATA_WIDTH-1:0] read_data;
  input nat_jump;
  output read_hit;
  input [OUTDATA_WIDTH-1:0] write_data;
  input write_wen;
  input csrss_en;
  input [15:0] csrss_addr;
  input [63:0] csrss_data;
  
  wire [3:0][1:0] newLRU;
  wire [3:0][1:0] oldLRU;
  wire [1:0] hitLRU;
  wire [3:0] read_hit_way;
  reg init_pending;
  reg [5:0] init_count;
  reg init_pending_reg;
  wire [5:0] init_count_d;
  wire [23:0] sproc;
  wire [1:0][23:0] pproc;
  wire [1:0][39:0] dummy_pproc;
  wire [1:0][23:0] vmproc;
  wire [1:0][39:0] dummy_vmproc;
  wire [1:0][63:0] mflags;

  reg [IP_WIDTH-1:0] addr_reg;
  
  reg read_clkEn_reg;

  assign read_hit=(|read_hit_way) & ~init_pending;
  assign hitLRU=read_hit ? 2'bz : 2'b00;
  assign read_data=read_hit ? 'z : {OUTDATA_WIDTH{1'B0}};

  generate
    genvar k;
    for(k=0;k<4;k=k+1)
      begin : ways_gen
        ctlb_way #(k) way_mod(
        clk,
        rst,
        read_clkEn,
        fStall,
        init_pending ? {46'b0,init_count,13'b0} : addr,
	nat_jump,
	sproc[20:0],
        read_data,
        oldLRU[k],
        read_hit_way[k],
        write_data,
        write_wen,
	nat_jump&write_wen,
        1'B0,
        init_pending,
        newLRU[k]
        );
        
        lru_single #(2,k) lru_mod(oldLRU[k],newLRU[k],hitLRU,init_pending,read_clkEn);
        
        assign hitLRU=read_hit_way[k] ? oldLRU[k] : 2'bz;
        
      end
  endgenerate
  
  adder_inc #(6) initAdd_mod(init_count,init_count_d,1'b1,);
  csrss_watch #(`csr_page) csrSproc0_mod(
  clk,
  rst,
  csrss_addr,
  csrss_data,
  csrss_en,
  {pproc[1],dummy_pproc[1],pproc[0],dummy_pproc[0]});

  csrss_watch #(`csr_vmpage) csrSproc1_mod(
  clk,
  rst,
  csrss_addr,
  csrss_data,
  csrss_en,
  {vmproc[1],dummy_vmproc[1],vmproc[0],dummy_vmproc[0]});

  csrss_watch #(`csr_mflags) csrSproc2_mod(
  clk,
  rst,
  csrss_addr,
  csrss_data,
  csrss_en,
  mflags);

  assign sproc=mflags[read_thread][`mflags_vm] ? pproc[read_thread]^{24'd1} : 24'b0;



  
  always @(posedge clk)
    begin
   /*   if (rst)
        read_clkEn_reg<=1'b0;
      else if (~fStall)
        read_clkEn_reg<=read_clkEn;
     */ 
      if (rst)
        begin 
          init_pending<=1'b1;
          init_count<=0;
        end
      else if (init_pending)
        begin
          init_count<=init_count_d;
          if (init_count==63)
            init_pending<=1'b0;
        end
        
     /* if (rst)
        init_pending_reg<=1'b0;
      else
        init_pending_reg<=init_pending;*/
    end
  
endmodule


