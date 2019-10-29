// File: hazard.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 30 2019

`ifndef HAZARD_V
`define HAZARD_V

module hazard(MemRead_ID_EX,
              RFWriteReg_EX_MEM,
              RegWrite_ID_EX,
              RegWrite_EX_MEM,
              RegisterRs_IF_ID,
              RegisterRt_IF_ID,
              RegisterRs_ID_EX,
              RegisterRt_ID_EX,
              Stall_Data_Hazard);

  input wire MemRead_ID_EX;
  input wire [4:0] RFWriteReg_EX_MEM;
  input wire RegWrite_ID_EX;
  input wire RegWrite_EX_MEM;
  input wire [4:0] RegisterRs_IF_ID;
  input wire [4:0] RegisterRt_IF_ID;
  input wire [4:0] RegisterRs_ID_EX;
  input wire [4:0] RegisterRt_ID_EX;

  output reg Stall_Data_Hazard;

  // data hazard stall pseudo code
  //if (ID/EX.MemRead and
  // ((ID/EX.RegisterRt = IF/ID.RegisterRs)
  // or (ID/EX.RegisterRt = IF/ID.RegisterRt)))
  //stall the pipeline for one cycle

  always@(*) begin

    // load use hazard detection
    if (MemRead_ID_EX == 1'b1 && (RegisterRt_ID_EX == RegisterRs_IF_ID ||
        RegisterRt_ID_EX == RegisterRt_IF_ID)) begin
        Stall_Data_Hazard <= 1'b1;
    end

    // read after write hazard detection
    else if (RegWrite_EX_MEM == 1'b1 && (RegisterRt_ID_EX != 0) &&
            (RegisterRt_ID_EX == RegisterRs_IF_ID ||
            RegisterRt_ID_EX == RegisterRt_IF_ID)) begin

        Stall_Data_Hazard <= 1'b1;

    end

    // else if (RFWriteReg != 5'b0 && (RFWriteReg == RegisterRs_IF_ID ||
    //     RFWriteReg == RegisterRt_IF_ID)) begin
    //     Stall_Data_Hazard <= 1'b1;
    // end

    else begin
      Stall_Data_Hazard <= 1'b0;
    end

  end




endmodule

`endif
