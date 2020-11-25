
`timescale 1ns / 1ps

module alu_control(
    input      [31:0] instruction,
    input      [1:0]  ALUOp,
    output reg [3:0]  ALUFn,
	output reg [1:0] BranchOp
);

always @(instruction or ALUOp)
begin
    if (ALUOp == 2'b00) begin //Load Word, Store Word, I type (ADD)
        // ALUFn <= instruction[5:0];
	if (instruction[6:5] == 2'b00) begin // Load word
		ALUFn <= 5'b0010; //ADD
	end else if (instruction[6:5] == 2'b01) begin // Store word
		ALUFn <= 5'b0010; // ADD
	end
    end else if (ALUOp == 2'b10) begin // R Type
	if (instruction[31:24] == 7'b0000000) begin
		if (instruction[14:12] == 3'b000) begin // ADD
			ALUFn <= 4'b0010; // ADD
		end else if (instruction[14:12] == 3'b111) begin // AND
			ALUFn <= 4'b0000;
		end else if (instruction[14:12] == 3'b110) begin // OR
			ALUFn <= 4'b0001; // OR
		end else if (instruction[14:12] == 3'b100) begin // XOR
			ALUFn <= 4'b0011; // XOR
		end else if (instruction[14:12] == 3'b001) begin // SLL
			ALUFn <= 4'b0100; // SLL
		end else if (instruction[14:12] == 3'b101) begin // SRL
			ALUFn <= 4'b1000; // SRL
		end 
	end else if (instruction[31:24] == 7'b0000001) begin
		if (instruction[14:12] == 3'b000) begin // Mul
			ALUFn <= 4'b0101; // 
		end else if (instruction[14:12] == 3'b100) begin // Div
			ALUFn <= 4'b0111; // SLL
		end else if (instruction[14:12] == 3'b110) begin // Rem
			ALUFn <= 4'b1001; // SRL
		end
	end 
    end else if (instruction[31:24] == 7'b0100000) begin
		if (instruction[14:12] == 3'b000) begin // SUB
			ALUFn <= 4'b0110; // SUB
		end
    end else if (ALUOp == 2'b01) begin // SB Type
       	ALUFn <= 4'b0110; // SUB
		if (instruction[14:12] == 3'b000) begin //BEQ
			BranchOp <= 2'b00;
		end else if (instruction[14:12] == 3'b000) begin // BNE
			BranchOp <= 2'b01;
		end else if (instruction[14:12] == 3'b000) begin // BLT
			BranchOp <= 2'b10;
		end else if (instruction[14:12] == 3'b000) begin // BGE
			BranchOp <= 2'b11;
		end
   end

end

endmodule