// File: data-memory-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`include "../data-memory.v"

module data_memory_tb;

  reg clk = 0;            // clock
  reg [4:0] address;      // input address for data location
  wire [31:0] readData;   // value stored at address
  reg [31:0] writeData;   // value to write into address

  reg memWrite;           // enable flag for writing
  reg memRead;            // enable flag for reading

  data_memory dm(
    .clk(clk),
    .address(address),
    .readData(readData),
    .writeData(writeData),
    .memWrite(memWrite),
    .memRead(memRead)
  );

  // clock alternates every unit of time
  always begin
    #1 clk = ~clk;
  end

  initial begin
    $dumpfile("data-memory.vcd");
    $dumpvars(0, data_memory_tb);

    // write 0x01ABCDEF at register 7
    writeData <= 32'h01ABCDEF;
		address <= 5'd7;
		memRead <= 1'b0;
		memWrite <= 1'b1;
    #5;
    // write 0xBAAD5EED at register 2
    writeData <= 32'hBAAD5EED;
		address <= 5'd2;
		memRead <= 1'b0;
		memWrite <= 1'b1;
    #5;
    // read value at register 1
    address <= 5'd1;
    memRead <= 1'b1;
    memWrite <= 1'b0;
    #5;
    // read value at register 4
    address <= 5'd4;
    memRead <= 1'b1;
    memWrite <= 1'b0;

    #5;
    // write 0xBAADB055 (badboss) at register 3
    // also read value at register 3
    // ILLEGAL MOVE, JUST FOR DEMO
    writeData <= 32'hBAADB055;
    address <= 5'd3;
    memRead <= 1'b1;
    memWrite <= 1'b1;
    #5;
    // write 0x5AADB011 (sadboii) at register 5
    // BUT write and read flags are off
    // so do nothing
    writeData <= 32'h5AADB011;
    address <= 5'd5;
    memRead <= 1'b0;
    memWrite <= 1'b0;
    #5;
    $finish;
  end
endmodule
