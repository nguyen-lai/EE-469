/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is 4 to 1 multiplexer
from 3 [2:1 Mux]

Input: 4 bits, 2 select lines
Output: 1 bit
	
******************************/
`timescale 1ns/10ps
module mux_4to1 (select, in, out);
	// Define inputs, outputs and wires
	input logic [3:0] in;
	input logic [1:0] select;
	output logic out;
	
	logic mux1out, mux2out;
	
	// Perform multiplexing process
	mux_2to1 mux1   (.select(select[0]), .a(in[0]),   .b(in[1]),   .y(mux1out));
	mux_2to1 mux2   (.select(select[0]), .a(in[2]),   .b(in[3]),   .y(mux2out));
	mux_2to1 result (.select(select[1]), .a(mux1out), .b(mux2out), .y(out));

endmodule

module mux_4to1_testbench();
	logic [3:0] in;
	logic [1:0] select;
	logic out;
	
	mux_4to1 dut (.select, .in, .out);
	
	initial begin
		in = 4'b1110; select = 2'b00; #10;
		in = 4'b1110; select = 2'b01; #10;
		in = 4'b1110; select = 2'b10; #10;
		in = 4'b1110; select = 2'b11; #10;

		in = 4'b1010; select = 2'b00; #10;
		in = 4'b1010; select = 2'b01; #10;
		in = 4'b1010; select = 2'b10; #10;
		in = 4'b1010; select = 2'b11; #10;	
	
		in = 4'b0110; select = 2'b00; #10;
		in = 4'b0110; select = 2'b01; #10;
		in = 4'b0110; select = 2'b10; #10;
		in = 4'b0110; select = 2'b11; #10;	

		in = 4'b0001; select = 2'b00; #10;
		in = 4'b0001; select = 2'b01; #10;
		in = 4'b0001; select = 2'b10; #10;
		in = 4'b0001; select = 2'b11; #10;
	end
endmodule