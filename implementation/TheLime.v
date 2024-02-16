/*******************************************************************************
* Author: Naziia Raitova
* Date: 2/15/2024
*
* Module: The Lime
*
*******************************************************************************/

module TheLime(
  input wire [15:0] main_input, //main input
  output reg [15:0] main_output // main output
);

// Control signals
wire PCWrite;
wire IorD;
wire memR;
wire memW;
wire mem2reg;
wire regWrite;
wire IRWrite;
wire [1:0] ALUSrcA;
wire [1:0] ALUSrcB;
wire [2:0] ALUOp;
wire PCSrc;
wire branch;
wire [1:0] branchType;

wire CLK;
wire reset;
wire zero;
wire negative;
wire carry;
    
wire [15:0] output_PC;
wire [6:0] Output_IR_Control;
wire [2:0] Output_IR_RegA;
wire [2:0] Output_IR_RegB;
wire [2:0] Output_IR_RegD;
wire [15:0] Output_IR_Imm;
wire [15:0] input_from_ALUOut;
wire [15:0] output_MDR;
wire [15:0] input_mem_data;

// wire output_Zero;
// wire output_negative;

Control control_inst (
  // Inputs
  .input_control(input_control),
  .CLK(CLK),
  .Reset(reset),
        
  // Outputs
  .output_control_PCWrite(PCWrite),
  .output_control_IoD(IoD),
  .output_control_MemR(memR),
  .output_control_MemW(memW),
  .output_control_IRWrite(IRWrite),
  .output_control_Mem2Reg(mem2reg),
  .output_control_RegWrite(regWrite),
  .output_control_ALUSrcA(ALUSrcA),
  .output_control_ALUSrcB(ALUSrcB),
  .output_control_ALUOp(ALUOp),
  .output_control_PCSrc(PCSrc),
  .output_control_branch(branch),
  .output_control_branchType(branchType),
  
  .output_control_current_state(output_control_current_state),
  .output_control_next_state(output_control_next_state)
);
  
FetchAndMemory fetch_and_memory_inst (
  // External inputs and output
  .input_PC_PCWrite(PCWrite),
  .input_PC_newPC(output_ALUMuxOut),
  .CLK(CLK),
  .input_zero(zero),
  .input_negative(negative),
  .input_branchType(branchType),
  .input_PC_isbranch(branch),
  .input_IR_write(IRWrite),
  .input_from_ALUOut(output_ALUOut),
  .IorD(IorD),
  .input_mem_write(memW),
  .input_mem_data(output_B_sr),
  
  .output_PC(output_PC),
  .Output_IR_Control(Output_IR_Control),
  .Output_IR_RegA(Output_IR_RegA),
  .Output_IR_RegB(Output_IR_RegB),
  .Output_IR_RegD(Output_IR_RegD),
  .Output_IR_Imm(Output_IR_Imm),
  .output_MDR(output_MDR),
);

wire [15:0] output_reg_A;
wire [15:0] output_reg_B;
wire [15:0] output_imm;
wire [15:0] ALUOut;
  
Data data_inst (
  // Inputs
  .input_reg_readA_address(Output_IR_RegA),
  .input_reg_readB_address(Output_IR_RegB),
  .input_reg_write(regWrite),
  .input_reg_write_address(Output_IR_RegD),
  .CLK(CLK),
  .input_imm(Output_IR_Imm),
  .input_ALUOut(output_ALUOut),
  .input_MDR(output_MDR),
  .memToReg(mem2reg),
  .input_branch(input_branch),
        
  // Outputs
  .output_imm(output_imm),
  .output_reg_A(output_reg_A),
  .output_reg_B(output_reg_B)
);

wire [15:0] output_ALUOut;
wire [15:0] output_ALUMuxOut;
wire [15:0] output_B_sr;
  
Calculations calculations_inst (
  // Inputs
  .input_A(output_reg_A),
  .input_B(output_reg_B),
  .input_ALUOp(ALUOp),
  .input_PC(output_PC),
  .input_ALUSrcA(ALUSrcA),
  .input_ALUSrcB(ALUSrcB),
  .input_PCSrc(PCSrc),
  .input_imm(output_imm),
  .clk(CLK),
  .set(reset),
  
  // Outputs
  .output_ALU_sr(output_ALUOut),
  .output_ALUMuxOut(output_ALUMuxOut),
  .output_Zero(zero),
  .output_negative(negative),
  .output_carry(carry),
  .outut_B_sr(output_B_sr),
);

endmodule
