`timescale 1ns / 1ps

module ALUController(
    
    //Inputs
    input [1:0] ALUOp,  //7-bit opcode field from the instruction
    input [6:0] Funct7, // bits 25 to 31 of the instruction
    input [2:0] Funct3, // bits 12 to 14 of the instruction
    input Branch,
    input Mem,OpI,AUIPC,
    //Output
    output [3:0] ALUFn, //ALUFn selection for ALU
    output Con_beq, Con_bnq,  Con_blt, Con_bgt
);

 assign Con_beq = (Branch)&&(Funct3==3'b000);
 assign Con_bnq = (Branch)&&(Funct3==3'b001);
 assign Con_blt = (Branch)&&(Funct3==3'b100||Funct3==3'b110);
 assign Con_bgt = (Branch)&&(Funct3==3'b101||Funct3==3'b111);

 assign ALUFn[0] = ((Funct7 == 7'b0000001)&&((Funct3 == 3'b000)||(Funct3 == 3'b100)||(Funct3 == 3'b110)))||((ALUOp[1]==1'b1) && (Funct7==7'b0000000) && ((Funct3==3'b110)||(Funct3==3'b100)||(Funct3==3'b011)))||(Branch&&(Funct3==3'b110||Funct3==3'b111))||(OpI&&(Funct3==3'b100))||(OpI&&(Funct3==3'b110))||(OpI&&Funct3==3'b011);


 assign ALUFn[1] = ((Funct7 == 7'b0000001)&&(Funct3 == 3'b100))||(ALUOp==2'b00&&(!OpI)) ||
                     ((ALUOp[1]==1'b1) && (Funct7==7'b0000000) && ((Funct3==3'b000)||(Funct3==3'b100)||(Funct3==3'b010)))||
                     ((ALUOp[1]==1'b1) && (Funct7==7'b0100000) && (Funct3==3'b000))||(ALUOp[0]==1'b1)||Mem||(OpI&&(Funct3==3'b100))||(OpI&&(Funct3==3'b000))||(OpI&&Funct3==3'b010); 



 assign ALUFn[2] = ((Funct7 == 7'b0000001)&&(Funct3 == 3'b110))||(ALUOp[0]==1'b1)||((ALUOp[1]==1'b1) && (Funct7==7'b0100000) && (Funct3==3'b000))||((ALUOp[1]==1'b1) && (Funct7==7'b0000000) && ((Funct3==3'b001)||(Funct3==3'b011))) ||(OpI&&Funct7 == 7'b0100000&&Funct3 == 3'b101) || (ALUOp[1]&&Funct7 == 7'b0100000&&Funct3 == 3'b101)||(OpI&&Funct3 == 3'b001)||(OpI&&Funct3==3'b011);

 assign ALUFn[3] = ((Funct7 == 7'b0000001)&&((Funct3 == 3'b000)||(Funct3 == 3'b100)||(Funct3 == 3'b110)))||(Funct3 == 3'b010&&(!Mem))||(OpI&&Funct3 == 3'b101&&Funct7 == 7'b0000000)||(ALUOp[1]&&(Funct3 == 3'b101))||(OpI&&Funct7 == 7'b0100000&&Funct3 == 3'b101)||(ALUOp[1]&&Funct7 == 7'b0100000&&Funct3 == 3'b101);

endmodule