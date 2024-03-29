/*********************************************** 
Nguyen Lai
Winter 2018
CSE 469

This is full adder to perform 1 bit addtion

Input:  a, b, carryIn
Output: sum and carryOut

	
************************************************/
`timescale 1ns/10ps

module fulladder (a, b, carryIn, carryOut, sum);
 // Define input, output
 input logic a, b, carryIn;
 output logic carryOut, sum;
 parameter DELAY = 0.05; 

 logic xorOut, andOut1, andOut2;
 
 // Perform addition from basic logic gates
	xor #DELAY theXorGate1 (xorOut, a, b);
	and #DELAY theAndGate1 (andOut1, a, b);
	and #DELAY theAndGate2 (andOut2, xorOut, carryIn);
	xor #DELAY theXorGate2 (sum, xorOut, carryIn);
	or  #DELAY theOrGate   (carryOut, andOut1, andOut2);
 
 endmodule
 
 module fulladder_testbench();
	logic a, b, carryIn;
	logic carryOut, sum;
	
	fulladder dut(.a, .b, .carryIn, .carryOut, .sum);
	
	initial begin
	a = 0; b = 0; carryIn = 0; #10;
					  carryIn = 1; #10;
			 b = 1; carryIn = 0; #10;
					  carryIn = 1; #10;
	a = 1; b = 0; carryIn = 0; #10;
					  carryIn = 1; #10;
			 b = 1; carryIn = 0; #10;
					  carryIn = 1; #10;
	end
	
endmodule