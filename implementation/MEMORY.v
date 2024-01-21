module MEMORY(
    input input_mem_write, // Single-bit input indicating when a write instruction is enabled.
    input [15:0] input_mem_addr, // 16-bit input representing the memory address for read or write operations.
    input [15:0] input_mem_data, // 16-bit input representing the data to be written into the memory when a write instruction is enabled.
    input CLK, // Clock input
    
    output reg [15:0] output_mem_data // 16-bit data from the memory at the specified address.
);

// Define memory array
reg [15:0] memory [0:65535]; // 16-bit memory with 64K addresses

// Memory read and write operations
always @(posedge CLK)
begin
    if (input_mem_write) // Write operation
        memory[input_mem_addr] <= input_mem_data;
    else // Read operation
        output_mem_data <= memory[input_mem_addr];
end

endmodule
