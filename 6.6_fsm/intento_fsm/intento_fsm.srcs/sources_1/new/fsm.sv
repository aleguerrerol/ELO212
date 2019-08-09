`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2019 19:31:36
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
    input logic btnc,
    
   // output logic button_sync,reset_sync,         //para observar comportamiento de los debouncers.
    
    output logic [1:0]leds_out      //número de current_state codificado en binario
    );
    enum logic [1:0] {wait_op1, wait_op2, wait_operation, show_result} current_state, next_state;
    
    always_ff @(posedge clock, negedge reset) begin                    //reset asincrónico (se cambió)
        if(~reset)   current_state <= wait_op1;
        else        current_state <=next_state;
        
    end
    
    always_comb begin
        next_state = wait_op1;
        leds_out=2'd0;             //no sé si es necesario
        case (current_state)
            wait_op1: begin
                                    if (btnc) begin
                                         next_state = wait_op2;
                                         leds_out=2'd1;
                                    end
                      end
            wait_op2: begin
                                    if (btnc) begin
                                         next_state = wait_operation;
                                         leds_out=2'd2;
                                    end
                      end
            wait_operation: begin
                                    if (btnc) begin
                                         next_state = show_result;
                                         leds_out=2'd3;
                                    end
                            end
            show_result: begin
                                    if (btnc) begin
                                        next_state = wait_op1;
                                        leds_out=2'b00;
                                    end
                         end
            default: next_state = current_state;       //E.O.C del diagrama
        endcase
    end
endmodule
