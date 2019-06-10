----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Berat YILDIZ
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
-- using clock is 1 Mhz 

entity UartReceiver is
generic(    
    clocks_per_bit : integer := 1000000/9600      -- clocks_per_bit = clock / baudrate
);
    Port ( ReceivePin : in STD_LOGIC;
           i_clk : in std_logic;
           sys_clock : in std_logic;
           led : out std_logic_vector(3 downto 0);
           rxPin : in std_logic;
           receiving : out std_logic;
           receiveInterrupt : out std_logic;
           receivedData : out std_logic_vector(7 downto 0)
    );
end UartReceiver;

architecture Behavioral of UartReceiver is

component ClockDivider is
Port ( i_clk : in STD_LOGIC;
       o_clk : out STD_LOGIC := '0');

end component;

signal clockIn : std_logic := '0';
signal ledState : boolean := false;

signal clock_per_bit_counter : integer range 0 to clocks_per_bit-1 := 0;
signal bitIterator : integer range 0 to 7 := 0;

type receiveEnumeration is (Idle,StartBit,DataBits,StopBits,Clean);
signal receiveEnum : receiveEnumeration := Idle;

signal recData : std_logic_vector(7 downto 0) := (others => '0');

begin

U0 : ClockDivider
port map (
       i_clk => sys_clock,
       o_clk => clockIn
);

ledproc : process(clockIn)
begin
    if(rising_edge(clockIn)) then
        case receiveEnum is
        
            when Idle =>
            
            receiving <= '0';   -- not receiving data
           
            if(rxPin = '0') then
                receiveEnum <= StartBit;
                receiving <= '1';
            else
                 receiveEnum <= Idle;
                 receiving <= '0';
            end if;
            
            when StartBit =>
                if(clock_per_bit_counter = (clocks_per_bit-1)/2) then
                    if(rxPin = '0') then
                        clock_per_bit_counter <= 0;
                        receiveEnum <= DataBits;
                    else
                        clock_per_bit_counter <= 0;
                        receiveEnum <= Idle;
                    end if;
                else
                    clock_per_bit_counter <= clock_per_bit_counter + 1;
                    receiveEnum <= StartBit;
                end if;
            
            when DataBits =>
                if(clock_per_bit_counter = (clocks_per_bit - 1)) then
                    receivedData(bitIterator) <= rxPin;
                    clock_per_bit_counter <= 0;
                    if(bitIterator < 7) then
                        bitIterator <= bitIterator + 1;
                        receiveEnum <= DataBits;
                    else
                        receiveEnum <= StopBits;
                        bitIterator <= 0;
                    end if;
                else
                    clock_per_bit_counter <= clock_per_bit_counter + 1;
                    receiveEnum <= DataBits;
                end if;
            
            when StopBits =>
                if(clock_per_bit_counter = clocks_per_bit - 1) then
                  clock_per_bit_counter <= 0;
                  receiveEnum <= Clean;
                  receiveInterrupt <= '1';
                else
                    clock_per_bit_counter <= clock_per_bit_counter + 1;
                    receiveEnum <= StopBits;
                end if;
            when Clean =>
                receiveInterrupt <= '0';
                receiveEnum <= Idle;
            when others =>
                receiveEnum <= Idle;
        end case;
     end if;
     
     
     
     if(recData = "00000001") then
        led <= "0001";
     elsif(recData = "00000010") then
        led <= "0010";
     elsif(recData = "00000011") then
        led <= "0100";
     elsif(recData = "00000100") then
        led <= "1000";
     else
        led <= "0000";
     end if;
end process;

end Behavioral;
