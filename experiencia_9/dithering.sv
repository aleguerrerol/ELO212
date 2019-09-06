`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2019 10:58:50
// Design Name: 
// Module Name: dithering
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


module dithering(
    input logic [23:0] pixel_in,
    output logic [23:0] pixel_out
    );
    logic [7:0]color_r,color_r_dither, color_g, color_g_dither, color_b, color_b_dither;
    assign color_r = pixel_in[23:16]; //{a,b,c,d,e,f,g}
    assign color_g = pixel_in[15:8];
    assign color_b = pixel_in[7:0];
    
    always_comb 
    begin
        if (color_r[3])
                 color_r_dither = ({color_r[7:4], 4'b0} + 'd25);
        else     color_r_dither = ({color_r[7:4], 4'b0} - 'd25);
        if (color_g[3])
                 color_g_dither = ({color_g[7:4], 4'b0} + 'd25);
        else     color_g_dither = ({color_g[7:4], 4'b0} - 'd25);
        if (color_b[3])
                 color_b_dither = ({color_b[7:4], 4'b0} + 'd25);
        else     color_b_dither = ({color_b[7:4], 4'b0} - 'd25);      
    end
    
    assign pixel_out = {color_r_dither, color_g_dither, color_b_dither};
endmodule
