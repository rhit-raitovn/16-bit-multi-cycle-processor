
module PC_tb;
// Inputs
reg input_PCWrite;
reg [15:0] input_newPC;
reg CLK;
reg input_zero;
reg input_negative;
reg [1:0] input_branchType;
reg input_PC_isbranch;

// Outputs
wire [15:0] output_PC;

// Clock generation block
integer i;
initial begin
 CLK = 0;
 for (i = 0; i < 249; i = i + 1) begin
	  #5;
	  CLK = ~CLK; // Toggle clock every half period
 end
end


// Instantiate the UUT
PC uut (
  .input_PCWrite(input_PCWrite),
  .input_newPC(input_newPC),
  .CLK(CLK),
  .input_zero(input_zero),
  .input_negative(input_negative),
  .input_branchType(input_branchType),
  .input_PC_isbranch(input_PC_isbranch),
  .output_PC(output_PC)
);



// Initialize Inputs
initial begin
  // Test 1: PCWrite = 0, no branch, expected output_PC is incremented by 2
  input_PCWrite = 01;
  input_newPC = 16'h0000;
  input_zero = 0;
  input_negative = 0;
  input_branchType = 2'b00;
  input_PC_isbranch = 0;
  #10;
  input_PCWrite = 0;
  input_newPC = 16'h1111;
  input_zero = 0;
  input_negative = 0;
  input_branchType = 2'b00;
  input_PC_isbranch = 0;
  #10
  $display("PC is %h", output_PC);
  if (output_PC !== 16'h0000)
		$display("Test Case 1 Failed. Expected: %h, Actual: %h", 16'h0000, output_PC);
  else
		$display("Test Case 1 Passed");

  // Test 2: PCWrite = 1, PC is set to newPC, expected output_PC is input_newPC
  input_PCWrite = 1;
  input_newPC = 16'h1234;
  input_zero = 0;
  input_negative = 0;
  input_branchType = 2'b00;
  input_PC_isbranch = 0;
  #10;
  $display("PC is %h", output_PC);
  if (output_PC !== 16'h1234)
		$display("Test Case 2 Failed. Expected: %h, Actual: %h", 16'h1234, output_PC);
  else
		$display("Test Case 2 Passed");

  // Test 3: PCWrite = 1, branch type is beq, ALU output is zero
  input_PCWrite = 1;
  input_newPC = 16'h0010;
  input_zero = 1;
  input_negative = 0;
  input_branchType = 2'b00;
  input_PC_isbranch = 1;
  #10;
  $display("PC is %h", output_PC);
  if (output_PC !== 16'h0010)
		$display("Test Case 3 Failed. Expected: %h, Actual: %h", 16'h0010, output_PC);
  else
		$display("Test Case 3 Passed");
		
	// Test 4: PCWrite = 1, branch type is blt, No branch 
  input_PCWrite = 1;
  input_newPC = 16'h0014;
  input_zero = 1;
  input_negative = 1;
  input_branchType = 2'b01;
  input_PC_isbranch = 1;
  #10;
  $display("PC is %h", output_PC);
  if (output_PC !== 16'h0014)
		$display("Test Case 4 Failed. Expected: %h, Actual: %h", 16'h0014, output_PC);
  else
		$display("Test Case 4 Passed");
		
	// Test 5: PCWrite = 1, branch type is blt, Yes branch 
  input_PCWrite = 1;
  input_newPC = 16'h0054;
  input_zero = 0;
  input_negative = 0;
  input_branchType = 2'b01;
  input_PC_isbranch = 1;
  #10;
  $display("PC is %h", output_PC);
  if (output_PC !== 16'h0054)
		$display("Test Case 4 Failed. Expected: %h, Actual: %h", 16'h0054, output_PC);
  else
		$display("Test Case 4 Passed");
		
	// Test 5: PCWrite = 1, branch type is blt, Yes branch 
  input_PCWrite = 1;
  input_newPC = 16'h0054;
  input_zero = 0;
  input_negative = 0;
  input_branchType = 2'b01;
  input_PC_isbranch = 1;
  #10;
  $display("PC is %h", output_PC);
  if (output_PC !== 16'h0054)
		$display("Test Case 5 Failed. Expected: %h, Actual: %h", 16'h0054, output_PC);
  else
		$display("Test Case 5 Passed");
  $stop;
end
endmodule
