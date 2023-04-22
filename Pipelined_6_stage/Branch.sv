module branch(input  logic signed [31:0] scra, scrb,
              input  logic        [3:0]  alucontrol,
              output logic               zero);

always_comb
    case(alucontrol)
        4'b0101:
            begin
                zero      = scra < scrb;
            end
        4'b0110:
            begin
                zero      = $unsigned(scra) < $unsigned(scrb);
            end
        4'b1010:
            begin
                zero      = scra == scrb;
            end
        4'b1011:
            begin
                zero      = scra != scrb;
            end
        4'b1100:
            begin
                zero      = scra >= scrb;
            end    
        4'b1101:
            begin
                zero      = $unsigned(scra) >= $unsigned(scrb);
            end
         default:
            begin
                zero      = 32'b0;
            end
    endcase

endmodule