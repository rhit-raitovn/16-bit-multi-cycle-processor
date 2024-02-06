module mux2to1 (
  input wire [15:0] a,
  input wire [15:0] b,
  input wire select,
  output reg [15:0] out
);

  always @(*) begin
    if (select)
      out = b;
    else
      out = a;
  end

endmodule
