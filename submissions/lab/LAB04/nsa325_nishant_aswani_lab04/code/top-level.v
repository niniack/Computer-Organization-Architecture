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
  // reg PCSrc = 0;

  // Control Logic (Hard-Coded)
  ///////// PROGRAM 2 /////////
  reg RegDst = 0;
  reg RegWrite = 0;
  reg ALUSrc = 1;
  reg [3:0] ALUControl = 4'b0010;
  reg MemtoReg = 1;
  reg memWrite = 0;
  reg memRead = 0;
  reg PCSrc = 0;

  // Program Counter
  reg [31:0] PCin;          // value that goes into PC, gets value from PCnext
  wire [31:0] PCnext;       // wire used for storing PCout + 4
  wire [31:0] PCout;        // value sent to IM
  wire [31:0] PCbranch;     // value used for storing output of PCin and offset
  wire [31:0] PCMUXout;     // value that decides between PCbranch and PCin

  // Instruction Memory
  wire [31:0] IMout;        // instruction from IM

  // Register File
  wire [31:0] RFout1;       // register 1 output
  wire [31:0] RFout2;       // register 2 output
  wire [31:0] RFWriteData;  // data to be written in

  // RegFile Mux
  wire [4:0] RFWriteReg;    // address of register to be written in

  // Sign Extend
  wire [31:0] SextOut;      // result of sign extension

  // Shift Left Logical by 2
  wire [31:0] SLLOut = 32'd0; // result of shift left 2

  // ALU
  wire [31:0] ALUin1;       // argument A for ALU
  wire [31:0] ALUin2;       // argument B for ALU
  wire [31:0] ALUout;       // output from ALU
  wire ALUzero;             // zero flag from ALU

  // Data Memory
  wire [31:0] DMout;        // data read from data memory


  ////////////////////////////
  /// MODULE INSTANTIATION ///
  ////////////////////////////
  program_counter pc(
    .clk(clk),
    .rst(rst),
    .in(PCMUXout),
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
  mux #(32) pcmux(
    .inA(PCin),
    .inB(PCbranch),
    .out(PCMUXout),
    .select(PCSrc)
    );


  ////////////////
  /// PC LOGIC ///
  ////////////////

  // half adder: add 4 to output of PC and send it next
  assign PCnext = PCout + 4;


  always@(*) begin
    // if reset, PCin must be 0
    if (rst) begin
      PCin <= 32'b0;
    end
    // otherwise, transfer the PCnext value to PCin
    else begin
      PCin <= PCnext;
    end
  end

  ////////////////////
  /// BRANCH LOGIC ///
  ////////////////////

  // add the offset to PCin
  assign PCbranch = SLLOut + PCin;

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
