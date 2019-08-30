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

    /*
    val == 5'b1_0011 //exe
    val = 5'b1_0111; //CLR
    val = 5'b1_0110; //CE (undo)
    */


// maquina nombre_(.clk(),.rst(), .val(),.button(),trigger_1(),.trigger_2(),.trigger_op(),.estado(),.clear());

module maquina(
    input logic clk, rst,
    input logic button,
    input logic [4:0] val,
    output logic trigger_1, trigger_2, trigger_op, clear, //clear resetea los bancos e registros
    output logic [1:0]estado, //
    output logic c1,c2,
    output logic [15:0]LED 
    );
    logic [15:0]LED_int;
    logic restriccion; //se pone en 1 y la maquina no permite usarla
    enum logic [4:0] {op10,send10,op11,send11,op12,send12,op13,send13,wait1,op20,send20,op21,send21,op22,
                        send22,op23,send23,wait2,operation,send_op,casi,casi_1,show_result,reset_calc} state, next_state;
    logic reset;
    logic c1_int,c2_int; //int de interno
    always_ff @(posedge clk, posedge rst) begin
        if (reset || rst) begin
            state<=op10;
        end
        else state<=next_state;
    end
    
    always_comb begin               //SE VIENEEEEE
        LED_int='b0; 
        c1_int = 0;
        c2_int = 0;
        reset = 0;
        
        case (state)
            op10:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d3;
                        reset =0;
                        LED_int=16'd1; //////////////////
                         
                        if((val == 5'b1_0011) && button) begin //exe
                            next_state=op20;
                        end
                        else if(button && (val[4] == 0))begin //val[4] == 0 cuando se aprieta un numero
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
                        LED_int=16'd2; //////////////////
                        if((val == 5'b1_0011) && button) begin //EXE
                            next_state=op20;
                        end
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                        else if(button && (val[4] == 0))begin //val[4] == 0 cuando se aprieta un numero
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
                        LED_int=16'd3; //////////////////
                          if((val == 5'b1_0011) && button) begin //EXE
                            next_state=op20;
                        end
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                        else if(button && (val[4] == 0))begin //val[4] == 0 cuando se aprieta un numero
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
                        LED_int=16'd4; //////////////////
                         if((val == 5'b1_0011) && button) begin //EXE
                            next_state=op20;
                        end
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                        else if(button && (val[4] == 0))begin //val[4] == 0 cuando se aprieta un numero
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
                        LED_int=16'd5; //////////////////
                          if((val == 5'b1_0011) && button) begin //EXE
                            next_state=op20;
                        end
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                        else next_state=state;
                    end
                    
            op20:   begin
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        c1_int='b1;
                        estado='d1;
                        LED_int=16'd6; //////////////////
                          if((val == 5'b1_0011) && button) begin //EXE
                            next_state=operation;
                        end
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                        else if(button && (val[4] == 0))begin //val[4] == 0 cuando se aprieta un numero
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
                        LED_int=16'd7; //////////////////
                          if((val == 5'b1_0011) && button) begin //EXE
                            next_state=operation;
                        end
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                        else if(button && (val[4] == 0))begin //val[4] == 0 cuando se aprieta un numero
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
                        LED_int=16'd8; //////////////////
                          if((val == 5'b1_0011) && button) begin //EXE
                            next_state=operation;
                        end
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                        else if(button && (val[4] == 0))begin //val[4] == 0 cuando se aprieta un numero
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
                        LED_int=16'd9; //////////////////
                          if((val == 5'b1_0011) && button) begin //EXE
                            next_state=operation;
                        end 
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                        else if(button && (val[4] == 0))begin //val[4] == 0 cuando se aprieta un numero
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
                        LED_int=16'd10; //////////////////
                          if((val == 5'b1_0011) && button) begin //EXE
                            next_state=operation;
                        end
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                        else next_state=state;                        
                    end
                    
            operation:  begin                   
                            trigger_1='b0;
                            trigger_2='b0;
                            trigger_op='b0;
                            c2_int = 'b1; 
                            LED_int=16'd11; //////////////////
                            estado ='d3; //no mostrar nada    
                            
                            if((val == 5'b1_0111) && button )begin // CLR
                                next_state=reset_calc;
                            end
                                    
                            else if(button && (val[4] == 1) && (val != 5'b1_0011) ) begin //val[4] == 1 cuando se aprieta un operador
                            next_state=send_op;
                            end
                            
                            else next_state=state;  
                        end
                        
            send_op: begin                       //estado transitorio creado para resolver bug al almacenar operacion.
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b1; 
                        estado='d3;
                        next_state=casi;
                   end
                           
            casi:   begin                       //estado para mostrar resultado 
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d3;
                        LED_int=16'd12; //////////////////
                        if((val == 5'b1_0011) && button) begin //exe
                            next_state=casi_1;
                        end
                        
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                            next_state=reset_calc;
                        end
                        
                         
                        else next_state=state;
                    end
            
            casi_1:   begin                       //estado para mostrar resultado 
                        trigger_1='b0;
                        trigger_2='b0;
                        trigger_op='b0;
                        estado='d3;
                        LED_int=16'd13; //////////////////
                        if((val == 5'b1_0011) && button) begin //exe
                            next_state=show_result;
                        end
                        
                        else if((val == 5'b1_0111) && button )begin // CLR
                                next_state=reset_calc;
                        end
                        
                        else next_state=state;
                      end
            
            show_result:    begin
                                trigger_1='b0;
                                trigger_2='b0;
                                trigger_op='b0;
                                estado='d2;
                                LED_int=16'd14; //////////////////
                                
                                if((val == 5'b1_0011) && button) begin //exe
                                    next_state=reset_calc;
                                end
                                
                                else if((val == 5'b1_0111) && button )begin // CLR
                                    next_state=reset_calc;
                                end
                        
                                else next_state=state;    
                            end
                            
            reset_calc:      begin
                                reset=1;
                                trigger_1='b0;
                                trigger_2='b0;
                                trigger_op='b0;
                                estado='d3;
                                LED_int=16'd15; //////////////////
                                next_state=op10;
                            end
            
            default: begin
                                reset = 0;
                                trigger_1='b0;
                                trigger_2='b0;
                                trigger_op='b0;
                                c1_int = 'b0;
                                c2_int = 'b0;
                                estado='d3;               
                                next_state=state;
                     end
                    
        endcase
    end
    assign clear=reset;
    assign c1 = c1_int;
    assign c2 = c2_int; 
    assign LED=LED_int;
endmodule
