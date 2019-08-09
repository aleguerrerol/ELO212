`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 22:39:13
// Design Name: 
// Module Name: driver
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


module driver(
    input CLK,reset,trigger,
    //input [7:0]SW,        //para probar el módulo
    input logic [31:0]in,
    output [6:0]catodos,
    output [7:0]anodos 
    );
    
    logic [2:0]cnt;
    logic [3:0]d;
    logic clk;
    logic [31:0]bcd;
    
    clkdiv #(104167)(.clk_in(CLK),.reset(reset),.clk_out(clk));
    
    contador_3 contador_3_inst_1(.clk_in(clk),.reset(reset),.count(cnt));
    
    bin_to_bcd bin_to_bcd_inst_1 (
		.clk(clk),
		.trigger(trigger),
		.in(in),
		.bcd(bcd)
	);
    
    multiplexer multiplexer_inst_1(.d_7(bcd[31:28]),//MSB, display de mas a la izquierda
                                   .d_6(bcd[27:24]),
                                   .d_5(bcd[23:20]),
                                   .d_4(bcd[19:16]),
                                   .d_3(bcd[15:12]),
                                   .d_2(bcd[11:8]),
                                   .d_1(bcd[7:4]),
                                   .d_0(bcd[3:0]), //LSB, display de mas a la derecha
                                   .contador(cnt),.dato(d));
    
    switcher #(0,0,0,1,1,1,1,1)(.count(cnt),.reset(reset),.anodos(anodos)); //se ponen en 1 los que deben prenderse
                                //mostraremos maximo 2^16=65536, o 5 digitos en bcd.
    
  bcd_to_ss bcd_to_ss_inst_1 (
		.bcd_in(d),
		.out(catodos)
	);
endmodule


