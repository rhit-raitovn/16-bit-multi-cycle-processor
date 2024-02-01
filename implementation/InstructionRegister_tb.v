/*******************************************************************************
* Author: Naziia Raitova
* Date: 1/31/2024
*
* Module: Instruction Register test benches
*
*
*******************************************************************************/

`timescale 1ns / 1ps

module InstructionRegister_tb;

  // Inputs
  reg [15:0] input_IR_Instru;
  reg input_IR_write;
  reg CLK;

  // Outputs
  wire [6:0] Output_IR_Control;
  wire [3:0] Output_IR_RegA;
  wire [3:0] Output_IR_RegB;
  wire [3:0] Output_IR_RegD;
  wire [15:0] Output_IR_Imm;

  // Instantiate the InstructionRegister module
  InstructionRegister uut (
    .input_IR_Instru(input_IR_Instru),
    .input_IR_write(input_IR_write),
    .CLK(CLK),
    .Output_IR_Control(Output_IR_Control),
    .Output_IR_RegA(Output_IR_RegA),
    .Output_IR_RegB(Output_IR_RegB),
    .Output_IR_RegD(Output_IR_RegD),
    .Output_IR_Imm(Output_IR_Imm)
  );

  // Clock generation
  always begin
    #5 CLK = ~CLK; // Toggle the clock every 5 time units
  end

  // Test procedure
  initial begin
    // Initialize inputs
    input_IR_write = 0;
    input_IR_Instru = 16'h0000;
    CLK = 0;

    // Test Case 1: Check default values, values should not change
    #10;
    if (Output_IR_Control !== 7'b0000000 || Output_IR_RegA !== 4'b0000 ||
        Output_IR_RegB !== 4'b0000 || Output_IR_RegD !== 4'b0000 || Output_IR_Imm !== 16'h0000)
      $display("Test Case 1 Failed");

    // Test Case 2: Set instruction to a specific value
    input_IR_write = 1;
    input_IR_Instru = 16'h1A2B;
    #10;
    if (Output_IR_Control !== 7'b0110101 || Output_IR_RegA !== 4'b0010 ||
        Output_IR_RegB !== 4'b1011 || Output_IR_RegD !== 4'b0010 || Output_IR_Imm !== 16'h1A2B)
      $display("Test Case 2 Failed");

    // Test Case 3: Check values after write operation, values should not change when disabled
    input_IR_write = 0;
    #10;
    if (Output_IR_Control !== 7'b0110101 || Output_IR_RegA !== 4'b0010 ||
        Output_IR_RegB !== 4'b1011 || Output_IR_RegD !== 4'b0010 || Output_IR_Imm !== 16'h1A2B)
      $display("Test Case 3 Failed");

    $stop; 
  end

endmodule

