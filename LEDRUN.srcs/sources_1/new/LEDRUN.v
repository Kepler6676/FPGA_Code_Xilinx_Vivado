module LEDRUN(CLK,RESET_N,LED);

    input CLK;
    input RESET_N;
    output reg  [7:0] LED;
    
    reg [24:0] counter; 
    
    
    always@(posedge CLK or negedge RESET_N)
            if(!RESET_N)
                counter <= 0;
            else if (counter == 25_000_000-1)
                counter <= 0;
            else 
                counter <=counter +1'd1;
            
            
    
    always@(posedge CLK or negedge RESET_N)       
             if(!RESET_N)
                    LED<= 8'b0000_0001;
             else if(counter == 25000000-1)
                    begin
                        if(LED==8'b0000_0000| LED== 8'b1000_0000)
                            LED<=8'b0000_0001;
                        else
                            LED<=LED<<1;
                     end
            
           
endmodule
