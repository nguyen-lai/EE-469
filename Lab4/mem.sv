module mem(clk, reset, EXMEM_ALUResult, EXMEM_RegB_content, EXMEM_MemWrite, EXMEM_read_enable, EXMEM_xfer_size, MEM_datafromMem);
	input logic clk, reset;
	input logic [63:0] EXMEM_ALUResult, EXMEM_RegB_content; 
	input logic EXMEM_MemWrite, EXMEM_read_enable;
	input logic [3:0] EXMEM_xfer_size;
	output logic [63:0] MEM_datafromMem;
	
	datamem theDataMem (.address(EXMEM_ALUResult), .write_enable(EXMEM_MemWrite), .read_enable(EXMEM_read_enable), .write_data(EXMEM_RegB_content), .clk
								, .xfer_size(EXMEM_xfer_size), .read_data(MEM_datafromMem));
								
	endmodule
	