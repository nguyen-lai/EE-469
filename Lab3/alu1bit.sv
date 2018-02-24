/*********************************************** 
Nguyen Lai
Winter 2018
CSE 469

This is 1 bit ALU unit
to perform arithmetic and logical operation

Input: 1 bit, 3 bit control line
Output: 1 bit based on the following operation:

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

	
************************************************/
`timescale 1ns/10ps
module alu1bit(a, b, carryIn, carryOut, control, result);
	// Define input, outputs 
	input logic a, b, carryIn;
	input logic [2:0] control;
	output logic result;
	output logic carryOut;
	parameter DELAY = 0.05;
	
	logic [7:0] intoMux;
	logic sum, notB;
	logic intoAdder;
	
	// Perform Logical Operation
	and #DELAY theAndGate (intoMux[4], a, b);
	or  #DELAY theOrGate  (intoMux[5],  a, b);
	xor #DELAY theXorGate (intoMux[6], a, b);
	
	// Perform (a + b) or (a + ~b) 
	not #DELAY theInvertor (notB, b);
	mux_2to1 theMux1 (.select(control[0]), .a(b), .b(notB), .y(intoAdder));
	
	fulladder theAdder(.a, .b(intoAdder), .carryIn, .carryOut(carryOut), .sum(sum));
	
	// When control = 0, output b
	assign intoMux[0] = b;
	
	// Assign sum to intoMux[2] and intoMux[3]
	// intoMux[2] and intoMux[3] will have same result but we only care about one result so that doesn't matter
	assign intoMux[3] = sum;
	assign intoMux[2] = sum;
	
	// Select which results to output
	mux_8to1 theMux2 (.select(control[2:0]), .in(intoMux[7:0]), .out(result));
	
endmodule

module alu1bit_testbench();
	logic a, b, carryIn;
	logic [2:0] control;
	logic result;
	logic carryOut;
	
	alu1bit dut(.a, .b, .carryIn, .carryOut, .control, .result);
	
	initial begin
	a = 0; b = 0; carryIn = 0; control = 3'b000; #10;
										control = 3'b010; #10;
										control = 3'b011; #10;
										control = 3'b100; #10;
										control = 3'b101; #10;
										control = 3'b110; #10;
	
	a = 0; b = 1; carryIn = 0; control = 3'b000; #10;
										control = 3'b010; #10;
										control = 3'b011; #10;
										control = 3'b100; #10;
										control = 3'b101; #10;
										control = 3'b110; #10;
	
	a = 1; b = 0; carryIn = 0; control = 3'b000; #10;
										control = 3'b010; #10;
										control = 3'b011; #10;
										control = 3'b100; #10;
										control = 3'b101; #10;
										control = 3'b110; #10;
										
	
	a = 1; b = 1; carryIn = 0; control = 3'b000; #10;
										control = 3'b010; #10;
										control = 3'b011; #10;
										control = 3'b100; #10;
										control = 3'b101; #10;
										control = 3'b110; #10;
	end
endmodule

