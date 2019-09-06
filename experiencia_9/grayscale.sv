`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2019 15:40:01
// Design Name: 
// Module Name: grayscale
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

//  grayscale nombre_(.pixel_in(24 bits),.gray(24 bits));

module grayscale(
    input logic [23:0]pixel_in,                     //stream del pixel de entrada
    output logic [23:0]gray                         //stream de salida en grayscale
    );
    logic [7:0]r_channel;
    logic [7:0]g_channel;
    logic [7:0]b_channel;
    logic [7:0]promedio;
    
    assign r_channel = pixel_in[23:16];
    assign g_channel = pixel_in[15:8];
    assign b_channel = pixel_in[7:0];
    
    assign promedio = (r_channel + g_channel + b_channel)/3;    //promedio
    assign gray[23:16]=promedio;
    assign gray[15:8]=promedio;
    assign gray[7:0]=promedio;

endmodule
