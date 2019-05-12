// Coders:           Esteban González Moreno, Robin Moises Salgado

// Date:            07 Mayo 2019

// Name:            UART_RX_TB.sv

// Description:     UART reception tb

import Definitions_Package::*;


module UART_RX_TB;
	//INPUT
	bit 				clk;
	bit 				rst;
	logic 			RX;
	logic 			Done;
	//Output
	word_lenght_t	Received_DATA;
	

UART_RX DUT(
	.clk(clk),
	.rst(rst),
	.RX(RX),
	.Done(Done),
	.Received_DATA(Received_DATA)
);

	

wire Done_wire;
wire Bd_cnt_ovf_wire;
wire Bd_Half_cnt_ovf_wire;
//SM RX Wires
wire wire_C1_EN;
wire wire_C2_EN;
wire wire_CLEAR_EN;
word_lenght_t wire_Received_DATA;
//wire clk_intern;
////SIGNAL TAP
//SIGNAL_TAP SIGNAL_TAP_inst(
//	.areset(rst),
//	.inclk0(clk),
//	.c0(clk_intern)
//);

//STATE MACHINE FOR RX
UART_RX_SM UART_RX_MOD(
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
	 .clear(LOAD_EN_wire),
	 .ovf(Done_wire)
);
SIPO_RX SIPO_RX_MOD(
	//inputs
	.clk(clk),//_intern),
	.rst(rst),
	.clear(wire_CLEAR_EN),
	.enb(Bd_cnt_ovf_wire),
	.in(RX),
	.SIPO_OUT(wire_Received_DATA)
);





/*********************************************************/
initial // Clock generator
  begin
    forever #1 clk = !clk;
  end
  

/*********************************************************/
initial begin // reset generator
	#0 	rst = 1;
	#50 	rst = 0;
	#10 	rst = 1;
end

/*********************************************************/
initial begin // Variables
	#0 	RX = 1;

	#878 	RX = 0;	//start bit
	#878 	RX = 1;	//1
	#878 	RX = 0;	//2
	#878 	RX = 1;	//3
	#878 	RX = 0;	//3
	#878 	RX = 1;	//4
	#878 	RX = 0;	//5
	#878 	RX = 0;	//6
	#878 	RX = 1;	//7
	#878 	RX = 0;	//8
	#878 	RX = 1;	//stop bit
	#100 	RX = 1;	//wait
end/*********************************************************/

endmodule 
