module clrflopr9(input  logic clk, reset, clear,
                  input  logic       PCSrcE1,
                  input  logic       BranchE,
                  input  logic       JumpE,
                  input  logic [1:0] ByteAccessE,
                  input  logic [2:0] ResultSrcE,
                  input  logic       MemWriteE,
                  input  logic [3:0] ALUControlE,
                  input  logic [2:0] ByteSrcE,
                  input  logic       RegWriteE,
                  
                  output logic       PCSrcB1,
                  output logic       BranchB,
                  output logic       JumpB,
                  output logic [1:0] ByteAccessB,
                  output logic [2:0] ResultSrcB,
                  output logic       MemWriteB,
                  output logic [3:0] ALUControlB,
                  output logic [2:0] ByteSrcB,
                  output logic       RegWriteB
                  );
                  
always_ff @(posedge clk, posedge reset)
    if(reset)
        begin
            PCSrcB1     <= 1'b0;
            BranchB     <= 1'b0;
            JumpB       <= 1'b0;
            ByteAccessB <= 2'b0;
            ResultSrcB  <= 3'b0;
            MemWriteB   <= 1'b0;
            ALUControlB <= 4'b0;
            ByteSrcB    <= 3'b0;
            RegWriteB   <= 1'b0;   
        end
    else if(clear)
        begin
            PCSrcB1     <= 1'b0;
            BranchB     <= 1'b0;
            JumpB       <= 1'b0;
            ByteAccessB <= 2'b0;
            ResultSrcB  <= 3'b0;
            MemWriteB   <= 1'b0;
            ALUControlB <= 4'b0;
            ByteSrcB    <= 3'b0;
            RegWriteB   <= 1'b0;   
        end
    else
        begin
            PCSrcB1     <= PCSrcE1;
            BranchB     <= BranchE;
            JumpB       <= JumpE;
            ByteAccessB <= ByteAccessE;
            ResultSrcB  <= ResultSrcE;
            MemWriteB   <= MemWriteE;
            ALUControlB <= ALUControlE;
            ByteSrcB    <= ByteSrcE;
            RegWriteB   <= RegWriteE;   
        end

endmodule