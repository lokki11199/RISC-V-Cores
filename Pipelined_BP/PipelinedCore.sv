module pipelined(input  logic        clk, reset,
                 input  logic [31:0] InstrF,
                 input  logic [31:0] ReadData,
                 output logic [31:0] PCF,
                 output logic [31:0] ALUResultM, ForwardW,
                 output logic [31:0] WriteDataM,
                 output logic        MemWriteM,
                 output logic [1:0]  ByteAccessM, ByteAccessW,
                 output logic        StallD,
                 output logic        FlushD      
                 );
         
logic        ZeroB, RegWriteW, RegWriteM, RegWriteB, ALUSrcE, StallF, FlushE, FlushB;
logic        BP, BPD, BranchB; //New Signals
logic [2:0]  PCSrcB; //Changed number of bits
logic [1:0]  ForwardAE, ForwardBE;
logic [2:0]  ResultSrcE, ResultSrcB, ResultSrcW, ResultSrcM, ImmSrcD, ByteSrcW;
logic [3:0]  ALUControlE, ALUControlB;
logic [4:0]  Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW, RdB;
logic [31:0] InstrD;
//logic [31:0] BPTarget; //New signal уже не нужен
logic [31:0] PCB;//New signal_ need to connect

controlunitreg cr(clk, reset, InstrD[6:0], InstrD[14:12], InstrD[30], BPD, ZeroB, FlushE, FlushB, MemWriteM, ByteAccessM, ByteAccessW,
                  ResultSrcW, PCSrcB, ALUControlE, ALUControlB, ALUSrcE, ByteSrcW, ImmSrcD, RegWriteW, ResultSrcE, 
                  ResultSrcB, RegWriteM, RegWriteB, BranchB);
                  
datapath        d(clk, reset, BP, ResultSrcB, ResultSrcW, PCSrcB, ALUControlE, ALUControlB, ALUSrcE, ByteSrcW, 
                  ImmSrcD, RegWriteW, InstrF, ReadData, StallF, StallD, FlushD, FlushE, FlushB, ForwardAE, ForwardBE, 
                  ZeroB, InstrD, PCF, ALUResultM, ForwardW, WriteDataM, RdW, RdM, RdB, RdE, Rs2E, Rs1E, Rs2D, Rs1D, BPD, PCB);
                  
hazardsunit     h(RegWriteW, PCSrcB, RegWriteM, RegWriteB, ResultSrcE, ResultSrcB, RdW, RdM, RdB, RdE, Rs2E, Rs1E, Rs2D, 
                  Rs1D, StallF, StallD, FlushD, FlushE, FlushB, ForwardAE, ForwardBE);
                  
BPU_4            bp(.clk(clk), .reset(reset), .BranchB(BranchB), .ZeroB(ZeroB), .PCF(PCF), .BP(BP), .PCB(PCB));// Check PCB signal
//BPU_1           bp(.clk(clk), .reset(reset), .BranchB(BranchB), .ZeroB(ZeroB), .PCF(PCF), .BP(BP));// Check PCB signal   
//BPU_7            bp(.clk(clk), .reset(reset), .BranchB(BranchB), .ZeroB(ZeroB), .BP(BP));              
endmodule