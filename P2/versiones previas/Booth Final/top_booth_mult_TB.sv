timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module top_booth_mult_TB;

parameter WORD_LENGTH = 16;
reg clk, start,rst; 
reg [WORD_LENGTH-1:0]Data1, Data2;
wire [31:0]result;
wire ready;


top_booth_mult
#(
	// Parameter Declarations
	.WORD_LENGTH(WORD_LENGTH)
	
)
DUT
(
	.clk(clk),
	.rst(rst),
	.start(start),
	.Data1(Data1), 
	.Data2(Data2),
	.result(result),
	.ready(ready)
);

/*********************************************************/
initial // Clock generator
  begin
    forever #5 clk = !clk;
  end
/*********************************************************/

initial begin 
 
 Data1 = 10;
 Data2 = 10; 
 #10 start = 1;
 #15 start = 0; 
 
 end 

/*********************************************************/
initial begin // reset generator
	#0 rst = 0;
	#5 rst = 1;
end




endmodule 