module tb_connected_control_memory_tb;

    // Inputs to the connected_control_memory
    reg CLK;
    reg [15:0] PC;
    reg [15:0] datain;

    // Outputs from the connected_control_memory
    wire ALUSrc;
    wire MemtoReg;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire Branch;
    wire [2:0] ALUOp;

    // Instantiate the Unit Under Test (UUT)
    connected_control_memory UUT (
        .CLK(CLK),
        .PC(PC),
        .datain(datain),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    // Clock generation
    parameter HALF_PERIOD = 50;
    always #(HALF_PERIOD) CLK = ~CLK;

    initial begin
        // Initialize Inputs
        CLK = 0;
        PC = 0;
        datain = 0;

        // Wait for global reset
        #100;

        // Test for an R-Type instruction
        PC=1;
        #100; // Wait for a clock cycle
        check_control_signals(0, 0, 1, 0, 0, 0, 3'b000); // Expected for R-type

        // Test for an I-Type instruction (SW)
        PC=2;
		  datain=420;
        #100;
        check_control_signals(1, 1, 1, 1, 0, 0, 3'b000); // Expected for LW

        // Test for an S-Type instruction (LW)
        PC=3;
		  datain=420;
        #100;
        check_control_signals(1, 0, 0, 0, 1, 0, 3'b000); // Expected for SW

        // Test for a Branch-Type instruction (BEQ)
        PC=4;
        #100;
        check_control_signals(0, 0, 0, 0, 0, 1, 3'b001); // Expected for BEQ

        // End simulation
        $stop;
    end

    // Task to check control signals
    task check_control_signals;
        input expectedALUSrc;
        input expectedMemtoReg;
        input expectedRegWrite;
        input expectedMemRead;
        input expectedMemWrite;
        input expectedBranch;
        input [2:0] expectedALUOp;
        begin
            if (ALUSrc !== expectedALUSrc ||
                MemtoReg !== expectedMemtoReg ||
                RegWrite !== expectedRegWrite ||
                MemRead !== expectedMemRead ||
                MemWrite !== expectedMemWrite ||
                Branch !== expectedBranch ||
                ALUOp !== expectedALUOp) begin
                $display("Assertion failed at time %t", $time);
            end
            else begin
                $display("Test passed for datain %h at time %t", datain, $time);
            end
        end
    endtask

endmodule
