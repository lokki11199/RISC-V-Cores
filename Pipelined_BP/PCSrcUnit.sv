module PCSrcU(input  logic       BPD,
              input  logic       PCSrcB1,
              input  logic       BranchB,
              input  logic       JumpB,
              input  logic       ZeroB,
              input  logic       BPB,
              input  logic [6:0] op,
              output logic [2:0] PCSrcB
              );
              
logic [5:0] controls;
assign controls = {BPD, PCSrcB1, BranchB, JumpB, ZeroB, BPB};

always_comb
    casex(controls)
        7'bx100xx: PCSrcB = 3'b010;
        7'bx001xx: PCSrcB = 3'b001;
        7'b001000: PCSrcB = 3'b000;
        7'bx01001: PCSrcB = 3'b100;
        7'bx01010: PCSrcB = 3'b001;
        7'b001011: PCSrcB = 3'b000;
        7'b101000: 
            begin
                if(op == 7'b1100011)
                    PCSrcB = 3'b011;
                else
                    PCSrcB = 3'b000;
            end
        7'b101011: 
            begin
                if(op == 7'b1100011)
                    PCSrcB = 3'b011;
                else
                    PCSrcB = 3'b000;
            end
        7'b0000xx: PCSrcB = 3'b000;
        7'b1000xx: 
            begin
                if(op == 7'b1100011)
                    PCSrcB = 3'b011;
                else
                    PCSrcB = 3'b000;
            end
        default:   PCSrcB = 3'b000;
    endcase
endmodule