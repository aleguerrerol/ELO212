`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2019 18:46:18
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


module top_module(
    input CLK100MHZ, BTNL, BTNR, CPU_RESETN,
    input [15:0]SW,
    output CA,CB,CC,CD,CE,CF,CG,
    output [7:0] AN 
    );
    
    logic [15:0] r1_out, r2_out;
    
    register_synch_reset_load_nbit #16 r1(.D(SW), .clk(CLK100MHZ), .rst(CPU_RESETN), .load(BTNL) , .Q(r1_out));
    register_synch_reset_load_nbit #16 r2(.D(SW), .clk(CLK100MHZ), .rst(CPU_RESETN), .load(BTNR) , .Q(r2_out));
    driver display_driver (.CLK(CLK100MHZ) , .reset(CPU_RESETN) , .catodos({CA,CB,CC,CD,CE,CF,CG}), .anodos(AN), 
                           .data_7(r1_out[15:12]), .data_6(r1_out[11:8]), .data_5(r1_out[7:4]), .data_4(r1_out[3:0]),     //4 displays de la izquierda
                           .data_3(r2_out[15:12]), .data_2(r2_out[11:8]), .data_1(r2_out[7:4]), .data_0(r2_out[3:0]));    //4 displays de la derecha
        
endmodule
