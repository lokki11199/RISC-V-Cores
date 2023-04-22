module top(input  logic        clk, reset,
           input  logic        InstrWrite,
           input  logic [31:0] WriteInst, WriteAdress,
           output logic [31:0] WriteDataM, ALUResultM, ALUResultW,
           output logic        MemWriteM
          );

logic [31:0] InstrF, ReadData;
logic [1:0]  ByteAccessM, ByteAccessW;
logic [31:0] PCF;
logic        StallD;
logic        FlushD;
//logic [31:0] ReadData_b;
//logic [31:0] WriteDataM, ALUResultM;


pipelined p(clk, reset, InstrF, ReadData, PCF, ALUResultM, ALUResultW, WriteDataM, MemWriteM, ByteAccessM, ByteAccessW, StallD, FlushD);  

imemory i(clk, StallD, FlushD, InstrWrite, WriteInst, WriteAdress, PCF, InstrF);

dmemory d(clk, MemWriteM, ByteAccessM, ByteAccessW, ALUResultM, ALUResultW, WriteDataM, ReadData); 
//byte_read b(ALUResultM, ReadData_b, ByteAccessM, ReadData);

endmodule