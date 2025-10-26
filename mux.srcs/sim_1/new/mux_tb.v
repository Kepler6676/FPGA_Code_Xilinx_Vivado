`timescale 1ns / 1ns


module mux_tb();

reg S0,S1,S2;
wire mux_out;
mux mux_0(.a(S0),.b(S1),.sel(S2),.out(mux_out));

initial begin
    S2=0; S1=0; S0=0;
    #20;
    
    S2=0; S1=0; S0=1;
    #20;
    
    S2=0; S1=1; S0=0;
    #20;
    
    S2=0; S1=1; S0=1;
    #20;
    
    S2=1; S1=0; S0=0;
    #20;
    
    S2=1; S1=0; S0=1;
    #20;
    
    S2=1; S1=1; S0=0;
    #20;
    
    S2=1; S1=1; S0=1;
    #20;
end
    
      
endmodule