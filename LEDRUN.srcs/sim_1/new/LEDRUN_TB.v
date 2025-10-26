`timescale 1ns / 1ns


module LEDRUN_TB();

    reg CLK;
    reg RESET_N;
    wire [7:0] LED;
    



LEDRUN LEDRUN_0 (
    .CLK(CLK),
    .RESET_N(RESET_N),
    .LED(LED));
    
    
    initial CLK=1;
    always#10 CLK=~CLK;
    
    initial begin
        RESET_N=0;
        #201;
        RESET_N=1;
        #2000_000_000;
        #2000_000_000;
        #2000_000_000;
        #2000_000_000;
        
        
        $stop;
    
    end
    
  
endmodule
