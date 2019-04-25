module alu(out, a, b, cin);
output [15:0] 	out;
input  [15:0]	a;
input  [15:0]	b;
input  cin;


assign out = a + b + cin;

endmodule