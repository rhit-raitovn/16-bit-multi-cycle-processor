module(
   input reg input_PC_PCWrite, 
   input reg [15:0] input_PC_newPC,
   input reg CLK,

  output reg [15:0] output_PC
);

initial begin
  CLK=0;
  forever #5 CLK =~CLK;
end

endmodule
