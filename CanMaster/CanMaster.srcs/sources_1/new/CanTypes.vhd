----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2019 10:09:38 PM
-- Design Name: 
-- Module Name: CanTypes - Behavioral
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

package CanTypes is

  constant  CLOCK_WIZARD_FREQUENCY  : integer   :=  24e6;
  constant  BAUDRATE_PRESCALER      : integer   :=  3;
  constant  TIME_SEGMENT_1          : integer   :=  13;
  constant  TIME_SEGMENT_2          : integer   :=  2;
  constant  TIME_SYNC_SEGMENT       : integer   :=  1;
  

type Data is array (7 downto 0) of std_logic_vector(7 downto 0);

type CanPackage is record

    StdId   :   std_logic_vector(11 downto 0);
    Rtr     :   std_logic;
    Dlc     :   std_logic_vector(3 downto 0);
    Data    :   Data; 
end record CanPackage;





end package CanTypes;
