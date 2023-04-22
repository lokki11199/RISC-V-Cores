module flopr4(input  logic clk, reset,
              input  logic [2:0] ResultSrcM,
              input  logic       RegWriteM,
                  
              output logic [2:0] ResultSrcW,
              output logic       RegWriteW
              );
                  
always_ff @(posedge clk, posedge reset)
    if(reset)
        begin
            ResultSrcW  <= 3'b0;
            RegWriteW   <= 1'b0;   
        end
    else
        begin
            ResultSrcW  <= ResultSrcM;
            RegWriteW   <= RegWriteM;   
        end

endmodule