onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /IFID_register_testbench/clk
add wave -noupdate /IFID_register_testbench/reset
add wave -noupdate /IFID_register_testbench/IF_instruction
add wave -noupdate /IFID_register_testbench/ID_instruction
add wave -noupdate /IFID_register_testbench/IF_PC
add wave -noupdate /IFID_register_testbench/ID_PC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {17279 ps}
