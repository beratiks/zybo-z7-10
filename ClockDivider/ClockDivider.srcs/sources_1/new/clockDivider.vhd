----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 20:39:04
-- Design Name: 
-- Module Name: clockDivider - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clockDivider is
    Port ( sys_clk_pin : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0));
end clockDivider;

architecture Behavioral of clockDivider is

signal  diveder : integer range 0 to 62500000;
signal temporary : std_logic := '0';

begin

u0 : process(sys_clk_pin)
begin
if(rising_edge(sys_clk_pin)) then

diveder <= diveder + 1;
if(diveder = 62499999) then 
    temporary <= not temporary;
    diveder <= 0;
end if;
end if; 
end process;

led(0) <= temporary;
led(1) <= temporary;
led(2) <= temporary;
led(3) <= temporary;


end Behavioral;
