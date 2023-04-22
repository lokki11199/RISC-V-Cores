module satcount_1bit(input  logic clk, reset,
                input  logic Zero,
                input  logic Branch,
                output logic BP
                );

logic state, nextstate, prevstate;

localparam nt = 1'b0, // not taken
           t  = 1'b1; // taken
           
always_ff @(posedge clk)
    if(reset)
        state <= nt;
    else if(Branch)
        begin
            if(Zero)
                state <= nextstate;
            else
                state <= prevstate;
        end

assign BP = state;

always_comb
    case(state)
        nt: begin nextstate = t; prevstate = nt; end
        t:  begin nextstate = t; prevstate = nt; end
    endcase
endmodule