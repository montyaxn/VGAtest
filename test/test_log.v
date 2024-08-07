module simtop;
  reg clk, start;

  wire calcend;
  wire [63:0] out;

  log l0 (
      .iCLK(clk),
      .iStart(start),
      .oCalc_end(calcend),
      .iX(64'h0000000000000000),
      .oY(out)

  );

  initial begin
    clk  <= 0;
    start <= 0;
    #100 start <= 1;
    #200 start <= 0;
    #100000000 $finish;
  end
  always #10 clk <= ~clk;
endmodule
