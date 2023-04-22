module alu (input  signed [31:0] scra, scrb, // огда нужно писать logic? ≈сли несколько присваиваний
//выбираетс€ последнее
            input         [3:0]  alucontrol,
            output logic  [31:0] aluresult,
            output logic        zero
            );
            

            
always_comb
    case(alucontrol)
        4'b0000: 
            begin //несколько выражений нужно группировать
                aluresult = scra + scrb; 
                zero      = 1'bx;
            end
        4'b0001: 
            begin
                aluresult = scra - scrb;
                zero      = 1'bx;
            end
        4'b0010:
            begin
                aluresult = scra & scrb;
                zero      = 1'bx;
            end
        4'b0011:
            begin
                aluresult = scra | scrb;
                zero      = 1'bx;
            end
        4'b0100:
            begin
                aluresult = scra ^ scrb;
                zero      = 1'bx;
            end
        4'b0101:
            begin
                aluresult = {31'b0, scra < scrb};
                zero      = scra < scrb;
            end
        4'b0110:
            begin
                aluresult = {31'b0, $unsigned(scra) < $unsigned(scrb)};
                zero      = $unsigned(scra) < $unsigned(scrb);
            end
        4'b0111:
            begin
                aluresult = scra << scrb[4:0];
                zero      = 1'bx;
            end
        4'b1000:
            begin
                aluresult = scra >> scrb[4:0];
                zero      = 1'bx;
            end
        4'b1001:
            begin
                aluresult = scra >>> scrb[4:0];
                zero      = 1'bx;
            end
        4'b1010:
            begin
                aluresult = 32'bx;
                zero      = scra == scrb;
            end
        4'b1011:
            begin
                aluresult = 32'bx;
                zero      = scra != scrb;
            end
        4'b1100:
            begin
                aluresult = 32'bx;
                zero      = scra >= scrb;
            end    
        4'b1101:
            begin
                aluresult = 32'bx;
                zero      = $unsigned(scra) >= $unsigned(scrb);
            end
         default:
            begin
                aluresult = 32'bx;
                zero      = 32'bx;
            end
    endcase
endmodule