`timescale 1ns/10ps
module mux_64x4to1(A, B, C, D, sel, out);
	input logic [63:0] A, B, C, D;
	input logic [1:0] sel;
	output logic [63:0] out;
	
	genvar i;
	generate 
		for (i = 0; i < 64; i++) begin: eachMux
			mux_4to1 theMuxes (.select(sel), .in({D[i], C[i], B[i], A[i]}), .out(out[i]));
		end
	endgenerate

endmodule

module mux_64x4to1_testbench();
	logic [63:0] A, B, C, D;
	logic [1:0] sel;
	logic [63:0] out;
	
	mux_64x4to1 dut(.A, .B, .C, .D, .sel, .out);
	
	initial begin
	A = 64'd50; B = 64'd29; C = 64'd99; D = 64'd77; sel = 2'd0; #10;
	sel = 2'd1; #10;
	sel = 2'd2; #10;
	sel = 2'd3; #10;
	end
endmodule