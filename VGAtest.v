module VGAtop (
    //////////// CLOCK //////////
    input CLK,

    //////////// KEY //////////
    input [3:0] KEY,

    //////////// SW //////////
    input [9:0] SW,

    //////////// LED //////////
    output [9:0] LEDR,

    //////////// Seg7 //////////
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3,
    output [6:0] HEX4,
    output [6:0] HEX5,

    //////////// VGA //////////
    output       VGA_BLANK_N,
    output [7:0] VGA_B,
    output       VGA_CLK,
    output [7:0] VGA_G,
    output       VGA_HS,
    output [7:0] VGA_R,
    output       VGA_SYNC_N,
    output       VGA_VS
);

  wire [10:0] VGA_X;
  wire [10:0] VGA_Y;

  wire [7:0] Xposin, Yposin;
  wire [8:0] RGBposin;

  wire       CLK40;

  assign NRST = KEY[0];
  assign VGA_CLK = CLK40;
  assign LEDR = SW;


  wire [7:0] posx, posy;
  wire [7:0] posr, posg, posb;
  wire [7:0] posxw, posyw;
  wire [2:0] posrw, posgw, posbw;

  wire [4:0] CX;
  wire [3:0] CY;
  wire [7:0] CHAR;

  reg putpixel, k3;

  assign posxw = (k3 == 0) ? posx : Xposin;
  assign posyw = (k3 == 0) ? posy : Yposin;
  assign posrw = (k3 == 0) ? posr : RGBposin[8:6];
  assign posgw = (k3 == 0) ? posg : RGBposin[5:3];
  assign posbw = (k3 == 0) ? posb : RGBposin[2:0];

  pll pll (
      .refclk(CLK),
      .rst(~NRST),
      .outclk_0(CLK40)
  );

  draw u8 (
      .CLK(CLK40),
      .NRST(NRST),
      .X(posx),
      .Y(posy),
      .R(posr),
      .G(posg),
      .B(posb),
      .CX(CX),
      .CY(CY),
      .CHAR(CHAR),
      .SW(SW),
      .KEY(KEY)
  );

  VGA_Ctrl u9 (  //Host Side
      .oCurrent_X(VGA_X),
      .oCurrent_Y(VGA_Y),
      .oRequest(VGA_Read),
      //VGA Side
      .oVGA_HS(VGA_HS),
      .oVGA_VS(VGA_VS),
      .oVGA_SYNC(VGA_SYNC_N),
      .oVGA_BLANK(VGA_BLANK_N),
      .oVGA_R(VGA_R),
      .oVGA_G(VGA_G),
      .oVGA_B(VGA_B),

      //Control Signal
      .iCLK  (CLK40),
      .iRST_N(NRST),


      .write_x(posx),
      .write_y(posy),
      .write_r(posr),
      .write_g(posg),
      .write_b(posb),

      .char_x(CX),
      .char_y(CY),
      .char_code(CHAR)
  );

  HEXtest hex0 (
      .nrst(NRST),
      .clk (CLK),
      .h0  (HEX0),
      .h1  (HEX1),
      .h2  (HEX2),
      .h3  (HEX3),
      .h4  (HEX4),
      .h5  (HEX5)
  );

endmodule

module HEXtest (
    nrst,
    clk,
    h0,
    h1,
    h2,
    h3,
    h4,
    h5
);
  input nrst;
  input clk;
  output [6:0] h0;
  output [6:0] h1;
  output [6:0] h2;
  output [6:0] h3;
  output [6:0] h4;
  output [6:0] h5;

  reg state;

  assign h0 = state;
  assign h1 = state;
  assign h2 = state;
  assign h3 = state;
  assign h4 = state;
  assign h5 = state;

  always @(posedge clk) begin
    if (!nrst) begin
      state <= 0;
    end else begin
      state <= 1;
    end
  end
endmodule
