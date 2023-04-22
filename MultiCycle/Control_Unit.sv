module controlunit(input  logic       CLK, Reset,
                   input  logic [6:0] op,
                   input  logic [2:0] funct3,
                   input  logic       funct7b5,
                   input  logic       Zero,
                   output logic       PCWrite,
                   output logic [1:0] ResultSrc,
                   output logic [1:0] ALUSrcB,
                   output logic [1:0] ALUSrcA,
                   output logic       RegWrite,
                   output logic       AdrSrc,
                   output logic       MemWrite,
                   output logic       IRWrite,
                   output logic [1:0] ByteAccess,
                   output logic [3:0] ALUControl,
                   output logic [2:0] ByteSrc,
                   output logic [2:0] ImmSrc
                  );
                  
logic       Branch, PCUpdate;
logic [1:0] DecOp;

fsm      m(CLK, Reset, op, Branch, PCUpdate, ResultSrc, ALUSrcB, ALUSrcA, RegWrite, AdrSrc, MemWrite, IRWrite, DecOp);

functdec f(DecOp, op[5], funct3, funct7b5, ByteAccess, ALUControl, ByteSrc);

immdec   i(op, ImmSrc);

assign PCWrite = PCUpdate | (Zero & Branch);
                  

endmodule