onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_TX_TB/rst
add wave -noupdate /UART_TX_TB/clk
add wave -noupdate /UART_TX_TB/TX_wire
add wave -noupdate /UART_TX_TB/TX_en
add wave -noupdate /UART_TX_TB/TX
add wave -noupdate /UART_TX_TB/TRANSMIT_wire
add wave -noupdate /UART_TX_TB/LOAD_EN_wire
add wave -noupdate /UART_TX_TB/LOAD
add wave -noupdate /UART_TX_TB/Done_wire
add wave -noupdate /UART_TX_TB/Data_To_Transmit
add wave -noupdate /UART_TX_TB/Bd_cnt_ovf_wire
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 369
configure wave -valuecolwidth 110
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {187 ps}
