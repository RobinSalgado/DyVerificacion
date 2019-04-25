


module Multiplexer_With_Case(in1, in2, in3, sel, out);
parameter Word_Length = 16;
input [1:0] sel;
input [Word_Length - 1:0] in1, in2, in3;
output [Word_Length - 1:0] out;

logic [Word_Length - 1:0] out;

always_comb begin
	  case (sel)
		2'b00: out = in1;
		2'b01: out = in2;
		2'b10: out = in3;
		default: out = 0;
	endcase
end
endmodule
