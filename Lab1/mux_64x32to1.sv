/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is 64x32 to 1 multiplexer
made of 64 [32:1 MUX]

Input: Array of 32x64 bits, 5 select lines
Output: 64 bits
	
******************************/
`timescale 1ns/10ps
module mux_64x32to1 (select, in, out);
	// Define inputs, outputs and wires
	input logic [31:0][63:0] in ;
	input logic [4:0] select;
	output logic [63:0] out;
	
	//Traversing 32x64 output from the registers to 64x32 so that they can be input to the Big Mux
	logic [63:0][31:0] traversedInput;
	int j,k;
	always_comb begin
		for (j = 0; j < 32; j++)
			for (k = 0; k < 64; k++)
				traversedInput[k][j] = in[j][k];
	end
	//End traversing	
	
	//Make a big multiplexer from 64 of [32:1 MUX]
	genvar i;
	generate

		for(i = 0; i < 64; i++)begin : eachBit
			mux_32to1 TheMux (.select(select), .in(traversedInput[i][31:0]), .out(out[i]));
		end
	endgenerate
endmodule
			
module mux_64x32to1_testbench();	
	logic [31:0][63:0] in;
	logic [4:0] select;
	logic [63:0] out;
	
	mux_64x32to1 dut(.select, .in, .out);
	
	initial begin
		int i, j;
		for (i = 0; i < 32;i++)
			begin
			in[i][63:0] = 64'd155 + i;
			end
		for (j = 0; j < 32; j++)
			begin
			select = j;
			#10;
			end
	end
endmodule