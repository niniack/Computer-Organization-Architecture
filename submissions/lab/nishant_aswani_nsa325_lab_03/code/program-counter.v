`ifndef PROGRAMCOUNTER_V
`define PROGRAMCOUNTER_V

module program_counter (clk, rst, nextAddress, currentAddress);

  input wire clk;
  input wire rst;
  input wire [31:0] nextAddress;
  output reg [31:0] currentAddress;

  always@(posedge clk) begin
    currentAddress <= nextAddress;
  end

endmodule

`endif
