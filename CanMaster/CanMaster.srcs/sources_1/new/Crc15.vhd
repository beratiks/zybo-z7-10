library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.CanTypes.ALL;

package Crc15 is
    
    function Crc(i_crc_vector : in std_logic_vector(SIZE_OF_MAX_CRC_FIELD - 1 downto 0); i_crc_size : in integer) return std_logic_vector; 
   
end package Crc15;



package body Crc15 is

    function Crc(i_crc_vector : in std_logic_vector(SIZE_OF_MAX_CRC_FIELD - 1 downto 0); i_crc_size : in integer) return std_logic_vector is
    variable doInvert : std_logic := '0';
    variable crc : std_logic_vector(SIZE_OF_CRC - 1 downto 0);
    begin
        
        for i in 0 to i_crc_size loop
        
            doInvert := i_crc_vector(i) xor crc(14);
            
            crc(14) := crc(13) xor doInvert;
            crc(13) := crc(12);
            crc(12) := crc(11);
            crc(11) := crc(10);
            crc(10) := crc(9) xor doInvert;
            crc(9)  := crc(8);
            crc(8)  := crc(7) xor doInvert;
            crc(7)  := crc(6) xor doInvert;
            crc(6)  := crc(5);
            crc(5)  := crc(4);
            crc(4)  := crc(3) xor doInvert;
            crc(3)  := crc(2) xor doInvert;
            crc(2)  := crc(1);
            crc(1)  := crc(0);
            crc(0)  := doInvert;
             
       end loop;
        
    return crc;
    end function;

end package body Crc15;     