module BPU_7 #(parameter BHT_WIDTH = 13)
          (input  logic        clk, reset,
           input  logic        BranchB,
           input  logic        ZeroB,
           output logic        BP
           );
           
logic [BHT_WIDTH-1:0] BHT;
//logic [2**BHT_WIDTH-1:0] Zero_ST;
//logic [2**BHT_WIDTH-1:0] Branch_ST;
//logic [2**BHT_WIDTH-1:0] BP_ST;
logic Zero_ST [2**BHT_WIDTH-1:0];
logic Branch_ST [2**BHT_WIDTH-1:0];
logic BP_ST [2**BHT_WIDTH-1:0];

genvar i;
generate
    for(i = 0; i < 2**BHT_WIDTH; i = i + 1)
        begin
            satcount_2bit fsm(.clk(clk), .reset(reset), .Zero(Zero_ST[i]), .Branch(Branch_ST[i]), .BP(BP_ST[i]));
        end
endgenerate

integer f;
always_comb
    begin
        for(f = 0; f < 2**BHT_WIDTH; f = f + 1)
            begin
//                        Zero_ST[f][g]   = ((f == BHT[g][BHT_WIDTH-1:0])&(g == PCB[2**BHT_DEPTH-1:2])) ? ZeroB : 0;
//                        Branch_ST[f][g] = ((f == BHT[g][BHT_WIDTH-1:0])&(g == PCB[2**BHT_DEPTH-1:2])) ? BranchB : 0;
                if(f == BHT)
                    begin
                        Zero_ST[f]   = ZeroB;
                        Branch_ST[f] = BranchB;
                    end
                else
                    begin
                        Zero_ST[f]   = 0;
                        Branch_ST[f] = 0;
                    end                        
            end
    end         
always_ff @(posedge clk)
    if(reset)
        begin
            BHT <= 0;   
        end
    else if(BranchB)
        begin    
            BHT    <= BHT << 1;
            BHT[0] <= ZeroB;
        end            
    
assign BP = BP_ST[BHT];

           
endmodule