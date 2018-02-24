/****************************** 
Nguyen Lai
Winter 2018
CSE 469

This is a register made of D-flipflop with Enable Line
	
******************************/
`timescale 1ns/10ps
module register (d, q, en, reset, clk);
	// Define inputs, outputs and extra wires
	input logic  [63:0] d;
	input logic  en, reset, clk;
	output logic [63:0] q;
	
	logic [63:0] data;
	
	// Make register from D-flipflop with Enable
	genvar i;
	
	generate
		for(i=0; i<64; i++) begin: eachDff
			mux_2to1 TheMux (.select(en), .a(q[i]), .b(d[i]), .y(data[i])); // Only store new data if Enable is ON,
																								 // otherwise, keep old data
			D_FF theDFF (.q(q[i]), .d(data[i]), .clk, .reset);
		end
		
	endgenerate
	
endmodule


module register_testbench();
	logic [63:0] q, d;
	logic en, reset, clk;
	
	register dut (.d, .q, .en, .reset, .clk);
	
	parameter CLOCK_PERIOD = 100; 
	
		initial begin 
	
		clk <= 0;
	
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
 
		end
		
	initial begin
	
		reset <= 1;											@(posedge clk)	
		reset <= 0; en <= 1; d <= 64'd25;			@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)	
		en <= 0; d <= 64'd3;								@(posedge clk)	
																@(posedge clk)	
																@(posedge clk)	
													         @(posedge clk)	
		en <= 1; d <= 64'd5;								@(posedge clk)
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
	