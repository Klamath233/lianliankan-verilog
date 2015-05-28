`timescale 1ns / 1ps

module card(clk, rst, cur, s, mf, ms,
            sel, blink, hidden);

  input clk; // the clock signal.
  input cur; // the cursor signal.
  input s; // the button s hit signal.
  input mf; // the match failure signal.
  input ms; // the match success signal.

  output sel; // the card selected signal.
  output blink; // the card blinking signal.
  output hidden; S// the card hidden signal.

  /** States encoding scheme:
   *  00001: the normal and initial state of every card.
   *  00010: the normal state under cursor.
   *  00100: the selected state.
   *  01000: the selected state under cursor.
   *  10000: the matched/success state.
   */
  reg [5:0] __state = 5'b00001;

  // The registers driving the outputs.
  reg __sel = 0;
  reg __blink = 0;
  reg __hidden = 0;

  // NS.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // reset
      __state <= 5'b00001;
    end
    else begin
      if (__state == 5'b00001) begin
        if (cur) begin
          __state <= 5'b00010;
        end else begin
          __state <= 5'b00001;
        end
      end else if (__state == 5'b00010) begin
        if (cur && s) begin
          __state <= 5'b00100;
        end else if (cur && !s) begin
          __state <= 5'b00010
        end else if (!cur) begin
          __state <= 5'b00001;
        end
      end else if (__state == 5'b00100) begin
        if (ms) begin
          __state <= 5'b10000;
        end else if (mf) begin
          __state <= 5'b00001;
        end else if (cur) begin
          __state <= 5'b01000;
        end else begin
          __state <= 5'b00100;
        end
      end else if (__state == 5'b01000) begin
        if (ms) begin
          __state <= 5'b10000;
        end else if (mf) begin
          __state <= 5'b00010;
        end else if (cur && s) begin
          __state <= 5'b00001;
        end else if (cur && !s) begin
          __state <= 5'b0100;
        end else if (!cur) begin
          __state <= 5'b00100;
        end
      end else if (__state == 5'b10000) begin
        __state <= 5'b10000;
      end else begin
        __state <= 5'b00001;
      end
    end
  end

  // OUTPUT.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // reset
      __sel <= 0;
      __blink <= 0;
      __hidden <= 0;
    end
    else begin
      if (__state == 5'b00001) begin
        __sel <= 0;
        __blink <= 0;
        __hidden <= 0;
      end else if (__state == 5'b00010) begin
        __sel <= 0;
        __blink <= 1;
        __hidden <= 0;
      end else if (__state == 5'b00100) begin
        __sel <= 1;
        __blink <= 0;
        __hidden <= 0;
      end else if (__state == 5'b01000) begin
        __sel <= 1;
        __blink <= 1;
        __hidden <= 0;
      end else if (__state == 5'b10000) begin
        __sel <= 0;
        __blink <= 0;
        __hidden <= 1;
      end else begin
        __sel <= 0;
        __blink <= 0;
        __hidden <= 0;
      end
    end
  end

  assign sel = __sel;
  assign blink = __blink;
  assign hidden = __hidden;

endmodule