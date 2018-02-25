onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instructDecode_testbench/reset
add wave -noupdate /instructDecode_testbench/clk
add wave -noupdate /instructDecode_testbench/ID_instruction
add wave -noupdate /instructDecode_testbench/WriteData_fromWB
add wave -noupdate /instructDecode_testbench/RegWrite_fromMEMWB
add wave -noupdate /instructDecode_testbench/Reg2Loc
add wave -noupdate /instructDecode_testbench/UncondBr
add wave -noupdate -radix unsigned /instructDecode_testbench/IFID_Rn
add wave -noupdate -radix unsigned /instructDecode_testbench/IFID_Rm
add wave -noupdate -radix unsigned /instructDecode_testbench/IFID_Rd
add wave -noupdate /instructDecode_testbench/RegA_content
add wave -noupdate /instructDecode_testbench/RegB_content
add wave -noupdate /instructDecode_testbench/Imm12Extended
add wave -noupdate /instructDecode_testbench/DAddr9Extended
add wave -noupdate /instructDecode_testbench/UncondMuxOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14334829 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 285
configure wave -valuecolwidth 398
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
WaveRestoreZoom {0 ps} {89381873 ps}
