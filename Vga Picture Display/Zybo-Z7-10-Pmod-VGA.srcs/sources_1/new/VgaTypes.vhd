library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


package VgaTypes is   

  constant WIDTH  : integer  := 128;
  constant HEIGHT : integer  := 128;

  type frame is array (0 to WIDTH*HEIGHT - 1) of std_logic_vector(11 downto 0);

end VgaTypes;

package body VgaTypes is


end VgaTypes;