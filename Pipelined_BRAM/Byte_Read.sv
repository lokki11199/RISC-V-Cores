module byte_read(input logic [31:0] ALUResult,
               input  logic [31:0] ReadData_b,
               input  logic [2:0]  ByteAccess,
               output logic [31:0] ReadData
               );

always_comb
    case(ByteAccess)
        2'b00: ReadData = ReadData_b;//lw
        2'b01: //lb, lbu
            case(ALUResult[1:0])
                2'b00: ReadData = {24'b0, ReadData_b[7:0]};
                2'b01: ReadData = {24'b0, ReadData_b[15:8]};
                2'b10: ReadData = {24'b0, ReadData_b[23:16]};
                2'b11: ReadData = {24'b0, ReadData_b[31:24]};
            endcase
        2'b10: //lh, lhu
            case(ALUResult[1])
                1'b0: ReadData = {16'b0, ReadData_b[15:0]};
                1'b1: ReadData = {16'b0, ReadData_b[31:16]};
            endcase 
        default:  ReadData = ReadData_b; 
    endcase
endmodule
