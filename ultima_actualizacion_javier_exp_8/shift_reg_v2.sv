`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2019 02:03:58
// Design Name: 
// Module Name: shift_reg_v2
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
/* instance template*/
// shift_registers nombre_(.clk(),.rst(),.bttn(),.bit_in(),.dato(),.clear()); //rst=CPU_RESET, reset=reset forzado proveniente de calculadora para resetear registros


module shift_registers(
    input logic clk, rst, bttn, clear,
    input logic [4:0]bit_in,
    
    output logic [15:0]dato
    );

    logic [15:0]dato_aux;
    always_ff @(posedge(clk)) begin
        if (rst || clear) 
            dato_aux <= 15'b0;        
        else if (bttn) 
            dato_aux <= {dato_aux[11:0], bit_in[3:0]};        
        else
            dato_aux <= dato_aux;
        end
        
    assign dato = dato_aux;
endmodule
