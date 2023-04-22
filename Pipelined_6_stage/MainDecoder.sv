module maindec(input  logic [6:0] op,
               output logic       Branch,
               output logic       Jump,
               output logic       PCSrc1,
               output logic [2:0] ResultSrc,
               output logic       MemWrite,
               output logic       ALUSrc,
               output logic       RegWrite,
               output logic [1:0] DecOp,
               output logic [2:0] ImmSrc
               );

logic [14:0] controls;

assign {RegWrite, DecOp, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch,
        Jump, PCSrc1} = controls;
        
always_comb
    case(op)
        7'b0000011: controls = 15'b1_00_000_1_0_100_0_0_0;
        7'b0010011: controls = 15'b1_11_000_1_0_000_0_0_0;
        7'b0010111: controls = 15'b1_10_100_x_0_011_0_0_0;
        7'b0100011: controls = 15'b0_00_001_1_1_000_0_0_0;
        7'b0110011: controls = 15'b1_11_xxx_0_0_000_0_0_0;
        7'b0110111: controls = 15'b1_10_100_x_0_001_0_0_0;
        7'b1100011: controls = 15'b0_01_010_0_0_000_1_0_0;
        7'b1100111: controls = 15'b1_00_000_1_0_010_0_0_1;
        7'b1101111: controls = 15'b1_10_011_x_0_010_0_1_0;
        default:    controls = 15'b0;
    endcase

endmodule
