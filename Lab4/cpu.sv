`timescale 1ns/10ps
module cpu(clk, reset);
	input logic clk, reset;
	
	// Instruction Fetch Stage
	logic [63:0] IF_PC;
	logic [31:0] IF_instruction;
	instructFetch theIFStage (.instruction(IF_instruction), .currentPC(IF_PC), .BranchToAddress(MEM_IncrementedPC), .BrTaken(MEM_BrTaken), .clk, .reset);

	// IF/ID Pipe
	logic [63:0] ID_PC;
	logic [31:0] ID_instruction;
	IFID_register theIFIDpipe (.clk, .reset, .IF_PC, .ID_PC, .IF_instruction, .ID_instruction);
	
	// Instruction Decode Stage
	logic [4:0] IFID_Rn, IFID_Rm, IFID_Rd;
	logic [63:0] RegA_content, RegB_content, WriteData_fromWB;
	logic RegWrite_fromMEMWB, Reg2Loc, UncondBr;
	logic [63:0] ID_Imm12Extended, ID_DAddr9Extended;
	logic [63:0] ID_UncondMuxOut;
	logic [4:0] MEMWB_Rd;
	logic [5:0] ID_shamt;
	instructDecode theIDStage(.clk, .reset, .ID_instruction, .IFID_Rn, .IFID_Rm, .IFID_Rd, .RegA_content, .RegB_content, .WriteData_fromWB, .RegWrite_fromMEMWB, .Reg2Loc, .Imm12Extended(ID_Imm12Extended), .DAddr9Extended(ID_DAddr9Extended)
							, .UncondMuxOut(ID_UncondMuxOut), .UncondBr, .MEMWB_Rd, .shamt(ID_shamt));
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
	
	logic [63:0] EX_PC, EX_RegA_content, EX_RegB_content, EX_Imm12Extended, EX_DAddr9Extended, EX_UncondMuxOut;
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
	.EX_UncondMuxOut,
	
	
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
	.ID_ALUResult,
	.ID_UncondMuxOut
	);
	
	
	
	
	// EX STAGE
	logic [63:0] WB_MemToRegOut;
	logic [1:0] ForwardA, ForwardB;
	logic EX_carryout;
	logic [63:0] EX_IncrementedPC, EX_ALUResult_out;																																														//is this supposed to be the same as EX_UncondMuxOut??
	exec TheEXStage(.clk, .reset, .Da(EX_RegA_content), .Db(EX_RegB_content), .WB_MemToRegOut, .EXMEM_ALUResult(MEM_ALUResult_out), .ForwardA, .ForwardB, .ALUSrc(EX_ALUSRC), .ALUOp(EX_ALUOp), .IDEX_PC(EX_PC), .IDEX_UncondBrMuxOut(EX_UncondMuxOut), .IDEX_DAddr9(EX_DAddr9Extended)
				, .IDEX_Imm12(EX_Imm12Extended), .overflowFlag(EX_overflow), .negativeFlag(EX_negative), .carryoutFlag(EX_carryout), .zeroFlag(EX_zero)
				, .PCplusBranch(EX_IncrementedPC), .EX_ALUResult_out, .shiftDirection(EX_shiftDirection), .shamt(EX_shamt), .ALUResult(EX_ALUResult));
				
	
	
	
	
	//------------------EXMEMReg outputs---------------------------------------------------------
	logic MEM_RegWrite, MEM_MemWrite, MEM_MemToReg, MEM_BrTaken,
	MEM_read_enable, MEM_NOOP;
	logic [3:0] MEM_xfer_size;
	logic [4:0] MEM_Rn, MEM_Rm, MEM_Rd;
	logic [63:0] MEM_ALUResult_out, MEM_IncrementedPC, MEM_RegB_content;
	
	//--------------------------------------------------------------------------------------------
	
	EXMEMReg theEXMEMReg(
		//outputs
		.MEM_RegWrite, .MEM_MemWrite, .MEM_MemToReg, .MEM_BrTaken,
		.MEM_read_enable, .MEM_NOOP, .MEM_xfer_size,
		
		.MEM_Rn, .MEM_Rm, .MEM_Rd,
		
		.MEM_ALUResult_out, .MEM_IncrementedPC, .MEM_RegB_content,
		
		//inputs
		.clk, .reset,
		
		.EX_RegWrite, .EX_MemWrite, .EX_MemToReg, .EX_BrTaken,
		.EX_read_enable, .EX_NOOP, .EX_xfer_size,
		
		
		.EX_Rn, .EX_Rm, .EX_Rd,
		
		.EX_ALUResult_out, .EX_IncrementedPC, .EX_RegB_content
	);
	
	
	// MEM STAGE
	logic [63:0] MEM_datafromMem;
	 mem theMEMStage(.clk, .reset, .EXMEM_ALUResult(MEM_ALUResult_out), .EXMEM_RegB_content(MEM_RegB_content), .EXMEM_MemWrite(MEM_Write)
			, .EXMEM_read_enable(MEM_read_enable), .EXMEM_xfer_size(MEM_xfer_size), .MEM_datafromMem);
	
	
	//-------------------------------------MEMWBReg outputs---------------------------------------------
	
	logic WB_MemToReg, WB_RegWrite;
	logic [63:0] WB_datafromMem, WB_ALUResult_out;
	
	logic [4:0] WB_Rd;
	
	//---------------------------------------------------------------------------------------------------
	
	
	
	
	MEMWBReg theMEMWBReg(
		.WB_MemToReg, .WB_RegWrite,
		.WB_datafromMem,
		.WB_Rd,
		.WB_ALUResult_out,
		.clk, .reset,
		.MEM_MemToReg, .MEM_RegWrite,
		.MEM_datafromMem,
		.MEM_Rd,
		.MEM_ALUResult_out
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