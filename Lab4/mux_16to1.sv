/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is 16 to 1 multiplexer
from 2 [8:1 Mux] and 1 [2:1 Mux]

Input: 16 bits, 4 select lines
Output: 1 bit
	
******************************/
`timescale 1ns/10ps
module mux_16to1 (select, in, out);
	// Define inputs, outputs and wires
	input logic [15:0] in;
	input logic [3:0] select;
	output logic out;
	
	logic mux1out, mux2out;
	
	// Perform multiplexing process
	mux_8to1 mux1   (.select(select[2:0]), .in(in[7:0]),  .out(mux1out));
	mux_8to1 mux2   (.select(select[2:0]), .in(in[15:8]), .out(mux2out));
	mux_2to1 result (.select(select[3]), .a(mux1out), .b(mux2out), .y(out));

endmodule

module mux_16to1_testbench();
	logic [15:0] in;
	logic [3:0] select;
	logic out;
	
	mux_16to1 dut (.select, .in, .out);
	
	initial begin
		int i;
		in = 16'd25;
		for(i = 0; i < 16; i++) 
		begin
			select = i;
			#10;
		end
		
		in = 16'd5099;
		for(i = 0; i < 16; i++) 
		begin
			select = i;
			#10;
		end
	end
endmodule