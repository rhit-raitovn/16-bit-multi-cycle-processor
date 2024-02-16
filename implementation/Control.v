/*
 * Module: control
 * Description: This module implements the control logic for lime. It generates control signals
 *              based on the current state and input control signals. The module defines various states
 *              such as Fetch, Decode, RType3, RIType, RTypeEnd, lw1, lw2, sw, JALR, BRANCH, BRANCH2,
 *              and JAL. It utilizes sequential logic to transition between states and assigns output
 *              control signals accordingly. The module takes input control signals, clock signal (CLK),
 *              and reset signal (Reset), and outputs various control signals required for the processor
 *              operation. It also includes combinational logic to calculate ALU operation (ALUOp) and
 *              ALU source (ALUSrcA and ALUSrcB) based on the input control signals.
 *
 * Author: Yueqiao Wang
 * Date: Feb 15, 2024
 * Version: 1.1
 * 
 * Inputs:
 *   - input_control: 7-bit input control signals
 *   - CLK: Clock signal
 *   - Reset: Reset signal
 *
 * Outputs:
 *   - output_control_branch: Branch control signal
 *   - output_control_IoD: Instruction/Data write control signal
 *   - output_control_IRWrite: Instruction register write control signal
 *   - output_control_Mem2Reg: Memory to register control signal
 *   - output_control_MemR: Memory read control signal
 *   - output_control_MemW: Memory write control signal
 *   - output_control_PCSrc: PC source control signal
 *   - output_control_PCWrite: PC write enable control signal
 *   - output_control_RegWrite: Register write control signal
 *   - output_control_ALUSrcA: ALU source A control signal
 *   - output_control_ALUSrcB: ALU source B control signal
 *   - output_control_branchType: Branch type control signal
 *   - output_control_ALUOp: ALU operation control signal
 */



module Control(
  input [6:0] input_control,
  input CLK,
  input Reset,
  output reg [0:0] output_control_Branch,
  output reg [0:0] output_control_IoD,
  output reg [0:0] output_control_IRWrite,
  output reg [0:0] output_control_Mem2Reg,
  output reg [0:0] output_control_MemR,
  output reg [0:0] output_control_MemW,
  output reg [0:0] output_control_PCSrc,
  output reg [0:0] output_control_PCWrite,
  output reg [0:0] output_control_RegWrite,
  output reg [1:0] output_control_ALUSrcA,
  output reg [1:0] output_control_ALUSrcB,
  output reg [1:0] output_control_BranchType,
  output reg [3:0] output_control_ALUOp,

  output reg [3:0] output_control_current_state,
  output reg [3:0] output_control_next_state
);


//state flip-flops
reg [3:0]    current_state;
reg [3:0]    next_state;

//state definitions
parameter    Fetch = 0;
parameter    Decode = 1;
parameter    RType = 2;
parameter    RIType = 3;
parameter    RTypeEnd = 4;
parameter    LW1 = 5;
parameter    LW2 = 6;
parameter    SW = 7;
parameter    JALR = 8;
parameter    BRANCH = 9;
parameter    BRANCH2 = 10;
parameter    JAL = 11;


//register calculation
always @ (posedge CLK, posedge Reset)
  begin
    if (Reset)
      current_state = Fetch;
    else 
  current_state = next_state;
end

reg [3:0] ALUOp;
reg [1:0] branchType;

// ALUOp Calculation
always @ (*) begin
    case(input_control[6:3])
        4'b0000: ALUOp = 4'b0000; // add
        4'b0001: ALUOp = 4'b0001; // subtract
        4'b0010: ALUOp = 4'b0010; // and
        4'b0011: ALUOp = 4'b0011; // or
        4'b0100: ALUOp = 4'b0100; // xor
        4'b0101: ALUOp = 4'b0101; // shift left logical
        4'b0110: ALUOp = 4'b0110; // shift right logical
        4'b0111: ALUOp = 4'b0111; // shift left arithmetic
        4'b1000: ALUOp = 4'b1000; // shift right arithmetic
        default: ALUOp = 4'bxxxx; // default value for undefined inputs
    endcase
end

always @ (*) begin
  branchType = input_control[4:3];
end


//OUTPUT signals for each state (depends on current state)
always @ (current_state)
  begin

  //Reset all signals that cannot be don't cares
  output_control_ALUOp = 4'b1111;
  output_control_ALUSrcA = 2'b00;
  output_control_ALUSrcB = 2'b00;
  output_control_Branch = 1'b0;
  output_control_BranchType = 2'b00;
  output_control_IoD = 1'b0;
  output_control_IRWrite = 1'b0;
  output_control_Mem2Reg = 1'b0;
  output_control_MemR = 1'b0;
  output_control_MemW = 1'b0;
  output_control_PCSrc = 1'b0;
  output_control_PCWrite = 1'b0;
  output_control_RegWrite = 1'b0;

  case (current_state)
    Fetch: begin
      output_control_ALUOp = 4'b0000; // "+"
      output_control_ALUSrcA = 0;
      output_control_ALUSrcB = 1;
      output_control_IoD = 0;
      output_control_IRWrite = 1;
      output_control_MemR = 0;
      output_control_PCSrc = 0;
      output_control_PCWrite = 1;
    end

    Decode: begin
      output_control_IRWrite = 0;
      output_control_MemR = 0;
      output_control_PCWrite = 0;
    end

    RType: begin
      output_control_ALUOp = ALUOp;
      output_control_ALUSrcA = 2;
      output_control_ALUSrcB = 0;
    end

    RIType: begin
      // Define behavior for RI-type instruction category
      // This could be similar to the behavior of other RI-type instructions
      output_control_ALUOp = ALUOp;
      output_control_ALUSrcA = 2;
      output_control_ALUSrcB = 2;
    end

    RTypeEnd: begin
      // Behavior at the end of R-type instructions
      output_control_Mem2Reg = 0;
      output_control_RegWrite = 1;
    end

    LW1: begin
      // Define behavior for the first load word instruction
      output_control_IoD = 1;
      output_control_MemR = 1;
    end

    LW2: begin
      // Define behavior for the second load word instruction
      output_control_Mem2Reg = 1;
      output_control_RegWrite = 1;
    end

    SW: begin
      // Define behavior for the store word instruction
      output_control_IoD = 1;
      output_control_MemW = 1;
    end

    JALR: begin
      // Define behavior for the jump and link register instruction
      output_control_ALUOp = 4'b0111;
      output_control_ALUSrcA = 3;
      output_control_ALUSrcB = 1;
      output_control_Mem2Reg = 0;
      output_control_RegWrite = 1;
    end

    BRANCH: begin
      output_control_ALUOp = 4'b1001;
      output_control_ALUSrcA = 0;
      output_control_ALUSrcB = 2;
      output_control_Branch = 1;
      output_control_BranchType = branchType;
    end

    BRANCH2: begin
      // Define behavior for the second branch instruction category
      output_control_ALUOp = 4'b0001;
      output_control_ALUSrcA = 2;
      output_control_ALUSrcB = 0;
      output_control_Branch = 1;
      output_control_BranchType = branchType;
      output_control_PCSrc = 1;
      output_control_PCWrite = 1;

    end

    JAL: begin
      // Define behavior for the jump and link instruction
      output_control_PCWrite = 1;
      output_control_ALUSrcA = 3;
      output_control_ALUSrcB = 1;
      output_control_ALUOp = 4'b0111;
    end
  endcase
end

//NEXT STATE calculation (depends on current state and opcode)       
always @ (current_state, next_state, input_control) begin         
  $display("The current state is %d", current_state);
  case (current_state)
    Fetch: begin
      next_state = Decode;
      $display("In Fetch, the next_state is %d", next_state);
    end

    Decode: begin       
      $display("The opcode is %d", input_control[2:0]);
      case (input_control[2:0])

        3'b000: begin
          $display("3R Type Instruction");
          next_state = RType;
          $display("The next state is RType");
        end

        3'b001: begin
          case (input_control[6:3])

            4'b1011: begin
              $display("2RI JALR Instruction");
              next_state = JALR;
              $display("The next state is JALR");
            end

            4'b1100: begin
              $display("2RI Branch Instruction");
              next_state = BRANCH;
              $display("The next state is BRANCH");
            end

            4'b1101: begin
              $display("2RI BRANCH Instruction");
              next_state = BRANCH;
              $display("The next state is BRANCH");
            end

            4'b1110: begin
              $display("2RI BRANCH Instruction");
              next_state = BRANCH;
              $display("The next state is BRANCH");
            end

            4'b1111: begin
              $display("2RI BRANCH Instruction");
              next_state = BRANCH;
              $display("The next state is BRANCH");
            end

            default: begin
              $display("2RI Normal Instruction");
              next_state = RIType;
              $display("The next state is RIType");
            end
          endcase 
        end

        3'b010: begin
          $display("RI Type Instruction");
          next_state = RIType;
          $display("The next state is RIType");
        end

        3'b011: begin
          $display("L Type Instruction");
          next_state = Fetch;
          $display("The next state is Fetch");
        end

        3'b100: begin
          $display("UJ Type Instruction");
          next_state = JAL;
          $display("The next state is JAL");
        end

      endcase  

      $display("In Decode, the next_state is %d", next_state);
    end

    RType: begin
      next_state = RTypeEnd;
      $display("In RType, the next_state RTypeEnd is %d", next_state);
    end

    RTypeEnd: begin
      next_state = Fetch;
      $display("In RTypeEnd, the next_state Fetch is %d", next_state);
    end

    RIType: begin
      case(input_control[6:3])
        4'b1001: begin
          next_state = LW1;
          $display("In RIType, lw instruction, the next_state LW1 is %d", next_state);
        end

        4'b1010: begin
          next_state = SW;
          $display("In RIType, SW instruction, the next_state SW is %d", next_state);
        end

        default: begin
          next_state = RTypeEnd;
          $display("In RIType, normal calculation instruction, the next_state RTypeEnd is %d", next_state);
        end

      endcase
    end

    SW: begin
      next_state = Fetch;
      $display("In SW, the next_state Fetch is %d", next_state);
    end

    LW1: begin
      next_state = LW2;
      $display("In LW1, the next_state LW2 is %d", next_state);
    end

    LW2: begin
      next_state = Fetch;
      $display("In LW2, the next_state Fetch is %d", next_state);
    end

    JAL: begin
      next_state = Fetch;
      $display("In JAL, the next_state Fetch is %d", next_state);
    end

    JALR: begin
      next_state = Fetch;
      $display("In JALR, the next_state Fetch is %d", next_state);
    end

    BRANCH: begin
      next_state = BRANCH2;
      $display("In BRANCH, the next_state BRANCH2 is %d", next_state);
    end

    BRANCH2: begin
      next_state = Fetch;
      $display("In JALR, the next_state Fetch is %d", next_state);
    end

    default: begin
      $display("Error State!");
      next_state = Fetch;
    end

  endcase
  output_control_current_state <= current_state;
  output_control_next_state <= next_state;
  $display("After the tests, the next_state is %d", next_state);
end



endmodule