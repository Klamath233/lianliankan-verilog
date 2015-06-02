`timescale 1ns / 1ps

module cursor_test;

  // Inputs
  reg clk;
  reg rst;
  reg up;
  reg down;
  reg left;
  reg right;

  // Outputs
  wire [35:0] cur_bus;

  // Instantiate the Unit Under Test (UUT)
  cursor uut (
    .clk(clk), 
    .rst(rst), 
    .up(up), 
    .down(down), 
    .left(left), 
    .right(right), 
    .cur_bus(cur_bus)
  );

  initial begin
    // Initialize Inputs
    clk = 0;
    rst = 0;
    up = 0;
    down = 0;
    left = 0;
    right = 0;

    // Wait 100 ns for global reset to finish
    #100;
        
    // Add stimulus here
    left = 1;
  end
  
  always #5 clk = ~clk;
endmodule

