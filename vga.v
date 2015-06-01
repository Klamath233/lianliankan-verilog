`timescale 1ns / 1ps

module vga_timing(clk100_in, rgb_out, hs_out, vs_out);

  input clk100_in;

  output [7:0] rgb_out;
  output hs_out;
  output vs_out;

  reg clk25 = 0;
  reg clk2 = 0;
  reg [9:0] hc = 0;
  reg [9:0] vc = 0;
  reg [1:0] counter = 0;
  reg [24:0] clk2_counter = 25'b0000000000000000000000000;

  reg [7:0] __rgb_out;
  reg __hs_out;
  reg __vs_out;

  always @(posedge clk100_in) begin
    counter <= counter + 1;
    if (counter == 2'b11) begin
      clk25 <= 1;
      counter <= 2'b00;
    else begin
      clk25 <= 0;
    end
  end

  always @(posedge clk100_in) begin
    clk2_counter <= clk2_counter + 1;
    if (cclk2_ounter == 25'b1011111010111100000111111) begin
      clk2 <= 1;
      clk2_counter <= 25'b0000000000000000000000000;
    else begin
      clk2 <= 0;
    end
  end

  always @(clk25) begin
    if (hc < 640 && vc < 480) begin
      __rgb_out <= 8'b11111111;
    end else begin
      __rgb_out <= 8'b00000000;
    end
  end

  always @(posedge clk25) begin
    if (hc >= 639 + 16 && hc <= 639 + 16 + 96) begin
      __hs_out <= 0;
    end else begin
      __hs_out <= 1;
    end

    if (vc >= 479 + 10 && vc <= 479 + 10 + 2) begin
      __vs_out <= 0;
    end else begin
      __vs_out <= 1;
    end

    hc <=  hc + 1;
    if (hc == 799) begin
      vc <= vc + 1;
      hc <= 10'b0000000000;
    end

    if (vc == 524) begin
      vc <= 10'b0000000000;
    end
  end

  assign hs_out = __hs_out;
  assign vs_out = __vs_out;
  assign rgb_out = __rgb_out;
endmodule