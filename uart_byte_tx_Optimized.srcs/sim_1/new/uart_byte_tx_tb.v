`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/21 20:14:02
// Design Name: 
// Module Name: uart_byte_tx_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module uart_byte_tx_tb();

    reg Clk;
    reg Reset_n;
    reg[7:0] Data;    
    wire uart_tx;
    wire Led;

     uart_byte_tx  uart_byte_tx_0(
        .Clk(Clk),
        .Reset_n(Reset_n),
        .Data(Data),
        .uart_tx(uart_tx),
        .Led(Led)        
     );
     
     defparam uart_byte_tx.Mcnt_Delay=500_000-1;

   initial Clk =1;
   always #10 Clk=~Clk;
   
   initial 
        begin
            Reset_n=0;
            #201;
            Reset_n=1;
            Data=8'b0101_0101;
            #30_000_000;
            Data=8'b1010_1010;
             #30_000_000;
             $stop;
        end    
   
     
endmodule
