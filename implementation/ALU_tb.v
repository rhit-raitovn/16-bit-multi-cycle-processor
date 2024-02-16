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
  reg [3:0] input_ALUOp;
  
  // Outputs
  wire [15:0] output_ALU;
  wire output_Zero, output_Negative;

  // Instantiate the ALU module
  ALU uut (
    .input_A(input_A),
    .input_B(input_B),
    .input_ALUOp(input_ALUOp),
    .output_ALU(output_ALU),
    .output_Zero(output_Zero),
    .output_Negative(output_Negative)
  );

  // Test procedure
  initial begin
    // Test Case 1: Addition (ALUOp = 3'b000)
    input_ALUOp = 4'b0000;
    input_A = 16'h1234;
    input_B = 16'h5678;
    #10;
    if (output_ALU !== (16'h68AC) || output_Zero !== 0 || output_Negative !== 0) begin
      $display("Test Case 1 Failed. Output ALU: %h", output_ALU);
    end else begin
      $display("Test Case 1 Passed");
    end

    // Test Case 2: Subtraction (ALUOp = 3'b001)
    input_ALUOp = 4'b0001;
    input_A = 16'h5678;
    input_B = 16'h1234;
    #10;
    if (output_ALU !== (16'h4444) || output_Zero !== 0 || output_Negative !== 0) begin
      $display("Test Case 2 Failed. Output ALU: %h", output_ALU);
    end else begin
      $display("Test Case 2 Passed");
    end

    // Test Case 3: AND Operation (ALUOp = 3'b100)
    input_ALUOp = 4'b0010;
    input_A = 16'hAAAA;
    input_B = 16'h5555;
    #10;
    if (output_ALU !== (16'h0000) || output_Zero !== 1 || output_Negative !== 0) begin
      $display("Test Case 3 Failed. Output ALU: %h", output_ALU);
    end else begin
      $display("Test Case 3 Passed");
    end

    // Test Case 4: OR Operation (ALUOp = 3'b101)
    input_ALUOp = 3'b0011;
    input_A = 16'hAAAA;
    input_B = 16'h5555;
    #10;
    if (output_ALU !== (16'hFFFF) || output_Zero !== 0 || output_Negative !== 1) begin
      $display("Test Case 4 Failed. Output ALU: %h", output_ALU);
    end else begin
      $display("Test Case 4 Passed");
    end

    // Test Case 5: XOR Operation (ALUOp = 3'b110)
    input_ALUOp = 4'b0100;
    input_A = 16'hAAAA;
    input_B = 16'h5555;
    #10;
    if (output_ALU !== (16'hFFFF) || output_Zero !== 0 || output_Negative !== 1) begin
      $display("Test Case 5 Failed. Output ALU: %h", output_ALU);
    end else begin
      $display("Test Case 5 Passed");
    end

    // Test Case 6: Invalid Operation (ALUOp = 4'b1111)
    input_ALUOp = 4'b1111;
    input_A = 16'h1234;
    input_B = 16'h5678;
    #10;
    if (output_ALU !== 16'hXXXX) begin
      $display("Test Case 6 Failed. Output ALU: %h", output_ALU);
    end else begin
      $display("Test Case 6 Passed (intentional exception should be above)");
    end

    $stop; 
  end
  
endmodule
