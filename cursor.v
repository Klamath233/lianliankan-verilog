`timescale 1ns / 1ps

module cursor(clk, rst, up, down, left, right,
              cur_bus);

  input clk;
  input rst;
  input up;
  input down;
  input left;
  input right;

  output [35:0] cur_bus;

  short __state = 0;

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
          __state = state + 6;
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

  integer i;
  for (i = 0; i < 35; i = i + 1) begin
    if (__state == i) begin
      assign cur_bus[i] = 1;
    end else begin
      assign cur_bus[i] = 0;
    end
  end

endmodule