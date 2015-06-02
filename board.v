`timescale 1ns / 1ps

/** @file board.v
 *  @author Xi Han
 *  
 *  This file represents the color of the cards on the board. The color serves
 *  two functionalities. For the display module, it is the base color it shall
 *  display. For the algorithm module, it is the information the module relies
 *  on to determine if two cards match; if the colors are the same, it is a
 *  match. Otherwise, it is not.
 *  
 */
 
module board(clk, addr, r, g, b);
             
  input clk;
  input [5:0] addr;
  
  output [2:0] r;
  output [2:0] g;
  output [1:0] b;
  
  reg [2:0] __r;
  reg [2:0] __g;
  reg [1:0] __b;
  
  always @(posedge clk) begin
    case (addr)
      0: begin
        __r <= 4;
        __g <= 4;
        __b <= 3;
      end
      
      1: begin
        __r <= 5;
        __g <= 2;
        __b <= 3;
      end
      
      2: begin
        __r <= 6;
        __g <= 2;
        __b <= 1;
      end
      
      3: begin
        __r <= 6;
        __g <= 2;
        __b <= 1;
      end
      
      4: begin
        __r <= 7;
        __g <= 0;
        __b <= 0;
      end
      
      5: begin
        __r <= 3;
        __g <= 0;
        __b <= 1;
      end
      
      6: begin
        __r <= 6;
        __g <= 5;
        __b <= 0;
      end
      
      7: begin
        __r <= 2;
        __g <= 5;
        __b <= 2;
      end
      
      8: begin
        __r <= 7;
        __g <= 7;
        __b <= 0;
      end
      
      9: begin
        __r <= 3;
        __g <= 0;
        __b <= 1;
      end
      
      10: begin
        __r <= 0;
        __g <= 6;
        __b <= 0;
      end
      
      11: begin
        __r <= 4;
        __g <= 2;
        __b <= 1;
      end
      
      12: begin
        __r <= 0;
        __g <= 5;
        __b <= 3;
      end
      
      13: begin
        __r <= 6;
        __g <= 5;
        __b <= 0;
      end
      
      14: begin
        __r <= 4;
        __g <= 4;
        __b <= 3;
      end
      
      15: begin
        __r <= 2;
        __g <= 3;
        __b <= 3;
      end
      
      16: begin
        __r <= 7;
        __g <= 0;
        __b <= 0;
      end
      
      17: begin
        __r <= 3;
        __g <= 3;
        __b <= 1;
      end
      
      18: begin
        __r <= 0;
        __g <= 5;
        __b <= 3;
      end
      
      19: begin
        __r <= 3;
        __g <= 3;
        __b <= 1;
      end
      
      20: begin
        __r <= 1;
        __g <= 4;
        __b <= 3;
      end
      
      21: begin
        __r <= 2;
        __g <= 3;
        __b <= 3;
      end
      
      22: begin
        __r <= 5;
        __g <= 2;
        __b <= 3;
      end
      
      23: begin
        __r <= 6;
        __g <= 0;
        __b <= 0;
      end
      
      24: begin
        __r <= 4;
        __g <= 5;
        __b <= 3;
      end
      
      25: begin
        __r <= 4;
        __g <= 6;
        __b <= 1;
      end
      
      26: begin
        __r <= 1;
        __g <= 4;
        __b <= 3;
      end
      
      27: begin
        __r <= 2;
        __g <= 5;
        __b <= 2;
      end
      
      28: begin
        __r <= 0;
        __g <= 6;
        __b <= 0;
      end
      
      29: begin
        __r <= 4;
        __g <= 2;
        __b <= 1;
      end
      
      30: begin
        __r <= 4;
        __g <= 5;
        __b <= 3;
      end
      
      31: begin
        __r <= 0;
        __g <= 0;
        __b <= 3;
      end
      
      32: begin
        __r <= 7;
        __g <= 7;
        __b <= 0;
      end
      
      33: begin
        __r <= 0;
        __g <= 0;
        __b <= 3;
      end
      
      34: begin
        __r <= 4;
        __g <= 6;
        __b <= 1;
      end
      
      35: begin
        __r <= 6;
        __g <= 0;
        __b <= 0;
      end
      
      default: begin
        __r <= 0;
        __g <= 0;
        __b <= 0;
      end
    endcase
  end

  assign r = __r;
  assign g = __g;
  assign b = __b;

endmodule
