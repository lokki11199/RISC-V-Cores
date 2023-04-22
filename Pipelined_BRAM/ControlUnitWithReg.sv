module controlunitreg(input  logic       clk, reset,
                      input  logic [6:0] op,
                      input  logic [2:0] funct3,
                      input  logic       funct7b5,
                      input  logic       ZeroE, FlushE,
                      output logic       MemWriteM,
                      output logic [1:0] ByteAccessM, ByteAccessW,
                      output logic [2:0] ResultSrcW,                   
                      output logic [1:0] PCSrcE,
                      output logic [3:0] ALUControlE,
                      output logic       ALUSrcE,
                      output logic [2:0] ByteSrcW,
                      output logic [2:0] ImmSrcD,
                      output logic       RegWriteW,
                      output logic [2:0] ResultSrcE,
                      output logic       RegWriteM,
                      output logic [2:0] ResultSrcM
                      );
                      
logic PCSrcD1;
logic BranchD, BranchE;
logic JumpD, JumpE;
logic [1:0] ByteAccessD, ByteAccessE;
logic [2:0] ResultSrcD;
logic       MemWriteD, MemWriteE;
logic [3:0] ALUControlD;
logic       ALUSrcD;
logic [2:0] ByteSrcD, ByteSrcE, ByteSrcM;
logic       RegWriteD, RegWriteE;

controlunit c(op, funct3, funct7b5, PCSrcD1, BranchD, JumpD, ResultSrcD, MemWriteD, ALUSrcD, RegWriteD,
                ByteAccessD, ALUControlD, ByteSrcD, ImmSrcD);
              
clrflopr11  e(clk, reset, FlushE, PCSrcD1, BranchD, JumpD, ByteAccessD, ResultSrcD, MemWriteD, 
              ALUControlD, ALUSrcD, ByteSrcD, RegWriteD, PCSrcE[1], BranchE, JumpE, ByteAccessE, 
              ResultSrcE, MemWriteE, ALUControlE, ALUSrcE, ByteSrcE, RegWriteE);
              
flopr6      m(clk, reset, ByteAccessE, ResultSrcE, MemWriteE, ByteSrcE, RegWriteE,
              ByteAccessM, ResultSrcM, MemWriteM, ByteSrcM, RegWriteM);
              
flopr4      w(clk, reset, ResultSrcM, RegWriteM, ByteSrcM, ByteAccessM,
              ResultSrcW, RegWriteW, ByteSrcW, ByteAccessW);
              
assign PCSrcE[0] = (ZeroE & BranchE) | JumpE;


endmodule