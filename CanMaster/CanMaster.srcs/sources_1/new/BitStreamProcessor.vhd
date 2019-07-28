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
               sample_start      :  in std_logic    -- BSP check starf of frame and set sample start 
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
     
      type FrameEnumType is (IDLE,SOF,ID,RTR,IDE,DLC,RESERVE,DATA,CRC,CRC_DELIMITER,ACK,ACK_DELIMITER,EOF,IFS,STUFFING);  -- enum types for parse and transmit frame
      signal receiveFrameEnum       : FrameEnumType  := Idle;         -- receive enum 
      signal receiveFrameEnumPrev   : FrameEnumType  := Idle;         -- receive enum
      signal transmitFrameEnum      : FrameEnumType := Idle;         -- transmit enum 
      
      signal sig_start_sample : std_logic := '0';   -- check rx pin falling edge and set start sample to BTL
      
      signal receiveFrame : CanFrame;                   -- receive frame for collection all received bits
      signal receivePackageCounter : integer := 0;      -- counter to get all bits of stage frame
      signal receiveDataByteCounter : integer := 0;     -- counter to get all bits data stage
      signal receveDataByteSize     : integer := 0;     -- stroge to received dlc as integer format
      
      signal crcVectorToCalculate : std_logic_vector(SIZE_OF_MAX_CRC_FIELD - 1 downto 0);   --  storage to combine stages to calculate crc
      signal receivedCrc          : std_logic_vector(SIZE_OF_CRC - 1 downto 0);             -- storage received crc bits
      signal calculatedCrc        : std_logic_vector(SIZE_OF_CRC - 1 downto 0);             -- storage calculated crc to compare with received crc
      
      signal receivedEOF          : std_logic_vector(SIZE_OF_EOF - 1 downto 0);             -- storage received eof bits to check error
      signal receivedIFS          : std_logic_vector(SIZE_OF_IFS - 1 downto 0);             -- storage received ifs bits to check error
    
      signal bitStuffingVector    : std_logic_vector(SIZE_OF_BIT_STUFFING_FIELD -1 downto 0);     -- get last 5 bits in stuff field to check stuffings
      signal bitStuffingCounter   : integer := 0;
      signal bitStuffingWaitBit   : std_logic;
      
      signal errorStates          : std_logic_vector(SIZE_OF_ERRORS - 1 downto 0) := "000000";
    
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
            
                if(falling_edge(Rx_Pin)) then           -- if rx pin falling edge transmit start
                
                    sig_start_sample <= '1';            --  say to BTL  start to sample received bits
                    receiveFrameEnum <= SOF;
                    receiveFrameEnumPrev <= receiveFrameEnum;
                    
                end if;
            
            when SOF =>                                 --  start of frame must be '0'
            
                if(rising_edge(sig_read_valid)) then    -- BTL finished to sample receive bit
                
                    if(sig_RxBit = '0') then            -- sof must be recessive to start of frame
                        
                        receiveFrameEnum <= ID;         --  change state to recieve std id
                        sig_check_arbitration <= '1';   -- frame enter to arbitration stage. Arbitration stage is only std id and rtr stages
                        receivePackageCounter <= 0;     -- receivePackageCounter reset to collect std id bits
                        receiveFrame.Sof <= sig_RxBit;  -- storage Sof bit
                        bitStuffingVector(bitStuffingCounter) <= sig_RxBit;
                        bitStuffingCounter <= bitStuffingCounter + 1;
                        receiveFrameEnumPrev <= receiveFrameEnum;
                    else
                    
                        errorStates(Location_Error_Sof) <= '1';
                        receiveFrameEnum <= IDLE;
                        -- TODO add error because rx Pin trigged to low and start SOF state but not keep low at sample point
                    
                    end if;
                
                end if;
            
            when ID =>                                                         -- Std id enum
            
                if(rising_edge(sig_read_valid)) then
                
                    receiveFrame.StdId(receivePackageCounter) <= sig_RxBit;     -- storage all received bits until received bits counter reach to size of std
                    if(receivePackageCounter = SIZE_OF_STD_ID) then             -- if counter reach to size of std set enum to rtr
                        receivePackageCounter <= 0;
                        receiveFrameEnum <= RTR;
                    end if;
                            
                    receivePackageCounter <= receivePackageCounter + 1;
                    -- check bit stuffing
                    receiveFrameEnumPrev <= receiveFrameEnum;       
                    bitStuffingVector(bitStuffingCounter) <= sig_RxBit;
                    bitStuffingCounter <= bitStuffingCounter + 1;
                    if((receivePackageCounter >= 5) and (bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "00000" or bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "11111")) then
                    
                        bitStuffingWaitBit <= not bitStuffingVector(receivePackageCounter - 1);
                        receiveFrameEnum <= STUFFING;
                    
                    end if;
                    -- end of check bit stuffing
                end if;
            
            when RTR =>                                                         -- remote control enum if rtr bit recessive frame is remote frame or rtr bit dominant frame is data                   
            
                if(rising_edge(sig_read_valid)) then
                
                    receiveFrame.Rtr <= sig_RxBit;                  
                    sig_check_arbitration <= '0';
                    receiveFrameEnum <= IDE;
                    
                     -- check bit stuffing
                    receiveFrameEnumPrev <= receiveFrameEnum;       
                    bitStuffingVector(bitStuffingCounter) <= sig_RxBit;
                    bitStuffingCounter <= bitStuffingCounter + 1;
                    if((receivePackageCounter >= 5) and (bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "00000" or bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "11111")) then
                    
                        bitStuffingWaitBit <= not bitStuffingVector(receivePackageCounter - 1);
                        receiveFrameEnum <= STUFFING;
                    
                    end if;
                    -- end of check bit stuffing                   
                
                end if;
            
            when IDE =>
            
                if(rising_edge(sig_read_valid)) then
                
                    receiveFrameEnum <= DLC;        -- then check ; if rxBit = '0' stdID or rxBit = '1' extended id. now state machine not check extended frame. it can add in future.
                    receiveFrame.Ide <= sig_RxBit;
                    
                    -- check bit stuffing
                    receiveFrameEnumPrev <= receiveFrameEnum;       
                    bitStuffingVector(bitStuffingCounter) <= sig_RxBit;
                    bitStuffingCounter <= bitStuffingCounter + 1;
                    if((receivePackageCounter >= 5) and (bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "00000" or bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "11111")) then
                    
                        bitStuffingWaitBit <= not bitStuffingVector(receivePackageCounter - 1);
                        receiveFrameEnum <= STUFFING;
                    
                    end if;
                    -- end of check bit stuffing        
                    
                end if;
            
            when DLC =>                             -- collect data bits to receive enum. 
            
                if(rising_edge(sig_read_valid)) then        
                
                    receiveFrame.Dlc(receivePackageCounter) <= sig_RxBit;   
                    receivePackageCounter <= receivePackageCounter + 1;
                    if(receivePackageCounter = SIZE_OF_DLC) then
                        receivePackageCounter <= 0;
                        receiveFrameEnum <= RESERVE;
                        receveDataByteSize <= to_integer(unsigned(receiveFrame.Dlc));          -- get dlc size as integer to use at another enums.
                    end if;
                    
                    -- check bit stuffing
                    receiveFrameEnumPrev <= receiveFrameEnum;       
                    bitStuffingVector(bitStuffingCounter) <= sig_RxBit;
                    bitStuffingCounter <= bitStuffingCounter + 1;
                    if((receivePackageCounter >= 5) and (bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "00000" or bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "11111")) then
                    
                        bitStuffingWaitBit <= not bitStuffingVector(receivePackageCounter - 1);
                        receiveFrameEnum <= STUFFING;
                    
                    end if;
                    -- end of check bit stuffing    
                    
                end if;            
            
            when RESERVE =>
            
                if(rising_edge(sig_read_valid)) then
                
                    if(sig_RxBit = '0') then    
                        receiveFrame.Reserved <= sig_RxBit;
                        
                        if(receveDataByteSize = 0 or receiveFrame.Rtr = '1') then       -- if DLC is 0 or frame is remote skip data enum and go to crc field.
                        
                            receiveFrameEnum <= DATA; 
                            
                        else
                        
                            receiveFrameEnum <= CRC;       
                        
                        end if;
                        
                     -- check bit stuffing
                    receiveFrameEnumPrev <= receiveFrameEnum;       
                    bitStuffingVector(bitStuffingCounter) <= sig_RxBit;
                    bitStuffingCounter <= bitStuffingCounter + 1;
                    if((receivePackageCounter >= 5) and (bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "00000" or bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "11111")) then
                    
                        bitStuffingWaitBit <= not bitStuffingVector(receivePackageCounter - 1);
                        receiveFrameEnum <= STUFFING;
                    
                    end if;
                    -- end of check bit stuffing    
                                       
                    else
                    
                        errorStates(Location_Error_Reserve) <= '1';
                        receiveFrameEnum <= IDLE;
                        -- then check ; if rxBit not '0' add error because reserve bit must be 0 
                    
                    end if;
                              
                end if;
            
            when DATA =>            -- collect data bits until received bits size reach to dlc size
            
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
                    
                    -- check bit stuffing
                    receiveFrameEnumPrev <= receiveFrameEnum;       
                    bitStuffingVector(bitStuffingCounter) <= sig_RxBit;
                    bitStuffingCounter <= bitStuffingCounter + 1;
                    if((receivePackageCounter >= 5) and (bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "00000" or bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "11111")) then
                    
                        bitStuffingWaitBit <= not bitStuffingVector(receivePackageCounter - 1);
                        receiveFrameEnum <= STUFFING;
                    
                    end if;
                    -- end of check bit stuffing  
                    
                end if;
            
            when CRC =>                         -- crc stage to collect crc bits
            
                if(rising_edge(sig_read_valid)) then
                    
                    receivedCrc(receivePackageCounter) <= sig_RxBit;
                    receivePackageCounter <= receivePackageCounter + 1;
                    if(receivePackageCounter = SIZE_OF_CRC) then                -- if received bits reach to size of crc compare receive crc and calculated crc
                        receivePackageCounter <= 0;
                        receiveFrameEnum <= CRC_DELIMITER;
                        crcVectorToCalculate <= receiveFrame.Sof & receiveFrame.StdId & receiveFrame.Rtr & receiveFrame.Ide & receiveFrame.Dlc & receiveFrame.Reserved;     -- combine all crc fields.
                        for i in 0 to to_integer(unsigned(receiveFrame.Dlc)) - 1 loop
                        
                            crcVectorToCalculate <= crcVectorToCalculate & receiveFrame.Data(i);
                        
                        end loop;
                        
                        calculatedCrc <= crc(crcVectorToCalculate,SIZE_OF_MIN_CRC_FIELD + to_integer(unsigned(receiveFrame.Dlc)));
                        if(receivedCrc = calculatedCrc) then    -- if calculated crc match with received crc send ack bit at crc delimeter field. if not not send anything.
                        
                            sig_write_order <= '1';
                            sig_TxBit <= '0';
                        else
                                    
                            errorStates(Location_Error_Crc) <= '1';             -- crc error
                            receiveFrameEnum <= IDLE;
                            
                        end if;
                    else
                    
                        -- check bit stuffing
                        receiveFrameEnumPrev <= receiveFrameEnum;       
                        bitStuffingVector(bitStuffingCounter) <= sig_RxBit;
                        bitStuffingCounter <= bitStuffingCounter + 1;
                        if((receivePackageCounter >= 5) and (bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "00000" or bitStuffingVector(receivePackageCounter - 5 to receivePackageCounter - 1) = "11111")) then
                        
                            bitStuffingWaitBit <= not bitStuffingVector(receivePackageCounter - 1);
                            receiveFrameEnum <= STUFFING;
                        
                        end if;
                        -- end of check bit stuffing  

                    end if;
                  
                end if;
            
            when CRC_DELIMITER =>           -- for crc delimeter send dominant bit to transmitter.
            
                if(sig_write_order = '1') then
                
                    if(falling_edge(sig_write_valid)) then
                    
                        sig_write_order <= '0';
                        receiveFrameEnum <= ACK;
                        
                    end if; 
                else
                    
                    if(rising_edge(sig_read_valid)) then
                    
                        receiveFrameEnum <= ACK;
                    
                    end if;
                      
                end if;
                
                
            when ACK =>                 -- get ack bit and check if equal to '0'. if not occur error.
            
                if(rising_edge(sig_read_valid)) then
                    
                    if(sig_RxBit = '0') then            -- if there isn't any error send ack as dominant bit at delimiter stage.
                    
                        sig_write_order <= '1';
                        sig_TxBit <= '0';
                        receiveFrameEnum <= ACK_DELIMITER;
                    else
                    
                        -- TODO ADD ERROR
                        errorStates(Location_Error_Ack) <= '1';
                        receiveFrameEnum <= ACK_DELIMITER;
                        receiveFrameEnum <= IDLE;
                        
                    end if;
                    
                end if;     
            
            
            when ACK_DELIMITER =>               -- send ack and go to eof enum
            
                if(sig_write_order = '1') then
                
                    if(falling_edge(sig_write_valid)) then
                    
                        sig_write_order <= '0';
                        receiveFrameEnum <= EOF;
                        
                    end if; 
                    
                else
                    
                   if(rising_edge(sig_read_valid)) then
                   
                    receiveFrameEnum <= EOF;
                   
                   end if; 
                
                end if;
                
                
            when EOF =>                                                     -- collect all eof bits check all bits if equal to recessive bit.
            
                if(rising_edge(sig_read_valid)) then
                   
                    receivedEOF(receivePackageCounter) <= sig_RxBit;
                    receivePackageCounter <= receivePackageCounter + 1;
                    if(receivePackageCounter = SIZE_OF_EOF) then
                        receivePackageCounter <= 0;
                        if(receivedEOF = "1111111") then
                        
                            receiveFrameEnum <= IFS;
                        
                        else
                        
                            errorStates(Location_Error_Eof) <= '1';            -- TODO add error because eof not received correctly as all bits '1'
                            receiveFrameEnum <= IFS;
                            receiveFrameEnum <= IDLE;
                        end if;
                    
                    end if;
                   
                end if; 
                
           when IFS =>                                      -- collect all ifs bits check all bits if equal to recessive bit.
           
                if(rising_edge(sig_read_valid)) then
                
                    receivedIFS(receivePackageCounter) <= sig_RxBit;
                    receivePackageCounter <= receivePackageCounter + 1;
                    if(receivePackageCounter = SIZE_OF_IFS) then
                    
                        receivePackageCounter <= 0;
                        if(receivedIFS = "111") then
                        
                            receiveFrameEnum <= IDLE;
                            sig_start_sample <= '0';
                            
                        else
                        
                            errorStates(Location_Error_Ifs) <= '1';
                            receiveFrameEnum <= IDLE;       -- TODO add error because all IFS bits must be '1'
                            sig_start_sample <= '0';
                        
                        end if;
                    
                    end if;
                
                end if;
                
          when STUFFING =>
          
            if(rising_edge(sig_read_valid)) then
            
                if(sig_rxBit = bitStuffingWaitBit) then
                
                    receiveFrameEnum <= receiveFrameEnumPrev;
                
                else
                
                    errorStates(Location_Error_BitStuffing) <= '1';
                    -- TODO add bit stuffing error.
                
                end if;
            
            
            end if;
           
        
        end case;
    
    end process;
    
    -- transmit process to stream to BTL
    transmitProcess : process
    begin
        
            
    end process;
    
    end Behavioral;
