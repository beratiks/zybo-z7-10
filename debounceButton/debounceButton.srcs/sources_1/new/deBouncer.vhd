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
use IEEE.NUMERIC_STD.ALL;

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
    getButton : in std_logic;
    sys_clock : in std_logic
 );
end deBouncer;

architecture Behavioral of deBouncer is

signal startCheck : boolean := false;
signal ledState : boolean := false;

begin

u0 : process(sys_clock)
variable counter : integer range 0 to 124999999 := 0;
begin

if rising_edge(sys_clock) then
    if getButton = '1' then
        
        if counter < 125000 then
            counter := counter + 1;
            startCheck <= false;
        else
           if startCheck = false then 
                startCheck <= true;
                if(ledState = false) then
                    ledState <= true;
                    setLed <= '1';
                else
                ledState <= false;
                setLed <= '0';
                end if;
           end if;
        
        end if;
        
        
        
    else
    
    counter := 0;
    
    end if;
end if;
    


end process;

end Behavioral;
