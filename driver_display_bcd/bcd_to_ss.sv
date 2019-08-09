`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2019 15:01:50
// Design Name: 
// Module Name: bcd_to_ss
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

/*
---planilla de instanciación

bcd_to_ss bcd_to_ss_inst_1 (
		.bcd_in(bcd_in),
		.out(out)
	);

*/
module bcd_to_ss
(
	input [3:0] bcd_in,
	output [6:0] out
);

	assign out =
        (bcd_in == 4'h0) ? 7'b1000000 :
		(bcd_in == 4'h1) ? 7'b1111001 :
		(bcd_in == 4'h2) ? 7'b0100100 :
		(bcd_in == 4'h3) ? 7'b0110000 :
		(bcd_in == 4'h4) ? 7'b0011001 :
		(bcd_in == 4'h5) ? 7'b0010010 :
		(bcd_in == 4'h6) ? 7'b0000010 :
		(bcd_in == 4'h7) ? 7'b1111000 :
		(bcd_in == 4'h8) ? 7'b0000000 :
		(bcd_in == 4'h9) ? 7'b0010000 : 7'b1111111;
		//		(bcd_in == 4'h0) ? 7'b1000000 :
//		(bcd_in == 4'h1) ? 7'b1111001 :
//		(bcd_in == 4'h2) ? 7'b0100100 :
//		(bcd_in == 4'h3) ? 7'b0110000 :
//		(bcd_in == 4'h4) ? 7'b0011001 :
//		(bcd_in == 4'h5) ? 7'b0010010 :
//		(bcd_in == 4'h6) ? 7'b0000010 :
//		(bcd_in == 4'h7) ? 7'b1111000 :
//		(bcd_in == 4'h8) ? 7'b0000000 :
//		(bcd_in == 4'h9) ? 7'b0010000 :
//		(bcd_in == 4'hA) ? 7'b0001000 :
//		(bcd_in == 4'hB) ? 7'b0000011 :
//		(bcd_in == 4'hC) ? 7'b1000110 :
//		(bcd_in == 4'hD) ? 7'b0100001 :
//		(bcd_in == 4'hE) ? 7'b0000110 : 7'b0001110;
endmodule
