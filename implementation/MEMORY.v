/*******************************************************************************
Module: MEMORY

Author: Yueqiao Wang
Date: 1/21/2024

Description:
This Verilog module represents a simple memory with read and write operations. It includes a 16-bit memory array with 64K addresses. The module takes inputs for memory write enable, memory address, and data to be written. It also takes a clock input and provides a 16-bit data output from the specified memory address.

Module Ports:
- input input_mem_write: Single-bit input indicating when a write instruction is enabled.
- input [15:0] input_mem_addr: 16-bit input representing the memory address for read or write operations.
- input [15:0] input_mem_data: 16-bit input representing the data to be written into the memory when a write instruction is enabled.
- input CLK: Clock input.

- output reg [15:0] output_mem_data: 16-bit data from the memory at the specified address.

Memory Array:
- reg [15:0] memory [0:65535]: 16-bit memory with 64K addresses.

Memory Read and Write Operations:
- The module performs memory read and write operations on the rising edge of the clock.
- If input_mem_write is asserted, it performs a write operation, writing input_mem_data to the specified memory address.
- If input_mem_write is deasserted, it performs a read operation, providing the data from the memory at the specified address as output_mem_data.

*******************************************************************************/

module MEMORY(
    input input_mem_write,
    input [15:0] input_mem_addr,
    input [15:0] input_mem_data,
    input CLK,
    output reg [15:0] output_mem_data
);

// Define memory array
reg [15:0] memory [0:65535];

// Memory read and write operations
always @(posedge CLK)
begin
    if (input_mem_write) // Write operation
        memory[input_mem_addr] <= input_mem_data;
    else // Read operation
        output_mem_data <= memory[input_mem_addr];
end

endmodule
