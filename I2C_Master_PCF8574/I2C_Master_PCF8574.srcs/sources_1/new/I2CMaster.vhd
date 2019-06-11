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

type stateMachine is(Idle,Start,SendDeviceId,Command,SlaveAck1,Write,SlaveAck2,MasterAck,Stop,notAck);
signal state : stateMachine := Idle;

signal data_clock : std_logic;
signal data_clock_prev : std_logic;

signal scl_clock : std_logic;
signal scl_clock_prev : std_logic;
 
signal scl : std_logic := '1';
signal sda : std_logic := '1';

signal deviceId : std_logic_vector(6 downto 0) := "1101010";

signal commandType : std_logic := '0';

signal txData : std_logic_vector(7 downto 0) := "01010101";

signal Send : std_logic := '1';

signal firstSend : std_logic := '0';

begin

clockProcess : process(sys_clock)

variable counter : integer range 0 to divider*4 := 0;

begin
    
    if(rising_edge(sys_clock)) then
        
        if(counter = divider*4-1) then
            counter := 0;
        else
            counter := counter + 1;
        end if;
    
        case counter is
        
            when 0 to divider-1 =>
            
                scl_clock <= '0';
                data_clock <= '0';
            
            when divider to divider*2-1 =>
            
                scl_clock <= '0';
                data_clock <= '1';
            
            when divider*2 to divider*3-1 =>
            
                scl_clock <= '1';
                data_clock <= '1';
            
            when others =>
                
                scl_clock <= '1';
                data_clock <= '0';            
        
        end case;
        
        scl_clock_prev <= scl_clock;
        data_clock_prev <= data_clock;
        
    end if;    

end process;

comProcess : process(sys_clock)
variable txDataIterator : integer range 0 to 7 := 7;
variable deviceIdIterator : integer range 0 to 6 := 6;
begin

    if(rising_edge(sys_clock)) then
        case state is
            when Idle =>
                sda <= '1';
                scl <= '1';
                if(Send = '1') then
                    if(data_clock_prev = '0' and data_clock = '1') then
                        sda <= '0';
                        state <= Start;
                    end if;
                end if;
            when Start =>
                sda <= '0';
                if(scl_clock = '1' and scl_clock_prev = '0') then
                    scl <= '0';
                elsif(scl_clock = '0' and scl_clock_prev = '1') then
                    sda <= deviceId(deviceIdIterator); 
                    state <= SendDeviceId;
                    firstSend <= '1';
                end if;
            when SendDeviceId =>
                if(data_clock_prev = '0' and data_clock = '1') then          
                    if(firstSend = '1') then
                        firstSend <= '0';
                    elsif(deviceIdIterator > 0) then
                        if(deviceIdIterator /= 0) then
                            deviceIdIterator := deviceIdIterator -1;   
                        end if;    
                        sda <= deviceId(deviceIdIterator);   
                    else
                        sda <= commandType;
                        state <= command;       
                        deviceIdIterator := 6;
                    end if;
                end if;
                scl <= scl_clock;
            when command =>
                if(data_clock_prev = '0' and data_clock = '1') then
                     sda <= 'Z';
                     state <= SlaveAck1; 
                end if;
                scl <= scl_clock;
            when SlaveAck1 =>
                if(data_clock_prev = '1' and data_clock = '0') then
                    if(sda = '0') then
                        state <= Write;
                        sda <= txData(txDataIterator);
                    else
                       state <= notAck;
                    end if;
                end if;
                scl <= scl_clock;
            when Write =>
                 if(data_clock_prev = '0' and data_clock = '1') then
                    if(firstSend = '1') then
                        firstSend <= '0';
                    elsif(txDataIterator > 0) then
                        if(txDataIterator /= 0) then
                            txDataIterator := txDataIterator-1;
                        end if;
                        sda <= txData(txDataIterator);
                    else
                        
                        txDataIterator := 7;
                        sda <= 'Z';
                        state <= SlaveAck2; 
                    end if;
                 end if;
                scl <= scl_clock;
            when SlaveAck2 =>
                scl <= scl_clock;
                if(data_clock_prev = '1' and data_clock = '0') then
                    if(sda = '0') then
                        state <= Stop;
                        sda <= '0';
                        scl <= '0';
                    else
                        state <= notAck;
                    end if;
                end if;
                
            when Stop =>
                if(scl_clock_prev = '1' and scl_clock = '0') then
                     scl <= '0';
                     sda <= '0';
                elsif(scl_clock_prev = '0' and scl_clock = '1') then
                    scl <= '1';
                    sda <= '0';
                elsif(data_clock_prev = '1' and data_clock = '0') then
                    scl <= '1';
                    sda <= '1';
                    state <= Idle;
                end if;
            when others =>
                state <= Idle;
        end case;


    end if;
end process;


end Behavioral;
