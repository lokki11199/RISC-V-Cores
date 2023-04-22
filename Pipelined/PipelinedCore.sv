module pipelined(input  logic        clk, reset,
                 input  logic [31:0] InstrF,
                 input  logic [31:0] ReadData,
                 output logic [31:0] PCF,
                 output logic [31:0] ALUResultM,
                 output logic [31:0] WriteDataM,
                 output logic        MemWriteM,
                 output logic [1:0]  ByteAccessM
                 );
         
logic        ZeroE, RegWriteW, RegWriteM, ALUSrcE, StallF, StallD, FlushD, FlushE;
logic [1:0]  PCSrcE, ForwardAE, ForwardBE;
logic [2:0]  ResultSrcE, ResultSrcW, ResultSrcM, ImmSrcD, ByteSrcM;
logic [3:0]  ALUControlE;
logic [4:0]  Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
logic [31:0] InstrD;

controlunitreg cr(clk, reset, InstrD[6:0], InstrD[14:12], InstrD[30], ZeroE, FlushE, MemWriteM, ByteAccessM,
                  ResultSrcW, PCSrcE, ALUControlE, ALUSrcE, ByteSrcM, ImmSrcD, RegWriteW, ResultSrcE, RegWriteM,
                  ResultSrcM);
                  
datapath        d(clk, reset, ResultSrcM[1:0], ResultSrcW, PCSrcE, ALUControlE, ALUSrcE, ByteSrcM, 
                  ImmSrcD, RegWriteW, InstrF, ReadData, StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE, 
                  ZeroE, InstrD, PCF, ALUResultM, WriteDataM, RdW, RdM, RdE, Rs2E, Rs1E, Rs2D, Rs1D);
                  
hazardsunit     h(RegWriteW, PCSrcE, RegWriteM, ResultSrcE, RdW, RdM, RdE, Rs2E, Rs1E, Rs2D, Rs1D,
                  StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);
                 
endmodule