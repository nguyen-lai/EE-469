/****************************** 
Jake Robinson
Winter 2018
CSE 469

This is a register made of D-flipflop with Enable Line.
Default size: 32 bits. Adjust SIZE parameter accordingly.  
	
******************************/
`timescale 1ns/10ps 

module parameterized_register #(parameter SIZE=32) (d, q, en, reset, clk);
	// Define inputs, outputs and extra wires
	input logic  [SIZE - 1:0] d;
	input logic  en, reset, clk;
	output logic [SIZE - 1:0] q;
	
	logic [SIZE - 1:0] data;
	
	// Make register from D-flipflop with Enable
	genvar i;
	generate
		for(i=0; i<SIZE; i++) begin: eachDff
			mux_2to1 TheMux (.select(en), .a(q[i]), .b(d[i]), .y(data[i])); // Only store new data if Enable is ON,
																								 // otherwise, keep old data
			D_FF theDFF (.q(q[i]), .d(data[i]), .clk, .reset);
		end
	endgenerate
endmodule
