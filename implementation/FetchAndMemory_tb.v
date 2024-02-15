`timescale 1ns / 1ps

module FetchAndMemory_tb();

	parameter CLK_PERIOD = 10; // Clock period in ns
  
	reg input_PC_PCWrite; // Flag indicating whether the PC will be updated.
   	reg [15:0] input_PC_newPC; // New value for the PC.
   	reg CLK; // Clock signal.
	reg input_zero;
	reg input_negative;
	reg input_isBranch;
	reg [1:0] input_branchType;
	
	wire [15:0] output_PC; // Output representing the value of the PC.
	
	reg input_IR_write;
	
	wire [6:0] Output_IR_Control;
	wire [2:0] Output_IR_RegA;
	wire [2:0] Output_IR_RegB;
	wire [2:0] Output_IR_RegD;
	wire [15:0] Output_IR_Imm;
	
	reg [15:0] input_from_ALUOut;
	wire [15:0] output_MDR; // Output representing the value in the MDR register.
	
	reg IorD;
	
	reg input_mem_write;
	reg [15:0]input_mem_data;
	
	FetchAndMemory UUT(
		.input_PC_PCWrite(input_PC_PCWrite), // Flag indicating whether the PC will be updated.
		.input_PC_newPC(input_PC_newPC), // New value for the PC.
		.CLK(CLK), // Clock signal.
		.input_zero(input_zero),
		.input_negative(input_negative),             // Signal indicating ALU output is negative.
    		.input_branchType(input_branchType),     // Branch type selector.
    		.input_PC_isbranch(input_PC_isBranch),          // Signal from control indicating if a branch comparison is being performed.	

		.output_PC(output_PC), // Output representing the value of the PC.
		
		.input_IR_write(input_IR_write),
		
		.Output_IR_Control(Output_IR_Control),
		.Output_IR_RegA(Output_IR_RegA),
		.Output_IR_RegB(Output_IR_RegB),
		.Output_IR_RegD(Output_IR_RegD),
		.Output_IR_Imm(Output_IR_Imm),
		
		.input_from_ALUOut(input_from_ALUOut),
		.output_MDR(output_MDR), // Output representing the value in the MDR register.
		
		.IorD(IorD),
		
		.input_mem_write(input_mem_write),
		.input_mem_data(input_mem_data)
	);
  
  always begin
    #5 CLK = ~CLK; // Toggle the clock every 5 time units
  end
  
  
  // Initial block
  initial begin
    CLK=1;
    input_PC_newPC = 16'h0002;
    input_PC_PCWrite = 1;
    // Test 1: fetch instruction: 16'h 1234 and check outputs
    input_PC_PCWrite = 1;
    IorD=0;
    input_PC_newPC = 16'h0002;
    input_IR_write=1;
	 
    #CLK_PERIOD; 
    if (output_PC !== 16'h0002) $display("FAIL FetchAndMemory test 1.1: tried to fetch instruction 16'h1234 at hex address 2 but output_PC was: %h",output_PC);
    #CLK_PERIOD;
    if (Output_IR_Imm !== 16'h1234) $display("FAIL FetchAndMemory test 1.2: tried to fetch instruction 16'h1234 at hex address 2 but Output_IR_Imm (should be whole instruction) was instead: %h",Output_IR_Imm);
    //TODO add more IR output checks

    #(5*CLK_PERIOD);

    //Test 2: load from memory 16'hBEEF and get from MDR
    input_PC_PCWrite = 0;
    IorD=1;
    input_IR_write=0;
    input_from_ALUOut=16'h0001;
    #CLK_PERIOD;
    #CLK_PERIOD;
    #1  
    if (output_MDR !== 16'hBEEF) $display("FAIL FetchAndMemory test 2: tried to load memory 16'hBEEF at hex address 0001 but output_MDR was: %h",output_MDR);
    //if (Output_IR_Imm !== 16'h1234) $display("FAIL FetchAndMemory test 1.2: tried to fetch instruction 16'h1234 at hex address 2 but Output_IR_Imm (should be whole instruction) was instead: %h",Output_IR_Imm);
    #9 
    #CLK_PERIOD; 
    $stop;
  end

endmodule
