//Jake Robinson
//Winter 2018
//CSE 469
//
//EX/MEM pipe register. 

`timescale 1ns/10ps

module EXMEMReg(

	//outputs
	MEM_RegWrite, MEM_MemWrite, MEM_MemToReg, MEM_BrTaken,
	MEM_read_enable, MEM_NOOP, MEM_xfer_size,
	
	MEM_Rn, MEM_Rm, MEM_Rd,
	
	MEM_ALUResult, MEM_IncrementedPC, MEM_RegB_content,
	
	//inputs
	clk, reset,
	
	EX_RegWrite, EX_MemWrite, EX_MemToReg, EX_BrTaken,
	EX_read_enable, EX_NOOP, EX_xfer_size,
	
	
	EX_Rn, EX_Rm, EX_Rd,
	
	EX_ALUResult, EX_IncrementedPC, EX_RegB_content
);

//-----------------------OUTPUTS----------------------------------------------
	output logic MEM_RegWrite, MEM_MemWrite, MEM_MemToReg, MEM_BrTaken,
	MEM_read_enable, MEM_NOOP, MEM_xfer_size;
	
	
	output logic [4:0] MEM_Rn, MEM_Rm, MEM_Rd;

	output logic [63:0] MEM_ALUResult, MEM_IncrementedPC, MEM_RegB_content;

//----------------------------------------------------------------------------



//----------------------INPUTS------------------------------------------------

	input logic clk, reset;
	input logic EX_RegWrite, EX_MemWrite, EX_MemToReg, EX_BrTaken,
	EX_read_enable, EX_NOOP, EX_xfer_size;
	
	
	input logic [4:0] EX_Rn, EX_Rm, EX_Rd;

	input logic [63:0] EX_ALUResult, EX_IncrementedPC, EX_RegB_content;
	
//------------------------------------------------------------------------------
	
	//create a register for each parameter to be passed through the pipe
	
	parameterized_register #(.SIZE(1)) RegWriteReg(.d(EX_RegWrite), .q(MEM_RegWrite), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(1)) MemWriteReg(.d(EX_MemWrite), .q(MEM_MemWrite), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(1)) MemToRegReg(.d(EX_MemToReg), .q(MEM_MemToReg), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(1)) BrTakenReg(.d(EX_BrTaken), .q(MEM_BrTaken), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(1)) read_enableReg(.d(EX_read_enable), .q(MEM_read_enable), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(1)) NOOPReg(.d(EX_NOOP), .q(MEM_NOOP), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(1)) xfer_sizeReg(.d(EX_xfer_size), .q(MEM_xfer_size), .en(1'b1), .reset, .clk);
	
	
	parameterized_register #(.SIZE(5)) RnReg(.d(EX_Rn), .q(MEM_Rn), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(5)) RmReg(.d(EX_Rm), .q(MEM_Rm), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(5)) RdReg(.d(EX_Rd), .q(MEM_Rd), .en(1'b1), .reset, .clk);
	
	parameterized_register #(.SIZE(64)) ALUResultReg(.d(EX_ALUResult), .q(MEM_ALUResult), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(64)) IncrementedPCReg(.d(EX_IncrementedPC), .q(MEM_IncrementedPC), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(64)) RegB_contentReg(.d(EX_RegB_content), .q(MEM_RegB_content), .en(1'b1), .reset, .clk);
	
endmodule






module EXMEMReg_testbench();
	logic clk, reset;
	
	logic MEM_RegWrite, MEM_MemWrite, MEM_MemToReg, MEM_BrTaken,
	MEM_read_enable, MEM_NOOP, MEM_xfer_size;
	
	logic EX_RegWrite, EX_MemWrite, EX_MemToReg, EX_BrTaken,
	EX_read_enable, EX_NOOP, EX_xfer_size;
	
	
	logic [4:0] EX_Rn, EX_Rm, EX_Rd;
	logic [4:0] MEM_Rn, MEM_Rm, MEM_Rd;
	
	
	logic [63:0] MEM_ALUResult, MEM_IncrementedPC, MEM_RegB_content;
	logic [63:0] EX_ALUResult, EX_IncrementedPC, EX_RegB_content;
	
	EXMEMReg dut(
	//outputs
	.MEM_RegWrite, .MEM_MemWrite, .MEM_MemToReg, .MEM_BrTaken,
	.MEM_read_enable, .MEM_NOOP, .MEM_xfer_size,
	
	.MEM_Rn, .MEM_Rm, .MEM_Rd,
	
	.MEM_ALUResult, .MEM_IncrementedPC, .MEM_RegB_content,
	
	//inputs
	.clk, .reset,
	
	.EX_RegWrite, .EX_MemWrite, .EX_MemToReg, .EX_BrTaken,
	.EX_read_enable, .EX_NOOP, .EX_xfer_size,
	
	
	.EX_Rn,.EX_Rm, .EX_Rd,
	
	.EX_ALUResult, .EX_IncrementedPC, .EX_RegB_content
	
	);
	
	//set up the clk
	initial begin
		parameter PERIOD = 100;
		clk <= 0;
		forever #(PERIOD/2) clk = ~clk;
	end
	
	
	initial begin
	
		reset <= 1;
		
		EX_RegWrite <= 1;
		EX_MemWrite <= 1;
		EX_MemToReg <= 1;
		EX_BrTaken <= 1;
		EX_read_enable <= 1;
		EX_NOOP <= 1;
		EX_xfer_size <= 1;
		
		EX_Rn <= 5'b11111;
		EX_Rm <= 5'b00000;
		EX_Rd <= 5'b10101;
		
		EX_ALUResult <= 64'hFFFFFFFF0000000F;
		EX_IncrementedPC <= 64'hA;
		EX_RegB_content <= 64'hFFFFFFFFFFFFFFF0;
	
		@(posedge clk);
		@(posedge clk);
		
		reset <= 0;
		
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		reset <= 1;
		@(posedge clk);
		@(posedge clk);
		
		reset <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
	$stop;
	end
endmodule