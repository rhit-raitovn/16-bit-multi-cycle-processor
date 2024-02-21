`timescale 1ns / 1ps // Define timescale for simulation
module lime_tb();

reg [15:0] main_input;
wire [15:0] main_output;
wire internalClock;
reg CLK;

TheLime uut(
	.main_input(main_input),
	.main_output(main_output),
	.CLK(CLK)
);

integer cycleCount=0;



always begin
  #5 
  CLK=~CLK;
  cycleCount=cycleCount+1;
 end


initial begin
	CLK=1;
	$display("Testing Processor");
	//test 1 relprime
	main_input=30;
	@(main_output==5);
	main_input=16'h0906;	
	$display("Test 1 Success after %d cycles",cycleCount/2);

	//test 2 relprime
	cycleCount=0;
	@(main_output==16'h000d);
	main_input=0030;
	$display("Test 2 Success after %d cycles",cycleCount/2);
	

	//test 3 relprime
	cycleCount=0;
	@(main_output==16'h0005);
	$display("Test 3 Success after %d cycles",cycleCount/2);
	
	#10
	$stop;
end



endmodule