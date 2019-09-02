`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2019 17:56:31
// Design Name: 
// Module Name: uart_reciver
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
/*template uart_reciver(.clk(),.rst(),.rx_ready(),.rx_data(),.dato(),.load(),.line());
*/

module uart_reciver(

    input logic clk, rst,
    input logic [7:0]rx_data,
    input logic rx_ready,
    
    output logic [23:0]dato,
    output logic load,
    output logic [17:0]line 
    );
    
    enum logic [4:0] {IDLE, cargar_byte1, store_1, cargar_byte2, store_2, cargar_byte3, store_3, enviar,
                      bajar_linea, wait_for_next} state, next_state;
    
    logic [7:0]byte1, byte2, byte3;
    logic [17:0]line_int;
    
    always_comb begin
        load=0;
        next_state=state;
        
        case(state)
            IDLE:           begin
                                next_state=cargar_byte1;
                            end
                            
            cargar_byte1:   begin
                            if(rx_ready=='d1) 
                                next_state=store_1;
                            else next_state=cargar_byte1;
                            end
                            
            store_1:        next_state=cargar_byte2;
            
            cargar_byte2:   begin
                                if(rx_ready=='d1) 
                                    next_state=store_2;
                                else next_state=cargar_byte2;
                            end
                            
            store_2:        next_state=cargar_byte3;               
           
            cargar_byte3:  begin
                                if(rx_ready=='d1) 
                                    next_state=store_3;
                                else next_state=cargar_byte3;
                            end
                            
                           
            store_3:        next_state=enviar;
            
            enviar:  begin
                                load=1;
                                next_state=bajar_linea;
                            end
            
            bajar_linea:   begin
                                next_state=wait_for_next;
                            end
            
            wait_for_next:  begin
                                if(rx_ready=='d1)
                                    next_state=store_1;
                                else next_state=wait_for_next;
                             end    

            default:        begin
                                load=0;
                            end  
        endcase
   end
  
  
   always_ff@(posedge clk)begin
        if(rst)
            state <= IDLE;
           
        else
            state <= next_state;       
   end
    
   
   always_ff@(posedge clk)begin
        if (state == store_1) byte1<=rx_data;
   end
   always_ff@(posedge clk)begin     
        if (state == store_2) byte2<=rx_data; 
   end 
   always_ff@(posedge clk)begin
        if (state == store_3) byte3<=rx_data;
   end
   always_ff@(posedge clk)begin
        if ((state == bajar_linea) || rst)
            if (rst==1'b1) line_int<=18'b1;
            else line_int<=line_int+1;   
   end 
   
   assign line=line_int;
   assign dato={byte1,byte2,byte3};
endmodule
    
