module mux2to1 (
  input wire a,
  input wire b,
  input wire select,
  output reg out
);

  always @(posedge select)
    if (select)
      out <= b;
    else
      out <= a;

endmodule
