`timescale 1ns / 1ps

module Control_tb;

  // Parameters
  parameter full = 10; // Clock period in time units
  parameter half = 5;

  // Inputs
  reg [6:0] input_control;
  reg CLK;
  reg Reset;

  // Outputs
  wire [0:0] output_control_Branch;
  wire [0:0] output_control_IoD;
  wire [0:0] output_control_IRWrite;
  wire [0:0] output_control_Mem2Reg;
  wire [0:0] output_control_MemR;
  wire [0:0] output_control_MemW;
  wire [0:0] output_control_PCSrc;
  wire [0:0] output_control_PCWrite;
  wire [0:0] output_control_RegWrite;
  wire [1:0] output_control_ALUSrcA;
  wire [1:0] output_control_ALUSrcB;
  wire [1:0] output_control_BranchType;
  wire [3:0] output_control_ALUOp;
  wire [3:0] output_control_current_state;
  wire [3:0] output_control_next_state;

  // Instantiate the control module
  Control uut(
    .input_control(input_control),
    .CLK(CLK),
    .Reset(Reset),
    .output_control_Branch(output_control_Branch),
    .output_control_IoD(output_control_IoD),
    .output_control_IRWrite(output_control_IRWrite),
    .output_control_Mem2Reg(output_control_Mem2Reg),
    .output_control_MemR(output_control_MemR),
    .output_control_MemW(output_control_MemW),
    .output_control_PCSrc(output_control_PCSrc),
    .output_control_PCWrite(output_control_PCWrite),
    .output_control_RegWrite(output_control_RegWrite),
    .output_control_ALUSrcA(output_control_ALUSrcA),
    .output_control_ALUSrcB(output_control_ALUSrcB),
    .output_control_BranchType(output_control_BranchType),
    .output_control_ALUOp(output_control_ALUOp),
    .output_control_current_state(output_control_current_state),
    .output_control_next_state(output_control_next_state)
  );


  // Clock generation block
  integer i;
  initial begin
   CLK = 0;
   for (i = 0; i < 249; i = i + 1) begin
      #half;
      CLK = ~CLK; // Toggle clock every half period
   end
  end

parameter    Fetch = 0;
parameter    Decode = 1;
parameter    RType = 2;
parameter    RIType = 3;
parameter    RTypeEnd = 4;
parameter    lw1 = 5;
parameter    lw2 = 6;
parameter    sw = 7;
parameter    jalr = 8;
parameter    branch = 9;
parameter    branch2 = 10;
parameter    jal = 11;


  initial begin

    input_control = 7'b0010000; //and

    // Reset generation
    Reset = 1;
    #full;
    Reset = 0;

    // Test 1 3R Type Path

    

    // Test 1 3R Type Path Fetech
    #half;

    // Test Case 1 (3R) Fetech for output_control_ALUOp
    if (output_control_ALUOp !== 4'b0000)
      $display("Test Case 1 (3R) Fetech 1 (3R) Fetech output_control_ALUOp Failed. Expected: %h, Actual: %h", 4'b0000, output_control_ALUOp);
    else
      $display("Test Case 1 (3R) Fetech 1 (3R) Fetech output_control_ALUOp Passed at Time %0t.", $time);

    // Test Case 1 (3R) Fetech 1 (3R) Fetech for output_control_ALUSrcA
    if (output_control_ALUSrcA !== 2'b00)
      $display("Test Case 1 (3R) Fetech output_control_ALUSrcA Failed. Expected: %h, Actual: %h", 2'b00, output_control_ALUSrcA);
    else
      $display("Test Case 1 (3R) Fetech output_control_ALUSrcA Passed at Time %0t.", $time);

    // Test Case 1 (3R) Fetech for output_control_ALUSrcB
    if (output_control_ALUSrcB !== 2'b01)
      $display("Test Case 1 (3R) Fetech output_control_ALUSrcB Failed. Expected: %h, Actual: %h", 2'b01, output_control_ALUSrcB);
    else
      $display("Test Case 1 (3R) Fetech output_control_ALUSrcB Passed at Time %0t.", $time);

    // Test Case 1 (3R) Fetech for output_control_IoD
    if (output_control_IoD !== 1'b0)
      $display("Test Case 1 (3R) Fetech output_control_IoD Failed. Expected: %h, Actual: %h", 1'b0, output_control_IoD);
    else
      $display("Test Case 1 (3R) Fetech output_control_IoD Passed at Time %0t.", $time);

    // Test Case 1 (3R) Fetech for output_control_IRWrite
    if (output_control_IRWrite !== 1'b1)
      $display("Test Case 1 (3R) Fetech output_control_IRWrite Failed. Expected: %h, Actual: %h", 1'b1, output_control_IRWrite);
    else
      $display("Test Case 1 (3R) Fetech output_control_IRWrite Passed at Time %0t.", $time);

    // Test Case 1 (3R) Fetech for output_control_MemR
    if (output_control_MemR !== 1'b0)
      $display("Test Case 1 (3R) Fetech output_control_MemR Failed. Expected: %h, Actual: %h", 1'b0, output_control_MemR);
    else
      $display("Test Case 1 (3R) Fetech output_control_MemR Passed at Time %0t.", $time);

    // Test Case 1 (3R) Fetech for output_control_PCSrc
    if (output_control_PCSrc !== 1'b0)
      $display("Test Case 1 (3R) Fetech output_control_PCSrc Failed. Expected: %h, Actual: %h", 1'b0, output_control_PCSrc);
    else
      $display("Test Case 1 (3R) Fetech output_control_PCSrc Passed at Time %0t.", $time);

    // Test Case 1 (3R) Fetech for output_control_PCWrite
    if (output_control_PCWrite !== 1'b1)
      $display("Test Case 1 (3R) Fetech output_control_PCWrite Failed. Expected: %h, Actual: %h", 1'b1, output_control_PCWrite);
    else
      $display("Test Case 1 (3R) Fetech output_control_PCWrite Passed at Time %0t.", $time);

    // Test Case for output_control_current_state
    if (output_control_current_state !== Fetch)
      $display("Test Case 1 (3R) Fetech output_control_current_state Failed. Expected: %h, Actual: %h", Fetch, output_control_current_state);
    else
      $display("Test Case 1 (3R) Fetech: output_control_current_state Passed at Time %0t.", $time);

    // Test Case for output_control_next_state
    if (output_control_next_state !== Decode)
      $display("Test Case 1 (3R) Fetech for output_control_next_state Failed. Expected: %h, Actual: %h", Decode, output_control_next_state);
    else
      $display("Test Case 1 (3R) Fetech for output_control_next_state Passed at Time %0t.", $time);

    #full

    //Test 1 3R Type Path Decode

    // Test Case for output_control_IRWrite
    if (output_control_IRWrite !== 1'b0)
      $display("Test Case 1 (3R) for output_control_IRWrite in Decode state Failed. Expected: %h, Actual: %h", 1'b0, output_control_IRWrite);
    else
      $display("Test Case 1 (3R) for output_control_IRWrite in Decode state Passed at Time %0t.", $time);

    // Test Case for output_control_MemR
    if (output_control_MemR !== 1'b0)
      $display("Test Case 1 (3R) for output_control_MemR in Decode state Failed. Expected: %h, Actual: %h", 1'b0, output_control_MemR);
    else
      $display("Test Case 1 (3R) for output_control_MemR in Decode state Passed at Time %0t.", $time);

    // Test Case for output_control_PCWrite
    if (output_control_PCWrite !== 1'b0)
      $display("Test Case 1 (3R) for output_control_PCWrite in Decode state Failed. Expected: %h, Actual: %h", 1'b0, output_control_PCWrite);
    else
      $display("Test Case 1 (3R) for output_control_PCWrite in Decode state Passed at Time %0t.", $time);

    // Test Case for output_control_current_state in Decode State
    if (output_control_current_state !== Decode)
      $display("Test Case 1 (3R) for output_control_current_state in Decode State Failed. Expected: %h, Actual: %h", Decode, output_control_current_state);
    else
      $display("Test Case 1 (3R) for output_control_current_state in Decode State Passed at Time %0t.", $time);

    // State Machine Transition Test for Decode State
    if (output_control_next_state !== RType)
      $display("Test Case 1 (3R) State Machine Transition Test for Decode State Failed. Next State Expected: %h, Actual: %h", RType, output_control_next_state);
    else
      $display("Test Case 1 (3R) State Machine Transition Test for Decode State Passed at Time %0t.", $time);






    
    
    // Finish simulation
    #full;
    $finish;
  end

endmodule
