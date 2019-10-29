// File: pipe-register.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 09 2019

`ifndef PIPE_REG_V
`define PIPE_REG_V

module pipe_register #(parameter N=32) (clk, rst, hold, clear, in, out);


  // control wires

  input clk;
  input rst;
  input hold;
	input clear;

  //registers

  input wire [N-1:0] in;
  output reg [N-1:0] out;

  always @(posedge clk) begin
    if (clear || rst) begin
      out <= {N{1'b0}};
    end

    else if (hold) begin
      out <= out;
    end

    else begin
      out <= in;
    end
  end


endmodule
`endif
