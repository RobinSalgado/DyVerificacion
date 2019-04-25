
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module boothDIV_TB;
	bit clk;
	bit rst;
	logic load;
	logic enable;
	logic [15:0] Dividend; 
	logic [15:0] Divisor;
	 //outputs
	logic [15:0]Quotient;
	logic [15:0]Remainder;
	logic busy;
	logic done;

	 boothDIV DUT(
	 //inputs
	. clk(clk),
	. rst(rst),
	. load(load),
	. enable(enable),
	. Dividend(Dividend), 
	. Divisor(Divisor), 	 
	 //outputs
	. Quotient(Quotient),
	. Remainder(Remainder),
	. busy(busy),
	. done(done)
	); 
	
	
	/*********************************************************/
	initial // Clock generator
	  begin
		 forever #2 clk = !clk;
	  end

  
  initial begin // multiplicand generator
	#7 Dividend = 7;
	   Divisor = 3;
	rst = 0;
	load = 0;
	enable = 0;
	#5 rst = 1;

	#10 load = 1;
	#10 load = 0;
	#5 enable = 1;
	
	
  end
  
  
endmodule 