
module siso

 #(parameter DW = 4)
 
 (
input               clk,
input               rst,
input               enb,
input               inp,
input					  left_right,
output              out
);

logic [DW-1:0]      rgstr_r;

always_ff@(posedge clk or negedge rst) begin: rgstr_label
    if(!rst)
        rgstr_r  <= '0;
    else if (enb)
		if(!left_right)
			rgstr_r <= {rgstr_r[DW-2:0],inp};
		else
			rgstr_r <= {inp, rgstr_r[DW-1:1]};
end:rgstr_label

assign out  = rgstr_r[DW-1];

//TODO: try to design a siso register where shifting is performed to the right instead of the left

endmodule

