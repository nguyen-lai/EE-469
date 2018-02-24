/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is a 3-bit to 8-bit decoder

Input: 3 bits, 1 WriteEnabler bit
Output: 8 bits
	
******************************/
`timescale 1ns/10ps
module decoder_3to8 (encoded, decoded, writeEnabler);
	//Define inputs, outputs, constant
	input logic [2:0] encoded;
	input logic writeEnabler;
	output logic [7:0] decoded;
	parameter DELAY = 0.05;

	//Perform decoding with AND gates
	and #DELAY Output0 (decoded[0], ~encoded[0], ~encoded[1], ~encoded[2], writeEnabler);
	and #DELAY Output1 (decoded[1],  encoded[0], ~encoded[1], ~encoded[2], writeEnabler);
	and #DELAY Output2 (decoded[2], ~encoded[0],  encoded[1], ~encoded[2], writeEnabler);
	and #DELAY Output3 (decoded[3],  encoded[0],  encoded[1], ~encoded[2], writeEnabler);	
	and #DELAY Output4 (decoded[4], ~encoded[0], ~encoded[1],  encoded[2], writeEnabler);
	and #DELAY Output5 (decoded[5],  encoded[0], ~encoded[1],  encoded[2], writeEnabler);
	and #DELAY Output6 (decoded[6], ~encoded[0],  encoded[1],  encoded[2], writeEnabler);
	and #DELAY Output7 (decoded[7],  encoded[0],  encoded[1],  encoded[2], writeEnabler);
	
endmodule

module decoder_3to8_testbench;
	logic writeEnabler;
	logic [7:0]decoded;
	logic [2:0]encoded;
	
	decoder_3to8 dut(.encoded, .decoded, .writeEnabler);

	initial begin
		integer i;
		writeEnabler = 1;
		for(i = 0; i < 8; i++) 
		begin
			encoded = i;
			#10;
		end
	end
endmodule