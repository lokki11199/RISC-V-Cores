module datapath(input  logic 		clk, reset,
			    input  logic [2:0]  ResultSrc,
				input  logic [1:0]  PCSrc,
				input  logic [3:0]  ALUControl,
				input  logic        ALUSrc,
				input  logic [2:0]  ByteSrc,
				input  logic [2:0]  ImmSrc,
				input  logic		RegWrite,
				input  logic [31:0] Instr, //Может [31:7]?
				input  logic [31:0] ReadData,
				output logic		Zero,
				output logic [31:0] PC,
				output logic [31:0] ALUResult, 
				output logic [31:0] WriteData
				);

	logic [31:0] PCNext, PCPlus4, PCTarget, ImmExt, SrcA, SrcB, Result, ByteExt;
	
//next PC logic
	flopr#(32)      pcreg(clk, reset, PCNext, PC); //#(32) - параметр (parameter)
	
	
	adder			pcadd4(PC, 32'd4, PCPlus4);
	adder			pcaddbranch(PC, ImmExt, PCTarget);
	mux3#(32)	    pcmux(PCPlus4, PCTarget, ALUResult, PCSrc, PCNext);

//register file logic
	regfile rf(clk, RegWrite ,Instr[19:15], Instr[24:20], 
				  Instr[11:7], Result, SrcA, WriteData);	  
	extend1  ext1(Instr[31:7], ImmSrc, ImmExt);
	extend2  ext2(ReadData, ByteSrc, ByteExt);

//ALU logic
	mux2#(32) srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
	alu		  alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
	mux5#(32) resultmux(ALUResult, ImmExt, PCPlus4, PCTarget, ByteExt,
								ResultSrc, Result);

endmodule