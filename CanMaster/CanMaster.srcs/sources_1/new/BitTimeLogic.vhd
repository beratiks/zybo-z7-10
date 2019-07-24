----------------------------------------------------------------------------------
-- Engineer: Berat YILDIZ
-- e-mail : yildizberat@gmail.com
-- Create Date: 07/22/2019 09:45:13 PM
-- Design Name: 
-- Module Name: BitTimeLogic - Behavioral
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
library work;
use work.canTypes.ALL;

entity BitTimeLogic is
    Port ( TxPin : out STD_LOGIC;               -- physical Tx pin to connect Can phy
           RxPin : in STD_LOGIC;                -- physical Rx pin to connect Can phy
           TxBit : in STD_LOGIC;                -- sending Bit to send
           RxBit : out STD_LOGIC;               -- received Bit to receive
           clk_in : in STD_LOGIC;               -- can clock
           write_order : in STD_LOGIC;          -- order of write.
           write_valid : out STD_LOGIC;         -- write is complete.  Accept falling edge
           read_valid : out STD_LOGIC;          -- read is complete.   Accept rising edge
           check_arbitration : in std_logic     -- bit stream processor set, because arbitration must check only message identifier phase
           ); 
           
end BitTimeLogic;

architecture Behavioral of BitTimeLogic is

signal sig_time_segment_1 : integer := TIME_SEGMENT_1;
signal sig_time_segment_2 : integer := TIME_SEGMENT_2;

-- signal of ports
signal sig_TxPin        : STD_LOGIC := '0';     
signal sig_RxPin        : STD_LOGIC;       
signal sig_TxBit        : STD_LOGIC;        
signal sig_RxBit        : STD_LOGIC := '0';              
signal sig_write_order  : STD_LOGIC := '0';  
signal sig_write_valid  : STD_LOGIC := '0'; 
signal sig_read_valid   : STD_LOGIC := '0';  

signal sig_startSample  : STD_LOGIC := '0';  

signal oneBitQuantaTime : integer := TIME_SEGMENT_1 + TIME_SEGMENT_2 + TIME_SYNC_SEGMENT;  -- one bit time
signal timeQuantaCounter : integer := 0;                                                    -- time quanta counter to detect bit states

type BitStateType is (IDLE,SYNC_SEGMENT,PHASE_SEGMENT_1,PHASE_SEGMENT_2);                   -- bit state enum type definition
signal BitState : BitStateType := IDLE;                                                     --  bit state enum

signal sig_bitArbitrationLose : std_logic := '0';

begin
-- conneect ports to signals to R-W
TxPin <= sig_TxPin;
sig_rxPin <= RxPin;
sig_TxBit <= TxBit;
RxBit <= sig_RxBit;       
sig_write_order <= write_order;  
write_valid <= sig_write_valid;
read_valid <= sig_read_valid;


-- calculate time quanta on every bit time
timeQuantaProcess : process(clk_in,sig_write_valid)
begin
 
    if(rising_edge(clk_in)) then
        if(BitState /= IDLE) then
            if(timeQuantaCounter >= oneBitQuantaTime -1) then
            
                timeQuantaCounter <= 0;
               
            else
            
                timeQuantaCounter <= timeQuantaCounter + 1;
            
            end if;
        else
        
        timeQuantaCounter <= 0;
        
        end if;
    end if;

end process;

-- set BitState state depends on time quanta
bitStateProcess : process(clk_in,timeQuantaCounter)
begin
    
     if((sig_startSample = '0' and sig_write_order = '0') and timeQuantaCounter = 0 ) then -- if sample is cancel wait for end of segment_2
        bitState <= IDLE;   
      elsif(bitState /= IDLE) then
            
        if(timeQuantaCounter >= 0 and timeQuantaCounter < TIME_SYNC_SEGMENT) then
        
            bitState <= SYNC_SEGMENT;
        
        elsif(timeQuantaCounter >= TIME_SYNC_SEGMENT and timeQuantaCounter < TIME_SYNC_SEGMENT+ sig_time_segment_1) then
        
            bitState <= PHASE_SEGMENT_1;
        
        elsif(timeQuantaCounter >= TIME_SYNC_SEGMENT + sig_time_segment_1 and timeQuantaCounter < oneBitQuantaTime) then
        
            bitState <= PHASE_SEGMENT_2;
        
        else
        
        bitState <= IDLE;
        
        end if;
        

     elsif((sig_startSample = '1' or sig_write_order = '1') and bitState = IDLE) then
        
         bitState <= SYNC_SEGMENT;    
         
      end if;

end process;

-- listen Rx process
receiveProcess : process(bitState,clk_in)
begin
    if(rising_edge(clk_in)) then
    
        case(bitState) is
        
            when IDLE =>    
            
                   if(sig_rxPin = '0') then             -- hard synchronisation
                   
                    sig_startSample <= '1';
                   
                   end if;
            
                
            when SYNC_SEGMENT =>
                             
                
            when PHASE_SEGMENT_1 =>
            
                if(falling_edge(sig_rxPin)) then        -- check if change rx recessive to dominant for re-synchronisaton. this is interpreted as a late edge
                
                    sig_time_segment_1 <= sig_time_segment_1 + (timeQuantaCounter - TIME_SYNC_SEGMENT);
                    oneBitQuantaTime <= TIME_SYNC_SEGMENT + sig_time_segment_1 + sig_time_segment_2;
                
                end if;
                
                if(timeQuantaCounter = (TIME_SYNC_SEGMENT + sig_time_segment_1 -1)) then   -- sample point where end of the time_segment_1
                    
                    sig_rxBit <= sig_rxPin;
                    sig_read_valid <= '1';
                
                end if;
            
            when PHASE_SEGMENT_2 => 
            
                if(falling_edge(sig_rxPin)) then        -- check if change rx recessive to dominant for re-synchronisaton. this is interpreted as an early bit
                
                    sig_time_segment_2 <= sig_time_segment_2 - (timeQuantaCounter - (TIME_SYNC_SEGMENT + time_segment_1));
                    oneBitQuantaTime <= TIME_SYNC_SEGMENT + sig_time_segment_1 + sig_time_segment_2;
                
                end if;
            
                sig_read_valid <= '0';          -- send info to Bit Stream Processor
            
            when others =>
           
        
        end case;
  end if;

end process;

-- transmit process
transmitBitProcess : process(clk_in)
begin

        if(rising_edge(clk_in)) then
    
        case(bitState) is
        
            when IDLE =>       
            
            sig_txPin <= '1';
                
            when SYNC_SEGMENT =>
            
                sig_write_valid <= '0';
                if(sig_txBit = '1' and falling_edge(sig_rxPin) and check_arbitration = '1') then        -- arbitration lose when rx change recessive to dominant
                    
                    sig_bitArbitrationLose <= '1';
                    sig_txPin <= '0';
                    
                else
                
                sig_txPin <= sig_txBit;  
                   
                end if;      
                
                
                
            when PHASE_SEGMENT_1 =>
            
                                
                if(timeQuantaCounter = (TIME_SYNC_SEGMENT + time_segment_1 - 1)) then
                    
                    sig_write_valid <= '1';
                
                end if;
            
            
            when PHASE_SEGMENT_2 => 
            
                sig_bitArbitrationLose <= '0';
                if(timeQuantaCounter = oneBitQuantaTime -1) then
                
                    sig_write_valid <= '0';
                
                end if;

            when others =>
           
        
        end case;
  end if;


end process;

end Behavioral;
