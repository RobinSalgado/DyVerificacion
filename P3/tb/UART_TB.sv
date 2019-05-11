// Coder:           Esteban González Moreno

// Date:            09 Mayo 2019

// Name:            UART.sv

// Description:     UART top module

import Definitions_Package::*;


module UART_TB;
	//INPUT
	bit 				clk;
	bit 				rst;
	logic 			Transmit_Enable;
	word_lenght_t 	Data_to_transmit;
	logic 			rx;
	//OUTPUT
	word_lenght_t 	Received_Data;
	logic 			tx;

UART DUT(
	//Inputs
	.clk(clk),
	.rst(rst),
	.Transmit_Enable(Transmit_Enable),
	.Data_to_transmit(Data_to_transmit),	
	.rx(rx),
	//Outputs
	.Received_Data(Received_Data),
	.tx(tx)
);


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
			rx = 1;
	 	   Transmit_Enable = 0;

	#10 	Data_to_transmit = 5;	
	#20000 	Transmit_Enable = 1;
	#20000 	Transmit_Enable = 0;
	
	
	#500	rx = 1;
	#878 	rx = 0;	//start bit
	
	#878 	rx = 1;	//0
	#878 	rx = 0;	//1
	#878 	rx = 1;	//2
	#878 	rx = 0;	//3
	#878 	rx = 1;	//4
	#878 	rx = 0;	//5
	#878 	rx = 1;	//6
	#878 	rx = 0;	//7
	
	#878 	rx = 1;	//stop bit
	#100 	rx = 1;	//wait
	
	
			rx = 1;
	#500	rx = 1;
	#878 	rx = 0;	//start bit
	#878 	rx = 1;	//0
	#878 	rx = 0;	//1
	#878 	rx = 1;	//2
	#878 	rx = 0;	//3
	#878 	rx = 1;	//4
	#878 	rx = 0;	//5
	#878 	rx = 1;	//6
	#878 	rx = 0;	//7
	#878 	rx = 1;	//stop bit
	#100 	rx = 1;	//wait
	
end/*********************************************************/

endmodule 