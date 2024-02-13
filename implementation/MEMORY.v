// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module memory 
(
	input [15:0] data,
	input [15:0] addr,
	input we, clk,
	
	output [15:0] q
);
parameter ADDR_WIDTH=10;
	// Declare the RAM variable
	reg [9:0] ram[0:2**ADDR_WIDTH-1];

	// Variable to hold the registered read address
	reg [15:0] addr_reg;

	
	initial begin
		$display("atempting to find memory.mem");
    		$readmemh("memory.mem", ram);
	end
	
	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data;

		   addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr_reg];

endmodule
