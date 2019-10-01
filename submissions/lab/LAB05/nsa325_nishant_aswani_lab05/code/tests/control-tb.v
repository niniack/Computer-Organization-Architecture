// File: control-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 02 2019

`include "../control.v"

module control_tb;

  reg clk;
  reg [5:0] opcode;  // resulting value from operation

  wire RegDst;
  wire Jump;
  wire Branch;
  wire MemRead;
  wire MemtoReg;
  wire [1:0] ALUOp;
  wire MemWrite;
  wire ALUSrc;
  wire RegWrite;



  // assign variables
  control ctrl(
    .opcode(opcode),
    .RegDst(RegDst),
    .Jump(Jump),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
    );

  // clock alternates every unit of time
  always begin
    #1 clk = ~clk;
  end

  // testing block
  initial begin
    $dumpfile("control.vcd");
    $dumpvars(0, control_tb);

    opcode <= 6'b000000;
    #5;

    opcode <= 6'b100011;
    #5;

    opcode <= 6'b101011;
    #5;

    opcode <= 6'b000100;
    #5;

    opcode <= 6'b001000;
    #5;

    opcode <= 6'b000010;
    #5;


    $finish;
  end

endmodule
