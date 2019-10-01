// File: test-bench.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 02 2019

`ifndef TOP_LEVEL_V
`define TOP_LEVEL_V

module top_level(clk,rst);

  //////////////
  /// WIRING ///
  //////////////

  // Global
  input wire clk;
  input wire rst;
  wire [31:0] t0;
  wire [31:0] t1;
  wire [31:0] t2;
  wire [31:0] datmem;

  // Program Counter
  reg [31:0]  PCin;          // value that goes into PC, gets value from PCnext
  wire [31:0] PCnext;       // wire used for storing PCout + 4
  wire [31:0] PCout;        // value sent to IM
  wire [31:0] PCbranch;     // value used for storing output of PCin and offset
  wire [31:0] PCBranchMUXout;     // value that decides between PCbranch and PCin
  wire [31:0] PCJumpMUXout;

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

  // Shift Left Logical by 2 Branch
  wire [31:0] SLLBOut; // result of shift left 2

  // ALU
  wire [31:0] ALUin1;       // argument A for ALU
  wire [31:0] ALUin2;       // argument B for ALU
  wire [31:0] ALUout;       // output from ALU
  wire ALUzero;             // zero flag from ALU

  // Data Memory
  wire [31:0] DMout;        // data read from data memory

  // Shift Left Logical by 2 Jump
  wire [27:0] SLLJOut;      // result of shift left 2

  // Jump Address
  wire [31:0] jumpAddress;  // concatenated with PC value

  // Control Logic
  wire RegDst;
  wire Jump;
  wire BranchCtrl;
  wire MemRead;
  wire MemtoReg;
  wire [1:0] ALUOp;
  wire MemWrite;
  wire ALUSrc;
  wire RegWrite;

  wire Branch;

  // ALU Control
  wire [2:0] ALUControl;


  ////////////////////////////
  /// MODULE INSTANTIATION ///
  ////////////////////////////
  program_counter pc(
    .clk(clk),
    .rst(rst),
    .in(PCJumpMUXout),
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

  shift_left_2 sllb(
    .clk(clk),
    .in(SextOut),
    .out(SLLBOut)
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
    .memWrite(MemWrite),
    .memRead(MemRead)
    );
  mux #(32) pcbmux(
    .inA(PCin),
    .inB(PCbranch),
    .out(PCBranchMUXout),
    .select(Branch)
    );

  // shift_left_2 #(26) sllj(
  //   .clk(clk),
  //   .in(IMout[25:0]),
  //   .out(SLLJOut)
  //   );

  mux #(32) pcjmux(
    .inA(PCBranchMUXout),
    .inB(jumpAddress),
    .out(PCJumpMUXout),
    .select(Jump)
    );

  control ctrl(
    .opcode(IMout[31:26]),
    .RegDst(RegDst),
    .Jump(Jump),
    .Branch(BranchCtrl),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
    );

  alu_control aluctrl(
    .ALUOp(ALUOp),
    .funct(IMout[5:0]),
    .ALUControl(ALUControl)
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

  // and the Branch control, ALU zero
  assign Branch = BranchCtrl && ALUzero;

  // add the offset to PCin
  assign PCbranch = SLLBOut + PCin;

  /////////////////
  /// ALU LOGIC ///
  /////////////////

  assign ALUin1 = RFout1;

  //////////////////
  /// JUMP LOGIC ///
  //////////////////

  assign SLLJOut[27:2] = IMout[25:0];
  assign SLLJOut[1:0] = 0;

  assign jumpAddress = {PCin[31:28], SLLJOut[27:0]};


  //////////////////
  /// TEST LOGIC ///
  //////////////////

  // assign testReg1 = rf.reg_file[9];
  // assign testReg2 = rf.reg_file[10];

  assign t0 = rf.reg_file[8];
  assign t1 = rf.reg_file[9];
  assign t2 = rf.reg_file[10];
  assign datmem = dm.mem[1];




endmodule
`endif
