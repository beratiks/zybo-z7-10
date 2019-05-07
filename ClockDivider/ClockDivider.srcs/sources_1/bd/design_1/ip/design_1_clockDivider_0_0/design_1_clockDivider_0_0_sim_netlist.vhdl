-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Tue May  7 21:27:42 2019
-- Host        : BERAT running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/github_repository/zybo-z7-10/ClockDivider/ClockDivider.srcs/sources_1/bd/design_1/ip/design_1_clockDivider_0_0/design_1_clockDivider_0_0_sim_netlist.vhdl
-- Design      : design_1_clockDivider_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_clockDivider_0_0_clockDivider is
  port (
    led : out STD_LOGIC_VECTOR ( 0 to 0 );
    sys_clk_pin : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_clockDivider_0_0_clockDivider : entity is "clockDivider";
end design_1_clockDivider_0_0_clockDivider;

architecture STRUCTURE of design_1_clockDivider_0_0_clockDivider is
  signal data0 : STD_LOGIC_VECTOR ( 25 downto 1 );
  signal diveder : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal \diveder0_carry__0_n_0\ : STD_LOGIC;
  signal \diveder0_carry__0_n_1\ : STD_LOGIC;
  signal \diveder0_carry__0_n_2\ : STD_LOGIC;
  signal \diveder0_carry__0_n_3\ : STD_LOGIC;
  signal \diveder0_carry__1_n_0\ : STD_LOGIC;
  signal \diveder0_carry__1_n_1\ : STD_LOGIC;
  signal \diveder0_carry__1_n_2\ : STD_LOGIC;
  signal \diveder0_carry__1_n_3\ : STD_LOGIC;
  signal \diveder0_carry__2_n_0\ : STD_LOGIC;
  signal \diveder0_carry__2_n_1\ : STD_LOGIC;
  signal \diveder0_carry__2_n_2\ : STD_LOGIC;
  signal \diveder0_carry__2_n_3\ : STD_LOGIC;
  signal \diveder0_carry__3_n_0\ : STD_LOGIC;
  signal \diveder0_carry__3_n_1\ : STD_LOGIC;
  signal \diveder0_carry__3_n_2\ : STD_LOGIC;
  signal \diveder0_carry__3_n_3\ : STD_LOGIC;
  signal \diveder0_carry__4_n_0\ : STD_LOGIC;
  signal \diveder0_carry__4_n_1\ : STD_LOGIC;
  signal \diveder0_carry__4_n_2\ : STD_LOGIC;
  signal \diveder0_carry__4_n_3\ : STD_LOGIC;
  signal diveder0_carry_n_0 : STD_LOGIC;
  signal diveder0_carry_n_1 : STD_LOGIC;
  signal diveder0_carry_n_2 : STD_LOGIC;
  signal diveder0_carry_n_3 : STD_LOGIC;
  signal diveder_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^led\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal temporary : STD_LOGIC;
  signal temporary_i_1_n_0 : STD_LOGIC;
  signal temporary_i_2_n_0 : STD_LOGIC;
  signal temporary_i_3_n_0 : STD_LOGIC;
  signal temporary_i_4_n_0 : STD_LOGIC;
  signal temporary_i_5_n_0 : STD_LOGIC;
  signal temporary_i_6_n_0 : STD_LOGIC;
  signal temporary_i_7_n_0 : STD_LOGIC;
  signal temporary_i_8_n_0 : STD_LOGIC;
  signal \NLW_diveder0_carry__5_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_diveder0_carry__5_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
begin
  led(0) <= \^led\(0);
diveder0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => diveder0_carry_n_0,
      CO(2) => diveder0_carry_n_1,
      CO(1) => diveder0_carry_n_2,
      CO(0) => diveder0_carry_n_3,
      CYINIT => diveder(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(4 downto 1),
      S(3 downto 0) => diveder(4 downto 1)
    );
\diveder0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => diveder0_carry_n_0,
      CO(3) => \diveder0_carry__0_n_0\,
      CO(2) => \diveder0_carry__0_n_1\,
      CO(1) => \diveder0_carry__0_n_2\,
      CO(0) => \diveder0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(8 downto 5),
      S(3 downto 0) => diveder(8 downto 5)
    );
\diveder0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \diveder0_carry__0_n_0\,
      CO(3) => \diveder0_carry__1_n_0\,
      CO(2) => \diveder0_carry__1_n_1\,
      CO(1) => \diveder0_carry__1_n_2\,
      CO(0) => \diveder0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(12 downto 9),
      S(3 downto 0) => diveder(12 downto 9)
    );
\diveder0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \diveder0_carry__1_n_0\,
      CO(3) => \diveder0_carry__2_n_0\,
      CO(2) => \diveder0_carry__2_n_1\,
      CO(1) => \diveder0_carry__2_n_2\,
      CO(0) => \diveder0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(16 downto 13),
      S(3 downto 0) => diveder(16 downto 13)
    );
\diveder0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \diveder0_carry__2_n_0\,
      CO(3) => \diveder0_carry__3_n_0\,
      CO(2) => \diveder0_carry__3_n_1\,
      CO(1) => \diveder0_carry__3_n_2\,
      CO(0) => \diveder0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(20 downto 17),
      S(3 downto 0) => diveder(20 downto 17)
    );
\diveder0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \diveder0_carry__3_n_0\,
      CO(3) => \diveder0_carry__4_n_0\,
      CO(2) => \diveder0_carry__4_n_1\,
      CO(1) => \diveder0_carry__4_n_2\,
      CO(0) => \diveder0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(24 downto 21),
      S(3 downto 0) => diveder(24 downto 21)
    );
\diveder0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \diveder0_carry__4_n_0\,
      CO(3 downto 0) => \NLW_diveder0_carry__5_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_diveder0_carry__5_O_UNCONNECTED\(3 downto 1),
      O(0) => data0(25),
      S(3 downto 1) => B"000",
      S(0) => diveder(25)
    );
\diveder[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => diveder(0),
      O => diveder_0(0)
    );
\diveder[25]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => temporary_i_2_n_0,
      O => temporary
    );
\diveder_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => diveder_0(0),
      Q => diveder(0),
      R => '0'
    );
\diveder_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(10),
      Q => diveder(10),
      R => temporary
    );
\diveder_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(11),
      Q => diveder(11),
      R => temporary
    );
\diveder_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(12),
      Q => diveder(12),
      R => temporary
    );
\diveder_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(13),
      Q => diveder(13),
      R => temporary
    );
\diveder_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(14),
      Q => diveder(14),
      R => temporary
    );
\diveder_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(15),
      Q => diveder(15),
      R => temporary
    );
\diveder_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(16),
      Q => diveder(16),
      R => temporary
    );
\diveder_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(17),
      Q => diveder(17),
      R => temporary
    );
\diveder_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(18),
      Q => diveder(18),
      R => temporary
    );
\diveder_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(19),
      Q => diveder(19),
      R => temporary
    );
\diveder_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(1),
      Q => diveder(1),
      R => temporary
    );
\diveder_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(20),
      Q => diveder(20),
      R => temporary
    );
\diveder_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(21),
      Q => diveder(21),
      R => temporary
    );
\diveder_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(22),
      Q => diveder(22),
      R => temporary
    );
\diveder_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(23),
      Q => diveder(23),
      R => temporary
    );
\diveder_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(24),
      Q => diveder(24),
      R => temporary
    );
\diveder_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(25),
      Q => diveder(25),
      R => temporary
    );
\diveder_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(2),
      Q => diveder(2),
      R => temporary
    );
\diveder_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(3),
      Q => diveder(3),
      R => temporary
    );
\diveder_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(4),
      Q => diveder(4),
      R => temporary
    );
\diveder_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(5),
      Q => diveder(5),
      R => temporary
    );
\diveder_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(6),
      Q => diveder(6),
      R => temporary
    );
\diveder_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(7),
      Q => diveder(7),
      R => temporary
    );
\diveder_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(8),
      Q => diveder(8),
      R => temporary
    );
\diveder_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clk_pin,
      CE => '1',
      D => data0(9),
      Q => diveder(9),
      R => temporary
    );
temporary_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => temporary_i_2_n_0,
      I1 => \^led\(0),
      O => temporary_i_1_n_0
    );
temporary_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => temporary_i_3_n_0,
      I1 => temporary_i_4_n_0,
      I2 => temporary_i_5_n_0,
      I3 => temporary_i_6_n_0,
      I4 => temporary_i_7_n_0,
      I5 => temporary_i_8_n_0,
      O => temporary_i_2_n_0
    );
temporary_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFDF"
    )
        port map (
      I0 => diveder(15),
      I1 => diveder(14),
      I2 => diveder(16),
      I3 => diveder(17),
      O => temporary_i_3_n_0
    );
temporary_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFFF"
    )
        port map (
      I0 => diveder(19),
      I1 => diveder(18),
      I2 => diveder(21),
      I3 => diveder(20),
      O => temporary_i_4_n_0
    );
temporary_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
        port map (
      I0 => diveder(7),
      I1 => diveder(6),
      I2 => diveder(9),
      I3 => diveder(8),
      O => temporary_i_5_n_0
    );
temporary_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF7F"
    )
        port map (
      I0 => diveder(11),
      I1 => diveder(10),
      I2 => diveder(13),
      I3 => diveder(12),
      O => temporary_i_6_n_0
    );
temporary_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF7F"
    )
        port map (
      I0 => diveder(3),
      I1 => diveder(2),
      I2 => diveder(4),
      I3 => diveder(5),
      O => temporary_i_7_n_0
    );
temporary_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7FFFFFFFFFFFFFF"
    )
        port map (
      I0 => diveder(24),
      I1 => diveder(25),
      I2 => diveder(22),
      I3 => diveder(23),
      I4 => diveder(1),
      I5 => diveder(0),
      O => temporary_i_8_n_0
    );
temporary_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => sys_clk_pin,
      CE => '1',
      D => temporary_i_1_n_0,
      Q => \^led\(0),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_clockDivider_0_0 is
  port (
    sys_clk_pin : in STD_LOGIC;
    led : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_clockDivider_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_clockDivider_0_0 : entity is "design_1_clockDivider_0_0,clockDivider,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_clockDivider_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_clockDivider_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_clockDivider_0_0 : entity is "clockDivider,Vivado 2018.3";
end design_1_clockDivider_0_0;

architecture STRUCTURE of design_1_clockDivider_0_0 is
  signal \^led\ : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  led(3) <= \^led\(0);
  led(2) <= \^led\(0);
  led(1) <= \^led\(0);
  led(0) <= \^led\(0);
U0: entity work.design_1_clockDivider_0_0_clockDivider
     port map (
      led(0) => \^led\(0),
      sys_clk_pin => sys_clk_pin
    );
end STRUCTURE;
