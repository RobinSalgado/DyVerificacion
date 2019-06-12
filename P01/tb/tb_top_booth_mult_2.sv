
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

import definitions_pkg::*;

module tb_top_booth_mult;

logic start; logic clk;
logic [15:0] product, o_prod_acc;
logic rdy, rst, enb, o_clr;

 int8_t     sum, diff, m, acc; 
 int8_t     Multiplier,Multiplicand;
 sgmnt_e  o_ones, o_tens;
 sgmnt_e  o_hundreds, o_thousands;
 cnt_t      counter, o_cnt_clr;
 state_e    Edo_Act;
 sgmnt_e  o_sign ; 
 
 
 Top_Booth_Mult_2  topMOd(

  .i_start(start),
  .rst(rst),
  .Multiplier(Multiplier), 
  .Multiplicand(Multiplicand), 
  .clk(clk),
  .ready(rdy),
  .Product(product),
  .o_sum(sum),
  .o_diff(diff),
  .o_m(m), 
  .o_acc(acc),
  .o_ones(o_ones), 
  .o_tens(o_tens),
  .o_hundrds(o_hundreds),
  .o_thousnds(o_thousands), 
  .o_cnt(counter),
  .o_Edo_Act(Edo_Act),
  .o_sign (o_sign),
  .o_clr(o_clr),
  .o_cnt_clr(o_cnt_clr),
  .o_prod_acc (o_prod_acc),
  .o_enb(enb)
	);
   

	 

 
  
  initial begin // reset generator
	  
	  clk   = 0;
	  start = 1;
	  rst   = 0;

	  Multiplier		=  -1;
	  Multiplicand    =   10;
	  
	  #2 rst = 1;
	  #2 start = 0;
	  
	  #15 Multiplier    =   -1;
	  #15 Multiplicand  =    10;
	  
	  
	  /* SECOND OPERATION*/
	
	  Multiplier		=  57;
	  Multiplicand    =  -57;
	  
	   start = 1; 
	   #2 start = 0;
		
     #15 Multiplier    =  57;
	  #15 Multiplicand  = - 57;
	 
	
    /* THIRD OPERATION*/
	
     Multiplier		=  -35;
	  Multiplicand    =   82;
	  
	   start = 1; 
	   #2 start = 0;
	

	
end/*********************************************************/

always begin
    #1 clk = ~clk;
end

endmodule 