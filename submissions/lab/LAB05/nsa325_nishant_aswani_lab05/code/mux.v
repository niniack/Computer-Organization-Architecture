// File: mux.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 02 2019

`ifndef MUX_V
`define MUX_V

module mux #(parameter N=32) (inA, inB, out, select);

  // input wires
  input wire [N-1: 0] inA;
  input wire [N-1: 0] inB;
  input wire select;

  // output wire
  output wire [N-1: 0] out;

  // output selection using unary operator
  assign out = select? inB : inA;

endmodule

`endif
