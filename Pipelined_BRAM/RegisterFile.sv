module regfile (input  logic        clk,
                input  logic        we3,
                input  logic [4:0]  a1, a2, a3,
                input  logic [31:0] wd3,
                output logic [31:0] rd1, rd2
                );
                
logic [31:0] rf[31:0];
initial
    begin
        integer i;
        for(i = 0; i <= 31; i = i+1)
        rf[i][31:0] = 32'b0;   
    end

always_ff @(negedge clk)
    if(we3) rf[a3] <= wd3;
    
assign rd1 = (a1 != 0) ? rf[a1] : 0; //Так как нулевой элемент регистра всегда ноль
assign rd2 = (a2 != 0) ? rf[a2] : 0;

endmodule