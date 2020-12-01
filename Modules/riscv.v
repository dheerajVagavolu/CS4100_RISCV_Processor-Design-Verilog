`timescale 1ns / 1ps

module riscv #(
    parameter DATA_W = 32)
    (input clk, reset, // clock and reset signals
    output [31:0] WB_Data// The ALU_Result
    );

wire [6:0] opcode;
wire ALUSrc, MemtoReg,RegtoMem, RegWrite, MemRead, MemWrite, Con_Jalr;
wire Con_beq, Con_bnq, Con_bgt, Con_blt, Con_Jal,Branch, Mem,OpI,AUIPC,LUI;

wire [1:0] ALUop;
wire [6:0] Funct7;
wire [2:0] Funct3;
wire [3:0] Operation; 
	
    Controller c(opcode, ALUSrc, MemtoReg,RegtoMem, RegWrite, MemRead, MemWrite, Branch, ALUop, Con_Jalr,Con_Jal,Mem, OpI, AUIPC, LUI);
    
    ALUController ac(ALUop, Funct7, Funct3, Branch,Mem,OpI,AUIPC, Operation, Con_beq, Con_bnq, Con_blt, Con_bgt);

    Datapath dp(clk, reset, RegWrite , MemtoReg, RegtoMem, ALUSrc , MemWrite, MemRead, Con_beq, Con_bnq, Con_bgt, Con_blt, Con_Jalr,Con_Jal, AUIPC, LUI,Operation, opcode, Funct7, Funct3, WB_Data);
        
endmodule
