/*******************************************************************************
* Author: Yueqiao Wang
* Date: 2/14/2024
*
* Module: ALU (Arithmetic Logic Unit)
*
* Description: This module implements an Arithmetic Logic Unit (ALU) capable of performing
* various arithmetic and logical operations based on the provided operation code.
*
* Inputs:
*   - input_A: 16-bit input operand A
*   - input_B: 16-bit input operand B
*   - input_ALUOp: 4-bit operation code specifying the operation to be performed
*
* Outputs:
*   - output_ALU: 2-bit output representing the result of the ALU operation
*   - output_Zero: Output indicating if the result of the ALU operation is zero
*   - output_Negative: Output indicating if the result of the ALU operation is negative
*   - output_Carry: Output indicating if there's a carry out during arithmetic operations
*
* Internal Signals:
*   - output: 17-bit internal signal used for computation of ALU operations
*
* Operations:
*   - Addition (add)
*   - Subtraction (subtract)
*   - Bitwise AND (and)
*   - Bitwise OR (or)
*   - Bitwise XOR (xor)
*   - Logical left shift (shift left logical)
*   - Logical right shift (shift right logical)
*   - Arithmetic left shift (shift left arithmetic)
*   - Arithmetic right shift (shift right arithmetic)
*   - 2* Operation (twice the sum of input operands)
*
* Implementation Details:
*   - The module uses a case statement to select the appropriate operation based on the input_ALUOp.
*   - Internal signal 'output' is used for intermediate computation of ALU operations.
*   - Zero, Negative, and Carry flags are generated based on the result of the ALU operation.
*******************************************************************************/


module ALU(
    input wire [15:0] input_A, input_B, // ALU inputs
    input wire [3:0] input_ALUOp, // ALU operation code
    output reg [15:0] output_ALU, // ALU output
    output reg output_Zero, output_Negative, output_Carry // ALU flags
);

reg [16:0] alu_output;

// ALUOp Calculation
always @ (*) begin
    case(input_ALUOp)
        4'b0000: begin // add
            {output_Carry, alu_output} = {1'b0, input_A} + {1'b0, input_B};
        end
        4'b0001: begin // subtract
            {output_Carry, alu_output} = {1'b0, input_A} - {1'b0, input_B};
        end
        4'b0010: alu_output = input_A & input_B; // and
        4'b0011: alu_output = input_A | input_B; // or
        4'b0100: alu_output = input_A ^ input_B; // xor
        4'b0101: alu_output = input_A << input_B[3:0]; // shift left logical
        4'b0110: alu_output = input_A >> input_B[3:0]; // shift right logical
        4'b0111: alu_output = input_A <<< input_B[3:0]; // shift left arithmetic
        4'b1000: alu_output = input_A >>> input_B[3:0]; // shift right arithmetic
        4'b1001: alu_output = 2 * (input_A + input_B); // 2* Operation
        4'b1100: alu_output = input_B; // set to IG
        default: begin 
		 alu_output = 16'hxxxx; // default value for undefined inputs
		 //$display("ALU EXCEPTION: invalid operation %b",input_ALUOp);		
		end
    endcase
	output_ALU = alu_output[15:0];
    $display("ALU Output: %b", output_ALU);
end

//Flag Logic
always @ (*) begin
    output_Zero = (alu_output[15:0] == 16'h0000); // Set if output is zero
    output_Negative = alu_output[15];
end

endmodule
