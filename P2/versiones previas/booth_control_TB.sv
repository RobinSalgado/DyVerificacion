
module booth_control_TB; 
 
reg clk, start; 
reg [15:0] mc, mp; 
 
wire [31:0] prod; 
wire busy; 
 
booth_control multiplier1(prod, busy, mc, mp, clk, start); 
 
initial begin 
clk = 0; 

mc = 10;
mp = 10; 
 start = 1;
 #10 start = 0; 
 
 

 end 
 
always #5 clk = !clk; 

 
endmodule 