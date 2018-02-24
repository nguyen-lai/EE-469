/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is 32 to 1 multiplexer
from 2 [16:1 Mux] and 1 [2:1 Mux]

Input: 32 bits, 5 select lines
Output: 1 bit
	
******************************/
`timescale 1ns/10ps
module mux_32to1 (select, in, out);
	// Define inputs, outputs and wires
	input logic [31:0] in;
	input logic [4:0] select;
	output logic out;
	
	logic mux1out, mux2out;
	
	// Perform multiplexing process
	mux_16to1 mux1   (.select(select[3:0]), .in(in[15:0]),  .out(mux1out));
	mux_16to1 mux2   (.select(select[3:0]), .in(in[31:16]), .out(mux2out));
	mux_2to1 result  (.select(select[4]), .a(mux1out), .b(mux2out), .y(out));

endmodule

module mux_32to1_testbench();
	logic [31:0] in;
	logic [4:0] select;
	logic out;
	
	mux_32to1 dut (.select, .in, .out);
	
	initial begin
		int i;
		in = 32'd73267;
		for(i = 0; i < 31; i++) 
		begin
			select = i;
			#10;
		end
		
		in = 32'd93041;
		for(i = 0; i < 31; i++) 
		begin
			select = i;
			#10;
		end
	end
endmodule