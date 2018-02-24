/*************************************************
Nguyen Lai
1572743
Winter 2018
CSE 469
Lab 3

Datapath for CPU
	
*********************************************/
`timescale 1ns/10ps
module datapath (Reg2Loc, RegWrite, ALUSrc, ALUOp, MemWrite, MemToReg, read_enable, instruction,
					 xfer_size, clk, reset, overflow, negative, zero, carry_out, NOOP, LDURB, MOVZnotMOVK);
	input logic [31:0] instruction;
	input logic Reg2Loc, RegWrite, MemWrite, MemToReg, read_enable, NOOP, clk, reset, LDURB, MOVZnotMOVK;
	input logic [1:0] ALUSrc;
	input logic [2:0] ALUOp;
	input logic [3:0] xfer_size;
	output logic overflow, negative, zero, carry_out;
	parameter DELAY = 0.05;
	
	
	logic [4:0] Ab;
	// RegToLoc Mux
	mux_5x2to1 RegToLocMux (.A(instruction[4:0]), .B(instruction[20:16]), .sel(Reg2Loc), .out(Ab));
	
	logic [63:0] Dw, Da, Db;
	regfile RegisterFile (.ReadData1(Da), .ReadData2(Db), .WriteData(Dw), .ReadRegister1(instruction[9:5]), .ReadRegister2(Ab), .WriteRegister(instruction[4:0]), .RegWrite, .clk);

	// Zero extend for Imm12
	logic [63:0] Imm12Extended;
	zeroExtend #(.WIDTH(12)) Imm12(.in(instruction[21:10]), .out(Imm12Extended));

	// Sign extend for DAddr9
	logic [63:0] DAddr9Extended;
	signExtend #(.WIDTH(9)) DAddr9(.in(instruction[20:12]), .out(DAddr9Extended));
	
	// MOV Logic
	
	logic [5:0] shiftDistance;
	logic [1:0] shamt;
	assign shamt = instruction[22:21];
	assign shiftDistance = {shamt, 4'b0}; // shiftDistance = shamt*16
	
	logic [63:0] mask; // Make a mask for masking out desired bits 
	shifter maskShift (.value(16'hFFFF), .direction(1'b0), .distance(shiftDistance), .result(mask));
	
	logic [63:0] shiftedImm16; 
	shifter imm16Shift (.value({48'b0,instruction[20:5]}), .direction(1'b0), .distance(shiftDistance), .result(shiftedImm16));	// Zero extend and left shift Imm16 to desired position
	
	logic [63:0] finalMask, Db_masked, MOVK_result;
	genvar j;
	generate 
		for (j = 0; j < 64; j++) begin: movKLogicGates
			not #DELAY (finalMask[j], mask[j]); // Invert mask to something like 000000000011111111 to mask out desired bits
			and #DELAY (Db_masked[j], Db[j], finalMask[j]); // Set desired bits of Db to 0
			or #DELAY (MOVK_result[j], Db_masked[j], shiftedImm16[j]); // Set desired bits of Db corresponding to Imm16
		end
	endgenerate
	
	logic [63:0] MOVZ_result;
	assign MOVZ_result = shiftedImm16; // MOVZ result will be the shifted Imm16
	
	// MOVZ mux to select between MOVZ or MOVK
	logic [63:0] MOVZmuxOut;
	mux_64x2to1 theMOVZmux (.A(MOVK_result), .B(MOVZ_result), .sel(MOVZnotMOVK), .out(MOVZmuxOut));
	
	// ALUSrc MUX
	logic [63:0] ALUSrcMuxOut;
	genvar i;
	generate 
		for (i = 0; i < 64; i++) begin: eachALUSrcMux
			mux_4to1 ALUSrcMuxes (.select(ALUSrc), .in({MOVZmuxOut[i], Imm12Extended[i], DAddr9Extended[i], Db[i]}), .out(ALUSrcMuxOut[i]));
		end
	endgenerate
	
	// Put information into ALU
	logic [63:0] ALUOut;
	logic negativeFlag, zeroFlag, overflowFlag, carryOutFlag;
	alu theALU (.A(Da), .B(ALUSrcMuxOut), .cntrl(ALUOp), .result(ALUOut), .negative(negativeFlag), .zero(zeroFlag), .overflow(overflowFlag), .carry_out(carryOutFlag));
	
	logic zeroFF;
	assign zero = zeroFlag;
	
	// Put flag into a flagRegister
	flagRegister flags (.d({negativeFlag, zeroFlag, overflowFlag, carryOutFlag}), .q({negative, zeroFF, overflow, carry_out}), .en(~NOOP), .reset, .clk);
	
	// Memory Read/Write
	logic [63:0] memoryOut;
	datamem theDataMem(.address(ALUOut), .write_enable(MemWrite), .read_enable, .write_data(Db), .clk, .xfer_size, .read_data(memoryOut));
	
	// Zero extend for LDURB
	logic [63:0] memoryLDURB;
	zeroExtend #(.WIDTH(8)) LDURBExtend(.in(memoryOut[7:0]), .out(memoryLDURB));
	
	// LDURB MUX
	logic [63:0] LDURBMuxOut;
	mux_64x2to1 theLDURBMux (.A(memoryOut), .B(memoryLDURB), .sel(LDURB), .out(LDURBMuxOut));
	
	
	// MemToReg Mux
	mux_64x2to1 theMemToRegMux (.A(ALUOut), .B(LDURBMuxOut), .sel(MemToReg), .out(Dw));
	
endmodule

module datapath_testbench();
	logic [31:0] instruction;
	logic Reg2Loc, RegWrite, MemWrite, MemToReg, read_enable, NOOP, clk, reset, LDURB, MOVZnotMOVK;
	logic [1:0] ALUSrc;
	logic [2:0] ALUOp;
	logic [3:0] xfer_size;
	logic overflow, negative, zero, carry_out;
	
	logic [4:0] Ab;
	logic [63:0] Dw, Da, Db;
	logic [63:0] Imm12Extended;
	logic [63:0] DAddr9Extended;
	logic [63:0] ALUSrcMuxOut;
	logic [63:0] ALUOut;
	logic [63:0] memoryOut;
	
	logic BrTaken, UncondBr;
	
	datapath dut(Reg2Loc, RegWrite, ALUSrc, ALUOp, MemWrite, MemToReg, read_enable, instruction,
					 xfer_size, clk, reset, overflow, negative, zero, carry_out, NOOP, LDURB, MOVZnotMOVK);
					 
	controlSignals control(Reg2Loc, RegWrite, ALUSrc, ALUOp, zero, MemWrite, MemToReg, UncondBr, BrTaken, instruction, 
								xfer_size, negative, overflow, read_enable, NOOP, LDURB, MOVZnotMOVK);
								
	parameter CLOCK_PERIOD= 100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	reset = 1'b1;             @(posedge clk);
   reset = 1'b0;             @(posedge clk);
	
/** BENCHMARKS 1 **/	
//	instruction = 32'b1001000100_000000000000_11111_00000; @(posedge clk);
//	@(posedge clk);
//	@(posedge clk);
//	instruction = 32'b1001000100_000000000001_00000_00001; @(posedge clk);
//	@(posedge clk);
//	instruction = 32'b1001000100_000000000001_00001_00010; @(posedge clk);
//	@(posedge clk);
//	instruction = 32'b1001000100_000000000010_00001_00011; @(posedge clk);
//	@(posedge clk);
//	instruction = 32'b1001000100_000000000100_00000_00100; @(posedge clk);
//	@(posedge clk);
//	instruction = 32'b000101_00000000000000000000000000; @(posedge clk);
//	@(posedge clk);
//	instruction = 32'b1001000100_000000000000_11111_11111; @(posedge clk);
//	@(posedge clk);

///** BENCHMARKS 2 **/	
//	instruction = 32'b1001000100_000000000001_11111_00000; @(posedge clk); // ADDI X0, X31, #1
//	@(posedge clk);
//	@(posedge clk);
//	instruction = 32'b11101011000_00000_000000_11111_00001; @(posedge clk); // SUBS X1, X31, X0 
//	@(posedge clk);
//	instruction = 32'b11101011000_00001_000000_00000_00010; @(posedge clk); // SUBS X2, X0, X1 
//	@(posedge clk);
//	instruction = 32'b11101011000_00010_000000_00001_00011; @(posedge clk); // SUBS X3, X1, X2
//	@(posedge clk);
//	instruction = 32'b11101011000_00001_000000_00011_00100; @(posedge clk); // SUBS X4, X3, X1
//	@(posedge clk);
//	instruction = 32'b10101011000_00100_000000_00011_00101; @(posedge clk); // ADDS X5, X3, X4
//	@(posedge clk);
//	instruction = 32'b10101011000_00001_000000_00000_00110; @(posedge clk); // ADDS X6, X0, X1
//	@(posedge clk);

	instruction = 32'b10110100_0000000000000010100_11111; @(posedge clk); // ADDI X0, X31, #1
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	$stop;
	end
endmodule