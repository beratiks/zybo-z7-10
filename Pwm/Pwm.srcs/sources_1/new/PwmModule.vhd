----------------------------------------------------------------------------------
-- Engineer: Berat YILDIZ
-- e-mail : yildizberat@gmail.com
-- Create Date: 09/04/2019 10:46:01 PM
-- Design Name: 
-- Module Name: PwmModule - Behavioral
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

entity PwmModule is
    generic
    (
        SYS_CLOCK_HZ : integer := 125e6
    );
    Port (
          
           main_clock : in STD_LOGIC;   -- sys clock 125Mhz
           frequency  : in integer range 0 to 125000000;    --
           pwm_pin : out STD_LOGIC;     -- pwm phy pin
           duty : in integer range 0 to 100;    -- duty percent
           startPwm : in STD_LOGIC;             --pwm start on rising edge
           stopPwm : in STD_LOGIC               -- pwm stop on rising edge
           );
end PwmModule;

architecture Behavioral of PwmModule is

signal sig_pwm_pin : std_logic;

signal sig_startPwmPrev : std_logic;
signal sig_stopPwmPrev  : std_logic;

type PwmState is (Stop,Start);
signal pwmStateEnum : PwmState := Stop; 

signal pwmCounterLimit : integer := 0;
signal pwmCounter : integer := 0;

begin

pwm_pin <= sig_pwm_pin;

pwmStateProc : process(main_clock,startPwm,stopPwm)
begin

    if(rising_edge(main_clock)) then
    
        if(sig_startPwmPrev = '0' and startPwm = '1') then
        
            pwmStateEnum <= Start;
        
        end if;
        
        sig_startPwmPrev <= startPwm;
        
        if(sig_stopPwmPrev = '0' and stopPwm = '1') then
        
            pwmStateEnum <= Stop;
        
        end if;
        
        sig_stopPwmPrev <= stopPwm;
    
    end if;

end process;


pwmFreqProc : process(main_clock)

begin

    if(rising_edge(main_clock)) then
        pwmCounterLimit <= (SYS_CLOCK_HZ / frequency);
        
        if(pwmCounter = pwmCounterLimit - 1) then
        
            pwmCounter <= 0;
            
        else
        
            pwmCounter <= pwmCounter + 1;
            
        
        end if;
    
    
    end if;

end process;

pwmDutyProc : process(main_clock,duty)

begin

    if(rising_edge(main_clock)) then
    
        if(pwmCounter < (pwmCounterLimit*duty)/100 and pwmStateEnum = Start) then
        
            sig_pwm_pin <= '1';
            
        else
        
           sig_pwm_pin <= '0';
        
        end if;
    
    
    end if;

end process;

end Behavioral;
