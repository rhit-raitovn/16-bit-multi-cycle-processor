/*******************************************************************************
* Author: Yueqiao Wang
* Date: 1/21/2024
*
* Module: Instruction Register
*
* Description:
*   Verilog code for an instruction register that stores a 16-bit instruction and
*   outputs control signals based on the opcode, register addresses, and immediate value.
*
* Inputs:
*   input wire [15:0] input_IR_Instru // 16-bit input bus for storing instruction data.
*   input wire input_IR_write // Single-bit control signal to write data into the instruction register.
*   input wire CLK // Clock signal.

* Outputs:
*   output wire [6:0] Output_IR_Control // 7-bit output for opcode and func4.
*   output wire [3:0] Output_IR_RegA // 3-bit output for register A address.
*   output wire [3:0] Output_IR_RegB // 3-bit output for register B address.
*   output wire [3:0] Output_IR_RegD // 3-bit output for register D address.
*   output wire [15:0] Output_IR_Imm // 16-bit output for immediate value.
*
* Internal Signals:
*   reg [15:0] instruction_register // Internal register to store the instruction.
*
* Operations:
*   - Write operation is synchronized to the rising edge of the clock.
*   - Control signals are output based on specific bit slices of the instruction.
*
*******************************************************************************/
module InstructionRegister(
    input wire [15:0] input_IR_Instru, // 16-bit input bus for storing instruction data.
    input wire input_IR_write, // Single-bit control signal to write data into the instruction register.
    input wire CLK, // Clock signal.

    output reg [6:0] Output_IR_Control, // 7-bit output for opcode and func4.
    output reg [3:0] Output_IR_RegA, // 3-bit output for register A address.
    output reg [3:0] Output_IR_RegB, // 3-bit output for register B address.
    output reg [3:0] Output_IR_RegD, // 3-bit output for register D address.
    output reg [15:0] Output_IR_Imm // 16-bit output for immediate value.
);

reg [15:0] instruction_register; // Internal register to store the instruction

always @(posedge CLK)
begin
    // Write operation
    if (input_IR_write)
        instruction_register <= input_IR_Instru;

    // Output control signals
    Output_IR_Control <= instruction_register[6:0];
    Output_IR_RegA <= instruction_register[12:10];
    Output_IR_RegB <= instruction_register[9:7];
    Output_IR_RegD <= instruction_register[12:10];
    Output_IR_Imm <= instruction_register;
end

endmodule
