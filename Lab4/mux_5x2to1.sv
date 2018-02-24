module mux_5x2to1 (A, B, sel, out);
	input logic [4:0] A, B;
	input logic sel;
	output logic [4:0] out;
	
	genvar i;
	generate
	for (i = 0; i < 5; i++) begin: eachMux
			mux_2to1 theMuxes (.select(sel), .a(A[i]), .b(B[i]), .y(out[i]));
		end
	endgenerate
endmodule