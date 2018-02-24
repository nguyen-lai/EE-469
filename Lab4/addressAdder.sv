`timescale 1ns/10ps
module addressAdder(A, B, sum);
	input logic [63:0] A, B;
	output logic [63:0] sum;
	logic [63:0] carryTemp;
	
	fulladder theLSBadder (.a(A[0]), .b(B[0]), .carryIn(1'b0), .carryOut(carryTemp[0]), .sum(sum[0])); // We don't need to care about substraction in address adding
	
	genvar i;
	generate 
		for (i = 1; i<64; i++) begin: eachAdder
			fulladder theOtherAdders (.a(A[i]), .b(B[i]), .carryIn(carryTemp[i-1]), .carryOut(carryTemp[i]), .sum(sum[i]));
			end
		endgenerate
endmodule
	
module addressAdder_testbench();
	logic [63:0] A, B;
	logic [63:0] sum;
	
	addressAdder dut(.A, .B, .sum);
	
	initial begin
	A = 64'd54213; B = 64'd42135; #10;
	A = 64'd32135123; B=64'd694730; #10;
	end
endmodule