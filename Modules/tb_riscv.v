`timescale 1ns / 1ps

module tb_riscv;

//clock and reset signal declaration
  reg tb_clk, reset;
  wire [31:0] tb_WB_Data;
  
//reset Generation
  initial begin
    tb_clk = 0;
    reset = 1;
    #25 reset =0;
  end
  
    //clock generation
  always #10 tb_clk = ~tb_clk;
  
  
  
  riscv riscV(
      .clk(tb_clk),
      .reset(reset),
      .WB_Data(tb_WB_Data)      
     );

  initial begin
    #1300;
    $finish;
   end
endmodule