module eflopr7 (input  logic clk, reset, clear,
                input  logic [31:0] d0, d1, d2, d3, d4, d5,
                input  logic [4:0]  d6,
                input  logic [31:0] d7, d8,
                output logic [31:0] q0, q1, q2, q3, q4, q5,
                output logic [4:0]  q6,
                output logic [31:0] q7, q8
               );

always_ff @(posedge clk, posedge reset)
        if(reset)
            begin
                q0 <= 0;
                q1 <= 0;
                q2 <= 0;
                q3 <= 0;
                q4 <= 0;
                q5 <= 0;
                q6 <= 0;
                q7 <= 0;
                q8 <= 0;
            end
        else if(clear)
            begin
                q0 <= 0;
                q1 <= 0;
                q2 <= 0;
                q3 <= 0;
                q4 <= 0;
                q5 <= 0;
                q6 <= 0;
                q7 <= 0;
                q8 <= 0;
            end
        else
            begin
                q0 <= d0;
                q1 <= d1;
                q2 <= d2;
                q3 <= d3;
                q4 <= d4;
                q5 <= d5;
                q6 <= d6;
                q7 <= d7;
                q8 <= d8;
            end
             //Неблокирующее присваивание как раз говорит о том, что сигнал
        //должен быть установившимся, так как значение в правой части вычисляется до присваивания

endmodule