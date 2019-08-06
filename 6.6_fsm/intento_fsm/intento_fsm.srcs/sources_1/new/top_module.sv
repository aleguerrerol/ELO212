`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2019 11:10:48
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
    input logic CLK100MHZ,CPU_RESETN,BTNC,RST_DB,       //RESPECTO A RST_DB -> CONSIDERAR DEJARLO FIJO EN 1 CUANDO SE IMPLEMENTE EN LA PLACA (MANTIENE LOGICA INVERSA DEL RESET ORIGINAL)
    output logic [1:0]LED
    );
    logic clean_rst;
    logic clean_btnc;

    debouncer_count debouncer_reset(.clk(CLK100MHZ),.rst(RST_DB),.PB(CPU_RESETN),.PB_pressed_status(clean_rst));      //OJO CON RST, QUÉ SEÑAL USO?
    debouncer_2 debouncer_button(.clk(CLK100MHZ),.rst(RST_DB),.PB(BTNC),.PB_pressed_status(clean_btnc));               //LO MISMO, NO TIENE RST
    fsm finite_state_machine(.clock(CLK100MHZ),.reset(clean_rst),.btnc(clean_btnc),.leds_out(LED));
    
   // fsm finite_state_machine(.clock(CLK100MHZ),.reset(CPU_RESETN),.btnc(BTNC),.leds_out(LED)); //para probar sin debouncers ni sincronizadores
endmodule
