module mux(a,b,out,sel);

    input a;
    input b;
    input sel;
    output out;

    assign out = (sel==0)?a:b;


endmodule

