// Coder:           Esteban González Moreno

// Date:            07 Mayo 2019

// Name:            UART.sv

// Description:     This is the UART Module


import Definitions_Package::*;

// TODO
// PARITY ERROR
// RX INTERRUPT

module UART(
	//Inputs
	input  	clk,
	input  	rst,
	input 	Transmit_Enable,
	input  	word_lenght_t Data_to_transmit,	
	input  	rx,
	//Outputs
	output	word_lenght_t Received_Data,
	output 	tx
);

wire RX_en_wire;
wire TX_en_wire;
wire tx_wire;
word_lenght_t wire_DATA_REC;



UART_TX uart_tx_MOD(
	.clk(clk),
	.rst(rst),
	.Data_To_Transmit(Data_to_transmit),
	.LOAD(transmit),
	.TX_en(Transmit_Enable),
	.TX(tx)
);

UART_RX uart_rx(
	//inputs
	.clk(clk),
	.rst(rst),
	.RX(rx),
	.Received_DATA(wire_DATA_REC)
);

	assign	Received_Data = wire_DATA_REC;
	assign 	tx = tx_wire;

endmodule