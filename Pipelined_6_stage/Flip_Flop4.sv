module flopr4(input  logic clk, reset,
              input  logic [2:0] ResultSrcM,
              input  logic       RegWriteM,
              input  logic [2:0] ByteSrcM,
              input  logic [1:0] ByteAccessM,
                  
              output logic [2:0] ResultSrcW,
              output logic       RegWriteW,
              output logic [2:0] ByteSrcW,
              output logic [1:0] ByteAccessW
              );
                  
always_ff @(posedge clk, posedge reset)
    if(reset)
        begin
            ResultSrcW  <= 3'b0;
            RegWriteW   <= 1'b0;  
            ByteSrcW   <= 3'b0;   
            ByteAccessW <= 2'b0;  
        end
    else
        begin
            ResultSrcW  <= ResultSrcM;
            RegWriteW   <= RegWriteM;   
            ByteSrcW   <= ByteSrcM;   
            ByteAccessW <= ByteAccessM;
        end

endmodule