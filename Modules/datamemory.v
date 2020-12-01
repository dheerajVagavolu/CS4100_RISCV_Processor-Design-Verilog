`timescale 1ns / 1ps

module datamemory#(
    parameter DM_ADDRESS = 9 ,
    parameter DATA_W = 32
    )(
    input clk,
	input MemRead , // comes from control unit
    input MemWrite , // Comes from control unit
    input [ DM_ADDRESS -1:0] a , // Read / Write address - 9 LSB bits of the ALU output
    input [ DATA_W -1:0] wd , // Write Data
    output reg [ DATA_W -1:0] rd // Read Data
    );
    
    reg [DATA_W-1:0] mem [(2**DM_ADDRESS)-1:0];
    
    always@(*) 
    begin
       if(MemRead)
            rd = mem[a];
	end
    
    always @(posedge clk) begin
       if (MemWrite)
            mem[a] = wd;
    end
    
endmodule

