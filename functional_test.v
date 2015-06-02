`timescale 1ns / 1ps

module functional_test;

  // Inputs
  reg clk;
  reg rst;
  reg up;
  reg down;
  reg left;
  reg right;
  reg s;
  
  wire [35:0] blink_bus;
  wire [35:0] cur_bus;
  wire [35:0] sel_bus;
  wire [35:0] hidden_bus;
  wire [2:0] r;
  wire [2:0] g;
  wire [1:0] b;

  // Outputs
  wire [5:0] addr;
  wire ms;
  wire mf;

  // Instantiate the Units Under Test (UUTs)
  matcher matcher (
    .clk(clk), 
    .rst(rst), 
    .sel_bus(sel_bus), 
    .hidden_bus(hidden_bus), 
    .r(r), 
    .g(g), 
    .b(b), 
    .addr(addr), 
    .ms(ms), 
    .mf(mf)
  );

  board bd0 (
    .clk(clk),
    .addr(addr),
    .r(r),
    .g(g),
    .b(b)
  );
  
  card_array ca (
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
  
  cursor cursor (
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
    s = 0;
    
    // Wait 100 ns for global reset to finish
    #100;
    
    // Add stimulus here
    
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    s = 1; #10; s = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
/*    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    up = 1; #10; up = 0; #1000;
    up = 1; #10; up = 0; #1000;
    up = 1; #10; up = 0; #1000;
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    right = 1; #10; right = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    right = 1; #10; right = 0; #1000;
    s = 1; #10; s = 0; #1000;
    left = 1; #10; left = 0; #1000;
    left = 1; #10; left = 0; #1000;
    up = 1; #10; up = 0; #1000;
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    right = 1; #10; right = 0; #1000;
    right = 1; #10; right = 0; #1000;
    s = 1; #10; s = 0; #1000;
    right = 1; #10; right = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    up = 1; #10; up = 0; #1000;
    right = 1; #10; right = 0; #1000;
    right = 1; #10; right = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    left = 1; #10; left = 0; #1000;
    left = 1; #10; left = 0; #1000;
    s = 1; #10; s = 0; #1000;
    left = 1; #10; left = 0; #1000;
    left = 1; #10; left = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    right = 1; #10; right = 0; #1000;
    right = 1; #10; right = 0; #1000;
    right = 1; #10; right = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    left = 1; #10; left = 0; #1000;
    left = 1; #10; left = 0; #1000;
    left = 1; #10; left = 0; #1000;
    up = 1; #10; up = 0; #1000;
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    right = 1; #10; right = 0; #1000;
    right = 1; #10; right = 0; #1000;
    right = 1; #10; right = 0; #1000;
    right = 1; #10; right = 0; #1000;
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    left = 1; #10; left = 0; #1000;
    s = 1; #10; s = 0; #1000;
    up = 1; #10; up = 0; #1000;
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    up = 1; #10; up = 0; #1000;
    up = 1; #10; up = 0; #1000;
    up = 1; #10; up = 0; #1000;
    left = 1; #10; left = 0; #1000;
    left = 1; #10; left = 0; #1000;
    left = 1; #10; left = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    right = 1; #10; right = 0; #1000;
    right = 1; #10; right = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    left = 1; #10; left = 0; #1000;
    s = 1; #10; s = 0; #1000;
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    right = 1; #10; right = 0; #1000;
    s = 1; #10; s = 0; #1000;
    up = 1; #10; up = 0; #1000;
    s = 1; #10; s = 0; #1000;
    
    up = 1; #10; up = 0; #1000;
    left = 1; #10; left = 0; #1000;
    s = 1; #10; s = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    down = 1; #10; down = 0; #1000;
    s = 1; #10; s = 0; #1000;*/
    
    #5000;
    $finish;
    
  end
  always #5 clk = ~clk;
endmodule

