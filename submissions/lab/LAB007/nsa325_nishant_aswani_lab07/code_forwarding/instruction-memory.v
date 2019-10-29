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

    mem[0] <= 32'h21080001;   // addi $t0 $t0 0x1
    mem[1] <= 32'h21090001;   // addi $t1 $t0 0x1
    mem[2] <= 32'h210A0001;   // addi $t2 $t0 0x1


  end

  always@(*) begin
    //assign relevant instruction given the register memory
    instruction <= mem[readAddress[31:2]][31:0];
  end

endmodule

`endif
