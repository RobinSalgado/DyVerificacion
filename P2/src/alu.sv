//The following is an alu.  
 //It is an adder, but capable of subtraction: 
 //Recall that subtraction means adding the two's complement-- 
 //a - b = a + (-b) = a + (inverted b + 1) 
 //The 1 will be coming in as cin (carry-in) 
module alu(out, a, b, cin); 
output [15:0] out;
 input [15:0] a; 
 input [15:0] b; 
 input cin; 
 
assign out = a + b + cin; 
 
endmodule 