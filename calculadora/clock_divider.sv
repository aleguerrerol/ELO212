`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2019 00:08:49
// Design Name: 
// Module Name: clock_divider
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


module clock_divider #(parameter COUNTER_MAX = 1) //1 debería ser PUT_NUMBER_HERE pero error porque no estaría declarado
( input logic clk_in,
  input logic reset,
  output logic clk_out);
  
    localparam DELAY_WIDTH = $clog2(COUNTER_MAX);
    logic [DELAY_WIDTH-1:0] counter = 'd0;
     // resetea el contador e invierte el valor del reloj de salida cada vez que el contador llega a su valor maximo
     
    always_ff @(posedge clk_in) begin       //CPU_RESETN INVERTIDO => reset==0  !!!
        if  (reset == 1'b0) begin //Reset Sincrónico, setea el contador y la salida a un valor conocido
            counter <= 'd0;
            clk_out <= 0; 
        end else if (counter == COUNTER_MAX-1) begin //Se resetea el contador y se invierte la salida 
            counter <= 'd0;
            clk_out <= ~clk_out;
        end else begin //se incrementa el contador y se mantiene la salida como su valor anterior
        counter <= counter + 'd1;
        clk_out <= clk_out;
        end
    end
endmodule
