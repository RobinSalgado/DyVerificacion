// Coder:           Esteban González Moreno

// Date:            07 Mayo 2019

// Name:            TOP_MODULE.sv

// Description:     This is the TOP Module



import Definitions_Package::*;

module MxV(
	input 					clk,
	input 					rst,
	input word_lenght_t 	REC_DATA,
	input 					REC_DONE,
	input 					ENABLE,
	output word_lenght_t DATA_OUT
);

wire [7:0] wire_ADDR;
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

wire [3:0]	wire_VEC_N;
wire [7:0]	wire_DATA_FEED;

wire EN_MAT;
wire EN_VEC;

wire [7:0] wire_REC_DATA;
wire [7:0] wire_RAM1_OUT;
wire [3:0]	wire_RAM_EN;

wire [3:0] wire_MUX_SEC_SEL;
wire [63:0] wire_VEC_DATA;
wire wire_R1_EN;
wire wire_R2_EN;
wire wire_R3_EN;
wire wire_R4_EN;
wire wire_R5_EN;
wire wire_R6_EN;
wire wire_R7_EN;
wire wire_R8_EN;


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
	.RAM_Num(wire_RAM_EN),
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


DC_RAM	RAM_1
(
	.clk_A(clk), 
	.clk_B(clk),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADDR),				
	.ENABLE_W(wire_R1_EN & EN_MAT),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(1'b0),
	.DATA_OUT(wire_RAM1_OUT)
);


DC_RAM	RAM_2
(
	.clk_A(clk), 
	.clk_B(clk),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADDR),				
	.ENABLE_W(wire_R2_EN & EN_MAT),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(1'b0),
	.DATA_OUT(wire_RAM1_OUT)
);


DC_RAM	RAM_3
(
	.clk_A(clk), 
	.clk_B(clk),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADDR),				
	.ENABLE_W(wire_R3_EN & EN_MAT),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(1'b0),
	.DATA_OUT(wire_RAM1_OUT)
);


DC_RAM	RAM_4
(
	.clk_A(clk), 
	.clk_B(clk),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADDR),				
	.ENABLE_W(wire_R4_EN & EN_MAT),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(1'b0),
	.DATA_OUT(wire_RAM1_OUT)
);


DC_RAM	RAM_5
(
	.clk_A(clk), 
	.clk_B(clk),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADDR),				
	.ENABLE_W(wire_R5_EN & EN_MAT),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(1'b0),
	.DATA_OUT(wire_RAM1_OUT)
);

DC_RAM	RAM_6
(
	.clk_A(clk), 
	.clk_B(clk),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADDR),				
	.ENABLE_W(wire_R6_EN & EN_MAT),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(1'b0),
	.DATA_OUT(wire_RAM1_OUT)
);


DC_RAM	RAM_7
(
	.clk_A(clk), 
	.clk_B(clk),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADDR),				
	.ENABLE_W(wire_R7_EN & EN_MAT),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(1'b0),
	.DATA_OUT(wire_RAM1_OUT)
);

DC_RAM	RAM_8
(
	.clk_A(clk), 
	.clk_B(clk),
	.Data_IN(wire_REC_DATA),
	.ADDR(wire_ADDR),				
	.ENABLE_W(wire_R8_EN & EN_MAT),//wire_ADDR seguramente llevara un mux
	.ENABLE_R(1'b0),
	.DATA_OUT(wire_RAM1_OUT)
);
Multiplexor_RAM MULT_RAM_MOD
(
	.Selector(wire_RAM_EN),
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
	.LOAD(wire_ASSIGN_EN & EN_MAT),//VEC),
	.Section_SEL(wire_RAM_EN),
	.DATA(wire_REC_DATA),
	.OUT(wire_VEC_DATA)
);

endmodule
