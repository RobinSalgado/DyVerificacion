
//`timescale 1ns / 1ps

timeunit 1ns; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ns;// It specifies the resolution in the simulation.


module Universal_Register_TB;

parameter DW = 4;

logic clk;
logic	rst;
logic enb;
logic l_s;
logic left_right;

logic [2:0]     selector;
logic [DW-1:0]  out;
logic [DW-1:0]  inp;

logic [DW-1:0]      rgstr_r;

/************************/
/****** WIRES    ********/
/************************/

//logic [DW-1:0] PIPO_OUT;
//logic [DW-1:0] SIPO_OUT;
//logic SISO_OUT;
//logic PISO_OUT;


/************************/
/***** MAIN MODULE  *****/
/************************/

Universal_Register uut(
.clk(clk),    			// Clock
.rst(rst),    			// asynchronous reset low active 
.enb(enb),    			// Enable
.l_s(l_s),   			// load or shift
.inp(inp),    			// data input
.left_right(left_right),		// Left shift by default, right shift by selection
.selector(selector),			// Selects the operation mode.
.out(out)     			// Serial output
);




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
	.inp(inp),
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





/*********************************************************/
always begin
    #1 clk <= ~clk;
end

/*********************************************************/
initial begin // reset generator
				clk = 0;
	#1			rst     = 0; 
   #1       enb     = 0;
   #1       l_s     = 0;
	#1 		left_right = 0;
   #1       inp     = 0;
   
	#6			rst     = 1;
	   	   enb     = 1;
	   		left_right   = 0;
            enb     = 1; 
        		selector   = 0;
   
				inp     = 9;
	
	#10		rst = 0;
	#2			rst = 1;
	
				selector   = 1;
              inp     = 4'b1000;
   #2         inp     = 4'b1000;
   #2         inp     = 4'b1000;
   #2         inp     = 4'b0000;
    
	 
	#10		rst = 0;
	#2			rst = 1;
	 
	      	selector   = 2;
              inp     = 4'b1000;
   #2         inp     = 4'b0000;
   #2         inp     = 4'b1000;
   #2         inp     = 4'b1000;
	 
   #10		rst = 0;
	#2			rst = 1;
	
	
	
				selector   = 3; // 0011
	         inp     = 3;
            l_s     = 1;
    #2      l_s     = 0;
    #100
    $stop;
	 
	 
	 
//				inp     = 9;

//   #5			inp     = 5;
//   #25      inp     = 7;
//	#30      selector = 0;
//	#35 		inp = 1;
//	#50 		selector = 1;
//	#55   inp = 10;
//   #100
//   $stop;

	
end


endmodule 