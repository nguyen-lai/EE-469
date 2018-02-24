module instructDecode(clk, reset, ID_instruction, IFID_Rn, IFID_Rm, IFID_Rd, RegA_content, RegB_content, WriteData_fromWB, RegWrite_fromMEMWB, Reg2Loc, Imm12Extended, DAddr9Extended);
	input logic clk, reset;
	input logic [31:0] ID_instruction;
	input logic [63:0] WriteData_fromWB;
	input logic RegWrite_fromMEMWB, Reg2Loc;
	output logic [4:0] IFID_Rn, IFID_Rm, IFID_Rd;
	output logic [63:0] RegA_content, RegB_content;
	output logic [63:0] Imm12Extended;
	output logic [63:0] DAddr9Extended;
	
// Assign statements for readability
assign IFID_Rn = ID_instruction[9:5];
assign IFID_Rm = ID_instruction[20:16];
assign IFID_Rd = ID_instruction[4:0];

logic imm12[11:0];
assign imm12 = ID_instruction[21:10];

logic dAddr9[8:0];
assign dAddr9 = ID_instruction[20:12];

// Reg2Loc Mux
logic [4:0] Ab;
mux_5x2to1 RegToLocMux (.A(IFID_Rd), .B(IFID_Rm), .sel(Reg2Loc), .out(Ab));



// The register file
// Da, Db go to ID/EX Pipe for next stage 
// RegWrite received from MEM/WB pipe
// WriteData received from WB stage
regfile theRegisterFile (.ReadData1(RegA_content), .ReadData2(RegB_content), .WriteData(WriteData_fromWB), .ReadRegister1(IFID_Rn), .ReadRegister2(Ab), .RegWrite(RegWrite_fromMEMWB), .clk);


	//Zero extend for Imm12
	//Imm12Extended goes to ID/EX Pipe for next stage
	zeroExtend #(.WIDTH(12)) Imm12(.in(imm12), .out(Imm12Extended));

	//Sign extend for DAddr9
	// DAddr9Extended goes to ID/EX Pipe for next stage
	signExtend #(.WIDTH(9)) DAddr9(.in(dAddr9), .out(DAddr9Extended));
	
endmodule