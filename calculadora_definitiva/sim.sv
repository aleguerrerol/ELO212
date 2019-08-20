`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2019 01:01:43
// Design Name: 
// Module Name: sim
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


module sim(
    );
    logic clk,reset,dec_trigger;
    logic [31:0]bin_in;
    logic [6:0]catodos;
    logic [7:0]anodos;
    
    nuevo_driver #(32) driver(.CLK(clk),.RESET(reset),.DEC_TRIGGER(dec_trigger),.BIN_IN(bin_in),
                                .CATODOS(catodos),.ANODOS(anodos));
                                
    always #1 clk<=!clk;
    
    initial begin
        clk=0;
        reset=0;
        bin_in=32'd0;
        dec_trigger=0;
        
    #5  reset=1;
        bin_in=32'd99;
    #15  dec_trigger=1;
    
    #1000 $finish;
    end
    
endmodule
