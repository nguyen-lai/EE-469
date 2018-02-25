`timescale 1ns/10ps
module instructDecode(clk, reset, ID_instruction, IFID_Rn, IFID_Rm, IFID_Rd, RegA_content, RegB_content, WriteData_fromWB, RegWrite_fromMEMWB, Reg2Loc, Imm12Extended, DAddr9Extended
							, UncondMuxOut, UncondBr, MEMWB_Rd);
	input logic clk, reset;
	input logic [31:0] ID_instruction;
	input logic [63:0] WriteData_fromWB;
	input logic RegWrite_fromMEMWB, Reg2Loc, UncondBr;
	input logic [4:0] MEMWB_Rd;
	output logic [4:0] IFID_Rn, IFID_Rm, IFID_Rd;
	output logic [63:0] RegA_content, RegB_content;
	output logic [63:0] Imm12Extended;
	output logic [63:0] DAddr9Extended;
	output logic [63:0] UncondMuxOut;
	
// Assign statements for readability
assign IFID_Rn = ID_instruction[9:5];
assign IFID_Rm = ID_instruction[20:16];
assign IFID_Rd = ID_instruction[4:0];


logic [11:0]imm12;
assign imm12 = ID_instruction[21:10];

logic [8:0]dAddr9;
assign dAddr9 = ID_instruction[20:12];

logic [18:0]condAddr19;
assign condAddr19 = ID_instruction[23:5];

logic [25:0]brAddr26;
assign brAddr26 = ID_instruction[25:0];

// Reg2Loc Mux
logic [4:0] Ab;
mux_5x2to1 RegToLocMux (.A(IFID_Rd), .B(IFID_Rm), .sel(Reg2Loc), .out(Ab));



// The register file
// Da, Db go to ID/EX Pipe for next stage 
// RegWrite received from MEM/WB pipe
// WriteData received from WB stage
regfile theRegisterFile (.ReadData1(RegA_content), .ReadData2(RegB_content), 
.WriteData(WriteData_fromWB), .ReadRegister1(IFID_Rn), .ReadRegister2(Ab), .WriteRegister(MEMWB_Rd), .RegWrite(RegWrite_fromMEMWB), .clk);


	//Zero extend for Imm12
	//Imm12Extended goes to ID/EX Pipe for next stage
	zeroExtend #(.WIDTH(12)) Imm12(.in(imm12), .out(Imm12Extended));

	//Sign extend for DAddr9
	// DAddr9Extended goes to ID/EX Pipe for next stage
	signExtend #(.WIDTH(9)) DAddr9(.in(dAddr9), .out(DAddr9Extended));
	
// Sign Extend condAddr19 and brAddr26
logic [63:0] CondAddrExtended, BrAddrExtended;
signExtend #(.WIDTH(19)) condAddrExtend (.in(condAddr19), .out(CondAddrExtended));
signExtend  #(.WIDTH(26)) brAddrExtend (.in(brAddr26), .out(BrAddrExtended));

	// Put results after sign extension into 2:1 Mux with control signal UncondBr
	genvar i;
	generate 
		for (i = 0; i < 64; i++) begin: eachUncondMux
			mux_2to1 theMuxes1 (.select(UncondBr), .a(CondAddrExtended[i]), .b(BrAddrExtended[i]), .y(UncondMuxOut[i]));
		end
	endgenerate
	
endmodule

module instructDecode_testbench();
	logic clk, reset;
	logic [31:0] ID_instruction;
	logic [63:0] WriteData_fromWB;
	logic RegWrite_fromMEMWB, Reg2Loc, UncondBr;
	logic [4:0] IFID_Rn, IFID_Rm, IFID_Rd;
	logic [63:0] RegA_content, RegB_content;
	logic [63:0] Imm12Extended;
	logic [63:0] DAddr9Extended;
	logic [63:0] UncondMuxOut;
	logic [4:0] MEMWB_Rd;
	
instructDecode dut(.clk, .reset, .ID_instruction, .IFID_Rn, .IFID_Rm, .IFID_Rd, .RegA_content, .RegB_content, .WriteData_fromWB, .RegWrite_fromMEMWB, .Reg2Loc, .Imm12Extended, .DAddr9Extended
							, .UncondMuxOut, .UncondBr, .MEMWB_Rd);
							
parameter CLOCK_PERIOD= 10000;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	
		reset <= 1;																																	@(posedge clk)	
		reset <= 0; ID_instruction = 32'b1001000100_000000000000_11111_00000; RegWrite_fromMEMWB = 1'b0; WriteData_fromWB = 64'b0; Reg2Loc = 1'b0; UncondBr = 1'b0;
																																						@(posedge clk)	
																																						@(posedge clk)	
						ID_instruction = 32'b1001000100_000000000001_00000_00001;													@(posedge clk)	
																																						@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)	
						ID_instruction =	32'b000101_00000000000000000000000010; UncondBr = 1'b1;@(posedge clk)	
													         @(posedge clk)	
																@(posedge clk)
																@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)		
																@(posedge clk)	
																@(posedge clk)	
		reset <= 1;											@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)	
																$stop;
	end
endmodule