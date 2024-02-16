`timescale 1ns / 1ps // Define timescale for simulation
module lime_tb();

reg [15:0] main_input;
wire [15:0] main_output;

TheLime uut(
	.main_input(main_input),
	.main_output(main_output)
);

initial begin
	//test 1 relprime
	main_input=16'h0006;
	#1000;
	if(main_output!==16'h0005)
		$display("lime processor test failed :( output was: 0x%h",main_output);
	else
		$display("TEST PASSED! :)");
	$stop;
end

endmodule