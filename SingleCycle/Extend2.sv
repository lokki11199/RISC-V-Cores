module extend2 (input  logic [31:0] result,
                input  logic [2:0]  bytesrc,
                output logic [31:0] byteext
                );
                
always_comb
    case(bytesrc)
        3'b000: byteext = {24'b0, result[7:0]};
        3'b001: byteext = {16'b0, result[15:0]};
        3'b010: byteext = {{24{result[7]}}, result[7:0]};
        3'b011: byteext = {{16{result[15]}}, result[15:0]};
        3'b100: byteext = result;
        default: byteext = 32'b0;
    endcase
endmodule