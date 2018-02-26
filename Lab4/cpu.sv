`timescale 1ns/10ps
module cpu(clk, reset);
	input logic clk, reset;
	
	// Instruction Fetch Stage
	logic [63:0] EXMEM_PCplusBranch, IF_PC;
	logic [31:0] IF_instruction;
	logic EXMEM_BrTaken;
	instructFetch theIFStage (.instruction(IF_instruction), .currentPC(IF_PC), .BranchToAddress(EXMEM_PCplusBranch), .BrTaken(EXMEM_BrTaken), .clk, .reset);

	// IF/ID Pipe
	logic [63:0] ID_PC;
	logic [31:0] ID_instruction;
	IFID_register theIFIDpipe (.clk, .reset, .IF_PC, .ID_PC, .IF_instruction, .ID_instruction);
	
	// Instruction Decode Stage
	logic [4:0] IFID_Rn, IFID_Rm, IFID_Rd;
	logic [63:0] RegA_content, RegB_content, WriteData_fromWB;
	logic RegWrite_fromMEMWB, Reg2Loc, UncondBr;
	logic [63:0] ID_Imm12Extended, ID_DAddr9Extended;
	logic [63:0] UncondMuxOut;
	logic [4:0] MEMWB_Rd;
	logic [5:0] ID_shamt;
	instructDecode theIDStage(.clk, .reset, .ID_instruction, .IFID_Rn, .IFID_Rm, .IFID_Rd, .RegA_content, .RegB_content, .WriteData_fromWB, .RegWrite_fromMEMWB, .Reg2Loc, .Imm12Extended(ID_Imm12Extended), .DAddr9Extended(ID_DAddr9Extended)
							, .UncondMuxOut, .UncondBr, .MEMWB_Rd, .shamt(ID_shamt));
	// Control Unit
	logic ID_RegWrite, ID_MemWrite, ID_MemToReg, ID_BrTaken, ID_read_enable, ID_NOOP, ID_shiftDirection;
	logic [1:0] ID_ALUSrc, ID_ALUResult;
	logic [2:0] ID_ALUOp;
	logic [3:0] ID_xfer_size;
	logic EX_zero, EX_negative, EX_overflow;
	
	controlSignals theControlUnit (.Reg2Loc, .RegWrite(ID_RegWrite), .ALUSrc(ID_ALUSrc), .ALUOp(ID_ALUOp), .zero(EX_zero), .MemWrite(ID_MemWrite), .MemToReg(ID_MemToReg), .UncondBr, .BrTaken(ID_BrTaken), .instruction(ID_instruction), 
								.xfer_size(ID_xfer_size), .negative(EX_negative), .overflow(EX_overflow), .read_enable(ID_read_enable), .NOOP(ID_NOOP), .shiftDirection(ID_shiftDirection), .ALUResult(ID_ALUResult));
	
	
	
	//-----------------------------------IDEXreg outputs-----------------------------------------------------------------
	logic EX_RegWrite, EX_MemWrite, EX_MemToReg, EX_BrTaken, EX_read_enable, EX_NOOP, EX_shiftDirection;
	
	logic [1:0] EX_ALUSRC, EX_ALUResult;
	logic [2:0] EX_ALUOp;
	logic [3:0] EX_xfer_size;
	logic [4:0] EX_Rn, EX_Rm, EX_Rd;
	logic [5:0] EX_shamt;
	
	logic [31:0] EX_instruction;
	
	logic [63:0] EX_PC, EX_RegA_content, EX_RegB_content, EX_Imm12Extended, EX_DAddr9Extended;
	//------------------------------------------------------------------------------------------------------------------
	
	
	IDEXreg theIDEXreg(.clk, .reset,
	//control signal outputs
	.EX_RegWrite, .EX_MemWrite, .EX_MemToReg, .EX_BrTaken,
	.EX_read_enable, .EX_NOOP, .EX_shiftDirection,  //EX_LDURB, EX_MOVZnotMOVK, shift direction = 1 bit, alu result = 2 bit
	.EX_ALUSRC, .EX_ALUOp, .EX_xfer_size,
	
	//PC address output
	.EX_PC, 

	//instruction output
	.EX_instruction,

	//Regfile read data outputs
	.EX_RegA_content, .EX_RegB_content,
	
	//Rm, Rn, and Rd outputs
	.EX_Rn, .EX_Rm, .EX_Rd,
	
	//sign-extended imm outputs
	.EX_Imm12Extended, .EX_DAddr9Extended,
	
	//shift amount output
	.EX_shamt,
	
	//shift/mult result mux control signal
	.EX_ALUResult,
	
	
	//control signal inputs
	.ID_RegWrite, .ID_MemWrite, .ID_MemToReg, .ID_BrTaken,
	.ID_read_enable, .ID_NOOP, .ID_shiftDirection, //ID_LDURB, ID_MOVZnotMOVK,---------------------------<------
	.ID_ALUSRC(ID_ALUSrc), .ID_ALUOp, .ID_xfer_size,
	
	//PC address input
	.ID_PC, 
	
	//instruction input
	.ID_instruction,
	
	//REgfile read data inputs
	.ID_RegA_content(RegA_content), .ID_RegB_content(RegB_content),
	
	//Rm, Rn, and Rd inputs
	.IFID_Rn, .IFID_Rm, .IFID_Rd,
	
	//Sign-extended imm inputs
	.ID_Imm12Extended, .ID_DAddr9Extended,
	
	//shift amount input
	.ID_shamt,
	
	//shift/mult result mux control signal
	.ID_ALUResult
	);
	
endmodule

module cpu_testbench();
	logic clk, reset;
	cpu dut(.clk, .reset);
	
	parameter CLOCK_PERIOD=1000;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	int i;
	
   initial begin
	
	reset = 1; @(posedge clk);
	   reset = 0; @(posedge clk);
		           @(posedge clk);
		for (i=0; i<100; i++) begin
			@(posedge clk);
		end
		$stop;
	end

endmodule