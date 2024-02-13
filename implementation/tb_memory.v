module tb_memory;

wire [15:0] output_q;

MEMORY uut(
	.data(16'b0),
	.addr(10'b0),
	.we(1'b0), 
	.clk(1'b0),
	
	.q(output_q)
);

endmodule