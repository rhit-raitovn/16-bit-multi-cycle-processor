/*******************************************************************************
* Author: Yueqiao Wang
* Date: 1/21/2024
*
* Module: Control Unit
*
* Description:
*   A control unit that decodes the opcode and funct4 of an
*   instruction to generate control signals for various components.
*
* Inputs:
*   input wire [6:0] input_control // Input opcode + funct4
*
* Outputs:
*   output wire [0:0] output_branch // 1 if it's a branch instruction, 0 otherwise.
*   output wire [0:0] output_memRead // 1 if reading from memory, 0 otherwise.
*   output wire [2:0] output_ALUOp // ALU operation (+, -, and, or, ...)
*   output wire [0:0] output_memWrite // 1 if writing to memory, 0 otherwise.
*   output wire [0:0] output_ALUSrc // 1 if using immediate, 0 otherwise.
*   output wire [0:0] output_regWrite // 1 if the instruction involves writing to a register, 0 otherwise.
*   output wire [1:0] output_branchType // Specifies the type of branch instruction 
*
*******************************************************************************/
module Control(
    input wire [6:0] input_control, // Input opcode + funct4
    // Flags
    output wire [0:0] output_branch, // 1 if it's a branch instruction, 0 otherwise.
    output wire [0:0] output_memRead, // 1 if reading from memory, 0 otherwise.
    output wire [2:0] output_ALUOp, // ALU operation (+, -, and, or, ...)
    output wire [0:0] output_memWrite, // 1 if writing to memory, 0 otherwise.
    output wire [0:0] output_ALUSrc, // 1 if using immediate, 0 otherwise.
    output wire [0:0] output_regWrite, // 1 if the instruction involves writing to a register, 0 otherwise.
    output wire [1:0] output_branchType // Specifies the type of branch instruction 
);


endmodule
