`timescale 1ns / 1ps

module clock_module(clk_in_100m_hz, 
                    clk_out_1000_hz,
                    clk_out_100_hz);

  input clk_in_100m_hz;
  output clk_out_1000_hz;
  output clk_out_100_hz;

  // Do we need to buffer the input to increase the fanout?
  clk_div_to_1k clk_div_to_1k (
    .clk_in(clk_in_100m_hz),
    .clk_out(clk_out_1000_hz)
  );

  clk_div_to_100 clk_div_to_100 (
    .clk_in(clk_in_100m_hz),
    .clk_out(clk_out_100_hz)
  );

endmodule