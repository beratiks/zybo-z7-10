-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Tue May  7 21:27:42 2019
-- Host        : BERAT running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/github_repository/zybo-z7-10/ClockDivider/ClockDivider.srcs/sources_1/bd/design_1/ip/design_1_clockDivider_0_0/design_1_clockDivider_0_0_stub.vhdl
-- Design      : design_1_clockDivider_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_clockDivider_0_0 is
  Port ( 
    sys_clk_pin : in STD_LOGIC;
    led : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end design_1_clockDivider_0_0;

architecture stub of design_1_clockDivider_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "sys_clk_pin,led[3:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "clockDivider,Vivado 2018.3";
begin
end;