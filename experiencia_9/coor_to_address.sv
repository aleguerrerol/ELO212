`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Coordinate to adress
// Create Date: 02.09.2019 17:41:23
// Design Name: 
// Module Name: coor_to_address
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: this module is used to determine which bit address should be paired with which color.    
// for an (n x m) matrix, any given value corresponding to an (a,b) adress could be determined as (a * m + b)
//
//////////////////////////////////////////////////////////////////////////////////

//coor_to_adress coor_to_adress_1 (.a(), .b(), .out());

module coor_to_address(
    input logic [9:0]a,
    input logic [9:0]b,
    output logic [18:0]out
    );
    
    always_comb begin
    out = b*512+a;
    end
endmodule
