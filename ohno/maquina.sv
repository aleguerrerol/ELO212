`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2019 08:28:24
// Design Name: 
// Module Name: maquina
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

// maquina nombre_(.clk(),.rst(),.exe(),.button(),trigger_1(),.trigger_2(),.trigger_op(),.estado());

module maquina(
    input logic clk, rst, exe,
    input logic button,
    output logic trigger_1, trigger_2, trigger_op,
    output logic [1:0]estado
    );
    enum logic [4:0] {op10,send10,op11,send11,op12,send12,op13,send13,wait1,op20,send20,op21,send21,op22,
                        send22,op23,send23,wait2,operation,casi,show_result} state, next_state;
    
    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            state<=op10;
            //estado<='d0;
        end
        else state<=next_state;
    end
    
    always_comb begin               //SE VIENEEEEE
        case (state)
            op10:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d0;
                        if(exe) begin
                            next_state=op20;
                        end
                        else if(button)begin
                            next_state=send10;
                        end
                        else next_state=state;
                    end
            send10: begin
                        trigger_1='b1;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d0;
                        next_state=op11;
                    end
    
            op11:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d0;
                        if(exe) begin
                            next_state=op20;
                        end
                        else if(button)begin
                            next_state=send11;
                        end
                        else next_state=state;
                    end
            send11: begin
                        trigger_1='b1;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d0;
                        next_state=op12;                
                    end
                    
            op12:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d0; 
                        if(exe) begin
                            next_state=op20;
                        end
                        else if(button)begin
                            next_state=send12;
                        end
                        else next_state=state;   
                    end
            send12: begin
                        trigger_1='b1;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d0;
                        next_state=op13;
                    end
            
            op13:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d0; 
                        if(exe) begin
                            next_state=op20;
                        end
                        else if(button)begin
                            next_state=send13;
                        end
                        else next_state=state;
                    end
            send12: begin
                        trigger_1='b1;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d0;
                        next_state=wait1;
                    end
                    
            wait1:  begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d0;
                        if(exe) begin
                            next_state=op20;
                        end
                        else next_state=state;
                    end
                    
            op20:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d1;
                        if(exe) begin
                            next_state=operation;
                        end
                        else if(button)begin
                            next_state=send20;
                        end
                        else next_state=state;
                    end
            send20: begin
                        trigger_1='b0;
                        trigger_2='b1;
                        trigger_op='b0;
                        estado='d1;
                        next_state=op21;
                    end
    
            op21:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d1; 
                        if(exe) begin
                            next_state=operation;
                        end
                        else if(button)begin
                            next_state=send21;
                        end
                        else next_state=state;
                    end
            send21: begin
                        trigger_1='b0;
                        trigger_2='b1;
                        trigger_op='b0;
                        estado='d1;
                        next_state=op22;                
                    end
                    
            op22:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d1; 
                        if(exe) begin
                            next_state=operation;
                        end
                        else if(button)begin
                            next_state=send22;
                        end
                        else next_state=state;   
                    end
            send22: begin
                        trigger_1='b0;
                        trigger_2='b1;
                        trigger_op='b0;
                        estado='d1;
                  
                        next_state=op23;
                    end
            
            op23:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d1;
                        if(exe) begin
                            next_state=operation;
                        end 
                        else if(button)begin
                            next_state=send23;
                        end
                        else next_state=state;
                    end
            send23: begin
                        trigger_1='b0;
                        trigger_2='b1;
                        trigger_op='b0;
                        estado='d1;
                        
                        next_state=wait2;
                    end
            
            wait2:  begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d1;
                        if(exe) begin
                            next_state=operation;
                        end
                        else next_state=state;                        
                    end
                    
            operation:  begin
                            trigger_1='b0;
                            trigger_2='b0;
                            trigger_op='b1;
                            estado='d2;
                            if(button) begin
                            next_state=casi;
                            end
                            else next_state=state;  
                        end
                        
            casi:   begin                       //revisar ancho de los estados en enum
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b1;
                        estado='d2;
                        if(exe) begin
                            next_state=show_result;
                        end 
                        else next_state=state;
                    end
            
            show_result:    begin
                                trigger_1='b0;
                                trigger_2='b0;
                                trigger_op='b1;
                                estado='d3;
                                if(exe) begin
                                    next_state=op10;
                                end
                                else next_state=state;    
                            end
            default: begin
                                trigger_1='b0;
                                trigger_2='b0;
                                trigger_op='b0;
                                estado='d0;
                                next_state=state;
                     end
                    
        endcase
    end
endmodule