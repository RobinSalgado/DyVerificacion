module Register_Shifter2 
(
input  [31:0]       DATA,

output [31:0]       Reg_Shift_Out
);

assign Reg_Shift_Out = DATA << 1;
//logic [15:0]		 reg_S;		//shift reg

//
//always_comb
//	begin
//		if(Direction_of_shift)
//				reg_S = DATA >> SHIFT_VALUE;//shift right
//		else
//				reg_S = DATA << SHIFT_VALUE;//shifts left
//	end
//
//assign Reg_Shift_Out = reg_S;

endmodule
    