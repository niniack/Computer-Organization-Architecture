// File: test-bench.v
// Name: Nishant Aswani
// Instructor: Cristoforos Vasilatos
// Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
// Due: Oct 02 2019

`ifndef TOP_LEVEL_V
`define TOP_LEVEL_V

module top_level(clk,rst);

  //////////////
  //////////////
  /// WIRING ///
  //////////////
  //////////////

  // Global

  input wire clk;
  input wire rst;
  input wire hold;
  input wire clear;

  // Probe Values

  wire [31:0] t0;
  wire [31:0] t1;
  wire [31:0] t2;
  wire [31:0] datmem;

  // Program Counter
  reg [31:0]  PCin;               // value that goes into PC, gets value from PCnext
  wire [31:0] PCnext;             // wire used for storing PCout + 4
  wire [31:0] PCout;              // value sent to IM
  wire [31:0] PCbranch;           // value used for storing output of PCin and offset
  wire [31:0] PCBranchMUXout;     // value that decides between PCbranch and PCin
  wire [31:0] PCJumpMUXout;

  // Instruction Memory
  wire [31:0] IMout;              // instruction from IM

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
  wire MemRead;
  wire MemtoReg;
  wire [1:0] ALUOp;
  wire MemWrite;
  wire ALUSrc;
  wire RegWrite;

  // Instruction determined branch activation
  wire BranchCtrl;
  // ANDed Branch
  wire Branch;

  // ALU Control
  wire [2:0] ALUControl;

  //////////////////////////
  //////////////////////////
  /// PIPELINE REGISTERS ///
  //////////////////////////
  //////////////////////////


  /////////////////////////
  //////// STAGE 1 ////////
  /////////////////////////

  wire [31:0] IMout_IF_ID;
  wire [31:0] PCnext_IF_ID;

  pipe_register s1_im_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(IMout),
    .out(IMout_IF_ID)
    );

  pipe_register s1_pcnext_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(PCnext),
    .out(PCnext_IF_ID)
    );

  /////////////////////////
  //////// STAGE 2 ////////
  /////////////////////////

  // Control

  wire ALUSrc_ID_EX;
  wire [1:0] ALUOp_ID_EX;
  wire RegDst_ID_EX;

  wire BranchCtrl_ID_EX;
  wire MemRead_ID_EX;
  wire MemWrite_ID_EX;


  wire RegWrite_ID_EX;
  wire MemtoReg_ID_EX;


  pipe_register #(1) s2_alusrc_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(ALUSrc),
    .out(ALUSrc_ID_EX)
    );

  pipe_register #(2) s2_aluop_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(ALUOp),
    .out(ALUOp_ID_EX)
    );

  pipe_register #(1) s2_regdst_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RegDst),
    .out(RegDst_ID_EX)
    );

  pipe_register #(1) s2_branchctrl_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(BranchCtrl),
    .out(BranchCtrl_ID_EX)
    );

  pipe_register #(1) s2_memread_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(MemRead),
    .out(MemRead_ID_EX)
    );

  pipe_register #(1) s2_memwrite_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(MemWrite),
    .out(MemWrite_ID_EX)
    );

  pipe_register #(1) s2_regwrite_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RegWrite),
    .out(RegWrite_ID_EX)
    );

  pipe_register #(1) s2_memtoreg_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(MemtoReg),
    .out(MemtoReg_ID_EX)
    );


  // Data
  wire [31:0] RFout1_ID_EX;
  wire [31:0] RFout2_ID_EX;
  wire [31:0] SextOut_ID_EX;
  wire [4:0] IMSelOne_ID_EX;
  wire [4:0] IMSelTwo_ID_EX;
  wire [31:0] PCnext_ID_EX;


  pipe_register s2_rfone_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RFout1),
    .out(RFout1_ID_EX)
    );
  pipe_register s2_rftwo_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RFout2),
    .out(RFout2_ID_EX)
    );

  pipe_register s2_sext_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(SextOut),
    .out(SextOut_ID_EX)
    );

  pipe_register #(5) s2_imselone_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(IMout_IF_ID[20:16]),
    .out(IMSelOne_ID_EX)
    );

  pipe_register #(5) s2_imseltwo_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(IMout_IF_ID[15:11]),
    .out(IMSelTwo_ID_EX)
    );

  pipe_register s2_pcnext_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(PCnext_IF_ID),
    .out(PCnext_ID_EX)
    );


  /////////////////////////
  //////// STAGE 3 ////////
  /////////////////////////

  // Control
  wire BranchCtrl_EX_MEM;
  wire MemRead_EX_MEM;
  wire MemWrite_EX_MEM;

  wire RegWrite_EX_MEM;
  wire MemtoReg_EX_MEM;

  pipe_register #(1) s3_branchctrl_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(BranchCtrl_ID_EX),
    .out(BranchCtrl_EX_MEM)
    );

  pipe_register #(1) s3_memread_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(MemRead_ID_EX),
    .out(MemRead_EX_MEM)
    );

  pipe_register #(1) s3_memwrite_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(MemWrite_ID_EX),
    .out(MemWrite_EX_MEM)
    );

  pipe_register #(1) s3_regwrite_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RegWrite_ID_EX),
    .out(RegWrite_EX_MEM)
    );

  pipe_register #(1) s3_memtoreg_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RegWrite_ID_EX),
    .out(RegWrite_EX_MEM)
    );

  // Data
  wire [31:0] PCbranch_EX_MEM;
  wire ALUzero_EX_MEM;
  wire [31:0] ALUout_EX_MEM;
  wire [31:0] RFout2_EX_MEM;
  wire [4:0] RFWriteReg_EX_MEM;
  wire [31:0] PCnext_EX_MEM;

  pipe_register s3_pcbranch_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(PCbranch),
    .out(PCbranch_EX_MEM)
    );

  pipe_register #(1) s3_aluzero_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(ALUzero),
    .out(ALUzero_EX_MEM)
    );

  pipe_register s3_aluout_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(ALUout),
    .out(ALUout_EX_MEM)
    );

  pipe_register s3_rftwo_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RFout2_ID_EX),
    .out(RFout2_EX_MEM)
    );

  pipe_register #(5) s3_rfwritereg_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RFWriteReg),
    .out(RFWriteReg_EX_MEM)
    );

  pipe_register s3_pcnext_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(PCnext_ID_EX),
    .out(PCnext_EX_MEM)
    );

  //////// STAGE 4 ////////

  // Control

  wire RegWrite_MEM_WB;
  wire MemtoReg_MEM_WB;

  pipe_register #(1) s4_regwrite_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RegWrite_EX_MEM),
    .out(RegWrite_MEM_WB)
    );

  pipe_register #(1) s4_memtoreg_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RegWrite_EX_MEM),
    .out(RegWrite_MEM_WB)
    );

  // Data
  wire [31:0] DMout_MEM_WB;
  wire [31:0] ALUout_MEM_WB;
  wire [4:0] RFWriteReg_MEM_WB;

  pipe_register s4_dmout_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(DMout),
    .out(DMout_MEM_WB)
    );

  pipe_register s4_aluout_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(ALUout_EX_MEM),
    .out(ALUout_MEM_WB)
    );

  pipe_register #(5) s4_rfwritereg_pr(
    .clk(clk),
    .rst(rst),
    .hold(hold),
    .clear(clear),
    .in(RFWriteReg_EX_MEM),
    .out(RFWriteReg_MEM_WB)
    );

  ////////////////////////////
  ////////////////////////////
  /// MODULE INSTANTIATION ///
  ////////////////////////////
  ////////////////////////////

  // Stage 1 Modules
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

  mux #(32) pcjmux(
    .inA(PCBranchMUXout),
    .inB(jumpAddress),
    .out(PCJumpMUXout),
    .select(Jump)
    );

  // Stage 2 Modules

  control ctrl(
    .opcode(IMout_IF_ID[31:26]),
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


  register_file rf(
    .clk(clk),
    .rst(rst),
    .readRegisterOne(IMout_IF_ID[25:21]),
    .readRegisterTwo(IMout_IF_ID[20:16]),
    .writeRegister(RFWriteReg_MEM_WB),
    .writeData(RFWriteData),
    .writeEnable(RegWrite_MEM_WB),
    .readDataOne(RFout1),
    .readDataTwo(RFout2)
    );

  sign_extend sext(
    .in(IMout_IF_ID[15:0]),
    .out(SextOut)
    );

  // Stage 3 Modules

  shift_left_2 sllb(
    .clk(clk),
    .in(SextOut_ID_EX),
    .out(SLLBOut)
    );

  alu alu(
    .clk(clk),
    .inA(ALUin1),
    .inB(ALUin2),
    .funct(ALUControl),
    .out(ALUout),
    .zero(ALUzero)
    );

  mux #(32) alumux(
    .inA(RFout2_ID_EX),
    .inB(SextOut_ID_EX),
    .out(ALUin2),
    .select(ALUSrc)
    );

  alu_control aluctrl(
    .ALUOp(ALUOp_ID_EX),
    .funct(SextOut_ID_EX[5:0]),
    .ALUControl(ALUControl)
    );

  mux #(5) immux(
      .inA(IMSelOne_ID_EX),
      .inB(IMSelTwo_ID_EX),
      .out(RFWriteReg),
      .select(RegDst_ID_EX)
    );

  // Stage 4 Modules

  data_memory dm(
    .clk(clk),
    .address(ALUout_EX_MEM),
    .writeData(RFout2_EX_MEM),
    .readData(DMout),
    .memWrite(MemWrite_EX_MEM),
    .memRead(MemRead_EX_MEM)
    );


  mux #(32) pcbmux(
    .inA(PCnext_EX_MEM),
    .inB(PCbranch),
    .out(PCBranchMUXout),
    .select(Branch)
    );

  // Stage 5 Modules

  mux #(32) rfmux(
    .inA(ALUout),
    .inB(DMout),
    .out(RFWriteData),
    .select(MemtoReg)
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

  /////////////////
  /// ALU LOGIC ///
  /////////////////

  assign ALUin1 = RFout1_ID_EX;

  ////////////////////
  /// BRANCH LOGIC ///
  ////////////////////

  // and the Branch control, ALU zero
  assign Branch = BranchCtrl_EX_MEM && ALUzero_EX_MEM;

  // add the offset to PCin
  assign PCbranch = SLLBOut + PCnext_ID_EX;

  // stall for branch
  


  //////////////////
  /// JUMP LOGIC ///
  //////////////////

  assign SLLJOut[27:2] = IMout[25:0];
  assign SLLJOut[1:0] = 0;

  ////////////////////////
  /// JUMP SHIFT LOGIC ///
  ////////////////////////

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
