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



module cc_comb (
  clk,
  rst,
  read_clkEn,
  read_set_flag,
  fstall,
  except,
  cc_read_IP,
  cc_read_hit,
  cc_read_tagErr,
  read_data,
  read_dataX,
  write_IP,
  cc_write_wen,
  cc_invalidate,
  write_data,
  chkCL_IP,
  chkCL_clkEn,
  chkCL_hit,
  expun_addr,
  expun_wen
  );  
  
  localparam DATA_WIDTH=65*16;
  localparam ADDR_WIDTH=6;
  localparam IP_WIDTH=44;
  localparam PHYS_WIDTH=44;
  localparam LINK_WIDTH=47;

  input clk;
  input rst;
  input read_clkEn;
  input read_set_flag;
  input fstall;
  input except;
  input [IP_WIDTH-1:0] cc_read_IP;
  output cc_read_hit;
  output [7:0] cc_read_tagErr;
  output [DATA_WIDTH/4-1:0] read_data;
  output [14:0] read_dataX;
  input [IP_WIDTH-1:0] write_IP;
  input cc_write_wen;
  input cc_invalidate;

  input [DATA_WIDTH/2-1:0] write_data;
  input [IP_WIDTH-1:0] chkCL_IP;
  input chkCL_clkEn;
  output chkCL_hit;
  output [36:0] expun_addr;
  output expun_wen;
  
  wire [DATA_WIDTH-1:0] read_data0;
  wire [DATA_WIDTH-1:0] cc_read_data0;
  
  reg [IP_WIDTH-1:0] write_IP_reg;
  reg [DATA_WIDTH-1:0] write_data_reg;



  reg cc_write_wen_reg;
  reg cc_invalidate_reg;
  reg cc_write_wen_reg2;
  reg cc_invalidate_reg2;

  reg [IP_WIDTH-1:0] write_IP_reg2;
  reg [DATA_WIDTH-1:0] write_data_reg2;

  reg cc_read_hitP;

  reg [DATA_WIDTH-1:0] read_data0_reg;
  
  reg [IP_WIDTH-6:0] cc_read_IP_reg;
  
  
  wire [59:0] read_dataX0;
  wire [59:0] cc_read_dataX0;
  wire [14:0] read_dataXP[3:0];
  reg [59:0] read_dataX0_reg;
  wire [36:0] cc_exp_addr0;  
  reg [36:0] cc_exp_addr0_reg;  
//  wire [71:0] read_dataY0;
//  wire [17:0] read_dataYP;
//  reg [71:0] read_dataY0_reg;

  wire [7:0] writeIP_next;
  
  wire cc_read_hit0;
  wire [7:0] cc_tagErr;
  wire cc_expun_hit0;
  reg cc_expun_hitP; 

  reg read_hit0A;
  reg read_hit1A;
  reg read_hit0B;
  reg read_hit1B;
  reg read_hitP;

  wire [DATA_WIDTH/4-1:0] read_dataP[3:0];
  
  reg [7:0] cc_read_tagErrP;
  
  reg read_clkEn_reg;
  reg chkCL_clkEn_reg;
  
  reg [1:0] cc_wen_step;
  
  
  integer a,b;
  

  assign read_data0=cc_read_data0;
  assign read_dataX0=cc_read_dataX0;
  
  assign read_dataP[0]=~(({260{~read_hit0A}} | ~read_data0_reg[DATA_WIDTH/4-1:0]) & read_dataP[1]); 
  assign read_dataP[1]=~(({260{read_hit1A}} &  read_data0_reg[DATA_WIDTH/2-1:DATA_WIDTH/4]) | read_dataP[2]); 
  assign read_dataP[2]=~(({260{~read_hit0B}} | ~read_data0_reg[DATA_WIDTH/4*3-1:DATA_WIDTH/2]) & read_dataP[3]); 
  assign read_dataP[3]=~(({260{read_hit1B}} & read_data0_reg[DATA_WIDTH-1:DATA_WIDTH/4*3])); 
  
  assign read_dataXP[0]=~(({15{~read_hit0A}} | ~read_dataX0_reg[14:0]) & read_dataXP[1]); 
  assign read_dataXP[1]=~(({15{read_hit1A}} & read_dataX0_reg[29:15]) | read_dataXP[2]); 
  assign read_dataXP[2]=~(({15{~read_hit0B}} | ~read_dataX0_reg[44:30]) & read_dataXP[3]); 
  assign read_dataXP[3]=~({15{read_hit1B}} & read_dataX0_reg[59:45]); 


/*  assign read_dataYP=read_hit0A ? read_dataY0_reg[17:0] : 18'BZ; 
  assign read_dataYP=read_hit1A ? read_dataY0_reg[35:18] : 18'BZ; 
  assign read_dataYP=read_hit0B ? read_dataY0_reg[53:36] : 18'BZ; 
  assign read_dataYP=read_hit1B ? read_dataY0_reg[71:54] : 18'BZ; 
  assign read_dataYP=read_hitP ? 18'BZ : 18'B0;
  */
  

  ccRam_half cc_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(read_clkEn_reg),
  .read_IP(cc_read_IP[43:1]),
  .read_set_flag(read_set_flag),
  .read_data(cc_read_data0),
  .read_dataX(cc_read_dataX0),
  .read_hit(cc_read_hit0),
  .expun_hit(cc_expun_hit0),
  .chkCL_IP(chkCL_IP[43:5]),
  .chkCL_clkEn(chkCL_clkEn_reg),
  .chkCL_hit(chkCL_hit),
  .write_IP(write_IP_reg2[IP_WIDTH-1:5]),
  .write_data(write_data_reg2),
  .write_wen(cc_write_wen_reg2),
  .expun_addr(cc_exp_addr0),
  .invalidate(cc_invalidate_reg2),
  .tagErr(cc_tagErr)
  );
  
  cc_fstalle #(4*65) stDat_mod (
  .clk(clk),
  .rst(rst),
  .except(except),
  .fstall(fstall),
  .write_data(read_dataP[0]),
  .read_data(read_data)
  );

  cc_fstalle #(15) stDatFl_mod (
  .clk(clk),
  .rst(rst),
  .except(except),
  .fstall(fstall),
  .write_data(read_dataXP[0]),
  .read_data(read_dataX)
  );

  cc_fstalle #(37) stAddrExp_mod (
  .clk(clk),
  .rst(rst),
  .except(except),
  .fstall(fstall),
  .write_data(cc_exp_addr0_reg),
  .read_data(expun_addr)
  );



  cc_fstalle #(10) stHit_mod (
  .clk(clk),
  .rst(rst),
  .except(except),
  .fstall(fstall),
  .write_data({cc_expun_hitP,cc_read_hitP,cc_read_tagErrP}),
  .read_data({expun_wen,cc_read_hit,cc_read_tagErr})
  );

 // adder #(8) wip_mod(write_IP_reg2[14:7],8'hff,writeIP_next,1'b0,1'b1);
/*
  cc_fstalle #(18) stDataY_mod (
  .clk(clk),
  .rst(rst),
  .except(except),
  .fstall(fstall),
  .write_data(read_dataYP),
  .read_data(tr_read_dataY)
  );
  */
  always @(negedge clk)
  begin
      if (rst) begin
          write_IP_reg2<=44'b0;
//          write_phys_reg2<=32'b0;
          read_hitP<=1'b0;
          cc_read_hitP<=1'b0;
          cc_expun_hitP<=1'b0;
   //       cc_read_hitNP<=1'b0;
          read_data0_reg<={DATA_WIDTH{1'b0}};
          read_dataX0_reg<=60'b0;
          write_data_reg2<={DATA_WIDTH{1'B0}};
          cc_read_tagErrP<=8'b0;
	  cc_exp_addr0_reg<=37'b0;
     //     cc_read_tagErrNP<=8'b0;
          read_hit0A<=1'b0;
          read_hit1A<=1'b0;
          read_hit0B<=1'b0;
          read_hit1B<=1'b0;
  //        read_physOut0_reg<={PHYS_WIDTH-12{1'B0}};
          cc_write_wen_reg2<=1'b0;
          cc_invalidate_reg2<=1'b0;
          cc_read_IP_reg<=39'b0;
      end
      else begin
          write_IP_reg2<=write_IP_reg;
    //      write_phys_reg2<=write_phys_reg;
          read_hitP<=cc_read_hit0;
          cc_read_hitP<=cc_read_hit0;
          cc_expun_hitP<=cc_expun_hit0;
       //   cc_read_hitNP<=cc_read_hitN0;
          read_data0_reg<=read_data0;
          read_dataX0_reg<=read_dataX0;
          if (cc_wen_step[0])
              write_data_reg2[DATA_WIDTH/2-1:0]<=write_data_reg[DATA_WIDTH/2-1:0];
          if (cc_wen_step[1])
              write_data_reg2[DATA_WIDTH-1:DATA_WIDTH/2]<=write_data_reg[DATA_WIDTH-1:DATA_WIDTH/2];
          cc_read_tagErrP<=cc_tagErr;
	  cc_exp_addr0_reg<=cc_exp_addr0;
          read_hit0A<=cc_read_hit0 & ~cc_read_IP_reg[1] & ~cc_read_IP_reg[0];
          read_hit1A<=cc_read_hit0 & ~cc_read_IP_reg[1] & cc_read_IP_reg[0];
          read_hit0B<=cc_read_hit0 & cc_read_IP_reg[1] & ~cc_read_IP_reg[0];
          read_hit1B<=cc_read_hit0 & cc_read_IP_reg[1] & cc_read_IP_reg[0];
      //    read_physOut0_reg<=read_physOut0;
          cc_write_wen_reg2<=cc_write_wen_reg;
          cc_invalidate_reg2<=cc_invalidate_reg;
          cc_read_IP_reg<=cc_read_IP[43:5];
      end
  end
  
  always @(posedge clk)
  begin
      if (rst) begin
          write_IP_reg<=44'b0;
        //  write_phys_reg<=32'b0;
          write_data_reg<={DATA_WIDTH{1'B0}};
          cc_write_wen_reg<=1'b0;
          cc_invalidate_reg<=1'b0;
          read_clkEn_reg<=1'b0;
	  chkCL_clkEn_reg<=1'b0;
          cc_wen_step<=2'b0;
      end
      else begin
          if (cc_write_wen || cc_invalidate) begin
              write_IP_reg<=write_IP;
          //    write_phys_reg<=write_phys;
          end
          write_data_reg<={2{write_data}};
          cc_write_wen_reg<=cc_wen_step[0];
          cc_invalidate_reg<=cc_invalidate;
          read_clkEn_reg<=read_clkEn;
	  chkCL_clkEn_reg<=chkCL_clkEn;
          cc_wen_step<={cc_wen_step[0],cc_write_wen};
      end
  end
  
endmodule

