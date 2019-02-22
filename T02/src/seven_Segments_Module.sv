////////////////////////////////////////////
/////												/////
/////			Robin Moisés Salgado			/////
/////			   SEVEN SEG MODULE        /////
/////				  12/02/19					/////
/////												/////
////////////////////////////////////////////	

module seven_Segments_Module
(
	input [3:0] ones,
	input [3:0] cents,
	input [3:0] hundreds,
	
	output [6:0] seg_Ones,
	output [6:0] seg_Cents,
	output [6:0] seg_Hundreds
	
);

bit [6:0] d_Ones;
bit [6:0] d_Cents;
bit [6:0] d_Hundreds;

always_comb 

begin

case(ones)
                            

	4'b0000: d_Ones = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	
	4'b0001: d_Ones = {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
	
	4'b0010: d_Ones = {1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1};
	
	4'b0011: d_Ones = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1};
	
	4'b0100: d_Ones = {1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
	
	4'b0101: d_Ones = {1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1};
	
	4'b0110: d_Ones = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1};
	
	4'b0111: d_Ones = {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1};
	
	4'b1000: d_Ones = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	
	4'b1001: d_Ones = {1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1};
	
	default: d_Ones = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
endcase

case(cents)
                             

	4'b0000: d_Cents = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	
	4'b0001: d_Cents = {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
	
	4'b0010: d_Cents = {1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1};
	
	4'b0011: d_Cents = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1};
	
	4'b0100: d_Cents = {1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
	
	4'b0101: d_Cents = {1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1};
	
	4'b0110: d_Cents = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1};
	
	4'b0111: d_Cents = {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1};
	
	4'b1000: d_Cents = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	
	4'b1001: d_Cents = {1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1};
	
	default: d_Cents = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
endcase

case(hundreds)
                          

	4'b0000: d_Hundreds = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	
	4'b0001: d_Hundreds = {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
	
	4'b0010: d_Hundreds = {1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1};
	
	4'b0011: d_Hundreds = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1};
	
	4'b0100: d_Hundreds = {1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
	
	4'b0101: d_Hundreds = {1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1};
	
	4'b0110: d_Hundreds = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1};
	
	4'b0111: d_Hundreds = {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1};
	
	4'b1000: d_Hundreds = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	
	4'b1001: d_Hundreds = {1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1};
	
	default: d_Hundreds = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
endcase

end

assign seg_Ones = (~d_Ones);
assign seg_Cents = (~d_Cents);
assign seg_Hundreds = (~d_Hundreds);
	
endmodule 