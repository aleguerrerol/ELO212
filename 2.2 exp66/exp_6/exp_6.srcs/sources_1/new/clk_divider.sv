`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 16:37:24
// Design Name: 
// Module Name: clk_divider
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


module clk_divider
#(parameter COUNTER_MAX = 1) //1 deber�a ser PUT_NUMBER_HERE pero error porque no estar�a declarado
( input logic clk_in,
  input logic reset,
  output logic clk_out);
  
    localparam DELAY_WIDTH = $clog2(COUNTER_MAX);
    logic [DELAY_WIDTH-1:0] counter = 'd0;
     // resetea el contador e invierte el valor del reloj de salida cada vez que el contador llega a su valor maximo
     
    always_ff @(posedge clk_in) begin
        if  (reset == 1'b1) begin //Reset Sincr�nico, setea el contador y la salida a un valor conocido
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
