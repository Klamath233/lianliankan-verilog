`timescale 1ns / 1ps

/** @file vga.v
 *  @author Xi Han
 *  
 *  This file is the translated and modified version of the VHDL vga template
 *  provided. Besides the direct translation of the original file, it includes
 *  a 2Hz clock for blinking the card under the cursor. It also listens to the
 *  buses for the data it needs to display the cards. It displays a colored,
 *  64 x 64 block if the card is in the normal state. It displays a blinking
 *  block if the card is under cursor. It displays a white box outside the block
 *  if the card is selected.
 *
 *  Some formula useful to compute the row number and colume number:
 *  row = (vc - 8) / 80, given vc < 480 - 8.
 *  col = (hc - 88) / 80, given hc < 640 - 88.
 */

module vga_timing(clk100_in, r, g, b, hidden_bus, blink_bus, sel_bus,
                  rgb_out, hs_out, vs_out, addr);

  input clk100_in;
  input [35:0] hidden_bus;
  input [35:0] blink_bus;
  input [35:0] sel_bus;
  input [2:0] r;
  input [2:0] g;
  input [1:0] b;

  output [7:0] rgb_out;
  output hs_out;
  output vs_out;
  output [5:0] addr;

  reg clk25 = 0;
  reg clk2 = 0;
  reg [9:0] hc = 0;
  reg [9:0] vc = 0;
  reg [1:0] counter = 0;
  reg [24:0] clk2_counter = 25'b0000000000000000000000000;

  reg [7:0] __rgb_out;
  reg __hs_out;
  reg __vs_out;

  reg [35:0] __hidden_bus;
  reg [35:0] __blink_bus;
  reg [35:0] __sel_bus;
  reg [2:0] __r;
  reg [2:0] __g;
  reg [2:0] __b;
  
  reg [5:0] __addr;
  
  // This block read all the data needed from the other modules.
  always @(posedge clk100_in) begin
    __hidden_bus <= hidden_bus;
    __blink_bus <= blink_bus;
    __sel_bus <= __sel_bus;
    if (hc >= 88 && vc >= 8) begin
      __addr <= (vc - 88) / 80 * 6 + (hc - 8) / 80;
    end
    __r <= r;
    __g <= g;
    __b <= b;
  end
  
  always @(posedge clk100_in) begin
    counter <= counter + 1;
    if (counter == 2'b11) begin
      clk25 <= 1;
      counter <= 2'b00;
    end else begin
      clk25 <= 0;
    end
  end

  always @(posedge clk100_in) begin
    clk2_counter <= clk2_counter + 1;
    if (clk2_counter == 25'b1011111010111100000111111) begin
      clk2 <= ~clk2;
      clk2_counter <= 25'b0000000000000000000000000;
    end else begin
      clk2 <= clk2;
    end
  end

  always @(clk25) begin
    if (hc < 640 && vc < 480) begin
      if (hc < 88 || hc >= 552 || (hc - 88) % 80 >= 64 ||
          vc < 8 || vc >= 472 || (vc - 8) % 80 >= 64)
      begin
        __rgb_out <= 8'b00000000;
      end else if (__hidden_bus[(hc - 88) / 80 + (vc - 8) / 80 * 6] == 1) begin
        __rgb_out <= 8'b00000000;
      end else if (__blink_bus[(hc - 88) / 80 + (vc - 8) / 80 * 6] == 1
                   && clk2 == 1)
      begin
        __rgb_out <= 8'b00000000;
      end else if (__sel_bus[(hc - 88) / 80 * 6 + (vc - 8) / 80] == 1 &&
                   ((hc - 88) % 80 == 0 || (hc - 88) % 80 == 63 ||
                    (vc - 8) % 80 == 0 || (vc - 8) % 80 == 63))
      begin
        __rgb_out <= 8'b00000000;
      end else begin
        __rgb_out <= {__r, __g, __b};
      end
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
  assign addr = __addr;
endmodule