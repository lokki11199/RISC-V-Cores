module top(input  logic        clk, reset,
           output logic [31:0] WriteDataM, ALUResultM,
           output logic        MemWriteM
          );

logic [31:0] InstrF, ReadData;
logic [1:0]  ByteAccessM;
logic [31:0] PCF;
//logic [31:0] WriteDataM, ALUResultM;


pipelined p(clk, reset, InstrF, ReadData, PCF, ALUResultM, WriteDataM, MemWriteM, ByteAccessM);  

imemory i(PCF, InstrF);

dmemory d(clk, MemWriteM, ByteAccessM, ALUResultM, WriteDataM, ReadData); 

endmodule