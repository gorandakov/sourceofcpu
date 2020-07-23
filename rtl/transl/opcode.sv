module is_opcode(
  data,is_bytes, is_valid, is_dir, is_fast, is_slow,is_memcan,tgtmode,immmode,bit8,sse);
  input [23:0] data;
  output reg [1:0] is_bytes;
  output reg is_valid;
  output reg is_dir;
  output reg is_fast;
  output reg is_slow;
  output reg [3:0] is_memcan; //0=2 regs 1=1 reg+1 op 2=nomem+r 3=nomem
  output reg tgtmode;
  output reg [2:0] immmode;
  output reg bit8;
  output reg sse;

  always @(data) begin
      is_bytes=data[7:0]==8'h0f;
      is_valid=1;
      is_dir=0;
      is_fast=0;
      is_slow=0;
      is_memcan=0;
      tgtmode=0;
      immmode=1;
      bit8=0;
      sse=0;
      case (data[7:0]) 
          8'h4,8'h24,8'h3c: begin 
              bit8=1;
              immode=2;
              is_dir=1;
              tgtmode=1;
              memcan=8;
          end
          8'h5,8'h25,8'h3d: begin
              immmode=4;
              is_dir=1;
              tgtmode=1;
              memcan=8;
          end
          8'h80: begin //0 4 7
              immmode=2;
              bit8=1;
              is_dir=1;
              tgtmode=1;
              memcan=2;
          end
          8'h81: begin //0 4 7
              immmode=4;
              is_dir=1;
              tgtmode=1;
              memcan=2;
          end
          8'h83: begin //0 4 7
              immmode=2;
              is_dir=1;
              tgtmode=1;
              memcan=2;
          end
          8'h00,8'h20,8'h38: begin
              is_dir=1;
              tgtmode=1;
              bit8=1;
          end
          8'h01,8'h21,8'h39: begin
              is_dir=1;
              tgtmode=1;
              bit8=0;
          end
          8'h02,8'h22,8'h3a: begin
              is_dir=1;
              bit8=1;
          end
          8'h03,8'h23,8'h3b: begin
              is_dir=1;
              bit8=0;
          end
          8'he8: begin
              immmode=4;
              memcan=8;
              is_dir=1;
          end
          8'hff,8'hf7: begin //2 1 ; 6
              memcan=2;
              is_dir=1;
          end
          8'hfe,8'hf6: begin // 1 ;6 
              memcan=2;
              is_dir=1;
              bit8=1;
          end
          8'h98,8'h99,8'hf8,8'hf5: begin
              memcan=8;
              is_dir=1;
          end
          8'ha6,8'ha7: begin
              memcan=8;
              is_fast=1;
          end
          8'hfc: begin
              memcan=8;
              is_slow=1;
          end
          8'hc8: begin //enter
              is_slow=1;
              is_bytes=2;
              immmode=2;
              memcan=8;
          end
          8'hd8,8'hdc,8'hde,8'hda,8'hdf/*bcd*/,8'hdb: begin //0 1 2 3;0 2 3;0 1;0 1 2 3;4 6;4 6 0 1 2 3
              memcan=2;
              sse=2;
              is_dir=1;
          end
      endcase
      if (data[7:0]==8'h0f) casex (data[15:8]) 
          8'h58,8'h55,8'h54,8'h2f,8'h5e: begin
              is_dir=1;
              sse=1;
          end
          8'hc2: begin
              is_dir=1;
              sse=1;
              immmode=2;
          end
          8'hbc,8'hbd,8'ha3,8'hbb,8'hb3,8'h_ab: begin
             is_slow=1;
          end
          8'hba: begin
             is_slow=1;
             immmode=2;
          end
          8'b11001xxx: begin //bswap
             is_slow=1;
             memcan=4;
          end
          8'hae: begin //7 6
              is_dir=1;
              memcan=2;
          end
          8'b0100xxxx: begin
              is_dir=1;
              bit8=0;             
          end
          default: begin
              is_slow=1;
              sse=1;
          end
          8'hb0: begin //cmpxchg
               is_slow=1;
               bit8=1;
          end
          8'hb1: begin //cmpxchg
               is_slow=1;
               bit8=0;
          end
          8'hc7: begin //cmpxchg8/16 (1)
               is_slow=1;
               bit8=0;
          end
          8'ha2,8'h77: begin //cpuid,emms
               is_slow=1;
               memcan=8;
          end
          8'he6,8'h5b,8'h2d,8'h5a,8'h2c: begin //cvt
               is_fast=1;
               bit8=0;
          end
          8'hd0: begin //size dec only
              is_slow=1;
              sse=1;
          end
      endcase
      if (data[15:0]==8'h3a0f) casex (data[23:16])
          8'h0d,8'h0c,8'h41,8'h40,8'h17: begin
              immmode=2;
              is_slow=1; 
              is_bytes=2;
          end 
      endcase 
      if (data[7:0]==8'hd9) casex (data[15:8]) 
          8'hf0,8'he1,8'he0: begin
              memcan=8;
              sse=2;
              is_slow=1;
          end
      endcase

  end
  
endmodule
