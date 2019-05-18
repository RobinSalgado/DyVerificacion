
// Coder:           Esteban González Moreno

// Date:            10 Mayo 2019

// Name:            DC_RAM.sv

// Description:     DC_RAM

//`ifndef DP_DC_RAM_SV
//   `define DP_DC_RAM_SV
	

import Definitions_Package::*;
module DC_RAM
(
	input clk_A, 
	input clk_B,
	input word_lenght_t Data_IN,
	input ADDR_lenght_t	ADDR,
	input	ENABLE_W,
	input	ENABLE_R,
	
	output word_lenght_t DATA_OUT
);

word_lenght_t temp;
	// Declare the RAM variable
word_lenght_t ram[ADDR_LENGHT:0] ;
	
always @ (posedge clk_A)
	begin
		// Write
		if (ENABLE_W)
			ram[ADDR] <= Data_IN;
	end
	
	always @ (posedge clk_B)
	begin
		// Read 
		if (ENABLE_R)
			temp <= ram[ADDR];
		else
			temp <= 8'b0;
	end

	assign DATA_OUT = temp;
	
endmodule

