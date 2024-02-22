/*
 * Module: Control
 * Description: This module implements the control logic for lime processor, generating control signals
 *              based on the current state and input control signals. It defines various operational states
 *              such as FETCH, DECODE, RTYPE, RITYPE, RTYPEEND, LW1, LW2, SW, JALR, BRANCH, BRANCH2,
 *              and JAL. Using sequential logic, it transitions between these states and assigns output
 *              control signals to manage the processor's operation. Combinational logic calculates the ALU
 *              operation (ALUOp) and the sources for the ALU (ALUSrcA and ALUSrcB) based on the input
 *              control signals. The module interfaces with both the processor's datapath and the clock
 *              system, responding to the clock signal (CLK) and a reset signal (Reset) to ensure timely
 *              and correct execution of instructions.
 *
 * Author: Yueqiao Wang
 * Date: Feb 20, 2024
 * Version: 2.0
 * 
 * Inputs:
 *   - input_control [6:0]: 7-bit input control signals for instruction decoding and control flow management.
 *   - CLK: Clock signal for synchronizing the control logic operations.
 *   - Reset: Reset signal for initializing the control logic to a known state, typically the FETCH state.
 *
 * Outputs:
 *   - output_control_ALUOp [3:0]: Control signal defining the operation to be performed by the ALU.
 *   - output_control_ALUSrcA [1:0]: Control signal for selecting the source A for the ALU.
 *   - output_control_ALUSrcB [1:0]: Control signal for selecting the source B for the ALU.
 *   - output_control_Branch [0:0]: Control signal for branching decisions.
 *   - output_control_BranchType [1:0]: Control signal indicating the type of branch operation.
 *   - output_control_IoD [0:0]: Control signal for selecting between instruction and data for memory operations.
 *   - output_control_IRWrite [0:0]: Control signal for enabling writing to the instruction register.
 *   - output_control_Mem2Reg [0:0]: Control signal for selecting between memory and ALU results for writing back to the register.
 *   - output_control_MemR [0:0]: Memory read control signal.
 *   - output_control_MemW [0:0]: Memory write control signal.
 *   - output_control_PCSrc [0:0]: Control signal for selecting the source for the Program Counter (PC) update.
 *   - output_control_PCWrite [0:0]: Control signal for enabling writing to the PC.
 *   - output_control_RegWrite [0:0]: Control signal for enabling writing to the register file.
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
  output reg [3:0] output_control_next_state,
  output reg [0:0] output_control_keepALUOut
);


//state flip-flops
reg [3:0]    current_state;
reg [3:0]    next_state;

//state definitions
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

initial current_state = 4'b0000;


//register calculation
always @ (posedge CLK, posedge Reset)
  begin
    if (Reset)
      current_state = FETCH;
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
        4'b1001: ALUOp = 4'b0000; // lw
        4'b1010: ALUOp = 4'b0000; // sw
        4'b1011: ALUOp = 4'bxxxx; // changeable
        4'b1100: ALUOp = 4'b1100; // set
        4'b1101: ALUOp = 4'bxxxx; // changeable
        4'b1111: ALUOp = 4'bxxxx; // changeable
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
  output_control_ALUOp = 4'bxxxx;
  output_control_ALUSrcA = 2'b00;
  output_control_ALUSrcB = 2'b00;
  output_control_Branch = 1'b0;
  output_control_BranchType = 2'b00;
  output_control_keepALUOut = 1'b0;
  output_control_IRWrite = 1'b0;
  output_control_IoD = 1'b0;
  output_control_Mem2Reg = 1'b0;
  output_control_MemR = 1'b0;
  output_control_MemW = 1'b0;
  output_control_PCSrc = 1'b0;
  output_control_PCWrite = 1'b0;
  output_control_RegWrite = 1'b0;

  case (current_state)
    FETCH: begin
      output_control_ALUOp = 4'b0000; // "+"
      output_control_ALUSrcA = 0;
      output_control_ALUSrcB = 1;
      output_control_IoD = 0;
      output_control_IRWrite = 1;
      output_control_MemR = 0;
      output_control_PCSrc = 0;
      output_control_PCWrite = 1;
    end

    DECODE: begin
      output_control_IRWrite = 0;
      output_control_MemR = 0;
      output_control_PCWrite = 0;
      output_control_keepALUOut = 1;
    end

    RTYPE: begin
      output_control_ALUOp = ALUOp;
      output_control_ALUSrcA = 2;
      output_control_ALUSrcB = 0;
    end

    RITYPE: begin
      output_control_ALUOp = ALUOp;
      output_control_ALUSrcA = 2;
      output_control_ALUSrcB = 2;
      output_control_Branch = 1; // speical situation for sw
      output_control_keepALUOut = 0;
    end

    RTYPEEND: begin
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
      // output_control_ALUOp = ALUOp; LUKE AND NAZIA ADDED THIS
      output_control_IoD = 1;
      output_control_MemW = 1;
    end

    JALR: begin
      // Define behavior for the jump and link register instruction
      output_control_ALUOp = 4'b0000; // PC = A + IG
      output_control_ALUSrcA = 2;
      output_control_ALUSrcB = 2;
      output_control_Mem2Reg = 0;
      output_control_PCSrc = 0;
      output_control_PCWrite = 1;
      output_control_RegWrite = 1;
      output_control_keepALUOut = 1;
    end

    BRANCH: begin
      output_control_ALUOp = 4'b0000;
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
      output_control_Mem2Reg = 0;
      output_control_RegWrite = 1;
      output_control_PCWrite = 1;
      output_control_ALUSrcB = 2;
      output_control_ALUOp = 4'b1100;// PC = IG
    end
  endcase
end

//NEXT STATE calculation (depends on current state and opcode)       
always @ (current_state, next_state, input_control) begin         
  ////$display("The current state is %d", current_state);
  case (current_state)
    FETCH: begin
      next_state = DECODE;
      ////$display("In FETCH, the next_state is %d", next_state);
    end

    DECODE: begin       
      ////$display("The opcode is %d", input_control[2:0]);
      case (input_control[2:0])

        3'b000: begin
          ////$display("3R Type Instruction");
          next_state = RTYPE;
          ////$display("The next state is RTYPE");
        end

        3'b001: begin
          case (input_control[6:3])

            4'b1011: begin
              //$display("2RI JALR Instruction");
              next_state = JALR;
              //$display("The next state is JALR");
            end

            4'b1100: begin
              //$display("2RI Branch Instruction");
              next_state = BRANCH;
              //$display("The next state is BRANCH");
            end

            4'b1101: begin
              //$display("2RI BRANCH Instruction");
              next_state = BRANCH;
              //$display("The next state is BRANCH");
            end

            4'b1110: begin
              //$display("2RI BRANCH Instruction");
              next_state = BRANCH;
              //$display("The next state is BRANCH");
            end

            4'b1111: begin
              //$display("2RI BRANCH Instruction");
              next_state = BRANCH;
              //$display("The next state is BRANCH");
            end

            default: begin
              //$display("2RI Normal Instruction");
              next_state = RITYPE;
              //$display("The next state is RITYPE");
            end
          endcase 
        end

        3'b010: begin
          //$display("RI Type Instruction");
          next_state = RITYPE;
          //$display("The next state is RITYPE");
        end

        3'b011: begin
          //$display("L Type Instruction");
          next_state = FETCH;
          //$display("The next state is FETCH");
        end

        3'b100: begin
          //$display("UJ Type Instruction");
          next_state = JAL;
          //$display("The next state is JAL");
        end

      endcase  

      //$display("In DECODE, the next_state is %d", next_state);
    end

    RTYPE: begin
      next_state = RTYPEEND;
      //$display("In RTYPE, the next_state RTYPEEND is %d", next_state);
    end

    RTYPEEND: begin
      next_state = FETCH;
      //$display("In RTYPEEND, the next_state FETCH is %d", next_state);
    end

    RITYPE: begin
      case(input_control[6:3])
        4'b1001: begin
          next_state = LW1;
          //$display("In RITYPE, lw instruction, the next_state LW1 is %d", next_state);
        end

        4'b1010: begin
          next_state = SW;
          //$display("In RITYPE, SW instruction, the next_state SW is %d", next_state);
        end

        default: begin
          next_state = RTYPEEND;
          //$display("In RITYPE, normal calculation instruction, the next_state RTYPEEND is %d", next_state);
        end

      endcase
    end

    SW: begin
      next_state = FETCH;
      //$display("In SW, the next_state FETCH is %d", next_state);
    end

    LW1: begin
      next_state = LW2;
      //$display("In LW1, the next_state LW2 is %d", next_state);
    end

    LW2: begin
      next_state = FETCH;
      //$display("In LW2, the next_state FETCH is %d", next_state);
    end

    JAL: begin
      next_state = FETCH;
      //$display("In JAL, the next_state FETCH is %d", next_state);
    end

    JALR: begin
      next_state = FETCH;
      //$display("In JALR, the next_state FETCH is %d", next_state);
    end

    BRANCH: begin
      next_state = BRANCH2;
      //$display("In BRANCH, the next_state BRANCH2 is %d", next_state);
    end

    BRANCH2: begin
      next_state = FETCH;
      //$display("In JALR, the next_state FETCH is %d", next_state);
    end

    default: begin
      //$display("Error State!");
      next_state = FETCH;
    end

  endcase
  output_control_current_state <= current_state;
  output_control_next_state <= next_state;
  //$display("After the tests, the next_state is %d", next_state);
end



endmodule