`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2019 00:08:32
// Design Name: 
// Module Name: contador_3bits
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


module contador_3bits(
    input logic clk_in,reset,
    output logic [2:0]count
    );
    always_ff @(posedge clk_in,negedge reset) begin     //reset asincr�nico
            if (reset==1'b0 || count==3'b111) count<=3'b000;
            else count<=count+1;                       //CARRY OUT??
        end
endmodule