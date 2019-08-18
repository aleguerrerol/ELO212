`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2019 01:47:11
// Design Name: 
// Module Name: registro_input
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


module registro_input #(parameter in_length=16)(
    input logic CLK,RESET,
    input logic [in_length-1:0]IN,
    input logic [1:0]STATE,
    
    output logic [in_length-1:0]A_OUT,
    output logic [in_length-1:0]B_OUT,
    output logic [in_length-1:0]OP_OUT
    );
    always_ff @(posedge CLK, negedge RESET) begin
        if(~RESET)begin
            A_OUT=0;
            B_OUT=0;
            OP_OUT=0;
        end
    end
    /*
    always_ff @(posedge CLK) begin      //FF_OPERAND_01
        if(STATE==2'd0) begin
            A_OUT <= IN;
        end
    end
    
    always_ff @(posedge CLK) begin      //FF_OPERAND_02
        if(STATE==2'd1) begin
            B_OUT <= IN;
        end
    end
    
    always_ff @(posedge CLK) begin      //FF_OPERATION BETWEEN A AND B
        if(STATE==2'd2) begin
            OP_OUT <= IN;
        end
    end
    */
    always_ff @(posedge CLK) begin      // más elegante y probablemente más eficiente(?)
            case(STATE)
                2'd0: A_OUT <= IN;
                2'd1: B_OUT <= IN;
                2'd2: OP_OUT <= IN;
            endcase    
    end
endmodule