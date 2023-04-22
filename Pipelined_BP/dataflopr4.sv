module dataflopr4(input  logic        clk, reset,
                  input  logic [31:0] d0, d1, d2,
                  input  logic [4:0]  d3,
                  output logic [31:0] q0, q1, q2,
                  output logic [4:0]  q3
);

always_ff @(posedge clk, posedge reset)

    if(reset)
        begin
            q0 <= 0;
            q1 <= 0;
            q2 <= 0;
            q3 <= 0;
        end
        
    else
        begin
            q0 <= d0;
            q1 <= d1;
            q2 <= d2;
            q3 <= d3;        
        end

endmodule