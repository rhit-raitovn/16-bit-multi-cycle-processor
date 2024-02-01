/*******************************************************************************
* Author: Naziia Raitova 
* Date: 1/31/2024
*
* Module: Program Counter (PC) test benches
*
*******************************************************************************/

`timescale 1ns / 1ps

module PC_tb();

// Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg input_PC_PCWrite;
  reg [15:0] input_PC_newPC;
  reg CLK;

  // Outputs
  wire [15:0] output_PC;
  
// Instantiate the UUT
  PC uut(
    .input_PC_PCWrite(input_PC_PCWrite),
    .input_PC_newPC(input_PC_newPC),
    .CLK(CLK),
    .output_PC(output_PC)
  );
  
  // Clock generation
  always begin
    #5 CLK = ~CLK; // Toggle the clock every 5 time units
  end
	
	
// Initialize Inputs

// Initial block
  initial begin
    // Test 1: PCWrite = 0, PC should not change
    input_PC_PCWrite = 0;
    input_PC_newPC = 8'hA5;
	 
    #10; 
    if (output_PC !== 16'h0000) $display("Test 1 failed!");

    // Test 2: PCWrite = 1, PC should be updated
    input_PC_PCWrite = 1;
    input_PC_newPC = 16'h1234;
    #10; 
    if (output_PC !== 16'h1234) $display("Test 2 failed!");

    // Test 3: PCWrite = 1, PC should be updated
    input_PC_PCWrite = 1;
    input_PC_newPC = 16'h5678;
    #10; 
    if (output_PC !== 16'h5678) $display("Test 3 failed!");

    $stop;
  end

endmodule




 