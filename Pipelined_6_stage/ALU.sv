module alu (input  logic signed [31:0] scra, scrb, // огда нужно писать logic? ≈сли несколько присваиваний
//выбираетс€ последнее
            input  logic  [3:0]  alucontrol,
            output logic  [31:0] aluresult
            );
            

            
always_comb
    unique case(alucontrol)
        4'b0000: 
            begin //несколько выражений нужно группировать
                aluresult = scra + scrb; 
            end
        4'b0001: 
            begin
                aluresult = scra - scrb;
            end
        4'b0010:
            begin
                aluresult = scra & scrb;
            end
        4'b0011:
            begin
                aluresult = scra | scrb;
            end
        4'b0101:
            begin
                aluresult = {31'b0, scra < scrb};
            end
        4'b0100:
            begin
                aluresult = scra ^ scrb;
            end
        4'b0111:
            begin
                aluresult = scra << scrb[4:0];
            end
        4'b1000:
            begin
                aluresult = scra >> scrb[4:0];
            end
        4'b1001:
            begin
                aluresult = scra >>> scrb[4:0];
            end
//         default:
//            begin
//                aluresult = 32'b0;
//            end
    endcase
endmodule