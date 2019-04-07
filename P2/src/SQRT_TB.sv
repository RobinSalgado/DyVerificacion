
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.


module SQRT_TB;
	//Inputs			
	bit clk;
	bit rst;										
	logic enable;
	logic [15:0]Data;
	logic [15:0]Result;
	logic [15:0]Residue;//negated_shift_enable Tells you when it has finished so it stops the shifting
	logic ready;
	
	
logic WIRE_RDY;
logic WIRE_COUNTER_FLAG;
logic [15:0] WIRE_count;
logic WIRE_OVF;

logic WIRE_SHIFT_EN;
logic [15:0] WIRE_DS2_OUT;

logic [15:0]WIRE_R;
logic [15:0]WIRE_Q;

logic [15:0] WIRE_QS1_OUT;
logic [15:0] WIRE_QS2_OUT;
logic [15:0] WIRE_RS2_OUT;
logic [15:0] WIRE_D_S2_AND_3;
logic [15:0] WIRE_DS2A3_or_RS2;
logic [15:0] WIRE_QS2_or_1;
logic [15:0] WIRE_QS2_or_3;
logic [15:0] WIRE_QS1_or_1;

logic WIRE_MUX_FLAG;

logic WIRE_MUX_FLAG2;

logic MUX_EN1;
logic MUX_EN2;

logic WIRE_OP_EN;
logic [15:0]WIRE_SUM;
logic [15:0]WIRE_SUB;
logic WIRE_SUM_FLAG;
logic WIRE_SUB_FLAG;


SQRT DUT (

	. clk(clk),
	. rst(rst),										
	. enable(enable),
	. Data(Data),
	. Result(Result),
	. Residue(Residue),//ne
	. ready(ready)
	);

	



// SQRT_SM
SM_SQRT	SM_MOD
(
. 				clk(clk),
. 				rst(rst),
.       		EN(enable),
.           COUNTER_FLAG(WIRE_OVF),
//.       		SHIFTER_FLAG(),
. 				MUX_FLAG(WIRE_MUX_FLAG),
. 				MUX_FLAG2(WIRE_MUX2_FLAG),
. 				ADDR_OR_REST_FLAG(WIRE_SUB_FLAG),


.				counter_EN(WIRE_COUNTER_FLAG),
.				SHIFT_EN(WIRE_SHIFT_EN),
.				MUX_EN(MUX_EN1),
. 				MUX_EN2(MUX_EN2),
.				OP_EN(WIRE_OP_EN),
.				OP_READY(WIRE_RDY)
);

Counter counter_SQRT_MOD
(
	//Inputs			
	. clk(clk),
	. rst(rst),	//Reset the counter
	. enb(WIRE_COUNTER_FLAG),
	. count_till_ovf(WIRE_count),				//Size of N-1 (number of bits to count -1) number of shifts
	//Output	
	. overflow(WIRE_OVF) 								//negated_shift_enable Tells you when it has finished so it stops the shifting

);	

// SHIFTER D

Register_Shifter R_S_D_MOD
(
	.clk(clk),
	.rst(rst),
//	.start(),
	.enb(WIRE_SHIFT_EN),
	.DATA(Data),
	.SHIFT_VALUE(2*WIRE_count),
	.Direction_of_shift(1'b0),
	.Reg_Shift_Out(WIRE_DS2_OUT)
);

// SHIFTER R

Register_Shifter R_S_R_MOD
(
	.clk(clk),
	.rst(rst),
//	.start(),
	.enb(WIRE_SHIFT_EN),
	.DATA(WIRE_R),
	.SHIFT_VALUE({{13*{1'b0}},2'b10}),
	.Direction_of_shift(1'b1),
	.Reg_Shift_Out(WIRE_RS2_OUT)
);
// SHIFTER Q

Register_Shifter R_S_Q_MOD
(
	.clk(clk),
	.rst(rst),
//	.start(),
	.enb(WIRE_SHIFT_EN),
	.DATA(WIRE_Q),
	.SHIFT_VALUE({{13*{1'b0}},2'b10}),
	.Direction_of_shift(1'b1),
	.Reg_Shift_Out(WIRE_QS2_OUT)
);
// SHIFTER Q << 1

Register_Shifter RS_Q1_MOD
(
	.clk(clk),
	.rst(rst),
//	.start(),
	.enb(WIRE_SHIFT_EN),
	.DATA(WIRE_Q),
	.SHIFT_VALUE({{14*{1'b0}},1'b1}),
	.Direction_of_shift(1'b1),
	.Reg_Shift_Out(WIRE_QS1_OUT)
);

// combinational module
combinational_block COMB_MOD(
	. Q_shifted(WIRE_QS2_OUT),
	. Q_S1(WIRE_QS1_OUT),
	. R_shifted(WIRE_RS2_OUT),
	. D_shifted(WIRE_DS2_OUT),
	. D_S2_AND_3_in(WIRE_D_S2_AND_3),
	. D_S2_AND_3(WIRE_D_S2_AND_3),
	. DS2A3_or_RS2(WIRE_DS2A3_or_RS2),
	. QS2_or_1(WIRE_QS2_or_1),
	. QS2_or_3(WIRE_QS2_or_3),
	. QS1_or_1(WIRE_QS1_or_1)
);
//MULTIPLEXER 1
Multiplexor_R Multiplexor_QMUX
(
	// Input 
	. clk(clk),
	. rst(rst),
	. REG1(WIRE_SUB),
	. REG2(WIRE_SUM),
	. R(WIRE_R),
	. Enable(MUX_EN1),
	// Output 
	. Output(WIRE_R),
	. FLAG(WIRE_MUX_FLAG)
);
//Multiplexer 2
Multiplexor_R Multiplexor_QMUX_2
(
	// Input 
	. clk(clk),
	. rst(rst),
	. REG1(WIRE_QS1_or_1),
	. REG2(WIRE_QS1_OUT),
	. R(WIRE_R),
	. Enable(MUX_EN2),
	// Output 
	. Output(WIRE_Q),
	. FLAG(WIRE_MUX2_FLAG)
);

//ADDER
Adder Adder_MOD(
	//input
	. clk(clk),
	. rst(rst),
	//. start(start),
	. Number(WIRE_DS2A3_or_RS2),	
	. Number2(WIRE_QS2_or_3),	
	. Enable(WIRE_OP_EN),					//Enables the sum if its not enabled it gives the number 2 in the output
	//Output
	. Sum_Output(WIRE_SUM),			//Output of the sum
	. FLAG(WIRE_SUM_FLAG)
);

//SUBSTRACTOR
substactor subtractor_MOD(
	//input
	. clk(clk),
	. rst(rst),
	//. start(start),
	. Number(WIRE_DS2A3_or_RS2),
	. Number2(WIRE_QS2_or_1),
	. Enable(WIRE_OP_EN),					//Enables the sum if its not enabled it gives the number 2 in the output
	//Output
	. Sub_Output(WIRE_SUB),			//Output of the sum
	. FLAG(WIRE_SUB_FLAG)
);

	
	/*********************************************************/
	initial // Clock generator
	  begin
		 forever #2 clk = !clk;
	  end

  
  initial begin // multiplicand generator
	enable = 0;
	#10 Data = 127;
		rst = 0;
	#1	rst = 1;
	
	
	#200	enable = 1;
	#400 enable = 0;
	#50 rst = 0;
  end
  
  
endmodule 