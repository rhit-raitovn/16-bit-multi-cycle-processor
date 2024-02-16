/*******************************************************************************
* Author: Naziia Raitova and Luke Pearcy
* Date: 2/8/2024
*
* Edited, passed compiles: Tulsi Manohar
* date: 2/14/2024
* Module: Calculations
*
*
*******************************************************************************/

module Data_tb;

    // Timescale definition
    `timescale 1ns/1ps

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg [2:0] input_reg_readA_address;
    reg [2:0] input_reg_readB_address;
    reg input_reg_write;
    reg [2:0] input_reg_write_address;
    reg CLK;
    reg [15:0] input_imm;
    reg [15:0] input_ALUOut;
    reg [15:0] input_MDR;
    reg memToReg;

    wire [15:0] output_imm;
    wire [15:0] output_reg_A;
    wire [15:0] output_reg_B;
    
    // Instantiate the module under test
    Data dut (
        .input_reg_readA_address(input_reg_readA_address),
        .input_reg_readB_address(input_reg_readB_address),
        .input_reg_write(input_reg_write),
        .input_reg_write_address(input_reg_write_address),
        .CLK(CLK),
        .input_imm(input_imm),
        .input_ALUOut(input_ALUOut),
        .input_MDR(input_MDR),
        .memToReg(memToReg),
        .output_imm(output_imm),
        .output_reg_A(output_reg_A),
        .output_reg_B(output_reg_B)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) CLK = ~CLK;
    
    // Initial stimulus
    initial begin
        // Prepare for tests by setting r0, r1, and r2 registers to zero
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b000;
        input_MDR = 16'h0001;
        memToReg = 1'b1;
        #CLK_PERIOD; // Wait for a few cycles
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b001;
        input_MDR = 16'h0005;
        memToReg = 1'b1;
        #CLK_PERIOD; // Wait for a few cycles
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b010;
        input_MDR = 16'h0010;
        memToReg = 1'b1;
        #CLK_PERIOD; // Wait for a few cycles
        // Prepare for tests by setting UI register in immediate generator to 0
        input_imm = 16'b0000000000000011;
        #CLK_PERIOD; // Wait for a few cycles
      
        // Test case 1: 3R-type
input_reg_readA_address = 3'b000;
input_reg_readB_address = 3'b001;
input_reg_write = 1'b1;
input_reg_write_address = 3'b010;
input_ALUOut = 16'h1234;
memToReg = 1'b0;

#CLK_PERIOD; // Wait for a few cycles
if ((output_reg_A !== 16'h0001) || (output_reg_B !== 16'h0005))
    $display("Test Case 1 For 3R-Type Failed");

// Test case 2: 2RI Type
input_reg_readA_address = 3'b010;
input_reg_write = 1'b1;
input_reg_write_address = 3'b100;
input_imm = 16'b010010000000001;
input_ALUOut = 16'h9876;
memToReg = 1'b0;

#CLK_PERIOD; // Wait for a few cycles
if ((output_reg_A !== 16'h0001) || (output_imm !== 16'b0000000000000011))
    $display("Test Case 2 For 2RI-type Failed");

// Test case 3: UJ Type
input_reg_write = 1'b1;
input_reg_write_address = 3'b100;
input_imm = 16'b1000001101100;
input_MDR = 16'h5432;
memToReg = 1'b1;

#CLK_PERIOD; // Wait for a few cycles
if (output_imm !== 16'b0000000000000110)
    $display("Test Case 3 For UJ-type Failed");

// Test case 4: RI Type
input_reg_write = 1'b1;
input_reg_write_address = 3'b100;
input_imm = 16'b100000101100010;
input_MDR = 16'h5432;
memToReg = 1'b1;

#CLK_PERIOD; // Wait for a few cycles
if (output_imm !== 16'b0000000000000001)
    $display("Test Case 4 For RI-type Failed");

// Test case 5: L Type
input_reg_write = 1'b1;
input_reg_write_address = 3'b100;
input_imm = 16'b0000000000000011;
input_ALUOut = 16'h9876;
memToReg = 1'b0;

#CLK_PERIOD; // Wait for a few cycles
if (output_imm !== 16'b0000000000000000)
    $display("Test Case 5 For L-type Failed");

                
        // End simulation
        $stop;
    end

endmodule
