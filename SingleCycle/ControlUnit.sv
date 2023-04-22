module controlunit (input  logic [6:0] op,
                    input  logic [2:0] funct3,
                    input  logic       funct7b5,
                    input  logic       Zero,
                    output logic [1:0] PCSrc,
                    output logic [2:0] ResultSrc,
                    output logic       MemWrite,
                    output logic       ALUSrc,
                    output logic       RegWrite,
                    output logic [1:0] ByteAccess,
                    output logic [3:0] ALUControl,
                    output logic [2:0] ByteSrc,
                    output logic [2:0] ImmSrc
                    );
                    
logic [1:0] DecOp;
logic       Branch, Jump;
                    
maindec  m(op, Branch, Jump, PCSrc[1], ResultSrc, MemWrite, ALUSrc,
          RegWrite, DecOp, ImmSrc);
          
functdec f(DecOp, op[5], funct3, funct7b5, ByteAccess,
           ALUControl, ByteSrc);
           
assign PCSrc[0] = (Zero & Branch) | Jump;

endmodule