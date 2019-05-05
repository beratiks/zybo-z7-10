// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May  5 19:34:44 2019
// Host        : BERAT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/zybo-z10_workspace/project_8/project_8.srcs/sources_1/bd/design_1/ip/design_1_buttons_0_0/design_1_buttons_0_0_stub.v
// Design      : design_1_buttons_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "buttons,Vivado 2018.3" *)
module design_1_buttons_0_0(btn, getButton)
/* synthesis syn_black_box black_box_pad_pin="btn[3:0],getButton[3:0]" */;
  input [3:0]btn;
  output [3:0]getButton;
endmodule
