// File: top-level-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 02 2019

`include "top-level.v"

module top_level_tb ();

  reg clk = 1'b0;              // clock
  reg rst = 1'b0;              // reset

  // assign variables
  top_level tl(
    .clk(clk),
    .rst(rst)
    );

  always begin
    #1 clk = ~clk;
  end

  initial begin
    $dumpfile("top-level.vcd");
    $dumpvars(0, top_level_tb);
    rst = 1'b1;
    #5;
    rst = 1'b0;
    #45;
    $finish;
  end
endmodule
