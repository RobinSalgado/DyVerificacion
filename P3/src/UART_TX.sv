// Coder:           Esteban González Moreno

// Date:            07 Mayo 2019

// Name:            UART_TX.sv

// Description:     UART transmition top module


import Definitions_Package::*;

module UART_TX(
	input 					clk,
	input 					rst,
	input word_lenght_t 	Data_To_Transmit,
	input 					LOAD,
	input 					TX_en,
	output 					TX
);


wire LOAD_EN_wire;
wire TRANSMIT_wire;

wire Done_wire;
wire Bd_cnt_ovf_wire;
//wire clk_intern;
////SIGNAL TAP
//SIGNAL_TAP SIGNAL_TAP_inst(
//	.areset(rst),
//	.inclk0(clk),
//	.c0(clk_intern)
//);
//STATE MACHINE FOR TX
UART_TX_SM UART_TX_MOD(
	.clk(clk),//_intern),
	.rst(rst),
	.LOAD(TX_en),
	.DONE(Done_wire),
	.LOAD_EN(LOAD_EN_wire),
	.TRANSMIT_EN(TRANSMIT_wire)
);

// BAUD RATE
cntr_baud_tx_ovf cntr_baud_tx_ovf_MOD(
	//inputs
	.clk(clk),//_intern),
	.rst(rst),
	.enb(TRANSMIT_wire),
	.clear(LOAD_EN_wire),
	//outputs
	.ovf(Bd_cnt_ovf_wire)
);

// FRAME COUNTER
 cntr_DATA_tx_ovf	cntr_DATA_tx_ovf_MOD(
	 .clk(clk),//_intern),
	 .rst(rst),
	 .enb(Bd_cnt_ovf_wire),
	 .clear(LOAD_EN_wire),
	 .ovf(Done_wire)
);
PISO_TX PISO_TX_MOD(
	//inputs
	.clk(clk),//_intern),
	.rst(rst),
	.LOAD_EN(LOAD_EN_wire),
	.TX_EN(Bd_cnt_ovf_wire),
	.DATA(Data_To_Transmit),
	//outputs
	.TX(TX_wire)
);





assign TX = TX_wire;

endmodule