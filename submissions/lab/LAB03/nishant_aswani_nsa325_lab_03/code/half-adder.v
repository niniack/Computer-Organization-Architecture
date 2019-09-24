// File: half-adder.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`ifndef HALF_ADDER_V
`define HALF_ADDER_V

module half_adder (a,b,sum,carry);

  input wire a;
  input wire b;
  output wire sum;
  output wire carry;

  assign sum = a ^ b;
  assign carry = a & b;

endmodule

`endif
