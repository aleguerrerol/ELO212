`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2019 01:28:04
// Design Name: 
// Module Name: fsm
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


module fsm(
    input logic clock, reset,
    input logic trigger,undo,
    
    output logic [1:0]LED,                      //número de current_state codificado en binario
    output logic [1:0]STATE
    );
    enum logic [1:0] {wait_op1, wait_op2, wait_operation, show_result} current_state, next_state;
    
    always_ff @(posedge clock, negedge reset) begin                    //reset asincrónico (se cambió)
        if(~reset) begin
                    current_state <= wait_op1;
                    LED = 2'b00;                    //Setea estado inicial de LED a 0 (?)
                    STATE = 2'b00;
                   end
        else        current_state <= next_state;
    end
    
    always_comb begin
        case(current_state)
            wait_op1:   begin
                            if (trigger && ~undo) begin
                                next_state = wait_op2;
                                LED = 2'b01;
                                STATE = 2'b01;
                            end
                            else if (~trigger && undo) begin
                                next_state = current_state;
                                LED = 2'b00;
                                STATE = 2'b00;
                            end
                            else begin
                                next_state = current_state;
                                LED = 2'b00;
                                STATE = 2'b00;
                            end
                        end
                        
            wait_op2:   begin
                            if (trigger && ~undo) begin                              
                                next_state = wait_operation;
                                LED = 2'b10;
                                STATE = 2'b10;
                            end
                            else if (~trigger && undo) begin
                                next_state = wait_op1;
                                LED = 2'b00;
                                STATE = 2'b00;
                            end
                            else begin                                     
                                next_state = current_state;
                                LED = 2'b01;
                                STATE = 2'b01;
                            end
                        end
                        
            wait_operation:begin
                            if (trigger && ~undo) begin                              
                                next_state = show_result;
                                LED = 2'b11;
                                STATE = 2'b11;
                            end
                            else if (~trigger && undo) begin
                                next_state = wait_op2;
                                LED = 2'b01;
                                STATE = 2'b01;
                            end
                            else begin                                      
                                next_state = current_state;
                                LED = 2'b10;
                                STATE = 2'b10;
                            end
                           end
                           
            show_result:   begin
                            if (trigger && ~undo) begin                                      
                                next_state = wait_op1;
                                LED = 2'b00;
                                STATE = 2'b00;
                            end
                            else if (~trigger && undo) begin
                                next_state = wait_operation;
                                LED = 2'b10;
                                STATE = 2'b10;
                            end
                            else begin
                                next_state = current_state;                 
                                LED = 2'b11;
                                STATE = 2'b11;
                            end
                           end 
        endcase
    end
endmodule