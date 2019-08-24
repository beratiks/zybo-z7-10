----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/24/2019 12:48:49 AM
-- Design Name: 
-- Module Name: Top_Module - Behavioral
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

entity Top_Module is
    Port (
            sysclk : in std_logic;
            sck_pin : out std_logic;
            cs_pin : out std_logic;
            mosi_pin : out std_logic;
            miso_pin : in std_logic;
            sw : in std_logic_vector(3 downto 0);
            led : out std_logic_vector(3 downto 0)
    );
end Top_Module;



architecture Behavioral of Top_Module is

component SPIMaster is
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
        writeData : in std_logic_vector(7 downto 0);
        writeEnable : in std_logic;
        writeIt : out std_logic;
        writing : out std_logic
  );
end component;

signal writeDataSig : std_logic_vector(7 downto 0);
signal writeEnableSig : std_logic;
signal writeItSig : std_logic;
signal writingSig : std_logic;

begin

spi_component : SPIMaster port map
(
        sysclk => sysclk,
        sck_pin => sck_pin,
        cs_pin  => cs_pin,
        mosi_pin => mosi_pin,
        miso_pin => miso_pin,
        writeData => writeDataSig,
        writeEnable => writeEnableSig,
        writeIt => writeItSig,
        writing => writingSig
);



proc : process(sysclk,sw)
variable beforeSwitches : std_logic_vector(3 downto 0);
variable counter : integer range 0 to 1250000  := 0;   
begin
    
    if(rising_edge(sysclk)) then
        if(counter < 1250000-1) then
            counter := counter + 1;
        else
            counter := 0;
            beforeSwitches := sw;
        end if;
        
        if(sw /= beforeSwitches) then
           writeEnableSig <= '1';
           led(0) <= '1';
        end if;
        
        if(writeItSig = '1') then
            writeEnableSig <= '0';
        end if;
        
     end if;
     

   WriteDataSig(3 downto 0) <= sw;
end process;

end Behavioral;
