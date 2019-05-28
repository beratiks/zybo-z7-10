----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2019 11:18:04 PM
-- Design Name: 
-- Module Name: AdcModule - Behavioral
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

entity AdcModule is
    Port ( led : out STD_LOGIC_VECTOR (3 downto 0);
           ja : in STD_LOGIC_VECTOR (1 downto 0);
           sys_clock : in STD_LOGIC);
end AdcModule;

architecture Behavioral of AdcModule is

component xadc_wiz_0 is
   port
   (
    daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
    den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
    di_in           : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
    dwe_in          : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
    do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
    dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
    vauxp14         : in  STD_LOGIC;                         -- Auxiliary Channel 14
    vauxn14         : in  STD_LOGIC;
    busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
    channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
    eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
    eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
    alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
    vp_in           : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
    vn_in           : in  STD_LOGIC
);
end component;

signal ADCValidData : std_logic_vector(7 downto 0);
signal ADCNonValidData : std_logic_vector(7 downto 0);
signal EnableInt : std_logic := '1';

begin

adcImp : xadc_wiz_0
port map
(
    daddr_in        => "0011110",           -- 14th drp port address is 0x1E
    den_in          => EnableInt,           -- set enable drp port
    di_in           => (others => '0'),     -- set input data as 0 
    dwe_in          => '0',                 -- disable write to drp
    do_out(15 downto 8)    => ADCValidData, -- because we use unipolar xadc
    do_out(7 downto 0)    => ADCNonValidData,  -- non valid data with dummy vector
    drdy_out        => open,                    
    dclk_in         => sys_clock,           -- 125 Mhz system clock wires to drp
    vauxp14         => ja(0),                        
    vauxn14         => ja(1),
    busy_out        => open,                   
    channel_out    => open,    
    eoc_out         => EnableInt,                       
    eos_out         => open,                      
    alarm_out       => open,                         
    vp_in           => '0',                        
    vn_in           => '0'
);

ledProcess : process(ADCValidData)
begin

if(ADCValidData <= "00000001") then

led <= "0000";

elsif(ADCValidData > "00000001" and  ADCValidData < "00000011") then

led <= "0001";

elsif(ADCValidData >= "00000011" and  ADCValidData < "00001111") then

led <= "0011";

elsif(ADCValidData >= "00001111" and  ADCValidData <= "00111111") then

led <= "0111";

elsif(ADCValidData >= "00111111" and  ADCValidData <= "11111111") then

led <= "1111";

end if;

end process;

end Behavioral;
