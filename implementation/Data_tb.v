/*******************************************************************************
* Author: tulsi
* Date: 
*
* Module: Data_tb
*
*******************************************************************************/

`timescale 1ns / 1ps // Define timescale for simulation

module Data_tb;

    // Inputs
    reg [2:0] input_reg_readA_address, input_reg_readB_address, input_reg_write_address;
    reg input_reg_write, CLK, input_branch, memToReg;
    reg [15:0] input_imm, input_ALUOut, input_MDR;

    // Outputs
    wire [15:0] output_imm, output_reg_A, output_reg_B;

    // Instantiate the module
    Data dut (
        .input_reg_readA_address(input_reg_readA_address),
        .input_reg_readB_address(input_reg_readB_address),
        .input_reg_write(input_reg_write),
        .input_reg_write_address(input_reg_write_address),
        .CLK(CLK),
        .input_imm(input_imm),
        .input_branch(input_branch),
        .input_ALUOut(input_ALUOut),
        .input_MDR(input_MDR),
        .memToReg(memToReg),
        .output_imm(output_imm),
        .output_reg_A(output_reg_A),
        .output_reg_B(output_reg_B)
    );
    parameter cycleLength = 10;
    // Initialize clock
    initial begin
        
        forever #(cycleLength/2) CLK = ~CLK; // Toggle clock every 5 time units
    end

    // Test cases
    initial begin
	CLK = 1'b0;
	//Test case 0:initialize some registers
	input_branch=1'b0;
	input_reg_write_address=3'b000;
	input_reg_write=1'b1;
	memToReg=1'b0;
	input_ALUOut=16'hABBA;
	#cycleLength;

	input_reg_write_address=3'b001;
	input_reg_write=1'b1;
	memToReg=1'b1;
	input_MDR=16'h0B01;
	#cycleLength;

	input_reg_write_address=3'b111;
	input_reg_write=1'b1;
	memToReg=1'b0;
	input_ALUOut=16'h5AD0;
	#cycleLength;
	
	//make sure registers initialized correctly
	input_reg_readA_address=3'b000;
	input_reg_readB_address=3'b001;
	input_reg_write=0'b0;
	#cycleLength;
	if (output_reg_A!==16'hABBA || output_reg_B!==16'h0B01)
            $display("Test case 0 failed! Output: output_imm=%h, output_reg_A=%h, output_reg_B=%h", output_imm, output_reg_A, output_reg_B);
	else
	    $display("Test case 0 passed!");

        // Test case 1: Write to register
        input_reg_readA_address = 3'b000;
        input_reg_readB_address = 3'b001;
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b010;
        input_imm = 16'b000_111111_0000_010; //increment with immediate 111111
        input_ALUOut = 16'h2024;
        memToReg = 0'b0;
        #cycleLength; // Wait some time for signals to stabilize

        // Check output
        if (output_imm !== 16'b1111111111111111) begin
            $display("Test case 1 failed! Output: output_imm=%h, output_reg_A=%h, output_reg_B=%h", output_imm, output_reg_A, output_reg_B);
        end else begin
            $display("Test case 1 passed!");
        end

        // Test case 2: Read from register we wrote to
        input_reg_readA_address = 3'b000;
        input_reg_readB_address = 3'b010;
        input_reg_write = 0'b0;
        input_reg_write_address = 3'b110;
        input_imm = 16'b000_1100110011_100;//jal with immediate 1100110011
        input_branch = 1'b0;
        input_ALUOut = 16'h9876;
        input_MDR = 16'h5432;
        memToReg = 1'b1;

        #cycleLength; // Wait some time for signals to stabilize

        // Check output
        if (output_imm !== 16'b1111111100110011 || output_reg_A !== 16'hABBA || output_reg_B !== 16'h2024) begin
            $display("Test case 2 failed! Output: output_imm=%b, output_reg_A=%h, output_reg_B=%h", output_imm, output_reg_A, output_reg_B);
        end else begin
            $display("Test case 2 passed!");
        end

        // End simulation
        #(cycleLength*2);
        $stop;
    end

endmodule
