// File: instruction-memory.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`ifndef INSTRUCTION_MEMORY_V
`define INSTRUCTION_MEMORY_V

module instruction_memory (readAddress, instruction);

  input wire [31:0] readAddress;  // address for instruction
  output wire [31:0] instruction; // instruction at address

  reg [31:0] mem[31:0]; //32 by 32 bit instruction memory

  initial begin
    mem[0] <= 32'b000000_01000_01001_0100000000100000;    //ADD $t0 $t0 $t1
    mem[1] <= 32'b001000_01001_01010_0000000000000001;    //ADDI $t2 $t1 0x0001
    mem[2] <= 32'b100010_11101_01101_1111000000001101;    //LWL $t5 0xF00D $sp
    mem[3] <= 32'b110111_10101_01101_1011101010111110;    //LD $t5 0xBABE $s5
  end

  //assign relevant instruction given the register memory
  assign instruction = mem[readAddress[3:0]][31:0];

endmodule

`endif
