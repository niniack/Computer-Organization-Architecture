// File: register-file-tb.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019


`include "../register-file.v"

module register_file_tb;

  reg clk = 0;
  reg rst;

  reg [4:0] readRegisterOne;
  reg [4:0] readRegisterTwo;
  reg [4:0] writeRegister;

  reg [31:0] writeData;
  reg writeEnable;

  wire [31:0] readDataOne;
  wire [31:0] readDataTwo;

  register_file rf(
    .clk(clk),
    .rst(rst),
    .readRegisterOne(readRegisterOne),
    .readRegisterTwo(readRegisterTwo),
    .writeRegister(writeRegister),
    .writeData(writeData),
    .writeEnable(writeEnable),
    .readDataOne(readDataOne),
    .readDataTwo(readDataTwo)
  );

    always begin
      #1 clk = ~clk;
    end

    initial begin
      $dumpfile("register-file.vcd");
      $dumpvars(0, register_file_tb);

      rst <= 0; // disable reset

      readRegisterOne <= 5'b00000; // read register 0
      readRegisterTwo <= 5'b00001; // read register 1
      ////////////////////////////
      writeEnable <= 1;            // enable write
      writeRegister <= 5'b00101;   // write to register 5
      writeData <= 32'b00001101_00010101_11101010_01011110; //0xD15EA5E

      #5;

      readRegisterOne <= 5'b00101; // read register 5
      readRegisterTwo <= 5'b00111; // read register 7
      ////////////////////////////
      writeEnable <= 0;            // disable write
      writeRegister <= 5'b00011;   // try to write to register 3
      writeData <= 32'b11111111_11111111_11111111_11111111; //0xFFFFFFFF

      #5;

      readRegisterOne <= 5'b00011; // read register 3
      readRegisterTwo <= 5'b00001; // read register 1
      ////////////////////////////
      writeEnable <= 1;            // enable write
      writeRegister <= 5'b00111;   // write to register 1
      writeData <= 32'b01010000_11010001_11101011_00001011; //0x50D1EBOB

      #5;
      writeEnable <= 0;
      rst <= 1;

      #2;
      rst <= 0;
      #4;

      readRegisterOne <= 5'b00101; // read register 5 to make sure its zero
      readRegisterTwo <= 5'b00111; // read register 7 to make sure its zero
      #10;




      $finish;
    end

endmodule
