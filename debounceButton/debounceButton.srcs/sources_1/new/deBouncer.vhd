----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2019 21:33:11
-- Design Name: 
-- Module Name: deBouncer - Behavioral
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

entity deBouncer is
Port (
    setLed : out std_logic_vector(3 downto 0);
    getButton : in std_logic_vector(3 downto 0)
 );
end deBouncer;

architecture Behavioral of deBouncer is

begin

    u0 : for i in 0 to 3 generate
    begin
    
    setLed(i) <= getButton(i);
    
    end generate;


end Behavioral;