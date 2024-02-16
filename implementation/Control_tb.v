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

    $display("*****************************************************************");
    $display("3R Type AND TEST");

    input_control = 7'b0010000; //and

    // Reset generation
    Reset = 1;
    #full;
    Reset = 0;

    // Test 1 3R Type Path

    // Test 1 3R Type Path Fetch
    #half;
    $display("----------------------Fetch----------------");
    // Test Case 1 (3R) Fetch for output_control_ALUOp
    if (output_control_ALUOp !== 4'b0000)
      $display("Test Case 1 (3R) Fetch 1 (3R) Fetch output_control_ALUOp Failed. Expected: %h, Actual: %h", 4'b0000, output_control_ALUOp);
    else
      $display("Test Case 1 (3R) Fetch 1 (3R) Fetch output_control_ALUOp !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) Fetch 1 (3R) Fetch for output_control_ALUSrcA
    if (output_control_ALUSrcA !== 2'b00)
      $display("Test Case 1 (3R) Fetch output_control_ALUSrcA Failed. Expected: %h, Actual: %h", 2'b00, output_control_ALUSrcA);
    else
      $display("Test Case 1 (3R) Fetch output_control_ALUSrcA !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) Fetch for output_control_ALUSrcB
    if (output_control_ALUSrcB !== 2'b01)
      $display("Test Case 1 (3R) Fetch output_control_ALUSrcB Failed. Expected: %h, Actual: %h", 2'b01, output_control_ALUSrcB);
    else
      $display("Test Case 1 (3R) Fetch output_control_ALUSrcB !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) Fetch for output_control_IoD
    if (output_control_IoD !== 1'b0)
      $display("Test Case 1 (3R) Fetch output_control_IoD Failed. Expected: %h, Actual: %h", 1'b0, output_control_IoD);
    else
      $display("Test Case 1 (3R) Fetch output_control_IoD !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) Fetch for output_control_IRWrite
    if (output_control_IRWrite !== 1'b1)
      $display("Test Case 1 (3R) Fetch output_control_IRWrite Failed. Expected: %h, Actual: %h", 1'b1, output_control_IRWrite);
    else
      $display("Test Case 1 (3R) Fetch output_control_IRWrite !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) Fetch for output_control_MemR
    if (output_control_MemR !== 1'b0)
      $display("Test Case 1 (3R) Fetch output_control_MemR Failed. Expected: %h, Actual: %h", 1'b0, output_control_MemR);
    else
      $display("Test Case 1 (3R) Fetch output_control_MemR !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) Fetch for output_control_PCSrc
    if (output_control_PCSrc !== 1'b0)
      $display("Test Case 1 (3R) Fetch output_control_PCSrc Failed. Expected: %h, Actual: %h", 1'b0, output_control_PCSrc);
    else
      $display("Test Case 1 (3R) Fetch output_control_PCSrc !!!Passed!!! at Time %0t.", $time);

    // Test Case 1 (3R) Fetch for output_control_PCWrite
    if (output_control_PCWrite !== 1'b1)
      $display("Test Case 1 (3R) Fetch output_control_PCWrite Failed. Expected: %h, Actual: %h", 1'b1, output_control_PCWrite);
    else
      $display("Test Case 1 (3R) Fetch output_control_PCWrite !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state
    if (output_control_current_state !== Fetch)
      $display("Test Case 1 (3R) Fetch output_control_current_state Failed. Expected: %h, Actual: %h", Fetch, output_control_current_state);
    else
      $display("Test Case 1 (3R) Fetch: output_control_current_state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_next_state
    if (output_control_next_state !== Decode)
      $display("Test Case 1 (3R) Fetch for output_control_next_state Failed. Expected: %h, Actual: %h", Decode, output_control_next_state);
    else
      $display("Test Case 1 (3R) Fetch for output_control_next_state !!!Passed!!! at Time %0t.", $time);
    $display("----------------------Fetch----------------");
    #full
    $display("----------------------Decode----------------");
    //Test 1 3R Type Path Decode

    // Test Case for output_control_IRWrite
    if (output_control_IRWrite !== 1'b0)
      $display("Test Case 1 (3R) for output_control_IRWrite in Decode state Failed. Expected: %h, Actual: %h", 1'b0, output_control_IRWrite);
    else
      $display("Test Case 1 (3R) for output_control_IRWrite in Decode state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_MemR
    if (output_control_MemR !== 1'b0)
      $display("Test Case 1 (3R) for output_control_MemR in Decode state Failed. Expected: %h, Actual: %h", 1'b0, output_control_MemR);
    else
      $display("Test Case 1 (3R) for output_control_MemR in Decode state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCWrite
    if (output_control_PCWrite !== 1'b0)
      $display("Test Case 1 (3R) for output_control_PCWrite in Decode state Failed. Expected: %h, Actual: %h", 1'b0, output_control_PCWrite);
    else
      $display("Test Case 1 (3R) for output_control_PCWrite in Decode state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in Decode State
    if (output_control_current_state !== Decode)
      $display("Test Case 1 (3R) for output_control_current_state in Decode State Failed. Expected: %h, Actual: %h", Decode, output_control_current_state);
    else
      $display("Test Case 1 (3R) for output_control_current_state in Decode State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for Decode State
    if (output_control_next_state !== RType)
      $display("Test Case 1 (3R) State Machine Transition Test for Decode State Failed. Next State Expected: %h, Actual: %h", RType, output_control_next_state);
    else
      $display("Test Case 1 (3R) State Machine Transition Test for Decode State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------Decode----------------");
    #full
    $display("----------------------RType----------------");
    //Test 1 3R Type Path RType
    // Test Case for output_control_ALUOp in RType State
    if (output_control_ALUOp !== 4'b0010)
      $display("Test Case for output_control_ALUOp in RType state Failed. Expected: %h, Actual: %h", 4'b0010, output_control_ALUOp);
    else
      $display("Test Case for output_control_ALUOp in RType state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcA in RType State
    if (output_control_ALUSrcA !== 2'b10)
      $display("Test Case for output_control_ALUSrcA in RType state Failed. Expected: %h, Actual: %h", 2'b10, output_control_ALUSrcA);
    else
      $display("Test Case for output_control_ALUSrcA in RType state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcB in RType State
    if (output_control_ALUSrcB !== 2'b00)
      $display("Test Case for output_control_ALUSrcB in RType state Failed. Expected: %h, Actual: %h", 2'b00, output_control_ALUSrcB);
    else
      $display("Test Case for output_control_ALUSrcB in RType state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in RType State
    if (output_control_current_state !== RType)
      $display("Test Case for output_control_current_state in RType State Failed. Expected: %h, Actual: %h", RType, output_control_current_state);
    else
      $display("Test Case for output_control_current_state in RType State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for RType State
    if (output_control_next_state !== RTypeEnd)
      $display("Test Case for State Machine Transition in RType State Failed. Next State Expected: %h, Actual: %h", RTypeEnd, output_control_next_state);
    else
      $display("Test Case for State Machine Transition in RType State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------RType----------------");
    #full
    $display("----------------------RTypeEnd----------------");
    //Test 1 3R Type Path RTypeEnd
    // Test Case for output_control_Mem2Reg in RTypeEnd State
    if (output_control_Mem2Reg !== 1'b0)
      $display("Test Case for output_control_Mem2Reg in RTypeEnd state Failed. Expected: %h, Actual: %h", 1'b0, output_control_Mem2Reg);
    else
      $display("Test Case for output_control_Mem2Reg in RTypeEnd state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_RegWrite in RTypeEnd State
    if (output_control_RegWrite !== 1'b1)
      $display("Test Case for output_control_RegWrite in RTypeEnd state Failed. Expected: %h, Actual: %h", 1'b1, output_control_RegWrite);
    else
      $display("Test Case for output_control_RegWrite in RTypeEnd state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in RTypeEnd State
    if (output_control_current_state !== RTypeEnd)
      $display("Test Case for output_control_current_state in RTypeEnd State Failed. Expected: %h, Actual: %h", RTypeEnd, output_control_current_state);
    else
      $display("Test Case for output_control_current_state in RTypeEnd State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for RTypeEnd State
    if (output_control_next_state !== Fetch)
      $display("Test Case for State Machine Transition in RTypeEnd State Failed. Next State Expected: %h, Actual: %h", Fetch, output_control_next_state);
    else
      $display("Test Case for State Machine Transition in RTypeEnd State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------RTypeEnd----------------");
    input_control = 7'b0101001; //slli
    $display("~~~TEST 2 input_control changed at Time %0t~~~~", $time);

    $display("Test 1 3R Type Path !!!Passed!!! Entirely at Time %0t.", $time);
    $display("*****************************************************************");

    $display("*****************************************************************");
    $display("TEST 2 Normal 2RI Type slli TEST");
    input_control = 7'b0101001; //slli
    #full
    $display("----------------------Fetch----------------");
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

    // Test Case for output_control_current_state in Fetch State
    if (output_control_current_state !== Fetch)
      $display("TEST 2 Normal 2RI Type slli: output_control_current_state in Fetch State Failed at Time %0t. Expected: %h, Actual: %h", $time, Fetch, output_control_current_state);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_current_state in Fetch State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for Fetch State
    if (output_control_next_state !== Decode)
      $display("TEST 2 Normal 2RI Type slli: State Machine Transition Test for Fetch State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, Decode, output_control_next_state);
    else
      $display("TEST 2 Normal 2RI Type slli: State Machine Transition Test for Fetch State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------Fetch----------------");

    #full

    $display("----------------------Decode----------------");
    // Test Case for output_control_IRWrite in Decode State
    if (output_control_IRWrite !== 1'b0)
      $display("TEST 2 Normal 2RI Type slli: output_control_IRWrite in Decode state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_IRWrite);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_IRWrite in Decode state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_MemR in Decode State
    if (output_control_MemR !== 1'b0)
      $display("TEST 2 Normal 2RI Type slli: output_control_MemR in Decode state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_MemR);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_MemR in Decode state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCWrite in Decode State
    if (output_control_PCWrite !== 1'b0)
      $display("TEST 2 Normal 2RI Type slli: output_control_PCWrite in Decode state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_PCWrite);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_PCWrite in Decode state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in Decode State
    if (output_control_current_state !== Decode)
      $display("TEST 2 Normal 2RI Type slli: output_control_current_state in Decode State Failed at Time %0t. Expected: %h, Actual: %h", $time, Decode, output_control_current_state);
    else
      $display("TEST 2 Normal 2RI Type slli: output_control_current_state in Decode State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for Decode State
    if (output_control_next_state !== RIType)
      $display("TEST 2 Normal 2RI Type slli: State Machine Transition Test for Decode State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, RIType, output_control_next_state);
    else
      $display("TEST 2 Normal 2RI Type slli: State Machine Transition Test for Decode State !!!Passed!!! at Time %0t.", $time);

    $display("----------------------Decode----------------");

    #full

    $display("----------------------RIType----------------");

    // Test Case for output_control_ALUOp in RIType State
    if (output_control_ALUOp !== 4'b0101)
      $display("TEST 2 RI Type Path RIType: output_control_ALUOp in RIType state Failed at Time %0t. Expected: %h, Actual: %h", $time, 4'b0101, output_control_ALUOp);
    else
      $display("TEST 2 RI Type Path RIType: output_control_ALUOp in RIType state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcA in RIType State
    if (output_control_ALUSrcA !== 2'b10)
      $display("TEST 2 RI Type Path RIType: output_control_ALUSrcA in RIType state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b10, output_control_ALUSrcA);
    else
      $display("TEST 2 RI Type Path RIType: output_control_ALUSrcA in RIType state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcB in RIType State
    if (output_control_ALUSrcB !== 2'b10)
      $display("TEST 2 RI Type Path RIType: output_control_ALUSrcB in RIType state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b10, output_control_ALUSrcB);
    else
      $display("TEST 2 RI Type Path RIType: output_control_ALUSrcB in RIType state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in RIType State
    if (output_control_current_state !== RIType)
      $display("TEST 2 RI Type Path RIType: output_control_current_state in RIType State Failed at Time %0t. Expected: %h, Actual: %h", $time, RIType, output_control_current_state);
    else
      $display("TEST 2 RI Type Path RIType: output_control_current_state in RIType State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test from RIType State to RTypeEnd State
    if (output_control_next_state !== RTypeEnd)
      $display("TEST 2 RI Type Path RIType: State Machine Transition from RIType State to RTypeEnd State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, RTypeEnd, output_control_next_state);
    else
      $display("TEST 2 RI Type Path RIType: State Machine Transition from RIType State to RTypeEnd State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------RIType----------------");

    #full

    $display("----------------------RTypeEnd----------------");
    // Test Case for output_control_Mem2Reg in RTypeEnd State
    if (output_control_Mem2Reg !== 1'b0)
      $display("TEST 2 RTypeEnd Path: output_control_Mem2Reg in RTypeEnd state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_Mem2Reg);
    else
      $display("TEST 2 RTypeEnd Path: output_control_Mem2Reg in RTypeEnd state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_RegWrite in RTypeEnd State
    if (output_control_RegWrite !== 1'b1)
      $display("TEST 2 RTypeEnd Path: output_control_RegWrite in RTypeEnd state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_RegWrite);
    else
      $display("TEST 2 RTypeEnd Path: output_control_RegWrite in RTypeEnd state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in RTypeEnd State
    if (output_control_current_state !== RTypeEnd)
      $display("TEST 2 RTypeEnd Path: output_control_current_state in RTypeEnd State Failed at Time %0t. Expected: %h, Actual: %h", $time, RTypeEnd, output_control_current_state);
    else
      $display("TEST 2 RTypeEnd Path: output_control_current_state in RTypeEnd State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test from RTypeEnd State to Fetch State
    if (output_control_next_state !== Fetch)
      $display("TEST 2 RTypeEnd Path: State Machine Transition from RTypeEnd State to Fetch State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, Fetch, output_control_next_state);
    else
      $display("TEST 2 RTypeEnd Path: State Machine Transition from RTypeEnd State to Fetch State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------RTypeEnd----------------");
    input_control = 7'b1001001; //lw
    $display("~~~TEST 3 input_control changed to 7'b1001001 at Time %0t~~~~", $time);

    $display("*****************************************************************");

    

    $display("*****************************************************************");
    $display("TEST 3 Load Word TEST");
    input_control = 7'b1001001; //lw
    #full

    $display("----------------------Fetch----------------");

    // Test Case for Fetch State
    // Test Case for output_control_ALUOp in Fetch State
    if (output_control_ALUOp !== 4'b0000)
      $display("TEST 3 Load Word TEST: output_control_ALUOp in Fetch state Failed at Time %0t. Expected: %h, Actual: %h", $time, 4'b0000, output_control_ALUOp);
    else
      $display("TEST 3 Load Word TEST: output_control_ALUOp in Fetch state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcA in Fetch State
    if (output_control_ALUSrcA !== 2'b00)
      $display("TEST 3 Load Word TEST: output_control_ALUSrcA in Fetch state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b00, output_control_ALUSrcA);
    else
      $display("TEST 3 Load Word TEST: output_control_ALUSrcA in Fetch state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_ALUSrcB in Fetch State
    if (output_control_ALUSrcB !== 2'b01)
      $display("TEST 3 Load Word TEST: output_control_ALUSrcB in Fetch state Failed at Time %0t. Expected: %h, Actual: %h", $time, 2'b01, output_control_ALUSrcB);
    else
      $display("TEST 3 Load Word TEST: output_control_ALUSrcB in Fetch state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_IoD in Fetch State
    if (output_control_IoD !== 1'b0)
      $display("TEST 3 Load Word TEST: output_control_IoD in Fetch state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_IoD);
    else
      $display("TEST 3 Load Word TEST: output_control_IoD in Fetch state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_IRWrite in Fetch State
    if (output_control_IRWrite !== 1'b1)
      $display("TEST 3 Load Word TEST: output_control_IRWrite in Fetch state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_IRWrite);
    else
      $display("TEST 3 Load Word TEST: output_control_IRWrite in Fetch state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_MemR in Fetch State
    if (output_control_MemR !== 1'b0)
      $display("TEST 3 Load Word TEST: output_control_MemR in Fetch state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_MemR);
    else
      $display("TEST 3 Load Word TEST: output_control_MemR in Fetch state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCSrc in Fetch State
    if (output_control_PCSrc !== 1'b0)
      $display("TEST 3 Load Word TEST: output_control_PCSrc in Fetch state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_PCSrc);
    else
      $display("TEST 3 Load Word TEST: output_control_PCSrc in Fetch state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCWrite in Fetch State
    if (output_control_PCWrite !== 1'b1)
      $display("TEST 3 Load Word TEST: output_control_PCWrite in Fetch state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b1, output_control_PCWrite);
    else
      $display("TEST 3 Load Word TEST: output_control_PCWrite in Fetch state !!!Passed!!! at Time %0t.", $time);

    
    // Test Case for output_control_current_state in Fetch State
    if (output_control_current_state !== Fetch)
      $display("TEST 3 Load Word TEST: output_control_current_state in Fetch State Failed at Time %0t. Expected: %h, Actual: %h", $time, Fetch, output_control_current_state);
    else
      $display("TEST 3 Load Word TEST: output_control_current_state in Fetch State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test for Fetch State
    if (output_control_next_state !== Decode)
      $display("TEST 3 Load Word TEST: State Machine Transition Test for Fetch State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, Decode, output_control_next_state);
    else
      $display("TEST 3 Load Word TEST: State Machine Transition Test for Fetch State !!!Passed!!! at Time %0t.", $time);

    $display("----------------------Fetch----------------");
    #full
    $display("----------------------Decode----------------");
    
    // Test Case for output_control_IRWrite in Decode State
    if (output_control_IRWrite !== 1'b0)
      $display("TEST 3 Load Word Path: output_control_IRWrite in Decode state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_IRWrite);
    else
      $display("TEST 3 Load Word Path: output_control_IRWrite in Decode state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_MemR in Decode State
    if (output_control_MemR !== 1'b0)
      $display("TEST 3 Load Word Path: output_control_MemR in Decode state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_MemR);
    else
      $display("TEST 3 Load Word Path: output_control_MemR in Decode state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_PCWrite in Decode State
    if (output_control_PCWrite !== 1'b0)
      $display("TEST 3 Load Word Path: output_control_PCWrite in Decode state Failed at Time %0t. Expected: %h, Actual: %h", $time, 1'b0, output_control_PCWrite);
    else
      $display("TEST 3 Load Word Path: output_control_PCWrite in Decode state !!!Passed!!! at Time %0t.", $time);

    // Test Case for output_control_current_state in Decode State
    if (output_control_current_state !== Decode)
      $display("TEST 3 Load Word Path: output_control_current_state in Decode State Failed at Time %0t. Expected: %h, Actual: %h", $time, Decode, output_control_current_state);
    else
      $display("TEST 3 Load Word Path: output_control_current_state in Decode State !!!Passed!!! at Time %0t.", $time);

    // State Machine Transition Test from Decode State to DECODE State
    if (output_control_next_state !== RIType)
      $display("TEST 3 Load Word Path: State Machine Transition from Decode State to RIType State Failed at Time %0t. Next State Expected: %h, Actual: %h", $time, RIType, output_control_next_state);
    else
      $display("TEST 3 Load Word Path: State Machine Transition from Decode State to RIType State !!!Passed!!! at Time %0t.", $time);
    $display("----------------------Decode----------------");
    #full    
    $display("----------------------RIType----------------");
    
    $display("----------------------RIType----------------");
    #full    
    $display("----------------------LW1----------------");
    
    $display("----------------------LW1----------------");
    #full
    $display("----------------------LW2----------------");
    
    $display("----------------------LW2----------------");

    $display("~~~TEST 4 SW input_control changed to 7'b1010001 at Time %0t~~~~", $time);
    input_control = 7'b1010001; //sw

    $display("*****************************************************************");
    
    $display("*****************************************************************");
    $display("TEST 4 Save Word TEST");
    input_control = 7'b1010001; //sw

    #full

    $display("----------------------Fetch----------------");

    $display("----------------------Fetch----------------");

    #full

    $display("----------------------Decode----------------");
    
    $display("----------------------Decode----------------");

    #full
    
    $display("----------------------RIType----------------");
    
    $display("----------------------RIType----------------");

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

    $display("----------------------Fetch----------------");

    $display("----------------------Fetch----------------");

    #full

    $display("----------------------Decode----------------");
    
    $display("----------------------Decode----------------");

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

    $display("----------------------Fetch----------------");

    $display("----------------------Fetch----------------");

    #full

    $display("----------------------Decode----------------");
    
    $display("----------------------Decode----------------");

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

    $display("----------------------Fetch----------------");

    $display("----------------------Fetch----------------");

    #full

    $display("----------------------Decode----------------");
    
    $display("----------------------Decode----------------");

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
    if (output_control_next_state !== Fetch) // Since L Type instruction directly goes back to Fetch
      $display("Test Case L Type: output_control_next_state Failed. Expected: %h, Actual: %h", Fetch, output_control_next_state);
    else
      $display("Test Case L Type: output_control_next_state Passed at Time %0t.", $time);

    #full;


    // Finish simulation
    #full;
    $stop;
  end

endmodule
