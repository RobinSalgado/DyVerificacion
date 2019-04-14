
module top_booth_mult
#(
	// Parameter Declarations
	parameter WORD_LENGTH = 16
	
)

(
	input clk,
	input rst,
	input start,
	input [WORD_LENGTH-1:0] Data1,
	input [WORD_LENGTH-1:0] Data2,
	
	output [(WORD_LENGTH*2)-1:0] result,
	output ready
);

logic [15:0] m_wire;
logic [15:0] acc_wire;
logic [15:0] Sum_Output_wire;
logic [15:0] count_till_ovf_wire;
logic overflow_wire;
logic [(WORD_LENGTH*2)-1:0]prod_wire;
logic [15:0]difference_output_wire;
logic [15:0] mp;
logic oveflow_wire;
logic enb = 1'b1;




 booth_mult M(
 .Sum_Output(Sum_Output_wire),
 .difference_Output(difference_output_wire),
 .prod(prod_wire),
 .ovf(oveflow_wire),
 .mc(Data1), 
 .mp(Data2), 
 .clk(clk),
 .start(start),
 .out_acc(acc_wire),
 .count_till_ovf(count_till_ovf_wire)
 ); 
 
 Adder1 A(
	//input
	 .clk(clk),
	 .rst(rst),
	//input start,
	.Number(acc_wire),
	.Number2(Data1),
	.Enable(Enable),					      //Enables the sum if its not enabled it gives the number 2 in the output
	//Output
	.Sum_Output(Sum_Output_wire),			//Output of the sum
	.FLAG(flag)
	);



substactor S(
	//input
	.clk(clk),
	.rst(rst),
	//input start,
	.Number(acc_wire),
	.Number2(Data1),
	.Enable(Enable),					      //Enables the sum if its not enabled it gives the number 2 in the output
	//Output
	.Sub_Output(difference_output_wire),			//Output of the sum
	.FLAG()
	);


  
 Counter C(
	//Inputs			
	.clk(clk),	
	.rst(rst),	                              //Reset the counter
	.enb(enb),
	.count_till_ovf(count_till_ovf_wire),				//Size of N-1 (number of bits to count -1) number of shifts
	//Output	
	.overflow(oveflow_wire)
	);		
				                        //negated_shift_enable Tells you when it has finished so it stops the shifting
												
assign result = prod_wire;
assign ready = oveflow_wire;

 endmodule  
