/*******************************************************************************
* Author: Yueqiao Wang, Naziia Raitova (modified)
* Date: 1/21/2024
*
* Module: Program Counter (PC)
*
* Description:
*   Verilog code for a program counter (PC) that updates its value based on a
*   control signal. The PC is updated on the rising edge of the clock when the
*   PCWrite flag is asserted.
*
* Inputs:
*   input wire input_PC_PCWrite // Flag indicating whether the PC will be updated.
*   input wire [15:0] input_PC_newPC // New value for the PC.
*   input wire CLK // Clock signal.

* Outputs:
*   output wire [15:0] output_PC // Output representing the value of the PC.
*
* Internal Signals:
*   reg [15:0] PC // Internal register to store the PC value.
*
* Operations:
*   - PC is updated on the rising edge of the clock when PCWrite is asserted.
*   - The new PC value is provided through input_PC_newPC.
*
*******************************************************************************/
module PC(
    input wire input_PC_PCWrite, // Flag indicating whether the PC will be updated.
    input wire [15:0] input_PC_newPC, // New value for the PC.
    input wire CLK, // Clock signal.

    output reg [15:0] output_PC // Output representing the value of the PC.
);

reg [15:0] PC; // Internal register to store the PC value.

always @(posedge CLK)
begin
    // Check if PC should be updated
    if (input_PC_PCWrite)
        PC <= input_PC_newPC; // Update PC with the new value
end

assign output_PC = PC;

endmodule
