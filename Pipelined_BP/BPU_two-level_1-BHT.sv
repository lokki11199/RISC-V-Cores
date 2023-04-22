module BPU_5 #(parameter BHT_WIDTH = 2)
          (input  logic        clk, reset,
           input  logic        BranchB,
           input  logic        ZeroB,
           input  logic [31:0] PCF,
           output logic        BP
           );
           
logic [BHT_WIDTH-1:0] BHT;
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

always_comb
    begin 
        integer j;
        for(j = 0; j < 2**BHT_WIDTH; j = j + 1)
            begin
                Zero_ST[j]   = (j == BHT) ? ZeroB : 0;
                Branch_ST[j] = (j == BHT) ? BranchB : 0;
            end
    end
    
assign BP = BP_ST[BHT];
           
always_ff @(posedge clk)
    if(reset)
        BHT <= 0;
    else
        begin  
            BHT <= BHT << 1;
            BHT[0] <= BP_ST[BHT];
        end
           
endmodule