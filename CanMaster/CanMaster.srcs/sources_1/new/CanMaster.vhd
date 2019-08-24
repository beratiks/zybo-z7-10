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
use IEEE.NUMERIC_STD.ALL;
library work;
use work.canTypes.ALL;

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
        sys_clock : in std_logic;
        rx     : in std_logic;
        tx     : out std_logic;
        led    : out std_logic_vector(3 downto 0);
        btn    : in  std_logic_vector(3 downto 0);
        sw    : in  std_logic_vector(3 downto 0);
        led6_r : out std_logic
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


component BitStreamProcessor is
Port ( 
    Tx_Pin               : out STD_LOGIC;
    Rx_Pin               : in STD_LOGIC;
    clk_in               : in STD_LOGIC;
    receivePackage       : out CanPackage;
    transmitPackage      : in CanPackage;
    receiving            : out STD_LOGIC;
    receiveIT            : out STD_LOGIC;
    transmitIT           : out STD_LOGIC;
    error                : out STD_LOGIC_VECTOR(SIZE_OF_ERRORS - 1 downto 0);
    transmitOrder        : in STD_LOGIC;
    startReceive         : in std_logic;
    bitstuffTrigger      : out std_logic;
    leds                 : out std_logic_vector(3 downto 0)
    );
    
end component BitStreamProcessor;

    signal clock_wiz : std_logic;

    signal sig_receivePackage       : CanPackage;
    signal sig_transmitPackage      : CanPackage;
    signal sig_receiving            : STD_LOGIC;
    signal sig_receiveIT            : STD_LOGIC;
    signal sig_transmitIT           : STD_LOGIC;
    signal sig_error                : STD_LOGIC_VECTOR(SIZE_OF_ERRORS - 1 downto 0);
    signal sig_transmitOrder        : STD_LOGIC;
    
    signal btn0             : std_logic;
    signal btn0_prev        : std_logic;
    
    signal led0             : std_logic;
    
    signal toggle           : boolean := false;    
    
    signal sig_startReceive : std_logic := '0';   
    
    signal sig_bitstuffTrigger  : std_logic;
    
    signal beforeSw : std_logic_vector(3 downto 0);
    
    signal sig_transmitITPrev : std_logic;
    

    
begin

    led6_r <= led0;

clk_wiz : clk_wiz_0 port map
(
  clk_out1 => clock_wiz,
  clk_in1  => sys_clock   
);


BSP : BitStreamProcessor port map
(
    Tx_Pin               => tx,
    Rx_Pin               => rx,
    clk_in               => clock_wiz,
    receivePackage       => sig_receivePackage,
    transmitPackage      => sig_transmitPackage,
    receiving            => sig_receiving,
    receiveIT            => sig_receiveIT,
    transmitIT           => sig_transmitIT,
    error                => sig_error,
    transmitOrder        => sig_transmitOrder,
    startReceive         => sig_startReceive,
    bitstuffTrigger      => sig_bitstuffTrigger,
    leds                  => led
);

     sig_transmitPackage.StdId <= "00100000000";
     sig_transmitPackage.Dlc   <= "1000";
     sig_transmitPackage.Rtr   <= '0';
  
proc : process

    variable sig_receiveITPRev : std_logic;
    
begin

    if(rising_edge(sys_clock)) then

        
        if(sw /= beforeSw and sig_transmitOrder = '0' and sig_receiving = '0' ) then          
    
            if(sw(0) = '0') then
            
                sig_transmitPackage.Data(0) <= std_logic_vector(to_unsigned(0,8));
            
            else
            
                sig_transmitPackage.Data(0) <= std_logic_vector(to_unsigned(1,8));
            
            end if;
            
            if(sw(1) = '0') then
            
                sig_transmitPackage.Data(1) <= std_logic_vector(to_unsigned(0,8));
            
            else
            
                sig_transmitPackage.Data(1) <= std_logic_vector(to_unsigned(1,8));
            
            end if;
            
            if(sw(2) = '0') then
            
                sig_transmitPackage.Data(2) <= std_logic_vector(to_unsigned(0,8));
            
            else
            
                sig_transmitPackage.Data(2) <= std_logic_vector(to_unsigned(1,8));
            
            end if;
            
            if(sw(3) = '0') then
            
                sig_transmitPackage.Data(3) <= std_logic_vector(to_unsigned(0,8));
            
            else
            
                sig_transmitPackage.Data(3) <= std_logic_vector(to_unsigned(1,8));
            
            end if;
                
            sig_transmitOrder <= '1';   
            
            led0 <= not led0;
                 
        end if; 
        beforeSw <= sw;
        
        
        if(sig_transmitITPrev = '0' and sig_transmitIT = '1') then
        
            sig_transmitOrder <= '0'; 
        
        end if;
        
        sig_transmitITPrev <= sig_transmitIT;
        
        
----        -- parse                        
--        if(sig_receiveITPrev = '0' and sig_receiveIT = '1') then
        
--            if(to_integer(unsigned(sig_receivePackage.StdId)) = 513) then
            
--                if(to_integer(unsigned(sig_receivePackage.Data(1))) = 1) then
                
--                    led(0) <= '1';
                
--                elsif(to_integer(unsigned(sig_receivePackage.Data(1))) = 0) then
                
--                    led(0) <= '0';
                
--                end if;
            
--            elsif(to_integer(unsigned(sig_receivePackage.StdId)) = 514) then
            
--               if(to_integer(unsigned(sig_receivePackage.Data(2))) = 1) then
                
--                    led(1) <= '1';
                
--                elsif(to_integer(unsigned(sig_receivePackage.Data(2))) = 0) then
                
--                    led(1) <= '0';
                
--                end if;
            
--            elsif(to_integer(unsigned(sig_receivePackage.StdId)) = 515) then
            
--                if(to_integer(unsigned(sig_receivePackage.Data(3))) = 1) then
                
--                    led(2) <= '1';
                
--                elsif(to_integer(unsigned(sig_receivePackage.Data(3))) = 0) then
                
--                    led(2) <= '0';
                
--                end if;
            
--            elsif(to_integer(unsigned(sig_receivePackage.StdId)) = 516) then
            
--                if(to_integer(unsigned(sig_receivePackage.Data(4))) = 1) then
                
--                    led(3) <= '1';
                
--                elsif(to_integer(unsigned(sig_receivePackage.Data(4))) = 0) then
                
--                    led(3) <= '0';
                
--                end if;
            
--            end if;
        
--        end if;
        
--        sig_receiveITPrev := sig_receiveIT;
        
     end if;
 
end process;

end Behavioral;
