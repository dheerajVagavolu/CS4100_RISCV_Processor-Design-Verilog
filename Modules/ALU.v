
`timescale 1ns / 1ps

module ALU(clk, x, y, out, ALUFn, zero, ng, overflow);
	input wire clk;
	input wire [31:0] x;
	input wire [31:0] y;
	input wire [3:0] ALUFn;
	output reg [31:0] out;
	output reg zero; 
	output reg ng; 
	output reg overflow;

	always @(x or y or ALUFn)
	begin
		if (ALUFn[3:0] == 4'b0010) begin // ADD
			out = x + y;
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			if ((x >= 0 && y >= 0 && out < 0) || (x < 0 && y < 0 && out >= 0)) 
                    		overflow = 1;
                	else
                    		overflow = 0;
                	
            	end else if (ALUFn[3:0] == 4'b0110) begin // SUB
			out = x - y;
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			if ((x >= 0 && y >= 0 && out < 0) || (x < 0 && y < 0 && out >= 0)) 
                    		overflow = 1;
                	else
                    		overflow = 0;
			
		end else if (ALUFn[3:0] == 4'b0000) begin // AND
			out = x & y;
			
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			overflow = 0;
		end else if (ALUFn[3:0] == 4'b0001) begin // OR
			out = x | y;
			
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			overflow = 0;
		end else if (ALUFn[3:0] == 4'b0011) begin // XOR
			out = x ^ y;
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			overflow = 0;
		end else if (ALUFn[3:0] == 4'b0100) begin // SLL
			out = x << y;
			
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			overflow = 0;
		end else if (ALUFn[3:0] == 4'b1000) begin // SRL
			out = x >> y;
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			overflow = 0;
		end else if (ALUFn[3:0] == 4'b0101) begin // Mul
			out = x * y;
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			overflow = 0;
		end else if (ALUFn[3:0] == 4'b0111) begin // Div
			out = x / y;
			
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			overflow = 0;
		end else if (ALUFn[3:0] == 4'b1001) begin // Rem
			out = x % y;
			zero = (out==0)?1:0;
			ng = (out<0)?1:0;
			overflow = 0;
		end
	end
endmodule
