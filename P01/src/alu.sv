
import definitions_pkg::*;

module alu(out, a, b, cin);
output int8_t	out;
input  int8_t    a;
input  int8_t	  b;
input  cin;


assign out = a + b + cin;

endmodule