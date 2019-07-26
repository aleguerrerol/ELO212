`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2019 14:28:33
// Design Name: 
// Module Name: sw_input
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


module sw_input #(parameter in_lenght=8)
(
    input logic [in_lenght-1:0]SW,
    output logic [in_lenght-1:0]out
    );
    assing  out = SW;
endmodule
