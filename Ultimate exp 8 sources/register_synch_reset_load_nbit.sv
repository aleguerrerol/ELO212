`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2019 12:49:12
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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
/* inst
register_synch_reset_load_nbit banco_op_1 (.D(), .clk(), .rst(), .load(), .Q(), .clear());
*/
module register_synch_reset_load_nbit
    #(parameter n=16)
    (
    input [n-1:0] D,
    input clk,
    input rst,
    input load,
    input clear,
    output reg[n-1:0] Q
    );
    always @(posedge clk) begin
        if (rst || clear) begin //reset de active high
            Q <= 'd0;
        end
        else if (load) begin
            Q <= D;
        end
    end
endmodule
