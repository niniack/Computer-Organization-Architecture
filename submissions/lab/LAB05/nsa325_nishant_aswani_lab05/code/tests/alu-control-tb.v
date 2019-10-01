// File: alu-control-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 02 2019

`include "../alu-control.v"

module alu_control_tb;

reg clk;
reg [1:0] ALUOp;
reg [5:0] funct;
wire [2:0] ALUControl;

// assign variables
alu_control aluctrl(
  .ALUOp(ALUOp),
  .funct(funct),
  .ALUControl(ALUControl)
  );

// clock alternates every unit of time
always begin
  #1 clk = ~clk;
end

// testing block
initial begin
  $dumpfile("alu-control.vcd");
  $dumpvars(0, alu_control_tb);

  ALUOp <= 2'b00;
  funct  <= 6'b000000;
  #5;

  ALUOp <= 2'b01;
  funct  <= 6'b000000;
  #5;

  ALUOp <= 2'b10;
  funct  <= 6'b100000;
  #5;

  ALUOp <= 2'b10;
  funct  <= 6'b100010;
  #5;

  ALUOp <= 2'b10;
  funct  <= 6'b100100;
  #5;

  ALUOp <= 2'b10;
  funct  <= 6'b100101;
  #5;

  ALUOp <= 2'b11;
  funct  <= 6'b000000;
  #5;

  $finish;
end

endmodule
