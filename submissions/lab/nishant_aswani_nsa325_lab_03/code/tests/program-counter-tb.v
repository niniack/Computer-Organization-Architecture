// File: program-counter-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`include "../program-counter.v"

module program_counter_tb;

  reg clk = 0;
  wire rst = 0;
  reg [31:0] nextAddress = 32'b11101110_11111001_11001010_11101110;
  wire [31:0] currentAddress;

  program_counter pc(
    .clk(clk),
    .rst(rst),
    .nextAddress(nextAddress),
    .currentAddress(currentAddress)
  );

  always begin
    #1 clk = ~clk;
  end

  initial begin
    $dumpfile("program-counter.vcd");
    $dumpvars(0, program_counter_tb);

    nextAddress <= 32'b00000000_11111001_11001010_11101110;
    #10;
    nextAddress <= 32'b11111111_11111001_11001010_11101110;
    #10;
    nextAddress <= 32'b00000000_11111001_11001010_11101110;
    #10;
    nextAddress <= 32'b11111111_11111001_11001010_11101110;
    $finish;
  end

endmodule
