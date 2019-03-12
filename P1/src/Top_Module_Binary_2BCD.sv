/////												/////
/////			Robin Moisés Salgado			/////
/////				TOP MODULE			      /////
/////				  12/02/19					/////
/////												/////
////////////////////////////////////////////	

module Top_Module_Binary_2BCD
(
	
	input [7:0] Switchs,
	output[6:0] Segment_Ones,
	output[6:0] Segment_Cents,
	output[6:0] Segment_Hundreds
	

);

wire [7:0] two_Comp_To_BCD_Wire;
wire [3:0] BCD_Ones_to_7_seg_Wire;
wire [3:0] BCD_Tens_to_7_seg_Wire;
wire [3:0] BCD_Hundreds_to_7_seg_Wire;


 two_Complement two_Complement_Ins
 (
.eigth_Bit_Value(Switchs),
.two_Comp(two_Comp_To_BCD_Wire)

);


 binary_to_BCD binary_to_BCD_Ins
 (
 .A(two_Comp_To_BCD_Wire), 
 .ONES(BCD_Ones_to_7_seg_Wire),
 .TENS(BCD_Tens_to_7_seg_Wire),
 .HUNDREDS(BCD_Hundreds_to_7_seg_Wire)
 );  
 
 seven_Segments_Module seven_Segments_Module_Ins
(
	.ones(BCD_Ones_to_7_seg_Wire),
	.cents(BCD_Tens_to_7_seg_Wire),
   .hundreds(BCD_Hundreds_to_7_seg_Wire),
	.seg_Ones(Segment_Ones),
   .seg_Cents(Segment_Cents),
	.seg_Hundreds(Segment_Hundreds)
	
);


endmodule 