// File: alu-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`include "../alu.v"

module alu_tb;

  reg clk = 0;      // clock
  reg [31:0] inA;   // input A
  reg [31:0] inB;   // input B
  reg [3:0] funct;  // function code to decide ALU operation

  wire [31:0] out;  // resulting value from operation
  wire zero;        // zero flag

  // assign variables
  alu alu(
    .clk(clk),
    .inA(inA),
    .inB(inB),
    .funct(funct),
    .out(out),
    .zero(zero)
    );

  // clock alternates every unit of time
  always begin
    #1 clk = ~clk;
  end

  // testing block
  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);

    funct <= 4'b0001; //funct code for BITWISE OR
    // out should be all 1s
    inA <= 32'b00000000_00000000_11111111_11111111;
    inB <= 32'b11111111_11111111_00000000_00000000;
    #5;

    funct <= 4'b0000;  //funct code for BITWISE AND
    // out == 0 and zero == 1
    inA <= 32'b00000000_00000000_11111111_11111111;
    inB <= 32'b11111111_11111111_00000000_00000000;
    #5;

    funct <= 4'b0010; //funct code for ADDITION
    // out should be all 1s
    inA <= 32'b00000000_00000000_11111111_11111111;
    inB <= 32'b11111111_11111111_00000000_00000000;
    #5;

    funct <= 4'b0011;  //funct code for SUBTRACTION
    // output should be 0x8BADF00D
    inA <= 32'h9E7BDF1D;
    inB <= 32'h12CDEF10;
    #5;

    funct <= 4'b0100; //funct code for BITWISE XOR
    // output should be 0x0000FF00
    inA <= 32'b01010101_10101010_11111111_10101010;
    inB <= 32'b01010101_10101010_00000000_10101010;
    #5;

    $finish;
  end

endmodule
