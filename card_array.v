`timescale 1ns / 1ps

/** @file card_array.v
 *  @author Xi Han
 *  
 *  This file represents the 6x6 array of cards in our program.
 *  It divides the input signals except the cur_bus signal to 
 *  multiple instances and distributes them to the cards. It also
 *  concatenate the individual outputs of the cards to a bus for
 *  the convenience of the display and algorithm module.
 */
 
module card_array(clk, rst, s, mf, ms, cur_bus,
                  sel_bus, blink_bus, hidden_bus);

  input clk; // the clock signal.
  input rst; // the reset signal.
  input s; // the button s signal.
  input mf; // the match failure signal.
  input ms; // the match success signal
  input [35:0] cur_bus; // the curson bus input from the cursor module.

  output [35:0] sel_bus; // the select bus output.
  output [35:0] blink_bus; // the blink bus output.
  output [35:0] hidden_bus; // the hidden bus output.

  generate
    genvar i;
    for (i = 0; i < 36; i = i + 1) begin
      card card(
        .clk(clk),
        .rst(rst),
        .cur(cur_bus[i]),
        .s(s),
        .mf(mf),
        .ms(ms),
        .sel(sel_bus[i]),
        .blink(blink_bus[i]),
        .hidden(hidden_bus[i]),
        .state_debug()
      );
    end
  endgenerate
  
endmodule