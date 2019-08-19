`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2019 01:31:44
// Design Name: 
// Module Name: calculadora_top
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


module calculadora_top #(parameter in_length=16)(
    input logic CLK100MHZ, BTNC, BTNU, BTND, CPU_RESETN,
    input logic [15:0]SW,
    
    output logic [7:0]AN,
    output logic CA,CB,CC,CE,CD,CF,CG,
    output logic [1:0]LED,
    output logic LED16_R, LED16_G, LED16_B
    );
    logic clk_div;                                  //display's clock
    logic reset_db, btnc_db, btnu_db, btnd_db;      //debounced and synchronized buttons
    logic current_state;                            //current state of the FSM
    logic a, b, op, resultado;                      //ALU indicators
    logic [in_length-1:0]display_input;
    
    clk_divider();
    
    db reset_debounce(.clk(CLK100MHZ),.PB(CPU_RESETN),.PB_pressed_status(reset_db));
    db btnc_debounce(.clk(CLK100MHZ),.PB(BTNC),.PB_released_pulse(btnc_db));
    db btnu_debounce(.clk(CLK100MHZ),.PB(BTNU),.PB_released_pulse(btnu_db));
    db btnd_debounce(.clk(CLK100MHZ),.PB(BTND),.PB_released_pulse(btnd_db));
    
    fsm(.clock(CLK100MHZ),.reset(reset_db),.trigger(btnc_db),.undo(btnu_db),.LED(LED),.STATE(current_state));
    registro_input(.CLK(CLK100MHZ),.RESET(reset_db),.IN(SW),.STATE(current_state),.A_OUT(a),.B_OUT(b),.OP_OUT(op));
    ALU(.A(a),.B(b),.OP(op),.result(resultado),.error({LED16_R,LED16_G,LED16_B}));               //no sé si queda bien el error led RGB
    registro_display(.CLK(CLK100MHZ),.RESET(reset_db),.A_OUT(a),.B_OUT(b),.RESULTADO(resultado),.SALIDA(display_input));
    nuevo_driver(.CLK(clk_div),.RESET(reset_db),.HEX_TRIGGER(btnd_db),.BIN_IN(display_input),
                 .CATODOS({CA,CB,CC,CD,CE,CF,CG}),.ANODOS(AN));
    
endmodule
