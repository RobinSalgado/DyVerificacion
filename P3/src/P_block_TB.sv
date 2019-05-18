
// Coder:           Esteban González Moreno

// Date:            15 Mayo 2019

// Name:            UART.sv

// Description:     UART top module

import Definitions_Package::*;

module P_block_TB;
	//inputs
	bit 					clk;
	bit 					rst;
	
	
	logic 			Enable;		//en_op
	logic	  [3:0]  MAT_SIZE;	//mat size
	logic	  [2:0]  P_NUM;   	//processor number
	logic  [19:0]	Last_data;	//data from big pipo
	logic   [7:0] 	Vector_IN;	//data from vector
	logic   [7:0]	DATA_RAM;	//Data_from
	logic  [3:0]	ADDR;
	logic  [3:0]	RAM;
	logic [19:0] 	OUTPUT;	//maximun
	

P_block DUT(
	.clk(clk),
	.rst(rst),
	.Enable(Enable),		//en_op
	.MAT_SIZE(MAT_SIZE),	//mat size
	.P_NUM(P_NUM),		//processor number
	.Last_data(Last_data),	//data from big pipo
	.Vector_IN(Vector_IN),	//data from vector
	.DATA_RAM(DATA_RAM),	//Data_from
	.ADDR(ADDR),
	.RAM(RAM),
	.OUTPUT(OUTPUT)	//maximun
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
			MAT_SIZE = 4'h4;
			Enable	= '0;
			P_NUM		= 4'h1;
			Last_data = 4'h2;
			Vector_IN = 4'h2;
			DATA_RAM = 4'h3;
			
	//FIRST COMMAND	

	#100			Enable 	= 1;
	#2		Last_data = 4'h3;
			DATA_RAM = 4'h4;
	#2		Last_data = 4'h4;
			DATA_RAM = 4'h5;
	#2		Last_data = 4'h5;
			DATA_RAM = 4'h6;
			
	
	#100			Enable 	= 0;

end/*********************************************************/

endmodule
