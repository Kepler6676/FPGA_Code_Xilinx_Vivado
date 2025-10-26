module LEDRUN2(CLK,RESET_N,LED);

    input CLK;
    input RESET_N;
    output wire  [7:0] LED;
    
    reg [24:0] counter; 
    
    
    always@(posedge CLK or negedge RESET_N)
            if(!RESET_N)
                counter <= 0;
            else if (counter == 25_000_000-1)
                counter <= 0;
            else 
                counter <=counter +1'd1;
                
                
                
                reg [2:0] counter2;
                
                always@(posedge CLK or negedge RESET_N)
            if(!RESET_N)
                counter2 <= 0;
            else if (counter == 25000000-1)
               counter2 <=counter2 +1'd1;
                
              
            
       decoder decoder_0(.A0(counter2[0]),
                                             .A1(counter2[1]),
                                             .A2( counter2[2]),
                                             .Y0(LED[0]),
                                             .Y1(LED[1]),
                                             .Y2(LED[2]),
                                             .Y3(LED[3]),
                                             .Y4(LED[4]),
                                             .Y5(LED[5]),
                                             .Y6(LED[6]),
                                             .Y7(LED[7]));        
endmodule