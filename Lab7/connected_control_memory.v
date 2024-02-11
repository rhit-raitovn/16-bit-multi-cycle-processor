module connected_control_memory(
	input wire CLK,
	input wire [15:0] PC,
	input wire [15:0] datain,
	
	output wire  ALUSrc,
   output wire  MemtoReg,
   output wire  RegWrite,
   output wire  MemRead,
   output wire  MemWrite,
   output wire  Branch,
   output wire  [2:0] ALUOp
	);

wire[15:0] inst;
	
memory mem(
	.data(datain),
	.addr(PC),
	.we(MemWrite), 
	.clk(CLK),	
	.q(inst)
);



BlockMemoryControl bmc(	  
	  .ALUSrc(ALUSrc),
	  .MemtoReg(MemtoReg),
	  .RegWrite(RegWrite), 
	  .MemRead(MemRead),
	  .MemWrite(MemWrite),
	  .Branch(Branch),
	  .ALUOp(ALUOp),
	  .Opcode(inst[7:0]),
	  .CLK(CLK),
	  .Reset(0)
	  );
endmodule