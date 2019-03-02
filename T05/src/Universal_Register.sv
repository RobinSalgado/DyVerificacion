module Universal_Register #(
parameter DW = 4
) (
input               clk,    			// Clock
input               rst,    			// asynchronous reset low active 
input               enb,    			// Enable
input               l_s,   			// load or shift
input  [DW-1:0]     inp,    			// data input
input					  left_right,		// Left shift by default, right shift by selection
input	 [1:0]		  selector,			// Selects the operation mode.
output [DW-1:0]     out     			// Serial output
);

logic [DW-1:0]      rgstr_r;

enum{pipo,sipo,siso,piso} REG_TYPE;		

/************************/
/****** WIRES    ********/
/************************/

logic [DW-1:0] PIPO_OUT;
logic [DW-1:0] SIPO_OUT;
logic SISO_OUT;
logic PISO_OUT;

/************************/
/***** PIPO MODULE  *****/
/************************/

pipo PIPO_inst
(
   .clk(clk),
   .rst(rst),
   .enb(enb),
	.inp(inp),
	.out(PIPO_OUT)

);

/************************/
/***** SIPO MODULE  *****/
/************************/

sipo SIPO_inst
(
   .clk(clk),
   .rst(rst),
   .enb(enb),
	.inp(inp[DW-1]),
	.left_right(left_right),
	.out(SIPO_OUT)

);

/************************/
/***** SISO MODULE  *****/
/************************/

siso SISO_inst
(
   .clk(clk),
   .rst(rst),
   .enb(enb),
	.inp(inp[DW-1]),
	.left_right(left_right),
	.out(SISO_OUT)

);

/************************/
/***** PISO MODULE  *****/
/************************/

piso PISO_inst
(
   .clk(clk),
   .rst(rst),
   .enb(enb),
	.inp(inp),
	.l_s (l_s),
	.left_right(left_right),
	.out(PISO_OUT)

);



always_ff@(posedge clk or negedge rst) begin: rgstr_label
	
	if(!rst)							
			  rgstr_r  <= '0;
	
	else if (enb)
		begin
			case(selector)
				pipo: begin
							rgstr_r <= PIPO_OUT;
						end
				sipo: begin							//Creo que no es necesario hacer un case para left and right
							rgstr_r <= SIPO_OUT;
						end
				siso: begin
						rgstr_r  <= '0;
							rgstr_r <= {SISO_OUT,3'b000};
						end
				piso: begin
						rgstr_r  <= '0;
							rgstr_r <= {PISO_OUT,3'b000};
						end
				endcase
		end
end:rgstr_label 

assign out  = rgstr_r;    // MSB bit is the first to leave



endmodule
