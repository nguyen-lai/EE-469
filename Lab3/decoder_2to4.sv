/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is a 2-bit to 4-bit decoder

Input: 2 bits, 1 WriteEnabler bit
Output: 4 bits
	
******************************/
`timescale 1ns/10ps
module decoder_2to4 (encoded, decoded, writeEnabler);
	// Define inputs, outputs and constant
	input logic [1:0] encoded;
	input logic writeEnabler;
	output logic [3:0] decoded;
	parameter DELAY = 0.05;
 
	
	//Perform decoding with AND gates
	and #DELAY Output0 (decoded[0], ~encoded[0], ~encoded[1], writeEnabler);
	and #DELAY Output1 (decoded[1],  encoded[0], ~encoded[1], writeEnabler);
	and #DELAY Output2 (decoded[2], ~encoded[0],  encoded[1], writeEnabler);
	and #DELAY Output3 (decoded[3],  encoded[0],  encoded[1], writeEnabler);
	
endmodule

module decoder_2to4_testbench;
	logic writeEnabler;
	logic [3:0]decoded;
	logic [1:0]encoded;
	
	decoder_2to4 dut(.encoded, .decoded, .writeEnabler);

	initial begin
		integer i;
		writeEnabler = 1;
		for(i = 0; i < 4; i++) 
		begin
			encoded = i;
			#10;
		end
	end
endmodule