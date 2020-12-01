`timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )(
        input [DATA_WIDTH-1:0] x,
        input [DATA_WIDTH-1:0] y,

        input [OPCODE_LENGTH-1:0] ALUFn,
        output reg [DATA_WIDTH-1:0] out,
        output reg Con_BLT, 
        output reg Con_BGT,
        output reg zero
        );

        integer i;
        always@(*)
        begin
            out = 'd0;
            Con_BLT = 'b0;
            Con_BGT = 'b0;
            zero = 'b0;
            case(ALUFn)
            4'b0000:        // AND
                    out = x & y;
            4'b0001:        //OR
                    out = x | y;
            4'b0011:        //XOR
                    out = x ^ y;
            4'b0010:        //ADD
                    out = x + y;
            4'b0110: begin       //Subtract
                    out = $signed(x) - $signed(y);
                    Con_BLT = ($signed(out) < $signed(1'd0));
                    Con_BGT = ($signed(out) > $signed(1'd0));
                    zero = ($signed(out) == $signed(1'd0));
                    end
            4'b0100:        //SLL
                    out = x << y;
            4'b0101:
                    out = x < y;
            4'b1010:
                    out = ($signed(x)<$signed(y));
            4'b0111:
                    begin       //unsigned branch
                    out = x - y;
                    Con_BLT = x < y;
                    Con_BGT = x > y;
                    zero = (out == 1'd0);
                    end
            4'b1000:        //SRL
                    out = x >> y;
            4'b1100:        //SRA
                    out = $signed(x) >>> y;
            4'b1001:        //MUL
                    out = x*y;
            4'b1011:        //DIV
                    out = x/y;
            4'b1101:        //REM
                    out = x%y;
            default: 
                    out = 'b0;
            endcase
        end
endmodule

