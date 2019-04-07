
module booth21_TB; 
 
reg clk, start; 
reg [15:0] mc, mp; 
 
wire [31:0] prod; 
wire busy; 
 
booth21 multiplier1(prod, busy, mc, mp, clk, start); 
 
initial begin 
clk = 0; 

mc = 40;
mp = -42; 
 start = 1;
 #50 start = 0; 
 
 

 end 
 
always #5 clk = !clk; 

 
endmodule 