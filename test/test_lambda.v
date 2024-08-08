module simtop;
  reg clk, start;

  wire calcend;
  wire [63:0] out;

  lambda #(
      .s_len(2)
  ) l0 (
      .iCLK(clk),
      .iStart(start),
      .iX(8'd32),
      .iY(8'd25),
      .iS(2'b01),
      .oCalc_end(calcend),
      .oLambda(out)
  );

  initial begin
    clk   <= 0;
    start <= 0;
    #100 start <= 1;
    #200 start <= 0;
    #100000 $finish;
  end
  always #10 clk <= ~clk;
endmodule
