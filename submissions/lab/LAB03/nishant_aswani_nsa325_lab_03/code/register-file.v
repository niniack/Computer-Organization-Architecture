// File: register-file.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`ifndef REGISTER_FILE_V
`define REGISTER_FILE_V

module register_file(clk,
                    rst,
                    readRegisterOne,
                    readRegisterTwo,
                    writeRegister,
                    writeData,
                    writeEnable,
                    readDataOne,
                    readDataTwo);

  input wire clk; //  clock
  input wire rst; //  async reset
  input wire [4:0] readRegisterOne; //  address for first read register
  input wire [4:0] readRegisterTwo; //  address for second read register
  input wire [4:0] writeRegister;   //  address for write register
  input wire [31:0] writeData;      //  data to be written into write register
  input wire writeEnable;           //  enable flag to change register

  output reg [31:0] readDataOne;   //  data to be sent to ALU
  output reg [31:0] readDataTwo;   //  data to be sent to ALU

  reg [31:0] reg_file[31:0];       //  registers stored in register file

  integer i = 0;

  initial begin
    reg_file[0] <= 32'd0;  //  0x0
    reg_file[1] <= 32'd0;  //  0x0
    reg_file[2] <= 32'd0;  //  0x0
    reg_file[3] <= 32'd0;  //  0x0
    reg_file[4] <= 32'd0;  //  0x0
    reg_file[6] <= 32'd0;  //  0x0
    reg_file[5] <= 32'd0;  //  0x0
    reg_file[7] <= 32'hFFFFFFFF;  //  0xFFFFFFFF

  end

  always@(posedge clk) begin

    // if reset is enabled
    if (rst == 1) begin
      // use a for loop to reset all register values to zero
      for(i=0; i<8; i=i+1)
      begin
        reg_file[i] <= 32'd0; // set back to 0
     	end
    end

    else begin
      // if writeEnable, then write to provided address
      if (writeEnable == 1)
        reg_file[writeRegister[4:0]] <= writeData[31:0];
    end
    // obtain values from provided register addresses
    readDataOne <= reg_file[readRegisterOne[4:0]][31:0];
    readDataTwo <= reg_file[readRegisterTwo[4:0]][31:0];


  end

endmodule

`endif
