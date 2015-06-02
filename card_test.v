`timescale 1ns / 1ps

module card_test;

		// Inputs
		reg clk;
		reg rst;
		reg cur;
		reg s;
		reg mf;
		reg ms;

		// Outputs
		wire sel;
		wire blink;
		wire hidden;
	wire [4:0] state_debug;

		// Instantiate the Unit Under Test (UUT)
		card uut (
				.clk(clk), 
				.rst(rst), 
				.cur(cur), 
				.s(s), 
				.mf(mf), 
				.ms(ms), 
				.sel(sel), 
				.blink(blink), 
				.hidden(hidden),
		.state_debug(state_debug)
		);

		initial begin
				// Initialize Inputs
				clk = 0;
				rst = 0;
				cur = 0;
				s = 0;
				mf = 0;
				ms = 0;

				// Wait 100 ns for global reset to finish
				#100;
		cur = 1;
		
		#50;
		cur = 0;
		
		#50;
		cur = 1;
		
		#50;
		cur = 0;
		
		#50;
		s = 1;
		ms = 1;
		
		#50;
		s = 0;
		ms = 0;
		
		#100;
		cur = 1;
		
		#100;
		s = 1;
		
		#10;
		s = 0;
		
		#25;
		cur = 0;
		
		#25;
		cur = 1;
		
		#50;
		s = 1;
		
		#10;
		s = 0;
		
		#150;
		ms = 1;
		
		#100;
		ms = 0;
				
				// Add stimulus here
		
		end
	always #5 clk = ~clk;
endmodule

