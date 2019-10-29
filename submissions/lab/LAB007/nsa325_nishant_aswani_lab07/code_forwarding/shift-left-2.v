// File: shift-left-2.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 09 2019

`ifndef SHIFT_LEFT_2_V
`define SHIFT_LEFT_2_V

module shift_left_2 #(parameter N=32) (clk, in, out);

// input wires
input wire [N-1: 0] in;
input wire clk;

//output wires
output reg [31: 0] out;

always@(*) begin
  out <= in<<2;
end

endmodule

`endif
