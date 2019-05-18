
// Coder:           Esteban González Moreno

// Date:            08 Mayo 2019

// Name:            SIPO_RX.sv

// Description:    SIPO for UART RX



import Definitions_Package::*;

 module SIPO_RX(
 
	input clk,
	input rst,
	input clear,
	input enb,
	input in,
	output sipo_lenght_t SIPO_OUT
);

sipo_lenght_t temp;

always@(posedge clk or negedge rst)
	begin
		if(!rst)
			temp <= 16'b0;
		else if (clear)
			temp <= 16'b0;
		else if (enb)
			begin
				temp <= temp << 1'b1;
				temp[0] <= in;
			end
end
assign SIPO_OUT =temp;
endmodule