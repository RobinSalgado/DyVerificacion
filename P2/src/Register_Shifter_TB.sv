

timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.



module Register_Shifter_TB ;

bit               clk;
bit               rst;
//input 				  start,
logic               enb;
logic  [15:0]       DATA;
logic  [15:0]       SHIFT_VALUE;
logic	 				  Direction_of_shift;
logic  [15:0]       Reg_Shift_Out;



 Register_Shifter DUT
(
.              clk(clk),
.              rst(rst),
//input 				  start,
.              enb(enb),
.              DATA(DATA),
.              SHIFT_VALUE(SHIFT_VALUE),
.	 				Direction_of_shift(Direction_of_shift),
.              Reg_Shift_Out(Reg_Shift_Out)
);

	/*********************************************************/
	initial // Clock generator
	  begin
		 forever #2 clk = !clk;
	  end

  
  initial begin // multiplicand generator
	enb = 0;
	SHIFT_VALUE = 2;
	Direction_of_shift = 0;
	#10 DATA = 8;
		rst = 0;
	#1	rst = 1;
	
	
	#200	enb = 1;
	#400 enb = 0;
	#50 rst = 0;
  end
  
  
endmodule 