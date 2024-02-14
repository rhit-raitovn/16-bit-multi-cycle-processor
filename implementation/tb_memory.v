module tb_memory;

//inputs
reg [15:0] input_data;
reg [15:0] input_addr;
reg input_write;
reg CLK;

//outputs
wire [15:0] output_q;

memory_component uut(
	.data(input_data),
	.addr(input_addr),
	.we(input_write), 
	.clk(CLK),
	
	.q(output_q)
);


// Clock generation
    initial CLK=0;
  always begin
    #5 CLK = ~CLK; // Toggle the clock every 5 time units
  end

initial begin
	//TEST 0 mem is properly loaded
	input_addr=16'h0000;
	input_write=1'b0;
	#10;
	if(output_q!==16'hdead)
		$display("FAIL test 0 in memory_component: adress 0 was expected to be hexadecimal value 'dead' but was: %h (if this is all X's the memory did not load, make sure filepath is correct)",output_q);
	
	//TEST 1 write to mem
	input_addr=16'h0001;
	input_write=1'b1;
	input_data=16'h0420;
	#10;
	if(output_q!==16'h0420)
		$display("FAIL test 1 in memory_component: atempt to write hexadecimal value 420 to address 1 failed, output was:%h",output_q);
	
	//TEST 2 read from address previously written to
	input_addr=16'h0000;
	#10;
	input_addr=16'h0001;
	#10;
	if(output_q!==16'h0420)
		$display("FAIL test 2 in memory_component: adress 1 did not keep hex value 420, output was:%h",output_q);

	$stop;

end

endmodule