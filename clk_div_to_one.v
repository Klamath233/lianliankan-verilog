`timescale 1ns / 1ps

module clk_div_to_100(clk_in, clk_out);

  input clk_in;
  output clk_out;
  
  reg [25:0] state = 0;
  reg __clk_out = 0;
  
  /* Determine the output. */
  always @(posedge clk_in) begin
    if (state == 499999) begin
      __clk_out <= ~__clk_out;
    end else begin
      __clk_out <= __clk_out;
    end
  end
  
  /* Determine the next state. */
  always @(posedge clk_in) begin
    if (state == 499999) begin
      state <= 0;
    end else begin
      state <= state + 1;
    end
  end
  
  assign clk_out = __clk_out;
endmodule
