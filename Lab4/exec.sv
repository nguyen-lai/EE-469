`timescale 1ns/10ps
module exec(clk, reset, Da, Db, WB_MemToRegOut, EXMEM_ALUResult, ForwardA, ForwardB, ALUSrc, ALUOp, IDEX_PC, IDEX_UncondBrMuxOut, IDEX_DAddr9, IDEX_Imm12, overflowFlag, negativeFlag, carryoutFlag, zeroFlag
				, PCplusBranch, EX_ALUResult_out);
				
input logic clk, reset;
input logic [63:0] Da, Db;
input logic [63:0] WB_MemToRegOut;
input logic [63:0] EXMEM_ALUResult;
input logic ForwardA, ForwardB;
input logic [1:0] ALUSrc;
input logic [2:0] ALUOp;
input logic [63:0] IDEX_PC, IDEX_DAddr9, IDEX_Imm12;
input logic [63:0] IDEX_UncondBrMuxOut;
output logic overflowFlag, negativeFlag, carryoutFlag, zeroFlag;
output logic [63:0] PCplusBranch, EX_ALUResult_out;

//Forward A MUX
logic [63:0] ForwardAMux_Out;
mux_64x4to1 theForwardAMux (.A(Da), .B(WB_MemToRegOut), .C(EXMEM_ALUResult), .D(64'dx), .select(ForwardA), .out(ForwardAMux_Out));

//Forward B MUX
logic [63:0] ForwardBMux_Out;
mux_64x4to1 theForwardBMux (.A(Db), .B(WB_MemToRegOut), .C(EXMEM_ALUResult), .D(64'dx), .select(ForwardB), .out(ForwardBMux_Out));

//Check FordwardBMUX_out for zero for CBZ;
// This goes straight to EX/MEM Pipe
norGate_64input checkZero (.out(zeroFlag), .in(ForwardBMux_Out));

//ALUSrc MUX
logic [63:0] ALUSrcMux_Out;
mux_64x4to1 theALUSrcMux (.A(ForwardBMux_Out), .B(IDEX_DAddr9), .C(IDEX_Imm12), .D(64'dx), .select(ALUSrc), .out(ALUSrcMux_Out));

//Left shift UncondBrMuxOut << 2
logic [63:0] shifterOut;
shifter shifted (.value(IDEX_UncondBrMuxOut), .direction(1'b0), .distance(6'b000010), .result(shifterOut));

//PC + UncondBrMuxOut
addressAdder theAddressAdder (.A(IDEX_PC), .B(shifterOut), .sum(PCplusBranch));

//Set up ALU
logic zeroFromALU;
alu theALU (.A(ForwardAMux_Out), .B(ALUSrcMux_Out), .cntrl(ALUOp), .result(EX_ALUResult_out), .negative(negativeFlag), .zero(zeroFromALU), .overflow(overflowFlag), .carry_out(carryoutFlag));

endmodule