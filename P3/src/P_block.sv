// Coder:           Esteban González Moreno

// Date:            12 Mayo 2019

// Name:            P_block.sv

// Description:     Individual Processor module

import Definitions_Package::*;

module P_block
(
	input 			clk,
	input 			rst,
	input 			Enable,		//en_op
	input	  [3:0]  MAT_SIZE,	//mat size
	input	  [2:0]  P_NUM,		//processor number
	input  [19:0]	Last_data,	//data from big pipo
	input   [7:0] 	Vector_IN,	//data from vector
	input   [7:0]	DATA_RAM,	//Data_from
	output  [3:0]	ADDR,
	output  [3:0]	RAM,
	output [19:0] 	OUTPUT	//maximun
);

reg [3:0]reg_ADDR;
reg [3:0]reg_RAM;
reg [3:0]reg_count1;
reg [3:0]reg_count2;
reg [19:0] reg_OUTPUT;


always@(*)
begin
reg_OUTPUT <=  Vector_IN*DATA_RAM;//Last_data + Vector_IN*DATA_RAM;
end
always_ff@(posedge clk or negedge rst) 
	begin
		if(!rst)
			begin
				reg_ADDR	<= 8;	
				reg_RAM	<= {4*{1'b0}};
				reg_count1	<= {4*{1'b0}};
				reg_count2	<= {1'b0,P_NUM};
				//reg_OUTPUT <= {20*{1'b0}};
			end
		else 
			begin
			
				if (Enable)
					begin
						if (reg_count2 <= (MAT_SIZE-1))
							begin
							//	reg_OUTPUT <=  Last_data + Vector_IN*DATA_RAM;
								
								reg_ADDR <= reg_count1;
								reg_RAM <= reg_count2;
								
								reg_count1 <= reg_count1 + 1'b1;
						
								if (reg_count1 >= (MAT_SIZE))
									begin
										
										reg_count2 <= reg_count2+4;
										
										if((reg_count2+4) >= MAT_SIZE)
											begin
												reg_count1 <= 4'h8;
											end
										else
											begin
												reg_count1 <= 0;
											end
									end
								else
									begin
										reg_RAM <= reg_count2;
										reg_count1 <= reg_count1 + 1'b1;
									end
							end
						else
							begin
								//si la ram buscada es mayor al tamaño de la matriz
								//La salida de ADDR debe ser 8 para que no interfiera.
								reg_count1 <= 4'h8;
								reg_count2 <= reg_count2;
							//	reg_OUTPUT <= reg_OUTPUT;
								reg_ADDR <= reg_count1;
							end

					end
				
						
				else
					begin
						//reg_OUTPUT	<= reg_OUTPUT;
						reg_count1 <= reg_count1;
						reg_count2 <= reg_count2;
						reg_ADDR <= reg_ADDR;
					end
			end
	end

assign  	ADDR = reg_ADDR;
assign  	RAM = reg_count2;
assign  	OUTPUT = reg_OUTPUT;	//maximun

endmodule
