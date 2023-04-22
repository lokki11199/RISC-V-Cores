module top(input  logic clk,
           input  logic reset,
           //output logic [31:0] Adr, WriteData,
           output logic        MemWrite
           );
logic [31:0] ReadData;
logic [31:0] Adr, WriteData;
logic [1:0]  ByteAccess;

multisycle m(clk, reset, ReadData, MemWrite, ByteAccess, Adr, WriteData);

dmemory    d(clk, MemWrite, ByteAccess, Adr, WriteData, ReadData);
           
endmodule