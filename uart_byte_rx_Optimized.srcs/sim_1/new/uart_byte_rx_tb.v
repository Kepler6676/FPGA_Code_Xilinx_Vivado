`timescale 1ns / 1ps

module uart_byte_rx_tb();
    
    reg Clk;
    reg Reset_n;
    reg uart_rx;
    wire Rx_Done;
    wire [7:0] Rx_Data;


    uart_byte_rx uart_byte_rx_0(
        .Clk(Clk),
        .Reset_n(Reset_n),
        .uart_rx(uart_rx),
        .Rx_Done(Rx_Done),
        .Rx_Data(Rx_Data)
    );
    
    initial Clk=1;
    always #10 Clk=~Clk;
    
    
    
    initial begin
        //preparation
        Reset_n=0;
        uart_rx=1;
        #201;
        Reset_n=1;
       #200;
       
       
       
       //Simulation Start
          
        //0101_0101
       uart_rx=0;#(5208*20); //Start
       uart_rx=1; #(5208*20);// Bit0
       uart_rx=0; #(5208*20);//Bit1
       uart_rx=1; #(5208*20);//Bit2
       uart_rx=0; #(5208*20);//Bit3
       uart_rx=1; #(5208*20);//Bit4
       uart_rx=0; #(5208*20);//Bit5
       uart_rx=1; #(5208*20);//Bit6
       uart_rx=0; #(5208*20);//Bit7
       uart_rx=1; #(5208*20);//Stop
       #(5208*20*10);
       
         //1010_1010
       uart_rx=0;#(5208*20); //Start
       uart_rx=0; #(5208*20);// Bit0
       uart_rx=1; #(5208*20);//Bit1
       uart_rx=0; #(5208*20);//Bit2
       uart_rx=1; #(5208*20);//Bit3
       uart_rx=0; #(5208*20);//Bit4
       uart_rx=1; #(5208*20);//Bit5
       uart_rx=0; #(5208*20);//Bit6
       uart_rx=1; #(5208*20);//Bit7
       uart_rx=1; #(5208*20);//Stop
        #(5208*20*10);
        
        
        
         //1111_0000
       uart_rx=0;#(5208*20); //Start
       uart_rx=0; #(5208*20);// Bit0
       uart_rx=0; #(5208*20);//Bit1
       uart_rx=0; #(5208*20);//Bit2
       uart_rx=0; #(5208*20);//Bit3
       uart_rx=1; #(5208*20);//Bit4
       uart_rx=1; #(5208*20);//Bit5
       uart_rx=1; #(5208*20);//Bit6
       uart_rx=1; #(5208*20);//Bit7
       uart_rx=1; #(5208*20);//Stop
        #(5208*20*10);
        
        
          //0000_1111
       uart_rx=0;#(5208*20); //Start
       uart_rx=1; #(5208*20);// Bit0
       uart_rx=1; #(5208*20);//Bit1
       uart_rx=1; #(5208*20);//Bit2
       uart_rx=1; #(5208*20);//Bit3
       uart_rx=0; #(5208*20);//Bit4
       uart_rx=0; #(5208*20);//Bit5
       uart_rx=0; #(5208*20);//Bit6
       uart_rx=0; #(5208*20);//Bit7
       uart_rx=1; #(5208*20);//Stop
        #(5208*20*10);
       
        $stop;
    end









endmodule