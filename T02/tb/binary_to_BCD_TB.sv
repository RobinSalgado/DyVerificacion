
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module binary_to_BCD_TB;
reg [7:0] A; 
wire [3:0] ONES, TENS;
wire [1:0] HUNDREDS; 

 binary_to_BCD UTT(A,ONES,TENS,HUNDREDS);
 
initial begin 
A = 0;

#30 A =  155;
#50 A = 248;
#100 A = 15;


end


endmodule 