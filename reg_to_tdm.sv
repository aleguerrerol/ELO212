`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 17:47:02
// Design Name: 
// Module Name: reg_to_tdm
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


module reg_to_tdm_sim(); //esto va vacío
    logic [15:0]BR1;
    logic [15:0]BR2;
    logic [15:0]BR3;
    logic [31:0]out;
    logic sel;
    
    reg_to_tdm DUT(.BR1(BR1), .BR2(BR2), .BR3(BR3), .out(out), .sel(sel)); 
     
    initial #0 begin
        BR1 = 16'h0001;
        BR2 = 16'h0F03;
        BR3 = 16'hAAAA;
        sel = 0;
        #50
        sel = 1;
        #50
        sel = 0;
        #50
        sel = 1;
        #100 $finish;
    end
endmodule
