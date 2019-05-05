----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2019 17:41:36
-- Design Name: 
-- Module Name: ledControler - Behavioral
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

entity ledControler is
    Port ( led : out STD_LOGIC_VECTOR (3 downto 0);
           setLed : in std_logic_vector(3 downto 0)
    );
end ledControler;

architecture Behavioral of ledControler is

begin

led(0) <= setled(0);
led(1) <= '1';


end Behavioral;
