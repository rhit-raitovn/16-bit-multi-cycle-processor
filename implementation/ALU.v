/*******************************************************************************
* Author: Yueqiao Wang
* Date: 1/21/2024
*
* Module: ALU (Arithmetic Logic Unit)
*
* Description:
*   Verilog code for a 16-bit ALU with various arithmetic and logic operations.
*
* Inputs:
*   input [15:0] input_A, input_B // ALU inputs
*   input [2:0] input_ALUOp // ALU operation code
*
* Outputs:
*   output [15:0] output_ALU // ALU output
*   output output_Zero, output_negative // ALU flags
*
* Internal Signals:
*   wire [15:0] add_result, sub_result, and_result, or_result, xor_result;
*   wire [16:0] add_carry, sub_borrow;
*   wire zero, negative;
*
* Operations:
*   - Arithmetic: Addition, Subtraction
*   - Logic: AND, OR, XOR, Shift
*   - Flags: Zero, Negative
*
* Implementation Details:
*   - Carry and borrow flags are generated for addition and subtraction operations.
*   - Zero and negative flags are set based on the ALU output.
*   - Operation selection is based on the input ALU operation code.
*   - Default case handles invalid operations.
*
*******************************************************************************/
module ALU(
    input [15:0] input_A, input_B, // ALU inputs
    input [2:0] input_ALUOp, // ALU operation code
    output [15:0] output_ALU, // ALU output
    output output_Zero, output_negative // ALU flags
);

// Declare internal signals
wire [15:0] add_result, sub_result, and_result, or_result, xor_result;
wire [16:0] add_carry, sub_borrow;
wire zero, negative;

// Perform arithmetic and logic operations
assign add_result = input_A + input_B;
assign sub_result = input_A - input_B;
assign and_result = input_A & input_B;
assign or_result = input_A | input_B;
assign xor_result = input_A ^ input_B;

// Generate carry and borrow flags
assign add_carry = {1'b0, input_A} + {1'b0, input_B};
assign sub_borrow = {1'b0, input_A} - {1'b0, input_B};

// Generate zero and negative flags
assign zero = (output_ALU == 16'b0);
assign negative = output_ALU[15];

// Select the output and flags based on the operation code
always @(*)
begin
    case(input_ALUOp)
        
        default: // Invalid operation
            ;
    endcase
end

endmodule
