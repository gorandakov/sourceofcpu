module sz1(
  input [3:0] bgn;
  output reg [6:2] sz;
  );

  always @(bgn) begin
      sz={bgn==4'ha,1'b0,bgn==4'he,bgn[2:0]!=3'b0 && bgn!=4'he && bgn!=4'ha,
	  bgn[2:0]==3'b0};
  end
endmodule

module sz2(
  input [3:0] bgn0;
  input [3:0] bgn2;
  input [3:0] bgn3;
  input [3:0] bgn4;
  input [3:0] bgn6;
  output [6:2] sz0;
  output [6:2] sz1;
  output [12:4] cnt1;
  );
  wire [6:2][6:2];
  sz1(bgn0,sz0);
  sz1(bgn2,sz[2]);
  sz1(bgn3,sz[3]);
  sz1(bgn4,sz[4]);
  sz1(bgn6,sz[6]);
  assign sz[5]=5'd3;
  generate
    genvar th;
    for(th=2;th<7;th++) begin
	assign cnt1=sz0[th] ? {5'd0,sz[th]}<<(th-2) : 10'bz;
	assign sz1=sz0[th] ? sz[th] : 10'bz;
    end
  endgenerate

endmodule

module sz2(
  input [3:0] bgn0;
  input [3:0] bgn2;
  input [3:0] bgn3;
  input [3:0] bgn4;
  input [3:0] bgn5;
  input [3:0] bgn6;
  input [3:0] bgn7;
  input [3:0] bgn8;
  input [3:0] bgn9;
  input [3:0] bgn10;
  input [3:0] bgn11;
  input [3:0] bgn12;
  input [3:0] bgn13;
  input [3:0] bgn14;
  input [3:0] bgn15;
  input [3:0] bgn16;
  input [3:0] bgn17;
  input [3:0] bgn18;
  output [6:2] sz0;
  output [6:2] sz1;
  output [6:2] sz2;
  output [6:2] sz3;
  output [12:4] cnt1;
  output [18:6] cnt2;
  output [24:8] cnt3;
  output [30:10] cnt4;

  );
  sz2 s0_med(
  bgn0,
  bgn2,
  bgn3,
  bgn4,
  bgn6,
  sz0,
  sz1,
  cnt1
  );

  sz2 s4_med(
  bgn4,  bgn6,  bgn7,  bgn8,  bgn10,
  sz0x[4],  sz1x[4],  cnt1x[4]
  );
  sz2 s5_med(
  bgn5,  bgn7,  bgn8,  bgn9,  bgn11,
  sz0x[5],  sz1x[5],  cnt1x[5]
  );
  sz2 s6_med(
  bgn6,  bgn8,  bgn9,  bgn10,  bgn12,
  sz0x[6],  sz1x[6],  cnt1x[6]
  );
  sz2 s7_med(
  bgn7,  bgn9,  bgn10,  bgn11,  bgn13,
  sz0x[7],  sz1x[7],  cnt1x[7]
  );
  sz2 s8_med(
  bgn8,  bgn10,  bgn11,  bgn12,  bgn14,
  sz0x[8],  sz1x[8],  cnt1x[8]
  );
  sz2 s9_med(
  bgn9,  bgn11,  bgn12,  bgn13,  bgn15,
  sz0x[9],  sz1x[9],  cnt1x[9]
  );
  sz2 s10_med(
  bgn10,  bgn12,  bgn13,  bgn14,  bgn16,
  sz0x[10],  sz1x[10],  cnt1x[10]
  );
  sz2 s11_med(
  bgn11,  bgn13,  bgn14,  bgn15,  bgn17,
  sz0x[11],  sz1x[11],  cnt1x[11]
  );
  sz2 s12_med(
  bgn12,  bgn14,  bgn15,  bgn16,  bgn18,
  sz0x[12],  sz1x[12],  cnt1x[12]
  );

