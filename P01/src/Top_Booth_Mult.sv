
import definitions_pkg::*;

 module Top_Booth_Mult_2(
 
 input           clk, rst              ,
 input  int8_t   Multiplier             ,   
 input  int8_t   Multiplicand            , 
 input           i_start               ,
 output          ready                 ,
 output 			  o_enb                 ,
 output          o_clr                 ,
 output int16_t  Product, o_prod_acc ,
 output int8_t   o_sum , o_diff        ,
 output int8_t   o_m, o_acc            , 
 output sgmnt_e  o_ones, o_tens        ,
 output sgmnt_e  o_hundrds, o_thousnds ,
 output sgmnt_e  o_sign                ,
 output cnt_t    o_cnt                 ,
 output cnt_t    o_cnt_clr             ,
 output state_e  o_Edo_Act
 
 );
 

 
	int8_t  diff_w, sum_w, m_w,acc_w    ;
	int16_t prod_w, tws_cmp_prod_w      ;
	logic   rdy_w, enb_w, ovf_w         ;
	logic   clr_w, enb_cnt_w, clr_cnt_w ;

	bcd_t sign_w     ;
	bcd_t ones_w     ;
	bcd_t tens_w     ;
	bcd_t hundreds_w ;
	bcd_t thousand_w ;

	
	cnt_t cnt_w, cnt_clr_w	;
 
 
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
  .i_mc   ( Multiplicand ), 
  .i_mp   (  Multiplier  ), 
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
	 .o_clr_cnt ( clr_cnt_w ),
	 .Edo_Act   ( o_Edo_Act ) 
  );
  
  cntr_mod_n_ovf 
  #(.MAXCNT (9) )
  
  CTR_CNT (
   .clk     (  clk  ),
   .rst     (  rst  ),
   .i_enb   ( enb_w ),
	.i_clr   ( clr_w ),
 	.o_ovf   ( ovf_w ),
   .o_count ( cnt_w )
  );
	 
	   cntr_mod_n_ovf
	#(.MAXCNT (2) )	

	CNT_CLR	(
   .clk     (  clk      ),
   .rst     (  rst      ),
   .i_enb   ( enb_cnt_w ),
	.i_clr   ( clr_cnt_w ),
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
	  .o_display ( o_hundrds  )
  );

  bcd2segm THOUSAND
  (	
	  .i_BCD     ( thousand_w  ),
	  .i_rdy     (    rdy_w    ),
	  .o_display ( o_thousnds  )
  );

bcd2segm SIGN
(
	
	.i_BCD     ( sign_w ),
	.i_rdy     ( rdy_w  ),
	.o_display ( o_sign )
);


	 pipo #(
	 .DW(16)
	) PROD_REG(
	  .clk ( clk ),
	  .rst ( rst   ),
	  .enb ( ovf_w ),
	  .inp ( prod_w ) ,
	  .out ( Product )
	);


	   assign o_m        =   m_w;
		assign o_prod_acc =   prod_w;
		assign ready      =   rdy_w;
		assign o_sum      =   sum_w;
		assign o_diff     =   diff_w;
		assign o_acc      =   acc_w;
		assign o_cnt      =   cnt_w;
		assign o_enb      =   enb_w;
		assign o_clr      =   clr_w;
		assign o_cnt_clr  =   cnt_clr_w;
		

endmodule 