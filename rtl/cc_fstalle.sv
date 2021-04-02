`include "../struct.sv"

module cc_fstalle(
  clk,
  rst,
  except,
  fstall,
  write_data,
  read_data
  );
  parameter WIDTH=32;
  input clk;
  input rst;
  input except;
  input fstall;
  input [WIDTH-1:0] write_data;  
  output [WIDTH-1:0] read_data;  

  reg [2:0] where1;
  reg [2:0] where2;
  reg [WIDTH-1:0] dataS;  
  reg [WIDTH-1:0] data1;  
  reg [WIDTH-1:0] data2;
  reg [WIDTH-1:0] write_data_reg;  
  reg isDataS;

  assign read_data=isDataS ? dataS : write_data_reg;
  
  always @(posedge clk) begin
      if (rst) begin
          where1<=3'b001;
          where2<=3'b010;
          dataS<={WIDTH{1'b0}};
          data1<={WIDTH{1'b0}};
          data2<={WIDTH{1'b0}};
          write_data_reg<={WIDTH{1'b0}};
          isDataS<=1'b0;
      end else if (except) begin
          where1<=3'b001;
          where2<=3'b010;
          isDataS<=1'b0;
      end else begin
          if (fstall) begin
              if (~where1[2]) where1<={where1[1:0],1'b0};
              if (~where2[2]) where2<={where2[1:0],1'b0};
              if (where1[1]) data1<=write_data;
              if (where2[1]) data2<=write_data;
          end else begin
              dataS<=data2;
              write_data_reg<=write_data;
              where1<=3'b001;
              isDataS<=where2[2];
              if (where1[2]) begin
                  where2<=3'b100;
                  data2<=data1;
              end else if (where1[1]) begin
                  data2<=write_data;
                  where2<=3'b100;
              end else where2<=3'b010;
          end
      end
  end
endmodule
