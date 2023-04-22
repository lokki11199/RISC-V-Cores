module enflopr #(parameter WIDTH = 32)
               (input  logic        CLK, Reset, Enable,
                input  logic [WIDTH-1:0] d,
                output logic [WIDTH-1:0] q
               );
               
always_ff @(posedge CLK, posedge Reset)
    if(Reset)
        q <= 0;
    else if(Enable)
        q <= d;
    

endmodule