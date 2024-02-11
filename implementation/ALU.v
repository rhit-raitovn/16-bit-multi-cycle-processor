/*******************************************************************************
* Author: Yueqiao Wang, Naziia Raitova
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
    input wire [15:0] input_A, input_B, // ALU inputs
    input wire [2:0] input_ALUOp, // ALU operation code
    output reg [15:0] output_ALU, // ALU output
    output reg output_Zero, output_negative // ALU flags
);

// Declare internal signals
reg [15:0] add_result, sub_result, and_result, or_result, xor_result;
reg [16:0] add_carry, sub_borrow;
reg zero, negative;

// Perform arithmetic and logic operations
always @*
begin
    case(input_ALUOp)
        3'b000: // Addition
            output_ALU = add_result;
        3'b001: // Subtraction
            output_ALU = sub_result;
        3'b010: // Bitwise Shift 
            output_ALU = input_A << input_B;
        3'b011: // Arithmetic Bitwise Shift
            output_ALU = (input_B[2]) ? (input_A >> input_B) : (input_A << input_B);
        3'b100: // AND Operation
            output_ALU = and_result;
        3'b101: // OR Operation
            output_ALU = or_result;
        3'b110: // XOR Operation
            output_ALU = xor_result;
        default: // Invalid operation
            output_ALU = 16'h0000; // Output default value for invalid operation
    endcase

    // Set zero flag
    output_Zero = (output_ALU == 16'b0);

    // Set negative flag
    output_negative = output_ALU[15];
end

// Perform arithmetic and logic operations
always @*
begin
    // Perform arithmetic operations
    add_result = input_A + input_B;
    sub_result = input_A - input_B;
    add_carry = {1'b0, input_A} + {1'b0, input_B};
    sub_borrow = {1'b0, input_A} - {1'b0, input_B};

    // Perform logic operations
    and_result = input_A & input_B;
    or_result = input_A | input_B;
    xor_result = input_A ^ input_B;
end

endmodule
