module uart_byte_rx(
    Clk,
    Reset_n,
    uart_rx,
    Rx_Done,
    Rx_Data
);
//////////////////////适用于短距离 非强干扰情况下的串口通信
    input Clk;
    input Reset_n;
    input uart_rx;
    output reg Rx_Done;
    output reg[7:0]Rx_Data;
    
    parameter Clock_Frequency = 50_000_000;
    parameter Baud_Rate = 9600;
    parameter Mcnt_Baud =  Clock_Frequency / Baud_Rate - 1;
    
    reg [7:0]r_Rx_Data;
    
    reg [29:0]Baud_Counter;
    reg En_Baud;
    reg [3:0]Bit_Counter;
    
    wire w_Rx_Done;
    wire nedge_uart_rx;
    
    reg r_uart_rx;
    
    reg dff0_uart_rx,dff1_uart_rx;
//波特率计数器逻辑
   always@(posedge Clk or negedge Reset_n)
    if(!Reset_n)
        Baud_Counter <= 0;
    else if(En_Baud)begin
        if(Baud_Counter == Mcnt_Baud)
            Baud_Counter <= 0;
        else
            Baud_Counter <= Baud_Counter + 1'd1;
    end
    else
         Baud_Counter <= 0;
  
        
//UART 信号边沿检测逻辑
    always@(posedge Clk)
        dff0_uart_rx <= uart_rx;
        
    always@(posedge Clk)
        dff1_uart_rx <= dff0_uart_rx;     
           
    always@(posedge Clk)
        r_uart_rx <= dff1_uart_rx;
        
    assign nedge_uart_rx = (dff1_uart_rx == 0) && (r_uart_rx == 1);
        
//波特率计数器使能逻辑
    always@(posedge Clk or negedge Reset_n)
    if(!Reset_n)
        En_Baud <= 0;
    else if(nedge_uart_rx)
        En_Baud <= 1;
    else if((Baud_Counter == Mcnt_Baud/2) && (Bit_Counter == 0) && (dff1_uart_rx == 1))
        En_Baud <= 0;
    else if((Baud_Counter == Mcnt_Baud/2) && (Bit_Counter == 9))
        En_Baud <= 0;


//位计数器逻辑
    always@(posedge Clk or negedge Reset_n)
    if(!Reset_n)   
        Bit_Counter <= 0;   
    else if(Baud_Counter == Mcnt_Baud)
        Bit_Counter <= Bit_Counter + 1'd1;
    else if((Bit_Counter == 9)&&(Baud_Counter == Mcnt_Baud/2))
        Bit_Counter<=0;   //结束位时间减半     
            
//位接收逻辑

    always@(posedge Clk or negedge Reset_n)
    if(!Reset_n)
        r_Rx_Data <= 8'd0;
    else if(Baud_Counter == Mcnt_Baud/2)begin
        case(Bit_Counter)
            1:r_Rx_Data[0] <= dff1_uart_rx;
            2:r_Rx_Data[1] <= dff1_uart_rx;
            3:r_Rx_Data[2] <= dff1_uart_rx;
            4:r_Rx_Data[3] <= dff1_uart_rx;
            5:r_Rx_Data[4] <= dff1_uart_rx;
            6:r_Rx_Data[5] <= dff1_uart_rx;
            7:r_Rx_Data[6] <= dff1_uart_rx;
            8:r_Rx_Data[7] <= dff1_uart_rx;
            default: r_Rx_Data <= r_Rx_Data;
        endcase     
    end

//接收完成标志信号
    assign w_Rx_Done = (Baud_Counter == Mcnt_Baud/2) && (Bit_Counter == 9);
    
     always@(posedge Clk)
        Rx_Done <= w_Rx_Done;

     always@(posedge Clk)
     if(w_Rx_Done)
        Rx_Data <= r_Rx_Data;
        
        
endmodule
