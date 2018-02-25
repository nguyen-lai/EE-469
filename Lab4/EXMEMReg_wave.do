onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /EXMEMReg_testbench/clk
add wave -noupdate /EXMEMReg_testbench/reset
add wave -noupdate /EXMEMReg_testbench/MEM_RegWrite
add wave -noupdate /EXMEMReg_testbench/MEM_MemWrite
add wave -noupdate /EXMEMReg_testbench/MEM_MemToReg
add wave -noupdate /EXMEMReg_testbench/MEM_BrTaken
add wave -noupdate /EXMEMReg_testbench/MEM_read_enable
add wave -noupdate /EXMEMReg_testbench/MEM_NOOP
add wave -noupdate /EXMEMReg_testbench/MEM_xfer_size
add wave -noupdate /EXMEMReg_testbench/EX_RegWrite
add wave -noupdate /EXMEMReg_testbench/EX_MemWrite
add wave -noupdate /EXMEMReg_testbench/EX_MemToReg
add wave -noupdate /EXMEMReg_testbench/EX_BrTaken
add wave -noupdate /EXMEMReg_testbench/EX_read_enable
add wave -noupdate /EXMEMReg_testbench/EX_NOOP
add wave -noupdate /EXMEMReg_testbench/EX_xfer_size
add wave -noupdate /EXMEMReg_testbench/EX_Rn
add wave -noupdate /EXMEMReg_testbench/EX_Rm
add wave -noupdate /EXMEMReg_testbench/EX_Rd
add wave -noupdate /EXMEMReg_testbench/MEM_Rn
add wave -noupdate /EXMEMReg_testbench/MEM_Rm
add wave -noupdate /EXMEMReg_testbench/MEM_Rd
add wave -noupdate /EXMEMReg_testbench/MEM_ALUResult
add wave -noupdate /EXMEMReg_testbench/MEM_IncrementedPC
add wave -noupdate /EXMEMReg_testbench/MEM_RegB_content
add wave -noupdate /EXMEMReg_testbench/EX_ALUResult
add wave -noupdate /EXMEMReg_testbench/EX_IncrementedPC
add wave -noupdate /EXMEMReg_testbench/EX_RegB_content
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45263771 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 439
configure wave -valuecolwidth 39
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
WaveRestoreZoom {0 ps} {28819508 ps}
