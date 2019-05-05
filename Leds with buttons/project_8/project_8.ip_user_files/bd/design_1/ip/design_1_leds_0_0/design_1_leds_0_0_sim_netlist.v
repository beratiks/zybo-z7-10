// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May  5 03:05:57 2019
// Host        : BERAT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/zybo-z10_workspace/project_8/project_8.srcs/sources_1/bd/design_1/ip/design_1_leds_0_0/design_1_leds_0_0_sim_netlist.v
// Design      : design_1_leds_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_leds_0_0,leds,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "leds,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_1_leds_0_0
   (led,
    sys_clock,
    clock);
  output [3:0]led;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 sys_clock CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME sys_clock, FREQ_HZ 125000000, PHASE 0.000, CLK_DOMAIN design_1_sys_clock, INSERT_VIP 0" *) input sys_clock;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clock CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clock, FREQ_HZ 5000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clock;

  wire clock;
  wire [2:0]\^led ;
  wire sys_clock;

  assign led[3] = \^led [2];
  assign led[2] = \^led [2];
  assign led[1] = \^led [2];
  assign led[0] = \^led [0];
  design_1_leds_0_0_leds U0
       (.clock(clock),
        .led({\^led [2],\^led [0]}),
        .sys_clock(sys_clock));
endmodule

(* ORIG_REF_NAME = "leds" *) 
module design_1_leds_0_0_leds
   (led,
    sys_clock,
    clock);
  output [1:0]led;
  input sys_clock;
  input clock;

  wire clear;
  wire clock;
  wire \counter2[0]_i_3_n_0 ;
  wire [21:0]counter2_reg;
  wire \counter2_reg[0]_i_2_n_0 ;
  wire \counter2_reg[0]_i_2_n_1 ;
  wire \counter2_reg[0]_i_2_n_2 ;
  wire \counter2_reg[0]_i_2_n_3 ;
  wire \counter2_reg[0]_i_2_n_4 ;
  wire \counter2_reg[0]_i_2_n_5 ;
  wire \counter2_reg[0]_i_2_n_6 ;
  wire \counter2_reg[0]_i_2_n_7 ;
  wire \counter2_reg[12]_i_1_n_0 ;
  wire \counter2_reg[12]_i_1_n_1 ;
  wire \counter2_reg[12]_i_1_n_2 ;
  wire \counter2_reg[12]_i_1_n_3 ;
  wire \counter2_reg[12]_i_1_n_4 ;
  wire \counter2_reg[12]_i_1_n_5 ;
  wire \counter2_reg[12]_i_1_n_6 ;
  wire \counter2_reg[12]_i_1_n_7 ;
  wire \counter2_reg[16]_i_1_n_0 ;
  wire \counter2_reg[16]_i_1_n_1 ;
  wire \counter2_reg[16]_i_1_n_2 ;
  wire \counter2_reg[16]_i_1_n_3 ;
  wire \counter2_reg[16]_i_1_n_4 ;
  wire \counter2_reg[16]_i_1_n_5 ;
  wire \counter2_reg[16]_i_1_n_6 ;
  wire \counter2_reg[16]_i_1_n_7 ;
  wire \counter2_reg[20]_i_1_n_3 ;
  wire \counter2_reg[20]_i_1_n_6 ;
  wire \counter2_reg[20]_i_1_n_7 ;
  wire \counter2_reg[4]_i_1_n_0 ;
  wire \counter2_reg[4]_i_1_n_1 ;
  wire \counter2_reg[4]_i_1_n_2 ;
  wire \counter2_reg[4]_i_1_n_3 ;
  wire \counter2_reg[4]_i_1_n_4 ;
  wire \counter2_reg[4]_i_1_n_5 ;
  wire \counter2_reg[4]_i_1_n_6 ;
  wire \counter2_reg[4]_i_1_n_7 ;
  wire \counter2_reg[8]_i_1_n_0 ;
  wire \counter2_reg[8]_i_1_n_1 ;
  wire \counter2_reg[8]_i_1_n_2 ;
  wire \counter2_reg[8]_i_1_n_3 ;
  wire \counter2_reg[8]_i_1_n_4 ;
  wire \counter2_reg[8]_i_1_n_5 ;
  wire \counter2_reg[8]_i_1_n_6 ;
  wire \counter2_reg[8]_i_1_n_7 ;
  wire \counter[0]_i_3_n_0 ;
  wire \counter[0]_i_4_n_0 ;
  wire \counter[0]_i_5_n_0 ;
  wire \counter[0]_i_6_n_0 ;
  wire [26:0]counter_reg;
  wire \counter_reg[0]_i_2_n_0 ;
  wire \counter_reg[0]_i_2_n_1 ;
  wire \counter_reg[0]_i_2_n_2 ;
  wire \counter_reg[0]_i_2_n_3 ;
  wire \counter_reg[0]_i_2_n_4 ;
  wire \counter_reg[0]_i_2_n_5 ;
  wire \counter_reg[0]_i_2_n_6 ;
  wire \counter_reg[0]_i_2_n_7 ;
  wire \counter_reg[12]_i_1_n_0 ;
  wire \counter_reg[12]_i_1_n_1 ;
  wire \counter_reg[12]_i_1_n_2 ;
  wire \counter_reg[12]_i_1_n_3 ;
  wire \counter_reg[12]_i_1_n_4 ;
  wire \counter_reg[12]_i_1_n_5 ;
  wire \counter_reg[12]_i_1_n_6 ;
  wire \counter_reg[12]_i_1_n_7 ;
  wire \counter_reg[16]_i_1_n_0 ;
  wire \counter_reg[16]_i_1_n_1 ;
  wire \counter_reg[16]_i_1_n_2 ;
  wire \counter_reg[16]_i_1_n_3 ;
  wire \counter_reg[16]_i_1_n_4 ;
  wire \counter_reg[16]_i_1_n_5 ;
  wire \counter_reg[16]_i_1_n_6 ;
  wire \counter_reg[16]_i_1_n_7 ;
  wire \counter_reg[20]_i_1_n_0 ;
  wire \counter_reg[20]_i_1_n_1 ;
  wire \counter_reg[20]_i_1_n_2 ;
  wire \counter_reg[20]_i_1_n_3 ;
  wire \counter_reg[20]_i_1_n_4 ;
  wire \counter_reg[20]_i_1_n_5 ;
  wire \counter_reg[20]_i_1_n_6 ;
  wire \counter_reg[20]_i_1_n_7 ;
  wire \counter_reg[24]_i_1_n_2 ;
  wire \counter_reg[24]_i_1_n_3 ;
  wire \counter_reg[24]_i_1_n_5 ;
  wire \counter_reg[24]_i_1_n_6 ;
  wire \counter_reg[24]_i_1_n_7 ;
  wire \counter_reg[4]_i_1_n_0 ;
  wire \counter_reg[4]_i_1_n_1 ;
  wire \counter_reg[4]_i_1_n_2 ;
  wire \counter_reg[4]_i_1_n_3 ;
  wire \counter_reg[4]_i_1_n_4 ;
  wire \counter_reg[4]_i_1_n_5 ;
  wire \counter_reg[4]_i_1_n_6 ;
  wire \counter_reg[4]_i_1_n_7 ;
  wire \counter_reg[8]_i_1_n_0 ;
  wire \counter_reg[8]_i_1_n_1 ;
  wire \counter_reg[8]_i_1_n_2 ;
  wire \counter_reg[8]_i_1_n_3 ;
  wire \counter_reg[8]_i_1_n_4 ;
  wire \counter_reg[8]_i_1_n_5 ;
  wire \counter_reg[8]_i_1_n_6 ;
  wire \counter_reg[8]_i_1_n_7 ;
  wire eqOp;
  wire [1:0]led;
  wire ledState;
  wire ledState_i_1_n_0;
  wire \led[0]_i_1_n_0 ;
  wire \led[0]_i_2_n_0 ;
  wire \led[0]_i_3_n_0 ;
  wire \led[0]_i_4_n_0 ;
  wire \led[0]_i_5_n_0 ;
  wire \led[3]_i_1_n_0 ;
  wire \led[3]_i_2_n_0 ;
  wire \led[3]_i_3_n_0 ;
  wire \led[3]_i_4_n_0 ;
  wire sys_clock;
  wire [3:1]\NLW_counter2_reg[20]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_counter2_reg[20]_i_1_O_UNCONNECTED ;
  wire [3:2]\NLW_counter_reg[24]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_counter_reg[24]_i_1_O_UNCONNECTED ;

  LUT4 #(
    .INIT(16'h4000)) 
    \counter2[0]_i_1 
       (.I0(\led[0]_i_2_n_0 ),
        .I1(\led[0]_i_3_n_0 ),
        .I2(\led[0]_i_4_n_0 ),
        .I3(\led[0]_i_5_n_0 ),
        .O(clear));
  LUT1 #(
    .INIT(2'h1)) 
    \counter2[0]_i_3 
       (.I0(counter2_reg[0]),
        .O(\counter2[0]_i_3_n_0 ));
  FDRE \counter2_reg[0] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[0]_i_2_n_7 ),
        .Q(counter2_reg[0]),
        .R(clear));
  CARRY4 \counter2_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\counter2_reg[0]_i_2_n_0 ,\counter2_reg[0]_i_2_n_1 ,\counter2_reg[0]_i_2_n_2 ,\counter2_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\counter2_reg[0]_i_2_n_4 ,\counter2_reg[0]_i_2_n_5 ,\counter2_reg[0]_i_2_n_6 ,\counter2_reg[0]_i_2_n_7 }),
        .S({counter2_reg[3:1],\counter2[0]_i_3_n_0 }));
  FDRE \counter2_reg[10] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[8]_i_1_n_5 ),
        .Q(counter2_reg[10]),
        .R(clear));
  FDRE \counter2_reg[11] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[8]_i_1_n_4 ),
        .Q(counter2_reg[11]),
        .R(clear));
  FDRE \counter2_reg[12] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[12]_i_1_n_7 ),
        .Q(counter2_reg[12]),
        .R(clear));
  CARRY4 \counter2_reg[12]_i_1 
       (.CI(\counter2_reg[8]_i_1_n_0 ),
        .CO({\counter2_reg[12]_i_1_n_0 ,\counter2_reg[12]_i_1_n_1 ,\counter2_reg[12]_i_1_n_2 ,\counter2_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter2_reg[12]_i_1_n_4 ,\counter2_reg[12]_i_1_n_5 ,\counter2_reg[12]_i_1_n_6 ,\counter2_reg[12]_i_1_n_7 }),
        .S(counter2_reg[15:12]));
  FDRE \counter2_reg[13] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[12]_i_1_n_6 ),
        .Q(counter2_reg[13]),
        .R(clear));
  FDRE \counter2_reg[14] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[12]_i_1_n_5 ),
        .Q(counter2_reg[14]),
        .R(clear));
  FDRE \counter2_reg[15] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[12]_i_1_n_4 ),
        .Q(counter2_reg[15]),
        .R(clear));
  FDRE \counter2_reg[16] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[16]_i_1_n_7 ),
        .Q(counter2_reg[16]),
        .R(clear));
  CARRY4 \counter2_reg[16]_i_1 
       (.CI(\counter2_reg[12]_i_1_n_0 ),
        .CO({\counter2_reg[16]_i_1_n_0 ,\counter2_reg[16]_i_1_n_1 ,\counter2_reg[16]_i_1_n_2 ,\counter2_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter2_reg[16]_i_1_n_4 ,\counter2_reg[16]_i_1_n_5 ,\counter2_reg[16]_i_1_n_6 ,\counter2_reg[16]_i_1_n_7 }),
        .S(counter2_reg[19:16]));
  FDRE \counter2_reg[17] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[16]_i_1_n_6 ),
        .Q(counter2_reg[17]),
        .R(clear));
  FDRE \counter2_reg[18] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[16]_i_1_n_5 ),
        .Q(counter2_reg[18]),
        .R(clear));
  FDRE \counter2_reg[19] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[16]_i_1_n_4 ),
        .Q(counter2_reg[19]),
        .R(clear));
  FDRE \counter2_reg[1] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[0]_i_2_n_6 ),
        .Q(counter2_reg[1]),
        .R(clear));
  FDRE \counter2_reg[20] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[20]_i_1_n_7 ),
        .Q(counter2_reg[20]),
        .R(clear));
  CARRY4 \counter2_reg[20]_i_1 
       (.CI(\counter2_reg[16]_i_1_n_0 ),
        .CO({\NLW_counter2_reg[20]_i_1_CO_UNCONNECTED [3:1],\counter2_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_counter2_reg[20]_i_1_O_UNCONNECTED [3:2],\counter2_reg[20]_i_1_n_6 ,\counter2_reg[20]_i_1_n_7 }),
        .S({1'b0,1'b0,counter2_reg[21:20]}));
  FDRE \counter2_reg[21] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[20]_i_1_n_6 ),
        .Q(counter2_reg[21]),
        .R(clear));
  FDRE \counter2_reg[2] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[0]_i_2_n_5 ),
        .Q(counter2_reg[2]),
        .R(clear));
  FDRE \counter2_reg[3] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[0]_i_2_n_4 ),
        .Q(counter2_reg[3]),
        .R(clear));
  FDRE \counter2_reg[4] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[4]_i_1_n_7 ),
        .Q(counter2_reg[4]),
        .R(clear));
  CARRY4 \counter2_reg[4]_i_1 
       (.CI(\counter2_reg[0]_i_2_n_0 ),
        .CO({\counter2_reg[4]_i_1_n_0 ,\counter2_reg[4]_i_1_n_1 ,\counter2_reg[4]_i_1_n_2 ,\counter2_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter2_reg[4]_i_1_n_4 ,\counter2_reg[4]_i_1_n_5 ,\counter2_reg[4]_i_1_n_6 ,\counter2_reg[4]_i_1_n_7 }),
        .S(counter2_reg[7:4]));
  FDRE \counter2_reg[5] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[4]_i_1_n_6 ),
        .Q(counter2_reg[5]),
        .R(clear));
  FDRE \counter2_reg[6] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[4]_i_1_n_5 ),
        .Q(counter2_reg[6]),
        .R(clear));
  FDRE \counter2_reg[7] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[4]_i_1_n_4 ),
        .Q(counter2_reg[7]),
        .R(clear));
  FDRE \counter2_reg[8] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[8]_i_1_n_7 ),
        .Q(counter2_reg[8]),
        .R(clear));
  CARRY4 \counter2_reg[8]_i_1 
       (.CI(\counter2_reg[4]_i_1_n_0 ),
        .CO({\counter2_reg[8]_i_1_n_0 ,\counter2_reg[8]_i_1_n_1 ,\counter2_reg[8]_i_1_n_2 ,\counter2_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter2_reg[8]_i_1_n_4 ,\counter2_reg[8]_i_1_n_5 ,\counter2_reg[8]_i_1_n_6 ,\counter2_reg[8]_i_1_n_7 }),
        .S(counter2_reg[11:8]));
  FDRE \counter2_reg[9] 
       (.C(clock),
        .CE(1'b1),
        .D(\counter2_reg[8]_i_1_n_6 ),
        .Q(counter2_reg[9]),
        .R(clear));
  LUT6 #(
    .INIT(64'h4000000000000000)) 
    \counter[0]_i_1 
       (.I0(counter_reg[0]),
        .I1(\counter[0]_i_3_n_0 ),
        .I2(\counter[0]_i_4_n_0 ),
        .I3(\led[3]_i_4_n_0 ),
        .I4(\counter[0]_i_5_n_0 ),
        .I5(\led[3]_i_3_n_0 ),
        .O(eqOp));
  LUT2 #(
    .INIT(4'h1)) 
    \counter[0]_i_3 
       (.I0(counter_reg[1]),
        .I1(counter_reg[2]),
        .O(\counter[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \counter[0]_i_4 
       (.I0(counter_reg[6]),
        .I1(counter_reg[5]),
        .I2(counter_reg[3]),
        .I3(counter_reg[4]),
        .I4(counter_reg[7]),
        .I5(counter_reg[8]),
        .O(\counter[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \counter[0]_i_5 
       (.I0(counter_reg[11]),
        .I1(counter_reg[12]),
        .I2(counter_reg[9]),
        .I3(counter_reg[10]),
        .I4(counter_reg[13]),
        .I5(counter_reg[14]),
        .O(\counter[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \counter[0]_i_6 
       (.I0(counter_reg[0]),
        .O(\counter[0]_i_6_n_0 ));
  FDRE \counter_reg[0] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2_n_7 ),
        .Q(counter_reg[0]),
        .R(eqOp));
  CARRY4 \counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\counter_reg[0]_i_2_n_0 ,\counter_reg[0]_i_2_n_1 ,\counter_reg[0]_i_2_n_2 ,\counter_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\counter_reg[0]_i_2_n_4 ,\counter_reg[0]_i_2_n_5 ,\counter_reg[0]_i_2_n_6 ,\counter_reg[0]_i_2_n_7 }),
        .S({counter_reg[3:1],\counter[0]_i_6_n_0 }));
  FDRE \counter_reg[10] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1_n_5 ),
        .Q(counter_reg[10]),
        .R(eqOp));
  FDRE \counter_reg[11] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1_n_4 ),
        .Q(counter_reg[11]),
        .R(eqOp));
  FDRE \counter_reg[12] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1_n_7 ),
        .Q(counter_reg[12]),
        .R(eqOp));
  CARRY4 \counter_reg[12]_i_1 
       (.CI(\counter_reg[8]_i_1_n_0 ),
        .CO({\counter_reg[12]_i_1_n_0 ,\counter_reg[12]_i_1_n_1 ,\counter_reg[12]_i_1_n_2 ,\counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[12]_i_1_n_4 ,\counter_reg[12]_i_1_n_5 ,\counter_reg[12]_i_1_n_6 ,\counter_reg[12]_i_1_n_7 }),
        .S(counter_reg[15:12]));
  FDRE \counter_reg[13] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1_n_6 ),
        .Q(counter_reg[13]),
        .R(eqOp));
  FDRE \counter_reg[14] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1_n_5 ),
        .Q(counter_reg[14]),
        .R(eqOp));
  FDRE \counter_reg[15] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1_n_4 ),
        .Q(counter_reg[15]),
        .R(eqOp));
  FDRE \counter_reg[16] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1_n_7 ),
        .Q(counter_reg[16]),
        .R(eqOp));
  CARRY4 \counter_reg[16]_i_1 
       (.CI(\counter_reg[12]_i_1_n_0 ),
        .CO({\counter_reg[16]_i_1_n_0 ,\counter_reg[16]_i_1_n_1 ,\counter_reg[16]_i_1_n_2 ,\counter_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[16]_i_1_n_4 ,\counter_reg[16]_i_1_n_5 ,\counter_reg[16]_i_1_n_6 ,\counter_reg[16]_i_1_n_7 }),
        .S(counter_reg[19:16]));
  FDRE \counter_reg[17] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1_n_6 ),
        .Q(counter_reg[17]),
        .R(eqOp));
  FDRE \counter_reg[18] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1_n_5 ),
        .Q(counter_reg[18]),
        .R(eqOp));
  FDRE \counter_reg[19] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1_n_4 ),
        .Q(counter_reg[19]),
        .R(eqOp));
  FDRE \counter_reg[1] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2_n_6 ),
        .Q(counter_reg[1]),
        .R(eqOp));
  FDRE \counter_reg[20] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[20]_i_1_n_7 ),
        .Q(counter_reg[20]),
        .R(eqOp));
  CARRY4 \counter_reg[20]_i_1 
       (.CI(\counter_reg[16]_i_1_n_0 ),
        .CO({\counter_reg[20]_i_1_n_0 ,\counter_reg[20]_i_1_n_1 ,\counter_reg[20]_i_1_n_2 ,\counter_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[20]_i_1_n_4 ,\counter_reg[20]_i_1_n_5 ,\counter_reg[20]_i_1_n_6 ,\counter_reg[20]_i_1_n_7 }),
        .S(counter_reg[23:20]));
  FDRE \counter_reg[21] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[20]_i_1_n_6 ),
        .Q(counter_reg[21]),
        .R(eqOp));
  FDRE \counter_reg[22] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[20]_i_1_n_5 ),
        .Q(counter_reg[22]),
        .R(eqOp));
  FDRE \counter_reg[23] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[20]_i_1_n_4 ),
        .Q(counter_reg[23]),
        .R(eqOp));
  FDRE \counter_reg[24] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[24]_i_1_n_7 ),
        .Q(counter_reg[24]),
        .R(eqOp));
  CARRY4 \counter_reg[24]_i_1 
       (.CI(\counter_reg[20]_i_1_n_0 ),
        .CO({\NLW_counter_reg[24]_i_1_CO_UNCONNECTED [3:2],\counter_reg[24]_i_1_n_2 ,\counter_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_counter_reg[24]_i_1_O_UNCONNECTED [3],\counter_reg[24]_i_1_n_5 ,\counter_reg[24]_i_1_n_6 ,\counter_reg[24]_i_1_n_7 }),
        .S({1'b0,counter_reg[26:24]}));
  FDRE \counter_reg[25] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[24]_i_1_n_6 ),
        .Q(counter_reg[25]),
        .R(eqOp));
  FDRE \counter_reg[26] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[24]_i_1_n_5 ),
        .Q(counter_reg[26]),
        .R(eqOp));
  FDRE \counter_reg[2] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2_n_5 ),
        .Q(counter_reg[2]),
        .R(eqOp));
  FDRE \counter_reg[3] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2_n_4 ),
        .Q(counter_reg[3]),
        .R(eqOp));
  FDRE \counter_reg[4] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1_n_7 ),
        .Q(counter_reg[4]),
        .R(eqOp));
  CARRY4 \counter_reg[4]_i_1 
       (.CI(\counter_reg[0]_i_2_n_0 ),
        .CO({\counter_reg[4]_i_1_n_0 ,\counter_reg[4]_i_1_n_1 ,\counter_reg[4]_i_1_n_2 ,\counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[4]_i_1_n_4 ,\counter_reg[4]_i_1_n_5 ,\counter_reg[4]_i_1_n_6 ,\counter_reg[4]_i_1_n_7 }),
        .S(counter_reg[7:4]));
  FDRE \counter_reg[5] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1_n_6 ),
        .Q(counter_reg[5]),
        .R(eqOp));
  FDRE \counter_reg[6] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1_n_5 ),
        .Q(counter_reg[6]),
        .R(eqOp));
  FDRE \counter_reg[7] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1_n_4 ),
        .Q(counter_reg[7]),
        .R(eqOp));
  FDRE \counter_reg[8] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1_n_7 ),
        .Q(counter_reg[8]),
        .R(eqOp));
  CARRY4 \counter_reg[8]_i_1 
       (.CI(\counter_reg[4]_i_1_n_0 ),
        .CO({\counter_reg[8]_i_1_n_0 ,\counter_reg[8]_i_1_n_1 ,\counter_reg[8]_i_1_n_2 ,\counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[8]_i_1_n_4 ,\counter_reg[8]_i_1_n_5 ,\counter_reg[8]_i_1_n_6 ,\counter_reg[8]_i_1_n_7 }),
        .S(counter_reg[11:8]));
  FDRE \counter_reg[9] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1_n_6 ),
        .Q(counter_reg[9]),
        .R(eqOp));
  LUT2 #(
    .INIT(4'h6)) 
    ledState_i_1
       (.I0(eqOp),
        .I1(ledState),
        .O(ledState_i_1_n_0));
  FDRE ledState_reg
       (.C(sys_clock),
        .CE(1'b1),
        .D(ledState_i_1_n_0),
        .Q(ledState),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hBFFF4000)) 
    \led[0]_i_1 
       (.I0(\led[0]_i_2_n_0 ),
        .I1(\led[0]_i_3_n_0 ),
        .I2(\led[0]_i_4_n_0 ),
        .I3(\led[0]_i_5_n_0 ),
        .I4(led[0]),
        .O(\led[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \led[0]_i_2 
       (.I0(counter2_reg[6]),
        .I1(counter2_reg[3]),
        .I2(counter2_reg[4]),
        .I3(counter2_reg[12]),
        .I4(counter2_reg[9]),
        .I5(counter2_reg[11]),
        .O(\led[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \led[0]_i_3 
       (.I0(counter2_reg[20]),
        .I1(counter2_reg[19]),
        .I2(counter2_reg[14]),
        .I3(counter2_reg[15]),
        .I4(counter2_reg[16]),
        .O(\led[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h01000000)) 
    \led[0]_i_4 
       (.I0(counter2_reg[2]),
        .I1(counter2_reg[1]),
        .I2(counter2_reg[0]),
        .I3(counter2_reg[18]),
        .I4(counter2_reg[21]),
        .O(\led[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \led[0]_i_5 
       (.I0(counter2_reg[10]),
        .I1(counter2_reg[13]),
        .I2(counter2_reg[17]),
        .I3(counter2_reg[8]),
        .I4(counter2_reg[5]),
        .I5(counter2_reg[7]),
        .O(\led[0]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h80FF8080)) 
    \led[3]_i_1 
       (.I0(\led[3]_i_2_n_0 ),
        .I1(\led[3]_i_3_n_0 ),
        .I2(\led[3]_i_4_n_0 ),
        .I3(eqOp),
        .I4(led[1]),
        .O(\led[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \led[3]_i_2 
       (.I0(\counter[0]_i_4_n_0 ),
        .I1(counter_reg[0]),
        .I2(ledState),
        .I3(counter_reg[2]),
        .I4(counter_reg[1]),
        .I5(\counter[0]_i_5_n_0 ),
        .O(\led[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h2000000000000000)) 
    \led[3]_i_3 
       (.I0(counter_reg[24]),
        .I1(counter_reg[23]),
        .I2(counter_reg[21]),
        .I3(counter_reg[22]),
        .I4(counter_reg[26]),
        .I5(counter_reg[25]),
        .O(\led[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \led[3]_i_4 
       (.I0(counter_reg[17]),
        .I1(counter_reg[18]),
        .I2(counter_reg[16]),
        .I3(counter_reg[15]),
        .I4(counter_reg[19]),
        .I5(counter_reg[20]),
        .O(\led[3]_i_4_n_0 ));
  FDRE \led_reg[0] 
       (.C(clock),
        .CE(1'b1),
        .D(\led[0]_i_1_n_0 ),
        .Q(led[0]),
        .R(1'b0));
  FDRE \led_reg[3] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\led[3]_i_1_n_0 ),
        .Q(led[1]),
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
