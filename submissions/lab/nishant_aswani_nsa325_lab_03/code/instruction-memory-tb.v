// File: half-adder-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`include "instruction-memory.v"

module instruction_memory_tb;

  reg [31:0] sendAddress = 32'b00000000_00000000_00000000_00000000;
  wire [31:0] instruction;

  instruction_memory im(
    .readAddress(sendAddress),
    .instruction(instruction)
  );

  initial begin
    $dumpfile("instruction-memory.vcd");
    $dumpvars(0, instruction_memory_tb);

    sendAddress <= 32'b00000000_00000000_00000000_00000001;
    #10;
    sendAddress <= 32'b00000000_00000000_00000000_00000010;
    #10;
    sendAddress <= 32'b00000000_00000000_00000000_00000011;
    #10;
    sendAddress <= 32'b00000000_00000000_00000000_00000000;
    #10
    sendAddress <= 32'b00000000_00000000_00000000_00000001;
  end
endmodule
