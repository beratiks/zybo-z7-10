----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2019 05:08:22 PM
-- Design Name: 
-- Module Name: ClockDivider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockDivider is
    generic(
      triggerLimit : integer := 125/2      -- input system clock is 125mhz, needed output clock frequency is 1mhz. For that 125/1 = 125
    );
    Port ( i_clk : in STD_LOGIC;
           o_clk : out STD_LOGIC := '0');
end ClockDivider;

architecture Behavioral of ClockDivider is

signal tempClk : std_logic := '0';

begin

clkCountProc : process(i_clk)

variable clkCounter : integer range 0 to triggerLimit := 0;


begin

if(rising_edge(i_clk)) then
    
    if(clkCounter < triggerLimit) then
    
        clkCounter := clkCounter + 1;
    
    elsif(clkCounter >= triggerLimit) then
    
        clkCounter := 0;
        tempClk <= not tempClk;
    
    end if;


end if;


end process;

o_clk <= tempClk;

end Behavioral;
