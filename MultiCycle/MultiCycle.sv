module multisycle(input  logic        CLK,
                  input  logic        Reset,
                  input  logic [31:0] ReadData,
                  output logic        MemWrite,
                  output logic [1:0]  ByteAccess,
                  output logic [31:0] Adr,
                  output logic [31:0] WriteData
                  );

logic [31:0] Instr, PC, Result;                  
logic [3:0]  ALUControl;
logic [2:0]  ImmSrc, ByteSrc;
logic [1:0]  ResultSrc, ALUSrcA, ALUSrcB;
logic        RegWrite, PCWrite, AdrSrc, IRWrite, Zero;

mux2#(32)   dmux(PC, Result, AdrSrc, Adr);

datapath    d(CLK, Reset, ReadData, IRWrite, PCWrite, RegWrite, ImmSrc, ByteSrc, ALUSrcA, ALUSrcB, ALUControl,
              ResultSrc, Zero, Instr, PC, Result, WriteData);
            
controlunit c(CLK, Reset, Instr[6:0], Instr[14:12], Instr[30], Zero, PCWrite, ResultSrc, ALUSrcB, ALUSrcA, RegWrite, AdrSrc, MemWrite, IRWrite,
              ByteAccess, ALUControl, ByteSrc, ImmSrc);


endmodule