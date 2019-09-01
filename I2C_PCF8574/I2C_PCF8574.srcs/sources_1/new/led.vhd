----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Berat YILDIZ
-- e-mail : yildizberat@gmail.com
-- Create Date: 06/13/2019 10:37:19 PM
-- Design Name: 
-- Module Name: I2CTopModule - Behavioral
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

entity I2CTopModule is
  Port (
        sys_clock : in std_logic;						-- system clock as 125 mhz
        led       : out std_logic_vector(3 downto 0);	-- leds		 for output
        sw        : in std_logic_vector(3 downto 0);	--- switches for input to send i2c
        sclPin    : out std_logic;						-- scl phy pin
        sdaPin    : inout std_logic						-- sda phy pin
   );
end I2CTopModule;

architecture Behavioral of I2CTopModule is

component I2CMaster is
    Port ( 
        sys_clock : in STD_LOGIC;
        sda_pin   : inout std_logic;
        scl_pin   : out std_logic;
        writeEnable : in std_logic;
        deviceId    : in std_logic_vector(6 downto 0);
        commandType : in std_logic;
        writeData   : in std_logic_vector(7 downto 0);
        writing     : out std_logic;
        wroteIt     : out std_logic;
        leds         : out std_logic_vector(3 downto 0)
    );
end component;

signal writeEnableSig : std_logic;
signal deviceIdSig : std_logic_vector(6 downto 0) := "0100000";
signal commandTypeSig : std_logic;
signal WriteDataSig : std_logic_vector(7 downto 0);
signal writingSig : std_logic;
signal wroteItSig : std_logic; 

begin

I2C_Component : I2CMaster port map
(
        sys_clock => sys_clock,
        sda_pin   => sdaPin,
        scl_pin   => sclPin,
        writeEnable => writeEnableSig,
        deviceId    => deviceIdSig,
        commandType => commandTypeSig,
        writeData  => WriteDataSig,
        writing     => writingSig,
        wroteIt     => wroteItSig,
        leds        => led
);

-- when change switches state send data to i2c 
proc : process(sw)
variable beforeSwitches : std_logic_vector(3 downto 0);
variable counter : integer range 0 to 1250000  := 0;   
begin

    if(rising_edge(sys_clock)) then
        if(counter < 1250000-1) then
            counter := counter + 1;
        else
            counter := 0;
            beforeSwitches := sw;
        end if;
        
        if(sw /= beforeSwitches and writingSig = '0') then
            writeEnableSig <= '1';
            led(0) <= '1';
            led(1) <= '0';
        end if;
        
        if(wroteItSig = '1') then
            writeEnableSig <= '0';
             led(1) <= '1';
             led(0) <= '0';
        end if;
     end if;

    
   WriteDataSig(3 downto 0) <= sw;
end process;
    
end Behavioral;
