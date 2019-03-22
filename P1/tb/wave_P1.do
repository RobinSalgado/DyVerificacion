onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /TOP_MOD_TB/clk
add wave -noupdate -radix decimal /TOP_MOD_TB/rst
add wave -noupdate -radix decimal /TOP_MOD_TB/start
add wave -noupdate -radix decimal /TOP_MOD_TB/Multiplier
add wave -noupdate -radix decimal /TOP_MOD_TB/Multiplicand
add wave -noupdate -radix decimal /TOP_MOD_TB/Sum_WIRE
add wave -noupdate -radix decimal /TOP_MOD_TB/Shifter_Left_WIRE
add wave -noupdate -radix decimal /TOP_MOD_TB/Shifter_Right_WIRE
add wave -noupdate -radix decimal /TOP_MOD_TB/sign
add wave -noupdate -radix decimal /TOP_MOD_TB/ovf_WIRE
add wave -noupdate -radix decimal /TOP_MOD_TB/ENABLE_FLAG_WIRE
add wave -noupdate -radix decimal /TOP_MOD_TB/Ready_WIRE
add wave -noupdate -radix decimal /TOP_MOD_TB/SIGN_WIRE
add wave -noupdate -radix decimal /TOP_MOD_TB/ADD_EN_WIRE
add wave -noupdate -radix decimal /TOP_MOD_TB/ready
add wave -noupdate -radix decimal /TOP_MOD_TB/start_WIRE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10000058 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {10000001 ps} {10000065 ps}
