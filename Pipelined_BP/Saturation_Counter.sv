module satcount(input  logic clk, reset,
                input  logic Zero,
                input  logic Branch,
                output logic BP
                );

logic [1:0] state, nextstate, prevstate;

localparam snt = 2'b00, // strongly not taken
           wnt = 2'b01, // weakly not taken
           wt  = 2'b10, // weakly taken
           st  = 2'b11; // strongly taken
           
always_ff @(posedge clk)
    if(reset)
        state <= snt;
    else if(Branch)
        begin
            if(Zero)
                state <= nextstate;
            else
                state <= prevstate;
        end

assign BP = state[1];

always_comb
    case(state)
        snt: begin nextstate = wnt; prevstate = snt; end
        wnt: begin nextstate = wt; prevstate = snt;  end
        wt:  begin nextstate = st; prevstate = wnt;  end
        st:  begin nextstate = st; prevstate = wt;   end
    endcase
endmodule