// Coder:           Esteban González Moreno

// Date:            07 Mayo 2019

// Name:            UART_TX.sv

// Description:     UART transmition top module

import Definitions_Package::*;


module UART_TX_TB;
	//INPUT
	bit 				clk;
	bit 				rst;
	
	
	word_lenght_t 	Data_To_Transmit;
	logic 			LOAD;
	logic 			TX_en;
	logic 			TX;
	
	
UART_TX	DUT(
	.clk(clk),
	.rst(rst),
	.Data_To_Transmit(Data_To_Transmit),
	.LOAD(LOAD),
	.TX_en(TX_en),
	.TX(TX)
);


wire LOAD_EN_wire;
wire TRANSMIT_wire;

wire Done_wire;
wire Bd_cnt_ovf_wire;
//STATE MACHINE FOR TX

UART_TX_SM UART_TX_MOD(
	.clk(clk),
	.rst(rst),
	.LOAD(TX_en),
	.DONE(Done_wire),
	.LOAD_EN(LOAD_EN_wire),
	.TRANSMIT_EN(TRANSMIT_wire)
);

// BAUD RATE
cntr_baud_tx_ovf cntr_baud_tx_ovf_MOD(
	//inputs
	.clk(clk),
	.rst(rst),
	.enb(TRANSMIT_wire),
	.clear(LOAD_EN_wire),
	//outputs
	.ovf(Bd_cnt_ovf_wire)
);

// FRAME COUNTER
 cntr_DATA_tx_ovf	cntr_DATA_tx_ovf_MOD(
	 .clk(clk),
	 .rst(rst),
	 .enb(Bd_cnt_ovf_wire),
	 .clear(LOAD_EN_wire),
	 .ovf(Done_wire)
);
PISO_TX PISO_TX_MOD(
	//inputs
	.clk(clk),
	.rst(rst),
	.LOAD_EN(LOAD_EN_wire),
	.TX_EN(Bd_cnt_ovf_wire),
	.DATA(Data_To_Transmit),
	//outputs
	.TX(TX_wire)
);



/*********************************************************/
initial // Clock generator
  begin
    forever #1 clk = !clk;
  end
  
initial // Clock generator
  begin
    			#5		TX_en = 1;
	end
/*********************************************************/
initial begin // reset generator
	#0 	rst = 1;
	#50 	rst = 0;
	#10 	rst = 1;
end

/*********************************************************/
initial begin // Variables
	#0 	TX_en = 0;

	#10 	Data_To_Transmit = 5;	
	#20000 	TX_en = 1;
	#5 	TX_en = 0;
end/*********************************************************/

endmodule 