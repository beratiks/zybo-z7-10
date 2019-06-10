----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/10/2019 11:09:35 PM
-- Design Name: 
-- Module Name: I2CMaster - Behavioral
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

entity I2CMaster is
generic (
    system_clock_speed : integer := 125000000;  -- system clock is 125 MHZ
    i2c_bus_speed : integer := 100000           -- i2c run normal mode as 100 kHz
);
    Port ( sys_clock : in STD_LOGIC);
end I2CMaster;

architecture Behavioral of I2CMaster is

constant divider : integer := (system_clock_speed/i2c_bus_speed) / 4;

type stateMachine is(Idle,Start,Command,SlaveAck1,Write,SlaveAck2,MasterAck,Stop);
signal state : stateMachine := Idle;

signal data_clock : std_logic;
signal data_clock_prev : std_logic;

signal scl_clk : std_logic;
 

begin


end Behavioral;
