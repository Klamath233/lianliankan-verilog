`timescale 1ns / 1ps

/** @file input_module.v
 *  @author Xi Han
 *  
 *  This file is adapted from the input module of lab 3 since the functionality
 *  is the same; it debounces all the inputs. However, different from lab 3, the
 *  sampling clock is implmented inside this file.
 *
 */
 
module input_module(up_in,  right_in,  down_in,  left_in, s_in,
                    up_out, right_out, down_out, left_out, s_out,
                    clk, en);
  
  input up_in;
  input right_in;
  input down_in;
  input left_in;
  input s_in;
  input clk;
  input en;
  
  output s_out;
  output up_out;
  output right_out;
  output down_out;
  output left_out;
  
  reg [18:0] counter = 0;
  reg __clk_1khz = 0;
  wire clk_1khz;
  
  always @(posedge clk) begin
    if (en) begin
      counter <= counter + 1;
      if (counter == 499999) begin
        __clk_1khz <= ~clk_1khz;
        counter <= 0;
      end else begin
        __clk_1khz <= clk_1khz;
      end
    end
  end
  
  assign clk_1khz = __clk_1khz;
  
  debounce d_up (
    .btn(up_in),
    .rst(),
    .clk(clk_1khz),
    .vld(up_out)
  );

  debounce d_right (
    .btn(right_in),
    .rst(),
    .clk(clk_1khz),
    .vld(right_out)
  );

  debounce d_down (
    .btn(down_in),
    .rst(),
    .clk(clk_1khz),
    .vld(down_out)
  );

  debounce d_left (
    .btn(left_in),
    .rst(),
    .clk(clk_1khz),
    .vld(left_out)
  );
  
  debounce d_s (
    .btn(s_in),
    .rst(),
    .clk(clk_1khz),
    .vld(s_out)
  );

endmodule