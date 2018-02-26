module forwardingUnit(IDEX_Rd, IDEX_Rm, IDEX_Rn, EXMEM_RegWrite, EXMEM_Rd, MEMWB_RegWrite, MEMWB_Rd, ForwardA, ForwardB);
	input logic [4:0] IDEX_Rd, IDEX_Rm, IDEX_Rn, EXMEM_Rd, MEMWB_Rd;
	input logic EXMEM_RegWrite, MEMWB_RegWrite;
	output logic [1:0] ForwardA, ForwardB;
	
	always_comb
		begin
		// Forward A EX Hazard
			if (EXMEM_RegWrite && (EXMEM_Rd != 5'd31) && (EXMEM_Rd == IDEX_Rn)) begin
				ForwardA = 2'b10;
				end
		// Forward A MEM Hazard
		//not(EX/MEM.RegWrite and (EX/MEM.RegisterRd ≠ 31) and (EX/MEM.RegisterRd ≠ ID/EX.RegisterRn1))
			else if (MEMWB_RegWrite && (MEMWB_Rd != 5'd31) && ~(EXMEM_RegWrite && (EXMEM_Rd != 5'd31) && (EXMEM_Rd != IDEX_Rn)) && (MEMWB_Rd == IDEX_Rn)) begin
				ForwardA = 2'b01;
				end
		// Else case
			else begin
				ForwardA = 2'b00;
				end
				
		// Forward B EX Hazard
			if (EXMEM_RegWrite && (EXMEM_Rd != 5'd31) && (EXMEM_Rd == IDEX_Rm)) begin
				ForwardB = 2'b10;
				end
		// Forward B MEM Hazrd
			else if (MEMWB_RegWrite && (MEMWB_Rd != 5'd31) && ~(EXMEM_RegWrite && (EXMEM_Rd != 5'd31) && (EXMEM_Rd != IDEX_Rm)) && (MEMWB_Rd == IDEX_Rm)) begin
				ForwardB = 2'b01;
				end		
		// Else case
			else begin
				ForwardB = 2'b00;
				end
			end
endmodule
				
	