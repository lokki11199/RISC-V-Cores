module flopr #(parameter WIDTH = 32)
              (input  logic clk, reset,
               input  logic [WIDTH-1:0] d,
               output logic [WIDTH-1:0] q
               );

always_ff @(posedge clk, posedge reset)
        if(reset) q <= 0;
        else q <= d; //Неблокирующее присваивание как раз говорит о том, что сигнал
        //должен быть установившимся, так как значение в правой части вычисляется до присваивания

endmodule