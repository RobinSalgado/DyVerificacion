
// Coder:           Esteban González Moreno

// Date:            07 Mayo 2019

// Name:            TOP_MODULE.sv

// Description:     This is the TOP Module



import Definitions_Package::*;

module DATA_FEEDER(
	input 			clk,
	input 			rst,
	input				SIZE_M_EN,
	input [7:0]		REC_DATA,
	input 			Enable_MAT,		//enable cruzado del SM  y la UART
	input				Enable_VEC,
	input 			CLEAR,
	input				ENB_ASSIGN,
	
	output [7:0]	ADDR,
	output [3:0]	RAM_Num,
	output [7:0]	DATA,
	output [3:0] 	PIPO_VEC
);
	
reg [3:0] 	Matrix_SIZE;
reg [7:0]	TEMP;
reg [7:0]	ADDR_TEMP;
reg [3:0]	count1;
reg [3:0]	count2;

always_ff@(posedge clk or negedge rst)
	begin
		if(!rst) 
			begin
				count1 <= 4'b0;
				count2 <= 4'b0;
				ADDR_TEMP <= 8'b0;
				TEMP <= 8'b0;
				Matrix_SIZE <= 4'b0;
			end
		else if (CLEAR)
			begin
				count1 <= 4'b0;
				count2 <= 4'b0;
				ADDR_TEMP <= 8'b0;
				TEMP <= 8'b0;
				Matrix_SIZE <= 4'b0;
			end
			
		else if(SIZE_M_EN)
			Matrix_SIZE <= REC_DATA;
		
		else if (ENB_ASSIGN)
			begin
				if(Enable_MAT)
					begin
						TEMP <= REC_DATA;
						if(count1 >= Matrix_SIZE)
							begin
								count1 <= 4'b0;
								count2 <= count2 + 1'b1;
							end
						else
							count1 <= count1+1'b1;
					end
				else if(Enable_VEC)
					begin
						TEMP <= REC_DATA;
						if(count1 >= Matrix_SIZE)
							count1 <= 4'b0;
						else
							count1 <= count1+1'b1;
					end	
				else
					begin
						count1 <= count1;
						count2 <= count2;
						ADDR_TEMP <= ADDR_TEMP;
						TEMP <= TEMP;
						Matrix_SIZE <= Matrix_SIZE;
					end
			end
end


	
assign	ADDR = count2;
assign   RAM_Num = count1;
assign	PIPO_VEC = count1;
assign	DATA = TEMP;

endmodule
