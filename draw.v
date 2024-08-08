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

  wire [15:0] addr;
  reg state;

  assign addr = {Y, X} + 'b1;

  

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
      state <= 0;
      cnt <= 0;

      n <= 0;
      x <= 1 << (x_exp - 1);
    end else if (addr != 0) begin
      {Y, X} <= addr;

    end else begin
    end
  end

endmodule


module lambda #(
    parameter s_len=2
) (
    input iCLK,
    input iStart,
    input iX,
    input iY,
    input [s_len-1:0] iS,
    output reg oLambda,
    output reg oClac_end
);
  parameter N_MAX=64;

  reg [15:0] n;
  reg [15:0] index;
  reg [63:0] x;
  reg [63:0] a,b;

  wire [63:0] next;
  assign nexta = a*x*((1<<32)-x);
  assign nextb = b*x*((1<<32)-x);

  always @(posedge iCLK) begin
    if(iStart) begin
      oLambda <= 0;
      oCalc_end <= 0;
      n <= 0;
      index <= 0;
      a <= iX<<(32-6);
      b <= iY<<(32-6);
      x <= 64'h0000000080000000;
    end else if(!oCalc_end && n != N_MAX) begin
      x <= (iS[index]*a + iS[index]*b)*x*(1<<32-x);
      if(n!=0) begin
        oLambda <= oLambda + 
      end
      if(index==s_len) begin
        index <= 0;
      end else begin
        index <= index + 1;
      end
    end else if(!oCalc_end && n == N_MAX) begin
      oCalc_end <= 1;
    end
  end

endmodule


// x != 0 のときlogを返す。 x==0のとき一番小さい数を返す
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
  reg [4:0] index;

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
        oY <= 64'h8000000000000000;
        find_max <= 0;
        oCalc_end <= 1;
      end else begin
        cnt_max   <= cnt_max + 1;
        Xfind_max <= Xfind_max << 1;
      end
    end
  end
endmodule
