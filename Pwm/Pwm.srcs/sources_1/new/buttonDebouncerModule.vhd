----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2019 12:40:45 AM
-- Design Name: 
-- Module Name: buttonDebouncerModule - Behavioral
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

entity buttonDebouncerModule is
    Port ( clk_in : in STD_LOGIC;
           pin_in : in STD_LOGIC;
           pinState : out STD_LOGIC);
end buttonDebouncerModule;

architecture Behavioral of buttonDebouncerModule is

signal startCheck : boolean := false;
signal pinBool : boolean := false;
signal pin_in_prev : std_logic;

begin

u0 : process(clk_in)
variable counter : integer range 0 to 124999999 := 0;
begin

if rising_edge(clk_in) then
    if pin_in /= pin_in_prev then
        counter := 0;
        startCheck <= true;
    end if;
    pin_in_prev <= pin_in;
      
        if(startCheck = true) then
            if counter < 125000 then
                counter := counter + 1;
                
            else
                startCheck <= false;
                pinState <= pin_in;
                counter := 0;
             end if;
            
        end if;
        
end if;
    


end process;

end Behavioral;