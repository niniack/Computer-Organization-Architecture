// File: half-adder-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`include "../instruction-memory.v"

module instruction_memory_tb;

  reg [31:0] sendAddress;   // address for instruction
  wire [31:0] instruction;  // instruction at address

  instruction_memory im(
    .readAddress(sendAddress),
    .instruction(instruction)
  );

  initial begin
    $dumpfile("instruction-memory.vcd");
    $dumpvars(0, instruction_memory_tb);

    // send address 1
    // expected instruction ADDI $t2 $t1 0x0001
    // 0x212A0001
    sendAddress <= 32'b00000000_00000000_00000000_00000001;
    #5;
    // send address 2
    // expected instruction LWL $t5 0xF00D $sp
    // 0x8BADF00D
    sendAddress <= 32'b00000000_00000000_00000000_00000010;
    #5;
    // send address 3
    // expected address LD $t5 0xBABE $s5
    // 0xDEADBABE
    sendAddress <= 32'b00000000_00000000_00000000_00000011;
    #5;

    // send address 0
    // expected instruction ADD $t0 $t0 $t1
    // 0x01094020
    sendAddress <= 32'b00000000_00000000_00000000_00000000;
    #5;
  end
endmodule
