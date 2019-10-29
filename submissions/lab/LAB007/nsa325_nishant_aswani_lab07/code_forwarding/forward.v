// File: forwarding.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 30 2019

`ifndef FORWARD_v
`define FORWARD_V

module forward(RegWrite_EX_MEM,
               RegWrite_MEM_WB,
               RFWriteReg_EX_MEM,
               RFWriteReg_MEM_WB,
               RegisterRs_ID_EX,
               RegisterRt_ID_EX,
               ForwardA,
               ForwardB);

  input wire RegWrite_EX_MEM;
  input wire RegWrite_MEM_WB;
  input wire [4:0] RFWriteReg_EX_MEM;
  input wire [4:0] RFWriteReg_MEM_WB;
  input wire [4:0] RegisterRs_ID_EX;
  input wire [4:0] RegisterRt_ID_EX;

  output reg [1:0] ForwardA;
  output reg [1:0] ForwardB;

  always@(*) begin
    // read after write hazard detection
    if (RegWrite_EX_MEM == 1'b1 && (RFWriteReg_EX_MEM != 0) &&
            (RFWriteReg_EX_MEM == RegisterRs_ID_EX)) begin

      ForwardA <= 2'b10;
      ForwardB <= 2'b00;
    end

    else if (RegWrite_EX_MEM == 1'b1 && (RFWriteReg_EX_MEM != 0) &&
            (RFWriteReg_EX_MEM == RegisterRt_ID_EX)) begin

      ForwardA <= 2'b00;
      ForwardB <= 2'b10;
    end

    else if (RegWrite_MEM_WB == 1'b1 && (RFWriteReg_MEM_WB != 0) &&
            (RFWriteReg_MEM_WB == RegisterRs_ID_EX)) begin

      ForwardA <= 2'b01;
      ForwardB <= 2'b00;
    end

    else if (RegWrite_MEM_WB == 1'b1 && (RFWriteReg_MEM_WB != 0) &&
            (RFWriteReg_MEM_WB == RegisterRt_ID_EX)) begin

      ForwardA <= 2'b00;
      ForwardB <= 2'b01;
    end

    else begin
      ForwardA <= 2'b00;
      ForwardB <= 2'b00;
    end

  end

endmodule

`endif
