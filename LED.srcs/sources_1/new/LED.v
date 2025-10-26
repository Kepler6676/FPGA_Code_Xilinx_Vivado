module led(CLK,LED,RESET_N);

        input CLK,RESET_N;
        output reg LED;  
         reg[24:0]counter;
         
         
         always@(posedge CLK  )    
                if(!RESET_N)
                    counter<=0;
                else if(counter==24_999_999)
                    counter<=0;
                else
                    counter<=counter+1'd1;
                
         
        always@(posedge CLK  )    
                if(!RESET_N)
                    LED<=1'b0;
                else if(counter==24_999_999)
                     LED<=!LED; 
endmodule 
