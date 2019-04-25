
module Register_Shifter 
(
input               clk,
input               rst,
//input 				  start,
input               enb,
input  [15:0]       DATA,
input  [15:0]       SHIFT_VALUE,
input	 				  Direction_of_shift,
output [15:0]       Reg_Shift_Out
);

logic [15:0]		 reg_S;		//shift reg

always_comb//ff@(posedge clk or negedge rst) 
	begin
//		if(!rst)
//			begin

//				reg_S	= {16*{1'b0}};
				
//			end
//		else if (start)	
//			begin
//				reg_S	<= DATA;
//			end
//		else 
//			begin
//				if (enb == 1)
//					begin
						//reg_S <= DATA;
						if(Direction_of_shift == 0)	//Shifts Rught
							reg_S = DATA >> SHIFT_VALUE;//shift right
						else
							reg_S = DATA << SHIFT_VALUE;//shifts left
//					end
//				else
//					begin
//						reg_S	= reg_S;
//					end
//			end
	end

assign Reg_Shift_Out = reg_S;

endmodule
    