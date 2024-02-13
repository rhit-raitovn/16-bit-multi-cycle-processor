/*******************************************************************************
* Author: Yueqiao Wang
* Date: 02/13/2024
*
* Module: Control Unit
*
* Description:
*   A control unit that decodes the opcode and funct4 of an
*   instruction to generate control signals for various components.
*
* Inputs:
*   input wire [6:0] input_control // Input opcode + funct4
*
* Outputs:
*   output wire [0:0] output_branch // 1 if it's a branch instruction, 0 otherwise.
*   output wire [0:0] output_memRead // 1 if reading from memory, 0 otherwise.
*   output wire [2:0] output_ALUOp // ALU operation (+, -, and, or, ...)
*   output wire [0:0] output_memWrite // 1 if writing to memory, 0 otherwise.
*   output wire [0:0] output_ALUSrc // 1 if using immediate, 0 otherwise.
*   output wire [0:0] output_regWrite // 1 if the instruction involves writing to a register, 0 otherwise.
*   output wire [1:0] output_branchType // Specifies the type of branch instruction 
*
*******************************************************************************/
module contol(
    input [6:0] input_control,
    output [0:0] output_control_PCWrite,
    output [0:0] output_control_IoD,
    output [0:0] output_control_MemR,
    output [0:0] output_control_MemW,
    output [0:0] output_control_IRWrite,
    output [0:0] output_control_Mem2Reg,
    output [0:0] output_control_RegWrite,
    output [1:0] output_control_ALUSrcA,
    output [1:0] output_control_ALUSrcB,
    output [2:0] output_control_ALUOp,
    output [0:0] output_control_PCSrc,
    output [0:0] output_control_branch,
    output [1:0] output_control_branchType,
    input CLK,
    input Reset
);

reg [0:0] output_control_PCWrite;
reg [0:0] output_control_IoD;
reg [0:0] output_control_MemR;
reg [0:0] output_control_MemW;
reg [0:0] output_control_IRWrite;
reg [0:0] output_control_Mem2Reg;
reg [0:0] output_control_RegWrite;
reg [1:0] output_control_ALUSrcA;
reg [1:0] output_control_ALUSrcB;
reg [2:0] output_control_ALUOp;
reg [0:0] output_control_PCSrc;
reg [0:0] output_control_branch;
reg [1:0] output_control_branchType;

   //-- You can add these state registers to the IO pins in the module
   //-- declaration and uncomment the output statements here if you want, but
   //-- Quartus won't identify this as a State Machine with the state
   //-- registers as inputs or outputs.
   //output [3:0] current_state;
   //output [3:0] next_state;

   input [5:0]  Opcode;
   input        CLK;
   input        Reset;

   //state flip-flops
   reg [3:0]    current_state;
   reg [3:0]    next_state;

   //state definitions
   parameter    Fetch = 0;
   parameter    Decode = 1;
   parameter    3RType = 2;
   parameter    RIType = 3;
   parameter    RTypeEnd = 4;
   parameter    lw1 = 5;
   parameter    lw2 = 6;
   parameter    sw = 7;
   parameter    jalr = 8;
   parameter    branch = 9;
   parameter    branch2 = 10;
   parameter    jal = 11;


   //register calculation
   always @ (posedge CLK, posedge Reset)
     begin
        if (Reset)
          current_state = Fetch;
        else 
          current_state = next_state;
     end


   //OUTPUT signals for each state (depends on current state)
   always @ (current_state)
     begin
        //Reset all signals that cannot be don't cares
        output_control_PCWrite = 1'b0;
        output_control_IoD = 1'b0;
        output_control_MemR = 1'b0;
        output_control_MemW = 1'b0;
        output_control_IRWrite = 1'b0;
        output_control_Mem2Reg = 1'b0;
        output_control_RegWrite = 1'b0;
        output_control_ALUSrcA = 2'b00;
        output_control_ALUSrcB = 2'b00;
        output_control_ALUOp = 3'b111; // 
        output_control_PCSrc = 1'b0;
        output_control_branch = 1'b0;
        output_control_branchType = 2'b00;
        
        case (current_state)
          Fetch: begin
            output_control_ALUOp = 3'b000; // "+"
            output_control_ALUSrcA = 0;
            output_control_ALUSrcB = 1;
            output_control_PCSrc = 0;
            output_control_PCWrite = 1;
            output_control_IRWrite = 1;
            output_control_IoD = 0;
            output_control_MemR = 0;
          end

          Decode: begin
            output_control_PCWrite = 0;
            output_control_IRWrite = 0;
            output_control_MemR = 0;
          end

          RType3: begin
              
          end

          RIType: begin
              // Define behavior for RI-type instruction category
              // This could be similar to the behavior of other RI-type instructions
          end

          RTypeEnd: begin
              // Behavior at the end of R-type instructions
          end

          LW1: begin
              // Define behavior for the first load word instruction
          end

          LW2: begin
              // Define behavior for the second load word instruction
          end

          SW: begin
              // Define behavior for the store word instruction
          end

          JALR: begin
              // Define behavior for the jump and link register instruction
          end

          Branch: begin
              // Define behavior for the branch instruction
          end

          Branch2: begin
              // Define behavior for the second branch instruction category
          end
          
          JAL: begin
              // Define behavior for the jump and link instruction
          end
      endcase
  end
                
   //NEXT STATE calculation (depends on current state and opcode)       
   always @ (current_state, next_state, Opcode)
     begin         

        $display("The current state is %d", current_state);
        
        case (current_state)
          
          Fetch:
            begin
               next_state = Decode;
               $display("In Fetch, the next_state is %d", next_state);
            end
          
          Decode: 
            begin       
               $display("The opcode is %d", Opcode);
               case (Opcode)
                 0:
                   begin
                      next_state = R_Execution;
                      $display("The next state is R");
                   end
                 2:
                   begin
                      next_state = Jump;
                      $display("The next state is Jump");
                   end
                 4:
                   begin
                      next_state = Branch;
                      $display("The next state is Branch");
                   end
                 35:
                   begin
                      next_state = Mem1;
                      $display("The next state is Mem");
                   end
                 43:
                   begin next_state = Mem1;
                      $display("The next state is Mem");
                   end
                 default:
                   begin 
                      $display(" Wrong Opcode %d ", Opcode);  
                      next_state = Fetch; 
                   end
               endcase  
               
               $display("In Decode, the next_state is %d", next_state);
            end
          
          R_Execution:
            begin
               next_state = R_Write;
               $display("In R_Exec, the next_state is %d", next_state);
            end
          
          R_Write:
            begin
               next_state = Fetch;
               $display("In R_Write, the next_state is %d", next_state);
            end
          
          Branch:
            begin
               next_state = Fetch;
               $display("In Branch, the next_state is %d", next_state);
            end

          Mem1:
            begin
               //not implemented - forcing return to cycle 1
               next_state = Fetch;
               $display("In Mem1, the next_state is %d", next_state);
            end
          
          Jump:
            begin
               next_state = Fetch;
               $display("In Jump, the next_state is %d", next_state);
            end
          
          default:
            begin
               $display(" Not implemented!");
               next_state = Fetch;
            end
          
        endcase
        
        $display("After the tests, the next_state is %d", next_state);
                
     end

endmodule