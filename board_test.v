`timescale 1ns / 1ps

module board_test;

	// Inputs
	reg clk;
	reg [5:0] addr;

	// Outputs
	wire [2:0] r;
	wire [2:0] g;
	wire [1:0] b;
  
  integer i;

	// Instantiate the Unit Under Test (UUT)
	board uut (
		.clk(clk), 
		.addr(addr), 
		.r(r), 
		.g(g), 
		.b(b)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		addr = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
    for (i = 0; i < 36; i = i + 1) begin
      addr = i;
      #10;
    end

	end
  
  always #5 clk <= ~clk;
endmodule

