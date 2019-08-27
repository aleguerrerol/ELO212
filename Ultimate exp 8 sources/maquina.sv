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

// maquina nombre_(.clk(),.rst(),.exe(),.button(),trigger_1(),.trigger_2(),.trigger_op(),.estado(),.reset_a_reg());

module maquina(
    input logic clk, rst, exe,
    input logic button,
    output logic trigger_1, trigger_2, trigger_op, reset_a_reg, //reset_a_reg resetea los bancos e registros
    output logic [2:0]estado // javier: cambie el numero de estados posibles para agregar estado "4" default en el display pricipal igual a cero.
    );
    logic restriccion; //se pone en 1 y la maquina no permite usarla
    enum logic [4:0] {op10,send10,op11,send11,op12,send12,op13,send13,wait1,op20,send20,op21,send21,op22,
                        send22,op23,send23,wait2,operation,casi,casi_0,show_result,reset_calc} state, next_state;
    logic reset;
    
    always_ff @(posedge clk, posedge rst) begin
        if (reset || rst) begin
            state<=op10;
        end
        else state<=next_state;
    end
    
    always_comb begin               //SE VIENEEEEE
    
        reset = 0;
        
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
            send13: begin
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
                            trigger_op='b0; 
                            estado='d2;                
                            if(button) begin
                            next_state=casi_0;
                            end
                            else next_state=state;  
                        end
                        
            casi_0: begin                       //estado transitorio creado para resolver bug al almacenar operacion.
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b1; 
                        estado='d2;
                        next_state=casi;
                   end
                           
            casi:   begin                       //estado para mostrar resultado 
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d2;
                        if(exe) begin
                            next_state=show_result;
                        end 
                        else next_state=state;
                    end
            
            show_result:    begin
                                trigger_1='b0;
                                trigger_2='b0;
                                trigger_op='b0;
                                estado='d3;
                                if(exe) begin
                                    next_state=reset_calc;
                                end
                                else next_state=state;    
                            end
                            
            reset_calc:      begin
                                reset=1;
                                trigger_1='b0;
                                trigger_2='b0;
                                trigger_op='b0;
                                estado='d4;
                                next_state=op10;
                            end
            default: begin
                                reset = 0;
                                trigger_1='b0;
                                trigger_2='b0;
                                trigger_op='b0;
                                estado='d4;               
                                next_state=state;
                     end
                    
        endcase
    end
    assign reset_a_reg=reset; 
endmodule
