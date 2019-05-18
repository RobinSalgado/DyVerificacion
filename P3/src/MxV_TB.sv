
// Coder:           Esteban González Moreno

// Date:            09 Mayo 2019

// Name:            UART.sv

// Description:     UART top module

import Definitions_Package::*;

module MxV_TB;
	//inputs
	bit 					clk;
	bit 					rst;
	word_lenght_t 		REC_DATA;
	logic 				REC_DONE;
	logic 				ENABLE;
	word_lenght_t 		DATA_OUT;//DATA LENGHT ENABLE


import Definitions_Package::*;

MxV	DUT(
	.clk(clk),
	.rst(rst),
	.REC_DATA(REC_DATA),
	.REC_DONE(REC_DONE),
	.ENABLE(ENABLE),
	.DATA_OUT(DATA_OUT)
);

word_lenght_t wire_ADDR;
wire wire_clk_DIV;
wire wire_RAM_OUT;
wire wire_TX_DONE;
wire wire_OP_DONE;
wire wire_SIZE_EN;
wire wire_ASSIGN_EN;
wire wire_OP_EN;
wire wire_TX_EN;
wire wire_CLEAR_EN;
wire wire_DL_EN;

ADDR_lenght_t	wire_VEC_N;
word_lenght_t	wire_DATA_FEED;

wire EN_MAT;
wire EN_VEC;

word_lenght_t wire_REC_DATA;

word_lenght_t wire_RAM1_OUT;
word_lenght_t wire_RAM2_OUT;
word_lenght_t wire_RAM3_OUT;
word_lenght_t wire_RAM4_OUT;
word_lenght_t wire_RAM5_OUT;
word_lenght_t wire_RAM6_OUT;
word_lenght_t wire_RAM7_OUT;
word_lenght_t wire_RAM8_OUT;

ADDR_lenght_t	wire_RAM_NUM;

ADDR_lenght_t wire_MUX_SEC_SEL;
wire [63:0] wire_VEC_DATA;
wire wire_R1_EN;
wire wire_R2_EN;
wire wire_R3_EN;
wire wire_R4_EN;
wire wire_R5_EN;
wire wire_R6_EN;
wire wire_R7_EN;
wire wire_R8_EN;


wire wire_RR1_EN;
wire wire_RR2_EN;
wire wire_RR3_EN;
wire wire_RR4_EN;
wire wire_RR5_EN;
wire wire_RR6_EN;
wire wire_RR7_EN;
wire wire_RR8_EN;

wire[15:0] 		wire_RAM_SEL_P;
wire [15:0]		wire_RAM_ADDR_P;
wire [159:0]	wire_DATA_OUT;



// DATA ASSIGNMENT MODULE
DATA_FEEDER DATA_FEEDER_MOD(
	.clk(clk),
	.rst(rst),
	
	.SIZE_M_EN(wire_SIZE_EN & ENABLE),
	.REC_DATA(wire_REC_DATA),
	.ENB_ASSIGN(wire_ASSIGN_EN & ENABLE),
	.Enable_MAT(EN_MAT),
	.Enable_VEC(EN_VEC),
	.ADDR(wire_ADDR),
	.RAM_Num(wire_RAM_NUM),
	.DATA(wire_DATA_FEED),
	.PIPO_VEC(wire_VEC_N)
);

//DATA PIPO

PIPO PIPO_MxV_MOD
(
	.clk(clk),
	.rst(rst),
	.LOAD(ENABLE),
	.DATA(REC_DATA),
	.OUT(wire_REC_DATA)
);


// MxV STATE MACHINE  NEED TO CHANGE THE NAME OF DATA_FEED_SM
MxV_SM MxV_SM_MOD(
	.clk(clk),
	.rst(rst),
	.REC_DATA(wire_REC_DATA),
	.Enable(ENABLE),
	.DONE_TRANSMITION(wire_TX_DONE),
	.OP_DONE(wire_OP_DONE),
	//outputs
	.MAT_SIZE_EN(wire_SIZE_EN),
	.DATA_ASSIGN_EN(wire_ASSIGN_EN),
	.OPERATION_EN(wire_OP_EN),
	.TRANSMIT_EN(wire_TX_EN),
	.CLEAR_EN(wire_CLEAR_EN),
	.DL_EN(wire_DL_EN),					//DATA LENGHT ENABLE
	.VEC_EN(EN_VEC),
	.MAT_EN(EN_MAT)
);

// TRANSMITION MODULE

//PIPO_ USED FOR....something

// OPERATION MODULE

//RAM MATRIX

wire [3:0] wire_ADD_RAM1;
wire [3:0] wire_ADD_RAM2;
wire [3:0] wire_ADD_RAM3;
wire [3:0] wire_ADD_RAM4;

Mult_ADDR Mult_ADDR_MOD1
(
	.Selector(wire_OP_EN),
	.in1(wire_ADDR),
	.in2(wire_RAM_ADDR_P[15:12]),
	.ADDR(wire_ADD_RAM1)
);
Mult_ADDR Mult_ADDR_MOD2
(
	.Selector(wire_OP_EN),
	.in1(wire_ADDR),
	.in2(wire_RAM_ADDR_P[11:8]),
	.ADDR(wire_ADD_RAM2)
);
Mult_ADDR Mult_ADDR_MOD3
(
	.Selector(wire_OP_EN),
	.in1(wire_ADDR),
	.in2(wire_RAM_ADDR_P[7:4]),
	.ADDR(wire_ADD_RAM3)
);
Mult_ADDR Mult_ADDR_MOD4
(
	.Selector(wire_OP_EN),
	.in1(wire_ADDR),
	.in2(wire_RAM_ADDR_P[3:0]),
	.ADDR(wire_ADD_RAM4)
);

DC_RAM	RAM_1
(
	.clk_A(clk), 
	.clk_B(clk_DIV),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADD_RAM1),				
	.ENABLE_W(wire_R1_EN & ENABLE),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(wire_RR1_EN),
	.DATA_OUT(wire_RAM1_OUT)
);


DC_RAM	RAM_2
(
	.clk_A(clk), 
	.clk_B(clk_DIV),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADD_RAM2),				
	.ENABLE_W(wire_R2_EN & ENABLE),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(wire_RR2_EN),
	.DATA_OUT(wire_RAM2_OUT)
);


DC_RAM	RAM_3
(
	.clk_A(clk), 
	.clk_B(clk_DIV),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADD_RAM3),				
	.ENABLE_W(wire_R3_EN & ENABLE),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(wire_RR3_EN),
	.DATA_OUT(wire_RAM3_OUT)
);


DC_RAM	RAM_4
(
	.clk_A(clk), 
	.clk_B(clk_DIV),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADD_RAM4),				
	.ENABLE_W(wire_R4_EN & ENABLE),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(wire_RR4_EN),
	.DATA_OUT(wire_RAM4_OUT)
);


DC_RAM	RAM_5
(
	.clk_A(clk), 
	.clk_B(clk_DIV),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADD_RAM1),				
	.ENABLE_W(wire_R5_EN & ENABLE),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(wire_RR5_EN),
	.DATA_OUT(wire_RAM5_OUT)
);

DC_RAM	RAM_6
(
	.clk_A(clk), 
	.clk_B(clk_DIV),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADD_RAM2),				
	.ENABLE_W(wire_R6_EN & ENABLE),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(wire_RR6_EN),
	.DATA_OUT(wire_RAM6_OUT)
);


DC_RAM	RAM_7
(
	.clk_A(clk), 
	.clk_B(clk_DIV),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADD_RAM3),				
	.ENABLE_W(wire_R7_EN & ENABLE),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(wire_RR7_EN),
	.DATA_OUT(wire_RAM7_OUT)
);

DC_RAM	RAM_8
(
	.clk_A(clk), 
	.clk_B(clk_DIV),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADD_RAM4),				
	.ENABLE_W(wire_R8_EN & ENABLE),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(wire_RR8_EN),
	.DATA_OUT(wire_RAM8_OUT)
);
Multiplexor_RAM MULT_RAM_MOD
(
	.Selector(wire_RAM_NUM),
	.RAM1(wire_R1_EN),
	.RAM2(wire_R2_EN),
	.RAM3(wire_R3_EN),
	.RAM4(wire_R4_EN),
	.RAM5(wire_R5_EN),
	.RAM6(wire_R6_EN),
	.RAM7(wire_R7_EN),
	.RAM8(wire_R8_EN)
);

//PIPO VECTOR

VECTOR_PIPO VEC_PIPO_MxV_MOD
(
	.clk(clk),
	.rst(rst),
	.LOAD(ENABLE & EN_VEC),//VEC),
	.Section_SEL(wire_RAM_NUM),
	.DATA(wire_REC_DATA),
	.OUT(wire_VEC_DATA)
);

// OPERATION MODULE
Processor Processor_MOD
(
	//inputs
	.clk(clk_DIV),
	.rst(rst),
	.ENABLE(wire_OP_EN),
	.SIZE_M_EN(wire_SIZE_EN ),
	.REC_DATA(wire_REC_DATA),				//Se usa para guardar el tamaño de la matriz

	.DATA_VEC(wire_VEC_DATA),

	.DATA_M2P({(wire_RAM1_OUT | wire_RAM5_OUT),(wire_RAM2_OUT | wire_RAM6_OUT),(wire_RAM3_OUT | wire_RAM7_OUT),(wire_RAM4_OUT | wire_RAM8_OUT)}),	//32 bits 8 8 8 8  Probablemente necesite un modulo para poder poner los resultados de la ram aqui
																																																												
	//outputs
	.RAM_SEL_P(wire_RAM_SEL_P),	//16 bits 4 4 4 4  wire de 16 bits que selecciona
	.RAM_ADDR_P(wire_RAM_ADDR_P),	//14 bits 4 4 4 4


	.OP_DONE(wire_DATA_OUT),
	.DATA_OUT()		//Resultado del tamaño del vector mat size
);


Mult_RAM Mult_RAM_MOD1
(
	.Selector(wire_RAM_SEL_P[15:12]),
	.Proc(0),
	.RAM1(wire_RR1_EN),
	.RAM2(wire_RR5_EN)
);
Mult_RAM Mult_RAM_MOD2
(
	.Selector(wire_RAM_SEL_P[11:8]),
	.Proc(1),
	.RAM1(wire_RR2_EN),
	.RAM2(wire_RR6_EN)
);
Mult_RAM Mult_RAM_MOD3
(
	.Selector(wire_RAM_SEL_P[7:4]),
	.Proc(2),
	.RAM1(wire_RR3_EN),
	.RAM2(wire_RR7_EN)
);
Mult_RAM Mult_RAM_MOD4
(
	.Selector(wire_RAM_SEL_P[3:0]),
	.Proc(3),
	.RAM1(wire_RR4_EN),
	.RAM2(wire_RR8_EN)
);

Clock_Generator clk_DIV_MOD
(
    .reset(rst),
    .clk(clk),
    .clk_Signal(clk_DIV)
);


/*********************************************************/
initial // Clock generator
  begin
    forever #1 clk = !clk;
  end
  
/*********************************************************/
initial begin // reset generator
	#0 	rst = 1;
	#50 	rst = 0;
	#10 	rst = 1;
end

/*********************************************************/
initial begin // Variables
				REC_DATA	= 8'hFF;
				ENABLE	= 0;
				
	//FIRST COMMAND	
	#200 		REC_DATA = 8'hFE;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;
	
	#200 		REC_DATA = 8'h03;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'h01;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	
	#200 		REC_DATA = 8'h02;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	
	#200 		REC_DATA = 8'hEF;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;
	
	//THIRD COMAND
	#200 		REC_DATA = 8'hFF;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'hFE;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'h02;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	
	#200 		REC_DATA = 8'h03;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'hEF;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	// FOURTH COMMAND
	
	#200 		REC_DATA = 8'hFF;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'hFE;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'h06;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'h04;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;
	
	#200 		REC_DATA = 8'h01;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'h02;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;
	
	#200 		REC_DATA = 8'h03;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'h04;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;


	#200 		REC_DATA = 8'hEF;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;
	
	
	// FOURTH COMMAND AGAIN
	
	#200 		REC_DATA = 8'hFF;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'hFE;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'h04;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'h05;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;
	
	#200 		REC_DATA = 8'h01;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;

	#200 		REC_DATA = 8'h02;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;
	
	#200 		REC_DATA = 8'hEF;
				ENABLE 	= 1;
	#2			ENABLE 	= 0;
	
	
end/*********************************************************/

endmodule
