

module block_ecc_decode(
data_in,
data2_in,
err_out,
data_out);

  input [17:0][17:0] data_in;
  input [17:0][17:0] data2_in;
  output err_out;
  output reg [17:0][17:0] data_out;

  reg [17:0] diag1;
  reg [17:0] diag2;
  reg [17:0] row;
  reg [17:0] col;

  integer l,l2;

  always @* begin
    for(l2=0;l2<18;l2=l2+1) begin
        diag1=18'b0;
        diag2=18'b0;
        row=18'b0;
        col=18'b0;
        for(l=0;l<18;l=l+1) begin
            row[l]=data_in[l2][l];
            col[l]=data_in[l][l2];
            if ((l2+l)<18) diag1[l]=data_in[l2+l][l];
            if ((l2+l)<18) diag2[l]=data_in[l][l2+l];
        end
        data_out=data2_in;
        if (^row) data_out[l2][0]=~data2_in[l2][0];
        if (^col && l2!=0) data_out[0][l2]=~data2_in[0][l2];
        if (^diag1 && l2!=0) data_out[l2][1]=~data2_in[l2][1];
        if (^diag2 && l2!=0 && l2!=1) data_out[1][l2]=~data2_in[1][l2];
    end
  end
endmodule

module block_ecc_correct(
data_in,
data2_in,
err_out,
data_out);

  input [17:0][17:0] data_in;
  input [17:0][17:0] data2_in;
  output err_out;
  output reg [17:0][17:0] data_out;

  reg diag1;
  reg diag2;
  reg row;
  reg col;
  reg [17:0][17:0] xore;

  integer l,l2;

  always @* begin
    xore='1;
    
    for(l2=0;l2<18;l2=l2+1) begin
        diag1=1'b0;
        diag2=1'b0;
        row=1'b0;
        col=1'b0;
        row=data2_in[l2][0];
        col=data2_in[0][l2] && l2!=0;
        diag1=data2_in[l2][1] && l2!=0;
        diag2=data2_in[1][l2] && l2!=0 && l3!=0;
        if (diag1) row=~row;
        if (diag2) col=~col;
        for(l=0;l<18;l=l+1) begin
            if (~row) xore[l2][l]=1'b0;
            if (~col) xore[l][l2]=1'b0;
            if (~diag1)=xore[l2+l][l]=1'b0;
            if (~diag2)=xore[l][l2+l]=1'b0;
        end
    end
    data_out=data_in^xore;
  end
endmodule
