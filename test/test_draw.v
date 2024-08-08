module simtop;
  reg clk, start;

  wire calcend;
  wire [63:0] out;

  wire [7:0] x,y,r,g,b,char;
  wire [4:0] cx;
  wire [3:0] cy;

  draw draw0 (
      .CLK(clk),
      .NRST(start),
      .X(x),
      .Y(y),
      .R(r),
      .G(g),
      .B(b),
      .CX(cx),
      .CY(cy),
      .CHAR(char),
      .SW(10'b0000000000),
      .KEY(4'b0000)
  );

  initial begin
    clk   <= 0;
    start <= 1;
    #100 start <= 0;
    #200 start <= 1;
    #100000000 $finish;
  end
  always #10 clk <= ~clk;
endmodule
