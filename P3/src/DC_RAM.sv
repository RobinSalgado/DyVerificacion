
// Coder:           Esteban González Moreno

// Date:            10 Mayo 2019

// Name:            DC_RAM.sv

// Description:     DC_RAM

//`ifndef DP_DC_RAM_SV
//   `define DP_DC_RAM_SV
	
	
module DC_RAM
(
	input clk_A, 
	input clk_B,
	input [7:0] Data_IN,
	input [3:0]	ADDR,
	input	ENABLE_W,
	input	ENABLE_R,
	
	output [7:0] DATA_OUT
);

reg [7:0] temp;
	// Declare the RAM variable
	reg [7:0] ram[3:0];
	
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
	end

	assign DATA_OUT = temp;
	
endmodule

