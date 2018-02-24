/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is a register made of D-flipflop with Enable Line
	
******************************/
`timescale 1ns/10ps
module register_32 (d, q, en, reset, clk);
	// Define inputs, outputs and extra wires
	input logic  [31:0] d;
	input logic  en, reset, clk;
	output logic [31:0] q;
	
	logic [31:0] data;
	
	// Make register from D-flipflop with Enable
	genvar i;
	
	generate
		for(i=0; i<32; i++) begin: eachDff
			mux_2to1 TheMux (.select(en), .a(q[i]), .b(d[i]), .y(data[i])); // Only store new data if Enable is ON,
																								 // otherwise, keep old data
			D_FF theDFF (.q(q[i]), .d(data[i]), .clk, .reset);
		end
		
	endgenerate
	
endmodule