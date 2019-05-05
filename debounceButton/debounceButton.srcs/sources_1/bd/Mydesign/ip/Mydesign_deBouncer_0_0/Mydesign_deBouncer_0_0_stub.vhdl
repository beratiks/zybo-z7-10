-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May  5 22:24:44 2019
-- Host        : BERAT running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/github_repository/zybo-z10/debounceButton/debounceButton.srcs/sources_1/bd/Mydesign/ip/Mydesign_deBouncer_0_0/Mydesign_deBouncer_0_0_stub.vhdl
-- Design      : Mydesign_deBouncer_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mydesign_deBouncer_0_0 is
  Port ( 
    setLed : out STD_LOGIC;
    getButton : in STD_LOGIC
  );

end Mydesign_deBouncer_0_0;

architecture stub of Mydesign_deBouncer_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "setLed,getButton";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "deBouncer,Vivado 2018.3";
begin
end;
