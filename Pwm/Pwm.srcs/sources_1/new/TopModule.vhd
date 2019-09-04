----------------------------------------------------------------------------------
-- Engineer: Berat YILDIZ
-- e-mail : yildizberat@gmail.com
-- Create Date: 09/05/2019 12:37:51 AM
-- Design Name: 
-- Module Name: TopModule - Behavioral
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

entity TopModule is
    Port ( 
           sys_clock : in STD_LOGIC;        -- system clock 125mhz
           btn : in STD_LOGIC_VECTOR (3 downto 0);  --buttons vector
           sw : in STD_LOGIC_VECTOR (3 downto 0);   -- sw vector
           led6_r : out std_logic;                  -- rgb's red led
           led6_g : out std_logic;                  -- rgb's green led
           led6_b : out std_logic                   -- rgb's blue led
           );
end TopModule;

architecture Behavioral of TopModule is

component buttonDebouncerModule is
    Port ( clk_in : in STD_LOGIC;
           pin_in : in STD_LOGIC;
           pinState : out STD_LOGIC);
end component buttonDebouncerModule;

component PwmModule is
    generic
    (
        SYS_CLOCK_HZ : integer := 125e6
    );
    Port (
           main_clock : in STD_LOGIC;   
           frequency  : in integer range 0 to 125000000;    
           pwm_pin : out STD_LOGIC;     
           duty : in integer range 0 to 100;    
           startPwm : in STD_LOGIC;             
           stopPwm : in STD_LOGIC               
           );
end component PwmModule;


-- definition of signals
signal sw_0_PinState : std_logic;
signal sw_1_PinState : std_logic;
signal sw_2_PinState : std_logic;

signal btn_0_PinState : std_logic;
signal btn_1_PinState : std_logic;
signal btn_2_PinState : std_logic;

signal btn_0_PinState_prev : std_logic;
signal btn_1_PinState_prev : std_logic;
signal btn_2_PinState_prev : std_logic;

signal ledsFrequency : integer := 200;

signal led_r_duty : integer := 0;
signal led_g_duty : integer := 0;
signal led_b_duty : integer := 0;

signal sig_startPwm_led_r : std_logic := '0';
signal sig_startPwm_led_g : std_logic := '0';
signal sig_startPwm_led_b : std_logic := '0';

signal sig_stopPwm_led_r : std_logic := '0';
signal sig_stopPwm_led_g : std_logic := '0';
signal sig_stopPwm_led_b : std_logic := '0';


begin

sw0Debouncer : buttonDebouncerModule port map
( 
        clk_in => sys_clock,
        pin_in => sw(0),
        pinState => sw_0_PinState
);

sw1Debouncer : buttonDebouncerModule port map
( 
        clk_in => sys_clock,
        pin_in => sw(1),
        pinState => sw_1_PinState
);

sw2Debouncer : buttonDebouncerModule port map
( 
        clk_in => sys_clock,
        pin_in => sw(2),
        pinState => sw_2_PinState
);

btn0Debouncer : buttonDebouncerModule port map
( 
        clk_in => sys_clock,
        pin_in => btn(0),
        pinState => btn_0_PinState
);

btn1Debouncer : buttonDebouncerModule port map
( 
        clk_in => sys_clock,
        pin_in => btn(1),
        pinState => btn_1_PinState
);

btn2Debouncer : buttonDebouncerModule port map
( 
        clk_in => sys_clock,
        pin_in => btn(2),
        pinState => btn_2_PinState
);

led_r_pwm : PwmModule port map
(
    main_clock => sys_clock,
    frequency  => ledsFrequency,   
    pwm_pin => led6_r,
    duty  => led_r_duty,
    startPwm => sig_startPwm_led_r, 
    stopPwm  => sig_stopPwm_led_r
);

led_g_pwm : PwmModule port map
(
    main_clock => sys_clock,
    frequency  => ledsFrequency,   
    pwm_pin => led6_g,
    duty  => led_g_duty,
    startPwm => sig_startPwm_led_g, 
    stopPwm  => sig_stopPwm_led_g
);

led_b_pwm : PwmModule port map
(
    main_clock => sys_clock,
    frequency  => ledsFrequency,   
    pwm_pin => led6_b,
    duty  => led_b_duty,
    startPwm => sig_startPwm_led_b, 
    stopPwm  => sig_stopPwm_led_b
);

mainProc : process(sys_clock)
begin

    if(rising_edge(sys_clock)) then
    
        if(sw_0_PinState = '1') then
        
            sig_startPwm_led_r <= '1';
            sig_stopPwm_led_r <= '0';
        
        else
        
            sig_startPwm_led_r <= '0';
            sig_stopPwm_led_r <= '1';
        
        end if;
        
        if(sw_1_PinState = '1') then
        
            sig_startPwm_led_g <= '1';
            sig_stopPwm_led_g <= '0';
        
        else
        
            sig_startPwm_led_g <= '0';
            sig_stopPwm_led_g <= '1';
        
        end if;
        
        if(sw_2_PinState = '1') then
        
            sig_startPwm_led_b <= '1';
            sig_stopPwm_led_b <= '0';
        
        else
        
            sig_startPwm_led_b <= '0';
            sig_stopPwm_led_b <= '1';
        
        end if;
        
        if(btn_0_PinState_prev = '0' and btn_0_PinState = '1') then
        
            if(led_r_duty > 100) then
            
                led_r_duty <= 0;
            
            else
            
            led_r_duty <= led_r_duty + 10;
            
            end if;
        end if;
        btn_0_PinState_prev <= btn_0_PinState;
        
        if(btn_1_PinState_prev = '0' and btn_1_PinState = '1') then
        
            if(led_g_duty > 100) then
            
                led_g_duty <= 0;
            
            else
            
            led_g_duty <= led_g_duty + 10;
            
            end if;
        end if;
        btn_1_PinState_prev <= btn_1_PinState;
        
        if(btn_2_PinState_prev = '0' and btn_2_PinState = '1') then
        
            if(led_b_duty > 100) then
            
                led_b_duty <= 0;
            
            else
            
            led_b_duty <= led_b_duty + 10;
            
            end if;
        end if;
        btn_2_PinState_prev <= btn_2_PinState;
    
    end if;

end process;

end Behavioral;
