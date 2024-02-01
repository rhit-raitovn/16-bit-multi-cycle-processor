/*******************************************************************************
* Author: Naziia Raitova
* Date: 1/31/2024
*
* Module: ALU (Arithmetic Logic Unit) test bench
*
*******************************************************************************/


`timescale 1ns / 1ps

module ALU_tb;

  // Inputs
  reg [15:0] input_A, input_B;
  reg [2:0] input_ALUOp;
  
  // Outputs
  wire [15:0] output_ALU;
  wire output_Zero, output_negative;

  // Instantiate the ALU module
  ALU uut (
    .input_A(input_A),
    .input_B(input_B),
    .input_ALUOp(input_ALUOp),
    .output_ALU(output_ALU),
    .output_Zero(output_Zero),
    .output_negative(output_negative)
  );

  // Test procedure
  initial begin
    // Test Case 1: Addition (ALUOp = 3'b000)
    input_ALUOp = 3'b000;
    input_A = 16'h1234;
    input_B = 16'h5678;
    #10;
    if (output_ALU !== (16'h1234 + 16'h5678) || output_Zero !== 0 || output_negative !== 0)
      $display("Test Case 1 Failed");

    // Test Case 2: Subtraction (ALUOp = 3'b001)
    input_ALUOp = 3'b001;
    input_A = 16'h5678;
    input_B = 16'h1234;
    #10;
    if (output_ALU !== (16'h5678 - 16'h1234) || output_Zero !== 0 || output_negative !== 0)
      $display("Test Case 2 Failed");

    // Test Case 3: AND Operation (ALUOp = 3'b100)
    input_ALUOp = 3'b100;
    input_A = 16'hAAAA;
    input_B = 16'h5555;
    #10;
    if (output_ALU !== (16'hAAAA & 16'h5555) || output_Zero !== 0 || output_negative !== 0)
      $display("Test Case 3 Failed");

    // Test Case 4: OR Operation (ALUOp = 3'b101)
    input_ALUOp = 3'b101;
    input_A = 16'hAAAA;
    input_B = 16'h5555;
    #10;
    if (output_ALU !== (16'hAAAA | 16'h5555) || output_Zero !== 0 || output_negative !== 0)
      $display("Test Case 4 Failed");

    // Test Case 5: XOR Operation (ALUOp = 3'b110)
    input_ALUOp = 3'b110;
    input_A = 16'hAAAA;
    input_B = 16'h5555;
    #10;
    if (output_ALU !== (16'hAAAA ^ 16'h5555) || output_Zero !== 0 || output_negative !== 0)
      $display("Test Case 5 Failed");

    $stop; 
  end

endmodule