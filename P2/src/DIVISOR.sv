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
		
	input [15:0] SUM,
	input [15:0] SUB,
	output [15:0] A,
	output [15:0]DIVISO,
	
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
	assign A = WIRE_A;
	assign DIVISO = WIRE_DIVISOR;
//sumador
//alu SUM_MOD(
//	.a(WIRE_A),
//	.b(WIRE_DIVISOR),
//	.cin(1'b0),
//	.out(WIRE_SUM)
//	);
////Restador
//alu REST_MOD(
//	.a(WIRE_A),
//	.b(~WIRE_DIVISOR),
//	.cin(1'b1),
//	.out(WIRE_REST)
//);

//MULTIPLEXER M31 = A31
Multiplexor_D Multiplexor_D3
(
	// Input 
//		. clk(clk),
	. Selector(WIRE_DIVISOR[15] ~^ WIRE_AQ_S1[31]),
	. REG1(SUB),
	. REG2(SUM),
	// Output 
	. Output(WIRE_AFTER_OP)
);

// combinational module
Comb_Block_DIV COMB_DIV_MOD(

	. start_over(WIRE_COUNTER_FLAG),
	. Start_Data(WIRE_DIVIDEND),
	
	. clk(clk),
	. Q(WIRE_Q1),
	. S(WIRE_AQ_S1[31]),
	. A_SHIFT1(WIRE_AQ_S1),
	. A_AFTER_OP(WIRE_AFTER_OP),
	. A_REF(WIRE_A_REF),
	. AQ(WIRE_AQ),
	. QN(WIRE_QN)
);

wire [15:0] WIRE_Q1_TEMP;
wire [15:0] WIRE_A_TEMP;
PIPO PIPO_FINAL_MOD_Q
(
	.clk(clk),
	.rst(rst),
	.LOAD(WIRE_COUNTER_FLAG),
	.DATA(WIRE_Q1),
	.OUT(WIRE_Q1_TEMP)
);
PIPO PIPO_FINAL_MOD_A
(
	.clk(clk),
	.rst(rst),
	.LOAD(WIRE_COUNTER_FLAG),
	.DATA(WIRE_A),
	.OUT(WIRE_A_TEMP)
);

//assign Result = WIRE_Q1_TEMP;
//assign Residue = WIRE_A_TEMP;
/*************/
//SIGN CORRECTION
wire [15:0] WIRE_result;
wire [15:0] WIRE_residue;
SIGN_DIV SIGN_DIV_MOD(
	.Divisor_Sign(WIRE_DIVISOR[15]),
	.Dividend_Sign(WIRE_DIVIDEND[15]),
	.Result_RAW(WIRE_Q1_TEMP),
	.Residue_RAW(WIRE_A_TEMP),
	.Result(WIRE_result),
	.Residue(WIRE_residue)
);
//assign Result = WIRE_result;
//assign Residue = WIRE_residue;

assign Result = WIRE_Q1;
assign Residue = WIRE_A;

/*************/
//assign Result = WIRE_Q1;
//assign Residue = WIRE_A;
assign ready = WIRE_COUNTER_FLAG;
endmodule