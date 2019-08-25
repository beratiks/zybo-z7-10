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


    entity BitStreamProcessor is
        Port ( Tx_Pin               : out STD_LOGIC := '1';
               Rx_Pin               : in STD_LOGIC;
               clk_in               : in STD_LOGIC;
               receivePackage       : out CanPackage;
               transmitPackage      : in CanPackage;
               receiving            : out STD_LOGIC;
               receiveIT            : out STD_LOGIC;
               transmitIT           : out STD_LOGIC;
               error                : out STD_LOGIC_VECTOR(SIZE_OF_ERRORS - 1 downto 0);
               transmitOrder        : in STD_LOGIC;
               startReceive         : in std_logic := '0';
               bitstuffTrigger      : out std_logic;
               leds                 : out std_logic_vector(3 downto 0)
              
               );
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
      end component BitTimeLogic;
      
      type FrameEnumType is (IDLE,SOF,ID,RTR,IDE,DLC,RESERVE,DATA,CRC,CRC_DELIMITER,ACK,ACK_DELIMITER,EOF,IFS,STUFFING,LOCK);  -- enum types for parse and transmit frame


      signal    sig_RxBit                   :   std_logic;
      signal    sig_read_valid              :   std_logic;
      signal    sig_check_arbitration       :   std_logic   :=  '0';    
      signal    receiveFrameEnum            :   FrameEnumType  := Idle;         -- receive enum 
      signal    receiveFrameEnumPrev        :   FrameEnumType  := Idle;         -- receive enum
      signal    sig_start_sample            :   std_logic := '0';   -- check rx pin falling edge and set start sample to BTL
      signal    receiveFrame                :   CanFrame;                   -- receive frame for collection all received bits
      signal    receivePackageCounter       :   integer := 0;      -- counter to get all bits of stage frame
      signal    receiveDataByteCounter      :   integer := 0;     -- counter to get all bits data stage
      signal    sig_receiving               :   std_logic   := '0';       
      signal    sig_receiveIT               :   std_logic;
      signal    startSample_receive         :   std_logic := '0';     
      signal    sig_rxPin                   :   std_logic       := '1';
      signal    sig_rxPinPrev               :   std_logic := '1';
      signal    bitStuffingCounter          :   integer := 0;
      signal    bitStuffingWillWaitBit      :   std_logic;
      signal    sig_TxBitReceive            :   std_logic := '1';
      signal    sig_write_orderReceive      :   std_logic   := '0';
      signal    sig_start_sampleReceive     :   std_logic := '0';
             
      signal    sig_start_sampleTransmit    :   std_logic := '0';
      signal    sig_write_order             :   std_logic   := '0';
      signal    sig_write_orderTransmit     :   std_logic   := '0';
      signal    sig_write_valid             :   std_logic;   
      signal    sig_TxBit                   :   std_logic;
      signal    sig_TxBitPrev               :   std_logic;
      signal    transmitFrameEnum           :   FrameEnumType  := Idle;         -- receive enum 
      signal    transmitFrame               :   CanFrame;                   -- receive frame for collection all received bits
      signal    sig_transmitIT              :   std_logic;
      signal    startTransmit               : std_logic := '1';
      signal    sig_TxBitTransmit           : std_logic := '1';
      signal    sig_transmitting            : std_logic := '0';
      signal    transmitError               : std_logic := '0';
      
      signal    arbitrationLost             : std_logic := '0';
      signal    txBitPrevForArbitration     : std_logic;
      signal    stuffingTransmitForAbitration : std_logic := '0';
      
      signal led : std_logic;
      
       
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
    
    
    sig_rxPin <= Rx_Pin;
    
    sig_TxBit <= sig_TxBitTransmit and sig_TxBitReceive;
    
    sig_write_order <= sig_write_orderReceive or sig_write_orderTransmit;
    
    sig_start_sample <= sig_start_sampleReceive or sig_start_sampleTransmit;
    
    transmitIT <= sig_transmitIT;
    
    receiving <= sig_receiving;   
    
    receiveIT <= sig_receiveIT;
            
       
    --receive process to parse frame
    receiveProcess : process
    
    
    variable    dlcIterator             :   std_logic_vector(SIZE_OF_DLC - 1 downto 0);
    variable    receveDataByteSize      : integer := 0;     -- stroge to received dlc as integer format
    variable    receivedCrc             : std_logic_vector(14 downto 0);
    
    
    variable    CrcNextBit                 :  std_logic;
    variable    var_CalculatedCrc          :  std_logic_vector(14 downto 0) := "000000000000000";
     
    variable    sig_read_validPrevReceive  : std_logic;
    variable    sig_write_valid_prev        : std_logic;
    
    
    
    begin
    
    if(rising_edge(clk_in) ) then
        
        case(receiveFrameEnum) is
    
            when IDLE =>

                sig_receiveIT <= '1';           
                sig_receiving <= '0';                    
                sig_start_sampleReceive <= '0';
                arbitrationLost <= '0';
                if(sig_rxPin = '0') then
                
                    sig_receiving <= '1';                         
                    receiveFrameEnum <= SOF;
                    receiveFrameEnumPrev <= SOF;
                    sig_start_sampleReceive <= '1';
                    bitStuffingCounter <= 0;
                    var_CalculatedCrc := (others => '0');
                    
                end if;
                sig_rxPinPrev <= sig_rxPin;
                sig_read_validPrevReceive := sig_read_valid;
            
            
            when SOF =>      
                    
                  --  start of frame must be '0'
                   --sig_read_validPrev = '0' and 
                if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then    -- BTL finished to sample receive bit
                     
                    if(sig_RxBit = '0') then            -- sof must be recessive to start of frame
                        
                        CrcNextBit :=  sig_RxBit xor var_CalculatedCrc(14);
                        var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                        var_CalculatedCrc(0) := '0';
                        
                        if (CrcNextBit = '1') then
                              var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                        end if;
                        
                        receiveFrameEnum <= ID;         --  change state to recieve std id
                        sig_check_arbitration <= '1';   -- frame enter to arbitration stage. Arbitration stage consist only std id and rtr stages
                        receivePackageCounter <= SIZE_OF_STD_ID - 1;     -- receivePackageCounter reset to collect std id bits
                        receiveFrame.Sof <= sig_RxBit;  -- storage Sof bit
                        bitStuffingCounter <= 1;
                        receiveFrameEnumPrev <= ID;
                        sig_rxPinPrev <= sig_RxBit;
                    else
                    
                        receiveFrameEnum <= IDLE;   
                     
                    end if;
                    ------------------------

                end if;
            sig_read_validPrevReceive := sig_read_valid;
            when ID =>   
                                      -- Std id enum
               
                if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then
                     
                        CrcNextBit :=  sig_RxBit xor var_CalculatedCrc(14);
                        var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                        var_CalculatedCrc(0) := '0';                    
                        if (CrcNextBit = '1') then
                              var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                        end if;
                              
                    receiveFrame.StdId(receivePackageCounter) <= sig_RxBit;     -- storage all received bits until received bits counter reach to size of std
                    receivePackageCounter <= receivePackageCounter - 1;
                    if(receivePackageCounter = 0) then             -- if counter reach to size of std set enum to rtr
                      
                      receiveFrameEnum <= RTR;
                    end if;
                    
                    -- check bit stuffing
                    receiveFrameEnumPrev <= receiveFrameEnum;       
                    
                    if(sig_RxBit = '0' and txBitPrevForArbitration = '1' and stuffingTransmitForAbitration = '0') then
                    
                        arbitrationLost <= '1';
                    
                    end if;
                    
                    if(sig_RxBit = sig_rxPinPrev) then
                    
                        bitStuffingCounter <= bitStuffingCounter + 1;
                        
                        if(bitStuffingCounter = 4) then
                        
                            bitStuffingWillWaitBit <= not sig_RxBit;
                            receiveFrameEnum <= STUFFING;      
                            bitStuffingCounter <= 1;
                            
                        end if;
                    
                    else
                    
                        bitStuffingCounter <= 1;
                    
                    end if;

                    -- end of check bit stuffing
                    
                    
                    sig_rxPinPrev <= sig_RxBit;
                end if;
            sig_read_validPrevReceive := sig_read_valid;
            
            
            when RTR =>     
                                                -- remote control enum if rtr bit recessive frame is remote frame or rtr bit dominant frame is data    
               
                if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then

                    CrcNextBit :=  sig_RxBit xor var_CalculatedCrc(14);
                    var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                    var_CalculatedCrc(0) := '0';
                    
                    if (CrcNextBit = '1') then
                          var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                    end if;
                                    
                    
                    receiveFrame.Rtr <= sig_RxBit;                  
                    sig_check_arbitration <= '0';
                    receiveFrameEnum <= IDE;
                     -- check bit stuffing
                    receiveFrameEnumPrev <= IDE;       
                    ------------------------
                       if(sig_RxBit = sig_rxPinPrev) then
                    
                        bitStuffingCounter <= bitStuffingCounter + 1;
                        
                        if(bitStuffingCounter = 4) then
                        
                            bitStuffingWillWaitBit <= not sig_RxBit;
                            receiveFrameEnum <= STUFFING;
                            bitStuffingCounter <= 1;
                            
                        end if;
                    
                    else
                    
                        bitStuffingCounter <= 1;
                    
                    end if;
                ------------------------------------------
                    -- end of check bit stuffing                   
                sig_rxPinPrev <= sig_RxBit;
                end if;
            sig_read_validPrevReceive := sig_read_valid;
            when IDE =>
               
                 if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then

                    CrcNextBit :=  sig_rxBit xor var_CalculatedCrc(14);
                    var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                    var_CalculatedCrc(0) := '0';
                    
                    if (CrcNextBit = '1') then
                          var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                    end if;
                                    
                    receiveFrameEnum <= RESERVE;       -- then check ; if rxBit = '0' stdID or rxBit = '1' extended id. now state machine not check extended frame. it can add in future.
                    receiveFrame.Ide <= sig_RxBit;
                    -- check bit stuffing
                    receiveFrameEnumPrev <= RESERVE;       

                    ------------------------
                       if(sig_RxBit = sig_rxPinPrev) then
                    
                        bitStuffingCounter <= bitStuffingCounter + 1;
                        
                        if(bitStuffingCounter = 4) then
                        
                            bitStuffingWillWaitBit <= not sig_RxBit;
                            receiveFrameEnum <= STUFFING;
                            bitStuffingCounter <= 1;
                            
                        end if;
                    
                    else
                    
                        bitStuffingCounter <= 1;
                    
                    end if;
                ------------------------------------------
                sig_rxPinPrev <= sig_RxBit;
                end if;
             sig_read_validPrevReceive := sig_read_valid;   
             
             when RESERVE =>
              
               if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then

                    CrcNextBit :=  sig_rxBit xor var_CalculatedCrc(14);
                    var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                    var_CalculatedCrc(0) := '0';
                    
                    if (CrcNextBit = '1') then
                          var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                    end if;
                                        
                    if(sig_RxBit = '0') then    
                        receiveFrame.Reserved <= sig_RxBit;
                        receivePackageCounter <= SIZE_OF_DLC - 1;
                        receiveFrameEnum <= DLC;

                     -- check bit stuffing
                    receiveFrameEnumPrev <= DLC;   
                    ------------------------
                       if(sig_RxBit = sig_rxPinPrev) then
                    
                        bitStuffingCounter <= bitStuffingCounter + 1;
                        
                        if(bitStuffingCounter = 4) then
                            
                            bitStuffingWillWaitBit <= not sig_RxBit;
                            receiveFrameEnum <= STUFFING;
                            bitStuffingCounter <= 1;
                        end if;
                        

                    
                    else
                    
                        bitStuffingCounter <= 1;
                    
                    end if;
                    

                ------------------------------------------
                    -- end of check bit stuffing    
                                       
                    else
                       
                        receiveFrameEnum <= IDLE;
                        -- then check ; if rxBit not '0' add error because reserve bit must be 0 
                    
                    end if;
                sig_rxPinPrev <= sig_RxBit;              
                end if;
            sig_read_validPrevReceive := sig_read_valid;
            
            when DLC => 
              
                   -- collect data bits to receive enum. 
                if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then  

                    CrcNextBit :=  sig_rxBit xor var_CalculatedCrc(14);
                    var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                    var_CalculatedCrc(0) := '0';
                    
                    if (CrcNextBit = '1') then
                          var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                    end if;
                                        
                    
                    dlcIterator(receivePackageCounter) := sig_RxBit;
                    receivePackageCounter <= receivePackageCounter - 1;
                    if(receivePackageCounter = 0) then
                        receiveFrame.Dlc <= dlcIterator;
                        receveDataByteSize := to_integer(unsigned(dlcIterator));          -- get dlc size as integer to use at another enums.
                        if(receveDataByteSize /= 0  and receiveFrame.Rtr = '0') then       -- if DLC is 0 or frame is remote skip data enum and go to crc field.
                             receiveDataByteCounter <= 0;
                             receivePackageCounter <= 7;
                             receiveFrameEnum <= DATA;    
                             receiveFrameEnumPrev <= DATA;         
                        else                       
                            receiveFrameEnum <= CRC;       
                            receivePackageCounter <= SIZE_OF_CRC - 1;
                            receiveFrameEnumPrev <= CRC;  

                        end if;
                    else
                    
                        receiveFrameEnumPrev <= DLC;  
                        
                    end if;
                    
--                    -- check bit stuffing    
                    ----------------------
                       if(sig_RxBit = sig_rxPinPrev) then
                    
                        bitStuffingCounter <= bitStuffingCounter + 1;
                        
                        if(bitStuffingCounter = 4) then
                        
                            bitStuffingWillWaitBit <= not sig_RxBit;
                            receiveFrameEnum <= STUFFING;
                            bitStuffingCounter <= 1;
                            
                        end if;
                    
                    else
                    
                        bitStuffingCounter <= 1;
                    
                    end if;
                ------------------------------------------
                    -- end of check bit stuffing    
                 sig_rxPinPrev <= sig_RxBit;   
                end if;            
            sig_read_validPrevReceive := sig_read_valid;
            
            when DATA =>            -- collect data bits until received bits size reach to dlc size
              
              if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then

                    CrcNextBit :=  sig_rxBit xor var_CalculatedCrc(14);
                    var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                    var_CalculatedCrc(0) := '0';
                    
                    if (CrcNextBit = '1') then
                          var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                    end if;
                                   
                    receiveFrameEnumPrev <= DATA;
                    receiveFrame.Data(receiveDataByteCounter)(receivePackageCounter) <= sig_RxBit;
                    receivePackageCounter <= receivePackageCounter - 1;
                    if(receivePackageCounter = 0) then
                        receivePackageCounter <= 7;
                        receiveDataByteCounter <= receiveDataByteCounter + 1;
                        if(receiveDataByteCounter = 7) then
                            receiveDataByteCounter <= 0;
                            receivePackageCounter <= SIZE_OF_CRC - 1;
                            receiveFrameEnum <= CRC;
                            receiveFrameEnumPrev <= CRC;
                         else
                         
                             receiveFrameEnumPrev <= DATA;       
                         
                        end if;
                        
                    end if;
                    
                    -- check bit stuffing
                    
                    ------------------------
                      if(sig_RxBit = sig_rxPinPrev) then
                    
                        bitStuffingCounter <= bitStuffingCounter + 1;
                        
                        if(bitStuffingCounter = 4) then
                        
                            bitStuffingWillWaitBit <= not sig_RxBit;
                            receiveFrameEnum <= STUFFING;
                            bitStuffingCounter <= 1;
                            
                        end if;
                    
                    else
                    
                        bitStuffingCounter <= 1;
                    
                    end if;
                ------------------------------------------
                    -- end of check bit stuffing   
                sig_rxPinPrev <= sig_RxBit;   
                end if;
            sig_read_validPrevReceive := sig_read_valid; 
            
            
            when CRC =>                         -- crc stage to collect crc bits
              
                if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then
                 
                    receivePackageCounter <= receivePackageCounter - 1;
                    receivedCrc(receivePackageCounter) := sig_RxBit;
                    if(receivePackageCounter = 0) then                -- if received bits reach to size of crc compare receive crc and calculated crc
                        receivePackageCounter <= 0;
                         if(receivedCrc(14 downto 0) = var_CalculatedCrc(14 downto 0)) then    -- if calculated crc match with received crc send ack bit at crc delimeter field. if not not send anything.
                           
                           receiveFrameEnum <= CRC_DELIMITER;
                           receiveFrameEnumPrev <= CRC_DELIMITER;   
                           
                         else

                                  receiveFrameEnum <= IDLE;
                                  
                                  
                         end if;
                    else
                    
                        -- check bit stuffing
                        receiveFrameEnumPrev <= CRC;       
                    ------------------------

                ------------------------------------------
                        -- end of check bit stuffing  

                    end if;
                    
                       if(sig_RxBit = sig_rxPinPrev) then
                    
                        bitStuffingCounter <= bitStuffingCounter + 1;
                        
                        if(bitStuffingCounter = 4) then
                        
                            bitStuffingWillWaitBit <= not sig_RxBit;
                            receiveFrameEnum <= STUFFING;
                            bitStuffingCounter <= 1;
                            
                        end if;
                    
                    else
                    
                        bitStuffingCounter <= 1;
                    
                    end if;
                    
                sig_rxPinPrev <= sig_RxBit;     
                end if;
            sig_read_validPrevReceive := sig_read_valid;
            
            when CRC_DELIMITER =>           -- for crc delimeter send dominant bit to transmitter.
              
                if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then

                  --  tx_Pin <= '0';
                    if(sig_transmitting = '0') then 
                        sig_write_orderReceive <= '1';
                        sig_TxBitReceive <= '0';
                        receiveFrameEnum <= ACK;
                    else
                    
                        receiveFrameEnum <= ACK;
                    
                    end if;

                end if;
                sig_read_validPrevReceive := sig_read_valid;  
            when ACK =>                 
                 
                   if(sig_write_valid_prev = '0' and sig_write_valid = '1') then
                   
                    if(sig_transmitting = '0') then
                        sig_write_orderReceive <= '1';
                        sig_TxBitReceive <= '1';
                        receiveFrameEnum <= ACK_DELIMITER;
                   else
                   
                        receiveFrameEnum <= ACK_DELIMITER;
                   
                   end if;     
                        
                        
                        

                   end if;
                 sig_write_valid_prev := sig_write_valid;
            when ACK_DELIMITER =>               -- send ack and go to eof enum
               
                sig_write_orderReceive <= '0';
                if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then

                    receiveFrameEnum <= EOF;
                    receivePackageCounter <= SIZE_OF_EOF - 1;

                end if;
               sig_read_validPrevReceive := sig_read_valid; 
                 
            when EOF =>                                                     -- collect all eof bits check all bits if equal to recessive bit.
                
                if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then
                    
                   if(sig_rxBit = '1') then     
                        receivePackageCounter <= receivePackageCounter - 1;
                        if(receivePackageCounter = 0) then
    
                                receiveFrameEnum <= IFS;
                                receivePackageCounter <= SIZE_OF_IFS - 1;
                            
                        end if;
                    else
                    
                        receiveFrameEnum <= IDLE;
                       
                            
                        
                  end if; 
                end if; 
           sig_read_validPrevReceive := sig_read_valid;     
           when IFS =>                                      -- collect all ifs bits check all bits if equal to recessive bit.
               
                if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then
                
                  if(sig_rxBit = '1') then 
                    receivePackageCounter <= receivePackageCounter - 1;
                    if(receivePackageCounter = 0) then

                            receiveFrameEnum <= IDLE;
                            sig_start_sampleReceive <= '0';
                            sig_receiveIT   <= '0';
                            
                            
                            receivePackage.StdId <= ReceiveFrame.StdId;
                            receivePackage.Data <= ReceiveFrame.Data;
                            receivePackage.Dlc  <= ReceiveFrame.Dlc;
                            receivePackage.Rtr  <= receiveFrame.Rtr;
                    
                    end if;
                  else
                
                        -- TODO error
                                            
                        receiveFrameEnum <= IDLE;
                     
                  end if;
                end if;
          sig_read_validPrevReceive := sig_read_valid;      
          
          when STUFFING =>
            
            if(sig_read_validPrevReceive = '0' and sig_read_valid = '1') then
                if(sig_RxBit = bitStuffingWillWaitBit) then
                    
                    receiveFrameEnum <= receiveFrameEnumPrev;
                    sig_rxPinPrev <= sig_RxBit;
                    
                else
                
                    receiveFrameEnum <= IDLE;
                  
                    -- TODO add bit stuffing error.
                end if;
                
            end if;
           
        sig_read_validPrevReceive := sig_read_valid;  
        
        when LOCK =>
        
           
            sig_start_sampleReceive <= '0';
        
        end case;
        
    
    end if;
    
    end process;
    
    --transmit process to stream to BTL
    transmitProcess : process
    
    variable transmitPackageCounter : integer := 0;
    variable transmitDataByteCounter : integer := 0;
    variable transmitBitStuffingCounter : integer := 0;
    variable transmitNextBit            : std_logic;

    variable    CrcNextBit                 :  std_logic;
    variable    var_CalculatedCrc          :  std_logic_vector(14 downto 0) := "000000000000000";
    
    variable sig_read_validPrevTransmit : std_logic;
    variable    sig_write_validPrev : std_logic;
    variable transmitOrderPrev : std_logic := '0';

    begin
    if(rising_edge(clk_in) ) then
  
        case(transmitFrameEnum) is
        
        when IDLE =>
           
           leds <= "0001";
           
           if(transmitOrder = '1') then
        
              startTransmit <= '1';
               
            end if;
     --       transmitOrderPrev := transmitOrder;
            
            sig_write_orderTransmit <= '0';
            sig_transmitting <= '0'; 
            sig_transmitIT <= '1';
            if(startTransmit = '1' and sig_receiving = '0') then 
                
                startTransmit <= '0';
                sig_transmitting <= '1';
                sig_TxBitTransmit <= '0';
                sig_TxBitPrev <= '0';
                sig_write_orderTransmit <= '1';
                transmitFrameEnum <= SOF;                 
                transmitBitStuffingCounter := 1;
                transmitNextBit := '0';
                var_CalculatedCrc := (others => '0');
                
                transmitFrame.StdId <= transmitPackage.StdId;
                transmitFrame.Dlc <= transmitPackage.Dlc;
                transmitFrame.Rtr <= transmitPackage.Rtr;
                transmitFrame.Data <= transmitPackage.Data;
                
          
                CrcNextBit :=  transmitNextBit xor var_CalculatedCrc(14);
                var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                var_CalculatedCrc(0) := '0';
               
                if (CrcNextBit = '1') then
                    var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                end if;
                
            end if;   
             sig_write_validPrev := sig_write_valid; 
             
        when SOF =>     
            leds <= "0010";
            if(sig_write_validPrev = '0' and sig_write_valid = '1') then
                
                
                -- start of bit stuffing control
                if(transmitBitStuffingCounter = 5) then
                
                    transmitNextBit := not sig_TxBitPrev;
                    transmitBitStuffingCounter := 1;
                    stuffingTransmitForAbitration <= '1';
                    
                else
                    stuffingTransmitForAbitration <= '0';
                    transmitPackageCounter := SIZE_OF_STD_ID - 1;
                    transmitNextBit := transmitFrame.StdId(transmitPackageCounter);
                    transmitFrameEnum <= ID;
 
                    if(sig_TxBitPrev = transmitNextBit) then
                    
                        transmitBitStuffingCounter := transmitBitStuffingCounter + 1;
                    
                    else
                    
                        transmitBitStuffingCounter := 1;
                    
                    end if;
                    
                    CrcNextBit :=  transmitNextBit xor var_CalculatedCrc(14);
                    var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                    var_CalculatedCrc(0) := '0';
                        
                    if (CrcNextBit = '1') then
                        var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                    end if;
                    txBitPrevForArbitration <= transmitNextBit;
                end if;
                -- end of bit stuffing control
                sig_TxBitTransmit <= transmitNextBit;
                sig_TxBitPrev <= transmitNextBit;
                
            end if;
        sig_write_validPrev := sig_write_valid;
        
        when ID =>
            leds <= "0100";
            if(sig_write_validPrev = '0' and sig_write_valid = '1') then
                
                if(arbitrationLost = '1') then
                                             
                   startTransmit <= '1';
                   sig_TxBitTransmit <= '1';
                   transmitFrameEnum <= IDLE;
                
                end if;
                -- start of bit stuffing control
                if(transmitBitStuffingCounter = 5) then
                
                    transmitNextBit := not sig_TxBitPrev;
                    transmitBitStuffingCounter := 1;
                    stuffingTransmitForAbitration <= '1';
                else
                    stuffingTransmitForAbitration <= '0';
                    if(transmitPackageCounter = 0) then
                        
                        transmitNextBit := transmitFrame.Rtr;
                        transmitFrameEnum <= RTR;
                        
                        
                    else
                        transmitPackageCounter := transmitPackageCounter - 1;
                        transmitNextBit := transmitFrame.StdId(transmitPackageCounter);

                    end if;
                    if(sig_TxBitPrev = transmitNextBit) then
                        
                        transmitBitStuffingCounter := transmitBitStuffingCounter + 1;
                       
                    else
                        
                         transmitBitStuffingCounter := 1;
                        
                    end if;
                     
                        CrcNextBit :=  transmitNextBit xor var_CalculatedCrc(14);
                        var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                        var_CalculatedCrc(0) := '0';
                            
                        if (CrcNextBit = '1') then
                            var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                        end if;
                        txBitPrevForArbitration <= transmitNextBit;
                end if;
                -- end of bit stuffing control
             sig_TxBitPrev <= transmitNextBit;
             sig_TxBitTransmit <= transmitNextBit;
             end if;
         sig_write_validPrev := sig_write_valid;    
         
         when RTR =>
            leds <= "1000";
            if(sig_write_validPrev = '0' and sig_write_valid = '1') then
          
                if(arbitrationLost = '1') then
                                             
                   startTransmit <= '1';
                   sig_TxBitTransmit <= '1';
                   transmitFrameEnum <= IDLE;
                
                end if;
                
                -- start of bit stuffing control
                if(transmitBitStuffingCounter = 5) then
                
                    transmitNextBit := not sig_TxBitPrev;
                    transmitBitStuffingCounter := 1;
                    
                else
                    
                    transmitNextBit := '0';
                    transmitFrameEnum <= IDE;
                    
                    if(sig_TxBitPrev = transmitNextBit) then
                        
                        transmitBitStuffingCounter := transmitBitStuffingCounter + 1;
                        
                    else
                        
                        transmitBitStuffingCounter := 1;
                        
                    end if;
                    
                   CrcNextBit :=  transmitNextBit xor var_CalculatedCrc(14);
                   var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                   var_CalculatedCrc(0) := '0';
                            
                   if (CrcNextBit = '1') then
                       var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                   end if;
                        
                end if;
                sig_TxBitPrev <= transmitNextBit;
                sig_TxBitTransmit <= transmitNextBit;
            end if;
          sig_write_validPrev := sig_write_valid;  
          
          when IDE =>
          
            leds <= "0011";
            if(sig_write_validPrev = '0' and sig_write_valid = '1') then
                
                -- start of bit stuffing control
                if(transmitBitStuffingCounter = 5) then
                
                    transmitNextBit := not sig_TxBitPrev;
                    transmitBitStuffingCounter := 1;
                    
                else
                    
                    transmitNextBit := '0';
                    transmitFrameEnum <= RESERVE;
                    
                    if(sig_TxBitPrev = transmitNextBit) then
                        
                        transmitBitStuffingCounter := transmitBitStuffingCounter + 1;
                        
                    else
                        
                        transmitBitStuffingCounter := 1;
                        
                    end if;
                    
                   CrcNextBit :=  transmitNextBit xor var_CalculatedCrc(14);
                   var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                   var_CalculatedCrc(0) := '0';
                            
                   if (CrcNextBit = '1') then
                       var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                   end if;
                   
                end if;
                sig_TxBitPrev <= transmitNextBit;
                sig_TxBitTransmit <= transmitNextBit;
                              
            
            end if;
            
                        
          sig_write_validPrev := sig_write_valid;
            
          when RESERVE =>
            leds <= "0101";  
            if(sig_write_validPrev = '0' and sig_write_valid = '1') then
                            
                -- start of bit stuffing control
                if(transmitBitStuffingCounter = 5) then
                
                    transmitNextBit := not sig_TxBitPrev;
                    transmitBitStuffingCounter := 1;
                    
                else
                    transmitPackageCounter := SIZE_OF_DLC - 1;
                    transmitNextBit := transmitFrame.Dlc(transmitPackageCounter);
                    transmitFrameEnum <= DLC;
                    if(sig_TxBitPrev = transmitNextBit) then
                        
                        transmitBitStuffingCounter := transmitBitStuffingCounter + 1;
                    
                    else
                    
                        transmitBitStuffingCounter := 1;
                    
                    end if;
                    
                   CrcNextBit :=  transmitNextBit xor var_CalculatedCrc(14);
                   var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                   var_CalculatedCrc(0) := '0';
                            
                   if (CrcNextBit = '1') then
                       var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                   end if;
                
                end if;
                -- end of bit stuffing control
                sig_TxBitTransmit <= transmitNextBit;
                sig_TxBitPrev <= transmitNextBit;
                
            end if;
        sig_write_validPrev := sig_write_valid;
         
          when DLC =>
            leds <= "1001";
            if(sig_write_validPrev = '0' and sig_write_valid = '1') then
                
                -- start of bit stuffing control
                if(transmitBitStuffingCounter = 5) then
                
                    transmitNextBit := not sig_TxBitPrev;
                    transmitBitStuffingCounter := 1;
                else    
                    if(transmitPackageCounter = 0) then
                        if(transmitFrame.Rtr = '0') then
                            transmitPackageCounter := 7;
                            transmitDataByteCounter := 0;
                            transmitNextBit := transmitFrame.Data(transmitDataByteCounter)(transmitPackageCounter);
                            transmitFrameEnum <= DATA;
                        else
                        
                            transmitPackageCounter := SIZE_OF_CRC - 1;
                            transmitNextBit := var_CalculatedCrc(transmitPackageCounter);
                            transmitFrameEnum <= CRC;
                        
                        end if;
                    else
                        transmitPackageCounter := transmitPackageCounter - 1;
                        transmitNextBit := transmitFrame.Dlc(transmitPackageCounter); 
                     

                     end if;
                  
                     if(sig_TxBitPrev = transmitNextBit) then
                        
                        transmitBitStuffingCounter := transmitBitStuffingCounter + 1;
                        
                     else
                        
                        transmitBitStuffingCounter := 1;
                        
                     end if; 
                     
                     CrcNextBit :=  transmitNextBit xor var_CalculatedCrc(14);
                     var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                     var_CalculatedCrc(0) := '0';
                             
                     if (CrcNextBit = '1') then
                         var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                      end if;
                end if;
                -- end of bit stuffing control
             sig_TxBitPrev <= transmitNextBit;
             sig_TxBitTransmit <= transmitNextBit;
             end if;
         sig_write_validPrev := sig_write_valid;    
         
          when DATA =>
            leds <= "0110";
            if(sig_write_validPrev = '0' and sig_write_valid = '1') then
                
                -- start of bit stuffing control
                if(transmitBitStuffingCounter = 5) then
                
                    transmitNextBit := not sig_TxBitPrev;
                    transmitBitStuffingCounter := 1;
                else
                    if((transmitDataByteCounter = to_integer(unsigned(transmitFrame.Dlc)) - 1) and transmitPackageCounter = 0) then                
                        
                        transmitPackageCounter := SIZE_OF_CRC - 1;
                        transmitNextBit := var_CalculatedCrc(transmitPackageCounter);
                        transmitFrameEnum <= CRC;

                    else
                        if(transmitPackageCounter = 0) then
                        
                            transmitPackageCounter := 7;
                            transmitDataByteCounter := transmitDataByteCounter + 1;
                        
                        else
                        
                            transmitPackageCounter := transmitPackageCounter - 1;
                        
                        end if;
                        
                        transmitNextBit := transmitFrame.Data(transmitDataByteCounter)(transmitPackageCounter);                       
                        
                       CrcNextBit :=  transmitNextBit xor var_CalculatedCrc(14);
                       var_CalculatedCrc(14 downto 1) := var_CalculatedCrc(13 downto 0);
                       var_CalculatedCrc(0) := '0';
                                
                       if (CrcNextBit = '1') then
                           var_CalculatedCrc(14 downto 0) := var_CalculatedCrc(14 downto 0) xor b"100010110011001"; --! CRC-15-CAN: x"4599"
                       end if;
                       

                    end if;
                        if(sig_TxBitPrev = transmitNextBit) then
                        
                            transmitBitStuffingCounter := transmitBitStuffingCounter + 1;
                        
                        else
                        
                            transmitBitStuffingCounter := 1;
                        
                        end if;
                end if;
                -- end of bit stuffing control
             sig_TxBitPrev <= transmitNextBit;
             sig_TxBitTransmit <= transmitNextBit;
             end if;
         sig_write_validPrev := sig_write_valid;  
         
           
         when CRC =>
               leds <= "1010";
                if(sig_write_validPrev = '0' and sig_write_valid = '1') then
                
                -- start of bit stuffing control
                if(transmitBitStuffingCounter = 5) then
                
                    transmitNextBit := not sig_TxBitPrev;
                    transmitBitStuffingCounter := 1;
                else
                    if(transmitPackageCounter = 0) then
                        
                        transmitNextBit := '1';
                        transmitFrameEnum <= CRC_DELIMITER;
                        
                    else
                        transmitPackageCounter := transmitPackageCounter - 1;
                        transmitNextBit := var_CalculatedCrc(transmitPackageCounter);
                        if(sig_TxBitPrev = transmitNextBit) then
                        
                            transmitBitStuffingCounter := transmitBitStuffingCounter + 1;
                        
                        else
                        
                            transmitBitStuffingCounter := 1;
                        
                        end if;
                    end if;
                end if;
                -- end of bit stuffing control
             sig_TxBitPrev <= transmitNextBit;
             sig_TxBitTransmit <= transmitNextBit;
             end if;
         sig_write_validPrev := sig_write_valid;    


         when CRC_DELIMITER =>
            leds <= "1100";
            if(sig_write_validPrev = '0' and sig_write_valid = '1') then

                transmitNextBit := '1';
                transmitFrameEnum <= ACK;
                sig_start_sampleTransmit <= '1';

            end if;
            sig_write_validPrev := sig_write_valid;   
            
           when ACK =>
            leds <= "0111";  
            if(sig_read_validPrevTransmit = '0' and sig_read_valid = '1') then
                
                if(sig_RxBit = '0') then
                
                    sig_TxBitTransmit <= '1';
                    transmitFrameEnum <= ACK_DELIMITER;
                    sig_start_sampleTransmit <= '0';
                    
                else
                    sig_TxBitTransmit <= '1';
                    transmitFrameEnum <= ACK_DELIMITER;
                    sig_start_sampleTransmit <= '0';
                    transmitError <= '1';
                    
                end if;
                
            end if;
           
            sig_read_validPrevTransmit := sig_read_valid; 
        
              when ACK_DELIMITER =>
              leds <= "1101";
               if(sig_write_validPrev = '0' and sig_write_valid = '1') then
                    
                    transmitPackageCounter := SIZE_OF_EOF - 1;
                    sig_TxBitTransmit <= '1';
                    transmitFrameEnum <= EOF;
                                    
               end if;
              sig_write_validPrev := sig_write_valid;      
              
              when EOF =>
                  leds <= "1011";
                    if(sig_write_validPrev = '0' and sig_write_valid = '1') then

                        if(transmitPackageCounter = 0) then
                        
                            transmitPackageCounter := SIZE_OF_IFS - 1;
                            sig_TxBitTransmit <= '1';
                            transmitFrameEnum <= IFS;
                        
                        else
                        
                            transmitPackageCounter := transmitPackageCounter - 1;
                            sig_TxBitTransmit <= '1';
                        
                        end if;
                    
                    end if;
              sig_write_validPrev := sig_write_valid;      
              when IFS =>
                        leds <= "1110";
                        if(sig_write_validPrev = '0' and sig_write_valid = '1') then

                        if(transmitPackageCounter = 0) then
                        
                            sig_TxBitTransmit <= '1';
                            transmitFrameEnum <= IDLE;

                            if(transmitError = '1') then
                            
                               transmitError <= '0';
                                startTransmit <= '1';
                                
                            else
                            
                                startTransmit <= '0';
                                sig_transmitIT <= '0';
                                
                            end if;
                            sig_write_orderTransmit <= '0';
                        else
                            
                            transmitPackageCounter := transmitPackageCounter - 1;
                            sig_TxBitTransmit <= '1';
                            
                        
                        end if;
                      
                    end if;
              sig_write_validPrev := sig_write_valid;
      
        when STUFFING =>
        
        
        when LOCK =>
        
        
              
        end case;
    end if;                
    end process;
    
    end Behavioral;
