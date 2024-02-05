module mux2to1 (
  input wire a[15:0],
  input wire b[15:0],
  input wire select,
  output reg out[15:0]
);

   assign y = (select) ? b : a;

endmodule
