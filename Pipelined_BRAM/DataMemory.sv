module dmemory(input  logic        clk,
               input  logic        MemWrite,
               input  logic [1:0]  ByteAccessM, ByteAccessW,
               input  logic [31:0] ALUResultM, ALUResultW,//Adr in Multi-Sycle Core
               input  logic [31:0] WriteData,
               output logic [31:0] ReadData
               );
logic [31:0] ReadData_b;          
dram dram_1(clk, MemWrite, ByteAccessM, ALUResultM, WriteData, ReadData_b);

always_comb
    case(ByteAccessW)
        2'b00: ReadData = ReadData_b;//lw
        2'b01: //lb, lbu
            case(ALUResultW[1:0])
                2'b00: ReadData = {24'b0, ReadData_b[7:0]};
                2'b01: ReadData = {24'b0, ReadData_b[15:8]};
                2'b10: ReadData = {24'b0, ReadData_b[23:16]};
                2'b11: ReadData = {24'b0, ReadData_b[31:24]};
            endcase
        2'b10: //lh, lhu
            case(ALUResultW[1])
                1'b0: ReadData = {16'b0, ReadData_b[15:0]};
                1'b1: ReadData = {16'b0, ReadData_b[31:16]};
            endcase 
        default:  ReadData = ReadData_b; 
    endcase
endmodule
