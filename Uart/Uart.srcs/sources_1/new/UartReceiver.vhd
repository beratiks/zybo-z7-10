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


begin

U0 : ClockDivider
port map (
       i_clk => sys_clock,
       o_clk => clockIn
);

ledproc : process(clockIn)
begin




end process;




end Behavioral;
