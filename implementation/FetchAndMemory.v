module FetchAndMemory(
	//external
	input wire input_PC_PCWrite, // Flag indicating whether the PC will be updated.
   input wire [15:0] input_PC_newPC, // New value for the PC.
   input wire CLK, // Clock signal.
	
	output wire [15:0] output_PC, // Output representing the value of the PC.
	
	input wire input_IR_write,
	
	output wire [6:0] Output_IR_Control,
	output wire [3:0] Output_IR_RegA,
	output wire [3:0] Output_IR_RegB,
	output wire [3:0] Output_IR_RegD,
	output wire [15:0] Output_IR_Imm,
	
	input wire [15:0] input_from_ALUOut,
	output wire [15:0] output_MDR, // Output representing the value in the MDR register.
	
	input wire IorD,
	
	input wire input_mem_write,
	input wire [15:0] input_mem_data
	
	
	
	//internal
	//output assign input_mem_addr = (IorD==0) ? output_PC : input_from_ALUOut,
	
	
);
wire input_mem_add;
wire output_mem_data;
//PC
PC PC_inst(
	.CLK(CLK),
	.input_PC_PCWrite(input_PC_PCWrite),
	.input_PC_newPC(input_PC_newPC),
	.output_PC(output_PC)
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
MEMORY mem_int(
	 .input_mem_write(input_mem_write),
    .input_mem_addr(input_mem_addr),//mux output here
    .input_mem_data(input_mem_data),
    .CLK(CLK),
    .output_mem_data(output_mem_data)
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
