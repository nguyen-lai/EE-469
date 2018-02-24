/*************************************************
Nguyen Lai
1572743
Winter 2018
CSE 469
Lab 3

Control Signals for CPU
	
*********************************************/
`timescale 1ns/10ps
module controlSignals (Reg2Loc, RegWrite, ALUSrc, ALUOp, zero, MemWrite, MemToReg, UncondBr, BrTaken, instruction, 
								xfer_size, negative, overflow, read_enable, NOOP, LDURB, MOVZnotMOVK);
	parameter DELAY = 0.05;
	input logic [31:0] instruction;
	input logic zero, negative, overflow;
	output logic Reg2Loc, RegWrite, MemWrite, MemToReg, UncondBr, BrTaken, read_enable, NOOP, LDURB, MOVZnotMOVK;
	output logic [1:0] ALUSrc;
	output logic [2:0] ALUOp;
	output logic [3:0] xfer_size;
	
	logic BLTxorResult;
	xor #DELAY BLTxor (BLTxorResult, negative, overflow);
	
	parameter B = 11'b000101xxxxx,
				ADDI = 11'b1001000100x,
				ADDS = 11'b10101011000,
				SUBS = 11'b11101011000,
				BLT = 11'b01010100xxx,
				CBZ = 11'b10110100xxx,
				LDUR = 11'b11111000010,
				STUR = 11'b11111000000,
				LDURB_Signals = 11'b00111000010,
				STURB = 11'b00111000000,
				MOVK = 11'b111_1001_01xx,
				MOVZ = 11'b110_1001_01xx;
				
				
	always_comb begin
		casex (instruction[31:21])
			B: begin
				Reg2Loc = 1'bx;
				RegWrite = 1'b0;
				ALUSrc = 2'bxx;
				ALUOp = 3'bxxx;
				MemWrite = 1'b0;
				MemToReg = 1'bx;
				UncondBr = 1'b1;
				BrTaken = 1'b1;
				read_enable = 1'b0;
				xfer_size = 4'bxxxx;
				NOOP = 1'b1;
				LDURB = 1'bx;
				MOVZnotMOVK = 1'bx;
				end
			
			ADDI: begin
				if (instruction == 32'b1001000100_000000000000_11111_11111)
					NOOP = 1'b1;
				else
					NOOP = 1'b0;
				Reg2Loc = 1'b1;
				RegWrite = 1'b1;
				ALUSrc = 2'b10;
				ALUOp = 3'b010;
				MemWrite = 1'b0;
				MemToReg = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				read_enable = 1'b0;
				xfer_size = 4'bxxxx;
				LDURB = 1'b0;
				MOVZnotMOVK = 1'bx;
				end
				
			ADDS: begin
				Reg2Loc = 1'b1;
				RegWrite = 1'b1;
				ALUSrc = 2'b00;
				ALUOp = 3'b010;
				MemWrite = 1'b0;
				MemToReg = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				read_enable = 1'b0;
				xfer_size = 4'bxxxx;
				NOOP = 1'b0;
				LDURB = 1'b0;
				MOVZnotMOVK = 1'bx;
				end
				
			SUBS: begin
				Reg2Loc = 1'b1;
				RegWrite = 1'b1;
				ALUSrc = 2'b00;
				ALUOp = 3'b011;
				MemWrite = 1'b0;
				MemToReg = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				read_enable = 1'b0;
				xfer_size = 4'bxxxx;
				NOOP = 1'b0;
				LDURB = 1'b0;
				MOVZnotMOVK = 1'bx;
				end

			BLT: begin
				Reg2Loc = 1'bx;
				RegWrite = 1'b0;
				ALUSrc = 2'bxx;
				ALUOp = 3'bxxx;
				MemWrite = 1'b0;
				MemToReg = 1'bx;
				UncondBr = 1'b0;
				BrTaken = BLTxorResult;
				read_enable = 1'b0;
				xfer_size = 4'bxxxx;
				NOOP = 1'b1;
				LDURB = 1'bx;
				MOVZnotMOVK = 1'bx;
				end
				
			CBZ: begin
				Reg2Loc = 1'b0;
				RegWrite = 1'b0;
				ALUSrc = 2'b00;
				ALUOp = 3'b000;
				MemWrite = 1'b0;
				MemToReg = 1'bx;
				UncondBr = 1'b0;
				BrTaken = zero;
				read_enable = 1'b0;
				xfer_size = 4'bxxxx;
				NOOP = 1'b0;
				LDURB = 1'bx;
				MOVZnotMOVK = 1'bx;
				end
				
			LDUR: begin
				Reg2Loc = 1'bx;
				RegWrite = 1'b1;
				ALUSrc = 2'b01;
				ALUOp = 3'b010;
				MemWrite = 1'b0;
				MemToReg = 1'b1;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				read_enable = 1'b1;
				xfer_size = 4'b1000;
				NOOP = 1'b1;
				LDURB = 1'b0;
				MOVZnotMOVK = 1'bx;
				end
				
			STUR: begin
				Reg2Loc = 1'b0;
				RegWrite = 1'b0;
				ALUSrc = 2'b01;
				ALUOp = 3'b010;
				MemWrite = 1'b1;
				MemToReg = 1'bx;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				read_enable = 1'b0;
				xfer_size = 4'b1000;
				NOOP = 1'b1;
				LDURB = 1'b0;
				MOVZnotMOVK = 1'bx;
				end
				
			LDURB_Signals: begin
				Reg2Loc = 1'bx;
				RegWrite = 1'b1;
				ALUSrc = 2'b01;
				ALUOp = 3'b010;
				MemWrite = 1'b0;
				MemToReg = 1'b1;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				read_enable = 1'b1;
				xfer_size = 4'b0001;
				NOOP = 1'b1;
				LDURB = 1'b1;
				MOVZnotMOVK = 1'bx;
				end
				
			STURB: begin
				Reg2Loc = 1'b0;
				RegWrite = 1'b0;
				ALUSrc = 2'b01;
				ALUOp = 3'b010;
				MemWrite = 1'b1;
				MemToReg = 1'bx;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				read_enable = 1'b0;
				xfer_size = 4'b0001;
				NOOP = 1'b1;
				LDURB = 1'bx;
				MOVZnotMOVK = 1'bx;
				end
				
			MOVK: begin
				Reg2Loc = 1'b0;
				RegWrite = 1'b1;
				ALUSrc = 2'b11;
				ALUOp = 3'b000;
				MemWrite = 1'b0;
				MemToReg = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				read_enable = 1'b0;
				xfer_size = 4'bxxxx;
				NOOP = 1'b1;
				LDURB = 1'bx;
				MOVZnotMOVK = 1'b0;
				end

			MOVZ: begin
				Reg2Loc = 1'b0;
				RegWrite = 1'b1;
				ALUSrc = 2'b11;
				ALUOp = 3'b000;
				MemWrite = 1'b0;
				MemToReg = 1'b0;
				UncondBr = 1'bx;
				BrTaken = 1'b0;
				read_enable = 1'b0;
				xfer_size = 4'bxxxx;
				NOOP = 1'b1;
				LDURB = 1'bx;
				MOVZnotMOVK = 1'b1;
				end								
		endcase
	end
endmodule

module controlSignals_testbench();
	logic [31:0] instruction;
	logic zero, negative, overflow;
	logic Reg2Loc, RegWrite, MemWrite, MemToReg, UncondBr, BrTaken, read_enable, NOOP, LDURB, MOVZnotMOVK;
	logic [1:0] ALUSrc;
	logic [2:0] ALUOp;
	logic [3:0] xfer_size;
	
	parameter B = 11'b000101xxxxx,
				ADDI = 11'b1001000100x,
				ADDS = 11'b10101011000,
				SUBS = 11'b11101011000,
				BLT = 11'b01010100xxx,
				CBZ = 11'b10110100xxx,
				LDUR = 11'b11111000010,
				STUR = 11'b11111000000,
				LDURB_Signals = 11'b00111000010,
				STURB = 11'b00111000000;
				
	controlSignals dut (.Reg2Loc, .RegWrite, .ALUSrc, .ALUOp, .zero, .MemWrite, .MemToReg, .UncondBr, .BrTaken, .instruction, 
							.xfer_size, .negative, .overflow, .read_enable, .NOOP, .LDURB, .MOVZnotMOVK);
	
	initial begin
		negative = 1'b0;
		zero = 1'b0;
		overflow = 1'b0;
		instruction[31:21] = B; #100;
		instruction[31:21] = ADDI; #100;
		instruction = 32'b1001000100_000000000000_11111_11111; #100;
		instruction[31:21] = ADDS; #100;
		instruction[31:21] = SUBS; #100;
		instruction[31:21] = BLT; #100;
		instruction[31:21] = CBZ; #100;
		instruction = 32'b000101_00000000000000000000001100; #100;
		$stop;
		end
endmodule