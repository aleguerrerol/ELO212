`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2019 02:06:57
// Design Name: 
// Module Name: registro_display
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

/* template
registro_display #(16) registro_display_1 (.STATE(), .A_OUT(), .B_OUT(), .RESULTADO(), .SALIDA() );
*/

module registro_display #(parameter in_length=16)(
    input [1:0]STATE,
    input logic [in_length-1:0]A_OUT,
    input logic [in_length-1:0]B_OUT,
    input logic [in_length-1:0]RESULTADO,
    
    output logic [in_length-1:0]SALIDA
    );
    
    always_comb begin            
        case(STATE)
            2'd0: SALIDA = 'b0;
            2'd1: SALIDA = A_OUT;
            2'd2: SALIDA = B_OUT;
            2'd3: SALIDA = RESULTADO;
        endcase
    
    
    end
    /*
    
    // Sabemos que usar la misma salida en multiples always hace que haya multiples drivers, lo cual es un error.
    // Por contexto, creemos que este modulo es una especie de MUX
    // por lo tanto, lo reintentaremos con lógica combinacional.
    always_ff @(posedge CLK, negedge RESET) begin
        if(~RESET || STATE==2'd0) begin                    //RESET O NO SE HAN INGRESADO DATOS
            SALIDA <= 0;
        end
    end
    
    always_ff @(posedge CLK) begin      //PASA OPERANDO 1
        if(STATE==2'd1) begin
            SALIDA <= A_OUT;
        end
    end
    
    always_ff @(posedge CLK) begin      //PASA OPERANDO 2
        if(STATE==2'd2) begin
            SALIDA <= B_OUT;
        end
    end
    
    always_ff @(posedge CLK) begin      //PASA EL RESULTADO
        if(STATE==2'd3) begin
            SALIDA <= RESULTADO;
        end
    end
    */
endmodule