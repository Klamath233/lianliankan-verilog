`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:14:14 05/05/2015
// Design Name:   clk_div_to_four
// Module Name:   C:/Users/152/Documents/xih/Lab3/StopWatch/clk_div_to_four_test.v
// Project Name:  StopWatch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clk_div_to_four
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clk_div_to_1k_test;

    // Inputs
  reg clk_in;

  // Outputs
  wire clk_out;

  // Instantiate the Unit Under Test (UUT)
  clk_div_to_four uut (
    .clk_in(clk_in), 
    .clk_out(clk_out)
  );

  initial begin
    // Initialize Inputs
    clk_in = 0;

    // Wait 100 ns for global reset to finish
    #100;
        
    // Add stimulus here

  end
    
    always #5 clk_in = ~clk_in;
endmodule

