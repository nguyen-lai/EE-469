/*************************************************
Nguyen Lai
1572743
Winter 2018
CSE 469
Lab 4

IF/ID register to pass instruction to other stages 
	
*********************************************/
`timescale 1ns/10ps

module IFID_register(clk, reset, IF_PC, ID_PC, IF_instruction, ID_instruction);
	input logic clk, reset;
	input logic [31:0] IF_instruction;
	input logic [63:0] IF_PC;
	output logic [31:0] ID_instruction;
	output logic [63:0] ID_PC;
	
	register thePCregister (.d(IF_PC), .q(ID_PC), .en(1'b1), .reset, .clk);
	register_32 theInstructionReg (.d(IF_instruction), .q(ID_instruction), .en(1'b1), .reset, .clk);
	
endmodule

module IFID_register_testbench();
	logic clk, reset;
	logic [31:0] IF_instruction;
	logic [63:0] IF_PC;
	logic [31:0] ID_instruction;
	logic [63:0] ID_PC;
	
	IFID_register dut(.clk, .reset, .IF_PC, .ID_PC, .IF_instruction, .ID_instruction);
	
	parameter CLOCK_PERIOD = 100; 
	
		initial begin 
	
		clk <= 0;
	
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
 
		end
		
	initial begin
	
		reset <= 1;																																	@(posedge clk)	
		reset <= 0; IF_instruction <= 32'd1996; IF_PC <= 64'd9999313;																@(posedge clk)	
																																						@(posedge clk)	
																																						@(posedge clk)	
																																						@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)	
													         @(posedge clk)	
																@(posedge clk)
																@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)		
																@(posedge clk)	
																@(posedge clk)	
		reset <= 1;											@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)	
																$stop;
	end
endmodule