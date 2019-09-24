// File: program-counter-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`include "../program-counter.v"

module program_counter_tb;

  reg clk = 0;                  //clock
  wire rst = 0;                 //reset
  reg [31:0] nextAddress;       //input address
  wire [31:0] currentAddress;   //output address

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

    // expected output: 0x00F9CAF2
    nextAddress <= 32'b00000000_11111001_11001010_11101110;
    #10;
    // expected output: 0xFFF9CAF2
    nextAddress <= 32'b11111111_11111001_11001010_11101110;
    #10;
    // expected output: 0x00F9CA04
    nextAddress <= 32'b00000000_11111001_11001010_00000000;
    #10;
    // expected output: 0x80898A72
    nextAddress <= 32'b10000000_10001001_10001010_01101110;
    $finish;
  end

endmodule
