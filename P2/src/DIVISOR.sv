//import Parameter_Definitions::*;

module DIVISOR
(
	//Inputs			
	input 			clk,
	input 			rst,
	input 			start,
	input 			enable,
	input  			LOAD_Dividend,
	input  			LOAD_Divisor,
	input  [15:0]	Data,
	output [15:0]	Result,
	output [15:0]	Residue,//negated_shift_enable Tells you when it has finished so it stops the shifting
	output 			ready
	);

//WIRES
wire [15:0] WIRE_DIVIDEND;
wire [15:0] WIRE_DIVISOR;

wire [15:0] WIRE_Q1;
wire [15:0] WIRE_Q2;

wire [15:0] WIRE_A;
wire [31:0] WIRE_AQ_S1;

wire WIRE_COUNTER_FLAG;

wire [15:0] WIRE_REST;
wire [15:0] WIRE_SUM;

wire [15:0] WIRE_AFTER_OP;

wire [15:0] WIRE_A_REF;

wire [31:0] WIRE_AQ;
wire WIRE_QN;
//Register Dividend
PIPO PIPO_DIVIDEND_MOD
(
	.clk(clk),
	.rst(rst),
	.LOAD(LOAD_Dividend),
	.DATA(Data),
	.OUT(WIRE_DIVIDEND)
);
//Register Divisor
PIPO PIPO_DIVISOR_MOD
(
	.clk(clk),
	.rst(rst),
	.LOAD(LOAD_Divisor),
	.DATA(Data),
	.OUT(WIRE_DIVISOR)
);	

//Reset_A DIVIDEND <0
DIVISOR_A  Multiplexor_D1
(
	// Input 
	. Condition(WIRE_DIVIDEND),
	. init(start),
	. A(WIRE_AQ[31:16]),
	// Output 
	. OUT(WIRE_A),
	. OUT_ref(WIRE_A_REF)
);


//MULTIPLEXER Q <0
Multiplexor_D Multiplexor_D2
(
	// Input 
//	. clk(clk),
	. Selector(enable),
	. REG1(WIRE_AQ[15:0]),
	. REG2(WIRE_DIVIDEND),
	// Output 
	. Output(WIRE_Q1)
);

// SHIFTER
Register_Shifter2 SHIFTER_MOD_DIV
(
	. DATA({WIRE_A,WIRE_Q1}),
//	. SHIFT_VALUE(1'b1),
//	. Direction_of_shift(1'b0),
	. Reg_Shift_Out(WIRE_AQ_S1)
);

// COUNTER


Counter_DIV Counter_DIV_MOD
(
	//Inputs			
	. clk(clk),
	. rst(rst),	//Reset the counter
	. enb(enable),
	//Output	
	. overflow(WIRE_COUNTER_FLAG) 								//negated_shift_enable Tells you when it has finished so it stops the shifting

);

//sumador
alu SUM_MOD(
	.a(WIRE_A),
	.b(WIRE_DIVISOR),
	.cin(1'b0),
	.out(WIRE_SUM)
	);
//Restador
alu REST_MOD(
	.a(WIRE_A),
	.b(~WIRE_DIVISOR),
	.cin(1'b1),
	.out(WIRE_REST)
);

//MULTIPLEXER M31 = A31
Multiplexor_D Multiplexor_D3
(
	// Input 
//		. clk(clk),
	. Selector(WIRE_DIVISOR[15] ~^ WIRE_AQ_S1[31]),
	. REG1(WIRE_REST),
	. REG2(WIRE_SUM),
	// Output 
	. Output(WIRE_AFTER_OP)
);

// combinational module
Comb_Block_DIV COMB_DIV_MOD(
	. clk(clk),
	. Q(WIRE_Q1),
	. S(WIRE_AQ_S1[31]),
	. A_SHIFT1(WIRE_AQ_S1),
	. A_AFTER_OP(WIRE_AFTER_OP),
	. A_REF(WIRE_A_REF),
	. AQ(WIRE_AQ),
	. QN(WIRE_QN)
);

assign Result = WIRE_Q1;
assign Residue = WIRE_A;
assign ready = WIRE_COUNTER_FLAG;
endmodule