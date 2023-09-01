/* 14 phase dynamic logic to implement "free" forwarding of alu.
   Note the OoO cpu can use 12 phase instead of 14. 
   But the smaller CPU has to use 14.*/


module yantar_gen_purp0(
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

  reg [39:0][64:0] ram;

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

module yantar_gen_purp0(
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
  write3_addr,write3_data,write3_wen,
  fwd_dataA,fwd_enA,
  fwd_dataB,fwd_enB);

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
  input [64:0] fwd_dataA;
  input [1:0] fwd_enA;
  input [64:0] fwd_dataB;
  input [1:0] fwd_enB;

  yantar_gen_purp0 reg0_mod(
  clk,
  rst,
  stall,
  read0_addr,read_data[0],
  read1_addr,read_data[1],
  read2_addr,read_data[2],
  read3_addr,read_data[3],
  read4_addr,read_data[4],
  read5_addr,read_data[5],
  read6_addr,read_data[6],
  read6_addr,read_data[7],
  read6_addr,read_data[8],
  write0_addr_reg,write0_data_reg,write0_wen_reg,
  write1_addr_reg,write1_data_reg,write1_wen_reg,
  write2_addr_reg,write2_data_reg,write2_wen_reg,
  write3_addr_reg,write3_data_reg,write3_wen_reg
  );

  generate
      genvar k;
      for(k=0;k<9;k=k+1) begin
          wire ren;
          if (k<2) begin
              assign read_dataA=fwd_enA[k] ? fwd_dataA : 65'bz;
              assign read_dataA=read_addr[k]==write0_addr && ~fwd_enA[k] ? write_data0 : 65'bz;
              assign read_dataA=read_addr[k]==write1_addr && ~fwd_enA[k] ? write_data1 : 65'bz;
              assign read_dataA=read_addr[k]==write2_addr && ~fwd_enA[k] ? write_data2 : 65'bz;
              assign read_dataA=read_addr[k]==write3_addr && ~fwd_enA[k] ? write_data3 : 65'bz;
              assign ren=read_addr[k]==write0_addr || read_addr[k]==write1_addr ||
                  read_addr[k]==write2_addr || read_addr[k]==write3_addr || fwd_enA[k];
          end else if (k<4) begin
              assign read_dataA=fwd_enB[k] ? fwd_dataB : 65'bz;
              assign read_dataA=read_addr[k]==write0_addr && ~fwd_enB[k] ? write_data0 : 65'bz;
              assign read_dataA=read_addr[k]==write1_addr && ~fwd_enB[k] ? write_data1 : 65'bz;
              assign read_dataA=read_addr[k]==write2_addr && ~fwd_enB[k] ? write_data2 : 65'bz;
              assign read_dataA=read_addr[k]==write3_addr && ~fwd_enB[k] ? write_data3 : 65'bz;
              assign ren=read_addr[k]==write0_addr || read_addr[k]==write1_addr ||
                  read_addr[k]==write2_addr || read_addr[k]==write3_addr || fwd_enB[k];
          end else begin
              assign read_dataA=read_addr[k]==write0_addr ? write_data0 : 65'bz;
              assign read_dataA=read_addr[k]==write1_addr ? write_data1 : 65'bz;
              assign read_dataA=read_addr[k]==write2_addr ? write_data2 : 65'bz;
              assign read_dataA=read_addr[k]==write3_addr ? write_data3 : 65'bz;
              assign ren=read_addr[k]==write0_addr || read_addr[k]==write1_addr ||
                  read_addr[k]==write2_addr || read_addr[k]==write3_addr;
          end
          assign read_dataA=read_addr[k]==write0_addr_reg && !ren ? write_data0_reg : 65'bz;
          assign read_dataA=read_addr[k]==write1_addr_reg && !ren ? write_data1_reg : 65'bz;
          assign read_dataA=read_addr[k]==write2_addr_reg && !ren ? write_data2_reg : 65'bz;
          assign read_dataA=read_addr[k]==write3_addr_reg && !ren ? write_data3_reg : 65'bz;
          assign read_dataA=read_addr[k]!=write0_addr_reg && read_addr[k]!=write1_addr_reg &&
              read_addr[k]!=write2_addr_reg && read_addr[k]!=write3_addr_reg && !ren ? read_data[k] : 65'bz;
      end
  endgenerate

  assign read0_data=read_dataA[0];
  assign read1_data=read_dataA[1];
  assign read2_data=read_dataA_n[2];
  assign read3_data=read_dataA_n[3];
  assign read4_data=read_dataA[4];
  assign read5_data=read_dataA[5];
  assign read6_data=read_dataA[6];
  assign read7_data=read_dataA[7];
  assign read8_data=read_dataA[8];
  //transparent register; simulation only (it is the phase of the forwarder chain)
  always @(negedge clk) begin
      read_dataA_n[2]<=read_dataA[2];
      read_dataA_n[3]<=read_dataA[3];
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
  bit_find_first_bit #(5) findLDST0(cls_load,rs_ldst0X,has_ldst0);
  bit_find_first_bit #(5) findSTLD0(cls_store,rs_stld0X,has_stld0);

  generate
    genvar j,k;
    for(j=0;j<5;j=j+1) begin
        for(k=0;k<5;k=k+1) begin
            assign swap=rs_alu0X[j] && rs_alu1X[k] ? ((rA[j]=={2'b11,k[3:0]} && rA_use) || (rB[j]=={2'b11,k[3:0]} && rB_use));
        end
        assign dep0AX=rs_alu0X[j] ? (rA[j]==last_rT && rA_use && last_rT_has) & ~swap;
        assign dep0BX=rs_alu0X[j] ? (rB[j]==last_rT && rB_use && last_rT_has) & ~swap;
        assign dep1AX=rs_alu1X[j] ? (rA[j]==last_rT && rA_use && last_rT_has) & swap;
        assign dep1BX=rs_alu1X[j] ? (rB[j]==last_rT && rB_use && last_rT_has && rs_alu1X[j]) & swap;
        assign last_rT_din=rs_ldst0X[j] && dec0_rT_use[j] && (rs_ldst0X>rs_alu0X)|~|(dec0_rT_use[4:0]&rs_alu0X) && (rs_ldst0X>rs_alu1X)|~|(dec0_rT_use[4:0]&rs_alu1X) ? dec0_rT[j] : 6'bz;
        assign last_rT_din=rs_alu0X[j] && dec0_rT_use[j] && (rs_ldst0X<rs_alu0X[j])|~(|cls_load) && (rs_alu0X>rs_alu1X)|~|(dec0_rT_use[4:0]&rs_alu1X)  ? dec0_rT[j] : 6'bz;
        assign last_rT_din=rs_alu1X[j] && dec0_rT_use[j] && (rs_alu1X>rs_alu0X[j])|~|(dec0_rT_use[4:0]&rs_alu0X) && (rs_ldst0X<rs_alu1X)|~(|cls_load) ? dec0_rT[j] : 6'bz;
        assign last_rT_din_has=rs_ldst0X[j] && dec0_rT_use[j] && (rs_ldst0X>rs_alu0X)|~|(dec0_rT_use[4:0]&rs_alu0X) && (rs_ldst0X>rs_alu1X)|~|(dec0_rT_use[4:0]&rs_alu1X) ? dec0_rT_use[j] : 1'bz;
        assign last_rT_din_has=rs_alu0X[j] && dec0_rT_use[j] && (rs_ldst0X<rs_alu0X[j])|~(|cls_load) && (rs_alu0X>rs_alu1X)|~|(dec0_rT_use[4:0]&rs_alu1X)  ? dec0_rT_use[j] : 1'bz;
        assign last_rT_din_has=rs_alu1X[j] && dec0_rT_use[j] && (rs_alu1X>rs_alu0X[j])|~|(dec0_rT_use[4:0]&rs_alu0X) && (rs_ldst0X<rs_alu1X)|~(|cls_load) ? dec0_rT_use[j] : 1'bz;
    end
  endgenerate  
  assign swap=!(has_alu0 && has_alu1) ? 1'b0 : 1'bz;
  assign dep0AX=has_alu0 ? 1'bz : 1'b0;
  assign dep0BX=has_alu0 ? 1'bz : 1'b0;
  assign dep1AX=has_alu1 ? 1'bz : 1'b0;
  assign dep1BX=has_alu1 ? 1'bz : 1'b0;
  assign last_rT_din=|dec0_rT_use ? 6'bz : 6'b0;
  assign last_rT_din_use=|dec0_rT_din_use ? 1'bz : 1'b0;

  always @* begin
      if (~swap && rs_alu0_has) begin
          rs_alu0=rs_alu0X;
          dep0A=dep0AX;
          dep0B=dep0BX;
      end else if (swap && rs_alu1_has) begin 
          rs_alu0=rs_alu1X;
          dep0A=dep1AX;
          dep0B=dep1BX;
      end else begin
          rs_alu0=5'h1f;
          dep0A=1'b0;
          dep0B=1'b0;
      end
      if (swap && rs_alu0_has) begin
          rs_alu1=rs_alu0X;
          dep1A=dep0AX;
          dep1B=dep0BX;
      end else if (~swap && rs_alu1_has) begin
          rs_alu1=rs_alu1X;
          dep1A=dep1AX;
          dep1B=dep1BX;
      end else begin
          rs_alu1=5'h1f;
          dep1A=1'b0;
          dep1B=1'b0;
      end
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
