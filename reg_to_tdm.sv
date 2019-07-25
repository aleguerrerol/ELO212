`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 16:53:47
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
// Additional Comments: en la experiencia 6 esto se utiliza para mandar al TDM lo que quieremos que se muestre en
// la pantalla. es decir: si apretamos ciertos botones, se muestra el contenido de los registros 1 y 2. si se aprietan otros
// se muestra el contenido del registro 3.
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_to_tdm(
    input logic [15:0]BR1,
    input logic[15:0]BR2,
    input logic[15:0]BR3,
    input logic sel,
    output logic [31:0] out   
    );
    
always_comb begin
    case (sel)
        1'd0: begin  
              out [31:16] = BR1;
              out [15:0] = BR2;
              end
              
        1'd1:  begin
               out [31:16] = 'd0;
               out [15:0] = BR3;
               end
    endcase
end
endmodule
