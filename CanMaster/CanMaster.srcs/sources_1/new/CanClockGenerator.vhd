----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/19/2019 01:35:06 AM
-- Design Name: 
-- Module Name: CanClockGenerator - Behavioral
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
library work;
use work.CanTypes.ALL;

entity CanClockGenerator is
    Port ( clk_input : in STD_LOGIC;
           clk_output : out STD_LOGIC);
end CanClockGenerator;

architecture Behavioral of CanClockGenerator is

signal sig_clk_input : std_logic;
signal sig_clk_output : std_logic := '0';

signal clockCounter : integer := 0;

begin

    sig_clk_input <= clk_input;
    clk_output    <= sig_clk_output;
    
    generateProcess : process(sig_clk_input)
    begin
        if(rising_edge(sig_clk_input)) then
            if(clockCounter >= BAUDRATE_PRESCALER -1) then
                sig_clk_output <= not sig_clk_output;
            else
                clockCounter <= clockCounter + 1;
            end if;        
        end if;
    
    end process;
    

end Behavioral;
