// File: alu.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`ifndef ALU_V
`define ALU_V

module alu(clk, inA, inB, funct, zero, out);

  input wire clk;         // clock
  input wire [31:0] inA;  // input A
  input wire [31:0] inB;  // input B
  input wire [3:0] funct; // function code to decide ALU operation

  output reg [31:0] out;  // resulting value from operation
  output wire zero;       // zero flag

  always @(posedge clk) begin
    case (funct)
      4'b0000 : out <= inA & inB; // code 0 does a bitwise and
      4'b0001 : out <= inA | inB; // code 1 does a bitwise or
      4'b0010 : out <= inA + inB; // code 2 does addition
      4'b0011 : out <= inA - inB; // code 3 does subtraction
      4'b0100 : out <= inA ^ inB; // code 4 does a bitwise XOR
    endcase
  end

  assign zero = (out==0) ? 1:0;   // if out == 0, then raise zero flag

endmodule
`endif
