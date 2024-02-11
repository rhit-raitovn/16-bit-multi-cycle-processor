/*******************************************************************************
* Author: Naziia Raitova 
* Date: 2/11/2024
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
module PC (
    input wire input_PCWrite,          // Flag indicating whether the PC will be updated.
    input wire [15:0] input_newPC,     // New value for the PC.
    input wire CLK,                    // Clock signal.
    input wire input_zero,             // Signal indicating ALU output is zero.
    input wire input_negative,         // Signal indicating ALU output is negative.
    input wire [1:0] input_branchType, // Branch type selector.
    input wire input_PC_isbranch,      // Signal from control indicating if a branch comparison is being performed.
    input wire input_PC_set,           // Signal from control indicating if the PC is being set to a specific value.
    output reg [15:0] output_PC        // Output representing the value of the PC.
);

reg [15:0] PC; // Internal register to store the PC value.

always @(posedge CLK) begin
    if (input_PCWrite) begin
        // Check if a branch is necessary
        if (input_PC_isbranch) begin
            case(input_branchType)
                2'b00: begin // beq
                    if (input_zero)
                        PC <= PC + (input_newPC * 2); // Branch taken
                    else
                        PC <= PC + 2; // Branch not taken
                end
                2'b01: begin // blt
                    if (input_negative)
                        PC <= PC + (input_newPC * 2); // Branch taken
                    else
                        PC <= PC + 2; // Branch not taken
                end
                2'b10: begin // bne
                    if (!input_zero)
                        PC <= PC + (input_newPC * 2); // Branch taken
                    else
                        PC <= PC + 2; // Branch not taken
                end
                2'b11: begin // bge
                    if (!input_negative)
                        PC <= PC + (input_newPC * 2); // Branch taken
                    else
                        PC <= PC + 2; // Branch not taken
                end
                default: PC <= PC + 2; // Default to increment by 2 if no branch type is selected
            endcase
        end
        // Set PC to input_newPC * 2
        else if (input_PC_set) begin
            PC <= input_newPC * 2;
            output_PC <= input_newPC * 2; // Initialize output_PC
        end
        // Increment PC by 2
        else begin
            PC <= PC + 2;
            output_PC <= PC + 2; // Initialize output_PC
        end
    end
end

endmodule
