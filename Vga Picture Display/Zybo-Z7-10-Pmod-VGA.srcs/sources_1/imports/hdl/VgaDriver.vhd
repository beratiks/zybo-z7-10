----------------------------------------------------------------------------------
-- Company: Digilent
-- Engineer: Arthur Brown, Sam Bobrowicz
-- 
--
-- Create Date:    13:01:51 02/15/2013 
-- Project Name:   pmodvga
-- Tool versions:  2016.4
-- Additional Comments: 
--
-- Copyright Digilent 2017zz
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VgaDriver is
    Port  ( 
           clock_in : in  STD_LOGIC;
           vga_hs_out : out  STD_LOGIC;
           vga_vs_out : out  STD_LOGIC;
           vga_red_out : out  STD_LOGIC_VECTOR (3 downto 0);
           vga_blue_out : out  STD_LOGIC_VECTOR (3 downto 0);
           vga_green_out : out  STD_LOGIC_VECTOR (3 downto 0);
           
           in_red : in STD_LOGIC_VECTOR (3 downto 0);
           in_blue : in STD_LOGIC_VECTOR (3 downto 0);
           in_green : in STD_LOGIC_VECTOR (3 downto 0);
           refreshPixel : out STD_LOGIC;
           pixel_clock : out STD_LOGIC;
           
           h_cntr_reg : out std_logic_vector(11 downto 0);
           v_cntr_reg : out std_logic_vector(11 downto 0)
           );
end VgaDriver;

architecture Behavioral of VgaDriver is

component clk_wiz_0
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic
 );
end component;

--Sync Generation constants

--***1920x1080@60Hz***-- Requires 148.5 MHz pxl_clk
constant FRAME_WIDTH : natural := 1920;
constant FRAME_HEIGHT : natural := 1080;

constant H_FP : natural := 88; --H front porch width (pixels)
constant H_PW : natural := 44; --H sync pulse width (pixels)
constant H_MAX : natural := 2200; --H total period (pixels)

constant V_FP : natural := 4; --V front porch width (lines)
constant V_PW : natural := 5; --V sync pulse width (lines)
constant V_MAX : natural := 1125; --V total period (lines)

constant H_POL : std_logic := '1';
constant V_POL : std_logic := '1';

signal pxl_clk : std_logic;
signal active : std_logic;

signal sig_h_cntr_reg : std_logic_vector(11 downto 0) := (others =>'0');
signal sig_v_cntr_reg : std_logic_vector(11 downto 0) := (others =>'0');

signal h_sync_reg : std_logic := not(H_POL);
signal v_sync_reg : std_logic := not(V_POL);

signal h_sync_dly_reg : std_logic := not(H_POL);
signal v_sync_dly_reg : std_logic :=  not(V_POL);

signal vga_red_outed_reg : std_logic_vector(3 downto 0) := (others =>'0');
signal vga_green_outreen_reg : std_logic_vector(3 downto 0) := (others =>'0');
signal vga_blue_outlue_reg : std_logic_vector(3 downto 0) := (others =>'0');

signal vga_red_outed : std_logic_vector(3 downto 0);
signal vga_green_outreen : std_logic_vector(3 downto 0);
signal vga_blue_outlue : std_logic_vector(3 downto 0);

signal sig_in_Red : std_logic_vector(3 downto 0);
signal sig_in_Blue : std_logic_vector(3 downto 0);
signal sig_in_Green : std_logic_vector(3 downto 0);

signal sig_refreshPixel : std_logic := '0';

begin

sig_in_Red <= in_red;
sig_in_Blue <= in_blue;
sig_in_Green <= in_green;
pixel_clock <= pxl_clk;
   
clk_div_inst : clk_wiz_0
  port map
   (-- Clock in ports
 
    CLK_IN1 => clock_in,
    -- Clock out ports
    CLK_OUT1 => pxl_clk);
    
    
    vga_red_outed <=   
                       sig_in_Red    when ( active = '1' ) else
                       (others=>'0');  
                  
    vga_blue_outlue <= 
                       sig_in_Blue          when ( active = '1') else
                       (others=>'0');  
                
    vga_green_outreen <= 
                       sig_in_Green    when ( active = '1' ) else
                       (others=>'0');  
                       
    sig_refreshPixel   <= active;

 process (pxl_clk)
  begin
    if (rising_edge(pxl_clk)) then
      if (sig_h_cntr_reg = (H_MAX - 1)) then
        sig_h_cntr_reg <= (others =>'0');
      else
        sig_h_cntr_reg <= sig_h_cntr_reg + 1;
      end if;
    end if;
  end process;

  process (pxl_clk)
  begin
    if (rising_edge(pxl_clk)) then
      if ((sig_h_cntr_reg = (H_MAX - 1)) and (sig_v_cntr_reg = (V_MAX - 1))) then
        sig_v_cntr_reg <= (others =>'0');
      elsif (sig_h_cntr_reg = (H_MAX - 1)) then
        sig_v_cntr_reg <= sig_v_cntr_reg + 1;
      end if;
    end if;
  end process;
  
    process (pxl_clk)
  begin
    if (rising_edge(pxl_clk)) then
      if (sig_h_cntr_reg >= (H_FP + FRAME_WIDTH - 1)) and (sig_h_cntr_reg < (H_FP + FRAME_WIDTH + H_PW - 1)) then
        h_sync_reg <= H_POL;
      else
        h_sync_reg <= not(H_POL);
      end if;
    end if;
  end process;
  
  
  process (pxl_clk)
  begin
    if (rising_edge(pxl_clk)) then
      if (sig_v_cntr_reg >= (V_FP + FRAME_HEIGHT - 1)) and (sig_v_cntr_reg < (V_FP + FRAME_HEIGHT + V_PW - 1)) then
        v_sync_reg <= V_POL;
      else
        v_sync_reg <= not(V_POL);
      end if;
    end if;
  end process;
  
  
  active <= '1' when ((sig_h_cntr_reg < FRAME_WIDTH) and (sig_v_cntr_reg < FRAME_HEIGHT))else
            '0';
            
  process (pxl_clk)
            begin
              if (rising_edge(pxl_clk)) then
                v_sync_dly_reg <= v_sync_reg;
                h_sync_dly_reg <= h_sync_reg;
                vga_red_outed_reg <= vga_red_outed;
                vga_green_outreen_reg <= vga_green_outreen;
                vga_blue_outlue_reg <= vga_blue_outlue;
              end if;
            end process;


  vga_hs_out <= h_sync_dly_reg;
  vga_vs_out <= v_sync_dly_reg;
  vga_red_out <= vga_red_outed_reg;
  vga_green_out <= vga_green_outreen_reg;
  vga_blue_out <= vga_blue_outlue_reg;
  refreshPixel <= sig_refreshPixel;
  h_cntr_reg <= sig_h_cntr_reg;
  v_cntr_reg <= sig_v_cntr_reg;
  
end Behavioral;
