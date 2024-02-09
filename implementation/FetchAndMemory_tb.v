`timescale 1ns / 1ps

module FetchAndMemory_tb();
  
	input wire input_PC_PCWrite; // Flag indicating whether the PC will be updated.
   input wire [15:0] input_PC_newPC; // New value for the PC.
   input wire CLK; // Clock signal.
	
	output reg [15:0] output_PC; // Output representing the value of the PC.
	
	input wire input_IR_write;
	
	output reg [6:0] Output_IR_Control;
	output reg [3:0] Output_IR_RegA;
	output reg [3:0] Output_IR_RegB;
	output reg [3:0] Output_IR_RegD;
	output reg [15:0] Output_IR_Imm;
	
	input wire [15:0] input_from_ALUOut;
	output reg [15:0] output_MDR; // Output representing the value in the MDR register.
	
	input wire IorD;
	
	input wire input_mem_write;
	input wire input_mem_data;
	
	FetchAndMemory UUT(
		input_PC_PCWrite(input_PC_PCWrite), // Flag indicating whether the PC will be updated.
		input_PC_newPC(input_PC_newPC), // New value for the PC.
		CLK(CLK), // Clock signal.
		
		output_PC(output_PC), // Output representing the value of the PC.
		
		input_IR_write(input_IR_write),
		
		Output_IR_Control(Output_IR_Control),
		Output_IR_RegA(Output_IR_RegA),
		Output_IR_RegB(Output_IR_RegB),
		Output_IR_RegD(Output_IR_RegD),
		Output_IR_Imm(Output_IR_Imm),
		
		input_from_ALUOut(input_from_ALUOut),
		output_MDR(output_MDR), // Output representing the value in the MDR register.
		
		IorD(IorD),
		
		input_mem_write(input_mem_write),
		input_mem_data(input_mem_data)
	);
	
  always begin
    #5 CLK = ~CLK; // Toggle the clock every 5 time units
  end
  
  
  // Initial block
  initial begin
    // Test 1: fetch instruction: add x0, x1, x2
    input_PC_PCWrite = 0;
    input_PC_newPC = 8'hA5;
	 
    #10; 
    if (output_PC !== 16'h0000) $display("Test 1 failed!");

    

    $stop;
  end

endmodule