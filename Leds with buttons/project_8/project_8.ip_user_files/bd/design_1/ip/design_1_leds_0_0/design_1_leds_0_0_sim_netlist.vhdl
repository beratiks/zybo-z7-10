-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May  5 03:05:57 2019
-- Host        : BERAT running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/zybo-z10_workspace/project_8/project_8.srcs/sources_1/bd/design_1/ip/design_1_leds_0_0/design_1_leds_0_0_sim_netlist.vhdl
-- Design      : design_1_leds_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_leds_0_0_leds is
  port (
    led : out STD_LOGIC_VECTOR ( 1 downto 0 );
    sys_clock : in STD_LOGIC;
    clock : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_leds_0_0_leds : entity is "leds";
end design_1_leds_0_0_leds;

architecture STRUCTURE of design_1_leds_0_0_leds is
  signal clear : STD_LOGIC;
  signal \counter2[0]_i_3_n_0\ : STD_LOGIC;
  signal counter2_reg : STD_LOGIC_VECTOR ( 21 downto 0 );
  signal \counter2_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \counter2_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \counter2_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \counter2_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \counter2_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \counter2_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \counter2_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \counter2_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \counter2_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \counter2_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \counter2_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \counter2_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \counter2_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \counter2_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \counter2_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \counter2_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \counter2_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \counter2_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \counter2_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \counter2_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \counter2_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \counter2_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \counter2_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \counter2_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \counter2_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \counter2_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \counter2_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \counter2_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \counter2_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \counter2_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \counter2_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \counter2_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \counter2_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \counter2_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \counter2_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \counter2_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \counter2_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \counter2_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \counter2_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \counter2_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \counter2_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \counter2_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \counter2_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \counter[0]_i_3_n_0\ : STD_LOGIC;
  signal \counter[0]_i_4_n_0\ : STD_LOGIC;
  signal \counter[0]_i_5_n_0\ : STD_LOGIC;
  signal \counter[0]_i_6_n_0\ : STD_LOGIC;
  signal counter_reg : STD_LOGIC_VECTOR ( 26 downto 0 );
  signal \counter_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \counter_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \counter_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \counter_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \counter_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \counter_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \counter_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \counter_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \counter_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \counter_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \counter_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \counter_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \counter_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \counter_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \counter_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \counter_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \counter_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \counter_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \counter_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \counter_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \counter_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \counter_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \counter_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \counter_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \counter_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \counter_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \counter_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \counter_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \counter_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \counter_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \counter_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \counter_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \counter_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \counter_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \counter_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \counter_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \counter_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \counter_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \counter_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \counter_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \counter_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \counter_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \counter_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \counter_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \counter_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \counter_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \counter_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \counter_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \counter_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \counter_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \counter_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \counter_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \counter_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal eqOp : STD_LOGIC;
  signal \^led\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ledState : STD_LOGIC;
  signal ledState_i_1_n_0 : STD_LOGIC;
  signal \led[0]_i_1_n_0\ : STD_LOGIC;
  signal \led[0]_i_2_n_0\ : STD_LOGIC;
  signal \led[0]_i_3_n_0\ : STD_LOGIC;
  signal \led[0]_i_4_n_0\ : STD_LOGIC;
  signal \led[0]_i_5_n_0\ : STD_LOGIC;
  signal \led[3]_i_1_n_0\ : STD_LOGIC;
  signal \led[3]_i_2_n_0\ : STD_LOGIC;
  signal \led[3]_i_3_n_0\ : STD_LOGIC;
  signal \led[3]_i_4_n_0\ : STD_LOGIC;
  signal \NLW_counter2_reg[20]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_counter2_reg[20]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_counter_reg[24]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_counter_reg[24]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
begin
  led(1 downto 0) <= \^led\(1 downto 0);
\counter2[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => \led[0]_i_2_n_0\,
      I1 => \led[0]_i_3_n_0\,
      I2 => \led[0]_i_4_n_0\,
      I3 => \led[0]_i_5_n_0\,
      O => clear
    );
\counter2[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => counter2_reg(0),
      O => \counter2[0]_i_3_n_0\
    );
\counter2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[0]_i_2_n_7\,
      Q => counter2_reg(0),
      R => clear
    );
\counter2_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \counter2_reg[0]_i_2_n_0\,
      CO(2) => \counter2_reg[0]_i_2_n_1\,
      CO(1) => \counter2_reg[0]_i_2_n_2\,
      CO(0) => \counter2_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \counter2_reg[0]_i_2_n_4\,
      O(2) => \counter2_reg[0]_i_2_n_5\,
      O(1) => \counter2_reg[0]_i_2_n_6\,
      O(0) => \counter2_reg[0]_i_2_n_7\,
      S(3 downto 1) => counter2_reg(3 downto 1),
      S(0) => \counter2[0]_i_3_n_0\
    );
\counter2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[8]_i_1_n_5\,
      Q => counter2_reg(10),
      R => clear
    );
\counter2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[8]_i_1_n_4\,
      Q => counter2_reg(11),
      R => clear
    );
\counter2_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[12]_i_1_n_7\,
      Q => counter2_reg(12),
      R => clear
    );
\counter2_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter2_reg[8]_i_1_n_0\,
      CO(3) => \counter2_reg[12]_i_1_n_0\,
      CO(2) => \counter2_reg[12]_i_1_n_1\,
      CO(1) => \counter2_reg[12]_i_1_n_2\,
      CO(0) => \counter2_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \counter2_reg[12]_i_1_n_4\,
      O(2) => \counter2_reg[12]_i_1_n_5\,
      O(1) => \counter2_reg[12]_i_1_n_6\,
      O(0) => \counter2_reg[12]_i_1_n_7\,
      S(3 downto 0) => counter2_reg(15 downto 12)
    );
\counter2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[12]_i_1_n_6\,
      Q => counter2_reg(13),
      R => clear
    );
\counter2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[12]_i_1_n_5\,
      Q => counter2_reg(14),
      R => clear
    );
\counter2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[12]_i_1_n_4\,
      Q => counter2_reg(15),
      R => clear
    );
\counter2_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[16]_i_1_n_7\,
      Q => counter2_reg(16),
      R => clear
    );
\counter2_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter2_reg[12]_i_1_n_0\,
      CO(3) => \counter2_reg[16]_i_1_n_0\,
      CO(2) => \counter2_reg[16]_i_1_n_1\,
      CO(1) => \counter2_reg[16]_i_1_n_2\,
      CO(0) => \counter2_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \counter2_reg[16]_i_1_n_4\,
      O(2) => \counter2_reg[16]_i_1_n_5\,
      O(1) => \counter2_reg[16]_i_1_n_6\,
      O(0) => \counter2_reg[16]_i_1_n_7\,
      S(3 downto 0) => counter2_reg(19 downto 16)
    );
\counter2_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[16]_i_1_n_6\,
      Q => counter2_reg(17),
      R => clear
    );
\counter2_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[16]_i_1_n_5\,
      Q => counter2_reg(18),
      R => clear
    );
\counter2_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[16]_i_1_n_4\,
      Q => counter2_reg(19),
      R => clear
    );
\counter2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[0]_i_2_n_6\,
      Q => counter2_reg(1),
      R => clear
    );
\counter2_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[20]_i_1_n_7\,
      Q => counter2_reg(20),
      R => clear
    );
\counter2_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter2_reg[16]_i_1_n_0\,
      CO(3 downto 1) => \NLW_counter2_reg[20]_i_1_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \counter2_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 2) => \NLW_counter2_reg[20]_i_1_O_UNCONNECTED\(3 downto 2),
      O(1) => \counter2_reg[20]_i_1_n_6\,
      O(0) => \counter2_reg[20]_i_1_n_7\,
      S(3 downto 2) => B"00",
      S(1 downto 0) => counter2_reg(21 downto 20)
    );
\counter2_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[20]_i_1_n_6\,
      Q => counter2_reg(21),
      R => clear
    );
\counter2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[0]_i_2_n_5\,
      Q => counter2_reg(2),
      R => clear
    );
\counter2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[0]_i_2_n_4\,
      Q => counter2_reg(3),
      R => clear
    );
\counter2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[4]_i_1_n_7\,
      Q => counter2_reg(4),
      R => clear
    );
\counter2_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter2_reg[0]_i_2_n_0\,
      CO(3) => \counter2_reg[4]_i_1_n_0\,
      CO(2) => \counter2_reg[4]_i_1_n_1\,
      CO(1) => \counter2_reg[4]_i_1_n_2\,
      CO(0) => \counter2_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \counter2_reg[4]_i_1_n_4\,
      O(2) => \counter2_reg[4]_i_1_n_5\,
      O(1) => \counter2_reg[4]_i_1_n_6\,
      O(0) => \counter2_reg[4]_i_1_n_7\,
      S(3 downto 0) => counter2_reg(7 downto 4)
    );
\counter2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[4]_i_1_n_6\,
      Q => counter2_reg(5),
      R => clear
    );
\counter2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[4]_i_1_n_5\,
      Q => counter2_reg(6),
      R => clear
    );
\counter2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[4]_i_1_n_4\,
      Q => counter2_reg(7),
      R => clear
    );
\counter2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[8]_i_1_n_7\,
      Q => counter2_reg(8),
      R => clear
    );
\counter2_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter2_reg[4]_i_1_n_0\,
      CO(3) => \counter2_reg[8]_i_1_n_0\,
      CO(2) => \counter2_reg[8]_i_1_n_1\,
      CO(1) => \counter2_reg[8]_i_1_n_2\,
      CO(0) => \counter2_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \counter2_reg[8]_i_1_n_4\,
      O(2) => \counter2_reg[8]_i_1_n_5\,
      O(1) => \counter2_reg[8]_i_1_n_6\,
      O(0) => \counter2_reg[8]_i_1_n_7\,
      S(3 downto 0) => counter2_reg(11 downto 8)
    );
\counter2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \counter2_reg[8]_i_1_n_6\,
      Q => counter2_reg(9),
      R => clear
    );
\counter[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000000000000000"
    )
        port map (
      I0 => counter_reg(0),
      I1 => \counter[0]_i_3_n_0\,
      I2 => \counter[0]_i_4_n_0\,
      I3 => \led[3]_i_4_n_0\,
      I4 => \counter[0]_i_5_n_0\,
      I5 => \led[3]_i_3_n_0\,
      O => eqOp
    );
\counter[0]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => counter_reg(1),
      I1 => counter_reg(2),
      O => \counter[0]_i_3_n_0\
    );
\counter[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
        port map (
      I0 => counter_reg(6),
      I1 => counter_reg(5),
      I2 => counter_reg(3),
      I3 => counter_reg(4),
      I4 => counter_reg(7),
      I5 => counter_reg(8),
      O => \counter[0]_i_4_n_0\
    );
\counter[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000800000000"
    )
        port map (
      I0 => counter_reg(11),
      I1 => counter_reg(12),
      I2 => counter_reg(9),
      I3 => counter_reg(10),
      I4 => counter_reg(13),
      I5 => counter_reg(14),
      O => \counter[0]_i_5_n_0\
    );
\counter[0]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => counter_reg(0),
      O => \counter[0]_i_6_n_0\
    );
\counter_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[0]_i_2_n_7\,
      Q => counter_reg(0),
      R => eqOp
    );
\counter_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \counter_reg[0]_i_2_n_0\,
      CO(2) => \counter_reg[0]_i_2_n_1\,
      CO(1) => \counter_reg[0]_i_2_n_2\,
      CO(0) => \counter_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \counter_reg[0]_i_2_n_4\,
      O(2) => \counter_reg[0]_i_2_n_5\,
      O(1) => \counter_reg[0]_i_2_n_6\,
      O(0) => \counter_reg[0]_i_2_n_7\,
      S(3 downto 1) => counter_reg(3 downto 1),
      S(0) => \counter[0]_i_6_n_0\
    );
\counter_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[8]_i_1_n_5\,
      Q => counter_reg(10),
      R => eqOp
    );
\counter_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[8]_i_1_n_4\,
      Q => counter_reg(11),
      R => eqOp
    );
\counter_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[12]_i_1_n_7\,
      Q => counter_reg(12),
      R => eqOp
    );
\counter_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter_reg[8]_i_1_n_0\,
      CO(3) => \counter_reg[12]_i_1_n_0\,
      CO(2) => \counter_reg[12]_i_1_n_1\,
      CO(1) => \counter_reg[12]_i_1_n_2\,
      CO(0) => \counter_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \counter_reg[12]_i_1_n_4\,
      O(2) => \counter_reg[12]_i_1_n_5\,
      O(1) => \counter_reg[12]_i_1_n_6\,
      O(0) => \counter_reg[12]_i_1_n_7\,
      S(3 downto 0) => counter_reg(15 downto 12)
    );
\counter_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[12]_i_1_n_6\,
      Q => counter_reg(13),
      R => eqOp
    );
\counter_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[12]_i_1_n_5\,
      Q => counter_reg(14),
      R => eqOp
    );
\counter_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[12]_i_1_n_4\,
      Q => counter_reg(15),
      R => eqOp
    );
\counter_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[16]_i_1_n_7\,
      Q => counter_reg(16),
      R => eqOp
    );
\counter_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter_reg[12]_i_1_n_0\,
      CO(3) => \counter_reg[16]_i_1_n_0\,
      CO(2) => \counter_reg[16]_i_1_n_1\,
      CO(1) => \counter_reg[16]_i_1_n_2\,
      CO(0) => \counter_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \counter_reg[16]_i_1_n_4\,
      O(2) => \counter_reg[16]_i_1_n_5\,
      O(1) => \counter_reg[16]_i_1_n_6\,
      O(0) => \counter_reg[16]_i_1_n_7\,
      S(3 downto 0) => counter_reg(19 downto 16)
    );
\counter_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[16]_i_1_n_6\,
      Q => counter_reg(17),
      R => eqOp
    );
\counter_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[16]_i_1_n_5\,
      Q => counter_reg(18),
      R => eqOp
    );
\counter_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[16]_i_1_n_4\,
      Q => counter_reg(19),
      R => eqOp
    );
\counter_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[0]_i_2_n_6\,
      Q => counter_reg(1),
      R => eqOp
    );
\counter_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[20]_i_1_n_7\,
      Q => counter_reg(20),
      R => eqOp
    );
\counter_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter_reg[16]_i_1_n_0\,
      CO(3) => \counter_reg[20]_i_1_n_0\,
      CO(2) => \counter_reg[20]_i_1_n_1\,
      CO(1) => \counter_reg[20]_i_1_n_2\,
      CO(0) => \counter_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \counter_reg[20]_i_1_n_4\,
      O(2) => \counter_reg[20]_i_1_n_5\,
      O(1) => \counter_reg[20]_i_1_n_6\,
      O(0) => \counter_reg[20]_i_1_n_7\,
      S(3 downto 0) => counter_reg(23 downto 20)
    );
\counter_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[20]_i_1_n_6\,
      Q => counter_reg(21),
      R => eqOp
    );
\counter_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[20]_i_1_n_5\,
      Q => counter_reg(22),
      R => eqOp
    );
\counter_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[20]_i_1_n_4\,
      Q => counter_reg(23),
      R => eqOp
    );
\counter_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[24]_i_1_n_7\,
      Q => counter_reg(24),
      R => eqOp
    );
\counter_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter_reg[20]_i_1_n_0\,
      CO(3 downto 2) => \NLW_counter_reg[24]_i_1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \counter_reg[24]_i_1_n_2\,
      CO(0) => \counter_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_counter_reg[24]_i_1_O_UNCONNECTED\(3),
      O(2) => \counter_reg[24]_i_1_n_5\,
      O(1) => \counter_reg[24]_i_1_n_6\,
      O(0) => \counter_reg[24]_i_1_n_7\,
      S(3) => '0',
      S(2 downto 0) => counter_reg(26 downto 24)
    );
\counter_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[24]_i_1_n_6\,
      Q => counter_reg(25),
      R => eqOp
    );
\counter_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[24]_i_1_n_5\,
      Q => counter_reg(26),
      R => eqOp
    );
\counter_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[0]_i_2_n_5\,
      Q => counter_reg(2),
      R => eqOp
    );
\counter_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[0]_i_2_n_4\,
      Q => counter_reg(3),
      R => eqOp
    );
\counter_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[4]_i_1_n_7\,
      Q => counter_reg(4),
      R => eqOp
    );
\counter_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter_reg[0]_i_2_n_0\,
      CO(3) => \counter_reg[4]_i_1_n_0\,
      CO(2) => \counter_reg[4]_i_1_n_1\,
      CO(1) => \counter_reg[4]_i_1_n_2\,
      CO(0) => \counter_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \counter_reg[4]_i_1_n_4\,
      O(2) => \counter_reg[4]_i_1_n_5\,
      O(1) => \counter_reg[4]_i_1_n_6\,
      O(0) => \counter_reg[4]_i_1_n_7\,
      S(3 downto 0) => counter_reg(7 downto 4)
    );
\counter_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[4]_i_1_n_6\,
      Q => counter_reg(5),
      R => eqOp
    );
\counter_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[4]_i_1_n_5\,
      Q => counter_reg(6),
      R => eqOp
    );
\counter_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[4]_i_1_n_4\,
      Q => counter_reg(7),
      R => eqOp
    );
\counter_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[8]_i_1_n_7\,
      Q => counter_reg(8),
      R => eqOp
    );
\counter_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter_reg[4]_i_1_n_0\,
      CO(3) => \counter_reg[8]_i_1_n_0\,
      CO(2) => \counter_reg[8]_i_1_n_1\,
      CO(1) => \counter_reg[8]_i_1_n_2\,
      CO(0) => \counter_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \counter_reg[8]_i_1_n_4\,
      O(2) => \counter_reg[8]_i_1_n_5\,
      O(1) => \counter_reg[8]_i_1_n_6\,
      O(0) => \counter_reg[8]_i_1_n_7\,
      S(3 downto 0) => counter_reg(11 downto 8)
    );
\counter_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \counter_reg[8]_i_1_n_6\,
      Q => counter_reg(9),
      R => eqOp
    );
ledState_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => eqOp,
      I1 => ledState,
      O => ledState_i_1_n_0
    );
ledState_reg: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => ledState_i_1_n_0,
      Q => ledState,
      R => '0'
    );
\led[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF4000"
    )
        port map (
      I0 => \led[0]_i_2_n_0\,
      I1 => \led[0]_i_3_n_0\,
      I2 => \led[0]_i_4_n_0\,
      I3 => \led[0]_i_5_n_0\,
      I4 => \^led\(0),
      O => \led[0]_i_1_n_0\
    );
\led[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => counter2_reg(6),
      I1 => counter2_reg(3),
      I2 => counter2_reg(4),
      I3 => counter2_reg(12),
      I4 => counter2_reg(9),
      I5 => counter2_reg(11),
      O => \led[0]_i_2_n_0\
    );
\led[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => counter2_reg(20),
      I1 => counter2_reg(19),
      I2 => counter2_reg(14),
      I3 => counter2_reg(15),
      I4 => counter2_reg(16),
      O => \led[0]_i_3_n_0\
    );
\led[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01000000"
    )
        port map (
      I0 => counter2_reg(2),
      I1 => counter2_reg(1),
      I2 => counter2_reg(0),
      I3 => counter2_reg(18),
      I4 => counter2_reg(21),
      O => \led[0]_i_4_n_0\
    );
\led[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => counter2_reg(10),
      I1 => counter2_reg(13),
      I2 => counter2_reg(17),
      I3 => counter2_reg(8),
      I4 => counter2_reg(5),
      I5 => counter2_reg(7),
      O => \led[0]_i_5_n_0\
    );
\led[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80FF8080"
    )
        port map (
      I0 => \led[3]_i_2_n_0\,
      I1 => \led[3]_i_3_n_0\,
      I2 => \led[3]_i_4_n_0\,
      I3 => eqOp,
      I4 => \^led\(1),
      O => \led[3]_i_1_n_0\
    );
\led[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
        port map (
      I0 => \counter[0]_i_4_n_0\,
      I1 => counter_reg(0),
      I2 => ledState,
      I3 => counter_reg(2),
      I4 => counter_reg(1),
      I5 => \counter[0]_i_5_n_0\,
      O => \led[3]_i_2_n_0\
    );
\led[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2000000000000000"
    )
        port map (
      I0 => counter_reg(24),
      I1 => counter_reg(23),
      I2 => counter_reg(21),
      I3 => counter_reg(22),
      I4 => counter_reg(26),
      I5 => counter_reg(25),
      O => \led[3]_i_3_n_0\
    );
\led[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000002000000000"
    )
        port map (
      I0 => counter_reg(17),
      I1 => counter_reg(18),
      I2 => counter_reg(16),
      I3 => counter_reg(15),
      I4 => counter_reg(19),
      I5 => counter_reg(20),
      O => \led[3]_i_4_n_0\
    );
\led_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clock,
      CE => '1',
      D => \led[0]_i_1_n_0\,
      Q => \^led\(0),
      R => '0'
    );
\led_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \led[3]_i_1_n_0\,
      Q => \^led\(1),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_leds_0_0 is
  port (
    led : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sys_clock : in STD_LOGIC;
    clock : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_leds_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_leds_0_0 : entity is "design_1_leds_0_0,leds,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_leds_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_leds_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_leds_0_0 : entity is "leds,Vivado 2018.3";
end design_1_leds_0_0;

architecture STRUCTURE of design_1_leds_0_0 is
  signal \^led\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute x_interface_info : string;
  attribute x_interface_info of clock : signal is "xilinx.com:signal:clock:1.0 clock CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clock : signal is "XIL_INTERFACENAME clock, FREQ_HZ 5000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute x_interface_info of sys_clock : signal is "xilinx.com:signal:clock:1.0 sys_clock CLK";
  attribute x_interface_parameter of sys_clock : signal is "XIL_INTERFACENAME sys_clock, FREQ_HZ 125000000, PHASE 0.000, CLK_DOMAIN design_1_sys_clock, INSERT_VIP 0";
begin
  led(3) <= \^led\(2);
  led(2) <= \^led\(2);
  led(1) <= \^led\(2);
  led(0) <= \^led\(0);
U0: entity work.design_1_leds_0_0_leds
     port map (
      clock => clock,
      led(1) => \^led\(2),
      led(0) => \^led\(0),
      sys_clock => sys_clock
    );
end STRUCTURE;
