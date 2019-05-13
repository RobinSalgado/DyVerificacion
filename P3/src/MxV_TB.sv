
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

logic [7:0] wire_ADDR;
logic wire_clk_DIV;
logic wire_RAM_OUT;
logic wire_TX_DONE;
logic wire_OP_DONE;
logic wire_SIZE_EN;
logic wire_ASSIGN_EN;
logic wire_OP_EN;
logic wire_TX_EN;
logic wire_CLEAR_EN;
logic wire_DL_EN;

logic [3:0]	wire_VEC_N;
logic [7:0]	wire_DATA_FEED;

logic EN_MAT;
logic EN_VEC;

wire [7:0] wire_REC_DATA;
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

//RAM


// TRANSMITION MODULE

//PIPO_ USED FOR....something

// OPERATION MODULE

//RAM



//
//DC_RAM DC_RAM_MOD(
//	.clk_A(clk)
//	.clk_B(wire_clk_DIV)
//	.ADDR(wire_ADDR)
//	.ENABLE(wire_RAM_EN)
//	.DATA_IN(REC_DATA)
//	.DATA_OUT(wire_RAM_OUT)
//);


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

	
	#200 		REC_DATA = 8'h04;
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
	

	
end/*********************************************************/

endmodule
