module BPU_2 #(parameter MEM_SIZE = 4)
          (input  logic        clk, reset,
           input  logic        BranchB,
           input  logic        ZeroB,
           input  logic [31:0] PCF, PCB,
           output logic        BP
           );

logic Zero_ST   [2**MEM_SIZE - 1:0];
logic BP_ST     [2**MEM_SIZE - 1:0];
logic Branch_ST [2**MEM_SIZE - 1:0];
integer f = 0;
always_comb
    begin
        //integer i;
        for(f=0; f < 2**MEM_SIZE; f = f + 1)
            begin
                Zero_ST[f] = (f == PCB[MEM_SIZE+1:2]) ? ZeroB : 0; //так с кайфом
                Branch_ST[f] = (f == PCB[MEM_SIZE+1:2]) ? BranchB : 0;
            end
    end

genvar i;
generate
    for(i = 0; i < 2**MEM_SIZE; i = i + 1)
        begin
            satcount_2bit fsm(.clk(clk), .reset(reset), .Zero(Zero_ST[i]), .BP(BP_ST[i]), .Branch(Branch_ST[i]));
        end
endgenerate

assign BP = BP_ST[PCF[MEM_SIZE+1:2]];

endmodule