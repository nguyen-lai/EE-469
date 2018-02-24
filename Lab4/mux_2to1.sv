/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is 2 to 1 multiplexer

Input: 2 bits, 1 select line
Output: 1 bit
	
******************************/
`timescale 1ns/10ps
module mux_2to1 (select, a, b, y);
	// Define inputs, outputs, constant and wires
	input logic a, b, select;
	output logic y;
	parameter DELAY = 0.05;
	
	logic a_Out, b_Out;
	
	// Perform multiplexing process
	and #DELAY AndGate1(a_Out, a, ~select);
	and #DELAY AndGate2(b_Out, b,  select);
	or  #DELAY OrGate  (y, a_Out, b_Out);
	
endmodule

module mux_2to1_testbench();
	logic a, b, select;
	logic y;
	
	mux_2to1 dut (.select, .a, .b, .y);
	
	initial begin
		select = 0; 
		
		a = 0; b = 0;
		#10;
		a = 0; b = 1;
		#10;
		a = 1; b = 0;
		#10;
		a = 1; b = 1;
		#10;
		
		select = 1;
		
		a = 0; b = 0;
		#10;
		a = 0; b = 1;
		#10;
		a = 1; b = 0;
		#10;
		a = 1; b = 1;
		#10;
		
	end
endmodule