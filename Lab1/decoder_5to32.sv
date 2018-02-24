/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is [5-to-32 decoder] from 2 
[2-to-4 decoder] and 4 [3-to-8 decoder]

Input: 5 bits, 1 WriteEnabler bit
Output: 32 bits
	
******************************/
`timescale 1ns/10ps
module decoder_5to32 (WriteRegister, decoded, RegWrite);
	//Define inputs, outputs and constant
	input logic [4:0] WriteRegister;
	input logic RegWrite;
	output logic [31:0] decoded;
	
	// 2 MSB to 2-to-4 decoder to select which 3-to-8 decoder to produce output
	logic [3:0] select3to8;     
	decoder_2to4 decoder2to4 (.encoded(WriteRegister[4:3]), .decoded(select3to8[3:0]), .writeEnabler(RegWrite));
	
	// 3 LSB to 3-to-8 decoder to produce decoded output
	decoder_3to8 decoder_3to8_1 (.encoded(WriteRegister[2:0]), .decoded(decoded[7:0]),   .writeEnabler(select3to8[0]));
	decoder_3to8 decoder_3to8_2 (.encoded(WriteRegister[2:0]), .decoded(decoded[15:8]),  .writeEnabler(select3to8[1]));
	decoder_3to8 decoder_3to8_3 (.encoded(WriteRegister[2:0]), .decoded(decoded[23:16]), .writeEnabler(select3to8[2]));
	decoder_3to8 decoder_3to8_4 (.encoded(WriteRegister[2:0]), .decoded(decoded[31:24]), .writeEnabler(select3to8[3]));

endmodule

module decoder_5to32_testbench;
	logic [4:0] WriteRegister;
	logic RegWrite;
	logic [31:0] decoded;
	
	decoder_5to32 dut(.WriteRegister, .decoded, .RegWrite);

	initial begin
		integer i;
		RegWrite = 1;
		for(i = 0; i < 32; i++) begin
			WriteRegister = i;
			#10;
		end
	end
endmodule