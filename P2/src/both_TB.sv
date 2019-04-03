
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module booth_TB;

logic [15:0] m;
logic [15:0] q;
bit clk;
//logic rst;
logic [31:0] out;


 booth DUT (

	.m(m),
	.q(q),
	.clk(clk),
	//.rst(rst), 
	.out(out));
	
	
	
	
	/*********************************************************/
	initial // Clock generator
	  begin
		 forever #2 clk = !clk;
	  end

  
  initial begin // multiplicand generator

	
	#7 m = -255;
	#7 q = -255;
	
  end
  
  
  endmodule 