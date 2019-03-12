
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module binary_to_BCD_14_TB;
reg [13:0] A; 
wire [3:0] ONES, TENS;
wire [3:0] HUNDREDS,THOUSAND;
wire [1:0] TEN_THOUSAND;

 binary_to_BCD_14 UTT(A,ONES,TENS,HUNDREDS,THOUSAND,TEN_THOUSAND);
 
initial begin 
A = 0;

#30 A = 11704;
#50 A = 248;
#100 A = 15;


end


endmodule 