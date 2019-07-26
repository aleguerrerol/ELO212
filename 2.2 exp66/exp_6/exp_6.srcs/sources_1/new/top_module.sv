`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2019 14:03:00
// Design Name: 
// Module Name: top_module
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


module top_module (
    input logic [7:0]SW,
    input logic BTNC,
    input logic CPU_RESETN,
    input logic CLK100MHZ,
    
    output logic CA,CB,CC,CD,CE,CF,CG,
    output logic [7:0]AN
    );
    logic [7:0]out;
    logic btn;
    debouncer_count(.clk(CLK100MHZ),.rst(CPU_RESETN),.PB(BTNC),.PB_pressed_status(btn));                                   // terminar!!!
    registro(.clk(CLK100MHZ),.en(btn),.reset(CPU_RESETN),.D(SW),.Q(out));
    driver(.CLK(CLK100MHZ),.reset(CPU_RESETN),
                            .data_7(),
                            .data_6(),
                            .data_5(),
                            .data_4(),
                            .data_3(),
                            .data_2(),
                            .data_1(out[7:4]),
                            .data_0(out[3:0]),
    .catodos({CA,CB,CC,CD,CE,CF,CG}),.anodos(AN));
endmodule
