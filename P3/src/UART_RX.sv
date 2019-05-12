// Coders:           Esteban González Moreno, Robin Moises Salgado

// Date:            08 Mayo 2019

// Name:            UART_RX.sv

// Description:     UART Reception top module



import Definitions_Package::*;

module UART_RX(
	input 						clk,
	input 						rst,
	input 				 		RX,
	output						Done,
	output 	word_lenght_t	Received_DATA
);


wire Done_wire;
wire Bd_cnt_ovf_wire;
wire Bd_Half_cnt_ovf_wire;
//SM RX Wires
wire wire_C1_EN;
wire wire_C2_EN;
wire wire_CLEAR_EN;
sipo_lenght_t wire_Received_DATA;
//wire clk_intern;
////SIGNAL TAP
//SIGNAL_TAP SIGNAL_TAP_inst(
//	.areset(rst),
//	.inclk0(clk),
//	.c0(clk_intern)
//);

//STATE MACHINE FOR RX
UART_RX_SM UART_RX_SM_MOD(
	.clk(clk),//_intern),
	.rst(rst),
	.DATA(RX),
	.DONE(Done_wire),
	.FC_done(Bd_Half_cnt_ovf_wire),
	.First_Count_EN(wire_C1_EN),
	.BAUD_Count_EN(wire_C2_EN),
	.Clear(wire_CLEAR_EN)
);


// HALF BAUD RATE
cntr_half_baud_ovf cntr_half_baud_ovf_MOD(
	//inputs
	.clk(clk),//_intern),
	.rst(rst),
	.enb(wire_C1_EN),
	.clear(wire_CLEAR_EN),
	//outputs
	.ovf(Bd_Half_cnt_ovf_wire)
);

// BAUD RATE
cntr_baud_tx_ovf cntr_baud_RX_ovf_MOD(
	//inputs
	.clk(clk),//_intern),
	.rst(rst),
	.enb(wire_C2_EN),
	.clear(wire_CLEAR_EN),
	//outputs
	.ovf(Bd_cnt_ovf_wire)
);

// FRAME COUNTER
 cntr_DATA_RX_ovf	cntr_DATA_RX_ovf_MOD(
	 .clk(clk),//_intern),
	 .rst(rst),
	 .enb(Bd_cnt_ovf_wire),
	 .clear(wire_CLEAR_EN),
	 .ovf(Done_wire)
);
SIPO_RX SIPO_RX_MOD(
	//inputs
	.clk(clk),//_intern),
	.rst(rst),
	.clear(wire_C1_EN),
	.enb(Bd_cnt_ovf_wire),
	.in(RX),
	.SIPO_OUT(wire_Received_DATA)
);





assign Received_DATA = wire_Received_DATA[16:1];
assign Done = Done_wire;
endmodule
