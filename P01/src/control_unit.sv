
import definitions_pkg::*;

module control_unit


(
    input                    rst       ,
    input                    clk       ,
    input                    i_start   ,
	 input 					     i_ovf     ,
	 input     logic [3:0]    i_cnt     ,
    output    logic          o_rdy     ,    // become 1 when 8 cycles have passed. 
	 output 	  logic			  o_enb     ,
	 output    logic          o_clr     ,
	 output    logic          o_enb_cnt ,
	 output    logic          o_clr_cnt ,
	 output    state_e        Edo_Act   
    );
	 


		always_ff@( posedge clk or negedge rst ) begin // Circuito Secuenicial en un proceso always.

		if ( !rst ) begin
		
		Edo_Act <= IDLE;
		
		end
		
		else case( Edo_Act )

		IDLE: begin 
		
					if ( i_start )
					Edo_Act <= PROCESING;					  
            end 
				
		PROCESING :begin 

					if ( i_ovf )
					Edo_Act <= READY;
					
               end


		READY : begin 
		
				 if ( i_cnt == 2 )   
				 Edo_Act <= CLEAR; 	
				 
				 end
			
		CLEAR: begin 
		
		 if ( i_start )
				  Edo_Act <= PROCESING;
				end
	
	
		
//		default: Edo_Act<= IDLE;
endcase
		
end



		// CTO combinacional de salida.
		always_comb begin
		
		case ( Edo_Act ) 
		
    	IDLE: begin 
		
				o_rdy  = U_ZERO    ;
				o_enb  = U_ZERO    ;
				o_clr  = U_ZERO    ;
				o_enb_cnt = U_ZERO ;
				o_clr_cnt = U_ZERO ;
				
		
	         end     
	
		PROCESING: begin
		
		   
				o_clr  = U_ZERO    ;
				o_enb  = U_ONE     ;
				o_rdy  = U_ZERO    ;
				o_enb_cnt = U_ZERO ;
				o_clr_cnt = U_ZERO ;
			

//				if ( i_ovf ) begin
//				
//				o_clr  = U_ONE  ;
//				o_enb  = U_ZERO ;
//				o_rdy  = U_ONE  ;
				
//				end				 
	              end 
	
			READY: begin 
			
				
				o_rdy  = U_ONE     ;
				o_enb  = U_ZERO    ;
				o_clr  = U_ONE     ;
				o_enb_cnt = U_ONE  ;
				o_clr_cnt = U_ZERO ;
				
			
				end
				
				
					  
			CLEAR: begin 
		        
				  o_rdy     = U_ONE  ;
				  o_enb     = U_ZERO ; 
				  o_clr     = U_ZERO ;
				  o_enb_cnt = U_ZERO ;
				  o_clr_cnt = U_ONE  ;  
				 
				end
			       			
//	
//			default: begin 
//			 
//			 o_clr  = U_ZERO    ;
//			 o_rdy  = U_ZERO    ;
//			 o_enb  = U_ZERO    ;
//			 o_enb_cnt = U_ZERO ;
//			 o_clr_cnt = U_ZERO ;
//	
			 
//						end
			endcase
			
			end // end of alws_cmb
 endmodule

		
		


