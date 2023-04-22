
module pipelined_tb();

logic        clk;
logic        reset;
logic [31:0] WriteData, ALUResult, ForwardW;
logic        InstrWrite = 0;
logic [31:0] WriteInst = 0, WriteAdress = 0;
logic        MemWrite;
top pipelined(clk, reset, InstrWrite, WriteInst, WriteAdress, WriteData, ALUResult, ForwardW, MemWrite);

logic [31:0] PCF;
logic [31:0] InstrF;
logic [31:0] RD1D;
logic [31:0] ImmExtD;
logic [31:0] ForwardAE;
logic [31:0] ALUResultE;
logic [31:0] ForwardM;
logic [31:0] ResultW;
logic RegWriteM;
logic RegWriteW;
logic [4:0] Rs1E;
logic [4:0] RdM;
logic [2:0] PCSrcB;
integer i = 0;

initial
    begin
        reset <= 1;
        //#22;
        #122;
        reset <= 0;
        i <= 0;
    end
    
always
    begin
        clk <= 1;
        #5;
        clk <= 0;
        #5;
        
    end
    
//always @(posedge clk)
//    begin
//        PCF = pipelined.PCF;
//        InstrF = pipelined.InstrF;
//        RD1D = pipelined.p.d.RD1D;
//        ImmExtD = pipelined.p.d.ImmExtD;
//        ForwardAE = pipelined.p.d.ForwardAE;
//        ALUResultE = pipelined.p.d.ALUResultE;
//        ForwardM = pipelined.p.d.ForwardM;
//        ResultW = pipelined.p.d.ResultW;
//        RegWriteM = pipelined.p.h.RegWriteM;
//        RegWriteW = pipelined.p.h.RegWriteW;
//        Rs1E = pipelined.p.d.Rs1E;
//        RdM = pipelined.p.d.RdM;
//        PCSrcB = pipelined.p.d.PCSrcB;
//    end
    
//initial
//    begin
//        #100000 $finish;
//    end
always @(posedge clk)
    i = i + 1;

always @(negedge clk)
    begin
        if(MemWrite)
            begin
                if(ALUResult === 32'h508 & WriteData === 32'd2047) //1.157e-4 1.35e-4
                    begin
                        $display("Simulation succeeded");
                        $stop;
                    end
            
//                else if(ALUResult === 1236 & WriteData === 1234)
//                    begin
//                        $display("Simulation failed");
//                        $stop;                
//                    end
            end
    end

endmodule