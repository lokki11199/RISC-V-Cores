module fsm(input  logic       CLK, Reset,
           input  logic [6:0] op,
           output logic       Branch,
           output logic       PCUpdate,
           output logic [1:0] ResultSrc,
           output logic [1:0] ALUSrcB,
           output logic [1:0] ALUSrcA,
           output logic       RegWrite,
           output logic       AdrSrc,
           output logic       MemWrite,
           output logic       IRWrite,
           output logic [1:0] DecOp
          );
          
logic [13:0] controls; 
assign {Branch, PCUpdate, ResultSrc, ALUSrcA, ALUSrcB, RegWrite, AdrSrc, MemWrite, IRWrite, DecOp} = controls;

logic [3:0]  state, nextstate;

parameter S0  = 4'd0,
          S1  = 4'd1,
          S2  = 4'd2,
          S3  = 4'd3,
          S4  = 4'd4,
          S5  = 4'd5,
          S6  = 4'd6,
          S7  = 4'd7,
          S8  = 4'd8,
          S9  = 4'd9,
          S10 = 4'd10,
          S11 = 4'd11,
          S12 = 4'd12,
          S13 = 4'd13,
          S14 = 4'd14; 
          
//State change
always_ff @(posedge CLK) 
    if(Reset)
        state <= S0;
    else
        state <= nextstate;
  
//Controls value in difrent state       
always_comb
    begin
        case(state)
            S0:      controls = 14'b0_1_10_00_10_0_0_0_1_10;//controls = 14'b0_1_10_00_10_0_0_0_1_000; //Fetch
            S1:      controls = 14'b0_0_xx_01_01_0_x_0_0_10; //Decode
            S2:      controls = 14'b0_0_xx_10_01_0_x_0_0_10; //MemAdr
            S3:      controls = 14'b0_0_00_xx_xx_0_1_0_0_00; //MemRead
            S4:      controls = 14'b0_0_01_xx_xx_1_x_0_0_00; //MemWB
            //S5:      controls = 14'b0_0_xx_10_01_0_x_0_0_10; //MemAdrS
            S5:      controls = 14'b0_0_00_xx_xx_0_1_1_0_00; //MemWrite
            S6:      controls = 14'b0_0_xx_10_00_0_x_0_0_11; //ExecuteR
            S7:      controls = 14'b0_0_00_xx_xx_1_x_0_0_10; //ALUWB
            S8:      controls = 14'b0_0_xx_10_01_0_x_0_0_11; //ExecuteI
            S9:      controls = 14'b0_1_00_01_10_0_x_0_0_10; //JAL
            S10:     controls = 14'b0_0_11_xx_xx_1_x_0_0_10; //LUI
            S11:     controls = 14'b0_0_xx_10_01_0_x_0_0_10; //ExecutePC
            S12:     controls = 14'b0_1_00_01_10_0_x_0_0_10; //JumpReg
            S13:     controls = 14'b1_0_00_10_00_0_x_0_0_01; //Branch
            default: controls = 14'b0_0_xx_xx_xx_0_x_0_0_xx;
        endcase
    end

//State machine
always_comb
    case(state)
        S0: nextstate = S1;
        S1:
            case(op)
                7'b0000011: nextstate = S2;
                7'b0100011: nextstate = S2;
                7'b0110011: nextstate = S6;
                7'b0010011: nextstate = S8;
                7'b1101111: nextstate = S9;
                7'b0110111: nextstate = S10;
                7'b1100111: nextstate = S11;
                7'b1100011: nextstate = S13;
                7'b0010111: nextstate = S7;
                default:    nextstate = S0;
            endcase
        S2:                  
            case(op)
                7'b0000011: nextstate = S3;
                7'b0100011: nextstate = S5;
                default:    nextstate = S0;
            endcase
        S3:      nextstate  = S4;
        S4:      nextstate  = S0;
        S5:      nextstate  = S0;
        S6:      nextstate  = S7;
        S7:      nextstate  = S0;
        S8:      nextstate  = S7;
        S9:      nextstate  = S7;
        S10:     nextstate = S0;
        S11:     nextstate = S12;
        S12:     nextstate = S7;
        S13:     nextstate = S0;
        default: nextstate = S0;
    endcase
       
endmodule