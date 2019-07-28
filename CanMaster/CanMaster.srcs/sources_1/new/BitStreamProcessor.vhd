    ----------------------------------------------------------------------------------
    -- Company: 
    -- Engineer: 
    -- 
    -- Create Date: 07/25/2019 01:59:40 AM
    -- Design Name: 
    -- Module Name: BitStreamProcessor - Behavioral
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
    use ieee.numeric_std.ALL;
    library work;
    use work.CanTypes.ALL;
    use work.Crc15.ALL;
    entity BitStreamProcessor is
        Port ( Tx_Pin : out STD_LOGIC;
               Rx_Pin : in STD_LOGIC;
               clk_in : in STD_LOGIC);
    end BitStreamProcessor;
    
    architecture Behavioral of BitStreamProcessor is
    
    component BitTimeLogic is
        Port ( TxPin : out STD_LOGIC;               -- physical Tx pin to connect Can phy
               RxPin : in STD_LOGIC;                -- physical Rx pin to connect Can phy
               TxBit : in STD_LOGIC;                -- sending Bit to send
               RxBit : out STD_LOGIC;               -- received Bit to receive
               clk_in : in STD_LOGIC;               -- can clock
               write_order : in STD_LOGIC;          -- order of write.
               write_valid : out STD_LOGIC;         -- write is complete.  Accept falling edge
               read_valid : out STD_LOGIC;          -- read is complete.   Accept rising edge
               check_arbitration : in std_logic;    -- bit stream processor set, because arbitration must check only message identifier phase
               sample_start      :  in std_logic 
               ); 
      end component;
      
      -- component signals
      signal    sig_RxBit               :   std_logic;
      signal    sig_TxBit               :   std_logic   := '0';
      signal    sig_write_order         :   std_logic   := '0';
      signal    sig_write_valid         :   std_logic;
      signal    sig_read_valid          :   std_logic;
      signal    sig_check_arbitration   :   std_logic   :=  '0';    
      -- end component signals
      
      signal sig_receiving : std_logic      := '0';
      signal sig_transmitting : std_logic   := '0';
     
     
      type FrameEnumType is (IDLE,SOF,ID,RTR,IDE,DLC,RESERVE,DATA,CRC,CRC_DELIMITER,ACK,EOF);  -- enum types for parse and transmit frame
      signal receiveFrameEnum : FrameEnumType  := Idle;
      signal transmitFrameEnum : FrameEnumType := Idle;
      
      signal sig_start_sample : std_logic := '0';   -- check rx pin falling edge and set start sample to BTL
      
      signal receiveFrame : CanFrame;
      signal receivePackageCounter : integer := 0;
      signal receiveDataByteCounter : integer := 0;
      signal receveDataByteSize     : integer := 0;
      
      signal crcVectorToCalculate : std_logic_vector(SIZE_OF_MAX_CRC_FIELD - 1 downto 0);
      signal receivedCrc          : std_logic_vector(SIZE_OF_CRC - 1 downto 0);
      signal calculatedCrc        : std_logic_vector(SIZE_OF_CRC - 1 downto 0);
    
    begin
    
    BTL : BitTimeLogic port map
    (
        TxPin =>                Tx_Pin,             
        RxPin =>                Rx_Pin,                    
        TxBit =>                sig_TxBit,               
        RxBit =>                sig_RxBit,             
        clk_in =>               clk_in,              
        write_order =>          sig_write_order,        
        write_valid =>          sig_write_valid,         
        read_valid =>           sig_read_valid,          
        check_arbitration =>    sig_check_arbitration,  
        sample_start     =>     sig_start_sample
    );
    
    --receive process to parse frame
    receiveProcess : process
    begin
        
        case(receiveFrameEnum) is
    
            when IDLE =>
            
                if(falling_edge(Rx_Pin)) then
                
                    sig_start_sample <= '1';
                    receiveFrameEnum <= SOF;
                    
                end if;
            
            when SOF =>
            
                if(rising_edge(sig_read_valid)) then
                
                    if(sig_RxBit = '0') then
                        
                        receiveFrameEnum <= ID;
                        sig_check_arbitration <= '1';
                        receivePackageCounter <= 0;
                        receiveFrame.Sof <= sig_RxBit;
                        
                    else
                    
                        -- TODO add error because rx Pin trigged to low and start SOF state but not keep low at sample point
                    
                    end if;
                
                end if;
            
            when ID =>
            
                if(rising_edge(sig_read_valid)) then
                
                    receiveFrame.StdId(receivePackageCounter) <= sig_RxBit;
                    receivePackageCounter <= receivePackageCounter + 1;
                    if(receivePackageCounter = SIZE_OF_STD_ID) then
                        receivePackageCounter <= 0;
                        receiveFrameEnum <= RTR;
                    end if;
                end if;
            
            when RTR =>
            
                if(rising_edge(sig_read_valid)) then
                
                    receiveFrame.Rtr <= sig_RxBit;
                    sig_check_arbitration <= '0';
                    receiveFrameEnum <= IDE;
                
                end if;
            
            when IDE =>
            
                if(rising_edge(sig_read_valid)) then
                
                    receiveFrameEnum <= DLC;        -- then check ; if rxBit = '0' stdID or rxBit = '1' extended id
                    receiveFrame.Ide <= sig_RxBit;
                    
                end if;
            
            when DLC =>
            
                if(rising_edge(sig_read_valid)) then
                
                    receiveFrame.Dlc(receivePackageCounter) <= sig_RxBit;
                    receivePackageCounter <= receivePackageCounter + 1;
                    if(receivePackageCounter = SIZE_OF_DLC) then
                        receivePackageCounter <= 0;
                        receiveFrameEnum <= RESERVE;
                        receveDataByteSize <= to_integer(unsigned(receiveFrame.Dlc));
                    end if;
                end if;            
            
            when RESERVE =>
            
                if(rising_edge(sig_read_valid)) then
                
                    receiveFrameEnum <= DATA;        -- then check ; if rxBit not '0' add error because reserve bit must be 0
                    receiveFrame.Reserved <= sig_RxBit;
                end if;
            
            when DATA =>
            
                if(rising_edge(sig_read_valid)) then
                
                    receiveFrame.Data(receiveDataByteCounter)(receivePackageCounter) <= sig_RxBit;
                    receivePackageCounter <= receivePackageCounter + 1;
                    if(receivePackageCounter = to_integer(unsigned(receiveFrame.Dlc))) then
                        receivePackageCounter <= 0;
                        receiveDataByteCounter <= receiveDataByteCounter + 1;
                        if(receiveDataByteCounter = receveDataByteSize) then
                            receiveDataByteCounter <= 0;
                            receivePackageCounter <= 0;
                            receiveFrameEnum <= CRC;
                        end if;
                        
                    end if;
                
                end if;
            
            when CRC =>
            
                if(rising_edge(sig_read_valid)) then
                    
                    receivedCrc(receivePackageCounter) <= sig_RxBit;
                    receivePackageCounter <= receivePackageCounter + 1;
                    if(receivePackageCounter = SIZE_OF_CRC) then
                        receivePackageCounter <= 0;
                        receiveFrameEnum <= CRC_DELIMITER;
                        crcVectorToCalculate <= receiveFrame.Sof & receiveFrame.StdId & receiveFrame.Rtr & receiveFrame.Ide & receiveFrame.Dlc & receiveFrame.Reserved;
                        for i in 0 to to_integer(unsigned(receiveFrame.Dlc)) - 1 loop
                        
                            crcVectorToCalculate <= crcVectorToCalculate & receiveFrame.Data(i);
                        
                        end loop;
                        
                        calculatedCrc <= crc(crcVectorToCalculate,SIZE_OF_MIN_CRC_FIELD + to_integer(unsigned(receiveFrame.Dlc)));
                        if(receivedCrc = calculatedCrc) then
                        
                            -- TODO send crc delimiter to sender
                        
                        end if;
                    end if;
                  
                end if;
            
            when ACK =>
            
            when EOF =>
            
        
        
        end case;
    
    end process;
    
    -- transmit process to stream to BTL
    transmitProcess : process
    begin
        
        case(transmitFrameEnum) is
    
            when IDLE =>
            
            when SOF =>
            
            when ID =>
            
            when RTR =>
            
           
            
            when DATA =>
            
            when CRC =>
            
            when ACK =>
            
            when EOF =>
            
        
        
        end case;
    
    end process;
    
    end Behavioral;
