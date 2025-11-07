    `timescale 1ns / 1ps
    module Key_Filter_tb;
        reg Clk;
        reg Reset_n;
        reg Key;       
        wire Key_P_Flag;
        wire Key_R_Flag; 
        wire Key_state;
        
        Key_Filter Key_Filter_0(
            .Clk(Clk),
            .Reset_n(Reset_n),
            .Key(Key),       
            .Key_P_Flag(Key_P_Flag),
            .Key_R_Flag(Key_R_Flag),
            .Key_state(Key_state)   
        );
        
        initial Clk=1;
        always #10 Clk=~Clk;
        
        initial begin      
            Reset_n=0;
            Key=1;
            #201;
            Reset_n=1;
                
                
                //1st test 
                Key=1;#100_000_000 //Idle for 100ms
                
                Key=0;#18_000_000;// Dither Simulation
                Key=1;#2_000_000
                Key=0;#1_000_000;
                Key=1;#200_000
                Key=0;#20_000_000;
                
                Key=0;#50_000_000;
                
                Key=1;#2_000_000;// Dither Simulation
                Key=0;#1_000_000;
                Key=1;#20_000_000
                
                Key=1;#50_000_000;
                
                //2nd test 
                Key=1;#100_000_000 //Idle for 100ms
                
                Key=0;#18_000_000;// Dither Simulation
                Key=1;#2_000_000
                Key=0;#1_000_000;
                Key=1;#200_000
                Key=0;#20_000_000;
                
                Key=0;#50_000_000;
                
                Key=1;#2_000_000;// Dither Simulation
                Key=0;#1_000_000;
                Key=1;#20_000_000
                
                Key=1;#50_000_000;
       
               $stop; 
            end    

    endmodule
