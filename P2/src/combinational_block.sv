module combinational_block(
	input [15:0] Q_shifted,
	input [15:0] Q_S1,	
	input [15:0] R_shifted,
	input [15:0] D_shifted,
	input [15:0] D_S2_AND_3_in,
	output [15:0] D_S2_AND_3,
	output [15:0] DS2A3_or_RS2,
	output [15:0] QS2_or_1,
	output [15:0] QS2_or_3,
	output [15:0] QS1_or_1

);

assign QS1_or_1 = Q_S1 | 1;//{Q_S1[15:1],1'b1};
assign D_S2_AND_3 = D_shifted & 3;
assign DS2A3_or_RS2 = D_S2_AND_3_in | R_shifted;
assign QS2_or_1 = Q_shifted | 1;
assign QS2_or_3 = Q_shifted | 3;



endmodule