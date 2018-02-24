/*************************************************
Nguyen Lai
1572743
Winter 2018
CSE 469
Lab 1

This is a 32 by 64 Register File
This register file is built from a
5to32 decoder, a 64x32 to 1 multiplexer,
32 registers 

Input: 
	- RegWrite: Write Enabler for the registers
	- Clk: the clock signal
	- writeRegister: the select lines to select 
						which register to write to
	- ReadRegister1, ReadRegister2: the select lines
				to select which register to read from
	- WriteData: Data writing to the registers

Output:
	- ReadData1, ReadData2: Data read from the chosen
				registers
	
*********************************************/
`timescale 1ns/10ps
module regfile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, clk);
	// Define inputs, outputs and extra wires
	input logic RegWrite, clk;
	input logic [4:0] WriteRegister, ReadRegister1, ReadRegister2;
	input logic [63:0] WriteData;
	output logic [63:0] ReadData1, ReadData2;
	
	logic [31:0] decoded;
	logic [31:0][63:0] regOut;
	
	// 5to32 decoder to find out which register to write to
	decoder_5to32 TheDecoder (.WriteRegister, .decoded(decoded[31:0]), .RegWrite); 
	
	assign regOut[31][63:0] = 64'b0; //Hardwire Reg31 to 0
	
	// Store data in the 32 registers
	genvar i;
	generate 
		
		for (i = 0; i < 31; i++)begin: inputToReg
			register TheRegisterI (.d(WriteData[63:0]), .q(regOut[i][63:0]), .en(decoded[i]), .reset(1'b0), .clk);
		end
	endgenerate

	
	// Output data to ReadData1
	mux_64x32to1 TheMux1 (.select(ReadRegister1[4:0]), .in(regOut), .out(ReadData1[63:0]));
	// Output data to ReadData2
	mux_64x32to1 TheMux2 (.select(ReadRegister2[4:0]), .in(regOut), .out(ReadData2[63:0]));

endmodule

// Test bench for Register file
module regstim(); 		

	parameter ClockDelay = 5000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	// Your register file MUST be named "regfile".
	// Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	regfile dut (.ReadData1, .ReadData2, .WriteData, 
					 .ReadRegister1, .ReadRegister2, .WriteRegister,
					 .RegWrite, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd0;
		ReadRegister2 <= 5'd0;
		WriteRegister <= 5'd31;
		WriteData <= 64'h00000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);

		// Write a value into each  register.
		$display("%t Writing pattern to all registers.", $time);
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000010204080001;
			@(posedge clk);
			
			RegWrite <= 1;
			@(posedge clk);
		end

		// Go back and verify that the registers
		// retained the data.
		$display("%t Checking pattern.", $time);
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
		end
		$stop;
	end
endmodule
