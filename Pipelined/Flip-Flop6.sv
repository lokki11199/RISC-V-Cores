module flopr6(input  logic clk, reset,
              input  logic [1:0] ByteAccessE,
              input  logic [2:0] ResultSrcE,
              input  logic       MemWriteE,
              input  logic [2:0] ByteSrcE,
              input  logic       RegWriteE,
                  
              output logic [1:0] ByteAccessM,
              output logic [2:0] ResultSrcM,
              output logic       MemWriteM,
              output logic [2:0] ByteSrcM,
              output logic       RegWriteM
              );
                  
always_ff @(posedge clk, posedge reset)
    if(reset)
        begin
            ByteAccessM <= 2'b0;
            ResultSrcM  <= 3'b0;
            MemWriteM   <= 1'b0;
            ByteSrcM    <= 3'b0;
            RegWriteM   <= 1'b0;   
        end
    else
        begin
            ByteAccessM <= ByteAccessE;
            ResultSrcM  <= ResultSrcE;
            MemWriteM   <= MemWriteE;
            ByteSrcM    <= ByteSrcE;
            RegWriteM   <= RegWriteE;   
        end

endmodule