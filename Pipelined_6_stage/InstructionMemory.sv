module imemory (input  logic        clk,
                input  logic        StallD,
                input  logic        FlushD,
                input  logic        InstWrite,
                input  logic [31:0] WriteInst,
                input  logic [31:0] WriteAdress,
                input  logic [31:0] PC,
                output logic [31:0] Instr
                );
                
logic [31:0] memory [4095:0];

initial
    $readmemh("riscvtest.mem", memory, 0, 4095);
//generate
//initial
//    $readmemb("riscvtestb.mem", memory, 0, 4095);
//endgenerate

//assign Instr = memory[PC[31:2]];//Выравнивание по словам

always_ff @(posedge clk)
    if(FlushD)
        Instr <= 0;
    else if(!StallD)
        begin
            if(InstWrite)
                memory[WriteAdress[31:2]] <= WriteInst;
            else
                Instr <= memory[PC[31:2]];  
        end

endmodule