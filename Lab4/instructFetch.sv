/*************************************************
Nguyen Lai
1572743
Winter 2018
CSE 469
Lab 4

Instruction Fetch Stage Pipelined for CPU
	
*********************************************/
`timescale 1ns/10ps
module instructFetch (instruction, currentPC, UncondBr, BrTaken, clk, reset);
	input logic BrTaken, UncondBr, clk, reset;
	output logic [31:0] instruction;
	output logic [63:0] currentPC;
	
	// Fetch instruction from current PC
	instructmem fecthInstruct(.address(currentPC), .instruction, .clk);
	
	logic [63:0] nextPC;
	// Add 4 to current instructrion
	addressAdder theAddressAdder1 (.A(currentPC), .B(64'd4), .sum(nextPC));
	
	logic [63:0] condAddrExtended, brAddrExtended;
	// Sign Extend condAddr19 and brAddr26
	signExtend #(.WIDTH(19)) condAddrExtend (.in(instruction[23:5]), .out(condAddrExtended));
	signExtend  #(.WIDTH(26)) brAddrExtend (.in(instruction[25:0]), .out(brAddrExtended));
	
	// Put results after sign extension into 2:1 Mux with control signal UncondBr
	logic [63:0] UncondMuxOut;
	genvar i;
	generate 
		for (i = 0; i < 64; i++) begin: eachUncondMux
			mux_2to1 theMuxes1 (.select(UncondBr), .a(condAddrExtended[i]), .b(brAddrExtended[i]), .y(UncondMuxOut[i]));
		end
	endgenerate
	
	logic [63:0] shifterOut;
	
	// Shift result from UncondMux
	shifter shifted (.value(UncondMuxOut), .direction(1'b0), .distance(6'b000010), .result(shifterOut));
	logic [63:0] PCplusBranch;
	// Add the shifted result with current PC
	addressAdder theAddressAdder2 (.A(currentPC), .B(shifterOut), .sum(PCplusBranch));
	
	// Mux to choose whether to branch or not
	logic [63:0] BrTakenOut;
	generate 
		for (i = 0; i < 64; i++) begin: eachBrTakenMux
			mux_2to1 theMuxes2 (.select(BrTaken), .a(nextPC[i]), .b(PCplusBranch[i]), .y(BrTakenOut[i]));
		end
	endgenerate
	
	// Store next PC to Program COunter
	PC storePC (.in(BrTakenOut), .out(currentPC), .clk, .reset);
		
endmodule

module instructFetch_testbench;
	logic clk, reset, BrTaken, UncondBr;
	logic [31:0] instruction;
	logic [63:0] currentPC;

	instructFetch dut(.instruction, .currentPC, .UncondBr, .BrTaken, .clk, .reset);

	parameter CLOCK_PERIOD= 10000;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	always_comb begin
		if(instruction[31:26] == 6'b000101) begin
			UncondBr = 1'b1;
			BrTaken = 1'b1;
		end
		else begin
			UncondBr = 1'b0;
			BrTaken = 1'b0;
		end
	end
	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		for(i = 0; i < 15; i++) begin
			@(posedge clk);
		end
		$stop;
	end
endmodule