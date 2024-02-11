/*******************************************************************************
* Author: Naziia Raitova 
* Date: 1/31/2024
*
* Module: Program Counter (PC) test benches
*
*******************************************************************************/

module PC_tb;
    // Inputs
    reg input_PCWrite;
    reg [15:0] input_newPC;
    reg CLK;
    reg input_zero;
    reg input_negative;
    reg [1:0] input_branchType;
    reg input_PC_isbranch;
    reg input_PC_set;

    // Outputs
    wire [15:0] output_PC;

    // Instantiate the UUT
    PC uut (
        .input_PCWrite(input_PCWrite),
        .input_newPC(input_newPC),
        .CLK(CLK),
        .input_zero(input_zero),
        .input_negative(input_negative),
        .input_branchType(input_branchType),
        .input_PC_isbranch(input_PC_isbranch),
        .input_PC_set(input_PC_set),
        .output_PC(output_PC)
    );
  
    // Clock generation
    always begin
        #5 CLK = ~CLK; // Toggle the clock every 5 time units
    end

    // Initialize Inputs
    initial begin
        // Test 1: PCWrite = 0, no branch or set, expected output_PC is incremented by 2
        input_PCWrite = 0;
        input_newPC = 16'h0000;
        input_zero = 0;
        input_negative = 0;
        input_branchType = 2'b00;
        input_PC_isbranch = 0;
        input_PC_set = 0;
        #10;
        if (output_PC !== 16'h0002)
            $display("Test Case 1 Failed. Expected: %h, Actual: %h", 16'h0002, output_PC);
        else
            $display("Test Case 1 Passed");

        // Test 2: PCWrite = 1, PC is set to newPC*2, expected output_PC is input_newPC*2
        input_PCWrite = 1;
        input_newPC = 16'h1234;
        input_zero = 0;
        input_negative = 0;
        input_branchType = 2'b00;
        input_PC_isbranch = 0;
        input_PC_set = 1;
        #10;
        if (output_PC !== 16'h2468)
            $display("Test Case 2 Failed. Expected: %h, Actual: %h", 16'h2468, output_PC);
        else
            $display("Test Case 2 Passed");

        // Test 3: PCWrite = 1, branch type is beq, ALU output is zero, expected output_PC is incremented by 2
        input_PCWrite = 1;
        input_newPC = 16'h0000;
        input_zero = 1;
        input_negative = 0;
        input_branchType = 2'b00;
        input_PC_isbranch = 1;
        input_PC_set = 0;
        #10;
        if (output_PC !== 16'h0002)
            $display("Test Case 3 Failed. Expected: %h, Actual: %h", 16'h0002, output_PC);
        else
            $display("Test Case 3 Passed");
        $stop;
    end
endmodule

 
