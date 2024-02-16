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

    // Initialize clock
    initial begin
        CLK = 1'b0;
        forever #5 CLK = ~CLK; // Toggle clock every 5 time units
    end

    // Test cases
    initial begin
        // Test case 1: Write to register
        input_reg_readA_address = 3'b000;
        input_reg_readB_address = 3'b001;
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b010;
        input_imm = 16'h1234;
        input_branch = 1'b1;
        input_ALUOut = 16'hABCD;
        input_MDR = 16'h5678;
        memToReg = 1'b0;

        #10; // Wait some time for signals to stabilize

        // Check output
        if (output_imm !== 16'h1234 || output_reg_A !== 16'hABCD || output_reg_B !== 16'h5678) begin
            $display("Test case 1 failed! Output: output_imm=%h, output_reg_A=%h, output_reg_B=%h", output_imm, output_reg_A, output_reg_B);
        end else begin
            $display("Test case 1 passed!");
        end

        // Test case 2: Read from register
        input_reg_readA_address = 3'b100;
        input_reg_readB_address = 3'b101;
        input_reg_write = 1'b0;
        input_reg_write_address = 3'b110;
        input_imm = 16'h4321;
        input_branch = 1'b0;
        input_ALUOut = 16'h9876;
        input_MDR = 16'h5432;
        memToReg = 1'b1;

        #10; // Wait some time for signals to stabilize

        // Check output
        if (output_imm !== 16'h4321 || output_reg_A !== 16'h9876 || output_reg_B !== 16'h5432) begin
            $display("Test case 2 failed! Output: output_imm=%h, output_reg_A=%h, output_reg_B=%h", output_imm, output_reg_A, output_reg_B);
        end else begin
            $display("Test case 2 passed!");
        end

        // End simulation
        #100;
        $finish;
    end

endmodule
