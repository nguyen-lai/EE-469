/*********************************************** 
Nguyen Lai
Winter 2018
CSE 469

This is 64 bit input NOR gate

************************************************/
`timescale 1ns/10ps

module norGate_64input(out, in);
	// Define inputs, outputs
	input logic [63:0] in;
	output logic out;
	parameter DELAY = 0.05;
	
	logic [15:0] intoAndGate;
	logic [3:0] intoResult;
	genvar i,j;
	generate 
	// Make 16 4-input NOR gates
	for (i = 0; i < 16; i++) begin: eachNorGate
		nor #DELAY theNorGate (intoAndGate[i], in[i*4], in[(i*4)+1], in[(i*4)+2], in[(i*4)+3]);
		end
	
   // Combine the 16 4-input NOR gates	
	for (j = 0; j < 4; j++) begin: eachAndGate
		and #DELAY theAndGate1 (intoResult[j], intoAndGate[j*4], intoAndGate[(j*4)+1], intoAndGate[(j*4)+2], intoAndGate[(j*4)+3]);
		end
	endgenerate
	
	// Compute final result
	and #DELAY theFinalAndGate (out, intoResult[0], intoResult[1], intoResult[2], intoResult[3]);
	
endmodule

module norGate_64input_testbench();
	logic [63:0] in;
	logic out;
	
	norGate_64input dut(out, in);
	
	initial begin
	in = 64'd5; #20;
	in = 64'd0; #20;
	in = 64'd99; #20;
	in = 64'd0; #20;
	end
	
endmodule
