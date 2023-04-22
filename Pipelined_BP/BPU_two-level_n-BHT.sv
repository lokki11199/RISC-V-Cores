module BPU_6 #(parameter BHT_WIDTH = 4, BHT_DEPTH = 7)
          (input  logic        clk, reset,
           input  logic        BranchB,
           input  logic        ZeroB,
           input  logic [31:0] PCF, PCB,
           output logic        BP
           );
           
logic [BHT_WIDTH-1:0] BHT [2**BHT_DEPTH-1:0]; //при вызове векторного массива сначала индексируется массив, потом биты BHT[0][1:0] 2 бита нуулевого элемента
logic [2**BHT_WIDTH-1:0] Zero_ST [2**BHT_DEPTH-1:0];
logic [2**BHT_WIDTH-1:0] Branch_ST [2**BHT_DEPTH-1:0];
logic [2**BHT_WIDTH-1:0] BP_ST [2**BHT_DEPTH-1:0];

genvar i,j;
generate
    for(j = 0; j < 2**BHT_DEPTH;j = j + 1)
        begin
            for(i = 0; i < 2**BHT_WIDTH; i = i + 1)
                begin
                    satcount_2bit fsm(.clk(clk), .reset(reset), .Zero(Zero_ST[j][i]), .Branch(Branch_ST[j][i]), .BP(BP_ST[j][i]));
                end
        end
endgenerate

integer f,g;
always_comb
    begin 
        for(g = 0; g < 2**BHT_DEPTH; g = g + 1)
            begin
                for(f = 0; f < 2**BHT_WIDTH; f = f + 1)
                    begin
//                        Zero_ST[f][g]   = ((f == BHT[g][BHT_WIDTH-1:0])&(g == PCB[2**BHT_DEPTH-1:2])) ? ZeroB : 0;
//                        Branch_ST[f][g] = ((f == BHT[g][BHT_WIDTH-1:0])&(g == PCB[2**BHT_DEPTH-1:2])) ? BranchB : 0;
                        if((f == BHT[PCB[BHT_DEPTH+1:2]])&(g == PCB[BHT_DEPTH+1:2]))
                            begin
                                Zero_ST[g][f]   = ZeroB;
                                Branch_ST[g][f] = BranchB;
                            end
                        else
                            begin
                                Zero_ST[g][f]   = 0;
                                Branch_ST[g][f] = 0;
                            end                        
                    end
            end
    end
integer s;           
always_ff @(posedge clk)
    if(reset)
        begin
            //integer i;
            for(s = 0; s < 2**BHT_DEPTH; s = s + 1)
                begin
                    BHT[s] <= 0;
                end          
        end
    else if(BranchB)
        begin    
            BHT[PCB[BHT_DEPTH+1:2]]    <= BHT[PCB[BHT_DEPTH+1:2]] << 1;
            BHT[PCB[BHT_DEPTH+1:2]][0] <= ZeroB;
        end
    else
        begin
            for(s = 0; s < 2**BHT_DEPTH; s = s + 1)
                begin
                    BHT[s] <= BHT[s];
                end              
        end
    
assign BP = BP_ST[PCF[BHT_DEPTH+1:2]][BHT[PCF[BHT_DEPTH+1:2]]];

           
endmodule