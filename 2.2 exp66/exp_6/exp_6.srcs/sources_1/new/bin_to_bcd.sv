`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2019 16:05:36
// Design Name: 
// Module Name: bin_to_bcd
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


module bin_to_bcd #(parameter in_lenght=8)      //está parametrizado pero lo demás está "a medida"
(
    input logic [in_lenght-1:0]binary,
    
    output logic [3:0]hundreds,
    output logic [3:0]tens,
    output logic [3:0]ones
    );
    
    
endmodule
