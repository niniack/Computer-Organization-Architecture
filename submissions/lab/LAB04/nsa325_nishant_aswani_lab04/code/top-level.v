// File: test-bench.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Sep 25 2019

`ifndef TOP_LEVEL_V
`define TOP_LEVEL_V

module top_level(clk,rst);

  //////////////
  /// WIRING ///
  //////////////

  // Global
  input wire clk;
  input wire rst;
  wire [31:0] testReg1;
  wire [31:0] testReg2;

  // Control Logic (Hard-Coded)
  ///////// PROGRAM 1 /////////
  // reg RegDst = 0;
  // reg RegWrite = 1;
  // reg ALUSrc = 1;
  // reg [3:0] ALUControl = 4'b0010;
  // reg MemtoReg = 0;
  // reg memWrite = 0;
  // reg memRead = 0;

  // Control Logic (Hard-Coded)
  ///////// PROGRAM 2 /////////
  reg RegDst = 0;
  reg RegWrite = 0;
  reg ALUSrc = 1;
  reg [3:0] ALUControl = 4'b0010;
  reg MemtoReg = 1;
  reg memWrite = 0;
  reg memRead = 0;

  // Program Counter
  reg [31:0] PCin;
  wire [31:0] PCnext;
  wire [31:0] PCout;

  // Instruction Memory
  wire [31:0] IMout;

  // Register File
  wire [31:0] RFout1;
  wire [31:0] RFout2;
  wire [31:0] RFWriteData;

  // RegFile Mux
  wire [4:0] RFWriteReg;

  // Sign Extend
  wire [31:0] SextOut;

  // Shift Left Logical by 2
  wire [31:0] SLLOut;

  // ALU
  wire [31:0] ALUin1;
  wire [31:0] ALUin2;
  wire [31:0] ALUout;
  wire ALUzero;

  // Data Memory
  wire [31:0] DMout;


  ////////////////////////////
  /// MODULE INSTANTIATION ///
  ////////////////////////////
  program_counter pc(
    .clk(clk),
    .rst(rst),
    .in(PCin),
    .out(PCout)
    );

  instruction_memory im(
    .clk(clk),
    .readAddress(PCout),
    .instruction(IMout)
    );

  mux #(5) immux(
      .inA(IMout[20:16]),
      .inB(IMout[15:11]),
      .out(RFWriteReg),
      .select(RegDst)
    );

  register_file rf(
    .clk(clk),
    .rst(rst),
    .readRegisterOne(IMout[25:21]),
    .readRegisterTwo(IMout[20:16]),
    .writeRegister(RFWriteReg),
    .writeData(RFWriteData),
    .writeEnable(RegWrite),
    .readDataOne(RFout1),
    .readDataTwo(RFout2)
    );

  sign_extend sext(
    .in(IMout[15:0]),
    .out(SextOut)
    );

  shift_left_2 sll(
    .clk(clk),
    .in(SextOut),
    .out(SLLOut)
    );

  mux #(32) alumux(
    .inA(RFout2),
    .inB(SextOut),
    .out(ALUin2),
    .select(ALUSrc)
    );

  alu alu(
    .clk(clk),
    .inA(ALUin1),
    .inB(ALUin2),
    .funct(ALUControl),
    .out(ALUout),
    .zero(ALUzero)
    );

  mux #(32) rfmux(
    .inA(ALUout),
    .inB(DMout),
    .out(RFWriteData),
    .select(MemtoReg)
    );

  data_memory dm(
    .clk(clk),
    .address(ALUout),
    .readData(DMout),
    .writeData(RFout2),
    .memWrite(memWrite),
    .memRead(memRead)
    );


  ////////////////
  /// PC LOGIC ///
  ////////////////

  assign PCnext = PCout + 4;

  always@(*) begin
    if (rst) begin
      PCin <= 32'b0;
    end
    else begin
      PCin <= PCnext;
    end
  end

  /////////////////
  /// ALU LOGIC ///
  /////////////////

  assign ALUin1 = RFout1;

  ////////////////
  /// DM LOGIC ///
  ////////////////

  always@(*) begin

    // store word
    if(IMout[31:26] == 6'b101011) begin
      memWrite <= 1;
      memRead <= 0;
      RegWrite = 0;
    end

    // load word
    else if (IMout[31:26] == 6'b100011) begin
      memWrite <= 0;
      memRead <= 1;
      RegWrite = 1;
    end

    else begin
      memWrite <= 0;
      memRead <= 0;
    end

  end

  //////////////////
  /// TEST LOGIC ///
  //////////////////

  // assign testReg1 = rf.reg_file[9];
  // assign testReg2 = rf.reg_file[10];

  assign testReg1 = dm.mem[1];
  assign testReg2 = rf.reg_file[9];




endmodule
`endif
