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
/*** UART MODULE ***/
UART  UART_MODULE
(
	.clk(clk), // HOW TO PUT ALL THE SAME SHIT
	.rst(rst),
	.Data_to_transmit(wire_MxV_OUTPUT),			
	.rx(RX),										
	.Transmit_Enable(wire_TX_ENABLE),			//Enables the transmition of the Data to transmit
	.Received_Data(wire_Rec_Data),				//DATA for the MxV
	.tx(wire_TX)
);

/*** MxV MODULE ***/
//MxV MxV_MODULE
//(
//);

assign TX = wire_TX;
endmodule