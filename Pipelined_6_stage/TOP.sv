module top(input  logic        clk, reset,
           input  logic        InstrWrite,
           input  logic [31:0] WriteInst, WriteAdress,
           output logic [31:0] WriteDataM, ALUResultM, ForwardW,
           output logic        MemWriteM
           //output logic [31:0] InstrF
          );

logic [31:0] InstrF, ReadData;
//logic [31:0] ReadData;
logic [1:0]  ByteAccessM, ByteAccessW;
logic [31:0] PCF;
logic        StallD;
logic        FlushD;
//logic [31:0] WriteDataM, ALUResultM;


pipelined p(clk, reset, InstrF, ReadData, PCF, ALUResultM, ForwardW, WriteDataM, MemWriteM, ByteAccessM, ByteAccessW, StallD, FlushD);  

imemory i(clk, StallD, FlushD, InstrWrite, WriteInst, WriteAdress, PCF, InstrF);

dmemory d(clk, MemWriteM, ByteAccessM, ByteAccessW, ALUResultM, ForwardW, WriteDataM, ReadData ); 

endmodule