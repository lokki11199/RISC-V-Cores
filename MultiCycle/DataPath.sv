module datapath (input  logic        CLK,
                 input  logic        Reset,
                 input  logic [31:0] ReadData,
                 input  logic        IRWrite,
                 input  logic        PCWrite,
                 input  logic        RegWrite,
                 input  logic [2:0]  ImmSrc,
                 input  logic [2:0]  ByteSrc,
                 input  logic [1:0]  ALUSrcA,
                 input  logic [1:0]  ALUSrcB,
                 input  logic [3:0]  ALUControl,
                 input  logic [1:0]  ResultSrc,
                 output logic        Zero,
                 output logic [31:0] Instr,
                 output logic [31:0] PC,
                 output logic [31:0] Result,
                 output logic [31:0] WriteData
                 );
                 
logic [31:0] OldPC, Data, RegData, A, ImmExt, ByteExt, SrcA, SrcB, ALUResult, ALUOut, RD1, RD2;

//PC logic
enflopr#(32) pcf(CLK, Reset, PCWrite, Result, PC);

//Register File logic
enflopr2#(32)  reginf(CLK, Reset, IRWrite, PC, ReadData, OldPC, Instr);
regfile             r(CLK, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7], Result, RD1, RD2);
flopr2#(32)   regoutf(CLK, Reset, RD1, RD2, A, WriteData);
extend1          ext1(Instr[31:7], ImmSrc, ImmExt);
extend2          ext2(Data, ByteSrc, ByteExt);

//ALU logic
mux3#(32)       amux1(PC, OldPC, A, ALUSrcA, SrcA);
mux3#(32)       amux2(WriteData, ImmExt, 32'd4, ALUSrcB, SrcB);
alu               alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
flopr#(32)         af(CLK, Reset, ALUResult, ALUOut);

//Result logic
flopr#(32)         df(CLK, Reset, ReadData, Data);
mux4#(32)          rm(ALUOut, ByteExt, ALUResult, ImmExt, ResultSrc, Result);

endmodule