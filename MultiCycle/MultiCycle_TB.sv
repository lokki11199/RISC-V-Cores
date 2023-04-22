module singlesycle_tb();

logic        clk;
logic        reset;
logic [31:0] WriteData, Adr;
logic        MemWrite;
logic [31:0] i;
initial
    i = 32'b0;

top multisycle(clk, reset, Adr, WriteData, MemWrite);

initial
    begin
        reset <= 1;
        #22;
        //#16;
        reset <= 0;
    end

//initial
//    begin
//        clk <= 0;
//        forever #5 clk <= ~clk;
//    end
    
//initial
//    begin
//        #50 $finish; 
//    end
always
    begin
        clk <= 1;
        #5;
        clk <= 0;
        #5;
    end

always@(clk)
    begin
     if(clk == 1)
        i = i+1;
    end
   
always @(negedge clk)
    begin
        if(MemWrite)
            begin
                if(Adr === 100 & WriteData === 25) 
                    begin
                        $display("Simulation succeeded", " i = %d",i);
                        $stop;
                    end
            
                else if(Adr !== 96)
                    begin
                        $display("Simulation failed");
                        $stop;                
                    end
            end
    end



endmodule