module yantar_gen_purp(
  clk,
  rst,
  stall,
  read0_addr,read0_data,
  read1_addr,read1_data,
  read2_addr,read2_data,
  read3_addr,read3_data,
  read4_addr,read4_data,
  read5_addr,read5_data,
  read6_addr,read6_data,
  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen);
  input clk;
  input rst;
  input stall;
  input [5:0]   read0_addr;
  output [64:0] read0_data;
  input [5:0]   read1_addr;
  output [64:0] read1_data;
  input [5:0]   read2_addr;
  output [64:0] read2_data;
  input [5:0]   read3_addr;
  output [64:0] read3_data;
  input [5:0]   read4_addr;
  output [64:0] read4_data;
  input [5:0]   read5_addr;
  output [64:0] read5_data;
  input [5:0]   read6_addr;
  output [64:0] read6_data;
  input [5:0]  write0_addr;
  input [64:0] write0_data;
  input        write0_wen;
  input [5:0]  write1_addr;
  input [64:0] write1_data;
  input        write1_wen;
  input [5:0]  write2_addr;
  input [64:0] write2_data;
  input        write2_wen;
  input [5:0]  write3_addr;
  input [64:0] write3_data;
  input        write3_wen;

  reg [5:0] read0_addr_reg;
  reg [5:0] read1_addr_reg;
  reg [5:0] read2_addr_reg;
  reg [5:0] read3_addr_reg;
  reg [5:0] read4_addr_reg;
  reg [5:0] read5_addr_reg;
  reg [5:0] read6_addr_reg;

  assign read0_data=ram[read0_addr_reg];
  assign read1_data=ram[read1_addr_reg];
  assign read2_data=ram[read2_addr_reg];
  assign read3_data=ram[read3_addr_reg];
  assign read4_data=ram[read4_addr_reg];
  assign read5_data=ram[read5_addr_reg];
  assign read6_data=ram[read6_addr_reg];

  always @(posedge clk) begin
    if (!stall) begin
        read0_addr_reg<=read0_addr;
        read1_addr_reg<=read1_addr;
        read2_addr_reg<=read2_addr;
        read3_addr_reg<=read3_addr;
        read4_addr_reg<=read4_addr;
        read5_addr_reg<=read5_addr;
        read6_addr_reg<=read6_addr;
    end
    if (write0_wen) ram[write0_addr]<=write0_data;
    if (write1_wen) ram[write1_addr]<=write1_data;
    if (write2_wen) ram[write2_addr]<=write2_data;
    if (write3_wen) ram[write3_addr]<=write3_data;
  end
endmodule


module distrib_alloc(
  clk,
  rst,
  stall,
  cls_ALU,
  cls_shift,
  cls_load,
  cls_store,
  cls_FPU,
  cls_loadFPU,
  cls_mul,
  rs_index_lsu,
  rs_index_alu0,
  rs_index_alu1,
  rs_index_fpu0,
  rs_index_fpu1,
  rs_index_fpu2,
  rs_store,
  dec0_rT,dec0_rA,dec0_rB,dec0_rA_use,dec0_rB_use,dec0_rT_use,
  dec0_rA_useF,dec0_rB_useF,dec0_rT_useF,
  dec0_rA_useV,dec0_rB_useV,dec0_rT_useV,
  );
  input clk;
  input rst;
  input stall;
  input [4:0] cls_ALU;
  input [4:0] cls_shift;
  input [4:0] cls_load;
  input [4:0] cls_store;
  input [4:0] cls_FPU;
  input [4:0] cls_loadFPU;
  input [4:0] cls_mul;
  output [4:0] rs_index_lsu;
  output [4:0] rs_index_alu0;
  output [4:0] rs_index_alu1;
  output [4:0] rs_index_fpu0;
  output [4:0] rs_index_fpu1;
  output [4:0] rs_index_fpu2;
  output rs_store;
  input [9:0][5:0] dec0_rT;
  input [9:0][5:0] dec0_rA;
  input [9:0][5:0] dec0_rB;
  input [9:0] dec0_rA_use;
  input [9:0] dec0_rB_use;
  input [9:0] dec0_rT_use;
  input [9:0] dec0_rA_useF;
  input [9:0] dec0_rB_useF;
  input [9:0] dec0_rT_useF;
  input [9:0] dec0_rA_useV;
  input [9:0] dec0_rB_useV;
  input [9:0] dec0_rT_useV;

  reg [5:0] last_rT;
  reg last_rT_has;
  wire [5:0] last_rT_din;
  wire last_rT_din_has;

  wire swap;

  bit_find_first_bit #(5) findALU0(cls_ALU|cls_shift,rs_alu0X,has_alu0);
  bit_find_first_bit #(5) findALU1((cls_ALU|cls_shift)&~rs_alu0X,rs_alu1X,has_alu1);
  bit_find_first_bit #(5) findLDST0(cls_load|cls_store,rs_ldst0X,has_ldst0);

  generate
    genvar j,k;
    for(j=0;j<5;j=j+1) begin
        for(k=0;k<5;k=k+1) begin
            assign swap=rs_alu0X[j] && rs_alu1X[k] ? ((rA[j]=={2'b11,k[3:0]} && rA_use) || (rB[j]=={2'b11,k[3:0]} && rB_use));
        end
        assign dep0A=rs_alu0X[j] ? (rA[j]==last_rT && rA_use && last_rT_has) & ~swap;
        assign dep0B=rs_alu0X[j] ? (rB[j]==last_rT && rB_use && last_rT_has) & ~swap;
        assign dep1A=rs_alu1X[j] ? (rA[j]==last_rT && rA_use && last_rT_has) & swap;
        assign dep1B=rs_alu1X[j] ? (rB[j]==last_rT && rB_use && last_rT_has && rs_alu1X[j]) & swap;
        assign last_rT_din=rs_ldst0X[j] && dec0_rT_use[j] && (rs_ldst0X>rs_alu0X)|~|(dec0_rT_use[4:0]&rs_alu0X) && (rs_ldst0X>rs_alu1X)|~|(dec0_rT_use[4:0]&rs_alu1X) ? dec0_rT[j] : 6'bz;
        assign last_rT_din=rs_alu0X[j] && dec0_rT_use[j] && (rs_ldst0X<rs_alu0X[j])|~(|cls_load) && (rs_alu0X>rs_alu1X)|~|(dec0_rT_use[4:0]&rs_alu1X)  ? dec0_rT[j] : 6'bz;
        assign last_rT_din=rs_alu1X[j] && dec0_rT_use[j] && (rs_alu1X>rs_alu0X[j])|~|(dec0_rT_use[4:0]&rs_alu0X) && (rs_ldst0X<rs_alu1X)|~(|cls_load) ? dec0_rT[j] : 6'bz;
        assign last_rT_din_has=rs_ldst0X[j] && dec0_rT_use[j] && (rs_ldst0X>rs_alu0X)|~|(dec0_rT_use[4:0]&rs_alu0X) && (rs_ldst0X>rs_alu1X)|~|(dec0_rT_use[4:0]&rs_alu1X) ? dec0_rT_use[j] : 1'bz;
        assign last_rT_din_has=rs_alu0X[j] && dec0_rT_use[j] && (rs_ldst0X<rs_alu0X[j])|~(|cls_load) && (rs_alu0X>rs_alu1X)|~|(dec0_rT_use[4:0]&rs_alu1X)  ? dec0_rT_use[j] : 1'bz;
        assign last_rT_din_has=rs_alu1X[j] && dec0_rT_use[j] && (rs_alu1X>rs_alu0X[j])|~|(dec0_rT_use[4:0]&rs_alu0X) && (rs_ldst0X<rs_alu1X)|~(|cls_load) ? dec0_rT_use[j] : 1'bz;
    end
  endgenerate  
  assign swap=!(has_alu0 && has_alu1) ? 1'b0 : 1'bz;
  assign dep0A=has_alu0 ? 1'bz : 1'b0;
  assign dep0B=has_alu0 ? 1'bz : 1'b0;
  assign dep1A=has_alu1 ? 1'bz : 1'b0;
  assign dep1B=has_alu1 ? 1'bz : 1'b0;
  assign last_rT_din=|dec0_rT_use ? 6'bz : 6'b0;
  assign last_rT_din_use=|dec0_rT_din_use ? 1'bz : 1'b0;

  always @* begin
      if (~swap && rs_alu0_has) rs_alu0=rs_alu0X;
      else if (swap && rs_alu1_has) rs_alu0=rs_alu1X;
      else rs_alu0=5'h1f;
      if (swap && rs_alu0_has) rs_alu1=rs_alu0X;
      else if (~swap && rs_alu1_has) rs_alu1=rs_alu1X;
      else rs_alu1=5'h1f;
  end
  always @(posedge clk) begin
      if (rst) begin
          last_rT<=6'd0;
          last_rT_has<=1'b0;
      end else if (!stall) begin
          last_rT<=last_rT_din;
          last_rT_has<=last_rT_din_has;
      end
  end
endmodule
