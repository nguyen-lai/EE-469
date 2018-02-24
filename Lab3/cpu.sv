`timescale 1ns/10ps
module cpu(clk, reset);
	input logic clk, reset;
	
	logic [31:0] instruction;
	logic UncondBr, BrTaken;
	logic zero, negative, overflow, carry_out;
	logic Reg2Loc, RegWrite, MemWrite, MemToReg, read_enable, NOOP, LDURB, MOVZnotMOVK;
	logic [1:0] ALUSrc;
	logic [2:0] ALUOp;
	logic [3:0] xfer_size;
	instructFetch FetchInstruction (.instruction, .UncondBr, .BrTaken, .clk, .reset);
	
	controlSignals theControl (.Reg2Loc, .RegWrite, .ALUSrc, .ALUOp, .zero, .MemWrite, .MemToReg, .UncondBr, .BrTaken, .instruction, 
								.xfer_size, .negative, .overflow, .read_enable, .NOOP, .LDURB, .MOVZnotMOVK);
								
	datapath theDataPath (.Reg2Loc, .RegWrite, .ALUSrc, .ALUOp, .MemWrite, .MemToReg, .read_enable, .instruction,
					 .xfer_size, .clk, .reset, .overflow, .negative, .zero, .carry_out, .NOOP, .LDURB, .MOVZnotMOVK);
					 
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