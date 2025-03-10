/*******************************************************************************
* Author: Naziia Raitova
* Date: 2/4/2024
*
* Module: Calculations
*
*
*******************************************************************************/

`timescale 1ns / 1ps // Define timescale for simulation

module Calculations_tb();

    reg clk, reset;
    reg [15:0] input_A, input_B, input_PC, input_imm;
    reg [3:0] input_ALUOp;
    reg [1:0] input_ALUSrcA;
	 reg [1:0] input_ALUSrcB;
    reg [0:0] input_PCSrc;
    wire [15:0] output_ALUOut_sr;
	 wire [15:0] output_ALUMuxOut;
    wire output_Zero, output_negative, output_carry;
    wire [15:0] output_B_sr;

    // Instantiate the DUT
    Calculations dut (
        .input_A(input_A),
        .input_B(input_B),
        .input_ALUOp(input_ALUOp),
        .input_PC(input_PC),
        .input_ALUSrcA(input_ALUSrcA),
        .input_ALUSrcB(input_ALUSrcB),
        .input_PCSrc(input_PCSrc),
        .input_imm(input_imm),
        .output_ALUOut_sr(output_ALUOut_sr),
        .output_ALUMuxOut(output_ALUMuxOut), // Connect this port accordingly
        .output_Zero(output_Zero),
        .output_negative(output_negative),
        .output_carry(output_carry),
        .output_B_sr(output_B_sr),
        .clk(clk),
        .reset(reset)
    );

    // Initialize clock
    initial begin
        forever #((10)/2) clk = ~clk; // Toggle clock every half period
    end

    // Test cases
    initial begin
        // Test case 0
		  clk = 1'b0;
        	  input_A = 16'h0001; // Input A = 1
		  input_B = 16'h0002; // Input B = 2
		  input_ALUOp = 4'b0000; // Example ALU operation code
		  input_PC = 16'b0000_0000_0000_0011; // Example PC value
		  input_ALUSrcA = 2'b10; // Select A_sr
		  input_ALUSrcB = 2'b00; // Select B_sr
		  input_PCSrc = 1'b0; // Select output_ALU
		  input_imm = 16'b0000_0000_0000_0100; // Example immediate value
		  reset = 1'b0; // Deassert reset
		  
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize

        // Check output
        if (output_ALUMuxOut !== 16'h0003 || output_Zero !== 1'b0 || output_negative !== 1'b0) begin
            $display("Test case 0 failed! Output: output_ALU=%h, output_Zero=%b, output_negative=%b", output_ALUMuxOut, output_Zero, output_negative);
        end else begin
            $display("Test case 0 passed!");
        end
    
        // Test Scenario 1: ALU addition operation
        input_A = 16'h1234;
        input_B = 16'h5678;
        input_ALUOp = 4'b0000; // ALU operation code for addition
        input_PC = 16'hABCD;
        input_ALUSrcA = 2'b10; // ALUSrcA value
        input_ALUSrcB = 2'b00; // ALUSrcB value (using B register)
        input_PCSrc = 1'b0; // PCSrc value
        input_imm = 16'h4321;
        reset = 1'b0; // Deassert reset
		  
		  #10; // Wait some time for signals to stabilize
		 
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize

        if (output_ALUMuxOut !== (16'h68AC) || output_Zero !== 0 || output_negative !== 0) begin
				$display("Test Case 1 ALU addition operation Failed! Output: output_ALU=%h, output_Zero=%b, output_negative=%b", output_ALUMuxOut, output_Zero, output_negative);
		  end else begin
            $display("Test case 1 passed!");
        end
				
				
        // Test Scenario 2: A - IMM
        input_A = 16'h0BCD;
        input_B = 16'h5678;
        input_ALUOp = 4'b0001; // ALU operation code for subtraction
        input_PC = 16'h1334;
        input_ALUSrcA = 2'b10; // ALUSrcA value (using A register)
        input_ALUSrcB = 2'b10; // ALUSrcB value (using immediate value)
        input_PCSrc = 1'b0; // PCSrc value
        input_imm = 16'h0111;
        reset = 1'b0; // Deassert reset
		  
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize
		
		  #10; // Wait some time for signals to stabilize

        if (output_ALUMuxOut !== (16'h0ABC) || output_Zero !== 0 || output_negative !== 0) begin
				$display("Test Case 2 (A - IMM) operation Failed! Output: output_ALU=%h, output_Zero=%b, output_negative=%b", output_ALUMuxOut, output_Zero, output_negative);
		  end else begin
            $display("Test case 2 passed!");
        end
				
				
        // Test Scenario 3: PC + 2
        input_A = 16'h00FF;
        input_B = 16'h5555;
        input_ALUOp = 4'b0000; 
        input_PC = 16'h1234;
        input_ALUSrcA = 2'b00; 
        input_ALUSrcB = 2'b01;
        input_PCSrc = 1'b0; // PCSrc value
        reset = 1'b0; // Deassert reset
		  
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize

        if (output_ALUMuxOut !== (16'h1236) || output_Zero !== 0 || output_negative !== 0) begin
				$display("Test Case 3: PC + 2 operation Failed! Output: output_ALU=%h, output_Zero=%b, output_negative=%b", output_ALUMuxOut, output_Zero, output_negative);
		  end else begin
            $display("Test case 3 passed!");
        end
				

        // Test Scenario 4: zero is true
        input_A = 16'h5555;
        input_B = 16'h5555;
        input_ALUOp = 4'b0001; // ALU operation code for subtraction
        input_PC = 16'h1234;
        input_ALUSrcA = 2'b10; 
        input_ALUSrcB = 2'b00;
        input_PCSrc = 1'b0; // PCSrc value
        input_imm = 16'h0F0F;
        //reset = 1'b0; // Deassert reset
		  
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize

        if (output_ALUMuxOut !== (16'h0000) || output_Zero !== 1 || output_negative !== 0) begin
				$display("Test Case 4: zero is true operation Failed! Output: output_ALU=%h, output_Zero=%b, output_negative=%b", output_ALUMuxOut, output_Zero, output_negative);
		  end else begin
            $display("Test case 4 passed!");
        end

        // Test Scenario 5: output_negative is true
        input_A = 16'h5555;
        input_B = 16'h5585;
        input_ALUOp = 4'b0001; // ALU operation code for subtraction
        input_PC = 16'h1234;
        input_ALUSrcA = 2'b10; 
        input_ALUSrcB = 2'b00;
        input_PCSrc = 1'b0; // PCSrc value
        input_imm = 16'h0F0F;
        //reset = 1'b0; // Deassert reset
		  
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize
		  
		  #10; // Wait some time for signals to stabilize

        if (output_ALUMuxOut !== (16'h5555 - 16'h5585) || output_Zero !== 0 || output_negative !== 1) begin
				$display("Test Case 5: output_negative is true operation Failed! Output: output_ALU=%h, output_Zero=%b, output_negative=%b", output_ALUMuxOut, output_Zero, output_negative);
		  end else begin
            $display("Test case 5 passed!");
        end
    
    
        // End simulation
        #100;
        $stop;
    end

endmodule
