import Parameter_Definitions::*;

module Register_Shifter 
(
input               clk,
input               rst,
input 				  start,
input 					EF,
input               enb,
input  [NBits-1:0] 	inp_Multiplier,
input  [NBits-1:0]		inp_Multiplicand,
output [2*NBits-1:0]    out_Multiplier,
output [NBits-1:0]		out_Multiplicand
);

logic [2*NBits-1:0]		rgstr_Multiplier;		//shifts left
logic [NBits-1:0]      rgstr_Multiplicand;	//shift right

always_ff@(posedge clk or negedge rst) 
	begin: rgstr_label
		if(!rst)
			begin

				rgstr_Multiplier	<= {2*NBits{1'b0}};
				rgstr_Multiplicand  <= {NBits{1'b0}};			
			end
		else if (start)	
			begin
				rgstr_Multiplier	<= {{NBits{1'b0}},inp_Multiplier};
				rgstr_Multiplicand  <= {inp_Multiplicand};			
			end
		else if (!enb)
			begin
									rgstr_Multiplier  <= {rgstr_Multiplier[2*NBits-2:0],1'b0};//shifts left
									rgstr_Multiplicand <= {1'b0,rgstr_Multiplicand[NBits-1:1]};

					end
		else
			begin
				rgstr_Multiplier	<= rgstr_Multiplier;
				rgstr_Multiplicand <= rgstr_Multiplicand;
			end
	end:rgstr_label

assign out_Multiplicand = rgstr_Multiplicand;
assign out_Multiplier = rgstr_Multiplier;

endmodule
    