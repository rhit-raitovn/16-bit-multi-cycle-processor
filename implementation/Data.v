module Data(
    input wire [2:0] input_reg_readA_address, // 3-bit address for reading Operand A.
    input wire [2:0] input_reg_readB_address, // 3-bit address for reading Operand B.
	input wire input_reg_write, // Single-bit signal to enable write operation.
    input wire [2:0] input_reg_write_address, // 3-bit address for write operation.
	input wire CLK, // Single-bit clock signal for synchronization.
    
    input wire [15:0] input_imm, // 16-bit input of the instruction for the immediate to be parsed
    input wire output_MDR, //MDR output

input wire a[15:0],
  input wire b[15:0],
  input wire memToReg,
  
	
	output reg out[15:0]	
    
    output reg [15:0] output_imm // 16-bit output representing the immediate value generated by the Immediate Generator.
    output reg [15:0] output_reg_A, // 16-bit output representing data read from Register A.
    output reg [15:0] output_reg_B // 16-bit output representing data read from Register B.
  
);

    //mdr inst needs to come in

    ProgrammableRegisterFile register_inst (
	    
    .clk(clk),
	    .input_reg_readA_address(input_reg_readA_address),
	    .input_reg_readB_address(input_reg_readB_address),
	    .input_reg_write(input_reg_write),
	    .input_reg_write_value(input_reg_write_value),
	    .input_reg_write_address(input_reg_write_address),
	    .output_reg_A(output_reg_A),
	    .output_reg_B(output_reg_B)

   );


	ImmediateGenerator ig_inst(
	    .input_imm(input_imm),
	    .output_imm(output_imm)
	);
         
	wire [15:0] immOrOut;
	mux2to1 mux_inst(
		.a(a),
		.b(b),
		.select(select),
		.out(memToReg)		
	);

    
endmodule
