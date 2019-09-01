----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Berat YILDIZ
-- e-mail  : yildizberat@gmaiil.com
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
    Port ( 
        sys_clock : in STD_LOGIC;			-- system clock
        sda_pin   : inout std_logic;		-- sda pin
        scl_pin   : out std_logic;			-- scl pin
        writeEnable : in std_logic;			-- write data order
        deviceId    : in std_logic_vector(6 downto 0);	-- device id to communicate
        commandType : in std_logic;						-- command type but now not using this project
        writeData   : in std_logic_vector(7 downto 0);	-- data array to write	
        writing     : out std_logic;					-- when writing this signal high
        wroteIt     : out std_logic;					-- wrote interrupt falling edger
        leds         : out std_logic_vector(3 downto 0)	-- leds for demo
    );
end I2CMaster;

architecture Behavioral of I2CMaster is

constant divider : integer := (system_clock_speed/i2c_bus_speed) / 4;	-- set divide from i2c bus speed

type stateMachine is(Idle,Start,SendDeviceId,Command,SlaveAck1,Write,SlaveAck2,MasterAck,Stop,notAck);		-- state machines to run communicate
signal state : stateMachine := Idle;																		-- start state is idle		

signal data_clock : std_logic;																				-- data clock for detect when data pin must set
signal data_clock_prev : std_logic;
	
signal scl_clock : std_logic;																				-- scl clock for detect when scl pin must set	
signal scl_clock_prev : std_logic;
 
signal scl : std_logic := '1';																				-- current using scl signal
signal sda : std_logic := '1';																				-- current using sda signal				
	
signal deviceIdSig : std_logic_vector(6 downto 0) := "0100000";												-- device id signal

signal commandTypeSig : std_logic := '0';																	-- command type but not using this project

signal txData : std_logic_vector(7 downto 0) := "10101011";													-- transmit data to send i2c bus	

signal writeEnableSig : std_logic := '1';																	-- write enable for start com.

signal firstSend : std_logic := '0';																		-- for run algorithm

signal writingSig : std_logic := '0';																		-- when transmit process run writingSig is high
signal wroteItSig : std_logic := '0';																		-- end of transmit interrupt at rising edge

signal ledSignal : std_logic_vector(3 downto 0);															-- set led for demo

begin

sda_pin <= sda;
scl_pin <= scl;
writeEnableSig <= writeEnable;
deviceIdSig <= deviceId;
commandTypeSig <= commandType;
txData <= writeData;
writing <= writingSig;
wroteIt <= wroteItSig;
leds <= ledSignal;


-- process to find when scl and data must be set depends on i2c clock
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

-- com process to send every bit true time bit.
-- data clock's rising edge new data must be set to send. And this time must be before scl_clock rising edge
-- scl clock is say data sent.
-- ack state data pin must be set 'Z' and read '0'
comProcess : process(sys_clock)
variable txDataIterator : integer range 0 to 7 := 7;
variable deviceIdIterator : integer range 0 to 6 := 6;
begin

    if(rising_edge(sys_clock)) then
        case state is
            when Idle =>
                if(wroteItSig = '1') then
                    wroteItSig <= '0';
                    writingSig <= '0';
                end if;
                sda <= '1';
                scl <= '1';
               
                if(writeEnableSig = '1') then
                    if(data_clock_prev = '0' and data_clock = '1') then
                        sda <= '0';
                        state <= Start;
                        writingSig <= '1';
                    end if;
                end if;
            when Start =>
                sda <= '0';
                if(scl_clock = '1' and scl_clock_prev = '0') then
                    scl <= '0';
                elsif(scl_clock = '0' and scl_clock_prev = '1') then
                    sda <= deviceIdSig(deviceIdIterator); 
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
                        sda <= deviceIdSig(deviceIdIterator);   
                    else
                        sda <= commandTypeSig;
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
                if(scl_clock = '0' and scl_clock_prev = '1') then
                    if(sda = '0') then
                        state <= Write;
                        sda <= '0';
                        firstSend <= '1';
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
                if(scl_clock = '0' and scl_clock_prev = '1') then
                    if(sda = '0') then
                        state <= Stop;
                        sda <= '0';
                        scl <= '0';
                    else
                        state <= notAck;
                    end if;
                end if;
                scl <= scl_clock;
            when Stop =>
                if(scl_clock_prev = '1' and scl_clock = '0') then
                     scl <= '0';
                     sda <= '0';
                elsif(scl_clock_prev = '0' and scl_clock = '1') then
                    scl <= '1';
                    sda <= '1';
                    state <= Idle;
                    wroteItSig <= '1';
                elsif(data_clock_prev = '0' and data_clock = '1') then
                    scl <= '1';
                    sda <= '0';
                end if;
                
            when notAck =>
            
            when others =>
                state <= Idle;
            
                
        end case;


    end if;
end process;


end Behavioral;
