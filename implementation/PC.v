/*******************************************************************************
* Author: Yueqiao Wang
* Date: 2/11/2024
*
* Module: Program Counter (PC)
*
* Description:
*   Verilog code for a program counter (PC) that updates its value based on a
*   control signal. The PC is updated on the rising edge of the clock when the
*   PCWrite flag is asserted. This module also handles branching conditions.
*
* Inputs:
*   input wire input_PCWrite        // Flag indicating whether the PC will be updated.
*   input wire [15:0] input_newPC  // New value for the PC.
*   input wire CLK                  // Clock signal.
*   input wire input_zero           // Signal indicating ALU output is zero.
*   input wire input_negative       // Signal indicating ALU output is negative.
*   input wire [1:0] input_branchType  // Branch type selector.
*   input wire input_PC_isbranch    // Signal from control indicating if a branch comparison is being performed.
*
* Outputs:
*   output reg [15:0] output_PC    // Output representing the value of the PC.
*
* Internal Signals:
*   reg [15:0] PC // Internal register to store the PC value.
*
* Operations:
*   - PC is updated on the rising edge of the clock when PCWrite is asserted.
*   - The new PC value is provided through input_newPC.
*   - Branching conditions are checked based on input signals.
*
*******************************************************************************/
module PC (
    input wire input_PCWrite,              // Flag indicating whether the PC will be updated.
    input wire [15:0] input_newPC,         // New value for the PC.
    input wire CLK,                        // Clock signal.
    input wire input_zero,                 // Signal indicating ALU output is zero.
    input wire input_negative,             // Signal indicating ALU output is negative.
    input wire [1:0] input_branchType,     // Branch type selector.
    input wire input_PC_isbranch,          // Signal from control indicating if a branch comparison is being performed.
    output wire [15:0] output_PC            // Output representing the value of the PC.
);

reg [15:0] PC; // Internal register to store the PC value.

always @(posedge CLK) begin
	if (input_PCWrite) begin
		if(input_PC_isbranch) begin
		  case(input_branchType)
				2'b00: begin // beq blt Reg[r1] - Reg[rd] = 0
					 if (input_zero)
						  PC <= input_newPC; // Branch taken
				end
				2'b01: begin // blt Reg[r1] - Reg[rd] >0
					 if (!input_negative)
						  PC <= input_newPC; // Branch taken
				end
				2'b10: begin // bne Reg[r1] - Reg[rd] != 0
					 if (!input_zero)
						  PC <= input_newPC; // Branch taken
				end
				2'b11: begin // bge blt Reg[r1] - Reg[rd] < 0
					 if (input_negative | input_zero)
						  PC <= input_newPC; // Branch taken
				end
				default: PC <= PC; // No branch condition met, PC remains the same
		  endcase
		end
		else
			PC <= input_newPC; // No branch comparison, update PC
            
   end
end

assign output_PC = PC; // Assign output

endmodule
