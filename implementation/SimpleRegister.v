/*******************************************************************************
* Author: Yueqiao Wang
* Date: 1/21/2024
*
* Module: Simple Register
*
* Description:
*   Simple register that updates its value every clock cycle.
*   The internal register is updated on the rising edge of the clock.
*
* Inputs:
*   input wire [15:0] input_SR // Input that updates every cycle.
*   input wire CLK // Clock signal.

* Outputs:
*   output wire [15:0] output_SR // Output representing the value in the register.
*
* Internal Signals:
*   reg [15:0] register_data // Internal register to store the value.
*
* Operations:
*   - On the rising edge of the clock, set the internal register to the input value.
*   - Output is a wire connected to the internal register.
*
*******************************************************************************/
module SimpleRegister(
    input wire [15:0] input_SR, // Input that updates every cycle.
    input wire CLK, // Clock signal.

    output reg [15:0] output_SR // Output representing the value in the register.
);

reg [15:0] register_data; // Internal register to store the value.

always @(posedge CLK)
begin
    // On the rising edge of the clock, set the internal register to the input value.
    register_data <= input_SR;

    // Assign the value of the internal register to the output
    output_SR <= register_data;
end

endmodule
