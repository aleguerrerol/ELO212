`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2019 16:50:42
// Design Name: 
// Module Name: get_color
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
/*template get_color(.addr(),.get_col(),.col(),.send_add());*/

module get_color(
    input logic [17:0]addr,
    input logic [23:0]get_col,
    output logic [23:0]col,
    output logic [17:0]send_add
    );
 
    assign send_add=addr;
    assign col=get_col;
 
endmodule
