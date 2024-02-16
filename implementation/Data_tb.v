/*******************************************************************************
* Author: Naziia Raitova and Luke Pearcy
* Date: 2/8/2024
*
* Module: Data tb
*
*
*******************************************************************************/

`timescale 1ns / 1ps

module Data_tb;

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
	 reg input_branch;

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
		  .input_branch(input_branch),
		  .output_imm(output_imm), 
		  .output_reg_A(output_reg_A), 
		  .output_reg_B(output_reg_B)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) CLK = ~CLK;
    
    // Initial stimulus
    initial begin
			CLK = 1'b1;
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
        input_imm = 16'b_0000_0000_0000_0_011;
        #CLK_PERIOD; // Wait for a few cycles

        // Test case 1: 3R-type
        input_branch = 1'b0;
        input_reg_readA_address = 3'b000;
        input_reg_readB_address = 3'b001;
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b010;
        input_ALUOut = 16'h1234;
        memToReg = 1'b0;

        #CLK_PERIOD; // Wait for a few cycles
        if (output_reg_A !== 16'h0001 || output_reg_B !== 16'h0005)
            $display("Test Case 1 For 3R-Type Failed Output: output_reg_A=%h, output_reg_B=%h", output_reg_A, output_reg_B);
				
				
        // Test case 2: 2RI Type
		  input_branch = 1'b1;
        input_reg_readA_address = 3'b010;
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b100;
        input_imm = 16'b010010000000001;
        input_ALUOut = 16'h9876;
        memToReg = 1'b0;
        
        #CLK_PERIOD; // Wait for a few cycles
        if (output_reg_A !== 16'h0001 || output_reg_B !== 16'h0010)
          $display("Test Case 2 For 2RI-type Failed Output: output_reg_A=%h, output_reg_B=%h", output_reg_A, output_reg_B);

        // Test case 3: UJ Type
		  input_branch = 1'b0;
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b100;
        input_imm = 16'b100_000001101_100;
        input_MDR = 16'h5432;
        memToReg = 1'b1;
        
        #CLK_PERIOD; // Wait for a few cycles
        if (output_imm !== 16'b0000000_000001101)
          $display("Test Case 3 For UJ-type Failed");

        // Test case 4: RI Type
		  input_branch = 1'b0;
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b100;
        input_imm = 16'h100_000001_0110_010;
        input_MDR = 16'h5432;
        memToReg = 1'b1;

        #CLK_PERIOD; // Wait for a few cycles
        if (output_imm !== 16'b0000000000_000001)
          $display("Test Case 4 For RI-type Failed Output: output_reg_A=%h, output_reg_B=%h", output_reg_A, output_imm);

        // Test case 5: L Type
		  input_branch = 1'b0;
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b100;
        input_imm = 16'b0000000000000_011;
        input_ALUOut = 16'h9876;
        memToReg = 1'b0;

        #CLK_PERIOD; // Wait for a few cycles
        if (output_imm !== 16'b0000_0000000000000)
          $display("Test Case 5 For L-type Failed");
               
                
        // End simulation
        $finish;
    end

endmodule
