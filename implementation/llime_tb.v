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
	//test 1 relprime
	main_input=16'h13b0;
	//#500;
	//if(main_output!==16'h0005)
	//	$display("lime processor test failed :( output was: 0x%h",main_output);
	//else
	//	$display("TEST PASSED! :)");
	//$stop;
	@(main_output==16'h000b);
	$display(cycleCount/2);
#10
	$stop;
end



endmodule