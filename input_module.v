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
                    clk);
  
  input up_in;
  input right_in;
  input down_in;
  input left_in;
  input s_in;
  input clk;
  
  output s_out;
  output up_out;
  output right_out;
  output down_out;
  output left_out;
  
  reg [16:0] counter = 0;
  reg __clk_1khz = 0;
  wire clk_1khz;
  
  always @(posedge clk) begin
    counter <= counter + 1;
    if (counter == 49999) begin
      __clk_1khz <= ~clk_1khz;
      counter <= 0;
    end else begin
      __clk_1khz <= clk_1khz;
    end
  end
  
  assign clk_1khz = __clk_1khz;
  
  debounce d_up (
    .SIG_IN(up_in),
    .CLK(clk_1khz),
    .SIG_OUT(up_out)
  );

  debounce d_right (
    .SIG_IN(right_in),
    .CLK(clk_1khz),
    .SIG_OUT(right_out)
  );

  debounce d_down (
    .SIG_IN(down_in),
    .CLK(clk_1khz),
    .SIG_OUT(down_out)
  );

  debounce d_left (
    .SIG_IN(left_in),
    .CLK(clk_1khz),
    .SIG_OUT(left_out)
  );
  debounce d_s (
    .SIG_IN(s_in),
    .CLK(clk_1khz),
    .SIG_OUT(s_out)
  );

endmodule