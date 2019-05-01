/////												/////
/////			Robin Moisés Salgado			/////
/////			   BINARY TO BCD			   /////
/////				  12/02/19					/////
/////												/////
////////////////////////////////////////////	

module Binary_BCD_16(A,ONES,TENS,HUNDREDS,THOUSANDS,TEN_THOUSANDS,HUNDRED_THOUSANDS); 

input  [15:0] A; 
output [3:0] ONES, TENS;
output [3:0] HUNDREDS; 
output [3:0]THOUSANDS;
output [3:0]TEN_THOUSANDS;
output HUNDRED_THOUSANDS;


	wire [3:0]   c1,c2,c3,c4,c5,c6,c7,c8,c9;
	wire [3:0]  c10,c11,c12,c13,c14,c15,c16;
	wire [3:0]  c17,c18,c19,c20,c21,c22;
	wire [3:0]  c23,c24,c25,c26,c27,c28,c29;
	wire [3:0]  c30,c31,c32,c33,c34,c35;
	 
	wire [3:0]   d1,d2,d3,d4,d5,d6,d7,d8,d9;
	wire [3:0]  d10,d11,d12,d13,d14,d15,d16;
	wire [3:0]  d17,d18,d19,d20,d21,d22;
	wire [3:0]  d23,d24,d25,d26,d27,d28,d29;
	wire [3:0]  d30,d31,d32,d33,d34,d35;
	 
	 
 assign d1   =  {1'b0,A[15:13]};
 assign d2   =  {c1[2:0],A[12]}; 
 assign d3   =  {c2[2:0],A[11]}; 
 assign d4   =  {c3[2:0],A[10]};
 assign d5   =  {c4[2:0],A[ 9]}; 
 assign d6   =  {c5[2:0],A[ 8]};
 assign d7   =  {c6[2:0],A[ 7]};
 assign d8   =  {c7[2:0],A[ 6]}; 
 assign d9   =  {c8[2:0],A[ 5]}; 
 assign d10  =  {c9[2:0],A[ 4]};
 assign d11  =  {c10[2:0],A[ 3]}; 
 assign d12  =  {c11[2:0],A[ 2]};
 assign d13  =  {c12[2:0],A[ 1]}; 
 assign d14  =  {1'b0,c1[3],c2[3],c3[3]};
 assign d15  =  {c14[2:0],c4[ 3]}; 
 assign d16  =  {c15[2:0],c5[ 3]}; 
 assign d17  =  {c16[2:0],c6[ 3]};
 assign d18  =  {c17[2:0],c7[ 3]}; 
 assign d19  =  {c18[2:0],c8[ 3]};
 assign d20  =  {c19[2:0],c9[ 3]};
 assign d21  =  {c20[2:0],c10[3]}; 
 assign d22  =  {c21[2:0],c11[3]}; 
 assign d23  =  {c22[2:0],c12[3]};
 assign d24  =  {1'b0,c14[3],c15[3],c16[3]};
 assign d25  =  {c24[2:0],c17[ 3]}; 
 assign d26  =  {c25[2:0],c18[ 3]}; 
 assign d27  =  {c26[2:0],c19[ 3]};
 assign d28  =  {c27[2:0],c20[ 3]}; 
 assign d29  =  {c28[2:0],c21[ 3]};
 assign d30  =  {c29[2:0],c22[ 3]};
 assign d31  =  {1'b0,c24[3],c25[3],c26[3]};
 assign d32  =  {c31[2:0],c27[ 3]}; 
 assign d33  =  {c32[2:0],c28[ 3]}; 
 assign d34  =  {c33[2:0],c29[ 3]};
 assign d35  =  {1'b0,c31[3],c32[3],c33[3]};

 	 
	 
 add3 m1(.in(d1),.out(c1)); 
 add3 m2(.in(d2),.out(c2));
 add3 m3(.in(d3),.out(c3));
 add3 m4(.in(d4),.out(c4));
 add3 m5(.in(d5),.out(c5)); 
 add3 m6(.in(d6),.out(c6));
 add3 m7(.in(d7),.out(c7)); 
 add3 m8(.in(d8),.out(c8)); 
 add3 m9(.in(d9),.out(c9));
 add3 m10(.in(d10),.out(c10));
 add3 m11(.in(d11),.out(c11));
 add3 m12(.in(d12),.out(c12)); 
 add3 m13(.in(d13),.out(c13));
 add3 m14(.in(d14),.out(c14));
 add3 m15(.in(d15),.out(c15));
 add3 m16(.in(d16),.out(c16));
 add3 m17(.in(d17),.out(c17)); 
 add3 m18(.in(d18),.out(c18));
 add3 m19(.in(d19),.out(c19));
 add3 m20(.in(d20),.out(c20));
 add3 m21(.in(d21),.out(c21));
 add3 m22(.in(d22),.out(c22)); 
 add3 m23(.in(d23),.out(c23));
 add3 m24(.in(d24),.out(c24));
 add3 m25(.in(d25),.out(c25));
 add3 m26(.in(d26),.out(c26));
 add3 m27(.in(d27),.out(c27)); 
 add3 m28(.in(d28),.out(c28));
 add3 m29(.in(d29),.out(c29)); 
 add3 m30(.in(d30),.out(c30));
 add3 m31(.in(d31),.out(c31));
 add3 m32(.in(d32),.out(c32)); 
 add3 m33(.in(d33),.out(c33));
 add3 m34(.in(d34),.out(c34));
 add3 m35(.in(d35),.out(c35));
  
 assign ONES = {c13[2:0],A[0]}; 
 assign TENS = {c23[2:0],c13[3]}; 
 assign HUNDREDS = {c30[2:0],c23[3]};
 assign THOUSANDS = {c34[2:0],c30[3]};
 assign TEN_THOUSANDS = {c35[2:0],c34[3]};
 assign HUNDRED_THOUSANDS = c35[3];
 
endmodule 