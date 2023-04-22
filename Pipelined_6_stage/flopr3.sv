module flopr3(input  logic        clk, reset,
                  input  logic [31:0] d1, //delete d0
                  input  logic [4:0]  d2,
                  output logic [31:0] q1, //delete d0
                  output logic [4:0]  q2
);

always_ff @(posedge clk, posedge reset)

    if(reset)
        begin
            //q0 <= 0;
            q1 <= 0;
            q2 <= 0;
        end
        
    else
        begin
            //q0 <= d0;
            q1 <= d1;
            q2 <= d2;       
        end

endmodule