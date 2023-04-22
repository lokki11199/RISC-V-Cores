module imemory (input  logic [31:0] PC,
                output logic [31:0] Instr
                );
                
logic [31:0] memory [63:0];

initial
    $readmemh("riscvtest.mem", memory);

assign Instr = memory[PC[31:2]];//Выравнивание по словам


endmodule