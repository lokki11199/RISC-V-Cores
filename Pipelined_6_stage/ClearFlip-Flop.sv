module clrflopr(input  logic clk, reset, clear,
                  input  logic [31:0] RD1D,
                  input  logic [31:0] RD2D,
                  input  logic [31:0] PCD,
                  input  logic [31:0] ImmExtD,
                  input  logic [4:0]  Rs1D,
                  input  logic [4:0]  Rs2D,
                  input  logic [4:0]  RdD,
                  input  logic [31:0] PCPlus4D,
                  
                  output logic [31:0] RD1E,
                  output logic [31:0] RD2E,
                  output logic [31:0] PCE,
                  output logic [31:0] ImmExtE,
                  output logic [4:0]  Rs1E,
                  output logic [4:0]  Rs2E,
                  output logic [4:0]  RdE,
                  output logic [31:0] PCPlus4E
                  );

always_ff @(posedge clk, posedge reset)
    if(reset)
        begin
            RD1E     <= 32'b0;
            RD2E     <= 32'b0;
            PCE      <= 32'b0;
            ImmExtE  <= 32'b0;
            Rs1E     <= 5'b0;
            Rs2E     <= 5'b0;
            RdE      <= 5'b0;
            PCPlus4E <= 32'b0;
        end
    else if(clear)
        begin
            RD1E     <= 32'b0;
            RD2E     <= 32'b0;
            PCE      <= 32'b0;
            ImmExtE  <= 32'b0;
            Rs1E     <= 5'b0;
            Rs2E     <= 5'b0;
            RdE      <= 5'b0;
            PCPlus4E <= 32'b0;   
        end
    else
        begin
            RD1E     <= RD1D;
            RD2E     <= RD2D;
            PCE      <= PCD;
            ImmExtE  <= ImmExtD;
            Rs1E     <= Rs1D;
            Rs2E     <= Rs2D;
            RdE      <= RdD;
            PCPlus4E <= PCPlus4D;    
        end

endmodule