`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2019 23:16:20
// Design Name: 
// Module Name: top
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


module top(
    input logic [15:0]A_INPUT,[15:0]B_INPUT,[15:0]OP_INPUT,
    output logic [16:0]RESULTADO,
    output logic carry_out
    );
    alu alu(.A(A_INPUT),.B(B_INPUT),.OP(OP_INPUT),.result(RESULTADO),.error(carry_out));
endmodule
