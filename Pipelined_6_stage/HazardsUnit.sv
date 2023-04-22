module hazardsunit(
                   input  logic        RegWriteW,
                   input  logic [1:0]  PCSrcB,
                   input  logic        RegWriteM,
                   input  logic        RegWriteB,
                   input  logic [2:0]  ResultSrcE,
                   input  logic [2:0]  ResultSrcB,
                   input  logic [4:0]  RdW,
                   input  logic [4:0]  RdM,
                   input  logic [4:0]  RdB,
                   input  logic [4:0]  RdE,
                   input  logic [4:0]  Rs2E,
                   input  logic [4:0]  Rs1E,
                   input  logic [4:0]  Rs2D,
                   input  logic [4:0]  Rs1D,
                   
                   output logic        StallF,
                   output logic        StallD,
                   output logic        FlushD,
                   output logic        FlushE,
                   output logic        FlushB,
                   output logic [1:0]  ForwardAE,
                   output logic [1:0]  ForwardBE
                   );
                   
logic lStall, cStall;                   

always_comb // ForwardAE
    if (((Rs1E == RdB) & RegWriteB) & (Rs1E != 0)) //forward from Branch stage
        ForwardAE = 2'b01;
    else if (((Rs1E == RdM) & RegWriteM) & (Rs1E != 0)) //forward from memory stage
        ForwardAE = 2'b10;
    else if(((Rs1E == RdW) & RegWriteW) & (Rs1E != 0))//forward from writeback stage
        ForwardAE = 2'b11;
    else
        ForwardAE = 2'b00;  //no forwarding
        
always_comb // ForwardBE
    if (((Rs2E == RdB) & RegWriteB) & (Rs2E != 0)) //forward from Branch stage
        ForwardBE = 2'b01;
    else if (((Rs2E == RdM) & RegWriteM) & (Rs2E != 0)) //forward from memory stage
        ForwardBE = 2'b10; 
    else if(((Rs2E == RdW) & RegWriteW) & (Rs2E != 0))//forward from writeback stage
        ForwardBE = 2'b11;
    else
        ForwardBE = 2'b00;  //no forwarding
        
assign lStall = ((ResultSrcE == 3'b100) & ((Rs1D == RdE) | (Rs2D == RdE))) | ((ResultSrcB == 3'b100) & ((Rs1D == RdB) | (Rs2D == RdB)));
assign StallF = lStall;
assign StallD = lStall;

assign cStall = (PCSrcB != 2'b00);
assign FlushD = cStall;
assign FlushB = cStall;
assign FlushE = (lStall | cStall);

endmodule