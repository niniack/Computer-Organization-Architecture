// File: sign-extend.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 25 2019

`ifndef SIGN_EXTEND_V
`define SIGN_EXTEND_V

module sign_extend (in, out);

  // input wires
  input wire [15:0] in;
  // input wire clk;

  //output wires
  output reg [31:0] out;

  always@(*) begin
    out <= { {16{in[15]}}, in[15:0] };
  end

endmodule

`endif
