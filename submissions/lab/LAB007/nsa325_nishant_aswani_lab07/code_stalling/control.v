// File: control.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 09 2019

`ifndef CONTROL_v
`define CONTROL_v


module control(opcode,
              RegDst,
              Jump,
              Branch,
              MemRead,
              MemtoReg,
              ALUOp,
              MemWrite,
              ALUSrc,
              RegWrite,
              Stall_Data_Hazard);

  // input opcode
  input wire [5:0] opcode;
  input wire Stall_Data_Hazard;

  // output controls
  output reg RegDst;
  output reg Jump;
  output reg Branch;
  output reg MemRead;
  output reg MemtoReg;
  output reg [1:0] ALUOp;
  output reg MemWrite;
  output reg ALUSrc;
  output reg RegWrite;


  always @(*) begin
    if (Stall_Data_Hazard == 1) begin
      RegDst   <= 0;
      ALUSrc   <= 0;
      MemtoReg <= 0;
      RegWrite <= 0;
      MemRead  <= 0;
      MemWrite <= 0;
      Branch   <= 0;
      Jump     <= 0;
      ALUOp   <= 00;
    end

    else begin
      case (opcode)

        // R-type
        6'b000000 :
        begin
          RegDst   <= 1;
          ALUSrc   <= 0;
          MemtoReg <= 0;
          RegWrite <= 1;
          MemRead  <= 0;
          MemWrite <= 0;
          Branch   <= 0;
          Jump     <= 0;
          ALUOp   <= 10;
        end

        // lw
        6'b100011 :
        begin
          RegDst   <= 0;
          ALUSrc   <= 1;
          MemtoReg <= 1;
          RegWrite <= 1;
          MemRead  <= 1;
          MemWrite <= 0;
          Branch   <= 0;
          Jump     <= 0;
          ALUOp   <= 00;
        end

        // sw
        6'b101011 :
        begin
          RegDst   <= 0;
          ALUSrc   <= 1;
          MemtoReg <= 0;
          RegWrite <= 0;
          MemRead  <= 0;
          MemWrite <= 1;
          Branch   <= 0;
          Jump     <= 0;
          ALUOp   <= 00;
        end

        // beq
        6'b000100 :
        begin
          RegDst   <= 0;
          ALUSrc   <= 0;
          MemtoReg <= 0;
          RegWrite <= 0;
          MemRead  <= 0;
          MemWrite <= 0;
          Branch   <= 1;
          Jump     <= 0;
          ALUOp   <= 01;
        end

        // addi
        6'b001000 :
        begin
          RegDst   <= 0;
          ALUSrc   <= 1;
          MemtoReg <= 0;
          RegWrite <= 1;
          MemRead  <= 0;
          MemWrite <= 0;
          Branch   <= 0;
          Jump     <= 0;
          ALUOp   <= 11;
        end

        // J-type
        6'b000010 :
        begin
          RegDst   <= 0;
          ALUSrc   <= 0;
          MemtoReg <= 0;
          RegWrite <= 0;
          MemRead  <= 0;
          MemWrite <= 0;
          Branch   <= 0;
          Jump     <= 1;
          ALUOp   <= 00;
        end
      endcase
    end
  end


endmodule

`endif
