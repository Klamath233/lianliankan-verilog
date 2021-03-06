`timescale 1ns / 1ps

/** @file top.v
 *  @author Xi Han
 *  
 *  This top level module connect all components together.
 *
 */

module top(clk, rst, up, down, left, right, s,
           rgb_out, hs_out, vs_out,
           up_d, down_d, left_d, right_d, s_d);

  input clk;
  input rst;
  input up;
  input down;
  input left;
  input right;
  input s;
  
  output [7:0] rgb_out;
  output hs_out;
  output vs_out;
  output up_d;
  output down_d;
  output left_d;
  output right_d;
  output s_d;
  
  wire [5:0] addr_0;
  wire [5:0] addr_1;
  wire [2:0] r0;
  wire [2:0] g0;
  wire [1:0] b0;
  wire [2:0] r1;
  wire [2:0] g1;
  wire [1:0] b1;
  wire mf;
  wire ms;
  wire [35:0] sel_bus;
  wire [35:0] cur_bus;
  wire [35:0] blink_bus;
  wire [35:0] hidden_bus;
  wire up_d;
  wire down_d;
  wire left_d;
  wire right_d;
  wire s_d;
  wire en;
  wire clk_fsm;
  
  clock_module cm (
    .clk_in_100m_hz(clk),
    .clk_out_1000_hz(),
    .clk_out_100_hz(clk_fsm)
  );
  
  board bd0 (
    .clk(clk_fsm),
    .addr(addr_0),
    .r(r0),
    .g(g0),
    .b(b0)
  );
  
  board bd1 (
    .clk(clk),
    .addr(addr_1),
    .r(r1),
    .g(g1),
    .b(b1)
  );
  
  card_array ca (
    .clk(clk_fsm),
    .rst(rst),
    .s(s),
    .mf(mf),
    .ms(ms),
    .cur_bus(cur_bus),
    .sel_bus(sel_bus),
    .blink_bus(blink_bus),
    .hidden_bus(hidden_bus)
  );
  
  input_module im (
    .en(en),
    .up_in(up),
    .right_in(right),
    .down_in(down),
    .left_in(left),
    .s_in(s),
    .up_out(up_d),
    .right_out(right_d),
    .down_out(down_d),
    .left_out(left_d),
    .s_out(s_d),
    .clk(clk)
  );
  
  cursor cursor (
    .clk(clk_fsm),
    .rst(rst),
    .up(up),
    .down(down),
    .left(left), 
    .right(right),
    .cur_bus(cur_bus)
  );
  
  matcher matcher (
    .clk(clk_fsm),
    .rst(rst),
    .sel_bus(sel_bus),
    .hidden_bus(hidden_bus),
    .r(r0),
    .g(g0),
    .b(b0),
    .addr(addr_0),
    .ms(ms),
    .mf(mf),
    .en_input(en)
  );
  
  vga_timing vga (
    .clk100_in(clk),
    .clk100hz_in(clk_fsm),
    .r(r1),
    .g(g1),
    .b(b1),
    .hidden_bus(hidden_bus),
    .blink_bus(blink_bus),
    .sel_bus(sel_bus),
    .rgb_out(rgb_out),
    .hs_out(hs_out),
    .vs_out(vs_out),
    .addr(addr_1)
  );

endmodule
