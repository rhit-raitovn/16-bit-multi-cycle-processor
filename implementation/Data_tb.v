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

    output wire [15:0] output_imm;
    output wire [15:0] output_reg_A;
    output wire [15:0] output_reg_B;
    
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
        .memToReg(memToReg)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) CLK = ~CLK;
    
    // Initial stimulus
    initial begin
        //prepare for tests by setting r0,r1,and r2 registers to zero
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b000;
        input_MDR = 16'h0001;
        memToReg = 1'b1;
        #20; // Wait for a few cycles
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b001;
        input_MDR = 16'h0005;
        memToReg = 1'b1;
        #20; // Wait for a few cycles
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b010;
        input_MDR = 16'h0010;
        memToReg = 1'b1;
        #20; // Wait for a few cycles
        //prepare for tests by setting UI register in immediate generator to 0
        input_imm= 16'b 0000 0000 0000 0 011;
        #20; // Wait for a few cycles
      
        // Test case 1: 3R-type
        input_reg_readA_address = 3'b000;
        input_reg_readB_address = 3'b001;
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b010;
        input_ALUOut = 16'h1234;
        memToReg = 1'b0;
        
        #20; // Wait for a few cycles
      if (output_reg_A !== 16'h0001 || output_reg_B !== 16'h0005)
          $display("Test Case 1 For 3R-Type Failed");
        
        // Test case 2: 2RI Type
        input_reg_readA_address = 3'b010;
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b100;
        input_imm = 16'b010010000000001;
        input_ALUOut = 16'h9876;
        memToReg = 1'b0;
        
        #20; // Wait for a few cycles
        if (output_reg_A !== 16'h0001 || output_imm !== 16'b0000000000000011)
          $display("Test Case 2 For 2RI-type Failed");

        // Test case 3: UJ Type
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b100;
        input_imm = 16'100 000001101 100;
        input_MDR = 16'h5432;
        memToReg = 1'b1;
        
        #20; // Wait for a few cycles
        if (output_imm !== 16'b 0000000 000001101)
          $display("Test Case 3 For UJ-type Failed");

        // Test case 4: RI Type
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b100;
        input_imm = 16'100 000001 0110 010;
        input_MDR = 16'h5432;
        memToReg = 1'b1;

        #20; // Wait for a few cycles
        if (output_imm !== 16'b 0000000000 000001)
          $display("Test Case 4 For RI-type Failed");

        // Test case 5: L Type
        input_reg_write = 1'b1;
        input_reg_write_address = 3'b100;
        input_imm = 16'0000000000000 011;
        input_ALUOut = 16'h9876;
        memToReg = 1'b0;

        #20; // Wait for a few cycles
        if (output_imm !== 16'b 0000 0000000000000)
          $display("Test Case 5 For L-type Failed");
                
        // End simulation
        $finish;
    end

endmodule
    
    // Task to display outputs
    task display_outputs;
        begin
            #10; // Add delay for stability
            $display("Outputs:");
            $display("output_imm = %b", output_imm);
            $display("output_reg_A = %b", output_reg_A);
            $display("output_reg_B = %b", output_reg_B);
        end
    endtask
    
    // Call the task to display outputs at the end of simulation
    initial begin
        $finish; // Terminate simulation
    end
    
endmodule
