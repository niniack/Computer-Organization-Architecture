// File: data-memory-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`include "../data-memory.v"


module data_memory_tb;

  reg clk = 0;
  reg [4:0] address;
  wire [31:0] readData;
  reg [31:0] writeData;

  reg memWrite;
  reg memRead;

  data_memory dm(
    .clk(clk),
    .address(address),
    .readData(readData),
    .writeData(writeData),
    .memWrite(memWrite),
    .memRead(memRead)
  );

  always begin
    #1 clk = ~clk;
  end

  initial begin
    $dumpfile("data-memory.vcd");
    $dumpvars(0, data_memory_tb);

    writeData <= 32'h01ABCDEF;
		address <= 5'd7;
		memRead <= 1'b0;
		memWrite <= 1'b1;

    #5;

    writeData <= 32'hBAAD5EED;
		address <= 5'd2;
		memRead <= 1'b0;
		memWrite <= 1'b1;

    #5;

    address <= 5'd1;
    memRead <= 1'b1;
    memWrite <= 1'b0;

    #5;

    address <= 5'd4;
    memRead <= 1'b1;
    memWrite <= 1'b0;

    #5;

    writeData <= 32'hBAADB055;
    address <= 5'd3;
    memRead <= 1'b1;
    memWrite <= 1'b1;

    #5;

    writeData <= 32'h5AADB0B1;
    address <= 5'd5;
    memRead <= 1'b0;
    memWrite <= 1'b0;

    #5;

    $finish;

  end

endmodule
