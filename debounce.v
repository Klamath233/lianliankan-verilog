`timescale 1ns / 1ps

module debounce(clk, rst, btn, vld);

    input clk;
    input rst;
    input btn;
    output vld;
   wire [17:0] clk_dv_inc;
   reg         clk_en;
   reg         clk_en_d;
   reg         inst_vld;
   reg [2:0]   step_d;
   // ===========================================================================
   // 763Hz timing signal for clock enable
   // ===========================================================================

   assign clk_dv_inc = clk_dv + 1;
   reg [16:0]  clk_dv;
   always @ (posedge clk)
     if (rst)
       begin
          clk_dv   <= 0;
          clk_en   <= 1'b0;
          clk_en_d <= 1'b0;
       end
     else
       begin
          clk_dv   <= clk_dv_inc[16:0];
          clk_en   <= clk_dv_inc[17];
          clk_en_d <= clk_en;
       end
   
   // ===========================================================================
   // Instruction Stepping Control
   // ===========================================================================

   always @ (posedge clk)
     if (rst)
       begin
          step_d[2:0]  <= 0;
       end
     else if (clk_en)
       begin
          step_d[2:0]  <= {btn, step_d[2:1]};
       end

   always @ (posedge clk)
     if (rst)
       inst_vld <= 1'b0;
     else
       inst_vld <= ~step_d[0] & step_d[1] & clk_en_d;

    assign vld = inst_vld;
endmodule
