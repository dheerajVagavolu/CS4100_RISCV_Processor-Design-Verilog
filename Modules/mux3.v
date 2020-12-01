`timescale 1ns / 1ps

module mux3
    #(parameter WIDTH = 9)
    (input [WIDTH-1:0] d0, d1, d2,
     input [1:0]s,
     output reg [WIDTH-1:0] y);

initial
begin
	if(s[1]&&!s[0])
		y = d1;
	else if(!s[1]&&s[0])
		y = d2;
	else
		y = d0;
end

endmodule
