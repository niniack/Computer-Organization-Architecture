// File: mux3.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 30 2019

`ifndef MUX3_V
`define MUX3_V

module mux3 #(parameter N=32) (inA, inB, inC, out, select);

  // input wires
  input wire [N-1: 0] inA;
  input wire [N-1: 0] inB;
  input wire [N-1: 0] inC;
  input wire [1:0] select;

  // output wire
  output reg [N-1: 0] out;

  always@(*) begin

    if (select == 2'b00) begin
      out <= inA;
    end

    else if (select == 2'b01) begin
      out <= inB;
    end

    else if (select == 2'b10) begin
      out <= inC;
    end

  end
  // // output selection case
  // case (select)
  //   // source: ID/EX
  //   2'b00 :
  //   begin
  //     assign out = inA;
  //   end
  //
  //   // source: MEM/WB
  //   2'b01 :
  //   begin
  //     assign out = inB;
  //   end
  //
  //   // source: EX/MEM
  //   2'b10 :
  //   begin
  //     assign out = inC;
  //   end
  // endcase

endmodule

`endif
