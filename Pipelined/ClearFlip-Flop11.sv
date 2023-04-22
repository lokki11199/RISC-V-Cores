module clrflopr11(input  logic clk, reset, clear,
                  input  logic       PCSrcD1,
                  input  logic       BranchD,
                  input  logic       JumpD,
                  input  logic [1:0] ByteAccessD,
                  input  logic [2:0] ResultSrcD,
                  input  logic       MemWriteD,
                  input  logic [3:0] ALUControlD,
                  input  logic       ALUSrcD,
                  input  logic [2:0] ByteSrcD,
                  input  logic       RegWriteD,
                  
                  output logic       PCSrcE1,
                  output logic       BranchE,
                  output logic       JumpE,
                  output logic [1:0] ByteAccessE,
                  output logic [2:0] ResultSrcE,
                  output logic       MemWriteE,
                  output logic [3:0] ALUControlE,
                  output logic       ALUSrcE,
                  output logic [2:0] ByteSrcE,
                  output logic       RegWriteE
                  );
                  
always_ff @(posedge clk, posedge reset)
    if(reset)
        begin
            PCSrcE1     <= 1'b0;
            BranchE     <= 1'b0;
            JumpE       <= 1'b0;
            ByteAccessE <= 2'b0;
            ResultSrcE  <= 3'b0;
            MemWriteE   <= 1'b0;
            ALUControlE <= 4'b0;
            ALUSrcE     <= 1'b0;
            ByteSrcE    <= 3'b0;
            RegWriteE   <= 1'b0;   
        end
    else if(clear)
        begin
            PCSrcE1     <= 1'b0;
            BranchE     <= 1'b0;
            JumpE       <= 1'b0;
            ByteAccessE <= 2'b0;
            ResultSrcE  <= 3'b0;
            MemWriteE   <= 1'b0;
            ALUControlE <= 4'b0;
            ALUSrcE     <= 1'b0;
            ByteSrcE    <= 3'b0;
            RegWriteE   <= 1'b0;   
        end
    else
        begin
            PCSrcE1     <= PCSrcD1;
            BranchE     <= BranchD;
            JumpE       <= JumpD;
            ByteAccessE <= ByteAccessD;
            ResultSrcE  <= ResultSrcD;
            MemWriteE   <= MemWriteD;
            ALUControlE <= ALUControlD;
            ALUSrcE     <= ALUSrcD;
            ByteSrcE    <= ByteSrcD;
            RegWriteE   <= RegWriteD;   
        end

endmodule