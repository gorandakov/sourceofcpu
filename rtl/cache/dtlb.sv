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
  read0_addr,
  read0_data,
  read1_addr,
  read1_data,
  read2_addr,
  read2_data,
  read3_addr,
  read3_data,
  read4_addr,
  read4_data,
  read5_addr,
  read5_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=`dtlb_width;
  localparam ADDR_WIDTH=4;
  localparam ADDR_COUNT=16;
  
  input clk;
  input rst;
  input [ADDR_WIDTH-1:0] read0_addr;
  output [DATA_WIDTH-1:0] read0_data;
  input [ADDR_WIDTH-1:0] read1_addr;
  output [DATA_WIDTH-1:0] read1_data;
  input [ADDR_WIDTH-1:0] read2_addr;
  output [DATA_WIDTH-1:0] read2_data;
  input [ADDR_WIDTH-1:0] read3_addr;
  output [DATA_WIDTH-1:0] read3_data;
  input [ADDR_WIDTH-1:0] read4_addr;
  output [DATA_WIDTH-1:0] read4_data;
  input [ADDR_WIDTH-1:0] read5_addr;
  output [DATA_WIDTH-1:0] read5_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  
  assign read0_data=ram[read0_addr];
  assign read1_data=ram[read1_addr];
  assign read2_data=ram[read2_addr];
  assign read3_data=ram[read3_addr];
  assign read4_data=ram[read4_addr];
  assign read5_data=ram[read5_addr];

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
  sproc,
  R0_sec_wren,
  addr,
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
  input [20:0] sproc;
  input R0_sec_wren;
  input [5:0][VADDR_WIDTH-15:0]   addr;
  output [5:0][OUTDATA_WIDTH-1:0] read_data0;
  output [5:0][OUTDATA_WIDTH-1:0] read_data1;
  output [5:0][OUTDATA_WIDTH-1:0] read_data2;
  output [5:0][2:0]               read_way;
  output [2:0] read_lru;
  output [2:0] read_lruW;
  output [5:0] read_hit;
  output [5:0] read_hitL;
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
  
  wire valid[5:0];
  wire shared[5:0];
  wire [VADDR_WIDTH-15:0] vaddr[5:0];
  wire write_wen_ram;
  wire [DATA_WIDTH-1:0] read_data_ram[5:0];
  wire [DATA_WIDTH-1:0] write_data_ram;
  wire [DATA_WIDTH-1:0] write_data_new;

  wire [2:0] write_lru;
  
  

  generate
    genvar p;
    for(p=0;p<6;p=p+1) begin
        assign vaddr[p]=read_data_ram[p][`dtlb_vaddr];
        assign valid[p]=read_data_ram[p][`dtlb_valid];
        assign shared[p]=read_data_ram[p][`dtlb_shr];

        assign read_hitL[p]=valid[p] && (vaddr[p]==addr[p] || ({sproc,addr[p][29:0]}==vaddr[p] && 
          shared[p]));
        assign read_hit[p]=read_hitL[p];
  
        assign read_data0[p]=read_hitL[p] ? read_data_ram[p][`dtlb_data1] : 'z;
        assign read_data1[p]=read_hitL[p] ? read_data_ram[p][`dtlb_data2] : 'z;
        assign read_data2[p]=read_hitL[p] ? read_data_ram[p][`dtlb_data3] : 'z;

        assign read_way[p]=read_hit[p] ? WAYNO[2:0] : 3'bz;

    end
  endgenerate
  assign write_wen_ram=(write_wen && write_lru==3'd7 && ~write_xstant) 
  || init || write_wen & write_xstant & ~force_way_off  & (read_hitL[0]|
  force_way_on);
  
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
  .read0_addr(addr[0][3:0]),
  .read0_data(read_data_ram[0]),
  .read1_addr(addr[1][3:0]),
  .read1_data(read_data_ram[1]),
  .read2_addr(addr[2][3:0]),
  .read2_data(read_data_ram[2]),
  .read3_addr(addr[3][3:0]),
  .read3_data(read_data_ram[3]),
  .read4_addr(addr[4][3:0]),
  .read4_data(read_data_ram[4]),
  .read5_addr(addr[5][3:0]),
  .read5_data(read_data_ram[5]),
  .write_addr(init ? initCount : write_addr[3:0]),
  .write_data(write_data_ram),
  .write_wen(write_wen_ram)
  );

  dtlb_lru_ram ramr_mod(
  .clk(clk),
  .rst(rst),
  .read_addr(addr[0][3:0]),
  .read_data(read_lru),
  .write_addr(write_wen ? write_addr[3:0] : (init? initCount : addr[0][3:0])),
  .write_data(newLRU),
  .write_wen(read_clkEn&R0_sec_wren||init||write_wen)
  );

  dtlb_lru_ram ramw_mod(
  .clk(clk),
  .rst(rst),
  .read_addr(write_addr[3:0]),
  .read_data(write_lru),
  .write_addr(write_wen ? write_addr[3:0] : (init? initCount : addr[0][3:0])),
  .write_data(newLRU),
  .write_wen(read_clkEn&R0_sec_wren||init||write_wen)
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
  input [5:0][VADDR_WIDTH-14:0] addr;
  input [20:0] sproc;
  output [5:0][OUTDATA_WIDTH-1:0] read_data;
  output [5:0][OUTDATA_WIDTH-1:0] read_data_next;
  output [5:0][2:0] read_way;
  output [5:0]read_hit;
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
  wire [7:0][2:0] lru_way;
  wire [7:0][2:0] newLru;
  wire [7:0][2:0] lru_wayW;
  wire [2:0] hitLruW;

  wire [7:0][5:0] read_hit_way;
  wire [7:0][5:0] read_hitL_way;

  
  wire [5:0][OUTDATA_WIDTH-1:0] read_data0;
  wire [5:0][OUTDATA_WIDTH-1:0] read_data1;
  wire [5:0][OUTDATA_WIDTH-1:0] read_data2;

  
  wire [5:0]read_hitL,read_hitH;

  wire [3:0] wrAddrNxt;
  reg [3:0] initCount;
  reg init;
  
  genvar k;
  wire [5:0][VADDR_WIDTH-15:0] addr0;
  assign addr0[0]=addr[0][VADDR_WIDTH-14:1];
  assign addr0[1]=addr[1][VADDR_WIDTH-14:1];
  assign addr0[2]=addr[2][VADDR_WIDTH-14:1];
  assign addr0[3]=addr[3][VADDR_WIDTH-14:1];
  assign addr0[4]=addr[4][VADDR_WIDTH-14:1];
  assign addr0[5]=addr[5][VADDR_WIDTH-14:1];
  generate
    for(k=0;k<WAY_COUNT;k=k+1)
	  begin : ways_gen
        dtlb_way #(k) way_mod(
        .clk(clk),
        .rst(rst),
        .read_clkEn(read_clkEn),
	.R0_sec_wren(sec_wren),
        .addr(addr0),
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

	assign hitLru=read_hitL_way[0][k] ? lru_way[k] : 3'bz;
	assign hitLruW=3'd7;
	
      end
  endgenerate
  
  assign hitLru=read_hitL[0] ? 3'bz : 3'b0;
  
  assign read_hitL[0]=|read_hit_way[0];
  assign read_hitL[1]=|read_hit_way[1];
  assign read_hitL[2]=|read_hit_way[2];
  assign read_hitL[3]=|read_hit_way[3];
  assign read_hitL[4]=|read_hit_way[4];
  assign read_hitL[5]=|read_hit_way[5];

  assign read_hit[0]=read_hitL[0] && ~init;
  assign read_hit[1]=read_hitL[1] && ~init;
  assign read_hit[2]=read_hitL[2] && ~init;
  assign read_hit[3]=read_hitL[3] && ~init;
  assign read_hit[4]=read_hitL[4] && ~init;
  assign read_hit[5]=read_hitL[5] && ~init;
//  assign read_2M[0]=read_data[`dtlbData_subpage];;
//  assign read_2M[1]=read_data_next[`dtlbData_subpage];;
  
  assign read_data0[0]=read_hit[0] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data1[0]=read_hit[0] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data2[0]=read_hit[0] ? 'z : {OUTDATA_WIDTH{1'B0}};

  assign read_data0[1]=read_hit[1] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data1[1]=read_hit[1] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data2[1]=read_hit[1] ? 'z : {OUTDATA_WIDTH{1'B0}};

  assign read_data0[2]=read_hit[2] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data1[2]=read_hit[2] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data2[2]=read_hit[2] ? 'z : {OUTDATA_WIDTH{1'B0}};

  assign read_data0[3]=read_hit[3] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data1[3]=read_hit[3] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data2[3]=read_hit[3] ? 'z : {OUTDATA_WIDTH{1'B0}};

  assign read_data0[4]=read_hit[4] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data1[4]=read_hit[4] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data2[4]=read_hit[4] ? 'z : {OUTDATA_WIDTH{1'B0}};

  assign read_data0[5]=read_hit[5] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data1[5]=read_hit[5] ? 'z : {OUTDATA_WIDTH{1'B0}};
  assign read_data2[5]=read_hit[5] ? 'z : {OUTDATA_WIDTH{1'B0}};

  assign read_way[0]=read_hit[0] ? 3'BZ : 3'B0;
  assign read_way[1]=read_hit[1] ? 3'BZ : 3'B0;
  assign read_way[2]=read_hit[2] ? 3'BZ : 3'B0;
  assign read_way[3]=read_hit[3] ? 3'BZ : 3'B0;
  assign read_way[4]=read_hit[4] ? 3'BZ : 3'B0;
  assign read_way[5]=read_hit[5] ? 3'BZ : 3'B0;
  
  assign read_data[0]=(~addr[0][0]) ? read_data0[0] : read_data1[0];
  assign read_data[1]=(~addr[1][0]) ? read_data0[1] : read_data1[1];
  assign read_data[2]=(~addr[2][0]) ? read_data0[2] : read_data1[2];
  assign read_data[3]=(~addr[3][0]) ? read_data0[3] : read_data1[3];
  assign read_data[4]=(~addr[4][0]) ? read_data0[4] : read_data1[4];
  assign read_data[5]=(~addr[5][0]) ? read_data0[5] : read_data1[5];
  
  assign read_data_next[0]=(~addr[0][0]) ? read_data1[0] : read_data2[0];
  assign read_data_next[1]=(~addr[1][0]) ? read_data1[1] : read_data2[0];
  assign read_data_next[2]=(~addr[2][0]) ? read_data1[2] : read_data2[0];
  assign read_data_next[3]=(~addr[3][0]) ? read_data1[3] : read_data2[0];
  assign read_data_next[4]=(~addr[4][0]) ? read_data1[4] : read_data2[0];
  assign read_data_next[5]=(~addr[5][0]) ? read_data1[5] : read_data2[0];
  
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

