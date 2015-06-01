`timescale 1ns / 1ps

module input_module(up_in,  right_in,  down_in,  left_in,
                    up_out, right_out, down_out, left_out,
                    clk);
  
  input up_in;
  input right_in;
  input down_in;
  input left_in;
  input clk;
  
  output up_out;
  output right_out;
  output down_out;
  output left_out;

  debounce d_up (
    .SIG_IN(up_in),
    .CLK(clk),
    .SIG_OUT(up_out)
  );

  debounce d_right (
    .SIG_IN(right_in),
    .CLK(clk),
    .SIG_OUT(right_out)
  );

  debounce d_down (
    .SIG_IN(down_in),
    .CLK(clk),
    .SIG_OUT(down_out)
  );

  debounce d_left (
    .SIG_IN(left_in),
    .CLK(clk),
    .SIG_OUT(left_int)
  );

endmodule