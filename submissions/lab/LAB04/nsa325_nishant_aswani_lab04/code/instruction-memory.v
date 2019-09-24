// File: instruction-memory.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 25 2019

`ifndef INSTRUCTION_MEMORY_V
`define INSTRUCTION_MEMORY_V

module instruction_memory (clk,readAddress, instruction);

  input wire clk;
  input wire [31:0] readAddress;  // address for instruction
  output reg [31:0] instruction; // instruction at address

  reg [31:0] mem[31:0]; //32 by 32 bit instruction memory

  initial begin

    ///////////////////////////// PROGRAM 1 /////////////////////////////////
    // mem[0] <= 32'b000000_00000_00000_0000000000000000;    // EMPTY
    // mem[1] <= 32'b001000_01001_01001_0000000000000001;    //ADDI $t1 $t1 1
    // mem[2] <= 32'b001000_01010_01010_0000000000000010;    //ADDI $t2 $t2 2
    // mem[3] <= 32'b001000_01001_01001_0000000000000001;    //ADDI $t1 $t1 1
    // mem[4] <= 32'b001000_01010_01010_0000000000000010;    //ADDI $t2 $t2 2

    ///////////////////////////// PROGRAM 2 /////////////////////////////////
    mem[0] <= 32'b000000_00000_00000_0000000000000000;    // EMPTY
    mem[1] <= 32'b101011_01001_01010_0000000000000000;    //SW $t2 0($t1)
    mem[2] <= 32'b100011_01001_01001_0000000000000000;    //LW $t1 0($t1)

  end

  always@(posedge clk) begin
    //assign relevant instruction given the register memory
    instruction <= mem[readAddress[31:2]][31:0];
  end

endmodule

`endif
