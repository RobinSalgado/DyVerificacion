
//import Parameter_Definitions::*;

module topmod
(
	input clk,
	input rst,
	input start,
	input [15:0]Data,
	input [1:0]op,
	output ready,
		
	output [6:0]ONES,
	output [6:0]TENS,
	output [6:0]HUNDREDS,
	output [6:0]THOUSAND,
	output [6:0]TEN_THOUSAND,
	output sign,
	output ERROR

	//						output LED DISPLAY			// ESTO SE DEBE QUE VER EN EL DISPLAY DE 7 Segmentos
);
// WIRES
wire [15:0] Data_X;
wire [15:0] Data_Y;

wire WIRE_ERROR;
wire WIRE_LOAD_EN_X;
wire WIRE_LOAD_EN_Y;
wire WIRE_OP_EN;
wire WIRE_RDY_EN;
wire WIRE_ERROR_EN;
wire WIRE_VAL_EN;
	
wire WIRE_RESULT;
wire WIRE_REMAINDER;
// ASSIGNS

//DEBOUNCER START

//PIPO MODULES
pipo pipo_X (
.clk(clk),
.rst(rst),
.enb(WIRE_LOAD_EN_X),
.inp(Data),
.out(Data_X)
);

pipo pipo_Y (
.clk(clk),
.rst(rst),
.enb(WIRE_LOAD_EN_Y),
.inp(Data),
.out(Data_Y)
);

//Control Unit

Control_Unit CU_MODULE
(
	//inputs
	. clk(clk),							//Internal clock
	. rst(rst),							//Master_Reset
	. start(start),						//Start the operation
	. done(WIRE_DONE),							//Tell the control when the operation has finished
	. error(WIRE_ERROR),
	. Load(load),
	//outputs
	. Load_X(WIRE_LOAD_EN_X),					//Load x register
	. Load_y(WIRE_LOAD_EN_Y),					//Load y register
	. op_EN(WIRE_OP_EN),
	. ready(WIRE_RDY_EN),						//Tells you when the multiplication has finished
	. error_OUT(WIRE_ERROR_EN),
	. val(WIRE_VAL_EN)
);

// VALIDATION

VALIDATION VAL_MODULE(
	.clk(clk),
	.rst(rst),
	.OP(op),
	.DATAX(Data_X),
	.DATAY(Data_Y),
	.Enable(WIRE_VAL_EN),
	.ERROR(WIRE_ERROR)
);

//MDR

//PE   PE_module(
//	.clk(clk),
//	.rst(rst),
//	.start(start),
//	.DataX(Data_X),
//	.DataY(Data_Y),
//	.op(op),
//
//	.result(WIRE_RESULT),
//	.DONE(WIRE_DONE),
//	.remainder(WIRE_REMAINDER)
//);
endmodule