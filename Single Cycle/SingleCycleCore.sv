module singlecycle (input  logic        clk, reset,
                    input  logic [31:0] Instr,
                    input  logic [31:0] ReadData,
                    output logic [31:0] PC,
                    output logic [31:0] ALUResult,
                    output logic [31:0] WriteData,
                    output logic        MemWrite,
                    output logic [1:0]  ByteAccess
                    );

logic Zero, RegWrite, ALUSrc;
logic [1:0] PCSrc;
logic [2:0] ResultSrc, ImmSrc, ByteSrc;
logic [3:0] ALUControl;

controlunit c(Instr[6:0], Instr[14:12], Instr[30], Zero, PCSrc, ResultSrc, MemWrite, 
              ALUSrc, RegWrite, ByteAccess, ALUControl, ByteSrc, ImmSrc);

datapath data(clk, reset, ResultSrc, PCSrc, ALUControl, ALUSrc, ByteSrc, 
           ImmSrc, RegWrite, Instr, ReadData, Zero, PC, ALUResult, WriteData);
endmodule