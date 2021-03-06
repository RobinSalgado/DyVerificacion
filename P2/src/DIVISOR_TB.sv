timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module DIVISOR_TB;

	//Inputs			
	bit 			clk;
	bit 			rst;										
	logic 			enable;
	logic				start;
	logic  			LOAD_Dividend;
	logic  			LOAD_Divisor;
	logic [15:0]	Data;
	logic [15:0]	Result;
	logic [15:0]	Residue;//negated_shift_enable Tells you when it has finished so it stops the shifting
	logic 			ready;
DIVISOR DUT
(
	//Inputs			
	. 	clk(clk),
	. 	rst(rst),										
	. 	enable(enable),
	.  start(start),
	.  LOAD_Dividend(LOAD_Dividend),
	.  LOAD_Divisor(LOAD_Divisor),
	.  Data(Data),
	. 	Result(Result),
	.	Residue(Residue),//negated_shift_enable Tells you when it has finished so it stops the shifting
	. 	ready(ready)
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
//		. clk(clk),
	. Selector(enable),//WIRE_DIVIDEND[15]),
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
	
	.start_over(WIRE_COUNTER_FLAG),
	. Start_Data(WIRE_DIVIDEND),
		
	. clk(clk),
	. S(WIRE_AQ_S1[31]),
	. Q(WIRE_Q1),
	. A_SHIFT1(WIRE_AQ_S1),
	. A_AFTER_OP(WIRE_AFTER_OP),
	. A_REF(WIRE_A_REF),
	. AQ(WIRE_AQ),
	. QN(WIRE_QN)
);

/*********/
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

/********/
	/*********************************************************/
	initial // Clock generator
	  begin
		 forever #2 clk = !clk;
	  end

  
  initial begin // multiplicand generator
//Valores iniciales
			enable = 0;
			rst = 0;
			LOAD_Dividend = 0;
			LOAD_Divisor = 0;
	#1		rst = 1;
			start = 0;

//Cargamos dividendo
	#10 	Data = 7;
			LOAD_Dividend = 1;
	#5		LOAD_Dividend = 0;
//cargamos divisor	
	#10 	Data = -3;
			LOAD_Divisor = 1;
	#5		LOAD_Divisor = 0;
	#5		start  = 1;
	#5		start  = 0;
// Iniciamos la operacion
	#400	enable = 1;
	
	#400		enable = 0;
	
	#10 	Data = 7;
			LOAD_Dividend = 1;
	#5		LOAD_Dividend = 0;
//cargamos divisor	
	#10 	Data = -3;
			LOAD_Divisor = 1;
	#5		LOAD_Divisor = 0;
	#100	start  = 1;
	#5		start  = 0;
	#400	enable = 1;
	
	#500 	rst = 0;
  end
  
  
endmodule 