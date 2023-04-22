module flopr2 #(parameter WIDTH = 32)
               (input  logic CLK, Reset,
                input  logic [WIDTH-1:0] d1, d2,
                output logic [WIDTH-1:0] q1, q2
               );
               
always_ff @(posedge CLK, posedge Reset)
    if(Reset)
        begin 
            q1 <= 0; q2 <= 0; 
        end
    else
        begin
            q1 <= d1;
            q2 <= d2;
        end
endmodule