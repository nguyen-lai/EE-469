module writeback(clk, reset, WB_datafromMem, WB_ALUResult, WB_MemToReg, WB_MemToReg_out);
	input logic clk, reset;
	input logic [63:0] WB_datafromMem, WB_ALUResult;
	input logic WB_MemToReg;
	output logic [63:0] WB_MemToReg_out;
	
	mux_64x2to1 theMemToRegMux (.A(WB_ALUResult), .B(WB_datafromMem), .sel(WB_MemToReg), .out(WB_MemToReg_out));
	
	endmodule