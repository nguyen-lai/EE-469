/*********************************************** 
Nguyen Lai
Winter 2018
CSE 469

This is 64-bit ALU unit
to perform arithmetic and logical operations

Input: 64 bit, 3 bit control line
Output: 64 bit based, set negative, zero, overflow and carryout flag based on 
		on the following operations:

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

	
************************************************/
`timescale 1ns/10ps

module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	output logic [63:0] result;
	output logic zero, overflow, carry_out, negative;
	
	parameter DELAY = 0.05;
	
	// Make a new 65 bit bus to store the 64 carryOuts from the Adders and carryIn 
	// for the LSB adder to determine whether or not substraction occurs
	logic [64:0] carryTemp; 
	assign carryTemp[0] = cntrl[0]; // If LSB of control is 0 -> addition
											  // If subtraction -> Add 1 to LSB Adder: (A + ~B + 1)
	// Make 64 1bit ALU 
	genvar i;
	generate 
		for (i = 0; i<64; i++) begin: eachALU
			alu1bit theALU (.a(A[i]), .b(B[i]), .carryIn(carryTemp[i]), .carryOut(carryTemp[i+1]), .control(cntrl[2:0]), .result(result[i]));
			end
		endgenerate
		
	// Set negative flag
	assign negative = result[63];
	
	// Set carryOut
	assign carry_out = carryTemp[64];
	
	// Set overflow flag
	xor theXorGate1 (overflow, carryTemp[64], carryTemp[63]); 
	
	// Set zero flag
	norGate_64input theNorGate (zero, result[63:0]);
	
endmodule

module alu_testbench();
	logic [63:0] A, B;
	logic [2:0] cntrl;
	logic [63:0] result;
	logic zero, overflow, carry_out, negative;
	
	alu dut(.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);
	
	initial begin
	A = 64'd50; B = 64'd25; cntrl = 3'b000; #1000;
									cntrl = 3'b010; #1000;
									cntrl = 3'b011; #1000;
									cntrl = 3'b100; #1000;
									cntrl = 3'b101; #1000;
									cntrl = 3'b110; #1000;
									
	A = 64'd40; B = 64'd95; cntrl = 3'b000; #1000;
									cntrl = 3'b010; #1000;
									cntrl = 3'b011; #1000;
									cntrl = 3'b100; #1000;
									cntrl = 3'b101; #1000;
									cntrl = 3'b110; #1000;
									
	A = 64'd40; B = 64'd0;  cntrl = 3'b000; #1000;
									cntrl = 3'b010; #1000;
									cntrl = 3'b011; #1000;
									cntrl = 3'b100; #1000;
									cntrl = 3'b101; #1000;
									cntrl = 3'b110; #1000;
	
	A = 64'd99; B = 64'd99; cntrl = 3'b000; #1000;
									cntrl = 3'b010; #1000;
									cntrl = 3'b011; #1000;
									cntrl = 3'b100; #1000;
									cntrl = 3'b101; #1000;
									cntrl = 3'b110; #1000;
	end
endmodule

// Test bench for ALU

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_A operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
	end
endmodule									