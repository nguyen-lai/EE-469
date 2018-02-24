`timescale 1ns/10ps
module zeroExtend #(parameter WIDTH = 12) (in, out);
	input logic [WIDTH-1:0] in;
	output logic [63:0] out;
	int i;
	always_comb begin
		for(int i = 0; i < WIDTH; i++)
			out[i] = in[i];
		for(int i = WIDTH; i < 64; i++)
			out[i] = 0;
	end
endmodule

module zeroExtend_testbench();
	parameter WIDTH = 12;
	logic [WIDTH-1:0] in;
	logic [63:0] out;
	zeroExtend #(.WIDTH(WIDTH)) dut(.in, .out);
	initial begin
		in = 12'd3219; #100;
		in = 12'd999; #100;
		end
endmodule

