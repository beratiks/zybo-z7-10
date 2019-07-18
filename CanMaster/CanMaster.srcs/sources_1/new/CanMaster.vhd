----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2019 12:17:01 AM
-- Design Name: 
-- Module Name: CanMaster - Behavioral
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

entity CanMaster is
    Port 
    (
        sysclk : in std_logic
     );

end CanMaster;

architecture Behavioral of CanMaster is

 component clk_wiz_0 is
 port
 (
  clk_out1 : out std_logic;
  clk_in1  : in  std_logic      
 );
end component clk_wiz_0;

component CanClockGenerator is
Port 
(
 clk_input : in STD_LOGIC;
 clk_output : out STD_LOGIC
 );
end component CanClockGenerator;

signal clock_wiz : std_logic;
signal clock_can   : std_logic;

begin

clk_wiz : clk_wiz_0 port map
(
  clk_out1 => clock_wiz,
  clk_in1  => sysclk   
);

canClkGenerator : CanClockGenerator port map
(
    clk_input => clock_wiz,
    clk_output => clock_can
);



end Behavioral;
