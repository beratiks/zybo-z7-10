----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Berat YILDIZ
-- e-mail : yildizberat@gmail.com
-- 
-- Create Date: 05/29/2019 05:25:23 PM
-- Design Name: 
-- Module Name: UartReceiver - Behavioral
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

-- I select uart baudrate is 9600
-- using clock is 125 Mhz 

entity UartReceiver is
generic(    
    clock_counter_per_bit : integer := 125000000/9600  -- clocks_per_bit = clock / baudrate
);
    Port (
           sys_clock : in std_logic;					-- osc clock 125 mhz
           led : out std_logic_vector(3 downto 0);		-- led for output
           rxPin : in std_logic;						-- phy rx pin
           receiving : out std_logic;					-- receiving signal is high during receiving
           receiveInterrupt : out std_logic;			-- end of receive interrupt at rising edge
           rxData   : out std_logic_vector(7 downto 0)	-- received Data buffer
    );
end UartReceiver;

architecture Behavioral of UartReceiver is

 type rxEnumType is (Idle, StartBit, DataBits,
                     StopBit, Clean);
  signal rxEnum : rxEnumType := Idle;
 
  signal clockCounter : integer range 0 to clock_counter_per_bit-1 := 0;
  signal bitIterator : integer range 0 to 7 := 0;  -- 8 Bits Total

begin

-- receive process 
-- storage receive bits depends on uart bus speed.
receiveproc : process(sys_clock)
begin
if(rising_edge(sys_clock)) then
      case rxEnum is
 
        when Idle =>
        
          clockCounter <= 0;
          bitIterator <= 0;
 
          if rxPin = '0' then       
            rxEnum <= StartBit;
            receiving <= '1';
          else
            rxEnum <= Idle;
            receiving <= '0';
          end if;
 
          
        when StartBit =>

          if clockCounter = (clock_counter_per_bit-1)/2 then
            if rxPin = '0' then
              clockCounter <= 0;  -- reset counter since we found the middle
              rxEnum   <= DataBits;
            else
              rxEnum   <= Idle;
            end if;
          else
            clockCounter <= clockCounter + 1;
            rxEnum   <= StartBit;
          end if;
 
           
        when DataBits =>

          if clockCounter < clock_counter_per_bit-1 then
            clockCounter <= clockCounter + 1;
            rxEnum   <= DataBits;
          else
            clockCounter            <= 0;
            rxData(bitIterator) <= rxPin;
             
            
            if bitIterator < 7 then
              bitIterator <= bitIterator + 1;
              rxEnum   <= DataBits;
            else
              bitIterator <= 0;
              rxEnum   <= StopBit;
            end if;
          end if;
 
        when StopBit =>
         
          if clockCounter < clock_counter_per_bit-1 then
            clockCounter <= clockCounter + 1;
            rxEnum   <= StopBit;
          else
            clockCounter <= 0;
            rxEnum   <= Clean;
            receiveInterrupt <= '1';
          end if;
            

        when Clean =>
          rxEnum <= Idle;
          receiveInterrupt <= '0';
         
             
        when others =>
          rxEnum <= Idle;
 
      end case; 
        
end if;

end process;



end Behavioral;
