// File: alu-control.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 09 2019

`ifndef ALU_CONTROL_v
`define ALU_CONTROL_v

module alu_control(ALUOp, funct, ALUControl);

  input wire [1:0] ALUOp;
  input wire [5:0] funct;
  output reg [2:0] ALUControl;

  reg [5:0] _funcOverride;

  always @(*) begin
    case (funct)
      6'b100000 : _funcOverride <= 010;     //add
      6'b100010 : _funcOverride <= 110;     //sub
      6'b100100 : _funcOverride <= 000;     //and
      6'b100101 : _funcOverride <= 001;     //or
      // undefined behavior, used as a dont' care
      default   : _funcOverride <= 111;
    endcase
  end

  always @(*) begin
    case (ALUOp)
      2'b00   : ALUControl <= 010;            //mem instructions need add
      2'b01   : ALUControl <= 110;            //beq needs sub
      2'b10   : ALUControl <= _funcOverride;  //R-type requires funct code
      2'b11   : ALUControl <= 010;            //I-type needs add
      // undefined behavior, used as a dont' care
      default : ALUControl <= 111;
    endcase
  end





endmodule
`endif
