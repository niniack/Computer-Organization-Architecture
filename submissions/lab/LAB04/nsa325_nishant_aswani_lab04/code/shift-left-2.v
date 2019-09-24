// File: shift-left-2.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 25 2019

`ifndef SHIFT_LEFT_2_V
`define SHIFT_LEFT_2_V

module shift_left_2 (clk, in, out);

// input wires
input wire [31:0] in;
input wire clk;

//output wires
output reg [31:0] out;

always@(*) begin
  out <= in<<2;
end

endmodule

`endif
