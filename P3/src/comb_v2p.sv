
module comb_v2p 
(
	input clk,
	input rst,
	input [63:0]	in,
	input [3:0]  	sel_1,
	input [3:0]  	sel_2,
	input [3:0]  	sel_3,
	input [3:0]  	sel_4,
	input [99:0] 	in_LD,
	
	input [3:0] in_Addr1,
	input [3:0] in_Addr2,
	input [3:0] in_Addr3,
	input [3:0] in_Addr4,
	
	output [7:0]	out_P1,
	output [7:0]	out_P2,
	output [7:0]	out_P3,
	output [7:0]	out_P4,
	output [19:0]	out_LD1,
	output [19:0]	out_LD2,
	output [19:0]	out_LD3,
	output [19:0]	out_LD4,
	output [20:0] RES
);
	
reg [7:0] temp1;	
reg [7:0] temp2;	
reg [7:0] temp3;	
reg [7:0] temp4;	

reg[19:0] temp_LD1;
reg[19:0] temp_LD2;
reg[19:0] temp_LD3;
reg[19:0] temp_LD4;

reg [159:0]TOTAL;


always@(*)//_ff@(posedge clk or negedge rst)
			begin
				if(sel_1 == 0)
					begin
						temp1 <= in[7:0];
					end
				else if(sel_1 == 4)
					begin
						temp1 <= in[39:32];
					end
				if(sel_2 == 1)
					begin
						temp2 <= in[15:8];
					end
				else if(sel_2 == 5)
					begin
						temp2 <= in[47:40];
					end
				if(sel_3 == 2)
					begin
						temp3 <= in[23:16];
					end
				else if(sel_3 == 6)
					begin
						temp3 <= in[55:48];
					end
				if(sel_4 == 3)
					begin
						temp4 <= in[31:24];
					end
				else if(sel_4 == 7)
					begin
						temp4 <= in[63:56];
					
					end
	end
	
always_ff@(posedge clk or negedge rst)
	begin		
	if(!rst)
		begin
		temp_LD1 <= 20'b0;
		temp_LD2 <= 20'b0;
		temp_LD3 <= 20'b0;
		temp_LD4 <= 20'b0;
		TOTAL <= {160'b0};//,in_LD[99:80]};
		end
	else
		begin
		//si el addr del P1 es 0 guardar los datos del 0 en 
			if(in_Addr1 == 0)
				begin
					TOTAL[19:0] <= TOTAL[19:0]+in_LD[99:80];
					temp_LD2 <= TOTAL[19:0];
				end
			else if(in_Addr1 == 1)
				begin
					TOTAL[39:20] <= TOTAL[39:20]+in_LD[99:80];
					temp_LD2 <= TOTAL[39:20];
				end
			else if(in_Addr1 == 2)
				begin
					TOTAL[59:40] <= TOTAL[59:40]+in_LD[99:80];
					temp_LD2 <= TOTAL[59:40];
				end
			else if(in_Addr1 == 3)
				begin
					TOTAL[79:60] <= TOTAL[89:60]+in_LD[99:80];
					temp_LD2 <= TOTAL[79:60];
				end
			else if(in_Addr1 == 4)
				begin
					TOTAL[99:80] <= TOTAL[99:80]+in_LD[99:80];
					temp_LD2 <= TOTAL[99:80];
					
				end
			else if(in_Addr1 == 5)
				begin
					TOTAL[119:100] <= TOTAL[119:100]+in_LD[99:80];
					temp_LD2 <= TOTAL[119:100];
				end
			else if(in_Addr1 == 6)
				begin
					TOTAL[139:120] <= TOTAL[139:120]+in_LD[99:80];
					temp_LD2 <= TOTAL[139:120];
				end
			else if(in_Addr1 == 7)
				begin
					TOTAL[159:140] <= TOTAL[159:140]+in_LD[99:80];
					temp_LD2 <= TOTAL[159:140];
				end
			
			
			/////PART 2
				if(in_Addr2 == 0)
				begin
					TOTAL[19:0] <= TOTAL[19:0]+in_LD[79:60];
					temp_LD3 <= TOTAL[19:0];
				end
			else if(in_Addr2 == 1)
				begin
					TOTAL[39:20] <= TOTAL[39:20]+in_LD[79:60];
					temp_LD3 <= TOTAL[39:20];

				end
			else if(in_Addr2 == 2)
				begin
					TOTAL[59:40] <= TOTAL[59:40]+in_LD[79:60];
					temp_LD3 <= TOTAL[59:40];
					
				end
			else if(in_Addr2 == 3)
				begin
					TOTAL[79:60] <= TOTAL[79:60]+in_LD[79:60];
					temp_LD3 <= TOTAL[99:60];
					
				end
			else if(in_Addr2 == 4)
				begin
					TOTAL[99:80] <= TOTAL[99:80] +in_LD[79:60];
					temp_LD3 <= TOTAL[99:80];
					
				end
			else if(in_Addr2 == 5)
				begin
					TOTAL[119:100] <= TOTAL[119:100]+in_LD[79:60];
					temp_LD3 <= TOTAL[119:100];
					
				end
			else if(in_Addr2 == 6)
				begin
					TOTAL[139:120] <= TOTAL[139:120]+in_LD[79:60];
					temp_LD3 <= TOTAL[139:120];
					
				end
			else if(in_Addr2 == 7)
				begin
					TOTAL[159:140] <= TOTAL[159:140]+in_LD[79:60];
					temp_LD3 <= TOTAL[159:140];
					
				end
		
		
		//PART3
		
			if(in_Addr3 == 0)
				begin
					TOTAL[19:0] <= TOTAL[19:0]+in_LD[59:40];
					temp_LD4 <= TOTAL[19:0];
				end
			else if(in_Addr3 == 1)
				begin
					TOTAL[39:20] <= TOTAL[39:20]+in_LD[59:40];
					temp_LD4 <= TOTAL[39:20];
					
				end
			else if(in_Addr3 == 2)
				begin
					TOTAL[59:40] <= TOTAL[59:40] +in_LD[59:40];
					temp_LD4 <= TOTAL[59:40];
					
				end
			else if(in_Addr3 == 3)
				begin
					TOTAL[79:60] <= TOTAL[79:60] +in_LD[59:40];
					temp_LD4 <= TOTAL[79:60];
					
				end
			else if(in_Addr3 == 4)
				begin
					TOTAL[99:80] <= TOTAL[99:80] +in_LD[59:40];
					temp_LD4 <= TOTAL[99:80];
					
				end
			else if(in_Addr3 == 5)
				begin
					TOTAL[119:100] <= TOTAL[119:100]+in_LD[59:40];
					temp_LD4 <= TOTAL[119:100];
					
				end
			else if(in_Addr3 == 6)
				begin
					TOTAL[139:120] <= TOTAL[139:120]+in_LD[59:40];
					temp_LD4 <= TOTAL[139:120];
					
				end
			else if(in_Addr3 == 7)
				begin
					TOTAL[159:140] <= 	TOTAL[159:140] +in_LD[59:40];
					temp_LD4 <= TOTAL[159:140];
					
				end
		
		
		//Part4
		
			if(in_Addr4 == 0)
				begin
					TOTAL[19:0] <=TOTAL[19:0]+ in_LD[39:20];
					temp_LD1 <= TOTAL[19:0];
					
				end
			else if(in_Addr4 == 1)
				begin
					TOTAL[39:20] <= TOTAL[39:20]+in_LD[39:20];
					temp_LD1 <= TOTAL[39:20];
					
				end
			else if(in_Addr4 == 2)
				begin
					TOTAL[59:40] <= TOTAL[59:40]+in_LD[39:20];
					temp_LD1 <= TOTAL[59:40];
					
				end
			else if(in_Addr4 == 3)
				begin
					TOTAL[79:60] <= 	TOTAL[79:60] +in_LD[39:20];
					temp_LD1 <= TOTAL[79:60];
					
				end
			else if(in_Addr4 == 4)
				begin
					TOTAL[99:80] <= TOTAL[99:80]+in_LD[39:20];
					temp_LD1 <= TOTAL[99:80];
					
				end
			else if(in_Addr4 == 5)
				begin
					TOTAL[119:100] <= TOTAL[119:100] +in_LD[39:20];
					temp_LD1 <= TOTAL[119:100];
					
				end
			else if(in_Addr4 == 6)
				begin
					TOTAL[139:120] <= TOTAL[139:120] +in_LD[39:20];
					temp_LD1 <= TOTAL[139:120];
					
				end
			else if(in_Addr4 == 7)
				begin
					TOTAL[159:140] <= TOTAL[159:140]+in_LD[39:20];
					temp_LD1 <= TOTAL[159:140];
					
				end
		end
	end
	
assign out_P1 = temp1;
assign out_P2 = temp2;
assign out_P3 = temp3;
assign out_P4 = temp4;

//assign out_LD1 = temp_LD1;
//assign out_LD2 = temp_LD2;
//assign out_LD3 = temp_LD3;
//assign out_LD4 = temp_LD4;

assign RES = TOTAL;

endmodule
