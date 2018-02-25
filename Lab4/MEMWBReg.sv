//Jake Robinson
//Winter 2018
//CSE 469
//
//MEM/WB pipe register


`timescale 1ns/10ps


module MEMWBReg(
	WB_MemToReg, WB_RegWrite,
	WB_datafromMem,
	WB_Rd,
	WB_ALUResult,
	clk, reset,
	MEM_MemToReg, MEM_RegWrite,
	MEM_datafromMem,
	MEM_Rd,
	MEM_ALUResult
);




//-----------------------------------OUTPUTS-------------------------------------


	output logic WB_MemToReg, WB_RegWrite;

	output logic [63:0] WB_datafromMem, WB_ALUResult;

	output logic [4:0] WB_Rd;



//-------------------------------------------------------------------------------


//----------------------------------INPUTS---------------------------------------
	input logic clk, reset;

	input logic MEM_MemToReg, MEM_RegWrite;
	
	input logic [63:0] MEM_datafromMem, MEM_ALUResult;
	
	input logic [4:0] MEM_Rd;


//-------------------------------------------------------------------------------


	parameterized_register #(.SIZE(1)) MemToRegReg(.d(MEM_MemToReg), .q(WB_MemToReg), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(1)) RegWriteReg(.d(MEM_RegWrite), .q(WB_RegWrite), .en(1'b1), .reset, .clk);

	parameterized_register #(.SIZE(64)) datafromMemReg(.d(MEM_datafromMem), .q(WB_datafromMem), .en(1'b1), .reset, .clk);
	parameterized_register #(.SIZE(64)) ALUResultReg(.d(MEM_ALUResult), .q(WB_ALUResult), .en(1'b1), .reset, .clk);
	
	parameterized_register #(.SIZE(5)) RdReg(.d(MEM_Rd), .q(WB_Rd), .en(1'b1), .reset, .clk);
	

endmodule

module MEMWBReg_testbench();

	logic clk, reset;
	logic WB_MemToReg, WB_RegWrite, MEM_MemToReg, MEM_RegWrite;
	logic [63:0] WB_datafromMem, WB_ALUResult, MEM_datafromMem, MEM_ALUResult;
	logic [4:0] WB_Rd, MEM_Rd;
	
	MEMWBReg dut(
	WB_MemToReg, WB_RegWrite,
	WB_datafromMem,
	WB_Rd,
	WB_ALUResult,
	clk, reset,
	MEM_MemToReg, MEM_RegWrite,
	MEM_datafromMem,
	MEM_Rd,
	MEM_ALUResult
	);
	
	//set up the clk
	initial begin
		parameter PERIOD = 100;
		clk <= 0;
		forever #(PERIOD/2) clk = ~clk;
	end
	
	initial begin
	
		 reset <= 1;
		 MEM_MemToReg <= 1;
		 MEM_RegWrite <= 1;
		 
		 MEM_datafromMem <= 64'hFFFFFFFFFFFFFFFF;
		 MEM_ALUResult <= 64'hFFFFFFFFFFFFFFFF;
		 
		 MEM_Rd <= 5'b11111;
		 
		 @(posedge clk);
		 @(posedge clk);
		 
		 reset <= 0;
		 
		 @(posedge clk);
		 @(posedge clk);
		 
		 reset <= 1; 
		 @(posedge clk);
		 reset <= 0; 
		 
		 @(posedge clk);
		 @(posedge clk);
		$stop;
	end
endmodule
	