module dram(input  logic        clk,
               input  logic        MemWrite,
               input  logic [1:0]  ByteAccess,
               input  logic [31:0] ALUResult,//Adr in Multi-Sycle Core
               input  logic [31:0] WriteData,
               output logic [31:0] ReadData
               );
               
//(* ram_decomp = "power" *) logic [31:0] memory [8191:0];
(* ram_style = "block" *) logic [31:0] memory [4095:0];
initial
    begin
        integer i;
        for(i = 0; i <= 4095; i = i+1)
        memory[i][31:0] = 32'b0;   
    end
    
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
                default: memory[ALUResult[31:2]] <= WriteData;
            endcase
        end
//    else
//        begin
//            ReadData[31:0] <= memory[ALUResult[31:2]][31:0];       
//      end

always_ff @(posedge clk)
    if(!MemWrite)
            ReadData[31:0] <= memory[ALUResult[31:2]][31:0];
endmodule
