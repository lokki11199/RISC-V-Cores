module BPU_3(input  logic        clk, reset,
           input  logic        BranchB,
           input  logic        ZeroB,
           input  logic [31:0] PCF,
           output logic        BP
           );

satcount_1bit fsm(.clk(clk), .reset(reset), .Zero(ZeroB), .BP(BP), .Branch(BranchB));


endmodule