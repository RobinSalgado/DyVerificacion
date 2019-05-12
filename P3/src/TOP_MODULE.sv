// Coder:           Esteban González Moreno

// Date:            07 Mayo 2019

// Name:            TOP_MODULE.sv

// Description:     This is the TOP Module



import Definitions_Package::*;

module topmod

(
	input clk,
	input rst,
	
	input  RX,
	output TX
);

// WIRES
wire wire_TX_ENABLE;
word_lenght_t wire_MxV_OUTPUT;					//wl is [15:0]
word_lenght_t wire_Rec_Data;
wire wire_TX;
wire wire_DONE);
/*** UART MODULE ***/
UART  UART_MODULE
(
	.clk(clk), // HOW TO PUT ALL THE SAME SHIT
	.rst(rst),
	.Data_to_transmit(wire_MxV_OUTPUT),			
	.rx(RX),										
	.Transmit_Enable(wire_TX_ENABLE),			//Enables the transmition of the Data to transmit
	.Received_Data(wire_Rec_Data),				//DATA for the MxV
	.DONE(wire_DONE),
	.tx(wire_TX)
	// AGREGAR DONE PARA RECEIVED DATA
);

/*** MxV MODULE ***/
MxV MxV_MODULE
(
	.clk(clk),
	.rst(rst),
	.REC_DATA(wire_Rec_Data),
	.REC_DONE(wire_DONE),
	.DATA_OUT(wire_MxV_OUTPUT),
);

assign TX = wire_TX;
endmodule