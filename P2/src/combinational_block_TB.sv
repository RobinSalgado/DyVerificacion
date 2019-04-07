
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.


module combinational_block_TB;

   logic [15:0] Q_shifted;
	logic [15:0] R_shifted;
	logic [15:0] D_shifted;
	logic [15:0] D_S2_AND_3_in;
	logic [15:0] D_S2_AND_3;
	logic [15:0] DS2A3_or_RS2;
	logic [15:0] QS2_or_1;
	logic [15:0] QS2_or_3;
	logic [15:0] QS1_or_1;
	logic [15:0] QS2;

 combinational_block DUT
(
   . Q_shifted(Q_shifted),
	. R_shifted(R_shifted),
	. D_shifted(D_shifted),
	. D_S2_AND_3_in(D_S2_AND_3_in),
	. D_S2_AND_3(D_S2_AND_3),
	. DS2A3_or_RS2(DS2A3_or_RS2),
	. QS2_or_1(QS2_or_1),
	. QS2_or_3(QS2_or_3),
	. QS1_or_1(QS1_or_1),
	. QS2(QS2)
);
		
	/*********************************************************/
	
  
  initial begin // multiplicand generator
	  Q_shifted = 7;
	  R_shifted = 7;
	  D_shifted  = 7;
	  D_S2_AND_3_in = 7;
	  
  end
  
  
endmodule 