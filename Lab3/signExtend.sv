`timescale 1ns/10ps
module signExtend #(parameter WIDTH = 9) (in, out);
	input logic [WIDTH-1:0] in;
	output logic [63:0] out;
	assign out = {{(64-WIDTH){in[WIDTH-1]}}, in[WIDTH-1:0]};
endmodule

module signExtend_testbench();
	logic [8:0] in;
	logic [63:0] out;
	
	signExtend dut(.in, .out);
	
	initial begin
	in = 9'b110111101; #10;
	in = 9'b000011010; #10;
	end
	
endmodule
	
	
	