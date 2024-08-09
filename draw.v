module draw (
    CLK,
    NRST,
    X,
    Y,
    R,
    G,
    B,
    CX,
    CY,
    CHAR,
    SW,
    KEY
);
  // parameter s_len = 2;
  // parameter s = 2'b01;


  input [9:0] SW;
  input [3:0] KEY;
  input CLK, NRST;
  output reg [7:0] X, Y;
  output reg [7:0] R, G, B;
  output reg [4:0] CX;
  output reg [3:0] CY;
  output reg [7:0] CHAR;

  reg [7:0] active_n;

  reg [7:0] lambda_index;

  // wire [3:0] lambdas_available;
  // wire lambda3_calcend, lambda2_calcend, lambda1_calcend, lambda0_calcend;
  // assign lambdas_available = {lambda3_calcend, lambda2_calcend, lambda1_calcend, lambda0_calcend};
  // reg [3:0] lambdas_start;
  // wire lambda0_start, lambda1_start, lambda2_start, lambda3_start;
  // assign lambda0_start = lambdas_start[0];
  // assign lambda1_start = lambdas_start[1];
  // assign lambda2_start = lambdas_start[2];
  // assign lambda3_start = lambdas_start[3];
  // wire [63:0] lambda0_out, lambda1_out, lambda2_out, lambda3_out;
  // reg [7:0] X0, Y0, X1, Y1, X2, Y2, X3, Y3;
  // wire [7:0] Xi, Yi;
  // assign Xi = lambda_index == 0 ? X0 : lambda_index == 1 ? X1 : lambda_index == 2 ? X2 : X3;
  // assign Yi = lambda_index == 0 ? Y0 : lambda_index == 1 ? Y1 : lambda_index == 2 ? Y2 : Y3;

  // wire [7:0] outR0, outG0, outB0, outR1, outG1, outB1, outR2, outG2, outB2, outR3, outG3, outB3;
  // wire [7:0] outRi, outGi, outBi;
  // assign outRi = lambda_index == 0 ? outR0 : lambda_index == 1 ? outR1 : lambda_index == 2? outR2 : outR3;
  // assign outGi = lambda_index == 0 ? outG0 : lambda_index == 1 ? outG1 : lambda_index == 2? outG2 : outG3;
  // assign outBi = lambda_index == 0 ? outB0 : lambda_index == 1 ? outB1 : lambda_index == 2? outB2 : outB3;

  parameter lambda_n = 4;
  reg [7:0] lambda_X[0:lambda_n -1];
  reg [7:0] lambda_Y[0:lambda_n -1];
  reg [15:0] nextXY;
  reg lambda_start[0:lambda_n-1];
  wire [63:0] lambda_out[0:lambda_n -1];
  wire lambda_available[0:lambda_n-1];
  wire [7:0] outR[0:lambda_n -1];
  wire [7:0] outG[0:lambda_n -1];
  wire [7:0] outB[0:lambda_n -1];

  parameter s_len = 4;
  parameter s = 8'b01100010;

  reg [63:0] p;
  genvar gi;
  generate
    for (gi = 0; gi < lambda_n; gi = gi + 1) begin : uuuu
      lambda #(
          .s_len(s_len)
      ) lambda0 (
          .iCLK(CLK),
          .iStart(lambda_start[gi]),
          .iX(lambda_X[gi]),
          .iY(lambda_Y[gi]),
          .iS(s),
          .iP(p),
          .oLambda(lambda_out[gi]),
          .oCalc_end(lambda_available[gi])
      );
      lambda2color l2c0 (
          .iLambda(lambda_out[gi]),
          .oR(outR[gi]),
          .oG(outG[gi]),
          .oB(outB[gi])
      );
    end
  endgenerate

  // lambda #(
  //     .s_len(s_len)
  // ) lambda0 (
  //     .iCLK(CLK),
  //     .iStart(lambda0_start),
  //     .iX(X0),
  //     .iY(Y0),
  //     .iS(s),
  //     .iP(p),
  //     .oLambda(lambda0_out),
  //     .oCalc_end(lambda0_calcend)
  // );
  // lambda2color l2c0 (
  //     .iLambda(lambda0_out),
  //     .oR(outR0),
  //     .oG(outG0),
  //     .oB(outB0)
  // );
  // lambda #(
  //     .s_len(s_len)
  // ) lambda1 (
  //     .iCLK(CLK),
  //     .iStart(lambda1_start),
  //     .iX(X1),
  //     .iY(Y1),
  //     .iS(s),
  //     .iP(p),
  //     .oLambda(lambda1_out),
  //     .oCalc_end(lambda1_calcend)
  // );
  // lambda2color l2c1 (
  //     .iLambda(lambda1_out),
  //     .oR(outR1),
  //     .oG(outG1),
  //     .oB(outB1)
  // );
  // lambda #(
  //     .s_len(s_len)
  // ) lambda2 (
  //     .iCLK(CLK),
  //     .iStart(lambda2_start),
  //     .iX(X2),
  //     .iY(Y2),
  //     .iS(s),
  //     .iP(p),
  //     .oLambda(lambda2_out),
  //     .oCalc_end(lambda2_calcend)
  // );
  // lambda2color l2c2 (
  //     .iLambda(lambda2_out),
  //     .oR(outR2),
  //     .oG(outG2),
  //     .oB(outB2)
  // );
  // lambda #(
  //     .s_len(s_len)
  // ) lambda3 (
  //     .iCLK(CLK),
  //     .iStart(lambda3_start),
  //     .iX(X3),
  //     .iY(Y3),
  //     .iS(s),
  //     .iP(p),
  //     .oLambda(lambda3_out),
  //     .oCalc_end(lambda3_calcend)
  // );
  // lambda2color l2c3 (
  //     .iLambda(lambda3_out),
  //     .oR(outR3),
  //     .oG(outG3),
  //     .oB(outB3)
  // );

  // wire [15:0] addr;
  // wire [15:0] addr_next;

  // assign addr = {Y, X} + 'b1;
  // assign addr_next = addr + 'b1;
  // wire [7:0] nextX,nextY;
  // assign {nextY,nextX} = addr_next;




  // reg lambda_start;
  // wire lambda_calcend;
  // wire [63:0] lambda_out;

  // wire [7:0] outR, outG, outB;
  // lambda2color l2c (
  //     .iLambda(lambda_out),
  //     .oR(outR),
  //     .oG(outG),
  //     .oB(outB)
  // );

  // lambda #(
  //     .s_len(4)
  // ) lambda (
  //     .iCLK(CLK),
  //     .iStart(lambda_start),
  //     .iX(nextX),
  //     .iY(nextY),
  //     .iS(8'b01100010),
  //     .iP(p),
  //     .oLambda(lambda_out),
  //     .oCalc_end(lambda_calcend)
  // );

  reg firstclk;
  reg [7:0] clk_cnt;


  always @(posedge CLK) begin
    if (!NRST) begin
      X <= 0;
      Y <= 0;
      R <= 0;
      G <= 0;
      B <= 0;

      CX <= 0;
      CY <= 0;
      CHAR <= 0;

      firstclk <= 1;
      clk_cnt <= 0;
      p <= 0;
      lambda_index <= 0;
      nextXY = 0;
      active_n <= lambda_n - 1;
    end else begin
      if ((lambda_available[lambda_index] && !lambda_start[lambda_index]) || clk_cnt <= lambda_n -1) begin
        if (clk_cnt <= lambda_n - 1) begin
          clk_cnt <= clk_cnt + 1;
        end
        lambda_start[lambda_index] <= 1;
        {Y, X} <= {lambda_Y[lambda_index], lambda_X[lambda_index]};
        R <= outR[lambda_index];
        G <= outG[lambda_index];
        B <= outB[lambda_index];
        {lambda_Y[lambda_index], lambda_X[lambda_index]} <= nextXY;
        nextXY <= nextXY + 1;
        if (lambda_index == active_n) begin
          lambda_index <= 0;
        end else begin
          lambda_index <= lambda_index + 1;
        end
        if (nextXY == 0) begin
          p <= (p <= ('b100 << 32)) ? (p + (1 << 29)) : 0;
        end
      end else if (!lambda_available[lambda_index]) begin
        lambda_start[lambda_index] <= 0;
        if (lambda_index == active_n) begin
          lambda_index <= 0;
        end else begin
          lambda_index <= lambda_index + 1;
        end
      end
    end
    // else if ((lambda_calcend && !lambda_start) || firstclk) begin
    //   firstclk <= 0;
    //   {Y, X} <= addr;
    //   lambda_start <= 1;
    //   R <= outR;
    //   G <= outG;
    //   B <= outB;
    //   if (addr == 0) begin
    //     p <= (p <= ('b100 << 32)) ? (p + (1 << 31)) : 0;
    //   end
    // end  
    // else if (addr == 0 && lambda_calcend && !lambda_start) begin
    //   {Y, X} <= addr;
    //   lambda_start <= 1;

    //   p <= p + (1<<31);
    //   R <= outR;
    //   G <= outG;
    //   B <= outB; end
    // else if (!lambda_calcend) begin
    //   lambda_start <= 0;
    // end
  end

endmodule

module lambda2color (
    input [63:0] iLambda,
    output wire [7:0] oR,
    output wire [7:0] oG,
    output wire [7:0] oB
);
  assign oR = iLambda[35:28];
  assign oG = iLambda[35:28];
  assign oB = iLambda[35:28];
endmodule


module lambda #(
    parameter s_len = 2
) (
    input iCLK,
    input iStart,
    input [7:0] iX,
    input [7:0] iY,
    input [2*s_len-1:0] iS,
    input [63:0] iP,
    output reg [63:0] oLambda,
    output reg oCalc_end
);
  parameter N_MAX = 64;

  reg [15:0] n;
  reg [15:0] index;
  reg [63:0] x;
  reg [63:0] a, b;



  wire [63:0] r_i;

  wire log_calcend;
  wire [63:0] log_out;
  reg log_start;
  wire [63:0] log_in;
  wire [63:0] temp0, temp1, temp2;
  assign temp0 = (1 << 32) - (2 * x);
  mult_fixed mf0 (
      .iX (r_i),
      .iY (temp0),
      .oXY(temp2)
  );

  abs abs0 (
      .iX(temp2),
      .oY(log_in)
  );
  reg  [63:0] p;

  // assign r_i = (1'b1 - iS[index]) * a + iS[index] * b;
  wire [ 1:0] r_i_n;
  assign r_i_n = {iS[2*index+1], iS[2*index]};
  assign r_i   = r_i_n == 0 ? a : r_i_n == 1 ? b : p;


  log log0 (
      .iCLK(iCLK),
      .iStart(log_start),
      .iX(log_in),
      .oY(log_out),
      .oCalc_end(log_calcend)
  );

  wire [63:0] x1x;
  assign temp1 = (1 << 32) - x;
  mult_fixed mf1 (
      .iX (x),
      .iY (temp1),
      .oXY(x1x)
  );
  wire [63:0] nextx;
  mult_fixed mf2 (
      .iX (r_i),
      .iY (x1x),
      .oXY(nextx)
  );

  wire [63:0] lambda_last;
  div_last divl0 (
      .iX  (oLambda + log_out),
      .iY  (n),
      .oXdY(lambda_last)
  );

  reg firstclk;

  always @(posedge iCLK) begin
    if (iStart) begin
      oLambda <= 0;
      oCalc_end <= 0;
      n <= 0;
      index <= 0;
      a <= iX << (32 - 6);
      b <= iY << (32 - 6);
      x <= 64'h0000000080000000;
      firstclk <= 1;
      p <= iP;
    end else if ((!oCalc_end && n != N_MAX && log_calcend && !log_start) || firstclk) begin
      firstclk <= 0;
      x <= nextx;
      log_start <= 1;
      n <= n + 1;
      if (n != 0 && n != 1) begin
        oLambda <= oLambda + log_out;
      end
      if (index == s_len - 1) begin
        index <= 0;
      end else begin
        index <= index + 1;
      end
    end else if (!oCalc_end && n == N_MAX && log_calcend && !log_start) begin
      oCalc_end <= 1;
      oLambda   <= lambda_last;
    end else if (!oCalc_end && !log_calcend) begin
      log_start <= 0;
    end
  end

endmodule

module mult_fixed (
    input [63:0] iX,
    input [63:0] iY,
    output wire [63:0] oXY
);
  wire [127:0] rawXY;
  assign rawXY = iX * iY;
  assign oXY   = rawXY[31] ? rawXY[95:32] + 1 : rawXY[95:32];
endmodule

module div_last (
    input [63:0] iX,
    input [15:0] iY,
    output wire [63:0] oXdY
);
  // wire [62:0] X_without_sign;
  // assign X_without_sign = iX[62:0];
  // assign oXdY = {iX[63], X_without_sign >> 6};
  wire [63:0] inv;
  assign inv = ~iX + 1;
  wire [63:0] inv_div;
  assign inv_div = ~(inv >> 6) + 1;
  assign oXdY = iX[63] ? inv_div : iX >> 6;
endmodule

module abs (
    input [63:0] iX,
    output wire [63:0] oY
);
  assign oY = iX[63] ? ~iX + 1 : iX;
endmodule



// x != 0 のときlogを返す。 x==0のとき-5を返す
// x : 64bit (int 32bit, exp 32bit) unsigned fixed point
// 返り値 : 64bit (int 32bit, exp 32bit) signed fixed point
module log (
    input iCLK,
    input iStart,
    input [63:0] iX,
    output reg [63:0] oY,
    output reg oCalc_end
);
  reg [63:0] Xfind_max;
  reg find_max;
  reg [31:0] cnt_max;

  wire [63:0] XX;
  reg [31:0] X;
  assign XX = X * X;
  reg  [ 4:0] index;

  wire [62:0] iszero;
  assign iszero = XX[61:0];

  always @(posedge iCLK) begin
    //start
    if (iStart) begin
      oY <= 0;
      find_max <= 1;
      cnt_max <= 0;
      oCalc_end <= 0;
      X <= iX;
      Xfind_max <= iX;
      index <= 1;
      //findmax ended & calc is on going
    end else if (!find_max && !oCalc_end && index != 0) begin
      index <= index + 1;
      if (XX[63]) begin
        oY <= {(oY << 1) + 1};
        X  <= XX[63:32];
      end else begin
        oY <= {oY << 1};
        X  <= XX[62:31];
      end
      //findmax ended & calc is on going & last digit
    end else if (!find_max && !oCalc_end && index == 0) begin
      oCalc_end <= 1;
      if (XX[63]) begin
        oY <= ((31 - cnt_max) << 32) + {oY << 1, 1'b1};
      end else begin
        oY <= ((31 - cnt_max) << 32) + {oY << 1};
      end
      //findmax
    end else if (find_max) begin
      if (Xfind_max[63] == 1) begin
        find_max <= 0;
        X <= Xfind_max[63:32];
      end else if (cnt_max == 64) begin
        oY <= 64'hFFFFFFFB00000000;
        find_max <= 0;
        oCalc_end <= 1;
      end else begin
        cnt_max   <= cnt_max + 1;
        Xfind_max <= Xfind_max << 1;
      end
    end
  end
endmodule
