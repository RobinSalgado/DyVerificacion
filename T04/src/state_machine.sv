
module state_machine(
 
 input clk,
 input rst,
 input start,
 output reg out, 
 output reg clk_1hz
	
);


	 
wire clk_Signal_wire;
Clock_Generator clock_Gen
(
   .clk(clk),
   .reset(reset),
   .clk_Signal(clk_Signal_wire)

);




logic [2:0]contador;
//logic	[1:0]State;

//assign clk_1hz = 1'b1;

logic [2:0] err_Counter;

struct {
    reg [1:0]  State;
    reg [2:0]  counter;
	 reg Go_Idle;
	 reg [1:0] contador2;
	 reg Led_Verde;
    } cnt;

assign clk_1hz = cnt.Led_Verde;
always@(posedge clk_Signal_wire or negedge reset)	
begin:STM
	
	
	
	if(reset == 0)	
		begin		
			cnt.State <= 2'b00;
			cnt.counter <= 2'b00;
			cnt.Go_Idle <= 1'b0;

		end
	else
	begin
		cnt.Led_Verde = ~cnt.Led_Verde;
			case(cnt.State)
				2'b00: begin
							if(cnt.counter >6)	
								begin
									cnt.counter <= 3'b000;
									cnt.State <= 2'b01;
									out <= '1;
								end
						end
				2'b01: begin
							cnt.contador2 <= cnt.contador2 +2'b01;
							if(cnt.contador2 == 3) 
								begin
									cnt.Go_Idle <= 1'b1;
								end
							
	
							if(cnt.counter >4 && cnt.Go_Idle == 0)
								begin
									cnt.counter <= 0;
									cnt.State <= 2'b00;
									out <= '0;
								end
							else if (cnt.counter >4 && cnt.Go_Idle == 1)
								begin
									cnt.counter <= 0;
									cnt.State <= 2'b10;
									out <= '0;
								end
						end
				2'b10: begin
						if(start == 1)
							begin
								cnt.State <= 2'b00;
								cnt.contador2 <= 2'b00;
								cnt.Go_Idle <= 1'b0;
								cnt.counter <= 0;
							end
					 end
			endcase
	end
end:STM

//	begin: Moore_State_Machine
//always@(posedge clk_Signal_wire or negedge reset)	
//	begin: Moore_State_Machine
//	cnt.counter <= cnt.counter + 2'b01;
//
////	clk_1hz <= ~clk_1hz;
////	if(reset == 0)	
////		begin		
////		//	cnt.State <= 2'b00;
////		//	cnt.counter <= 2'b00;
////			Go_Idle <= 1'b0;
////
////		end
////	else
////		begin
//			case(cnt.State)
//				2'b00: begin
//							if(cnt.counter >6)	
//								begin
//									cnt.counter <= 3'b000;
//									cnt.State <= 2'b01;
//									out <= '1;
//								end
//								
//						 end
//			
//				2'b01: begin
//							contador2 <= contador2 +2'b01;
//							if(contador2 == 3) 
//								begin
//									Go_Idle <= 1'b1;
//								end
//							
//	
//						if(cnt.counter >4 && Go_Idle == 0)
//							begin
//								cnt.counter <= 0;
//								cnt.State <= 2'b00;
//								out <= 1'b0;
//							end
//						else if (cnt.counter >4 && Go_Idle == 1)
//							begin
//								cnt.counter <= 0;
//								cnt.State <= 2'b10;
//								out <= 1'b0;
//							end
//						end
//		endcase
////			2'b10: begin
////						if(start == 1)
////							begin
////								State <= 2'b00;
////								contador2 <= 2'b00;
////								Go_Idle <= 1'b0;
////								counter <= 0;
////							end
////					 end
////		endcase
//
//	end:Moore_State_Machine
endmodule
	