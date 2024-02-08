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
    
        // Test Scenario 2: ALU subtraction operation with immediate value
        input_A = 16'hABCD;
        input_B = 16'h5678;
        input_ALUOp = 3'b010; // ALU operation code for subtraction
        input_PC = 16'h1234;
        input_ALUSrcA = 2'b00; // ALUSrcA value (using A register)
        input_ALUSrcB = 2'b01; // ALUSrcB value (using immediate value)
        input_PCSrc = 1'b0; // PCSrc value
        input_imm = 16'h1111;
        #20; // Wait for 20 time units
    
        // Test Scenario 3: ALU bitwise AND operation
        input_A = 16'hFFFF;
        input_B = 16'h5555;
        input_ALUOp = 3'b011; // ALU operation code for bitwise AND
        input_PC = 16'h1234;
        input_ALUSrcA = 2'b01; // ALUSrcA value (using immediate value)
        input_ALUSrcB = 2'b00; // ALUSrcB value (using B register)
        input_PCSrc = 1'b0; // PCSrc value
        input_imm = 16'h0F0F;
        #20; // Wait for 20 time units
    
        // Add more test scenarios here if needed
    
        // End simulation
        #100;
        $finish;
    end

endmodule
