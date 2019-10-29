// File: instruction-memory.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 09 2019

`ifndef INSTRUCTION_MEMORY_V
`define INSTRUCTION_MEMORY_V

module instruction_memory (clk,readAddress, instruction);

  input wire clk;
  input wire [31:0] readAddress;  // address for instruction
  output reg [31:0] instruction; // instruction at address

  reg [31:0] mem[31:0]; //32 by 32 bit instruction memory

  initial begin

    mem[0] <= 32'b00000000000000000000000000000000;   // EMPTY
    mem[1] <= 32'b00100001000010000000000000000010;   // addi $t0 $t0 2
    mem[2] <= 32'b00100001010010100000000000000010;   // addi $t2 $t2 2
    mem[3] <= 32'b00000001000010100100000000100000;   // add  $t0 $t0 $t2
    mem[4] <= 32'b00100001001010010000000000000001;   // addi $t1 $t1 1
    mem[5] <= 32'b10101101001010000000000000000000;   // sw   $t0 0($t1)
    mem[6] <= 32'b10001101001010100000000000000000;   // lw   $t2 0($t1)
    mem[7] <= 32'b00000001000010010100000000100010;   // sub  $t0 $t0 $t1
    mem[8] <= 32'b00010001000010010000000000000001;   // beq  $t0 $t1 end
    mem[9] <= 32'b00001000000000000000000000000111;   // j loop

  end

  always@(*) begin
    //assign relevant instruction given the register memory
    instruction <= mem[readAddress[31:2]][31:0];
  end

endmodule

`endif
