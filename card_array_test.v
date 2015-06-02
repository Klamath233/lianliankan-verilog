`timescale 1ns / 1ps

module card_array_test;

  // Inputs
  reg clk;
  reg rst;
  reg s;
  reg mf;
  reg ms;
  reg [35:0] cur_bus;

  // Outputs
  wire [35:0] sel_bus;
  wire [35:0] blink_bus;
  wire [35:0] hidden_bus;

  // Instantiate the Unit Under Test (UUT)
  card_array uut (
    .clk(clk), 
    .rst(rst), 
    .s(s), 
    .mf(mf), 
    .ms(ms), 
    .cur_bus(cur_bus), 
    .sel_bus(sel_bus), 
    .blink_bus(blink_bus), 
    .hidden_bus(hidden_bus)
  );

  initial begin
    // Initialize Inputs
    clk = 0;
    rst = 0;
    s = 0;
    mf = 0;
    ms = 0;
    cur_bus = 36'b100000000000000000000000000000000000;

    // Wait 100 ns for global reset to finish
    #100;
    cur_bus = 36'b010000000000000000000000000000000000;

    #100;
    cur_bus = 36'b001000000000000000000000000000000000;    
    // Add stimulus here

  end
  always #5 clk = ~clk;
endmodule

