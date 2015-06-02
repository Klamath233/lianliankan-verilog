`timescale 1ns / 1ps

/** @file matcher.v
 *  @author Xi Han
 *  
 *  This file implements the core algorithm of the game. The game rule says two
 *  cards match if they have the same color and they can reach the same border
 *  of the board; that is, there is no other cards between each of them and the
 *  border. The module implements a complex finite state machine which do two
 *  things. The first is that it reads all information it needs to its internal
 *  registers for the convenience of computation. The other is that it walks
 *  through all four directions trying to find a solution. If a solution is
 *  found, the module asserts ms; if no solution is found, it asserts mf. While
 *  it is finding the solution or loading the data, it does not assert either
 *  of the signals.
 *
 */

module matcher(clk, rst, sel_bus, hidden_bus, r, g, b,
               addr, ms, mf);

  input clk;
  input rst;
  input [35:0] sel_bus;
  input [35:0] hidden_bus;
  input [2:0] r;
  input [2:0] g;
  input [1:0] b;
  
  output [5:0] addr;
  output ms;
  output mf;
  
  reg [5:0] __addr = 0;
  reg __ms = 0;
  reg __mf = 0;
  
  reg [2:0] __row = 0;
  reg [2:0] __col = 0;
  reg [1:0] __dir = 0;
  reg __which = 0;
  reg __en = 0;
  reg __adding = 0;
  reg [2:0] __reading = 0;
  reg __ready = 0;
  
  reg [5:0] __coord0;
  reg [5:0] __coord1;
  reg [35:0] __hidden_buf;
  reg [2:0] __r0;
  reg [2:0] __g0;
  reg [1:0] __b0;
  reg [2:0] __r1;
  reg [2:0] __g1;
  reg [1:0] __b1;
  reg [2:0] __r;
  reg [2:0] __g;
  reg [1:0] __b;
  
  reg [1:0] __sel_acc = 0;
  integer i;
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      __row <= 0;
      __col <= 0;
      __dir <= 0;
      __which <= 0;
      __en <= 0;
      __reading <= 0;
      __sel_acc <= 0;
      __addr <= 0;
      __ms <= 0;
      __mf <= 0;
    end else begin
      
      
      // If the matcher is in its initial state and it is free, check sel_bus to see if there
      // are two cards selected.
      if (!__en && !__adding) begin
        __sel_acc <= sel_bus[0] + sel_bus[1] + sel_bus[2] + sel_bus[3] +
                     sel_bus[4] + sel_bus[5] + sel_bus[6] + sel_bus[7] +
                     sel_bus[8] + sel_bus[9] + sel_bus[10] + sel_bus[11] +
                     sel_bus[12] + sel_bus[13] + sel_bus[14] + sel_bus[15] +
                     sel_bus[16] + sel_bus[17] + sel_bus[18] + sel_bus[19] +
                     sel_bus[20] + sel_bus[21] + sel_bus[22] + sel_bus[23] +
                     sel_bus[24] + sel_bus[25] + sel_bus[26] + sel_bus[27] +
                     sel_bus[28] + sel_bus[29] + sel_bus[30] + sel_bus[31] +
                     sel_bus[32] + sel_bus[33] + sel_bus[34] + sel_bus[35];
        __adding <= 1;
        
        __ms <= 0;
        __mf <= 0;
      end
      
      if (!__en && __adding) begin
        if (__sel_acc == 2) begin
          __en <= 1;
        end else begin
          __en <= 0;
        end
        __adding <= 0;
        __sel_acc <= 0;
      end
      
      // Save the state of the hidden bus and issue the read request to the
      // board.
      if (__en && !__ready) begin
        if (__reading == 0) begin
          casez (sel_bus)
            36'b1???????????????????????????????????: __coord0 <= 35;
            36'b01??????????????????????????????????: __coord0 <= 34;
            36'b001?????????????????????????????????: __coord0 <= 33;
            36'b0001????????????????????????????????: __coord0 <= 32;
            36'b00001???????????????????????????????: __coord0 <= 31;
            36'b000001??????????????????????????????: __coord0 <= 30;
            36'b0000001?????????????????????????????: __coord0 <= 29;
            36'b00000001????????????????????????????: __coord0 <= 28;
            36'b000000001???????????????????????????: __coord0 <= 27;
            36'b0000000001??????????????????????????: __coord0 <= 26;
            36'b00000000001?????????????????????????: __coord0 <= 25;
            36'b000000000001????????????????????????: __coord0 <= 24;
            36'b0000000000001???????????????????????: __coord0 <= 23;
            36'b00000000000001??????????????????????: __coord0 <= 22;
            36'b000000000000001?????????????????????: __coord0 <= 21;
            36'b0000000000000001????????????????????: __coord0 <= 20;
            36'b00000000000000001???????????????????: __coord0 <= 19;
            36'b000000000000000001??????????????????: __coord0 <= 18;
            36'b0000000000000000001?????????????????: __coord0 <= 17;
            36'b00000000000000000001????????????????: __coord0 <= 16;
            36'b000000000000000000001???????????????: __coord0 <= 15;
            36'b0000000000000000000001??????????????: __coord0 <= 14;
            36'b00000000000000000000001?????????????: __coord0 <= 13;
            36'b000000000000000000000001????????????: __coord0 <= 12;
            36'b0000000000000000000000001???????????: __coord0 <= 11;
            36'b00000000000000000000000001??????????: __coord0 <= 10;
            36'b000000000000000000000000001?????????: __coord0 <= 9;
            36'b0000000000000000000000000001????????: __coord0 <= 8;
            36'b00000000000000000000000000001???????: __coord0 <= 7;
            36'b000000000000000000000000000001??????: __coord0 <= 6;
            36'b0000000000000000000000000000001?????: __coord0 <= 5;
            36'b00000000000000000000000000000001????: __coord0 <= 4;
            36'b000000000000000000000000000000001???: __coord0 <= 3;
            36'b0000000000000000000000000000000001??: __coord0 <= 2;
            36'b00000000000000000000000000000000001?: __coord0 <= 1;
            36'b000000000000000000000000000000000001: __coord0 <= 0;
          endcase
          
          casez (sel_bus)
            36'b???????????????????????????????????1: __coord1 <= 0;
            36'b??????????????????????????????????10: __coord1 <= 1;
            36'b?????????????????????????????????100: __coord1 <= 2;
            36'b????????????????????????????????1000: __coord1 <= 3;
            36'b???????????????????????????????10000: __coord1 <= 4;
            36'b??????????????????????????????100000: __coord1 <= 5;
            36'b?????????????????????????????1000000: __coord1 <= 6;
            36'b????????????????????????????10000000: __coord1 <= 7;
            36'b???????????????????????????100000000: __coord1 <= 8;
            36'b??????????????????????????1000000000: __coord1 <= 9;
            36'b?????????????????????????10000000000: __coord1 <= 10;
            36'b????????????????????????100000000000: __coord1 <= 11;
            36'b???????????????????????1000000000000: __coord1 <= 12;
            36'b??????????????????????10000000000000: __coord1 <= 13;
            36'b?????????????????????100000000000000: __coord1 <= 14;
            36'b????????????????????1000000000000000: __coord1 <= 15;
            36'b???????????????????10000000000000000: __coord1 <= 16;
            36'b??????????????????100000000000000000: __coord1 <= 17;
            36'b?????????????????1000000000000000000: __coord1 <= 18;
            36'b????????????????10000000000000000000: __coord1 <= 19;
            36'b???????????????100000000000000000000: __coord1 <= 20;
            36'b??????????????1000000000000000000000: __coord1 <= 21;
            36'b?????????????10000000000000000000000: __coord1 <= 22;
            36'b????????????100000000000000000000000: __coord1 <= 23;
            36'b???????????1000000000000000000000000: __coord1 <= 24;
            36'b??????????10000000000000000000000000: __coord1 <= 25;
            36'b?????????100000000000000000000000000: __coord1 <= 26;
            36'b????????1000000000000000000000000000: __coord1 <= 27;
            36'b???????10000000000000000000000000000: __coord1 <= 28;
            36'b??????100000000000000000000000000000: __coord1 <= 29;
            36'b?????1000000000000000000000000000000: __coord1 <= 30;
            36'b????10000000000000000000000000000000: __coord1 <= 31;
            36'b???100000000000000000000000000000000: __coord1 <= 32;
            36'b??1000000000000000000000000000000000: __coord1 <= 33;
            36'b?10000000000000000000000000000000000: __coord1 <= 34;
            36'b100000000000000000000000000000000000: __coord1 <= 35;
          endcase
          
          __hidden_buf <= hidden_bus;
          __reading <= 1;      
        end
        
        if (__reading == 1) begin
          if (__hidden_buf[__coord1] || __hidden_buf[__coord0]) begin
            __ms <= 0;
            __mf <= 0;
            __en <= 0;
            __reading <= 0;
            __ready <= 0;
              
            __row <= 0;
            __col <= 0;
            __which <= 0;
            __dir <= 0;
          end else begin
            __reading <= 2;
          end
        end
        
        if (__reading == 2) begin
          __addr <= __coord0;
          __reading <= 3;
        end
        
        if (__reading == 3) begin
          __addr <= __coord1;
          __reading <= 4;
          
        end
        
        if (__reading == 4) begin
          __addr <= 0;
          __reading <= 5;
          
          __r0 <= r;
          __g0 <= g;
          __b0 <= b;
          
        end
        
        if (__reading == 5) begin
          __ready <= 1;
          __reading <= 0;
          
          __r1 <= r;
          __g1 <= g;
          __b1 <= b;
          
          __row <= __coord0 / 6;
          __col <= __coord0 % 6;
        end
      end
      
      // Data is all ready, we can start to compute.
      if (__en && __ready) begin

        // Searching UP.
        if (__dir == 0) begin
          // First, see whether the colors match; assert failure if not.
          if (__r0 != __r1 || __g0 != __g1 || __b0 != __b1) begin
            __mf <= 1;
            __en <= 0;
            __reading <= 0;
            __ready <= 0;
            
            __row <= 0;
            __col <= 0;
            __which <= 0;
            __dir <= 0;
          end

          if (__row == 0) begin
            if (__which == 0) begin
              __which <= 1;
              __row <= __coord1 / 6;
              __col <= __coord1 % 6;
            end
            
            if (__which == 1) begin
              __ms <= 1;
              __en <= 0;
              __reading <= 0;
              __ready <= 0;
            end
          end else if (__hidden_buf[6 * (__row - 1) + __col] == 1) begin
            __row <= __row - 1;
          end else begin // search failed, go to next direction.
            __dir <= 1;
            __row <= __coord0 / 6;
            __col <= __coord0 % 6;
            __which <= 0;
          end
        end
        
        // Searching RIGHT.
        if (__dir == 1) begin
          if (__col == 5) begin
            if (__which == 0) begin
              __which <= 1;
              __row <= __coord1 / 6;
              __col <= __coord1 % 6;
            end
            
            if (__which == 1) begin
              __ms <= 1;
              __en <= 0;
              __reading <= 0;
              __ready <= 0;
              
              __row <= 0;
              __col <= 0;
              __which <= 0;
              __dir <= 0;
            end
          end else if (__hidden_buf[6 * __row + __col + 1] == 1) begin
            __col <= __col + 1;
          end else begin // search failed, go to next direction.
            __dir <= 2;
            __row <= __coord0 / 6;
            __col <= __coord0 % 6;
            __which <= 0;
          end
        end
        
        // Searching DOWN.
        if (__dir == 2) begin
          if (__row == 5) begin
            if (__which == 0) begin
              __which <= 1;
              __row <= __coord1 / 6;
              __col <= __coord1 % 6;
            end
            
            if (__which == 1) begin
              __ms <= 1;
              __en <= 0;
              __reading <= 0;
              __ready <= 0;
              
              __row <= 0;
              __col <= 0;
              __which <= 0;
              __dir <= 0;
            end
          end else if (__hidden_buf[6 * (__row + 1) + __col] == 1) begin
            __row <= __row + 1;
          end else begin // search failed, go to next direction.
            __dir <= 3;
            __row <= __coord0 / 6;
            __col <= __coord0 % 6;
            __which <= 0;
          end
        end
        
        // Searching LEFT.
        if (__dir == 3) begin
          if (__col == 0) begin
            if (__which == 0) begin
              __which <= 1;
              __row <= __coord1 / 6;
              __col <= __coord1 % 6;
            end
            
            if (__which == 1) begin
              __ms <= 1;
              __en <= 0;
              __reading <= 0;
              __ready <= 0;
              
              __row <= 0;
              __col <= 0;
              __which <= 0;
              __dir <= 0;
            end
          end else if (__hidden_buf[6 * __row + __col - 1] == 1) begin
            __col <= __col - 1;
          end else begin // search failed, assert failure.
            __mf <= 1;
            __en <= 0;
            __reading <= 0;
            __ready <= 0;
            
            __row <= 0;
            __col <= 0;
            __which <= 0;
            __dir <= 0;
          end
        end
      end
    end
  end
  
  assign addr = __addr;
  assign ms = __ms;
  assign mf = __mf;

endmodule
