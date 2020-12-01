`timescale 1ns / 1ps

module tb_riscv();

reg clk, rst;
wire [31:0] tb_WB_Data;

initial begin 
clk = 0;
rst = 0;
#100 rst = 1;
end

always #50 clk = ~clk;

riscv riscV(.clk(clk),.reset(rst),.WB_Data(tb_WB_Data));


endmodule