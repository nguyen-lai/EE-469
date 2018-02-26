
//Jake Robinson
//Winter 2018
//CSE 469
//
//ID/EX pipe register. 
	
	
	
//removed Reg2Loc and UncondBr, added shiftDirection

`timescale 1ns/10ps

module IDEXreg(
	clk, reset,
	//control signal outputs
	EX_RegWrite, EX_MemWrite, EX_MemToReg, EX_BrTaken,
	EX_read_enable, EX_NOOP, EX_shiftDirection,  //EX_LDURB, EX_MOVZnotMOVK, shift direction = 1 bit, alu result = 2 bit
	EX_ALUSRC, EX_ALUOp, EX_xfer_size,
	
	//PC address output
	EX_PC, 

	//instruction output
	EX_instruction,

	//Regfile read data outputs
	EX_RegA_content, EX_RegB_content,
	
	//Rm, Rn, and Rd outputs
	EX_Rn, EX_Rm, EX_Rd,
	
	//sign-extended imm outputs
	EX_Imm12Extended, EX_DAddr9Extended,
	
	//shift amount output
	EX_shamt,
	
	//shift/mult result mux control signal
	EX_ALUResult,
	EX_UncondMuxOut,
	
	
	//control signal inputs
	ID_RegWrite, ID_MemWrite, ID_MemToReg, ID_BrTaken,
	ID_read_enable, ID_NOOP, ID_shiftDirection, //ID_LDURB, ID_MOVZnotMOVK,---------------------------<------
	ID_ALUSRC, ID_ALUOp, ID_xfer_size,
	
	//PC address input
	ID_PC, 
	
	//instruction input
	ID_instruction,
	
	//REgfile read data inputs
	ID_RegA_content, ID_RegB_content,
	
	//Rm, Rn, and Rd inputs
	IFID_Rn, IFID_Rm, IFID_Rd,
	
	//Sign-extended imm inputs
	ID_Imm12Extended, ID_DAddr9Extended,
	
	//shift amount input
	ID_shamt,
	
	//shift/mult result mux control signal
	ID_ALUResult,
	
	ID_UncondMuxOut

); 

//---------------------OUTPUTS-------------------------------------------------------------

//control signal outputs
	output logic EX_RegWrite, EX_MemWrite, EX_MemToReg, EX_BrTaken,
	EX_read_enable, EX_NOOP, EX_shiftDirection;
	output logic [1:0] EX_ALUSRC;
	output logic [2:0] EX_ALUOp;
	output logic [3:0] EX_xfer_size;
 
	//PC address output
	output logic [63:0] EX_PC;
	
	//instruction output
	output logic [31:0] EX_instruction;
	
	//Regfile read data outputs
	output logic [63:0] EX_RegA_content, EX_RegB_content, EX_UncondMuxOut;
	
	//Rm, Rn, and Rd
	output logic [4:0] EX_Rn, EX_Rm, EX_Rd;
	
	//sign-extended Imm inputs 
	output logic [63:0] EX_Imm12Extended, EX_DAddr9Extended;
	
	output logic [5:0] EX_shamt;
	output logic [1:0] EX_ALUResult;
	
//----------------------------------------------------------------------------------------	

	
//----------------------INPUTS------------------------------------------------------------
	
	//control signal inputs
	input logic ID_RegWrite, ID_MemWrite, ID_MemToReg, ID_BrTaken,
	ID_read_enable, ID_NOOP, ID_shiftDirection;
	input logic [1:0] ID_ALUSRC;
	input logic [2:0] ID_ALUOp;
	input logic [3:0] ID_xfer_size;
 
	//PC address input
	input logic [63:0] ID_PC;
	
	//instruction input
	input logic [31:0] ID_instruction;
	
	//Regfile read data inputs
	input logic [63:0] ID_RegA_content, ID_RegB_content;
	
	//Rm, Rn, and Rd
	input logic [4:0] IFID_Rn, IFID_Rm, IFID_Rd;
	
	//sign-extended Imm inputs 
	input logic [63:0] ID_Imm12Extended, ID_DAddr9Extended, ID_UncondMuxOut;
	
	//shamt input and ALU result control signal
	input logic [5:0] ID_shamt;
	input logic [1:0] ID_ALUResult;
	
	
	
//--------------------------------------------------
 
	input logic clk, reset;

	
 //create a bunch of registers for all the outputs
	// parameterized_register #(.SIZE(1)) Reg2LocReg(.d(ID_Reg2Loc), .q(EX_Reg2Loc), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(1)) RegWriteReg(.d(ID_RegWrite), .q(EX_RegWrite), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(1)) MemWriteReg(.d(ID_MemWrite), .q(EX_MemWrite), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(1)) MemToRegReg(.d(ID_MemToReg), .q(EX_MemToReg), .en(1'b1), .reset, .clk);
	 //parameterized_register #(.SIZE(1)) UncondBrReg(.d(ID_UncondBr), .q(EX_UncondBr), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(1)) BrTakenReg(.d(ID_BrTaken), .q(EX_BrTaken), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(1)) read_enableReg(.d(ID_read_enable), .q(EX_read_enable), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(1)) NOOPReg(.d(ID_NOOP), .q(EX_NOOP), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(1)) shiftDirectionReg(.d(ID_shiftDirection), .q(EX_shiftDirection), .en(1'b1), .reset, .clk);
	// parameterized_register #(.SIZE(1)) LDURBReg(.d(ID_LDURB), .q(EX_LDURB), .en(1'b1), .reset, .clk);
	// parameterized_register #(.SIZE(1)) MOVZnotMOVKReg(.d(ID_MOVZnotMOVK), .q(EX_MOVZnotMOVK), .en(1'b1), .reset, .clk);
	 
	 parameterized_register #(.SIZE(2)) ALUSRCReg(.d(ID_ALUSRC), .q(EX_ALUSRC), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(3)) ALUOPReg(.d(ID_ALUOp), .q(EX_ALUOp), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(4)) xfer_sizeReg(.d(ID_xfer_size), .q(EX_xfer_size), .en(1'b1), .reset, .clk);
	 
	 parameterized_register #(.SIZE(64)) PCReg(.d(ID_PC), .q(EX_PC), .en(1'b1), .reset, .clk);
	 
	 parameterized_register #(.SIZE(32)) instructionReg(.d(ID_instruction), .q(EX_instruction), .en(1'b1), .reset, .clk);
	 
	 parameterized_register #(.SIZE(64)) RegA_contentReg(.d(ID_RegA_content), .q(EX_RegA_content), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(64)) RegB_contentReg(.d(ID_RegB_content), .q(EX_RegB_content), .en(1'b1), .reset, .clk);
	 
	 parameterized_register #(.SIZE(5)) RnReg(.d(IFID_Rn), .q(EX_Rn), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(5)) RmReg(.d(IFID_Rm), .q(EX_Rm), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(5)) RdReg(.d(IFID_Rd), .q(EX_Rd), .en(1'b1), .reset, .clk);
	 
	 parameterized_register #(.SIZE(64)) Imm12Reg(.d(ID_Imm12Extended), .q(EX_Imm12Extended), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(64)) DAddr9Reg(.d(ID_DAddr9Extended), .q(EX_DAddr9Extended), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(64)) UncondMuxOutReg(.d(ID_UncondMuxOut), .q(EX_UncondMuxOut), .en(1'b1), .reset, .clk);
	 
	 parameterized_register #(.SIZE(6)) shamtReg(.d(ID_shamt), .q(EX_shamt), .en(1'b1), .reset, .clk);
	 parameterized_register #(.SIZE(2)) ALUResultReg(.d(ID_ALUResult), .q(EX_ALUResult), .en(1'b1), .reset, .clk);
	 
	 
endmodule


module IDEXreg_testbench(); 

	logic clk, reset, ID_RegWrite, ID_MemWrite, ID_MemToReg, ID_BrTaken,
	ID_read_enable, ID_NOOP, ID_shiftDirection, EX_RegWrite, EX_MemWrite, EX_MemToReg, EX_BrTaken,
	EX_read_enable, EX_NOOP, EX_shiftDirection;
	
	logic [1:0] ID_ALUSRC, EX_ALUSRC, ID_ALUResult, EX_ALUResult;
	logic [2:0] ID_ALUOp, EX_ALUOp;
	logic[3:0] ID_xfer_size, EX_xfer_size;
	logic[4:0] EX_Rn, EX_Rm, EX_Rd, IFID_Rn, IFID_Rm, IFID_Rd;
	logic [5:0] ID_shamt, EX_shamt;
	logic[31:0] EX_instruction, ID_instruction;
	
	logic[63:0] ID_PC, ID_RegA_content, ID_RegB_content, ID_Imm12Extended, ID_DAddr9Extended, ID_UncondMuxOut;
	logic[63:0] EX_PC, EX_RegA_content, EX_RegB_content, EX_Imm12Extended, EX_DAddr9Extended, EX_UncondMuxOut;

	IDEXreg dut(

	.clk, .reset,
	//control signal outputs
   .EX_RegWrite, .EX_MemWrite, .EX_MemToReg, .EX_BrTaken,
	.EX_read_enable, .EX_NOOP, .EX_shiftDirection,
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
	
	
	//control signal inputs.
	.ID_RegWrite, .ID_MemWrite, .ID_MemToReg, .ID_BrTaken,
	.ID_read_enable, .ID_NOOP, .ID_shiftDirection,
	.ID_ALUSRC, .ID_ALUOp, .ID_xfer_size,
	
	//PC address input
	.ID_PC, 
	
	//instruction input
	.ID_instruction,
	
	//REgfile read data inputs
	.ID_RegA_content, .ID_RegB_content,
	
	//Rm, Rn, and Rd inputs
	.IFID_Rn, .IFID_Rm, .IFID_Rd,
	
	//Sign-extended imm inputs
	.ID_Imm12Extended, .ID_DAddr9Extended,
	
		//shamt input and ALU result control signal
	.ID_shamt, .ID_ALUResult,
	
	.ID_UncondMuxOut
	);
	
	//set up the clk
	initial begin
		parameter PERIOD = 100;
		clk <= 0;
		forever #(PERIOD/2) clk = ~clk;
	end
	
	
	initial begin
	
		reset <= 1;
		
		
		ID_RegWrite <= 1;
		ID_MemWrite <= 1;
		ID_MemToReg <= 1;

		ID_BrTaken <= 1;
		ID_read_enable <= 1;
		ID_NOOP <= 1;
		ID_shiftDirection <= 1;
		
		ID_ALUSRC <= 2'b10;
		ID_ALUResult <= 2'b10; 
		
		
		ID_ALUOp <= 3'b111;
		
		ID_xfer_size <= 4'b1111;
	
		IFID_Rn <= 5'b11111;
		IFID_Rm <= 5'b11111;
		IFID_Rd <= 5'b11111;
		
		ID_shamt <= 6'b111111;
		
		
		ID_instruction <= 8'hFFFFFFFF;
		
		ID_PC <= 16'hFFFFFFFFFFFFFFFF;
		ID_RegA_content <= 16'hFFFFFFFFFFFFFFFF;
		ID_RegB_content <= 16'hFFFFFFFFFFFFFFFF;
		ID_Imm12Extended <= 16'hFFFFFFFFFFFFFFFF;
		ID_DAddr9Extended <= 16'hFFFFFFFFFFFFFFFF;
		
		@(posedge clk);
		
		reset <= 0; 
		
		@(posedge clk);
		@(posedge clk);
		
		reset <= 1; 
		@(posedge clk);
		@(posedge clk);
		
		$stop;
	
	end
	
endmodule







