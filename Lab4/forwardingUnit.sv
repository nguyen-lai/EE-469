module forwardingUnit(IDEX_Rd, IDEX_Rm, IDEX_Rn, EXMEM_RegWrite, EXMEM_Rd, MEMWB_RegWrite, MEMWB_Rd, ForwardA, ForwardB);
	input logic [4:0] IDEX_Rd, IDEX_Rm, IDEX_Rn, EXMEM_Rd, MEMWB_Rd;
	input logic EXMEM_RegWrite; MEMWB_RegWrite;
	output logic [1:0] ForwardA, ForwardB;
	
	