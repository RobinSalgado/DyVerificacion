////////////////////////////////////////////
/////												/////
/////			Robin Moisés Salgado			/////
/////			   BINARY TO BCD			   /////
/////				  12/02/19					/////
/////												/////
////////////////////////////////////////////	

module binary_to_BCD_14(
	A,
	ONES,
	TENS,
	HUNDREDS,
	THOUSAND,
	TEN_THOUSAND); 

input [13:0] A; 
output [3:0] ONES, TENS;
output [3:0] HUNDREDS,THOUSAND;
output [1:0] TEN_THOUSAND; 

 wire [3:0]  c1,c2,c3,c4,c5,c6,c7,c8,c9,c10;
 wire [3:0] c11,c12,c13,c14,c15,c16,c17,c18;
 wire [3:0] c19,c20,c21,c22,c23,c24,c25,c26;
 wire [3:0]  d1,d2,d3,d4,d5,d6,d7,d8,d9,d10;
 wire [3:0] d11,d12,d13,d14,d15,d16,d17,d18;
 wire [3:0] d19,d20,d21,d22,d23,d24,d25,d26;
 
 assign d1 = {1'b0,A[13:11]};
 assign d2 = {c1[2:0],A[10]}; 
 assign d3 = {c2[2:0],A[9]}; 
 assign d4 = {c3[2:0],A[8]};
 assign d5 = {c4[2:0],A[7]};
 assign d6 = {c5[2:0],A[6]};
 assign d7 = {c6[2:0],A[5]};
 assign d8 = {c7[2:0],A[4]};
 assign d9 = {c8[2:0],A[3]};
 assign d10 ={c9[2:0],A[2]};
 assign d11 ={c10[2:0],A[1]};
 
 assign d12 = {1'b0,c1[3],c2[3],c3[3]};
 assign d13 = {c12[2:0],c4[3]};
 assign d14 = {c13[2:0],c5[3]};
 assign d15 = {c14[2:0],c6[3]};
 assign d16 = {c15[2:0],c7[3]};
 assign d17 = {c16[2:0],c8[3]};
 assign d18 = {c17[2:0],c9[3]};
 assign d19 = {c18[2:0],c10[3]};
 
 assign d20 = {1'b0,c12[3],c13[3],c14[3]};
 assign d21 = {c20[2:0],c15[3]};
 assign d22 = {c21[2:0],c16[3]};
 assign d23 = {c22[2:0],c17[3]};
 assign d24 = {c23[2:0],c18[3]};
 
 assign d25 = {1'b0,c20[3],c21[3],c22[3]};
 assign d26 = {c25[2:0],c23[3]};
 
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
 
 assign ONES = {c11[2:0],A[0]}; 
 assign TENS = {c19[2:0],c11[3]}; 
 assign HUNDREDS = {c24[2:0],c19[3]};
 assign THOUSAND = {c26[2:0],c24[3]};
 assign TEN_THOUSAND = {c25[3],c26[3]};
 
 endmodule 