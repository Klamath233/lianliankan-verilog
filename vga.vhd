-- 640 x 480

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity vga_timing is
port (
	clk100_in: in std_logic;
	rgb_out:  out std_logic_vector(7 downto 0);
	hs_out: out std_logic;
	vs_out: out std_logic);
end vga_timing;


architecture behavioral of vga_timing is
signal clk25: std_logic := '0';
signal hc : std_logic_vector(9 downto 0) := "0000000000";
signal vc : std_logic_vector(9 downto 0) := "0000000000";
signal counter : std_logic_vector(1 downto 0) := "00";

begin

	-- This process divides the main clock (100MHz) to (25MHz)
	-- Do not modify this
	process(clk100_in)
	begin
		if clk100_in'event and clk100_in='1' then
			counter <= counter+'1';
			if counter = "11" then
				clk25 <= '1';
				counter <= "00";
			else
				clk25 <= '0';
			end if;
		end if;
	end process;

	-- This is the process that you want to modify in order to display
	-- different drawings on the screen. 
	-- The screen size is 640 by 480.
	-- Currently, it is displaying "white color" on the screen (i.e., the pixels
	--  within the screen size) 
	process(clk25)
	begin
		if hc < 640 and vc < 480 then
			rgb_out <= "11111111";
		else
			rgb_out <= "00000000";
		end if;
	end process;
	
	-- Do not modify this process
	process(clk25)
	begin
		if clk25'event and clk25 = '1' then
			-- porch
			if hc >= (639+16) and hc <= (639+16+96) then
				hs_out <= '0';
			else
				hs_out <= '1';
			end if;
			
			if vc >= (479+10) and vc <= (479+10+2) then
				vs_out <= '0';
			else
				vs_out <= '1';
			end if;
			
			-- hc from 0 to 799; the whole frame is 800
			hc <= hc + 1;
			if hc = 799 then
				vc <= vc + 1;
				hc <= "0000000000";
			end if;
			
			-- vc from 0 to 524; the whole frame is 525
			if vc = 524 then
				vc <= "0000000000";
			end if;
		end if;
	end process;
end behavioral;
	