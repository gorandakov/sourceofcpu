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





module dtlb_ram(
  clk,
  rst,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=`dtlb_width;
  localparam ADDR_WIDTH=4;
  localparam ADDR_COUNT=16;
  
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



module dtlb_lru_ram(
  clk,
  rst,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=3;
  localparam ADDR_WIDTH=4;
  localparam ADDR_COUNT=16;
  
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



module dtlb_way(
  clk,
  rst,
  read_clkEn,
  sec_wren,
  addr,
  sproc,
  read_data0,
  read_data1,
  read_data2,
  read_way,
  read_lru,
  read_lruW,
  read_hit,
  read_hitL,
  write_addr,
  write_data0,
  write_data1,
  write_data2,
  write_wen,
  write_xstant,
  write_invl,
  force_way_on,
  force_way_off,
  newLRU,
  init,
  initCount
  );

  parameter WAYNO=0;
  localparam DATA_WIDTH=`dtlb_width;
  localparam DATAH_WIDTH=`dtlb_width;
  localparam OUTDATA_WIDTH=`dtlbData_width;
  localparam VADDR_WIDTH=65;
  localparam ADDR_WIDTH=4;
  localparam ADDRH_WIDTH=3;

  
  input clk;
  input rst;
  input read_clkEn;
  input sec_wren;
  input [VADDR_WIDTH-15:0] addr;
  input [20:0] sproc;
  output [OUTDATA_WIDTH-1:0] read_data0;
  output [OUTDATA_WIDTH-1:0] read_data1;
  output [OUTDATA_WIDTH-1:0] read_data2;
  output [2:0] read_way;
  output [2:0] read_lru;
  output [2:0] read_lruW;
  output read_hit;
  output read_hitL;
  input [VADDR_WIDTH-15:0] write_addr;
  input [OUTDATA_WIDTH-1:0] write_data0;
  input [OUTDATA_WIDTH-1:0] write_data1;
  input [OUTDATA_WIDTH-1:0] write_data2;
  input write_wen;
  input write_xstant;
  input write_invl;
  input force_way_on;
  input force_way_off;
  input [2:0] newLRU;
  input init;
  input [3:0] initCount;
  
  wire valid;
  wire shared;
  wire [VADDR_WIDTH-15:0] vaddr;
  wire write_wen_ram;
  wire [DATA_WIDTH-1:0] read_data_ram;
  wire [DATA_WIDTH-1:0] write_data_ram;
  wire [DATA_WIDTH-1:0] write_data_new;

  wire [2:0] write_lru;
  
  

  assign vaddr=read_data_ram[`dtlb_vaddr];
  assign valid=read_data_ram[`dtlb_valid];
  assign shared=read_data_ram[`dtlb_shr];

  assign read_hitL=valid && (vaddr==addr || ({sproc,addr[29:0]}==vaddr && 
    shared));
  assign read_hit=read_hitL;
  
  assign write_wen_ram=(write_wen && write_lru==3'd7 && ~write_xstant) 
  || init || write_wen & write_xstant & ~force_way_off  & (read_hitL|
  force_way_on);
  
  assign read_data0=read_hitL ? read_data_ram[`dtlb_data1] : 'z;
  assign read_data1=read_hitL ? read_data_ram[`dtlb_data2] : 'z;
  assign read_data2=read_hitL ? read_data_ram[`dtlb_data3] : 'z;

  assign read_way=read_hit ? WAYNO[2:0] : 3'bz;

  assign write_data_new[`dtlb_vaddr]=write_addr;
  assign write_data_new[`dtlb_valid]=~init && ~write_invl;
  assign write_data_new[`dtlb_shr]=write_data0[`dtlbData_glo] && write_data1[
    `dtlbData_glo] && write_data2[`dtlbData_glo];
  assign write_data_new[`dtlb_data1]=write_data0;
  assign write_data_new[`dtlb_data2]=write_data1;
  assign write_data_new[`dtlb_data3]=write_data2;


 
  assign write_data_ram=write_data_new & {DATA_WIDTH{~init}};

  
  dtlb_ram ram_mod(
  .clk(clk),
  .rst(rst),
  .read_addr(addr[3:0]),
  .read_data(read_data_ram),
  .write_addr(init ? initCount : write_addr[3:0]),
  .write_data(write_data_ram),
  .write_wen(write_wen_ram)
  );

  dtlb_lru_ram ramr_mod(
  .clk(clk),
  .rst(rst),
  .read_addr(addr[3:0]),
  .read_data(read_lru),
  .write_addr(write_wen ? write_addr[3:0] : (init? initCount : addr[3:0])),
  .write_data(newLRU),
  .write_wen(read_clkEn&sec_wren||init||write_wen)
  );

  dtlb_lru_ram ramw_mod(
  .clk(clk),
  .rst(rst),
  .read_addr(write_addr[3:0]),
  .read_data(write_lru),
  .write_addr(write_wen ? write_addr[3:0] : (init? initCount : addr[3:0])),
  .write_data(newLRU),
  .write_wen(read_clkEn&sec_wren||init||write_wen)
  );

  assign read_lruW=write_lru;

  always @(posedge clk) begin
     //if (read_clkEn && addr==52'h6f56ff8) $display("May ",WAYNO," ",vaddr," ",addr," ",sproc," ",read_hitL);
  //    if (write_invl && write_wen_ram) $display("May ",WAYNO," ",vaddr);
  end
  
endmodule



module dtlb(
  clk,
  rst,
  read_clkEn,
  sec_wren,
  addr,
  sproc,
  read_data,
  read_data_next,
  read_way,
  read_hit,
  //read_2M,
  write_addr,
  write_data0,
  write_data1,
  write_data2,
  write_wen,
  write_xstant,
  write_invl,
  force_way_en,
  force_way
  );

  localparam WAY_COUNT=8;
  localparam DATA_WIDTH=`dtlb_width;
  localparam OUTDATA_WIDTH=`dtlbData_width;
  localparam VADDR_WIDTH=65;
  localparam ADDR_WIDTH=5;

  
  input clk;
  input rst;
  input read_clkEn;
  input sec_wren;
  input [VADDR_WIDTH-14:0] addr;
  input [20:0] sproc;
  output [OUTDATA_WIDTH-1:0] read_data;
  output [OUTDATA_WIDTH-1:0] read_data_next;
  output [2:0] read_way;
  output read_hit;
  //output [1:0] read_2M;
  input [VADDR_WIDTH-15:0] write_addr;
  input [OUTDATA_WIDTH-1:0] write_data0;
  input [OUTDATA_WIDTH-1:0] write_data1;
  input [OUTDATA_WIDTH-1:0] write_data2;
  input write_wen;
  input write_xstant;
  input write_invl;
  input force_way_en;
  input [2:0] force_way;
  
  wire [2:0] hitLru;
  wire [2:0] lru_way[7:0];
  wire [2:0] newLru[7:0];
  wire [2:0] lru_wayW[7:0];
  wire [2:0] hitLruW;

  wire [7:0] read_hit_way;
  wire [7:0] read_hitL_way;

  wire [2:0] read_way_X;

  assign read_way=read_way_X;
  
  wire [OUTDATA_WIDTH-1:0] read_data0;
  wire [OUTDATA_WIDTH-1:0] read_data1;
  wire [OUTDATA_WIDTH-1:0] read_data2;

  
  wire read_hitL,read_hitH;

  wire [3:0] wrAddrNxt;
  reg [3:0] initCount;
  reg init;
  
  genvar k;
  
  generate
    for(k=0;k<WAY_COUNT;k=k+1)
	  begin : ways_gen
        dtlb_way #(k) way_mod(
        .clk(clk),
        .rst(rst),
        .read_clkEn(read_clkEn),
	.sec_wren(sec_wren),
        .addr(addr[VADDR_WIDTH-14:1]),
        .sproc(sproc[20:0]),
        .read_data0(read_data0),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .read_way(read_way_X),
        .read_lru(lru_way[k]),
        .read_lruW(lru_wayW[k]),
        .read_hit(read_hit_way[k]),
        .read_hitL(read_hitL_way[k]),
        .write_addr(write_addr),
        .write_data0(write_data0),
        .write_data1(write_data1),
        .write_data2(write_data2),
        .write_wen(write_wen),
        .write_xstant(write_xstant),
        .write_invl(write_invl),
        .force_way_on(k==force_way && force_way_en),
        .force_way_off(k!=force_way && force_way_en),
        .newLRU(newLru[k]),
        .init(init),
        .initCount(initCount)
        );
		
	lru_single #(3,k) lru_mod (
        .lru(write_wen ? lru_wayW[k] : lru_way[k]),
        .newLRU(newLru[k]),
        .hitLRU(write_wen ? hitLruW: hitLru),
        .init(init),
        .en(read_clkEn|write_wen)
        );

	assign hitLru=read_hitL_way[k] ? lru_way[k] : 3'bz;
	assign hitLruW=3'd7;
	
      end
  endgenerate
  
  assign hitLru=read_hitL ? 3'bz : 3'b0;
  
  assign read_hitL=|read_hit_way;

  assign read_hit=read_hitL && ~init;
//  assign read_2M[0]=read_data[`dtlbData_subpage];;
//  assign read_2M[1]=read_data_next[`dtlbData_subpage];;
  
  assign read_data0=read_hit ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data1=read_hit ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data2=read_hit ? 'z : {OUTDATA_WIDTH{1'B0}};

  assign read_way_X=read_hit ? 3'BZ : 3'B0;
  
  assign read_data=(~addr[0]) ? read_data0 : read_data1;
  
  assign read_data_next=(~addr[0]) ? read_data1 : read_data2;
  
  adder_inc #(4) initAdd_mod(initCount,wrAddrNxt,1'b1,);
  
  always @(posedge clk) begin
      if (rst) begin
	      init<=1'b1;
	      initCount<=4'd0;
	  end else begin    
	      if (init&&initCount==4'd15) init<=1'b0;
	      if (init) initCount<=wrAddrNxt;
      end
  end

endmodule

