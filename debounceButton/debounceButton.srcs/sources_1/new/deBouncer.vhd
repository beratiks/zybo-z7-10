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
    setLed : out std_logic;
    getButton : in std_logic
 );
end deBouncer;

architecture Behavioral of deBouncer is



begin

--u0 : process(sys_clock)
--variable counter : integer := 0;
--begin

setLed <= getButton;


--end process;

end Behavioral;
