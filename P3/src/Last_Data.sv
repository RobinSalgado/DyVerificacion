//Last Data block?
module Last_Data(
	input clk,
	input rst,
	input [19:0] 	IN_P1,
	input [19:0]	IN_P2,
	input [19:0]	IN_P3,
	input [19:0]	IN_P4,
	
	input 			P1_EN,
	input 			P2_EN,
	input 			P3_EN,
	input 			P4_EN,
	
	input [3:0]		P1_ADDR,
	input [3:0]		P2_ADDR,
	input [3:0]		P3_ADDR,
	input [3:0]		P4_ADDR,
	output [99:0]OUT_LD,
	output	[19:0] temp [7:0]
);

reg [19:0] reg_temp [7:0];
reg [3:0] P1_ADDR_temp1 ;
reg [3:0] P1_ADDR_temp2 ;
reg [3:0] P1_ADDR_temp3 ;
reg [3:0] P1_ADDR_temp4 ;
always_ff@(posedge clk or negedge rst)begin
	if(!rst)
		begin
			P1_ADDR_temp1 <= 4'h8;
			P1_ADDR_temp2 <= 4'h8;
			P1_ADDR_temp3 <= 4'h8;
			P1_ADDR_temp4 <= 4'h8;
		end
	else
		begin
			if(P1_EN)
				P1_ADDR_temp1 <= P1_ADDR;
			else
				P1_ADDR_temp1 <= P1_ADDR_temp1;
				
				
			if(P2_EN)
				P1_ADDR_temp2 <= P2_ADDR;
			else
				P1_ADDR_temp2 <= P1_ADDR_temp2;

				
			if(P3_EN)
				P1_ADDR_temp3 <= P3_ADDR;
			else
				P1_ADDR_temp3 <= P1_ADDR_temp3;

				
			if(P4_EN)
				P1_ADDR_temp4 <= P4_ADDR;
			else
				P1_ADDR_temp4 <= P1_ADDR_temp4;

		end	
end
always_ff@(posedge clk or negedge rst)begin
	if(!rst)
		begin
			reg_temp [0] <= 20'b0;
			reg_temp [1] <= 20'b0;
			reg_temp [2] <= 20'b0;
			reg_temp [3] <= 20'b0;
			reg_temp [4] <= 20'b0;
			reg_temp [5] <= 20'b0;
			reg_temp [6] <= 20'b0;
			reg_temp [7] <= 20'b0;
		end
	else
		begin
			
			reg_temp [P1_ADDR_temp1] <= IN_P1;
			reg_temp [P1_ADDR_temp2] <= IN_P2;
			reg_temp [P1_ADDR_temp3] <= IN_P3;
			reg_temp [P1_ADDR_temp4] <= IN_P4;

				
		end
end
assign OUT_LD = {reg_temp[4],reg_temp[3],reg_temp[2],reg_temp[1],reg_temp[0]};//{{reg_temp[0]},{reg_temp[1]},{reg_temp[2]},{reg_temp[3]},{reg_temp[4]},{reg_temp[5]},{reg_temp[6]},{reg_temp[7]}};      
assign temp = reg_temp;
endmodule
