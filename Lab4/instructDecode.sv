module instructDecode(clk, reset, ID_instruction, IFID_Rn, IFID_Rm, IFID_Rd, RegA_content, RegB_content);
	input logic clk, reset;
	input logic [31:0] ID_instruction;
	output logic [4:0] IFID_Rn, IFID_Rm, IFID_Rd;
	output logic [63:0] RegA_content, RegB_content;
	
	