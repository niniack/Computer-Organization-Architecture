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

  input wire clk;               // clock
  input wire [31:0] address;     // input address for data location
  output wire [31:0] readData;  // value stored at address
  input wire [31:0] writeData;  // value to write into address

  input wire memWrite;          // enable flag for writing
  input wire memRead;           // enable flag for reading

  reg [31:0] mem[127:0];        // 2D array to store dummy values

  initial begin
    mem[0] <= 32'h1CEB00DA;  //  0x1CEB00DA (icebooda)
    mem[1] <= 32'hBAAAAAAD;  //  0xBAAAAAAD (baaaaaad)
    mem[2] <= 32'hBADDCAFE;  //  0xBADDCAFE (baddcafe)
    mem[3] <= 32'hCAFED00D;  //  0xCAFED00D (cafedude)
    mem[4] <= 32'hDEADDEAD;  //  0xDEADDEAD (deaddead)
    mem[5] <= 32'hFACEFEED;  //  0xFACEFEED (facefeed)
    mem[6] <= 32'hC00010FF;  //  0xC00010FF (cooloff)
    mem[7] <= 32'h50D1EB0B;  //  0x50D1EB0B (sodiebob)

  end

  // at every positive edge of the clock
  always @(posedge clk) begin
    // if memWrite is enabled
		if (memWrite == 1) begin
      // write the value to given register address
			mem[address] = writeData;
		end
	end

  // if memRead is enabled, read address at location, otherwise output 0
  assign readData = memRead ? mem[address[4:0]][31:0] : 0;





endmodule




`endif
