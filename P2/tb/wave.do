onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /topmod_TB/clk
add wave -noupdate -radix decimal /topmod_TB/rst
add wave -noupdate -radix decimal /topmod_TB/op
add wave -noupdate -radix decimal /topmod_TB/load
add wave -noupdate -radix decimal /topmod_TB/start
add wave -noupdate -radix decimal /topmod_TB/Data_X_wire
add wave -noupdate -radix decimal /topmod_TB/Data_Y_wire
add wave -noupdate -radix decimal /topmod_TB/Data
add wave -noupdate -radix decimal /topmod_TB/start_WIRE
add wave -noupdate -radix decimal /topmod_TB/ready
add wave -noupdate -radix decimal /topmod_TB/ERROR
add wave -noupdate -radix decimal /topmod_TB/Data_result_wire
add wave -noupdate -radix decimal /topmod_TB/Data_residue_wire
add wave -noupdate -radix decimal /topmod_TB/sign
add wave -noupdate -radix decimal /topmod_TB/ONES_WIRE
add wave -noupdate -radix decimal /topmod_TB/TENS_WIRE
add wave -noupdate -radix decimal /topmod_TB/HUNDREDS_WIRE
add wave -noupdate -radix decimal /topmod_TB/THOUSAND_WIRE
add wave -noupdate -radix decimal /topmod_TB/TEN_THOUSAND_WIRE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {254 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 347
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {66 ps} {287 ps}
