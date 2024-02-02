/*******************************************************************************
* Author: Tulsi Manohar
* Date: 2/2/2024
*
* Module: Programmable Register File Testbench
*
* Description:
*   Testbench for the Programmable Register File module. This testbench will
*   simulate read and write operations to the register file.
*
*******************************************************************************/
`timescale 1ns / 1ps

module ProgrammableRegisterFile_tb;

    // Inputs
    reg [2:0] input_reg_readA_address;
    reg [2:0] input_reg_readB_address;
    reg input_reg_write;
    reg [15:0] input_reg_write_value;
    reg [2:0] input_reg_write_address;
    reg CLK;

    // Outputs
    wire [15:0] output_reg_A;
    wire [15:0] output_reg_B;

    // Instantiate the ProgrammableRegisterFile module
    ProgrammableRegisterFile uut (
        .input_reg_readA_address(input_reg_readA_address),
        .input_reg_readB_address(input_reg_readB_address),
        .input_reg_write(input_reg_write),
        .input_reg_write_value(input_reg_write_value),
        .input_reg_write_address(input_reg_write_address),
        .CLK(CLK),
        .output_reg_A(output_reg_A),
        .output_reg_B(output_reg_B)
    );

    // Clock generation
    always begin
        #5 CLK = ~CLK; // Toggle the clock every 5 time units
    end

    // Test procedure
    initial begin
        // Initialize Inputs
        CLK = 0;
        input_reg_write = 0;
        input_reg_readA_address = 0;
        input_reg_readB_address = 0;
        input_reg_write_value = 0;
        input_reg_write_address = 0;

        // Wait for global reset
        #100;

        // Test Case 1: Write and Read from the same register
        input_reg_write = 1;
        input_reg_write_value = 16'h1234;
        input_reg_write_address = 3'b001;
        #10;
        input_reg_write = 0;
        input_reg_readA_address = 3'b001;
        #10;
        if (output_reg_A !== 16'h1234) 
            $display("Test Case 1 Failed: output_reg_A should be 16'h1234");

        // Test Case 2: Write to one register and read from another
        input_reg_write = 1;
        input_reg_write_value = 16'hABCD;
        input_reg_write_address = 3'b010;
        input_reg_readB_address = 3'b001;
        #10;
        input_reg_write = 0;
        #10;
        if (output_reg_B !== 16'h1234) 
            $display("Test Case 2 Failed: output_reg_B should be 16'h1234");
        if (output_reg_A !== 16'h1234) 
            $display("Test Case 2 Failed: output_reg_A should be 16'h1234");

         $stop;
    end

endmodule
