
module division(Q,M,Quo,Rem,clk,rst);

    //the size of input and output ports of the division module is generic.
    parameter WIDTH = 8;
    //input and output ports.
	 input clk;
	 input rst;
    input  [WIDTH-1:0] Q; //dividend 
    input  [WIDTH-1:0] M; //divisor 
    output [WIDTH-1:0] Quo;
	 output [WIDTH-1:0] Rem;
    //internal variables    
    reg [WIDTH-1:0] Quo = 0; 
	 reg [WIDTH-1:0] Rem = 0; 
    reg [WIDTH-1:0] a1,b1; // these variables are going to update during looping 
    reg [WIDTH:0] p1;   	// initialize A as in Booths algorithm
    integer i;

    always_ff@ (posedge clk, negedge rst)
	  begin
	  
		if (!rst)
			begin
		  a1 = 0;
        b1 = 0;
        p1= 0; 
		  end
	
        //initialize the variables.
        a1 = Q;
        b1 = M;
        p1= 0; 		//Initialize A = 0
		  
		  if (a1[WIDTH-1] == 1) // i.e Q is negative 
		  a1 = 0 - a1; 			// Now Q is positive 
		  if (b1[WIDTH-1] == 1)
		  b1 = 0 - b1;
		  if ((a1[WIDTH-1] == 1) && (b1[WIDTH-1] == 1)) begin 
		   a1 = 0 - a1;
			b1 = 0 - b1;
		  end 
		  
        for(i=0;i < WIDTH;i=i+1)    begin //start the for loop

            p1 = {p1[WIDTH-2:0],a1[WIDTH-1]}; //shift left A
            a1[WIDTH-1:1] = a1[WIDTH-2:0];	 //shilf left Q
            p1 = p1-b1;								 //A = A-M
            if(p1[WIDTH-1] == 1)    begin		 //checking A<0 i.e MSB = 1 ()
                a1[0] = 0;
                p1 = p1 + b1;   end
            else
                a1[0] = 1;
        end
		  
		if ((Q[WIDTH-1] == 1) && (M[WIDTH-1] == 0)) begin 
		  Quo = 0 - a1;
		  Rem = 0 - p1; 
		  end
		  
			  else if ((Q[WIDTH-1] == 0) && (M[WIDTH-1] == 1)) begin 	
				Quo = 0 - a1;
				Rem = p1;
				end
			
					else if ((Q[WIDTH-1] == 1) && (M[WIDTH-1] == 1)) begin 	
					Quo = a1;
					Rem = 0 - p1;
					end
						
						else begin 
						Quo = a1;
						Rem = p1;
						end
	
    end 

endmodule
