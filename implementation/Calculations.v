/*******************************************************************************
* Author: Naziia Raitova
* Date: 2/4/2024
*
* Module: Calculations
*
*
*******************************************************************************/


// Example: Main design using the Counter module
module Calculations(
    input wire [15:0] input_A, input_B, // ALU inputs
    input wire [2:0] input_ALUOp, // ALU operation code
    input wire [15:0] input_PC,
    input wire [1:0] input_ALUSrcA, input_ALUSrcB,
    input wire [0:0] input_PCSrc,
    input wire [15:0] input_imm,
	 
    output wire [15:0] output_ALU, // ALU output
    output wire output_Zero, output_negative, // ALU flags
	 
    input wire clk,
    input wire reset
);

wire [15:0] A_sr;
SimpleRegister A_inst (
	.CLK(clk),
			  
	.input_SR(input_A),			  
	.output_SR(A_sr)
);

wire [15:0] B_sr;
SimpleRegister B_inst (
	.CLK(clk),
			  
	.input_SR(input_B),			  
	.output_SR(B_sr)
);

// 3:1 Mux for ALUSrcA
reg [15:0] A_mux_out;
always @(*) begin
	case(input_ALUSrcA)
		0: A_mux_out = input_PC;
      1: A_mux_out = 16'b0000_0000_0000_0010;
      2: A_mux_out = A_sr;
      default: A_mux_out = 16'b0000_0000_0000_0000; // Default to zero if an invalid selection
   endcase
end

// 3:1 Mux for ALUSrcB
reg [15:0] B_mux_out;
always @(*) begin
    case(input_ALUSrcB)
        0: B_mux_out = B_sr;
        1: B_mux_out = 16'b0000_0000_0000_0010; // Assuming you have an immediate generator module
        2: B_mux_out = input_imm; // Assuming '2' is a 16-bit immediate value
        default: B_mux_out = 16'b0000_0000_0000_0000; // Default to zero if an invalid selection
    endcase
end

// Instantiate Counter module
ALU calculations_inst (			  
	.input_A(A_mux_out),
	.input_B(B_mux_out),
	.input_ALUOp(input_ALUOp),
			  
	.output_ALU(output_ALU),
	.output_Zero(output_Zero),
	.output_negative(output_negative)
);

wire [15:0] ALU_output_wire;
assign ALU_output_wire = output_ALU;

SimpleRegister ALUOut_inst (
    .CLK(clk),
    .input_SR(ALU_output_wire),			  
    .output_SR(ALUOut_sr)
);

// 2:1 Mux for PCSrc
reg [15:0] ALUOut_mux_out;
always @(*) begin
    case(input_PCSrc)
        0: ALUOut_mux_out = output_ALU;
        1: ALUOut_mux_out = ALUOut_sr; // Assuming you have an immediate generator module
        default: ALUOut_mux_out = 16'b0000_0000_0000_0000; // Default to zero if an invalid selection
    endcase
end

endmodule
