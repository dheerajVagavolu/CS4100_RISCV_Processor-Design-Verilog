`timescale 1ns / 1ps

module ALU_tb;

    reg [31:0] x;
    reg [31:0] y;
    reg [3:0] ALUFn;
    wire [31:0] out;
    wire overflow;
    wire zero;
    wire ng;

	ALU alu(.clk(clk),.x(x),.y(y), .out(out), .ALUFn(ALUFn),.zero(zero), .ng(ng),.overflow(overflow));

	initial 
        begin
            //add
            #100 
            ALUFn = 4'b0010;     
            x = 32'h00000001; 
            y = 32'h00000001; 
            //subtract
            #100 
            ALUFn = 4'b0110;     
            x = 32'h00000013; 
            y = 32'h00000002;
            #100 //and
            ALUFn = 4'b0000;     
            x = 1; 
            y = 0;
            #100 //or
            ALUFn = 4'b0001;  
            x = 1; 
            y = 0;    
            #100 //xor
            ALUFn = 4'b0011;     
            x = 32'h00000001; 
            y = 32'h00000000;  
            #100 //shiftleft
            ALUFn = 4'b0100;     
            x = 32'h00000001; 
            y = 32'h00000003; 
            #100 //shiftright
            ALUFn = 6'b1000;     
            x = 32'h00000010; 
            y = 32'h00000003;         
        end
    
endmodule
	