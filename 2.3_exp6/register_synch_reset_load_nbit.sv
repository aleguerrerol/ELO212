`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2019 18:05:25
// Design Name: 
// Module Name: register_synch_reset_load_nbit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Del profe, adaptado para ser un banco de registros de n bits en lugar de 8
// Sacado de https://github.com/gcarvajalb/ELO212-reference-modules/blob/master/PushButton-debouncer/project_1.srcs/sources_1/new/debouncer_FSM.sv
//////////////////////////////////////////////////////////////////////////////////


module register_synch_reset_load_nbit
    #(parameter n=8)
    (
    input [n-1:0] D,
    input clk,
    input rst,
    input load,
    output reg[n-1:0] Q
    );
    always @(posedge clk) begin
        if (!rst) begin
            Q <= 'd0;
        end
        else if (load) begin
            Q <= D;
        end
    end
endmodule

//-----------
