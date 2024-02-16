// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module memory_component 
(
	input [15:0] data,
	input [15:0] addr,
	input we, clk,
	
	
	input wire[15:0] processor_input,
	output reg[15:0] processor_output,

	output reg [15:0] q
);
parameter ADDR_WIDTH=10;
	// Declare the RAM variable
	reg [15:0] ram[0:2**ADDR_WIDTH-1];

	// Variable to hold the registered read address
	reg [15:0] addr_reg;

	
	initial begin
		$display("atempting to find memory.txt");
		
		//CHANGE THIS FILEPATH //should be readmemh for hex and redmemb for binary
    		$readmemb("C:/Users/pearcyln/OneDrive - Rose-Hulman Institute of Technology/Documents/GitHub/rhit-csse232-2324b-project-lime-2324b-02/implementation/memory.txt", ram);//opens file here
	end
	
	always @ (negedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data;
		
		//get new address
		addr_reg <= addr;

		//check if address is valid for 10 bit ram
		if(addr[15:10]!==6'b000000 && addr!==16'b1111110000000000) 
			$display("EXCEPTION IN MEMORY: the memory address 0x%h is invalid for 10 bit adressed ram component and was not special input/output address(first 6 bits are ignored)",addr);
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	

	always @ (*) begin
		case (addr) 
			16'b1111110000000000: begin
				if(we) 
				   processor_output = data;
				q = processor_input;
			end
			
			default: begin
				q = ram[addr_reg];
			end
		endcase
	end

endmodule
