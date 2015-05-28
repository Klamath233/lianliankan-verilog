`timescale 1ns / 1ps

module card_array(clk, rst, s, mf, ms, cur_bus,
                  sel_bus, blink_bus, hidden_bus);

  input clk;
  input rst;
  input s;
  input mf;
  input ms;
  input [35:0] cur_bus;

  output [35:0] sel_bus;
  output [35:0] blink_bus;
  output [35:0] hidden_bus;

  wire [35:0] __clk_bus;
  wire [35:0] __rst_bus;
  wire [35:0] __s_bus;
  wire [35:0] __mf_bus;
  wire [35:0] __ms_bus;

  integer i;
  for (i = 0; i < 36; i = i + 1) begin
    assign __clk_bus[i] = clk;
    assign __rst_bus[i] = rst;
    assign __s_bus[i] = s;

    if (cur_bus[i] == 1) begin
      assign __mf_bus[i] = mf;
      assign __ms_bus[i] = ms;
    end else begin
      assign __mf_bus[i] = 0;
      assign __ms_bus[i] = 0;
    end
  end

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

end