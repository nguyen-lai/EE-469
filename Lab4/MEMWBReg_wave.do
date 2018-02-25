onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MEMWBReg_testbench/clk
add wave -noupdate /MEMWBReg_testbench/reset
add wave -noupdate /MEMWBReg_testbench/WB_MemToReg
add wave -noupdate /MEMWBReg_testbench/WB_RegWrite
add wave -noupdate /MEMWBReg_testbench/MEM_MemToReg
add wave -noupdate /MEMWBReg_testbench/MEM_RegWrite
add wave -noupdate /MEMWBReg_testbench/WB_datafromMem
add wave -noupdate /MEMWBReg_testbench/WB_ALUResult
add wave -noupdate /MEMWBReg_testbench/MEM_datafromMem
add wave -noupdate /MEMWBReg_testbench/MEM_ALUResult
add wave -noupdate /MEMWBReg_testbench/WB_Rd
add wave -noupdate /MEMWBReg_testbench/MEM_Rd
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
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
