module controlunitreg(input  logic       clk, reset,
                      input  logic [6:0] op,
                      input  logic [2:0] funct3,
                      input  logic       funct7b5,
                      input  logic       BPD, //New signals
                      input  logic       ZeroB, FlushE, FlushB,
                      output logic       MemWriteM,
                      output logic [1:0] ByteAccessM, ByteAccessW,  
                      output logic [2:0] ResultSrcW,                   
                      output logic [2:0] PCSrcB, //Changed number of bits
                      output logic [3:0] ALUControlE,
                      output logic [3:0] ALUControlB,
                      output logic       ALUSrcE,
                      output logic [2:0] ByteSrcW,
                      output logic [2:0] ImmSrcD,
                      output logic       RegWriteW,
                      output logic [2:0] ResultSrcE,
                      output logic [2:0] ResultSrcB,
                      output logic       RegWriteM,
                      output logic       RegWriteB,
                      output logic       BranchB //New signal
                      );
                      
logic PCSrcD1, PCSrcE1, PCSrcB1;
logic BranchD, BranchE;
logic JumpD, JumpE, JumpB;
logic BPE, BPB;
logic [1:0] ByteAccessD, ByteAccessE, ByteAccessB;
logic [2:0] ResultSrcD, ResultSrcM;
logic       MemWriteD, MemWriteE, MemWriteB;
logic [3:0] ALUControlD;
logic       ALUSrcD;
logic [2:0] ByteSrcD, ByteSrcE, ByteSrcB, ByteSrcM;
logic       RegWriteD, RegWriteE;

controlunit c(op, funct3, funct7b5, PCSrcD1, BranchD, JumpD, ResultSrcD, MemWriteD, ALUSrcD, RegWriteD,
                ByteAccessD, ALUControlD, ByteSrcD, ImmSrcD);
              
clrflopr11  e(clk, reset, FlushE, PCSrcD1, BranchD, JumpD, BPD, ByteAccessD, ResultSrcD, MemWriteD, 
              ALUControlD, ALUSrcD, ByteSrcD, RegWriteD, PCSrcE1, BranchE, JumpE, BPE, ByteAccessE, 
              ResultSrcE, MemWriteE, ALUControlE, ALUSrcE, ByteSrcE, RegWriteE);
              
clrflopr9   b(clk, reset, FlushB, PCSrcE1, BranchE, JumpE, BPE, ByteAccessE, ResultSrcE, MemWriteE, ALUControlE, ByteSrcE,
              RegWriteE, PCSrcB1, BranchB, JumpB, BPB, ByteAccessB, ResultSrcB, MemWriteB, ALUControlB, ByteSrcB, RegWriteB);
              
flopr6      m(clk, reset, ByteAccessB, ResultSrcB, MemWriteB, ByteSrcB, RegWriteB,
              ByteAccessM, ResultSrcM, MemWriteM, ByteSrcM, RegWriteM);
              
flopr4      w(clk, reset, ResultSrcM, RegWriteM, ByteSrcM, ByteAccessM,
              ResultSrcW, RegWriteW, ByteSrcW, ByteAccessW);
              
PCSrcU      PC(.BPD(BPD), .PCSrcB1(PCSrcB1), .BranchB(BranchB), .JumpB(JumpB), .ZeroB(ZeroB), .BPB(BPB), .PCSrcB(PCSrcB), .op(op));


endmodule