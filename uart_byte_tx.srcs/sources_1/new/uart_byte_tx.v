module uart_byte_tx(
    Clk,
    Reset_n,
    Data,
    uart_tx,
    Led
    );
    
    input Clk;
    input Reset_n;
    input[7:0] Data;
    output reg uart_tx;

    
    parameter Clock_Frequency=50_000_000;
    parameter Baud_Rate = 9600;
    parameter Mcnt_Baud=Clock_Frequency/Baud_Rate -1;
    parameter Mcnt_Bit=9; 
    parameter Mcnt_Delay=50_000_000-1;
    reg [12:0]Baud_Div_Counter;
    reg En_Baud;
    reg[3:0]Bit_Counter;
    reg [7:0]r_Data;
    reg [25:0]Delay_Counter;
 

  //En_Baud 
    always@(posedge Clk or negedge Reset_n)
        if(!Reset_n)     
            En_Baud<=0;
        else if(Delay_Counter==Mcnt_Baud)
            En_Baud<=1;
        else if((Bit_Counter==Mcnt_Bit)&&(Baud_Div_Counter==Mcnt_Baud)) 
            En_Baud<=0;       
   

//Baud_Counter
    always@(posedge Clk or negedge Reset_n)
        if(!Reset_n)
            Baud_Div_Counter<=0;
        else if(En_Baud)
            begin
                if(Baud_Div_Counter==Mcnt_Baud)
                     Baud_Div_Counter<=0;
                else     
                     Baud_Div_Counter<= Baud_Div_Counter+1'd1;
            end
        else
            Baud_Div_Counter<=0;

//Bit_Counter 
    always@(posedge Clk or negedge Reset_n)
        if(!Reset_n)
            Bit_Counter<=0;
        else if(Baud_Div_Counter==Mcnt_Baud)
            begin
                if(Bit_Counter==Mcnt_Bit)
                    Bit_Counter<=0;
                else
                    Bit_Counter<=Bit_Counter+1'd1;        
            end
            
 //Delay_Counter 
    always@(posedge Clk or negedge Reset_n)
        if(!Reset_n)
            r_Data<=0;
        else if(Delay_Counter==Mcnt_Delay)
            r_Data<=Data;
         else
            r_Data<=r_Data;   
            //r_Data
            
//         always@(posedge Clk )
//             if(Delay_counter==Mcnt_Delay)
//                r_Data<=Data;

  always@(posedge Clk or negedge Reset_n)
        if(!Reset_n)
            Delay_Counter<=0;
        else if(Delay_Counter== Mcnt_Delay)
            Delay_Counter<=0;
         else
            Delay_Counter<=Delay_Counter+1'd1;       
     
        
//bit_send logic
    always@(posedge Clk or negedge Reset_n)
        if(!Reset_n)
            uart_tx<=1;
        else if(En_Baud==0)
            uart_tx<=1;
        else     
            begin
                case(Bit_Counter)
                    0:uart_tx<=1'd0;
                    1:uart_tx<=r_Data[0];
                    2:uart_tx<=r_Data[1];
                    3:uart_tx<=r_Data[2];
                    4:uart_tx<=r_Data[3];
                    5:uart_tx<=r_Data[4];
                    6:uart_tx<=r_Data[5];
                    7:uart_tx<=r_Data[6];
                    8:uart_tx<=r_Data[7];
                    9:uart_tx<=1;
                    default:uart_tx<=uart_tx;
                 endcase   
            end

            
            
            
 
            
            
         

    
    
    
endmodule
