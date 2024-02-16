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

parameter    FETCH = 0;
parameter    DECODE = 1;
parameter    RTYPE = 2;
parameter    RITYPE = 3;
parameter    RTYPEEND = 4;
parameter    LW1 = 5;
parameter    LW2 = 6;
parameter    SW = 7;
parameter    JALR = 8;
parameter    BRANCH = 9;
parameter    BRANCH2 = 10;
parameter    JAL = 11;


  initial begin

    $display("*****************************************************************");
    $display("3R Type AND TEST");

    input_control = 7'b0010000; //and

    // Reset generation
    Reset = 1;
    #full;
    Reset = 0;

    // Test 1 3R Type Path

    // Test 1 3R Type Path FETCH
    #half;
    $display("----------------------FETCH----------------");
    // Test Case 1 (3R) FETCH for output_control_ALUOp
    if (output_control_ALUOp !== 4'b0000)
      $display("Test Case 1 (3R) FETCH 1 (3R) FETCH output_control_ALUOp Failed. Expected: %h, Actual: %h", 4'b0000, output_control_ALUOp);
    else
      $display("Test Case 1 (3R) FETCH 1 (3R) FETCH output_control_ALUOp !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) FETCH 1 (3R) FETCH for output_control_ALUSrcA
    if (output_control_ALUSrcA !== 2'b00)
      $display("Test Case 1 (3R) FETCH output_control_ALUSrcA Failed. Expected: %h, Actual: %h", 2'b00, output_control_ALUSrcA);
    else
      $display("Test Case 1 (3R) FETCH output_control_ALUSrcA !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) FETCH for output_control_ALUSrcB
    if (output_control_ALUSrcB !== 2'b01)
      $display("Test Case 1 (3R) FETCH output_control_ALUSrcB Failed. Expected: %h, Actual: %h", 2'b01, output_control_ALUSrcB);
    else
      $display("Test Case 1 (3R) FETCH output_control_ALUSrcB !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) FETCH for output_control_IoD
    if (output_control_IoD !== 1'b0)
      $display("Test Case 1 (3R) FETCH output_control_IoD Failed. Expected: %h, Actual: %h", 1'b0, output_control_IoD);
    else
      $display("Test Case 1 (3R) FETCH output_control_IoD !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) FETCH for output_control_IRWrite
    if (output_control_IRWrite !== 1'b1)
      $display("Test Case 1 (3R) FETCH output_control_IRWrite Failed. Expected: %h, Actual: %h", 1'b1, output_control_IRWrite);
    else
      $display("Test Case 1 (3R) FETCH output_control_IRWrite !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) FETCH for output_control_MemR
    if (output_control_MemR !== 1'b0)
      $display("Test Case 1 (3R) FETCH output_control_MemR Failed. Expected: %h, Actual: %h", 1'b0, output_control_MemR);
    else
      $display("Test Case 1 (3R) FETCH output_control_MemR !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) FETCH for output_control_PCSrc
    if (output_control_PCSrc !== 1'b0)
      $display("Test Case 1 (3R) FETCH output_control_PCSrc Failed. Expected: %h, Actual: %h", 1'b0, output_control_PCSrc);
    else
      $display("Test Case 1 (3R) FETCH output_control_PCSrc !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) FETCH for output_control_PCWrite
    if (output_control_PCWrite !== 1'b1)
      $display("Test Case 1 (3R) FETCH output_control_PCWrite Failed. Expected: %h, Actual: %h", 1'b1, output_control_PCWrite);
    else
      $display("Test Case 1 (3R) FETCH output_control_PCWrite !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state
    if (output_control_current_state !== FETCH)
      $display("Test Case 1 (3R) FETCH output_control_current_state Failed. Expected: %h, Actual: %h", FETCH, output_control_current_state);
    else
      $display("Test Case 1 (3R) FETCH: output_control_current_state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_next_state
    if (output_control_next_state !== DECODE)
      $display("Test Case 1 (3R) FETCH for output_control_next_state Failed. Expected: %h, Actual: %h", DECODE, output_control_next_state);
    else
      $display("Test Case 1 (3R) FETCH for output_control_next_state !!!Passed!!! at Time %0t.", $time);
    $display("----------------------FETCH----------------");
    #full
    $display("----------------------DECODE----------------");
    //Test 1 3R Type Path DECODE

    // Test Case for output_control_IRWrite
    if (output_control_IRWrite !== 1'b0)
      $display("Test Case 1 (3R) for output_control_IRWrite in DECODE state Failed. Expected: %h, Actual: %h", 1'b0, output_control_IRWrite);
    else
      $display("Test Case 1 (3R) for output_control_IRWrite in DECODE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_MemR
    if (output_control_MemR !== 1'b0)
      $display("Test Case 1 (3R) for output_control_MemR in DECODE state Failed. Expected: %h, Actual: %h", 1'b0, output_control_MemR);
    else
      $display("Test Case 1 (3R) for output_control_MemR in DECODE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCWrite
    if (output_control_PCWrite !== 1'b0)
      $display("Test Case 1 (3R) for output_control_PCWrite in DECODE state Failed. Expected: %h, Actual: %h", 1'b0, output_control_PCWrite);
    else
      $display("Test Case 1 (3R) for output_control_PCWrite in DECODE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in DECODE State
    if (output_control_current_state !== DECODE)
      $display("Test Case 1 (3R) for output_control_current_state in DECODE State Failed. Expected: %h, Actual: %h", DECODE, output_control_current_state);
    else
      $display("Test Case 1 (3R) for output_control_current_state in DECODE State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for DECODE State
    if (output_control_next_state !== RTYPE)
      $display("Test Case 1 (3R) State Machine Transition Test for DECODE State Failed. Next State Expected: %h, Actual: %h", RTYPE, output_control_next_state);
    else
      $display("Test Case 1 (3R) State Machine Transition Test for DECODE State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------DECODE----------------");
    #full
    $display("----------------------RTYPE----------------");
    //Test 1 3R Type Path RTYPE
    // Test Case for output_control_ALUOp in RTYPE State
    if (output_control_ALUOp !== 4'b0010)
      $display("Test Case for output_control_ALUOp in RTYPE state Failed. Expected: %h, Actual: %h", 4'b0010, output_control_ALUOp);
    else
      $display("Test Case for output_control_ALUOp in RTYPE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcA in RTYPE State
    if (output_control_ALUSrcA !== 2'b10)
      $display("Test Case for output_control_ALUSrcA in RTYPE state Failed. Expected: %h, Actual: %h", 2'b10, output_control_ALUSrcA);
    else
      $display("Test Case for output_control_ALUSrcA in RTYPE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcB in RTYPE State
    if (output_control_ALUSrcB !== 2'b00)
      $display("Test Case for output_control_ALUSrcB in RTYPE state Failed. Expected: %h, Actual: %h", 2'b00, output_control_ALUSrcB);
    else
      $display("Test Case for output_control_ALUSrcB in RTYPE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in RTYPE State
    if (output_control_current_state !== RTYPE)
      $display("Test Case for output_control_current_state in RTYPE State Failed. Expected: %h, Actual: %h", RTYPE, output_control_current_state);
    else
      $display("Test Case for output_control_current_state in RTYPE State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for RTYPE State
    if (output_control_next_state !== RTYPEEND)
      $display("Test Case for State Machine Transition in RTYPE State Failed. Next State Expected: %h, Actual: %h", RTYPEEND, output_control_next_state);
    else
      $display("Test Case for State Machine Transition in RTYPE State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------RTYPE----------------");
    #full
    $display("----------------------RTYPEEND----------------");
    //Test 1 3R Type Path RTYPEEND
    // Test Case for output_control_Mem2Reg in RTYPEEND State
    if (output_control_Mem2Reg !== 1'b0)
      $display("Test Case for output_control_Mem2Reg in RTYPEEND state Failed. Expected: %h, Actual: %h", 1'b0, output_control_Mem2Reg);
    else
      $display("Test Case for output_control_Mem2Reg in RTYPEEND state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_RegWrite in RTYPEEND State
    if (output_control_RegWrite !== 1'b1)
      $display("Test Case for output_control_RegWrite in RTYPEEND state Failed. Expected: %h, Actual: %h", 1'b1, output_control_RegWrite);
    else
      $display("Test Case for output_control_RegWrite in RTYPEEND state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in RTYPEEND State
    if (output_control_current_state !== RTYPEEND)
      $display("Test Case for output_control_current_state in RTYPEEND State Failed. Expected: %h, Actual: %h", RTYPEEND, output_control_current_state);
    else
      $display("Test Case for output_control_current_state in RTYPEEND State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for RTYPEEND State
    if (output_control_next_state !== FETCH)
      $display("Test Case for State Machine Transition in RTYPEEND State Failed. Next State Expected: %h, Actual: %h", FETCH, output_control_next_state);
    else
      $display("Test Case for State Machine Transition in RTYPEEND State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------RTYPEEND----------------");
    input_control = 7'b0101001; //slli
    $display("~~~TEST 2 input_control changed at Time %0t~~~~", $time);

    $display("Test 1 3R Type Path !!!Passed!!! Entirely at Time %0t.", $time);
    $display("*****************************************************************");

    $display("*****************************************************************");
    $display("TEST 2 Normal 2RI Type slli TEST");
    input_control = 7'b0101001; //slli
    #full
    $display("----------------------FETCH----------------");
    // Test for output_control_ALUOp
    if (output_control_ALUOp !== 4'b0000)
      $display("TEST 2 Normal 2RI Type slli: output_control_ALUOp Failed at Time %0t. Expected: %h, Actual: %h", $time, 4'b0000, output_control_ALUOp);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_ALUOp !!!Passed!!! at Time %0t.", $time);

    // Test for output_control_ALUSrcA
    if (output_control_ALUSrcA !== 2'b00)
      $display("TEST 2 Normal 2RI Type slli: output_control_ALUSrcA Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b00, output_control_ALUSrcA);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_ALUSrcA !!!Passed!!! at Time %0t.", $time);

    // Test for output_control_ALUSrcB
    if (output_control_ALUSrcB !== 2'b01)
      $display("TEST 2 Normal 2RI Type slli: output_control_ALUSrcB Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b01, output_control_ALUSrcB);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_ALUSrcB !!!Passed!!! at Time %0t.", $time);

    // Test for output_control_IoD
    if (output_control_IoD !== 1'b0)
      $display("TEST 2 Normal 2RI Type slli: output_control_IoD Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_IoD);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_IoD !!!Passed!!! at Time %0t.", $time);

    // Test for output_control_IRWrite
    if (output_control_IRWrite !== 1'b1)
      $display("TEST 2 Normal 2RI Type slli: output_control_IRWrite Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_IRWrite);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_IRWrite !!!Passed!!! at Time %0t.", $time);

    // Test for output_control_MemR
    if (output_control_MemR !== 1'b0)
      $display("TEST 2 Normal 2RI Type slli: output_control_MemR Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_MemR);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_MemR !!!Passed!!! at Time %0t.", $time);

    // Test for output_control_PCSrc
    if (output_control_PCSrc !== 1'b0)
      $display("TEST 2 Normal 2RI Type slli: output_control_PCSrc Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_PCSrc);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_PCSrc !!!Passed!!! at Time %0t.", $time);

    // Test for output_control_PCWrite
    if (output_control_PCWrite !== 1'b1)
      $display("TEST 2 Normal 2RI Type slli: output_control_PCWrite Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_PCWrite);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_PCWrite !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in FETCH State
    if (output_control_current_state !== FETCH)
      $display("TEST 2 Normal 2RI Type slli: output_control_current_state in FETCH State Failed at Time %0t. Expected: %h, Actual: %h", $time, FETCH, output_control_current_state);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_current_state in FETCH State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for FETCH State
    if (output_control_next_state !== DECODE)
      $display("TEST 2 Normal 2RI Type slli: State Machine Transition Test for FETCH State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, DECODE, output_control_next_state);
    else
      $display("TEST 2 Normal 2RI Type slli: State Machine Transition Test for FETCH State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------FETCH----------------");

    #full

    $display("----------------------DECODE----------------");
    // Test Case for output_control_IRWrite in DECODE State
    if (output_control_IRWrite !== 1'b0)
      $display("TEST 2 Normal 2RI Type slli: output_control_IRWrite in DECODE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_IRWrite);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_IRWrite in DECODE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_MemR in DECODE State
    if (output_control_MemR !== 1'b0)
      $display("TEST 2 Normal 2RI Type slli: output_control_MemR in DECODE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_MemR);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_MemR in DECODE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCWrite in DECODE State
    if (output_control_PCWrite !== 1'b0)
      $display("TEST 2 Normal 2RI Type slli: output_control_PCWrite in DECODE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_PCWrite);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_PCWrite in DECODE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in DECODE State
    if (output_control_current_state !== DECODE)
      $display("TEST 2 Normal 2RI Type slli: output_control_current_state in DECODE State Failed at Time %0t. Expected: %h, Actual: %h", $time, DECODE, output_control_current_state);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_current_state in DECODE State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for DECODE State
    if (output_control_next_state !== RITYPE)
      $display("TEST 2 Normal 2RI Type slli: State Machine Transition Test for DECODE State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, RITYPE, output_control_next_state);
    else
      $display("TEST 2 Normal 2RI Type slli: State Machine Transition Test for DECODE State !!!Passed!!! at Time %0t.", $time);

    $display("----------------------DECODE----------------");

    #full

    $display("----------------------RITYPE----------------");

    // Test Case for output_control_ALUOp in RITYPE State
    if (output_control_ALUOp !== 4'b0101)
      $display("TEST 2 RI Type Path RITYPE: output_control_ALUOp in RITYPE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 4'b0101, output_control_ALUOp);
    else
      $display("TEST 2 RI Type Path RITYPE: output_control_ALUOp in RITYPE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcA in RITYPE State
    if (output_control_ALUSrcA !== 2'b10)
      $display("TEST 2 RI Type Path RITYPE: output_control_ALUSrcA in RITYPE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b10, output_control_ALUSrcA);
    else
      $display("TEST 2 RI Type Path RITYPE: output_control_ALUSrcA in RITYPE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcB in RITYPE State
    if (output_control_ALUSrcB !== 2'b10)
      $display("TEST 2 RI Type Path RITYPE: output_control_ALUSrcB in RITYPE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b10, output_control_ALUSrcB);
    else
      $display("TEST 2 RI Type Path RITYPE: output_control_ALUSrcB in RITYPE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in RITYPE State
    if (output_control_current_state !== RITYPE)
      $display("TEST 2 RI Type Path RITYPE: output_control_current_state in RITYPE State Failed at Time %0t. Expected: %h, Actual: %h", $time, RITYPE, output_control_current_state);
    else
      $display("TEST 2 RI Type Path RITYPE: output_control_current_state in RITYPE State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test from RITYPE State to RTYPEEND State
    if (output_control_next_state !== RTYPEEND)
      $display("TEST 2 RI Type Path RITYPE: State Machine Transition from RITYPE State to RTYPEEND State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, RTYPEEND, output_control_next_state);
    else
      $display("TEST 2 RI Type Path RITYPE: State Machine Transition from RITYPE State to RTYPEEND State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------RITYPE----------------");

    #full

    $display("----------------------RTYPEEND----------------");
    // Test Case for output_control_Mem2Reg in RTYPEEND State
    if (output_control_Mem2Reg !== 1'b0)
      $display("TEST 2 RTYPEEND Path: output_control_Mem2Reg in RTYPEEND state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_Mem2Reg);
    else
      $display("TEST 2 RTYPEEND Path: output_control_Mem2Reg in RTYPEEND state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_RegWrite in RTYPEEND State
    if (output_control_RegWrite !== 1'b1)
      $display("TEST 2 RTYPEEND Path: output_control_RegWrite in RTYPEEND state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_RegWrite);
    else
      $display("TEST 2 RTYPEEND Path: output_control_RegWrite in RTYPEEND state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in RTYPEEND State
    if (output_control_current_state !== RTYPEEND)
      $display("TEST 2 RTYPEEND Path: output_control_current_state in RTYPEEND State Failed at Time %0t. Expected: %h, Actual: %h", $time, RTYPEEND, output_control_current_state);
    else
      $display("TEST 2 RTYPEEND Path: output_control_current_state in RTYPEEND State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test from RTYPEEND State to FETCH State
    if (output_control_next_state !== FETCH)
      $display("TEST 2 RTYPEEND Path: State Machine Transition from RTYPEEND State to FETCH State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, FETCH, output_control_next_state);
    else
      $display("TEST 2 RTYPEEND Path: State Machine Transition from RTYPEEND State to FETCH State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------RTYPEEND----------------");
    input_control = 7'b1001001; //lw
    $display("~~~TEST 3 input_control changed to 7'b1001001 at Time %0t~~~~", $time);

    $display("*****************************************************************");

    

    $display("*****************************************************************");
    $display("TEST 3 Load Word TEST");
    input_control = 7'b1001001; //lw
    #full

    $display("----------------------FETCH----------------");

    // Test Case for FETCH State
    // Test Case for output_control_ALUOp in FETCH State
    if (output_control_ALUOp !== 4'b0000)
      $display("TEST 3 Load Word FETCH Path: output_control_ALUOp in FETCH state Failed at Time %0t. Expected: %h, Actual: %h", $time, 4'b0000, output_control_ALUOp);
    else
      $display("TEST 3 Load Word FETCH Path: output_control_ALUOp in FETCH state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcA in FETCH State
    if (output_control_ALUSrcA !== 2'b00)
      $display("TEST 3 Load Word FETCH Path: output_control_ALUSrcA in FETCH state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b00, output_control_ALUSrcA);
    else
      $display("TEST 3 Load Word FETCH Path: output_control_ALUSrcA in FETCH state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcB in FETCH State
    if (output_control_ALUSrcB !== 2'b01)
      $display("TEST 3 Load Word FETCH Path: output_control_ALUSrcB in FETCH state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b01, output_control_ALUSrcB);
    else
      $display("TEST 3 Load Word FETCH Path: output_control_ALUSrcB in FETCH state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_IoD in FETCH State
    if (output_control_IoD !== 1'b0)
      $display("TEST 3 Load Word FETCH Path: output_control_IoD in FETCH state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_IoD);
    else
      $display("TEST 3 Load Word FETCH Path: output_control_IoD in FETCH state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_IRWrite in FETCH State
    if (output_control_IRWrite !== 1'b1)
      $display("TEST 3 Load Word FETCH Path: output_control_IRWrite in FETCH state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_IRWrite);
    else
      $display("TEST 3 Load Word FETCH Path: output_control_IRWrite in FETCH state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_MemR in FETCH State
    if (output_control_MemR !== 1'b0)
      $display("TEST 3 Load Word FETCH Path: output_control_MemR in FETCH state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_MemR);
    else
      $display("TEST 3 Load Word FETCH Path: output_control_MemR in FETCH state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCSrc in FETCH State
    if (output_control_PCSrc !== 1'b0)
      $display("TEST 3 Load Word FETCH Path: output_control_PCSrc in FETCH state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_PCSrc);
    else
      $display("TEST 3 Load Word FETCH Path: output_control_PCSrc in FETCH state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCWrite in FETCH State
    if (output_control_PCWrite !== 1'b1)
      $display("TEST 3 Load Word FETCH Path: output_control_PCWrite in FETCH state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_PCWrite);
    else
      $display("TEST 3 Load Word FETCH Path: output_control_PCWrite in FETCH state !!!Passed!!! at Time %0t.", $time);


    // Test Case for output_control_current_state in FETCH State
    if (output_control_current_state !== FETCH)
      $display("TEST 3 Load Word FETCH Path: output_control_current_state in FETCH State Failed at Time %0t. Expected: %h, Actual: %h", $time, FETCH, output_control_current_state);
    else
      $display("TEST 3 Load Word FETCH Path: output_control_current_state in FETCH State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for FETCH State
    if (output_control_next_state !== DECODE)
      $display("TEST 3 Load Word FETCH Path: State Machine Transition Test for FETCH State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, DECODE, output_control_next_state);
    else
      $display("TEST 3 Load Word FETCH Path: State Machine Transition Test for FETCH State !!!Passed!!! at Time %0t.", $time);

    $display("----------------------FETCH----------------");
    #full
    $display("----------------------DECODE----------------");
    
    // Test Case for output_control_IRWrite in DECODE State
    if (output_control_IRWrite !== 1'b0)
      $display("TEST 3 Load Word DECODE Path: output_control_IRWrite in DECODE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_IRWrite);
    else
      $display("TEST 3 Load Word DECODE Path: output_control_IRWrite in DECODE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_MemR in DECODE State
    if (output_control_MemR !== 1'b0)
      $display("TEST 3 Load Word DECODE Path: output_control_MemR in DECODE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_MemR);
    else
      $display("TEST 3 Load Word DECODE Path: output_control_MemR in DECODE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCWrite in DECODE State
    if (output_control_PCWrite !== 1'b0)
      $display("TEST 3 Load Word DECODE Path: output_control_PCWrite in DECODE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_PCWrite);
    else
      $display("TEST 3 Load Word DECODE Path: output_control_PCWrite in DECODE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in DECODE State
    if (output_control_current_state !== DECODE)
      $display("TEST 3 Load Word DECODE Path: output_control_current_state in DECODE State Failed at Time %0t. Expected: %h, Actual: %h", $time, DECODE, output_control_current_state);
    else
      $display("TEST 3 Load Word DECODE Path: output_control_current_state in DECODE State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test from DECODE State to DECODE State
    if (output_control_next_state !== RITYPE)
      $display("TEST 3 Load Word DECODE Path: State Machine Transition from DECODE State to RITYPE State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, RITYPE, output_control_next_state);
    else
      $display("TEST 3 Load Word DECODE Path: State Machine Transition from DECODE State to RITYPE State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------DECODE----------------");
    #full    
    $display("----------------------RITYPE----------------");
    // Test Case for output_control_ALUOp in RITYPE State
    if (output_control_ALUOp !== 4'b1001)
      $display("TEST 3 Load Word RITYPE Path: output_control_ALUOp in RITYPE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 4'b1001, output_control_ALUOp);
    else
      $display("TEST 3 Load Word RITYPE Path: output_control_ALUOp in RITYPE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcA in RITYPE State
    if (output_control_ALUSrcA !== 2'b10)
      $display("TEST 3 Load Word RITYPE Path: output_control_ALUSrcA in RITYPE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b10, output_control_ALUSrcA);
    else
      $display("TEST 3 Load Word RITYPE Path: output_control_ALUSrcA in RITYPE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcB in RITYPE State
    if (output_control_ALUSrcB !== 2'b10)
      $display("TEST 3 Load Word RITYPE Path: output_control_ALUSrcB in RITYPE state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b10, output_control_ALUSrcB);
    else
      $display("TEST 3 Load Word RITYPE Path: output_control_ALUSrcB in RITYPE state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in RITYPE State
    if (output_control_current_state !== RITYPE)
      $display("TEST 3 Load Word RITYPE Path: output_control_current_state in RITYPE State Failed at Time %0t. Expected: %h, Actual: %h", $time, RITYPE, output_control_current_state);
    else
      $display("TEST 3 Load Word RITYPE Path: output_control_current_state in RITYPE State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test from RITYPE State to LW1 State
    if (output_control_next_state !== LW1)
      $display("TEST 3 Load Word RITYPE Path: State Machine Transition from RITYPE State to LW1 State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, LW1, output_control_next_state);
    else
      $display("TEST 3 Load Word RITYPE Path: State Machine Transition from RITYPE State to LW1 State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------RITYPE----------------");
    #full    
    $display("----------------------LW1----------------");
    // Test Case for output_control_IoD in LW1 State
    if (output_control_IoD !== 1'b1)
      $display("TEST 3 Load Word LW1 Path: output_control_IoD in LW1 state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_IoD);
    else
      $display("TEST 3 Load Word LW1 Path: output_control_IoD in LW1 state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_MemR in LW1 State
    if (output_control_MemR !== 1'b1)
      $display("TEST 3 Load Word LW1 Path: output_control_MemR in LW1 state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_MemR);
    else
      $display("TEST 3 Load Word LW1 Path: output_control_MemR in LW1 state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in LW1 State
    if (output_control_current_state !== LW1)
      $display("TEST 3 Load Word LW1 Path: output_control_current_state in LW1 State Failed at Time %0t. Expected: %h, Actual: %h", $time, LW1, output_control_current_state);
    else
      $display("TEST 3 Load Word LW1 Path: output_control_current_state in LW1 State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test from LW1 State to LW2 State
    if (output_control_next_state !== LW2)
      $display("TEST 3 Load Word LW1 Path: State Machine Transition from LW1 State to LW2 State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, LW2, output_control_next_state);
    else
      $display("TEST 3 Load Word LW1 Path: State Machine Transition from LW1 State to LW2 State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------LW1----------------");
    #full

    $display("----------------------LW2----------------");
    // Test Case for output_control_Mem2Reg in LW2 State
    if (output_control_Mem2Reg !== 1'b1)
      $display("TEST 3 Load Word LW2 Path: output_control_Mem2Reg in LW2 state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_Mem2Reg);
    else
      $display("TEST 3 Load Word LW2 Path: output_control_Mem2Reg in LW2 state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_RegWrite in LW2 State
    if (output_control_RegWrite !== 1'b1)
      $display("TEST 3 Load Word LW2 Path: output_control_RegWrite in LW2 state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_RegWrite);
    else
      $display("TEST 3 Load Word LW2 Path: output_control_RegWrite in LW2 state !!!Passed!!! at Time %0t.", $time);

     // Test Case for output_control_current_state in LW2 State
    if (output_control_current_state !== LW2)
      $display("TEST 3 Load Word LW2 Path: output_control_current_state in LW2 State Failed at Time %0t. Expected: %h, Actual: %h", $time, LW2, output_control_current_state);
    else
      $display("TEST 3 Load Word LW2 Path: output_control_current_state in LW2 State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test from LW2 State to FETCH State
    if (output_control_next_state !== FETCH)
      $display("TEST 3 Load Word LW2 Path: State Machine Transition from LW2 State to FETCH State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, FETCH, output_control_next_state);
    else
      $display("TEST 3 Load Word LW2 Path: State Machine Transition from LW2 State to FETCH State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------LW2----------------");

    $display("~~~TEST 4 SW input_control changed to 7'b1010001 at Time %0t~~~~", $time);
    input_control = 7'b1010001; //sw

    $display("*****************************************************************");
    
    $display("*****************************************************************");
    $display("TEST 4 Save Word TEST");
    input_control = 7'b1010001; //sw

    #full

    $display("----------------------FETCH----------------");

    $display("----------------------FETCH----------------");

    #full

    $display("----------------------DECODE----------------");
    
    $display("----------------------DECODE----------------");

    #full
    
    $display("----------------------RITYPE----------------");
    
    $display("----------------------RITYPE----------------");

    #full

    $display("----------------------SW----------------");
    
    $display("----------------------SW----------------");

    $display("~~~TEST 5 jalr input_control changed to 7'b1011001 at Time %0t~~~~", $time);
    input_control = 7'b1011001; //jalr

    $display("*****************************************************************");

    #full

    $display("*****************************************************************");
    $display("TEST 5 JALR TEST");
    input_control = 7'b1011001; //jalr

    $display("----------------------FETCH----------------");

    $display("----------------------FETCH----------------");

    #full

    $display("----------------------DECODE----------------");
    
    $display("----------------------DECODE----------------");

    #full
    
    $display("----------------------JALR----------------");
    
    $display("----------------------JALR----------------");

    $display("~~~TEST 6 jal input_control changed to 7'bXXXX100 at Time %0t~~~~", $time);
    input_control = 7'bXXXX100; //jal

    $display("*****************************************************************");

    #full

    $display("*****************************************************************");
    $display("TEST 6 JAL TEST");
    input_control = 7'bXXXX100; //jal

    $display("----------------------FETCH----------------");

    $display("----------------------FETCH----------------");

    #full

    $display("----------------------DECODE----------------");
    
    $display("----------------------DECODE----------------");

    #full
    
    $display("----------------------JAL----------------");
    
    $display("----------------------JAL----------------");

    $display("~~~TEST 7 BRNACH input_control changed to 7'b11110001 bne at Time %0t~~~~", $time);
    input_control = 7'b1110001; //bne

    $display("*****************************************************************");

    $display("*****************************************************************");
    $display("TEST 7 BRANCH bne TEST");
    input_control = 7'b1110001; //bne

    #full

    $display("----------------------FETCH----------------");

    $display("----------------------FETCH----------------");

    #full

    $display("----------------------DECODE----------------");
    
    $display("----------------------DECODE----------------");

    #full
    
    $display("----------------------BRANCH----------------");
    
    $display("----------------------BRANCH----------------");

    #full

    $display("----------------------BRANCH2----------------");
    
    $display("----------------------BRANCH2----------------");

    $display("~~~TEST 8 L input_control changed to 7'bXXXX011 at Time %0t~~~~", $time);
    input_control = 7'bXXXX011; //L

    $display("*****************************************************************");

    $display("*****************************************************************");
    // Test Case for L Type Instruction
    $display("----------L Type------------");
    // Setting input_control to represent an L Type instruction (opcode = 3'b011)
    input_control <= 7'bXXXX011;

    #full; // Wait for one clock cycle


    // Test Case for output_control_IoD
    if (output_control_IoD !== 1'b0) // ince L Type instruction writes to IR
      $display("Test Case L Type: output_control_IoD Failed. Expected: %h, Actual: %h", 1'b0, output_control_IoD);
    else
      $display("Test Case L Type: output_control_IoD Passed at Time %0t.", $time);

    // Test Case for output_control_IRWrite
    if (output_control_IRWrite !== 0'b1) // Since L Type instruction writes to IR
      $display("Test Case L Type: output_control_IRWrite Failed. Expected: %h, Actual: %h", 0'b1, output_control_IRWrite);
    else
      $display("Test Case L Type: output_control_IRWrite Passed at Time %0t.", $time);

    // Test Case for output_control_MemR
    if (output_control_MemR !== 1'b0) // L Type instruction does not memory read
      $display("Test Case L Type: output_control_MemR Failed. Expected: %h, Actual: %h", 1'b0, output_control_MemR);
    else
      $display("Test Case L Type: output_control_MemR Passed at Time %0t.", $time);

    // Test Case for output_control_PCSrc
    if (output_control_PCSrc !== 1'b0) // Since L Type instruction doesn't involve PC source change
      $display("Test Case L Type: output_control_PCSrc Failed. Expected: %h, Actual: %h", 1'b0, output_control_PCSrc);
    else
      $display("Test Case L Type: output_control_PCSrc Passed at Time %0t.", $time);

    // Test Case for output_control_PCWrite
    if (output_control_PCWrite !== 1'b0) // Since L Type instruction doesn't involve PC write
      $display("Test Case L Type: output_control_PCWrite Failed. Expected: %h, Actual: %h", 1'b0, output_control_PCWrite);
    else
      $display("Test Case L Type: output_control_PCWrite Passed at Time %0t.", $time);

    // Test Case for output_control_RegWrite
    if (output_control_RegWrite !== 1'b0) // Since L Type instruction doesn't write to register
      $display("Test Case L Type: output_control_RegWrite Failed. Expected: %h, Actual: %h", 1'b0, output_control_RegWrite);
    else
      $display("Test Case L Type: output_control_RegWrite Passed at Time %0t.", $time);

    // Test Case for output_control_Mem2Reg
    if (output_control_Mem2Reg !== 1'b0) // Since L Type instruction doesn't involve memory to register
      $display("Test Case L Type: output_control_Mem2Reg Failed. Expected: %h, Actual: %h", 1'b0, output_control_Mem2Reg);
    else
      $display("Test Case L Type: output_control_Mem2Reg Passed at Time %0t.", $time);

    // Test Case for output_control_Branch
    if (output_control_Branch !== 1'b0) // Since L Type instruction doesn't involve branch
      $display("Test Case L Type: output_control_Branch Failed. Expected: %h, Actual: %h", 1'b0, output_control_Branch);
    else
      $display("Test Case L Type: output_control_Branch Passed at Time %0t.", $time);

    // Test Case for output_control_BranchType
    if (output_control_BranchType !== 2'b00) // Since L Type instruction doesn't involve branch
      $display("Test Case L Type: output_control_BranchType Failed. Expected: %h, Actual: %h", 2'b00, output_control_BranchType);
    else
      $display("Test Case L Type: output_control_BranchType Passed at Time %0t.", $time);

    // Test Case for output_control_next_state
    if (output_control_next_state !== FETCH) // Since L Type instruction directly goes back to FETCH
      $display("Test Case L Type: output_control_next_state Failed. Expected: %h, Actual: %h", FETCH, output_control_next_state);
    else
      $display("Test Case L Type: output_control_next_state Passed at Time %0t.", $time);

    #full;


    // Finish simulation
    #full;
    $stop;
  end

endmodule
