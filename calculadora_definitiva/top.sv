`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2019 23:16:20
// Design Name: 
// Module Name: top
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


module top(
    input logic DEC_TRIGGER, //de estar en 1, el driver funcionará en modo BCD (entra un numero binario, sale ese numero en BCD).
    input logic CLK, RESET,
    input logic [15:0]OP_1,[15:0]OP_2,
    input logic [1:0]ALU_CTRL, //dicta que operacion hará la alu
    input logic [1:0]IDLE, //dicta si se va a mostrar en el display OP1, OP2, RESULT
    
    output logic [15:0]RESULTADO,
    output logic [2:0]LED_RGB, //aquí va a ir directo para el LED RGB
    
    output logic [6:0] CATODOS,
    output logic [7:0] ANODOS
    );
    logic overflow;
    
    logic [15:0] SALIDA;
    logic [31:0] SALIDA_TO_BIN_IN;
    assign SALIDA_TO_BIN_IN [31:16] = 16'b0;
    assign SALIDA_TO_BIN_IN [15:0] = SALIDA;
    
    alu alu_1(.A(OP_1),.B(OP_2),.OP(ALU_CTRL),.result_1(RESULTADO),.error(overflow));
    registro_display #(16) registro_display_1(.STATE(IDLE), .A_OUT(OP_1), .B_OUT(OP_2), .RESULTADO(RESULTADO), .SALIDA(SALIDA) ); 
    nuevo_driver #(32) nuevo_driver_1 (.CLK(CLK), .RESET(RESET), .DEC_TRIGGER(DEC_TRIGGER), .BIN_IN(SALIDA_TO_BIN_IN), .CATODOS(CATODOS), .ANODOS(ANODOS));
    led_rgb_driver led_rgb_driver (.error(overflow), .estado(IDLE), .out(LED_RGB));
endmodule
