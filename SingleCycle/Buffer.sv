module buff #(parameter WIDTH = 32)
            (input  logic [WIDTH-1:0] in,
             output logic [WIDTH-1:0] out
            );

logic [WIDTH-1:0] bet;

assign bet = in;
assign out = bet;

endmodule