`timescale 1ns / 1ps

module control(
	input [31:0] instruction,

	output reg ALUSrc,
	output reg MemToReg,
	output reg RegWrite,
	output reg MemRead,
	output reg MemWrite,
	output reg Branch,
	output reg [1:0] ALUOp,
	output reg Jump,
	output reg JumpR
);

wire [6:0] opcode;
assign opcode = instruction [6:0];

reg [9:0]  controlSignals[63:0];

initial
begin

    controlSignals[7'b0110011] = 10'b0010001000; // rtype
    controlSignals[7'b0010011] = 10'b1010000000; // itype
    controlSignals[7'b1100011] = 10'b0000010100; //sbtype

    controlSignals[7'b1101111] = 10'b0010000010; //JAL
    controlSignals[7'b1100111] = 10'b0011000001; //JALR
// jump
    controlSignals[7'b0000011] = 10'b1110100000; // lw
    controlSignals[7'b0100011] = 10'b1001000000; // sw

end

always @(instruction)
    begin

        ALUSrc   = controlSignals[opcode][9];
        MemToReg = controlSignals[opcode][8];
        RegWrite = controlSignals[opcode][7];
        MemWrite = controlSignals[opcode][6];
        MemRead  = controlSignals[opcode][5];
        Branch   = controlSignals[opcode][4];
        ALUOp    = controlSignals[opcode][3:2];
        Jump     = controlSignals[opcode][1];
	JumpR     = controlSignals[opcode][0];

    end
endmodule