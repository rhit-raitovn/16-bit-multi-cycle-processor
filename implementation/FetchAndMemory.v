module FetchAndMemory(
	//external
	input wire input_PC_PCWrite, // Flag indicating whether the PC will be updated.
   	input wire [15:0] input_PC_newPC, // New value for the PC.
   	input wire CLK, // Clock signal..input_zero(),                 // Signal indicating ALU output is zero.
    	input wire input_zero,
	input wire input_negative,             // Signal indicating ALU output is negative.
    	input wire [1:0] input_branchType,     // Branch type selector.
    	input wire input_PC_isbranch,          // Signal from control indicating if a branch comparison is being performed.	
	
	output wire [15:0] output_PC, // Output representing the value of the PC.
	
	input wire input_IR_write,
	
	output wire [6:0] Output_IR_Control,
	output wire [2:0] Output_IR_RegA,
	output wire [2:0] Output_IR_RegB,
	output wire [2:0] Output_IR_RegD,
	output wire [15:0] Output_IR_Imm,
	
	input wire [15:0] input_from_ALUOut,
	output wire [15:0] output_MDR, // Output representing the value in the MDR register.
	
	input wire IorD,
	
	input wire input_mem_write,
	input wire [15:0] input_mem_data
	
	
	
	//internal
	//output assign input_mem_addr = (IorD==0) ? output_PC : input_from_ALUOut,
	
	
);
wire [15:0] input_mem_addr;
wire [15:0] output_mem_data;
//PC
PC PC_inst(
	.input_PCWrite(input_PC_PCWrite),              // Flag indicating whether the PC will be updated.
    	.input_newPC(input_PC_newPC),         // New value for the PC.
   	.CLK(CLK),                        // Clock signal.
    	.input_zero(input_zero),                 // Signal indicating ALU output is zero.
    	.input_negative(input_negative),             // Signal indicating ALU output is negative.
    	.input_branchType(input_branchType),     // Branch type selector.
    	.input_PC_isbranch(input_PC_isBranch),          // Signal from control indicating if a branch comparison is being performed.
    	.output_PC(output_PC)            // Output representing the value of the PC.
);

//Instruction Register
InstructionRegister IR_inst(
    .input_IR_Instru(output_mem_data),				
    .input_IR_write(input_IR_write),
    .CLK(CLK),
    .Output_IR_Control(Output_IR_Control),
    .Output_IR_RegA(Output_IR_RegA),
    .Output_IR_RegB(Output_IR_RegB),
    .Output_IR_RegD(Output_IR_RegD),
    .Output_IR_Imm(Output_IR_Imm)
  );

//Memory
memory_component mem_int(
	.data(input_mem_data),
	.addr(input_mem_addr),
	.we(input_mem_write), 
	.clk(CLK),
	
	.q(output_mem_data)
);

//MDR
SimpleRegister MDR(
	.input_SR(output_mem_data), // Input that updates every cycle.
    	.CLK(CLK), // Clock signal.
	.output_SR(output_MDR) // Output representing the value in the register.
);

//IorD mux
mux2to1 IorDMux(
  	.a(output_PC),
  	.b(input_from_ALUOut),
  	.select(IorD),
  	.out(input_mem_addr)
);



endmodule
