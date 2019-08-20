`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2019 03:15:36
// Design Name: 
// Module Name: led_rgb_driver
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: este driver de rgb está hecho para funcionar específicamente solo cuando se está en el estado de mostrar resultados
// por lo tanto, no es muy portable.
//////////////////////////////////////////////////////////////////////////////////
/*
led_rgb_driver led_rgb_driver (.error(), .estado(), .out());
*/

module led_rgb_driver(
    input logic error,
    input logic [1:0]estado,
    
    output logic [2:0]out
    );

    always_comb begin
    
        if (error == 1'b1 && estado == 2'd3) out = 3'b100;
        else if (error == 1'b0 && estado == 2'd3) out = 3'b010;        
        else out = 3'b000;
    end
    
endmodule
