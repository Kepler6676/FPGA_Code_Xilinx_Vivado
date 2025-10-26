`timescale 1ns / 1ns
module decoder_3_8_tb();
    
    reg A0,A1,A2;
    wire Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;
    
    decoder_3_8   decoder_3_8_0(
    .A0(A0),
    .A1(A1),
    .A2(A2),
    .Y0(Y0),
    .Y1(Y1),
    .Y2(Y2),
    .Y3(Y3),
    .Y4(Y4),
    .Y5(Y5),
    .Y6(Y6),
    .Y7(Y7)
    );
    
    initial  begin
        A2=0 ;A1=0; A0=0;
        #20;        
        A2=0 ;A1=0; A0=1;
        #20;        
        A2=0 ;A1=1; A0=0;
        #20;       
        A2=0 ;A1=1; A0=1;
        #20;  
        A2=1 ;A1=0; A0=0;
        #20;   
        A2=1 ;A1=0; A0=1;
        #20;    
        A2=1 ;A1=1; A0=0;
        #20;    
        A2=1 ;A1=1; A0=1;
        #20;
        
        $stop;    
    end    
endmodule
