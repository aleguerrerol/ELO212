`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2019 04:41:51
// Design Name: 
// Module Name: hex_to_bit_ascii
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


module hex_to_bit_ascii(
    input logic [3:0]num,
	output logic [4*8-1:0]bit_ascii
    );
    always_comb begin
        case (num)
            4'h0:   bit_ascii="0000";
            4'h1:   bit_ascii="0001";
            4'h2:   bit_ascii="0010";
            4'h3:   bit_ascii="0011";
            4'h4:   bit_ascii="0100";
            4'h5:   bit_ascii="0101";
            4'h6:   bit_ascii="0110";
            4'h7:   bit_ascii="0111";
            4'h8:   bit_ascii="1000";
            4'h9:   bit_ascii="1001";
            4'hA:   bit_ascii="1010";
            4'hB:   bit_ascii="1011";
            4'hC:   bit_ascii="1100";
            4'hD:   bit_ascii="1101";
            4'hE:   bit_ascii="1110";
            4'hF:   bit_ascii="1111";
        endcase
    end
endmodule
