/*******************************************************************************
* Author: Yueqiao Wang
* Date: 1/21/2024
*
* Module: Programmable Register File
*
* Description:
*   Verilog code for a register file with read and write operations. The module
*   includes two read ports (Operand A and Operand B) and a write port.
*
* Inputs:
*   input wire [2:0] input_reg_readA_address // 3-bit address for reading Operand A.
*   input wire [2:0] input_reg_readB_address // 3-bit address for reading Operand B.
*   input wire input_reg_write // Single-bit signal to enable write operation.
*   input wire [15:0] input_reg_write_value // 16-bit value for write operation.
*   input wire [2:0] input_reg_write_address // 3-bit address for write operation.
*   input wire CLK // Single-bit clock signal for synchronization.

* Outputs:
*   output wire [15:0] output_reg_A // 16-bit output representing data read from Register A.
*   output wire [15:0] output_reg_B // 16-bit output representing data read from Register B.
*
* Internal Signals:
*   reg [15:0] registers [0:7] // Array of 8 registers, each 16 bits wide.
*
* Operations:
*   - Read operations synchronized to the rising edge of the clock.
*   - Write operation is performed when the write signal is asserted.
*
*******************************************************************************/
module ProgrammableRegisterFile(
    input wire [2:0] input_reg_readA_address, // 3-bit address for reading Operand A.
    input wire [2:0] input_reg_readB_address, // 3-bit address for reading Operand B.
	 
    input wire input_reg_write, // Single-bit signal to enable write operation.
    input wire [15:0] input_reg_write_value, // 16-bit value for write operation.
    input wire [2:0] input_reg_write_address, // 3-bit address for write operation.
	 
    input wire CLK, // Single-bit clock signal for synchronization.

    output wire [15:0] output_reg_A, // 16-bit output representing data read from Register A.
    output wire [15:0] output_reg_B // 16-bit output representing data read from Register B.
);

reg [15:0] registers [0:7]; // Array of 8 registers, each 16 bits wide

always @(posedge CLK)
begin
    // Read operations
    output_reg_A <= registers[input_reg_readA_address];
    output_reg_B <= registers[input_reg_readB_address];

    // Write operation
    if (input_reg_write)
        registers[input_reg_write_address] <= input_reg_write_value;
end

endmodule
