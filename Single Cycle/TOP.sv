module top(input  logic        clk, reset,
           output logic [31:0] WriteData, ALUResult,
           output logic        MemWrite
           );

logic [31:0]  Instr, ReadData;
logic [1:0] ByteAccess;
logic [31:0] PC;

singlecycle s(clk, reset, Instr, ReadData, PC, ALUResult, WriteData, MemWrite, ByteAccess);

imemory i(PC, Instr);

dmemory d(clk, MemWrite, ByteAccess, ALUResult, WriteData, ReadData);

endmodule