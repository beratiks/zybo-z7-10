// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue May  7 21:27:42 2019
// Host        : BERAT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/github_repository/zybo-z7-10/ClockDivider/ClockDivider.srcs/sources_1/bd/design_1/ip/design_1_clockDivider_0_0/design_1_clockDivider_0_0_sim_netlist.v
// Design      : design_1_clockDivider_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_clockDivider_0_0,clockDivider,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "clockDivider,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_1_clockDivider_0_0
   (sys_clk_pin,
    led);
  input sys_clk_pin;
  output [3:0]led;

  wire [0:0]\^led ;
  wire sys_clk_pin;

  assign led[3] = \^led [0];
  assign led[2] = \^led [0];
  assign led[1] = \^led [0];
  assign led[0] = \^led [0];
  design_1_clockDivider_0_0_clockDivider U0
       (.led(\^led ),
        .sys_clk_pin(sys_clk_pin));
endmodule

(* ORIG_REF_NAME = "clockDivider" *) 
module design_1_clockDivider_0_0_clockDivider
   (led,
    sys_clk_pin);
  output [0:0]led;
  input sys_clk_pin;

  wire [25:1]data0;
  wire [25:0]diveder;
  wire diveder0_carry__0_n_0;
  wire diveder0_carry__0_n_1;
  wire diveder0_carry__0_n_2;
  wire diveder0_carry__0_n_3;
  wire diveder0_carry__1_n_0;
  wire diveder0_carry__1_n_1;
  wire diveder0_carry__1_n_2;
  wire diveder0_carry__1_n_3;
  wire diveder0_carry__2_n_0;
  wire diveder0_carry__2_n_1;
  wire diveder0_carry__2_n_2;
  wire diveder0_carry__2_n_3;
  wire diveder0_carry__3_n_0;
  wire diveder0_carry__3_n_1;
  wire diveder0_carry__3_n_2;
  wire diveder0_carry__3_n_3;
  wire diveder0_carry__4_n_0;
  wire diveder0_carry__4_n_1;
  wire diveder0_carry__4_n_2;
  wire diveder0_carry__4_n_3;
  wire diveder0_carry_n_0;
  wire diveder0_carry_n_1;
  wire diveder0_carry_n_2;
  wire diveder0_carry_n_3;
  wire [0:0]diveder_0;
  wire [0:0]led;
  wire sys_clk_pin;
  wire temporary;
  wire temporary_i_1_n_0;
  wire temporary_i_2_n_0;
  wire temporary_i_3_n_0;
  wire temporary_i_4_n_0;
  wire temporary_i_5_n_0;
  wire temporary_i_6_n_0;
  wire temporary_i_7_n_0;
  wire temporary_i_8_n_0;
  wire [3:0]NLW_diveder0_carry__5_CO_UNCONNECTED;
  wire [3:1]NLW_diveder0_carry__5_O_UNCONNECTED;

  CARRY4 diveder0_carry
       (.CI(1'b0),
        .CO({diveder0_carry_n_0,diveder0_carry_n_1,diveder0_carry_n_2,diveder0_carry_n_3}),
        .CYINIT(diveder[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S(diveder[4:1]));
  CARRY4 diveder0_carry__0
       (.CI(diveder0_carry_n_0),
        .CO({diveder0_carry__0_n_0,diveder0_carry__0_n_1,diveder0_carry__0_n_2,diveder0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S(diveder[8:5]));
  CARRY4 diveder0_carry__1
       (.CI(diveder0_carry__0_n_0),
        .CO({diveder0_carry__1_n_0,diveder0_carry__1_n_1,diveder0_carry__1_n_2,diveder0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S(diveder[12:9]));
  CARRY4 diveder0_carry__2
       (.CI(diveder0_carry__1_n_0),
        .CO({diveder0_carry__2_n_0,diveder0_carry__2_n_1,diveder0_carry__2_n_2,diveder0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:13]),
        .S(diveder[16:13]));
  CARRY4 diveder0_carry__3
       (.CI(diveder0_carry__2_n_0),
        .CO({diveder0_carry__3_n_0,diveder0_carry__3_n_1,diveder0_carry__3_n_2,diveder0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[20:17]),
        .S(diveder[20:17]));
  CARRY4 diveder0_carry__4
       (.CI(diveder0_carry__3_n_0),
        .CO({diveder0_carry__4_n_0,diveder0_carry__4_n_1,diveder0_carry__4_n_2,diveder0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[24:21]),
        .S(diveder[24:21]));
  CARRY4 diveder0_carry__5
       (.CI(diveder0_carry__4_n_0),
        .CO(NLW_diveder0_carry__5_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_diveder0_carry__5_O_UNCONNECTED[3:1],data0[25]}),
        .S({1'b0,1'b0,1'b0,diveder[25]}));
  LUT1 #(
    .INIT(2'h1)) 
    \diveder[0]_i_1 
       (.I0(diveder[0]),
        .O(diveder_0));
  LUT1 #(
    .INIT(2'h1)) 
    \diveder[25]_i_1 
       (.I0(temporary_i_2_n_0),
        .O(temporary));
  FDRE \diveder_reg[0] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(diveder_0),
        .Q(diveder[0]),
        .R(1'b0));
  FDRE \diveder_reg[10] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[10]),
        .Q(diveder[10]),
        .R(temporary));
  FDRE \diveder_reg[11] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[11]),
        .Q(diveder[11]),
        .R(temporary));
  FDRE \diveder_reg[12] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[12]),
        .Q(diveder[12]),
        .R(temporary));
  FDRE \diveder_reg[13] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[13]),
        .Q(diveder[13]),
        .R(temporary));
  FDRE \diveder_reg[14] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[14]),
        .Q(diveder[14]),
        .R(temporary));
  FDRE \diveder_reg[15] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[15]),
        .Q(diveder[15]),
        .R(temporary));
  FDRE \diveder_reg[16] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[16]),
        .Q(diveder[16]),
        .R(temporary));
  FDRE \diveder_reg[17] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[17]),
        .Q(diveder[17]),
        .R(temporary));
  FDRE \diveder_reg[18] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[18]),
        .Q(diveder[18]),
        .R(temporary));
  FDRE \diveder_reg[19] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[19]),
        .Q(diveder[19]),
        .R(temporary));
  FDRE \diveder_reg[1] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[1]),
        .Q(diveder[1]),
        .R(temporary));
  FDRE \diveder_reg[20] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[20]),
        .Q(diveder[20]),
        .R(temporary));
  FDRE \diveder_reg[21] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[21]),
        .Q(diveder[21]),
        .R(temporary));
  FDRE \diveder_reg[22] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[22]),
        .Q(diveder[22]),
        .R(temporary));
  FDRE \diveder_reg[23] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[23]),
        .Q(diveder[23]),
        .R(temporary));
  FDRE \diveder_reg[24] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[24]),
        .Q(diveder[24]),
        .R(temporary));
  FDRE \diveder_reg[25] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[25]),
        .Q(diveder[25]),
        .R(temporary));
  FDRE \diveder_reg[2] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[2]),
        .Q(diveder[2]),
        .R(temporary));
  FDRE \diveder_reg[3] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[3]),
        .Q(diveder[3]),
        .R(temporary));
  FDRE \diveder_reg[4] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[4]),
        .Q(diveder[4]),
        .R(temporary));
  FDRE \diveder_reg[5] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[5]),
        .Q(diveder[5]),
        .R(temporary));
  FDRE \diveder_reg[6] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[6]),
        .Q(diveder[6]),
        .R(temporary));
  FDRE \diveder_reg[7] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[7]),
        .Q(diveder[7]),
        .R(temporary));
  FDRE \diveder_reg[8] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[8]),
        .Q(diveder[8]),
        .R(temporary));
  FDRE \diveder_reg[9] 
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(data0[9]),
        .Q(diveder[9]),
        .R(temporary));
  LUT2 #(
    .INIT(4'h9)) 
    temporary_i_1
       (.I0(temporary_i_2_n_0),
        .I1(led),
        .O(temporary_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    temporary_i_2
       (.I0(temporary_i_3_n_0),
        .I1(temporary_i_4_n_0),
        .I2(temporary_i_5_n_0),
        .I3(temporary_i_6_n_0),
        .I4(temporary_i_7_n_0),
        .I5(temporary_i_8_n_0),
        .O(temporary_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFDF)) 
    temporary_i_3
       (.I0(diveder[15]),
        .I1(diveder[14]),
        .I2(diveder[16]),
        .I3(diveder[17]),
        .O(temporary_i_3_n_0));
  LUT4 #(
    .INIT(16'hDFFF)) 
    temporary_i_4
       (.I0(diveder[19]),
        .I1(diveder[18]),
        .I2(diveder[21]),
        .I3(diveder[20]),
        .O(temporary_i_4_n_0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    temporary_i_5
       (.I0(diveder[7]),
        .I1(diveder[6]),
        .I2(diveder[9]),
        .I3(diveder[8]),
        .O(temporary_i_5_n_0));
  LUT4 #(
    .INIT(16'hFF7F)) 
    temporary_i_6
       (.I0(diveder[11]),
        .I1(diveder[10]),
        .I2(diveder[13]),
        .I3(diveder[12]),
        .O(temporary_i_6_n_0));
  LUT4 #(
    .INIT(16'hFF7F)) 
    temporary_i_7
       (.I0(diveder[3]),
        .I1(diveder[2]),
        .I2(diveder[4]),
        .I3(diveder[5]),
        .O(temporary_i_7_n_0));
  LUT6 #(
    .INIT(64'hF7FFFFFFFFFFFFFF)) 
    temporary_i_8
       (.I0(diveder[24]),
        .I1(diveder[25]),
        .I2(diveder[22]),
        .I3(diveder[23]),
        .I4(diveder[1]),
        .I5(diveder[0]),
        .O(temporary_i_8_n_0));
  FDRE #(
    .INIT(1'b0)) 
    temporary_reg
       (.C(sys_clk_pin),
        .CE(1'b1),
        .D(temporary_i_1_n_0),
        .Q(led),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
