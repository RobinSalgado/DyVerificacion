
import definitions_pkg::*;

 module Top_Booth_Mult_2(
 
 input             clk, rst,
 input  int8_t     i_multiplier, 
 input  int8_t     i_multiplicand, 
 input             i_start,
 output            o_rdy,
 output 				 o_enb,
 output            o_clr,
 output int16_t    o_product,
 output int8_t     o_sum, o_diff, o_m, o_acc, 
 output segment_e  o_ones, o_tens,
 output segment_e  o_hundreds, o_thousands,
 output segment_e  o_sign,
 output cnt_t      o_cnt,
 output cnt_t      o_cnt_clr,
 output state_e    o_Edo_Act
 
 );
 
 


 
	int8_t  diff_w, sum_w, m_w,acc_w   ;
	int16_t prod_w, tws_cmp_prod_w     ;
	logic   rdy_w, enb_w, ovf_w ;
	logic   clr_w, enb_cnt_w;

	bcd_t ones_w;
	bcd_t tens_w;
	bcd_t hundreds_w;
	bcd_t thousand_w;

	segment_e sign_w;
	segment_e sign_disp_w;
	segment_e ones_disp_w;
	segment_e tens_disp_w;
	segment_e hundreds_disp_w;
	segment_e thousand_disp_w;
	

	int8_t tws_cmp_mp_w; // wire for 2's comp of multiplier.
	int8_t tws_cmp_mc_w; // wire for 2's comp of multiplicand.
	
	cnt_t cnt_w, cnt_clr_w	;
 
 
 twos_comp TWS_CMP_MC (
	
	 .i_data ( i_multiplicand ),
	 .o_data ( tws_cmp_mc_w   )
   );
 
 
 twos_comp TWS_CMP_MP (
		
	 .i_data ( i_multiplier ),
	 .o_data ( tws_cmp_mp_w )
   );
 
twos_comp_out TWS_CMP_PROD (
 
	 .i_data (     prod_w     ), 
	 .o_data ( tws_cmp_prod_w ), 
	 .o_sign (     sign_w     )
	);
 
 Booth_Mult mult (
 
  .clk    (    clk       ),
  .rst    (    rst       ),
  .i_clr  (    clr_w     ),
  .i_enb  (    enb_w     ),
  .i_ovf  (    ovf_w     ),
  .i_mc   ( tws_cmp_mc_w ), 
  .i_mp   ( tws_cmp_mp_w ), 
  .i_sum  (    sum_w     ), 
  .i_diff (    diff_w    ),
  .i_cnt  (    cnt_w     ),
  .o_m    (    m_w       ), 
  .o_acc  (    acc_w     ),
  .o_prod (    prod_w    )
 ); 
  
  
  
  control_unit FSM 
  (
	 .clk       (   clk     ),
    .rst       (   rst     ),
	 .i_start   ( i_start   ),
	 .i_ovf     ( ovf_w     ),
	 .i_cnt     ( cnt_clr_w	),
	 .o_rdy     ( rdy_w     ),
	 .o_enb     ( enb_w     ),
    .o_clr     ( clr_w     ),
	 .o_enb_cnt ( enb_cnt_w ),
	 .Edo_Act   ( o_Edo_Act ) 
  );
  
  cntr_mod_n_ovf CNT (
  
   .clk     (  clk  ),
   .rst     (  rst  ),
   .i_enb   ( enb_w ),
	.i_clr   ( clr_w ),
 	.o_ovf   ( ovf_w ),
   .o_count ( cnt_w )
  );
	 
	   cntr_mod_n_ovf CNT_CLR (
  
   .clk     (  clk      ),
   .rst     (  rst      ),
   .i_enb   ( enb_cnt_w ),
	.i_clr   (           ),
 	.o_ovf   (           ),
   .o_count ( cnt_clr_w )
  );
	 
	 
	 
	 
  //sumador
 alu SUM_MOD 
  (
		.a   ( acc_w ),
		.b   ( m_w   ),
		.cin ( 1'b0  ),
		.out ( sum_w )
  );
	
  //Restador
 alu REST_MOD 
 (
		.a   (  acc_w ),
		.b   (  ~m_w  ),
		.cin (  1'b1  ),
		.out ( diff_w )
  );

  bin2bcd_16  B_BCD 
  (
		.A         ( tws_cmp_prod_w ),
		.ONES      (     ones_w     ),
		.TENS      (     tens_w     ),
		.HUNDREDS  (   hundreds_w   ),
		.THOUSANDS (   thousand_w   )
  );
  
  bcd2segm ONES 
  (
	  .i_BCD     ( ones_w ),
	  .i_rdy     ( rdy_w  ),
	  .o_display ( o_ones )
  );

  bcd2segm TENS 
  (	
	  .i_BCD     ( tens_w ),
	  .i_rdy     ( rdy_w  ),
	  .o_display ( o_tens )
  );

  bcd2segm HUNDREDS
  (
	  .i_BCD     ( hundreds_w ),
	  .i_rdy     (    rdy_w   ),
	  .o_display ( o_hundreds )
  );

  bcd2segm THOUSAND
  (	
	  .i_BCD     ( thousand_w  ),
	  .i_rdy     (    rdy_w    ),
	  .o_display ( o_thousands )
  );

bcd2segm SIGN
(
	
	.i_BCD     ( sign_w ),
	.i_rdy     ( rdy_w  ),
	.o_display ( o_sign )
);

	   assign o_m       =   m_w;
		assign o_product =   prod_w;
		assign o_rdy     =   rdy_w;
		assign o_sum     =   sum_w;
		assign o_diff    =   diff_w;
		assign o_acc     =   acc_w;
		assign o_cnt     =   cnt_w;
		assign o_enb     =   enb_w;
		assign o_clr     =   clr_w;
		assign o_cnt_clr =   cnt_clr_w;
		

endmodule 