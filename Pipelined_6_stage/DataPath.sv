module datapath(input  logic        clk, reset,
                input  logic [2:0]  ResultSrcB, 
                input  logic [2:0]  ResultSrcW,                   
                input  logic [1:0]  PCSrcB,
                input  logic [3:0]  ALUControlE,
                input  logic [3:0]  ALUControlB,
                input  logic        ALUSrcE,
                input  logic [2:0]  ByteSrcW,
                input  logic [2:0]  ImmSrcD,
                input  logic        RegWriteW,
                input  logic [31:0] InstrF,   
                input  logic [31:0] ReadData,    
                input  logic        StallF, StallD, FlushD, FlushE, FlushB,
                input  logic [1:0]  ForwardAE, ForwardBE,
                output logic        ZeroB,
                output logic [31:0] InstrD,
                output logic [31:0] PCF,
                output logic [31:0] ALUResultM, ForwardW,
                output logic [31:0] WriteDataM,
                output logic [4:0]  RdW, RdM, RdB, RdE, Rs2E, Rs1E, 
                output logic [4:0]  Rs2D, Rs1D        
                );
                
logic [31:0] PCF1, PCD, PCE;  
logic [31:0] PCPlus4F, PCPlus4D, PCPlus4E, PCPlus4B, PCPlus4M, PCPlus4W;
logic [31:0] RD1D, RD2D, RD1E, RD2E, WriteDataE, WriteDataB; //WriteDataE = RD2E    
logic [31:0] ImmExtD, ImmExtE, ImmExtB, ImmExtM, ImmExtW;
logic [4:0]  RdD;
logic [31:0] SrcAE, SrcBE, SrcB, SrcAB, SrcBB;
logic [31:0] ALUResultE, ALUResultB, ALUResultW;
logic [31:0] PCTargetE, PCTargetB, PCTargetM, PCTargetW;
logic [31:0] ReadDataW, ReadDataM;  
logic [31:0] ResultW; 
logic [31:0] ForwardM, ForwardB;   
                
//Fetch logic
mux3#(32)	 pcmux(PCPlus4F, PCTargetB, ALUResultB, PCSrcB, PCF1);
flopenr#(32) ff(clk, reset, StallF, PCF1, PCF);
adder	     pcadd4(PCF, 32'd4, PCPlus4F);
clrflopenr   fen(clk, reset, StallD, FlushD, PCF, PCPlus4F, PCD, PCPlus4D);
assign InstrD = InstrF;

//Decode logic
assign Rs1D = InstrD[19:15];
assign Rs2D = InstrD[24:20];
assign RdD = InstrD[11:7];
regfile      rf(clk, RegWriteW, InstrD[19:15], InstrD[24:20], RdW, ResultW, RD1D, RD2D);
extend1      ext1(InstrD[31:7], ImmSrcD, ImmExtD);
clrflopr     df(clk, reset, FlushE, RD1D, RD2D, PCD, ImmExtD, Rs1D, Rs2D, RdD, PCPlus4D,
                RD1E, RD2E, PCE, ImmExtE, Rs1E, Rs2E, RdE, PCPlus4E);
                
//Execute logic

mux4#(32)    srcamux(RD1E, ForwardB, ForwardM, ResultW, ForwardAE, SrcAE);
mux4#(32)    srcbmux(RD2E, ForwardB, ForwardM, ResultW, ForwardBE, WriteDataE);
mux2#(32)    srcbemux(WriteDataE, ImmExtE, ALUSrcE, SrcBE);
alu		     alu(SrcAE, SrcBE, ALUControlE, ALUResultE);
adder	     pcaddbranch(PCE, ImmExtE, PCTargetE);
eflopr7      ef(clk, reset, FlushB, SrcAE, ALUResultE, SrcBE, WriteDataE, PCTargetE, ImmExtE, RdE, PCPlus4E,
                SrcAB, ALUResultB, SrcBB, WriteDataB, PCTargetB, ImmExtB, RdB, PCPlus4B);
                
//Branch logic
branch       branch(SrcAB, SrcBB, ALUControlB, ZeroB);
mux4#(32)    forwardmux(ALUResultB, ImmExtB, PCPlus4B, PCTargetB, ResultSrcB[1:0], ForwardB);
dataflopr4   b(clk, reset, ALUResultB, WriteDataB, ForwardB, RdB, ALUResultM, WriteDataM,
               ForwardM, RdM);
              
//Memory logic
extend2      ext2(ReadData, ByteSrcW, ReadDataM);
flopr3       mf(clk, reset, ForwardM, RdM, ForwardW, RdW);
assign ReadDataW = ReadDataM;              
//WriteBack logic
mux2#(32)    wmux(ForwardW, ReadDataW, ResultSrcW[2], ResultW);




endmodule