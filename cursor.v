`timescale 1ns / 1ps

/** @file cursor.v
 *  @author Xi Han
 *  
 *  This module represents the state of the cursor. The state is a six-bit
 *  integer dividing which by 6 is the row number and the remainder is the
 *  column number.
 *
 */

module cursor(clk, rst, up, down, left, right,
              cur_bus);

  input clk;
  input rst;
  input up;
  input down;
  input left;
  input right;

  output [35:0] cur_bus;

  reg [5:0] __state = 0;
  reg [35:0] __cur_bus;
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // reset
      __state = 0;
    end else begin
      if (up) begin
        if (__state / 6 == 0) begin
          __state = __state + 30;
        end else begin
          __state = __state - 6;
        end
      end

      if (down) begin
        if (__state / 6 == 5) begin
          __state = __state - 30;
        end else begin
          __state = __state + 6;
        end
      end

      if (left) begin
        if (__state % 6 == 0) begin
          __state = __state + 5;
        end else begin
          __state = __state - 1;
        end
      end

      if (right) begin
        if (__state % 6 == 5) begin
          __state = __state - 5;
        end else begin
          __state = __state + 1;
        end
      end
    end
  end
  
  
  generate 
    genvar i;
    for (i = 0; i < 36; i = i + 1) begin
      always @* begin
        if (__state == i) begin
          __cur_bus[35 - i] = 1;
        end else begin
          __cur_bus[35 - i] = 0;
        end
      end
    end
  endgenerate
  
  assign cur_bus = __cur_bus;

endmodule