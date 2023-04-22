module singlesycle_tb();

logic        clk;
logic        reset;
logic [31:0] WriteData, ALUResult;
logic        MemWrite;

top singlecycle(clk, reset, WriteData, ALUResult, MemWrite);

initial
    begin
        reset <= 1;
        #22;
        reset <= 0;
    end


always
    begin
        clk <= 1;
        #5;
        clk <= 0;
        #5;
    end
   
always @(negedge clk)
    begin
        if(MemWrite)
            begin
                if(ALUResult === 100 & WriteData === 25) 
                    begin
                        $display("Simulation succeeded");
                        $stop;
                    end
            
                else if(ALUResult !== 96)
                    begin
                        $display("Simulation failed");
                        $stop;                
                    end
            end
    end

endmodule