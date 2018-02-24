/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is 8 to 1 multiplexer
from 2 [4:1 Mux] and 1 [2:1 Mux]

Input: 8 bits, 3 select lines
Output: 1 bit
	
******************************/
`timescale 1ns/10ps
module mux_8to1 (select, in, out);
	// Define inputs, outputs and wires
	input logic [7:0] in;
	input logic [2:0] select;
	output logic out;
	
	logic mux1out, mux2out;
	
	// Perform multiplexing process
	mux_4to1 mux1   (.select(select[1:0]), .in(in[3:0]), .out(mux1out));
	mux_4to1 mux2   (.select(select[1:0]), .in(in[7:4]), .out(mux2out));
	mux_2to1 result (.select(select[2]), .a(mux1out), .b(mux2out), .y(out));

endmodule

module mux_8to1_testbench();
	logic [7:0] in;
	logic [2:0] select;
	logic out;
	
	mux_8to1 dut (.select, .in, .out);
	
	initial begin
		in = 8'b11000011; select = 3'b000; #10;
		in = 8'b11000011; select = 3'b001; #10;
		in = 8'b11000011; select = 3'b010; #10;
		in = 8'b11000011; select = 3'b011; #10;
		in = 8'b11000011; select = 3'b100; #10;
		in = 8'b11000011; select = 3'b101; #10;
		in = 8'b11000011; select = 3'b110; #10;
		in = 8'b11000011; select = 3'b111; #10;

		in = 8'b10101010; select = 3'b000; #10;
		in = 8'b10101010; select = 3'b001; #10;
		in = 8'b10101010; select = 3'b010; #10;
		in = 8'b10101010; select = 3'b011; #10;
		in = 8'b10101010; select = 3'b100; #10;
		in = 8'b10101010; select = 3'b101; #10;
		in = 8'b10101010; select = 3'b110; #10;
		in = 8'b10101010; select = 3'b111; #10;

		in = 8'b00001111; select = 3'b000; #10;
		in = 8'b00001111; select = 3'b001; #10;
		in = 8'b00001111; select = 3'b010; #10;
		in = 8'b00001111; select = 3'b011; #10;
		in = 8'b00001111; select = 3'b100; #10;
		in = 8'b00001111; select = 3'b101; #10;
		in = 8'b00001111; select = 3'b110; #10;
		in = 8'b00001111; select = 3'b111; #10;


	end
endmodule