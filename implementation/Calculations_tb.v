/*******************************************************************************
* Author: Naziia Raitova
* Date: 2/4/2024
*
* Module: Calculations
*
*
*******************************************************************************/

`timescale 1ns / 1ps

module Calculations_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg [15:0] input_A, input_B, input_PC, input_imm;
    reg [2:0] input_ALUOp;
    reg [1:0] input_ALUSrcA, input_ALUSrcB;
    reg [0:0] input_PCSrc;
    reg clk, reset;

    wire [15:0] output_ALU;
    wire output_Zero, output_negative;

    // Instantiate the Unit Under Test (UUT)
    Calculations uut (
        .input_A(input_A),
        .input_B(input_B),
        .input_ALUOp(input_ALUOp),
        .input_PC(input_PC),
        .input_ALUSrcA(input_ALUSrcA),
        .input_ALUSrcB(input_ALUSrcB),
        .input_PCSrc(input_PCSrc),
        .input_imm(input_imm),
        .output_ALU(output_ALU),
        .output_Zero(output_Zero),
        .output_negative(output_negative),
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #CLK_PERIOD clk = ~clk;

    // Initial stimulus
    initial begin
        clk = 0;
        reset = 0;
    
        // Test Scenario 1: ALU addition operation
        input_A = 16'h1234;
        input_B = 16'h5678;
        input_ALUOp = 3'b001; // ALU operation code for addition
        input_PC = 16'hABCD;
        input_ALUSrcA = 2'b10; // ALUSrcA value
        input_ALUSrcB = 2'b00; // ALUSrcB value (using B register)
        input_PCSrc = 1'b0; // PCSrc value
        input_imm = 16'h4321;
        #20; // Wait for 20 time units

        if (output_ALU !== (16'h1234 + 16'h5678) || output_Zero !== 0 || output_negative !== 0)
            $display("Test Case 1 ALU addition operation Failed");
    
        // Test Scenario 2: A - IMM
        input_A = 16'hABCD;
        input_B = 16'h5678;
        input_ALUOp = 3'b010; // ALU operation code for subtraction
        input_PC = 16'h1234;
        input_ALUSrcA = 2'b10; // ALUSrcA value (using A register)
        input_ALUSrcB = 2'b10; // ALUSrcB value (using immediate value)
        input_PCSrc = 1'b0; // PCSrc value
        input_imm = 16'h1111;
        #20; // Wait for 20 time units

        if (output_ALU !== (16'hABCD - 16'h1111) || output_Zero !== 0 || output_negative !== 0)
            $display("Test Case 2 (A - IMM) operation Failed");
    
        // Test Scenario 3: PC + 2
        input_A = 16'hFFFF;
        input_B = 16'h5555;
        input_ALUOp = 3'b011; // ALU operation code for bitwise AND
        input_PC = 16'h1234;
        input_ALUSrcA = 2'b00; 
        input_ALUSrcB = 2'b01;
        input_PCSrc = 1'b1; // PCSrc value
        input_imm = 16'h0F0F;
        #20; // Wait for 20 time units

        if (output_ALU !== (16'hFFFF + 16'h0002) || output_Zero !== 0 || output_negative !== 0)
            $display("Test Case 3: PC + 2 operation Failed");

        // Test Scenario 3: zero is true
        input_A = 16'h5555;
        input_B = 16'h5555;
        input_ALUOp = 3'b010; // ALU operation code for bitwise AND
        input_PC = 16'h1234;
        input_ALUSrcA = 2'b10; 
        input_ALUSrcB = 2'b00;
        input_PCSrc = 1'b1; // PCSrc value
        input_imm = 16'h0F0F;
        #20; // Wait for 20 time units

        if (output_ALU !== (16'h5555 - 16'h5555) || output_Zero === 0 || output_negative !== 0)
            $display("Test Case 3: zero is true operation Failed");

        // Test Scenario 3: output_negative is true
        input_A = 16'h5555;
        input_B = 16'h5585;
        input_ALUOp = 3'b010; // ALU operation code for bitwise AND
        input_PC = 16'h1234;
        input_ALUSrcA = 2'b10; 
        input_ALUSrcB = 2'b00;
        input_PCSrc = 1'b1; // PCSrc value
        input_imm = 16'h0F0F;
        #20; // Wait for 20 time units

        if (output_ALU !== (16'h5555 - 16'h5585) || output_Zero !== 0 || output_negative === 0)
            $display("Test Case 3: output_negative is true operation Failed");
    
    
        // End simulation
        #100;
        $finish;
    end

endmodule
