module mux3to1 (
  input wire a[15:0],
  input wire b[15:0],
  input wire c[15:0],
  input wire select,
  output wire out[15:0]
);

  assign out = (select == 2'b00) ? a :
            (select == 2'b01) ? b :
            (select == 2'b10) ? c :
            1'bx; // Output is undefined for select values other than 0, 1, or 2

endmodule
