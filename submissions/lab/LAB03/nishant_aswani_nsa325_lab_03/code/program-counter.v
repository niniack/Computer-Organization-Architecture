// File: program-counter.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`ifndef PROGRAM_COUNTER_V
`define PROGRAM_COUNTER_V

module program_counter (clk, rst, nextAddress, currentAddress);

  input wire clk;                      //clock
  input wire rst;                      //reset
  input wire [31:0] nextAddress;       //input address
  output reg [31:0] currentAddress;    //output address

  always@(posedge clk) begin
    // increment pc by 4
    currentAddress <= nextAddress + 4;
  end

endmodule

`endif
