`timescale 1ns / 1ns


module led_tb();

    reg CLK,RESET_N;
    wire LED;  
   
    led led_0(
        .CLK(CLK),
        .LED(LED),
        .RESET_N(RESET_N)
        );
        
      initial CLK=1;
      always #10 CLK=!CLK;
    
      initial 
      begin 
            RESET_N=0;   
            #201;
            RESET_N=1;
            #2000_000_000;
            $stop;  
        
        end
endmodule