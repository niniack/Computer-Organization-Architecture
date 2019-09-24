// File: program-counter.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 25 2019

`ifndef PROGRAM_COUNTER_V
`define PROGRAM_COUNTER_V

module program_counter (clk, rst, out, in);

  input wire clk;            //clock
  input wire rst;            //reset
  input wire [31:0] in;      //input address
  output reg [31:0] out;     //output address


  always@(posedge clk) begin

    if (rst) begin
      out <= 32'b0;
    end

    // assign value of in to out
    else begin
      out <= in;
    end
    
  end

endmodule

`endif
