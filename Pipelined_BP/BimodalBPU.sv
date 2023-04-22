module BPU(input  logic        clk, reset,
           input  logic        BranchB,
           input  logic        ZeroB,
           input  logic [31:0] InstrF,
           input  logic [31:0] PCF,
           output logic [31:0] BPTarget,
           output logic        BP
           );
logic [31:0] immext;
logic Prediction;
assign immext = {{20{InstrF[31]}}, InstrF[7], InstrF[30:25], InstrF[11:8], 1'b0};
assign BPTarget = $signed(PCF) + $signed(immext);
satcount fsm(.clk(clk), .reset(reset), .Zero(ZeroB), .BP(Prediction), .Branch(BranchB));

always_comb
    if(InstrF[6:0] == 7'b1100011)
        begin
            BP = Prediction;
        end
    else
        begin
            BP = 0;
        end

endmodule