`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2019 14:02:30
// Design Name: 
// Module Name: registro
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


module registro #(parameter in_lenght=8)        //podemos variamos la cantidad de bits
(    
    input logic clk,en,reset,
    input logic [in_lenght-1:0]D,
    output logic [in_lenght-1:0]Q
    );
    always_ff@(posedge clk, negedge reset)      //reset asincrónico invertido CPU_RESETN
        if          (reset==1'b0) Q <= 'b0;
        else if     (en)    Q <= D;             // EN(button) => D pasa a Q
        
endmodule