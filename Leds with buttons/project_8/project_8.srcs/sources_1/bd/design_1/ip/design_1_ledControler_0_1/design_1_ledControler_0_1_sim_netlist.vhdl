-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May  5 19:56:00 2019
-- Host        : BERAT running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/zybo-z10_workspace/project_8/project_8.srcs/sources_1/bd/design_1/ip/design_1_ledControler_0_1/design_1_ledControler_0_1_sim_netlist.vhdl
-- Design      : design_1_ledControler_0_1
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_ledControler_0_1 is
  port (
    led : out STD_LOGIC_VECTOR ( 3 downto 0 );
    setLed : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_ledControler_0_1 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_ledControler_0_1 : entity is "design_1_ledControler_0_1,ledControler,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_ledControler_0_1 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_ledControler_0_1 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_ledControler_0_1 : entity is "ledControler,Vivado 2018.3";
end design_1_ledControler_0_1;

architecture STRUCTURE of design_1_ledControler_0_1 is
  signal \^setled\ : STD_LOGIC_VECTOR ( 3 downto 0 );
begin
  \^setled\(3 downto 0) <= setLed(3 downto 0);
  led(3 downto 0) <= \^setled\(3 downto 0);
end STRUCTURE;
