----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Berat YILDIZ
-- e-mail : yildizberat@gmail.com
-- 
-- Create Date: 07.06.2019 16:31:34
-- Design Name: 
-- Module Name: UartTop - Behavioral
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

entity UartTop is
    Port ( sys_clock : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (3 downto 0);
           txPin : out STD_LOGIC;
           rxPin : in std_logic
           );
end UartTop;



architecture Behavioral of UartTop is

component UartReceiver is
generic(    
    clock_counter_per_bit : integer := 125000000/9600  -- clocks_per_bit = clock / baudrate
);
    Port (
           sys_clock : in std_logic;
           led : out std_logic_vector(3 downto 0);
           rxPin : in std_logic;
           receiving : out std_logic;
           receiveInterrupt : out std_logic;
           rxData   : out std_logic_vector(7 downto 0)
    );


end component;

component uartTransmitter is
     generic ( clock_counter_per_bit : integer := 125000000/9600
    );
    Port ( txPin : out STD_LOGIC;
           sys_clock : in STD_LOGIC;
           sendByte : in std_logic;
           txData : in std_logic_vector(7 downto 0);
           transmitting : out std_logic;
           transmitInterrupt : out std_logic
           );
           
 end component;

 signal sig_sendByte : STD_LOGIC := '0';
 signal sig_rxData : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
 signal sig_txData :  STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
 signal sig_receiveIT : STD_LOGIC := '0';
 signal sig_transmitIT : STD_LOGIC := '0';
 signal sig_receiving : STD_LOGIC := '0';
 signal sig_transmitting : STD_LOGIC := '0';
 signal beforeSw : std_logic_vector(3 downto 0);

 
begin

tx : uartTransmitter port map
(
           txPin => txPin,
           sys_clock => sys_clock,
           sendByte => sig_sendByte,
           txData => sig_txData,
           transmitting => sig_transmitting,
           transmitInterrupt => sig_transmitIT

);

rx : uartReceiver port map
(
           sys_clock => sys_clock,
           led => led,
           rxPin => rxPin,
           receiving => sig_receiving,
           receiveInterrupt => sig_receiveIT,
           rxData   => sig_rxData
);

receiveProcess : process(sig_receiveIT)
begin
    
    if(rising_edge(sig_receiveIT)) then
        led <= sig_rxData(3 downto 0);
    end if;


end process;

transmitProcess : process(sys_clock)
begin
    if(rising_edge(sys_clock)) then
       if((sw /= beforeSw)and (sig_receiving /= '1') ) then
    
         sig_sendByte <= '1';
    
        end if;
        beforeSw <= sw;
        
        if(sig_transmitIT = '1') then
            sig_sendByte <= '0';
        end if;
        
    end if;
        sig_txData(3 downto 0) <= sw;

end process;

end Behavioral;
