// File: register-file.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 25 2019

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

  // initialization block
  initial begin
    // use a for loop to reset all register values to zero
    for(i=0; i<31; i=i+1) begin
      reg_file[i] <= 32'd0; // set back to 0
    end

  end

  // block for resetting
  always@(posedge clk) begin

    // if reset is enabled
    if (rst == 1) begin
      // use a for loop to reset all register values to zero
      for(i=0; i<31; i=i+1) begin
        reg_file[i] <= 32'd0; // set back to 0
     	end
      reg_file[9] <= 32'h00000001;
      reg_file[10] <= 32'hDEADDEAD;
    end

    // else check for write conditions
    // and store writeData into appropriate register
    else if (writeRegister && writeEnable != 0) begin
        reg_file[writeRegister][31:0] <= writeData;
    end
  end


  // @(*) used for combinational logic
  // assigning output value
  always @ (*) begin
    // if read address is 0, then output 0
    if(readRegisterOne == 5'd0) begin
      readDataOne = 32'd0;
    end

    // otherwise output whatever is actually inside
    else begin
      readDataOne = reg_file[readRegisterOne][31:0];
    end

  end

  always @ (*) begin
    // if read address is 0, then output 0
    if(readRegisterTwo == 5'd0) begin
      readDataTwo = 32'd0;
    end

    // otherwise output whatever is actually inside
    else begin
      readDataTwo = reg_file[readRegisterTwo][31:0];
    end

  end

endmodule

`endif
