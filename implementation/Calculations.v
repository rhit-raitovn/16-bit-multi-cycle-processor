/*******************************************************************************
* Author: Naziia Raitova
* Date: 2/4/2024
*
* Module: Calculations
*
*
*******************************************************************************/


module Calculations(
    input wire [15:0] input_A, input_B, // ALU inputs
    input wire [3:0] input_ALUOp, // ALU operation code
    input wire [15:0] input_PC,
	input wire [2:0] input_ALUSrcA, 
	 input wire [1:0] input_ALUSrcB,
    input wire [0:0] input_PCSrc,
    input wire [15:0] input_imm,
    input wire input_keep_ALUOut,
	input wire [15:0] mdr,
	
    output wire [15:0] output_ALUOut_sr, // ALUOut_sr
    output reg [15:0] output_ALUMuxOut, // ALUMuxOut
    output wire output_Zero, output_negative, output_carry, // ALU flags
	output wire [15:0] output_B_sr,output_A_sr,
	 
    input wire clk, reset
);

wire [15:0] A_sr;
SimpleRegister A_inst (
	.CLK(clk),
			  
	.input_SR(input_A),			  
	.output_SR(output_A_sr)
);

SimpleRegister B_inst (
	.CLK(clk),
			  
	.input_SR(input_B),			  
	.output_SR(output_B_sr)
);

// 4:1 Mux for ALUSrcA
reg [15:0] A_mux_out;
always @(*) begin
	case(input_ALUSrcA)
		0: A_mux_out = input_PC;
		1: A_mux_out = 16'b0000_0000_0000_0001;
		2: A_mux_out = output_A_sr;
		3: A_mux_out = input_imm;
		4: A_mux_out = mdr;
      default: A_mux_out = 16'hxxxx; // Default to xxxx if an invalid selection
   endcase
end

// 3:1 Mux for ALUSrcB
reg [15:0] B_mux_out;
always @(*) begin
    case(input_ALUSrcB)
        0: B_mux_out = output_B_sr;
        1: B_mux_out = 16'b0000_0000_0000_0001; 
        2: B_mux_out = input_imm; 
        default: B_mux_out = B_mux_out; // Default to keeping value if an invalid selection
    endcase
end
	
wire [15:0] ALU_output_wire;
// Instantiate Counter module
ALU calculations_inst (			  
	.input_A(A_mux_out),
	.input_B(B_mux_out),
	.input_ALUOp(input_ALUOp),
			  
	.output_ALU(ALU_output_wire),
	.output_Zero(output_Zero),
	.output_Negative(output_negative),
	.output_Carry(output_carry)
);


reg [15:0] keepALUOut_mux;
// 2:1 mux for keepALUOut
always @(*) begin
    case(input_keep_ALUOut)
        0: keepALUOut_mux = ALU_output_wire;
        1: keepALUOut_mux = output_ALUOut_sr; 
        default: keepALUOut_mux = 16'hxxxx; // Default to xxxx if an invalid selection
    endcase
end

SimpleRegister ALUOut_inst (
    .CLK(clk),
    .input_SR(keepALUOut_mux),			  
    .output_SR(output_ALUOut_sr)
);

// 2:1 Mux for PCSrc
//reg [15:0] ALUOut_mux_out;
always @(*) begin
    case(input_PCSrc)
        0: output_ALUMuxOut = ALU_output_wire;
        1: output_ALUMuxOut = output_ALUOut_sr; 
        default: output_ALUMuxOut = 16'hxxxx; // Default to xxxx if an invalid selection
    endcase
end

endmodule
