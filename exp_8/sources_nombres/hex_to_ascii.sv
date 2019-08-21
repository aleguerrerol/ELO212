`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2019 04:04:51
// Design Name: 
// Module Name: hex_to_ascii
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


module hex_to_ascii(
    input [3:0] hex_num,
	output logic[7:0] ascii_conv
    );
    always_comb begin
        case (hex_num)
            4'h0:   ascii_conv="0";
            4'h1:   ascii_conv="1";
            4'h2:   ascii_conv="2";
            4'h3:   ascii_conv="3";
            4'h4:   ascii_conv="4";
            4'h5:   ascii_conv="5";
            4'h6:   ascii_conv="6";
            4'h7:   ascii_conv="7";
            4'h8:   ascii_conv="8";
            4'h9:   ascii_conv="9";
            4'hA:   ascii_conv="A";
            4'hB:   ascii_conv="B";
            4'hC:   ascii_conv="C";
            4'hD:   ascii_conv="D";
            4'hE:   ascii_conv="E";
            4'hF:   ascii_conv="F";
        endcase
    end 
    
    
endmodule
