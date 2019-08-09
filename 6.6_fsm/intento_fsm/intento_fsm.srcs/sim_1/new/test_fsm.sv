`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2019 11:41:56
// Design Name: 
// Module Name: test_fsm
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


module test_fsm(
    );
    logic CLK,RESET,RST;
    logic BUTTON;
    logic clean_button,clean_reset;
    logic [1:0]LED;
    //logic reset_sync;
    //logic button_sync;
    
    top_module  FSM(.CLK100MHZ(CLK),.RST_DB(RST),.CPU_RESETN(RESET),.BTNC(BUTTON),.LED(LED)/*,.button_sync(button_sync),.reset_sync(reset_sync)*/);
    
    debouncer_count deb_reset(.clk(CLK),.rst(RST),.PB(RESET),.PB_pressed_status(clean_reset));
    debouncer_2 deb_button(.clk(CLK),.rst(RST),.PB(BUTTON),.PB_pressed_status(clean_button));
    
    always #1 CLK<=!CLK;
    always #100 BUTTON=!BUTTON;
    //always #100 RESET=!RESET;
    
    initial begin
        CLK=0;
        RESET=0;
        RST=0;
        BUTTON=0;
        
        #5  //RESET=1;
            RST=1;
        #10 RESET=1;
        
        #1000 $finish;
    end
    
endmodule
