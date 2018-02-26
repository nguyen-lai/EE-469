onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /IDEXreg_testbench/ID_shiftDirection
add wave -noupdate /IDEXreg_testbench/EX_shiftDirection
add wave -noupdate /IDEXreg_testbench/clk
add wave -noupdate /IDEXreg_testbench/reset
add wave -noupdate /IDEXreg_testbench/ID_RegWrite
add wave -noupdate /IDEXreg_testbench/ID_MemWrite
add wave -noupdate /IDEXreg_testbench/ID_MemToReg
add wave -noupdate /IDEXreg_testbench/ID_BrTaken
add wave -noupdate /IDEXreg_testbench/ID_read_enable
add wave -noupdate /IDEXreg_testbench/ID_NOOP
add wave -noupdate /IDEXreg_testbench/EX_RegWrite
add wave -noupdate /IDEXreg_testbench/EX_MemWrite
add wave -noupdate /IDEXreg_testbench/EX_MemToReg
add wave -noupdate /IDEXreg_testbench/EX_BrTaken
add wave -noupdate /IDEXreg_testbench/EX_read_enable
add wave -noupdate /IDEXreg_testbench/EX_NOOP
add wave -noupdate /IDEXreg_testbench/ID_ALUSRC
add wave -noupdate /IDEXreg_testbench/EX_ALUSRC
add wave -noupdate /IDEXreg_testbench/ID_ALUOp
add wave -noupdate /IDEXreg_testbench/EX_ALUOp
add wave -noupdate /IDEXreg_testbench/ID_xfer_size
add wave -noupdate /IDEXreg_testbench/EX_xfer_size
add wave -noupdate /IDEXreg_testbench/EX_Rn
add wave -noupdate /IDEXreg_testbench/EX_Rm
add wave -noupdate /IDEXreg_testbench/EX_Rd
add wave -noupdate /IDEXreg_testbench/IFID_Rn
add wave -noupdate /IDEXreg_testbench/IFID_Rm
add wave -noupdate /IDEXreg_testbench/IFID_Rd
add wave -noupdate /IDEXreg_testbench/EX_instruction
add wave -noupdate /IDEXreg_testbench/ID_instruction
add wave -noupdate /IDEXreg_testbench/ID_PC
add wave -noupdate /IDEXreg_testbench/ID_RegA_content
add wave -noupdate /IDEXreg_testbench/ID_RegB_content
add wave -noupdate /IDEXreg_testbench/ID_Imm12Extended
add wave -noupdate /IDEXreg_testbench/ID_DAddr9Extended
add wave -noupdate /IDEXreg_testbench/EX_PC
add wave -noupdate /IDEXreg_testbench/EX_RegA_content
add wave -noupdate /IDEXreg_testbench/EX_RegB_content
add wave -noupdate /IDEXreg_testbench/EX_Imm12Extended
add wave -noupdate /IDEXreg_testbench/EX_DAddr9Extended
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
WaveRestoreZoom {449050 ps} {450050 ps}
