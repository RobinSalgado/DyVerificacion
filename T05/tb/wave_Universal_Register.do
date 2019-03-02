onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Universal_Register_TB/clk
add wave -noupdate /Universal_Register_TB/rst
add wave -noupdate /Universal_Register_TB/enb
add wave -noupdate /Universal_Register_TB/l_s
add wave -noupdate /Universal_Register_TB/left_right
add wave -noupdate /Universal_Register_TB/selector
add wave -noupdate /Universal_Register_TB/out
add wave -noupdate /Universal_Register_TB/inp
add wave -noupdate /Universal_Register_TB/rgstr_r
add wave -noupdate /Universal_Register_TB/PIPO_OUT
add wave -noupdate /Universal_Register_TB/SISO_OUT
add wave -noupdate /Universal_Register_TB/PISO_OUT
add wave -noupdate /Universal_Register_TB/SIPO_OUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15 ns} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {126 ns}
