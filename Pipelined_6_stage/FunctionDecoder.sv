module functdec(input  logic [1:0] DecOp,
                input  logic       op5,
                input  logic [2:0] funct3,
                input  logic       funct7b5,
                output logic [1:0] ByteAccess,
                output logic [3:0] ALUControl,
                output logic [2:0] ByteSrc
                );

always_comb
    case(DecOp)
        3'b00: 
            begin
                ALUControl = 4'b0000;
                        case(funct3)
                            3'b000:  begin ByteAccess = 2'b01; ByteSrc = 3'b010; end
                            3'b001:  begin ByteAccess = 2'b10; ByteSrc = 3'b011; end
                            3'b010:  begin ByteAccess = 2'b00; ByteSrc = 3'b100; end
                            3'b100:  begin ByteAccess = 2'b01; ByteSrc = 3'b000; end
                            3'b101:  begin ByteAccess = 2'b10; ByteSrc = 3'b001; end
                            default: begin ByteAccess = 2'b00; ByteSrc = 3'b000; end
                            endcase
            end
        3'b01:
            begin
                ByteAccess = 2'b00; ByteSrc = 3'bxx;
                case(funct3)
                    3'b000:  ALUControl = 4'b1010;
                    3'b001:  ALUControl = 4'b1011;
                    3'b100:  ALUControl = 4'b0101;
                    3'b101:  ALUControl = 4'b1100;
                    3'b110:  ALUControl = 4'b0110;
                    3'b111:  ALUControl = 4'b1101;
                    default: ALUControl = 4'b0000;
                endcase
            end
        3'b10: begin ALUControl = 4'bxxxx; ByteAccess = 2'b00; ByteSrc = 3'bxx; end
        3'b11:
            begin
                ByteAccess = 2'b00; ByteSrc = 3'bxx;
                case(funct3)
                    3'b000:
                        begin
                            case(op5)
                                1'b0: begin ALUControl = 4'b0000; end
                                1'b1:
                                    begin
                                        case(funct7b5)
                                            1'b0: ALUControl = 4'b0000;
                                            1'b1: ALUControl = 4'b0001;
                                        endcase
                                    end
                            endcase
                        end
                    3'b001:  ALUControl = 4'b0111;
                    3'b010:  ALUControl = 4'b0101;
                    3'b011:  ALUControl = 4'b0110;
                    3'b100:  ALUControl = 4'b0100;
                    3'b101:
                        begin
                            case(funct7b5)
                                1'b0: ALUControl = 4'b1000;
                                1'b1: ALUControl = 4'b1001;
                            endcase
                        end
                    3'b110:  ALUControl = 4'b0011;
                    3'b111:  ALUControl = 4'b0010;
                    default: ALUControl = 4'b0000;
                endcase
            end
        default: begin ByteAccess = 2'b00; ByteSrc = 3'b000; ALUControl = 4'b0000; end     
    endcase
endmodule