/*******************************************************************************
* Author: Tulsi Manohar
* Date: 2/2/2024
*
* Module: Simple Register Testbench
*
* Description:
*   Testbench for the Simple Register module. This testbench will apply various
*   inputs to the Simple Register and checks the outputs.
*
*******************************************************************************/
`timescale 1ns / 1ps

module SimpleRegister_tb;

    parameter CLK_PERIOD = 10; // Clock period in ns

    // Inputs
    reg [15:0] input_SR;
    reg CLK;

    // Output
    wire [15:0] output_SR;

    // Instantiate the SimpleRegister module
    SimpleRegister uut (
        .input_SR(input_SR),
        .CLK(CLK),
        .output_SR(output_SR)
    );

    // Clock generation
    always begin
        #5 CLK = ~CLK; // Toggle the clock every 5 time units
    end

    // Test procedure
    initial begin
        // Initialize inputs
        CLK = 0;
        input_SR = 0;

        // Test Case 1: Input value is 0
        #CLK_PERIOD; 
        input_SR = 16'h0000;
        #CLK_PERIOD;
        if (output_SR !== 16'h0000) 
            $display("Test Case 1 Failed: output_SR should be 16'h0000");

        // Test Case 2: Input value is a random value
        #CLK_PERIOD; 
        input_SR = 16'hABCD;
        #CLK_PERIOD;
        if (output_SR !== 16'hABCD)
            $display("Test Case 2 Failed: output_SR should be 16'hABCD");

        // Test Case 3: Input value changes multiple times
        #CLK_PERIOD;
        input_SR = 16'h1234;
        #CLK_PERIOD;
        input_SR = 16'h5678;
        #CLK_PERIOD;
        if (output_SR !== 16'h5678)
            $display("Test Case 3 Failed: output_SR should be 16'h5678");

        $stop;
    end

endmodule
