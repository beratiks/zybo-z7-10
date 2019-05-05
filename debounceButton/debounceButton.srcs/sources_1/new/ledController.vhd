----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2019 20:51:20
-- Design Name: 
-- Module Name: ledController - Behavioral
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

entity ledController is
    Port ( led : out STD_LOGIC_VECTOR (3 downto 0);
            setLed : in STD_LOGIC_VECTOR (3 downto 0)
    );
end ledController;

architecture Behavioral of ledController is

begin

    u0 : for i in 0 to 3 generate
    begin
    
    led(i) <= setLed(i);
    
    end generate;


end Behavioral;
