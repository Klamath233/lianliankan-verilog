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

  // The internal buses which divide the signals.
  wire [35:0] __clk_bus;
  wire [35:0] __rst_bus;
  wire [35:0] __s_bus;
  wire [35:0] __mf_bus;
  wire [35:0] __ms_bus;

  // The driver driving the bus.
  reg [35:0] __clk_bus_driver;
  reg [35:0] __rst_bus_driver;
  reg [35:0] __s_bus_driver;
  reg [35:0] __mf_bus_driver;
  reg [35:0] __ms_bus_driver;
  
  generate
    genvar i;
    for (i = 0; i < 36; i = i + 1) begin
      always @* begin
        __clk_bus_driver[i] = clk;
        __rst_bus_driver[i] = rst;
        __s_bus_driver[i] = s;
        __mf_bus_driver[i] = mf;
        __ms_bus_driver[i] = ms;
      end
    end
  endgenerate

  assign __clk_bus = __clk_bus_driver;
  assign __rst_bus = __rst_bus_driver;
  assign __s_bus = __s_bus_driver;
  assign __mf_bus = __mf_bus_driver;
  assign __ms_bus = __ms_bus_driver;
  
  card card_array[35:0](
    .clk(__clk_bus),
    .rst(__rst_bus),
    .cur(__cur_bus),
    .s(__s_bus),
    .mf(__mf_bus),
    .ms(__ms_bus),
    .sel(__sel_bus),
    .blink(__blink_bus),
    .hidden(__hidden_bus)
  );

endmodule