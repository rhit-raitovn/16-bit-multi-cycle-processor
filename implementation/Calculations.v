


// Example: Main design using the Counter module
module Calculations(

	 input wire [15:0] input_A, input_B, // ALU inputs
    input wire [2:0] input_ALUOp, // ALU operation code
	 input wire [15:0] input_PC,
	 input wire [0:0] input_ALUSrcA, input_ALUSrcB, input_ALUOp, 
	 
	 output wire [15:0] output_ALU, // ALU output
    output reg output_Zero, output_negative, // ALU flags
	 
    input wire clk,
    input wire reset
);

    // Instantiate Counter module
    ALU calculations_inst (
        .clk(clk),
        .reset(reset),
		  
        .input_A(input_A),
		  .input_B(input_B),
		  .input_ALUOp(input_ALUOp),
		  .input_ALUSrcA(input_ALUSrcA),
		  .input_ALUSrcB(input_ALUSrcB),
		  .input_ALUOp(input_ALUOp),
		  .input_PC(input_PC),
		  
		  .output_ALU(output_ALU),
		  .output_Zero(output_Zero),
		  .output_negative(output_negative)
    );
	 
assign
	 
always @(*)
begin
    case(input_ALUOp)
        
        default: // Invalid operation
            ;
    endcase
end


endmodule