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
//  datos se ordenan así: [7] [6] [5] [4] [3] [2] [1] [0] 
//////////////////////////////////////////////////////////////////////////////////


module driver(
    input CLK,reset,
    //input [7:0]SW,        //para probar el módulo
    input logic [3:0]data_7,data_6,data_5,data_4,data_3,data_2,data_1,data_0,
    output [6:0]catodos,
    output [7:0]anodos 
    );
    logic [2:0]cnt;
    logic [3:0]d;
    logic clk;
    
    clkdiv #(104167)(.clk_in(CLK),.reset(reset),.clk_out(clk));
    contador_3(.clk_in(clk),.reset(reset),.count(cnt));
    multiplexer(.d_7(data_7),
                .d_6(data_6),
                .d_5(data_5),
                .d_4(data_4),
                .d_3(data_3),
                .d_2(data_2),
                .d_1(data_1),
                .d_0(data_0),
                .contador(cnt),.dato(d));
    switcher #(1,1,1,1,1,1,1,1)(.count(cnt),.reset(reset),.anodos(anodos));
    bin_to_hex(.binary_input(d),.sevenSeg(catodos));
endmodule
