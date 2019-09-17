// File: data-memory.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 18 2019

`ifndef DATA_MEMORY_V
`define DATA_MEMORY_V

module data_memory(clk,
                  address,
                  readData,
                  writeData,
                  memWrite,
                  memRead);

  input wire clk;
  input wire [4:0] address;
  output wire [31:0] readData;
  input wire [31:0] writeData;

  input wire memWrite;
  input wire memRead;

  reg [31:0] mem[127:0];

  initial begin
    mem[0] <= 32'h1CEB00DA;  //  0x1CEB00DA
    mem[1] <= 32'hBAAAAAAD;  //  0xBAAAAAAD
    mem[2] <= 32'hBADDCAFE;  //  0xBADDCAFE
    mem[3] <= 32'hCAFED00D;  //  0xCAFED00D
    mem[4] <= 32'hDEADDEAD;  //  0xDEADDEAD
    mem[5] <= 32'hFACEFEED;  //  0xFACEFEED
    mem[6] <= 32'hC00010FF;  //  0xC00010FF
    mem[7] <= 32'h50D1EB0B;  //  0x50D1EB0B

  end

  always @(posedge clk) begin
		if (memWrite == 1) begin
			mem[address] <= writeData;
		end
	end

  assign readData = memRead? mem[address[4:0]][31:0] : 0;





endmodule




`endif
