/*******************************************************************************
* Author: Naziia Raitova
* Date: 2/15/2024
*
* Module: The Lime
*
*******************************************************************************/
`timescale 1ns / 1ps // Define timescale for simulation
module TheLime(
  input wire [15:0] main_input, //main input
  output wire [15:0] main_output, // main output
  output reg CLK
);

initial CLK=1;
always begin
  #5 
  CLK=~CLK;
  $display("~~~~~~~~Half Cycle Passed~~~~~~~");
  end

// Control signals
wire IRWrite;
wire IorD;
wire PCSrc;
wire PCWrite;
wire [1:0] ALUSrcA;
wire [1:0] ALUSrcB;
wire [1:0] branchType;
wire [3:0] ALUOp;
wire branch;
wire decoding;
wire mem2reg;
wire memR;
wire memW;
wire regWrite;

wire carry;
wire negative;
wire reset;
wire zero;
    
//wire [15:0] input_from_ALUOut;
wire [15:0] Output_IR_Imm;
wire [15:0] output_MDR;
wire [15:0] output_PC;
wire [2:0] Output_IR_RegA;
wire [2:0] Output_IR_RegB;
wire [2:0] Output_IR_RegD;
wire [6:0] Output_IR_Control;


wire [3:0] output_control_current_state;
wire [3:0] output_control_next_state;

// wire output_Zero;
// wire output_negative;

// For Data
wire [15:0] output_reg_A;
wire [15:0] output_reg_B;
wire [15:0] output_imm;

  
// For Calculations
wire [15:0] output_ALUOut;
wire [15:0] output_ALUMuxOut;
wire [15:0] output_B_sr;

Control control_inst (
  // Inputs
  .input_control(Output_IR_Control),
  .CLK(CLK),
  .Reset(reset),
        
  // Outputs
  .output_control_ALUOp(ALUOp),
  .output_control_ALUSrcA(ALUSrcA),
  .output_control_ALUSrcB(ALUSrcB),
  .output_control_Branch(branch),
  .output_control_BranchType(branchType),
  .output_control_Decoding(decoding),
  .output_control_IRWrite(IRWrite),
  .output_control_IoD(IorD),
  .output_control_Mem2Reg(mem2reg),
  .output_control_MemR(memR),
  .output_control_MemW(memW),
  .output_control_PCSrc(PCSrc),
  .output_control_PCWrite(PCWrite),
  .output_control_RegWrite(regWrite),
  .output_control_current_state(output_control_current_state),
  .output_control_next_state(output_control_next_state)
);
  
FetchAndMemory fetch_and_memory_inst (
  // External inputs and output
  .CLK(CLK),
  .IorD(IorD),
  .input_IR_write(IRWrite),
  .input_PC_PCWrite(PCWrite),
  .input_PC_isbranch(branch),
  .input_PC_newPC(output_ALUMuxOut),
  .input_branchType(branchType),
  .input_from_ALUOut(output_ALUOut),
  .input_mem_data(output_B_sr),
  .input_mem_write(memW),
  .input_negative(negative),
  .input_zero(zero),
  
  .Output_IR_Control(Output_IR_Control),
  .Output_IR_Imm(Output_IR_Imm),
  .Output_IR_RegA(Output_IR_RegA),
  .Output_IR_RegB(Output_IR_RegB),
  .Output_IR_RegD(Output_IR_RegD),
  .output_MDR(output_MDR),
  .output_PC(output_PC),

  .processor_input(main_input),
  .processor_output(main_output)
);


Data data_inst (
  // Inputs
  .CLK(CLK),
  .input_ALUOut(output_ALUOut),
  .input_MDR(output_MDR),
  .input_branch(branch),
  .input_imm(Output_IR_Imm),
  .input_reg_readA_address(Output_IR_RegA),
  .input_reg_readB_address(Output_IR_RegB),
  .input_reg_write(regWrite),
  .input_reg_write_address(Output_IR_RegD),
  .memToReg(mem2reg),
        
  // Outputs
  .output_imm(output_imm),
  .output_reg_A(output_reg_A),
  .output_reg_B(output_reg_B)
);
  

Calculations calculations_inst (
  // Inputs
  .clk(CLK),
  .input_A(output_reg_A),
  .input_ALUOp(ALUOp),
  .input_ALUSrcA(ALUSrcA),
  .input_ALUSrcB(ALUSrcB),
  .input_B(output_reg_B),
  .input_PC(output_PC),
  .input_PCSrc(PCSrc),
  .input_imm(output_imm),
  .input_keep_ALUOut(decoding),
  .reset(reset),
  
  // Outputs
  .output_ALUMuxOut(output_ALUMuxOut),
  .output_ALUOut_sr(output_ALUOut),
  .output_B_sr(output_B_sr),
  .output_Zero(zero),
  .output_carry(carry),
  .output_negative(negative)
);

endmodule
