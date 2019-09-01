----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Berat YILDIZ
-- e-mail : yildizberat@gmail.com
-- Create Date: 06/21/2019 12:02:57 AM
-- Design Name: 
-- Module Name: SPIMaster - Behavioral
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

entity SPIMaster is
  generic(
    SYS_CLOCK : integer := 125000000;
    BUS_SPEED : integer := 10000000;
    Bits    : integer := 8  
  );
  Port ( 
        sysclk : in std_logic;					
        sck_pin : out std_logic;
        cs_pin : out std_logic;
        mosi_pin : out std_logic;
        miso_pin : in std_logic;
        writeData : in std_logic_vector(7 downto 0);		-- data to send spi
        writeEnable : in std_logic;							-- write order
        writeIt : out std_logic;							-- end of transmit interrupt at rising edge	
        writing : out std_logic								-- set high during transmitting			
  );
end SPIMaster;

architecture Behavioral of SPIMaster is


signal o_clk : std_logic := '1';
signal o_clk_prev : std_logic := '1';

signal data_clk : std_logic := '1';
signal data_clk_prev : std_logic := '1';

constant clk_divider : integer := (SYS_CLOCK/BUS_SPEED)/4;    -- for set data and sck
signal clockin : std_logic := '0';

--------------------------------------

signal CS : std_logic := '1';
signal MOSI : std_logic;
signal MISO : std_logic;
signal SCK : std_logic := '1';

type SpiEnumeration is (Idle,Start,Write,Finish);
signal SpiEnum : SpiEnumeration := Idle;

signal writeDataSig : std_logic_vector(7 downto 0);
signal writeEnableSig : std_logic := '0';
signal WriteItSig : std_logic := '1';
signal writingSig : std_logic;

begin

sck_pin <= SCK;
cs_pin <= CS;
mosi_pin <= MOSI;
MISO <= miso_pin;
writeDataSig <= writeData;
writeEnableSig <= writeEnable;
writeIt <= writeItSig;

sck_clk_proc : process(sysclk)

-- find clock and where data bit must be set

variable clk_counter  : integer range 0 to clk_divider*4 := 0;

begin

    if(rising_edge(sysclk)) then
    
        if(clk_counter = clk_divider*4-1) then
            clk_counter := 0;
            o_clk <=not o_clk;
        else
            clk_counter := clk_counter + 1;
        end if;
        
        case clk_counter is
        
            when 0 to clk_divider-1 =>
            
                o_clk <= '0';
                data_clk <= '0';
            
            when clk_divider to clk_divider*2-1 =>
                
                o_clk <= '0';
                data_clk <= '1';
                            
            when clk_divider*2 to clk_divider*3-1 =>
                
                o_clk <= '1';
                data_clk <= '1';
                
            when others =>
                o_clk <= '1';
                data_clk <= '0';
        end case;
        
            o_clk_prev <= o_clk;
            data_clk_prev <= data_clk;
        
    
    end if;

end process;

-- spi process with state machine
-- send just 1 byte to receiver
spiProc : process(sysclk)
variable bitIterator : integer range 0 to 7 := 7;
begin

    if(rising_edge(sysclk)) then
    
        case spiEnum is
        
            when Idle =>
            
            CS <= '1';
            WriteItSig <= '0';
            writingSig <= '0';
            
            if(writeEnableSig = '1') then
            
                spiEnum <= Start;
                CS <= '0';
                writingSig <= '1';
            
            end if;
            
            when Start =>
                
                if(data_clk_prev = '0' and data_clk = '1') then

                    spiEnum <= Write;
                    MOSI <= writeDataSig(bitIterator);
                    
                end if;
            
            when Write =>
            
                if(data_clk_prev <= '0' and data_clk = '1') then
                
                    if(bitIterator = 0) then                 
                        
                            bitIterator := 7;
                            spiEnum <= Finish;                     
                        
                    else
                    
                        bitIterator := bitIterator - 1;
                        MOSI <= writeDataSig(bitIterator);
                        
                    end if;
                
                end if;
                         
            when Finish =>
            
                WriteItSig <= '1';
            
                if(o_clk_prev = '0' and o_clk = '1') then
                
                    spiEnum <= Idle;
                    CS <= '1';
                   
                
                end if;
                   
            when others =>
            
            spiEnum <= Idle;
            
            
          end case;
    end if;
                       

end process;

    SCK <=  o_clk when spiEnum = Write else
            '0';

end Behavioral;
