module clrflopenr(input  logic clk, reset, enable, clear,
                  //input  logic [31:0] InstrF,
                  input  logic [31:0] PCF,
                  input  logic [31:0] PCPlus4F,
                  
                  //output logic [31:0] InstrD,
                  output logic [31:0] PCD,
                  output logic [31:0] PCPlus4D
                  );
                  
always_ff @(posedge clk, posedge reset)
    if(reset) 
        begin
            //InstrD   <=   32'b0;
            PCD      <=   32'b0;
            PCPlus4D <= 32'b0;
        end  
    else if(clear)
        begin
            //InstrD   <=   32'b0;
            PCD      <=   32'b0;
            PCPlus4D <= 32'b0;
        end     
    else if(!enable)
        begin
            //InstrD   <=   InstrF;
            PCD      <=   PCF;
            PCPlus4D <= PCPlus4F;   
        end               


endmodule