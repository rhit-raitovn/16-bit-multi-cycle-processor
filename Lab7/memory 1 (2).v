// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module memory 
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=10)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input we, clk,
	
	output [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[0:2**ADDR_WIDTH-1];
	//reg [DATA_WIDTH-1:0] ram[0:16];//I WROTE THIS LINE TO SEE IF IT WOULD WORK (IT  PROBABLY DOESN'T) THE LINE ABOVE IS THE ORIGIONAL PROVIDED
	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	
	initial begin
    $readmemh("C:/Users/pearcyln/Downloads/memory 1.txt", ram);
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
