-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May  5 22:24:44 2019
-- Host        : BERAT running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/github_repository/zybo-z10/debounceButton/debounceButton.srcs/sources_1/bd/Mydesign/ip/Mydesign_buttonController_0_0/Mydesign_buttonController_0_0_sim_netlist.vhdl
-- Design      : Mydesign_buttonController_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Mydesign_buttonController_0_0 is
  port (
    btn : in STD_LOGIC;
    getButton : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Mydesign_buttonController_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Mydesign_buttonController_0_0 : entity is "Mydesign_buttonController_0_0,buttonController,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of Mydesign_buttonController_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of Mydesign_buttonController_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of Mydesign_buttonController_0_0 : entity is "buttonController,Vivado 2018.3";
end Mydesign_buttonController_0_0;

architecture STRUCTURE of Mydesign_buttonController_0_0 is
  signal \^btn\ : STD_LOGIC;
begin
  \^btn\ <= btn;
  getButton <= \^btn\;
end STRUCTURE;
