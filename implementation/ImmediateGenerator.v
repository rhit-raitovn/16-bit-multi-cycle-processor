/*
Module: ImmediateGenerator

Author: Yueqiao Wang
Date: 1/21/2024

Description:
This module represents an Immediate Generator that parses a 16-bit instruction to generate a 16-bit immediate value. It  takes an input instruction (input_imm). The output is the generated immediate value (output_imm). The module handles different cases based on the input_imm[2:0] values and performs appropriate immediate value generation.

Inputs:
- input wire [15:0] input_imm: 16-bit input instruction for the immediate to be parsed.

Outputs:
- output wire [15:0] output_imm: 16-bit output representing the immediate value generated by the Immediate Generator.

Registers:
- reg [15:0] UI_reg: Upper Immediate (UI) register.

Behavior:
- If input_imm[2:0] is equal to 3'b011, UI_reg is updated with input_imm[15:3], and output_imm is set to 16'b0.
- In normal cases, the module handles different cases based on input_imm[2:0]:
  - Case 3'b001: Generates output_imm by merging UI_reg[12], UI_reg, and input_imm[9:7].
  - Case 3'b010: Generates output_imm by sign-extending input_imm[12:7].
  - Case 3'b100: Generates output_imm by sign-extending input_imm[12:3].
  - Default case: Sets output_imm to 16'b0 .


*/

module ImmediateGenerator(
    input wire [15:0] input_imm, // 16-bit input of the instruction for the immediate to be parsed
    output wire [15:0] output_imm // 16-bit output representing the immediate value generated by the Immediate Generator.
);

reg [15:0] UI_reg; // UI (Upper Immediate) register
logic [15:0] imm;

always @(*)
begin
    if (input_imm[2:0] == 3'b011) begin // Check if input_imm[2:0] is equal to 011
        UI_reg <= input_imm[15:3]; // Update UI register with input_imm[15:3]
        imm <= 16'b0; // Output equals 0 in this case
    end
    else begin
        // Normal case
        case(input_imm[2:0])
            3'b001: imm <= {UI_reg[12], UI_reg, input_imm[9:7]}; // Output for input_imm[2:0] = 001 merge UI_reg[12], UI_reg, input_imm[9:7]
            3'b010: imm <= {{8{input_imm[12]}}, input_imm[12:7]}; // Output for 010, SE(input_imm[12:7])
            3'b100: imm <= {{4{input_imm[12]}}, input_imm[12:3]}; // Output for 100, SE(input_imm[12:3])
            default: imm <=  16'b0; // Default case (sign-extended)
        endcase
    end
	 output_imm <= imm;
end

endmodule
