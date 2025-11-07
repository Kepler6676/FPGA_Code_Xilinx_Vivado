module Key_Filter(
    Clk,
    Reset_n,
    Key,
    Key_P_Flag,
    Key_R_Flag,
    Key_state
    );
     
    input Clk;
    input Reset_n;
    input Key;
    output reg Key_P_Flag;
    output reg Key_R_Flag;
    output reg Key_state;
    
    reg sync_d0_Key;
    reg sync_d1_Key;
    reg r_Key;    
     
    wire pedge_key;
    wire nedge_key;
    
    reg[1:0]state;
    
    localparam IDLE     =0;
    localparam P_FILTER =1;
    localparam WAIT_R   =2;
    localparam R_FILTER =3;
 
    parameter Mcnt = 1_000_000-1;    
    reg [29:0]Counter;
    
    wire time_20ms_reached;
    
 ///////////////////////////////////////////////////de_meta_stable
        always@(posedge Clk)
            sync_d0_Key<=Key;
        always@(posedge Clk)
            sync_d1_Key<=sync_d0_Key; 
///////////////////////////////////////////////edge detection             
        always@(posedge Clk)       
            r_Key<=sync_d1_Key;           
  
    assign nedge_key=(r_Key==1)&&(sync_d1_Key==0);
    assign pedge_key=(r_Key==0)&&(sync_d1_Key==1);   
// //////////////////////////////////////////////////////////  Counter
//   always@(posedge Clk or negedge Reset_n)
//    if(!Reset_n)
//        Counter<=0;
//    else if((state==P_FILTER)||(state==R_FILTER))
//        Counter<=Counter + 1'd1;
//    else
//        Counter<=0;   
////////////////////////////////////////////////////"time 20ms reached " signal       
   assign time_20ms_reached = (Counter>=Mcnt); 
//////////////////////////////////////////////////////   
   always@(posedge Clk or negedge Reset_n)
    if(!Reset_n)begin       
         state<=IDLE;
         Key_P_Flag<=1'd0;
         Key_R_Flag<=1'd0;  
         Counter<=0;
         Key_state<=1'd1;           
    end
    else begin       
        case(state)
            IDLE:
                begin
                    Key_R_Flag<=1'd0;   
                    if(nedge_key)
                        state<=P_FILTER; 
                end
    
             P_FILTER:
                if(time_20ms_reached)begin        
                    state<=WAIT_R;  
                    Key_P_Flag<=1'd1; 
                    Key_state<=1'd0;  
                    Counter<=0;                                       
                end
                else if(pedge_key)begin
                    state<=IDLE;
                    Counter<=0;
                end
                else begin
                    state<=state;   
                    Counter<=Counter+1'd1; 
                end
            WAIT_R:
                begin
                    Key_P_Flag<=1'd0;    
                    if(pedge_key)
                        state<=R_FILTER;
                end 
                           
            R_FILTER:
                if(time_20ms_reached) begin     
                    state<=IDLE;
                    Key_R_Flag<=1'd1;
                    Key_state<=1'd1;   
                    Counter<=0;  
                end
                else if(nedge_key)begin
                    state<=WAIT_R;
                    Counter<=0; 
                end     
                else begin
                    state<=state;
                    Counter<=Counter+1; 
                end       
            endcase
        end  
endmodule
