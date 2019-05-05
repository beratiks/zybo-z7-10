----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2019 21:24:35
-- Design Name: 
-- Module Name: buttonController - Behavioral
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

entity buttonController is
    Port ( btn : in STD_LOGIC_VECTOR (3 downto 0);
           getButton : out STD_LOGIC_VECTOR(3 downto 0)
    );
end buttonController;

architecture Behavioral of buttonController is

begin

u0 : for i in 0 to 3 generate
begin

getButton(i) <= btn(i);

end generate;

end Behavioral;
