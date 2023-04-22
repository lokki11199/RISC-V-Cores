module dmemory(input  logic        clk,
               input  logic        MemWrite,
               input  logic [1:0]  ByteAccess,
               input  logic [31:0] ALUResult,//Adr in Multi-Sycle Core
               input  logic [31:0] WriteData,
               output logic [31:0] ReadData
               );
               
logic [31:0] memory [63:0];
    

always_comb
    case(ByteAccess)
        2'b00: ReadData = memory[ALUResult[31:2]];//lw
        2'b01: //lb, lbu
            case(ALUResult[1:0])
                2'b00: ReadData = {24'b0, memory[ALUResult[31:2]][7:0]};
                2'b01: ReadData = {24'b0, memory[ALUResult[31:2]][15:8]};
                2'b10: ReadData = {24'b0, memory[ALUResult[31:2]][23:16]};
                2'b11: ReadData = {24'b0, memory[ALUResult[31:2]][31:24]};
            endcase
        2'b10: //lh, lhu
            case(ALUResult[1])
                1'b0: ReadData = {16'b0, memory[ALUResult[31:2]][15:0]};
                1'b1: ReadData = {16'b0, memory[ALUResult[31:2]][31:16]};//
            endcase 
        default:  ReadData = memory[ALUResult[31:2]]; 
    endcase
    
always_ff @(posedge clk)
    if(MemWrite)
        begin
            case(ByteAccess)
                2'b00: memory[ALUResult[31:2]] <= WriteData;//sw
                2'b01: //sb
                    case(ALUResult[1:0])
                        2'b00: memory[ALUResult[31:2]][7:0]   <= WriteData[7:0];
                        2'b01: memory[ALUResult[31:2]][15:8]  <= WriteData[7:0];
                        2'b10: memory[ALUResult[31:2]][23:16] <= WriteData[7:0];
                        2'b11: memory[ALUResult[31:2]][31:24] <= WriteData[7:0];
                    endcase
                2'b10: //sh
                    case(ALUResult[1])
                        1'b0: memory[ALUResult[31:2]][15:0]  <= WriteData[15:0];
                        1'b1: memory[ALUResult[31:2]][31:16] <= WriteData[15:0];
                    endcase
            endcase
        end
    

endmodule
