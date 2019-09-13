`ifndef INSTRUCTIONMEMORY_V
`define INSTRUCTIONMEMORY_V

module instruction_memory (readAddress, instruction);

  input wire [31:0] readAddress;
  output reg [31:0] instruction;

  reg [127:0] mem[31:0]; 

  always@(posedge clk) begin
    currentInstruction <= nextInstruction;
  end

endmodule

`endif
