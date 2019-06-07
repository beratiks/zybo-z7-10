----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Berat YILDIZ
-- e-mail : yildizberat@gmail.com
-- 
-- Create Date: 06.06.2019 20:30:29
-- Design Name: 
-- Module Name: uartTransmitter - Behavioral
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

entity uartTransmitter is
    generic ( clock_counter_per_bit : integer := 125000000/9600
    );
    Port ( txPin : out STD_LOGIC;
           sys_clock : in STD_LOGIC;
           sendByte : in std_logic;
           txData : in std_logic_vector(7 downto 0);
           transmitting : out std_logic;
           transmitInterrupt : out std_logic
           );
end uartTransmitter;

architecture Behavioral of uartTransmitter is

type txEnumType is (Idle,StartBit,DataBits,StopBit,Clean);
signal txEnum : txEnumType := Idle;

signal clockCounter : integer range 0 to clock_counter_per_bit-1 := 0;
signal bitIterator : integer range 0 to 7:= 0;


begin

 txProc : process(sys_clock)
 begin
 
 if(rising_edge(sys_clock)) then
 
 case txEnum is
 
    when Idle =>
        txPin <= '1';
        if(sendByte = '1') then
            txEnum <= StartBit;
            transmitting <= '1';
        else
            txEnum <= Idle;
            transmitting <= '0';
        end if;
    
    when StartBit =>
    
        txPin <= '0';
        if(clockCounter < clock_counter_per_bit-1) then
            clockCounter <= clockCounter + 1;
            txEnum <= StartBit;
        else
            txEnum <= DataBits;
            clockCounter <= 0;
        end if;
    
    when DataBits =>
    
        txPin <= txData(bitIterator);
        
        if(clockCounter < clock_counter_per_bit-1) then
            clockCounter <= clockCounter + 1;
            txEnum <= DataBits;
        else
            clockCounter <= 0;
            
            if(bitIterator < 7) then
                 txEnum <= DataBits;
                 bitIterator <= bitIterator + 1;
            else
                bitIterator <= 0;
                txEnum <= StopBit;
            end if;
            
        end if;
    
    when StopBit =>
    
        if(clockCounter < clock_counter_per_bit -1) then
            clockCounter <= clockCounter + 1;
            txEnum <= StopBit;
        else
            clockCounter <= 0;
            txEnum <= Clean;
            transmitInterrupt <= '1';
        end if;
    
    
    when Clean =>
 
        txEnum <= Idle;
        transmitInterrupt <= '0';
    when others =>
    
        txEnum <= Idle;
 
 end case;
 
-- if(sw /= beforeSw) then

--sendByte <= '1';

--end if;

--beforeSw <= sw;
--txData(3 downto 0) <= sw;

 end if;
 
 end process;
 


end Behavioral;
