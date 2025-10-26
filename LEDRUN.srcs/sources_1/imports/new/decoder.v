module decoder(A0,A1,A2,Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7);
    input   A0,A1,A2;
    output reg  Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;


    always@(*)//¹ý³Ì¸³Öµ
        case({A2,A1,A0})
            3'd0: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b0000_0001;
            3'd1:  {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b0000_0010;
            3'd2: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b0000_0100;
            3'd3: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b0000_1000;
            3'd4:  {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b0001_0000;
            3'd5:  {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b0010_0000;
            3'd6: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b0100_0000;
            3'd7: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b1000_0000;
            default:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b0000_0000;
            
       endcase
    

endmodule